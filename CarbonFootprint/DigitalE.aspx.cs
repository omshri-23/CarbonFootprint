using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace CarbonFootprint
{
    public partial class DigitalE : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("~/Login.aspx");
                return;
            }
        }

        protected void Calculate_Click(object sender, EventArgs e)
        {
            CalculateAndMaybeSave(false);
        }

        protected void SaveToHistory_Click(object sender, EventArgs e)
        {
            CalculateAndMaybeSave(true);
        }

        protected void Reset_Click(object sender, EventArgs e)
        {
            // Clear inputs
            txtScreenHours.Text = string.Empty;
            txtScreenMinutes.Text = string.Empty;
            txtStreamingHours.Text = string.Empty;
            ddlStreamingQuality.SelectedIndex = 0;
            txtSocialMediaHours.Text = string.Empty;
            txtGamingHours.Text = string.Empty;
            ddlGamingPlatform.SelectedIndex = 0;
            txtVideoCallHours.Text = string.Empty;
            txtEmailsSent.Text = string.Empty;
            txtEmailsReceived.Text = string.Empty;
            txtCloudStorage.Text = string.Empty;
            txtDeviceCharges.Text = string.Empty;
            ddlDeviceType.SelectedIndex = 0;

            // Reset results
            lblTotalEmission.Text = "0";
            lblTotalEmissionDisplay.Text = "0";

            ClientScript.RegisterStartupScript(GetType(), "resetDigitalUI", "resetDigitalUI();", true);
        }

        private void CalculateAndMaybeSave(bool save)
        {
            decimal screenHours = ParseDecimal(txtScreenHours.Text);
            decimal screenMinutes = ParseDecimal(txtScreenMinutes.Text);
            decimal totalScreenTime = screenHours + (screenMinutes / 60m);

            decimal streamingHours = ParseDecimal(txtStreamingHours.Text);
            string streamingQuality = ddlStreamingQuality.SelectedValue;

            decimal socialMediaHours = ParseDecimal(txtSocialMediaHours.Text);

            decimal gamingHours = ParseDecimal(txtGamingHours.Text);
            string gamingPlatform = ddlGamingPlatform.SelectedValue;

            decimal videoCallHours = ParseDecimal(txtVideoCallHours.Text);

            int emailsSent = ParseInt(txtEmailsSent.Text);
            int emailsReceived = ParseInt(txtEmailsReceived.Text);

            decimal cloudStorage = ParseDecimal(txtCloudStorage.Text);

            int deviceCharges = ParseInt(txtDeviceCharges.Text);
            string deviceType = ddlDeviceType.SelectedValue;

            decimal screenEmission = totalScreenTime * 0.05m;
            decimal streamingEmission = streamingHours * GetStreamingFactor(streamingQuality);
            decimal socialMediaEmission = socialMediaHours * 0.08m;
            decimal gamingEmission = gamingHours * GetGamingFactor(gamingPlatform);
            decimal videoCallEmission = videoCallHours * 0.15m;
            decimal emailEmission = (emailsSent * 0.004m) + (emailsReceived * 0.0001m);
            decimal cloudEmission = cloudStorage * 0.02m;
            decimal chargingEmission = deviceCharges * GetChargingFactor(deviceType);

            decimal totalEmission = screenEmission + streamingEmission + socialMediaEmission +
                                    gamingEmission + videoCallEmission + emailEmission +
                                    cloudEmission + chargingEmission;

            lblTotalEmission.Text = totalEmission.ToString("F2");
            lblTotalEmissionDisplay.Text = totalEmission.ToString("F2");

            if (!save) return;

            int userId = Convert.ToInt32(Session["UserID"]);
            string notes = $"Screen:{screenEmission:F2}, Streaming:{streamingEmission:F2}, Social:{socialMediaEmission:F2}, " +
                           $"Gaming:{gamingEmission:F2}, Calls:{videoCallEmission:F2}, Email:{emailEmission:F2}, " +
                           $"Cloud:{cloudEmission:F2}, Charging:{chargingEmission:F2}";

            string cs = ConfigurationManager.ConnectionStrings["CarbonDB"].ConnectionString;
            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();
                using (SqlTransaction tx = con.BeginTransaction())
                {
                    try
                    {
                        DateTime today = DateTime.Today;
                        int activityId;
                        using (SqlCommand cmd = new SqlCommand(@"
INSERT INTO ActivityData (UserID, ActivityDate, Category, SubCategory, ActivityType, Quantity, Unit, Notes)
VALUES (@UserID, @ActivityDate, 'Digital', 'Digital Usage', 'Digital Footprint', @Quantity, 'hours', @Notes);
SELECT SCOPE_IDENTITY();", con, tx))
                        {
                            cmd.Parameters.AddWithValue("@UserID", userId);
                            cmd.Parameters.AddWithValue("@ActivityDate", today);
                            cmd.Parameters.AddWithValue("@Quantity", totalScreenTime);
                            cmd.Parameters.AddWithValue("@Notes", notes);
                            activityId = Convert.ToInt32(cmd.ExecuteScalar());
                        }

                        using (SqlCommand cmd = new SqlCommand(@"
INSERT INTO EmissionCalculation
(UserID, ActivityID, FactorID, CalculationDate, Category, TotalCO2, TotalCH4, TotalN2O, CO2Equivalent)
VALUES
(@UserID, @ActivityID, NULL, @CalculationDate, 'Digital', @TotalCO2, 0, 0, @CO2e);", con, tx))
                        {
                            cmd.Parameters.AddWithValue("@UserID", userId);
                            cmd.Parameters.AddWithValue("@ActivityID", activityId);
                            cmd.Parameters.AddWithValue("@CalculationDate", today);
                            cmd.Parameters.AddWithValue("@TotalCO2", totalEmission);
                            cmd.Parameters.AddWithValue("@CO2e", totalEmission);
                            cmd.ExecuteNonQuery();
                        }

                        using (SqlCommand cmd = new SqlCommand("sp_UpdateEmissionHistory", con, tx))
                        {
                            cmd.CommandType = CommandType.StoredProcedure;
                            cmd.Parameters.AddWithValue("@UserID", userId);
                            cmd.Parameters.AddWithValue("@RecordDate", today);
                            cmd.Parameters.AddWithValue("@Category", "Digital");
                            cmd.Parameters.AddWithValue("@DailyCO2e", totalEmission);
                            cmd.ExecuteNonQuery();
                        }

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

        private static decimal ParseDecimal(string value)
        {
            return decimal.TryParse(value, out decimal result) ? result : 0m;
        }

        private static int ParseInt(string value)
        {
            return int.TryParse(value, out int result) ? result : 0;
        }

        private static decimal GetStreamingFactor(string quality)
        {
            switch (quality)
            {
                case "SD": return 0.1m;
                case "HD": return 0.25m;
                case "4K": return 0.5m;
                default: return 0.25m;
            }
        }

        private static decimal GetGamingFactor(string platform)
        {
            switch (platform)
            {
                case "Mobile": return 0.05m;
                case "Console": return 0.2m;
                case "PC": return 0.3m;
                case "Cloud": return 0.4m;
                default: return 0.2m;
            }
        }

        private static decimal GetChargingFactor(string device)
        {
            switch (device)
            {
                case "Smartphone": return 0.008m;
                case "Tablet": return 0.015m;
                case "Laptop": return 0.05m;
                case "Smartwatch": return 0.002m;
                default: return 0.01m;
            }
        }
    }
}
