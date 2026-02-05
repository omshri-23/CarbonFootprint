using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace CarbonFootprint.user
{
    public partial class CalculationAI : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("~/Login.aspx");
                return;
            }
        }

        protected void SaveActivity_Click(object sender, EventArgs e)
        {
            int userId = Convert.ToInt32(Session["UserID"]);

            string transportType = ddlTransportType.SelectedValue;
            decimal distance = ParseDecimal(txtTransportDistance.Text);
            decimal electricityUnits = ParseDecimal(txtElectricityUnits.Text);
            string foodType = ddlFoodType.SelectedValue;
            decimal meals = ParseDecimal(txtMealsPerDay.Text);
            decimal waterUsage = ParseDecimal(txtWaterUsage.Text);
            decimal showerMinutes = ParseDecimal(txtShowerDuration.Text);
            string shoppingFreq = ddlShoppingFrequency.SelectedValue;
            decimal onlineShopping = ParseDecimal(txtOnlineShopping.Text);
            string heatingCooling = ddlHeatingCooling.SelectedValue;
            decimal wasteGenerated = ParseDecimal(txtWasteGenerated.Text);
            string recycling = ddlRecycling.SelectedValue;
            string composting = ddlComposting.SelectedValue;

            decimal transportEmission = distance * GetTransportFactor(transportType);
            decimal electricityEmission = electricityUnits * 0.82m;
            decimal foodEmission = meals * GetFoodFactor(foodType);
            decimal waterEmission = (waterUsage * 0.0003m) + (showerMinutes * 10m * 0.0003m);
            decimal lifestyleEmission = GetShoppingFactor(shoppingFreq) + (onlineShopping * 0.5m) + GetHeatingCoolingFactor(heatingCooling);
            decimal wasteEmission = wasteGenerated * 0.5m * GetRecyclingMultiplier(recycling) * GetCompostingMultiplier(composting);
            decimal totalEmission = transportEmission + electricityEmission + foodEmission + waterEmission + lifestyleEmission + wasteEmission;

            lblTransportEmission.Text = transportEmission.ToString("F2");
            lblElectricityEmission.Text = electricityEmission.ToString("F2");
            lblFoodEmission.Text = foodEmission.ToString("F2");
            lblWaterEmission.Text = waterEmission.ToString("F2");
            lblLifestyleEmission.Text = lifestyleEmission.ToString("F2");
            lblWasteEmission.Text = wasteEmission.ToString("F2");
            lblTotalEmission.Text = totalEmission.ToString("F2");

            string cs = ConfigurationManager.ConnectionStrings["CarbonDB"].ConnectionString;
            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();
                using (SqlTransaction tx = con.BeginTransaction())
                {
                    try
                    {
                        DateTime today = DateTime.Today;

                        SaveEmissionEntry(con, tx, userId, "Transportation", "Transport", transportType, distance, "km",
                            $"Transport type: {transportType}", transportEmission, today);

                        SaveEmissionEntry(con, tx, userId, "Energy", "Electricity", "Grid Electricity", electricityUnits, "kWh",
                            "Electricity usage", electricityEmission, today);

                        SaveEmissionEntry(con, tx, userId, "Food", "Meals", foodType, meals, "meals",
                            $"Food type: {foodType}", foodEmission, today);

                        SaveEmissionEntry(con, tx, userId, "Water", "Water Usage", "Daily Water", waterUsage, "liters",
                            $"Shower minutes: {showerMinutes}", waterEmission, today);

                        SaveEmissionEntry(con, tx, userId, "Other", "Lifestyle", "Lifestyle", onlineShopping, "packages",
                            $"Shopping: {shoppingFreq}, Heating: {heatingCooling}", lifestyleEmission, today);

                        SaveEmissionEntry(con, tx, userId, "Waste", "Waste", "Waste Generated", wasteGenerated, "kg",
                            $"Recycling: {recycling}, Composting: {composting}", wasteEmission, today);

                        tx.Commit();
                    }
                    catch
                    {
                        tx.Rollback();
                        throw;
                    }
                }
            }
        }

        protected void Recalculate_Click(object sender, EventArgs e)
        {
            // Clear all inputs
            ddlTransportType.SelectedIndex = 0;
            txtTransportDistance.Text = string.Empty;
            txtElectricityUnits.Text = string.Empty;
            ddlFoodType.SelectedIndex = 0;
            txtMealsPerDay.Text = string.Empty;
            txtWaterUsage.Text = string.Empty;
            txtShowerDuration.Text = string.Empty;
            ddlShoppingFrequency.SelectedIndex = 0;
            txtOnlineShopping.Text = string.Empty;
            ddlHeatingCooling.SelectedIndex = 0;
            txtWasteGenerated.Text = string.Empty;
            ddlRecycling.SelectedIndex = 0;
            ddlComposting.SelectedIndex = 0;

            // Reset results
            lblTransportEmission.Text = "0";
            lblElectricityEmission.Text = "0";
            lblFoodEmission.Text = "0";
            lblWaterEmission.Text = "0";
            lblLifestyleEmission.Text = "0";
            lblWasteEmission.Text = "0";
            lblTotalEmission.Text = "0";

            // Reset client-side UI pieces
            ClientScript.RegisterStartupScript(GetType(), "resetCalcUI", "resetCalculationUI();", true);
        }

        private static void SaveEmissionEntry(SqlConnection con, SqlTransaction tx, int userId, string category,
            string subCategory, string activityType, decimal quantity, string unit, string notes,
            decimal emission, DateTime date)
        {
            if (emission <= 0 && quantity <= 0) return;

            int activityId;
            using (SqlCommand cmd = new SqlCommand(@"
INSERT INTO ActivityData (UserID, ActivityDate, Category, SubCategory, ActivityType, Quantity, Unit, Notes)
VALUES (@UserID, @ActivityDate, @Category, @SubCategory, @ActivityType, @Quantity, @Unit, @Notes);
SELECT SCOPE_IDENTITY();", con, tx))
            {
                cmd.Parameters.AddWithValue("@UserID", userId);
                cmd.Parameters.AddWithValue("@ActivityDate", date);
                cmd.Parameters.AddWithValue("@Category", category);
                cmd.Parameters.AddWithValue("@SubCategory", subCategory);
                cmd.Parameters.AddWithValue("@ActivityType", activityType);
                cmd.Parameters.AddWithValue("@Quantity", quantity);
                cmd.Parameters.AddWithValue("@Unit", unit);
                cmd.Parameters.AddWithValue("@Notes", notes ?? string.Empty);
                activityId = Convert.ToInt32(cmd.ExecuteScalar());
            }

            using (SqlCommand cmd = new SqlCommand(@"
INSERT INTO EmissionCalculation
(UserID, ActivityID, FactorID, CalculationDate, Category, TotalCO2, TotalCH4, TotalN2O, CO2Equivalent)
VALUES
(@UserID, @ActivityID, NULL, @CalculationDate, @Category, @TotalCO2, 0, 0, @CO2e);", con, tx))
            {
                cmd.Parameters.AddWithValue("@UserID", userId);
                cmd.Parameters.AddWithValue("@ActivityID", activityId);
                cmd.Parameters.AddWithValue("@CalculationDate", date);
                cmd.Parameters.AddWithValue("@Category", category);
                cmd.Parameters.AddWithValue("@TotalCO2", emission);
                cmd.Parameters.AddWithValue("@CO2e", emission);
                cmd.ExecuteNonQuery();
            }

            using (SqlCommand cmd = new SqlCommand("sp_UpdateEmissionHistory", con, tx))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@UserID", userId);
                cmd.Parameters.AddWithValue("@RecordDate", date);
                cmd.Parameters.AddWithValue("@Category", category);
                cmd.Parameters.AddWithValue("@DailyCO2e", emission);
                cmd.ExecuteNonQuery();
            }
        }

        private static decimal ParseDecimal(string value)
        {
            return decimal.TryParse(value, out decimal result) ? result : 0m;
        }

        private static decimal GetTransportFactor(string type)
        {
            switch (type)
            {
                case "Car": return 0.21m;
                case "Bus": return 0.089m;
                case "Train": return 0.041m;
                case "Bike": return 0.59m;
                case "Flight": return 0.255m;
                default: return 0.15m;
            }
        }

        private static decimal GetFoodFactor(string type)
        {
            switch (type)
            {
                case "Vegetarian": return 1.5m;
                case "Non-Vegetarian": return 2.5m;
                case "Vegan": return 1.0m;
                default: return 1.5m;
            }
        }

        private static decimal GetShoppingFactor(string freq)
        {
            switch (freq)
            {
                case "Daily": return 3.0m;
                case "Weekly": return 2.0m;
                case "BiWeekly": return 1.5m;
                case "Monthly": return 1.0m;
                default: return 2.0m;
            }
        }

        private static decimal GetHeatingCoolingFactor(string usage)
        {
            switch (usage)
            {
                case "None": return 0.5m;
                case "Moderate": return 2.0m;
                case "Heavy": return 3.5m;
                default: return 1.5m;
            }
        }

        private static decimal GetRecyclingMultiplier(string recycling)
        {
            switch (recycling)
            {
                case "Never": return 1.2m;
                case "Sometimes": return 1.0m;
                case "Often": return 0.8m;
                case "Always": return 0.6m;
                default: return 1.0m;
            }
        }

        private static decimal GetCompostingMultiplier(string composting)
        {
            return composting == "Yes" ? 0.85m : 1.0m;
        }
    }
}
