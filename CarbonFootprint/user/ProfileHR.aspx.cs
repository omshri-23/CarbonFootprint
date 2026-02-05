using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace CarbonFootprint.user
{
    public partial class ProfileHR : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            phUserLinks.Visible = Session["UserID"] != null;
            phAdminLinks.Visible = Session["Admin"] != null;

            if (!IsPostBack)
            {
                LoadProfile();
                LoadHistory();
                LoadRecommendations();
            }
        }

        private void LoadProfile()
        {
            string cs = ConfigurationManager.ConnectionStrings["CarbonDB"].ConnectionString;
            int userId = Convert.ToInt32(Session["UserID"]);
            using (SqlConnection con = new SqlConnection(cs))
            using (SqlCommand cmd = new SqlCommand(@"
SELECT FullName, Email, PhoneNumber, City, Country, CreatedDate
FROM Users
WHERE UserID=@UserID", con))
            {
                cmd.Parameters.AddWithValue("@UserID", userId);
                con.Open();
                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    if (dr.Read())
                    {
                        string fullName = dr["FullName"].ToString();
                        string email = dr["Email"].ToString();
                        string phone = dr["PhoneNumber"] == DBNull.Value ? string.Empty : dr["PhoneNumber"].ToString();
                        string city = dr["City"] == DBNull.Value ? string.Empty : dr["City"].ToString();
                        string country = dr["Country"] == DBNull.Value ? string.Empty : dr["Country"].ToString();
                        DateTime created = dr["CreatedDate"] == DBNull.Value ? DateTime.Today : Convert.ToDateTime(dr["CreatedDate"]);

                        lblProfileName.Text = fullName;
                        lblProfileEmail.Text = email;
                        lblMemberSince.Text = created.ToString("MMMM yyyy");

                        txtFullName.Text = fullName;
                        txtEmail.Text = email;
                        txtPhone.Text = phone;

                        string location = string.Empty;
                        if (!string.IsNullOrWhiteSpace(city) && !string.IsNullOrWhiteSpace(country))
                            location = city + ", " + country;
                        else if (!string.IsNullOrWhiteSpace(city))
                            location = city;
                        else if (!string.IsNullOrWhiteSpace(country))
                            location = country;

                        txtLocation.Text = location;
                    }
                }
            }
        }

        protected void SaveProfile_Click(object sender, EventArgs e)
        {
            lblProfileStatus.Text = string.Empty;

            string fullName = txtFullName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string phone = txtPhone.Text.Trim();
            string location = txtLocation.Text.Trim();

            if (string.IsNullOrWhiteSpace(fullName) || string.IsNullOrWhiteSpace(email))
            {
                lblProfileStatus.Text = "Name and email are required.";
                return;
            }

            string city = null;
            string country = null;
            if (!string.IsNullOrWhiteSpace(location))
            {
                string[] parts = location.Split(',');
                city = parts[0].Trim();
                if (parts.Length > 1)
                    country = parts[1].Trim();
            }

            string cs = ConfigurationManager.ConnectionStrings["CarbonDB"].ConnectionString;
            int userId = Convert.ToInt32(Session["UserID"]);
            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                using (SqlCommand check = new SqlCommand(
                    "SELECT COUNT(*) FROM Users WHERE Email=@Email AND UserID<>@UserID", con))
                {
                    check.Parameters.AddWithValue("@Email", email);
                    check.Parameters.AddWithValue("@UserID", userId);
                    int exists = Convert.ToInt32(check.ExecuteScalar());
                    if (exists > 0)
                    {
                        lblProfileStatus.Text = "Email already in use.";
                        return;
                    }
                }

                using (SqlCommand cmd = new SqlCommand(@"
UPDATE Users
SET FullName=@FullName,
    Email=@Email,
    PhoneNumber=@PhoneNumber,
    City=@City,
    Country=@Country,
    UpdatedDate=GETDATE()
WHERE UserID=@UserID", con))
                {
                    cmd.Parameters.AddWithValue("@FullName", fullName);
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@PhoneNumber", string.IsNullOrWhiteSpace(phone) ? (object)DBNull.Value : phone);
                    cmd.Parameters.AddWithValue("@City", string.IsNullOrWhiteSpace(city) ? (object)DBNull.Value : city);
                    cmd.Parameters.AddWithValue("@Country", string.IsNullOrWhiteSpace(country) ? (object)DBNull.Value : country);
                    cmd.Parameters.AddWithValue("@UserID", userId);
                    cmd.ExecuteNonQuery();
                }
            }

            Session["UserName"] = fullName;
            Session["UserEmail"] = email;

            lblProfileStatus.Text = "Profile updated successfully.";
            LoadProfile();
        }

        private void LoadHistory()
        {
            string cs = ConfigurationManager.ConnectionStrings["CarbonDB"].ConnectionString;
            int userId = Convert.ToInt32(Session["UserID"]);
            using (SqlConnection con = new SqlConnection(cs))
            using (SqlCommand cmd = new SqlCommand(@"
SELECT TOP 8 Category, CO2Equivalent, CalculationDate, CreatedDate
FROM EmissionCalculation
WHERE UserID=@UserID
ORDER BY CalculationDate DESC, CreatedDate DESC", con))
            {
                cmd.Parameters.AddWithValue("@UserID", userId);
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    dt.Columns.Add("Icon", typeof(string));
                    dt.Columns.Add("Title", typeof(string));
                    dt.Columns.Add("Description", typeof(string));
                    dt.Columns.Add("AmountText", typeof(string));
                    dt.Columns.Add("DateText", typeof(string));

                    foreach (DataRow row in dt.Rows)
                    {
                        string category = row["Category"]?.ToString() ?? "Other";
                        decimal amount = row["CO2Equivalent"] == DBNull.Value ? 0m : Convert.ToDecimal(row["CO2Equivalent"]);
                        DateTime date = row["CalculationDate"] == DBNull.Value
                            ? DateTime.Today
                            : Convert.ToDateTime(row["CalculationDate"]);

                        row["Icon"] = GetCategoryIcon(category);
                        row["Title"] = category;
                        row["Description"] = "Recent calculation";
                        row["AmountText"] = $"{amount:F1} kg CO₂e";
                        row["DateText"] = date.ToString("MMM d, yyyy");
                    }

                    rptHistory.DataSource = dt;
                    rptHistory.DataBind();
                    lblHistoryEmpty.Visible = dt.Rows.Count == 0;
                }
            }
        }

        private void LoadRecommendations()
        {
            string cs = ConfigurationManager.ConnectionStrings["CarbonDB"].ConnectionString;
            int userId = Convert.ToInt32(Session["UserID"]);
            using (SqlConnection con = new SqlConnection(cs))
            using (SqlCommand cmd = new SqlCommand(@"
SELECT TOP 6 Category, RecommendationText, PotentialSavings, Priority, CreatedDate
FROM Recommendations
WHERE UserID=@UserID
ORDER BY CreatedDate DESC", con))
            {
                cmd.Parameters.AddWithValue("@UserID", userId);
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    dt.Columns.Add("Icon", typeof(string));
                    dt.Columns.Add("Title", typeof(string));
                    dt.Columns.Add("Text", typeof(string));
                    dt.Columns.Add("ImpactText", typeof(string));

                    foreach (DataRow row in dt.Rows)
                    {
                        string category = row["Category"]?.ToString() ?? "General";
                        string text = row["RecommendationText"]?.ToString() ?? string.Empty;
                        decimal savings = row["PotentialSavings"] == DBNull.Value ? 0m : Convert.ToDecimal(row["PotentialSavings"]);

                        row["Icon"] = GetCategoryIcon(category);
                        row["Title"] = category + " Recommendation";
                        row["Text"] = text;
                        row["ImpactText"] = savings > 0 ? $"Save ~{savings:F1} kg CO₂e" : "Action recommended";
                    }

                    rptRecommendations.DataSource = dt;
                    rptRecommendations.DataBind();
                    lblRecEmpty.Visible = dt.Rows.Count == 0;
                }
            }
        }

        private static string GetCategoryIcon(string category)
        {
            switch (category)
            {
                case "Transportation": return "🚗";
                case "Energy": return "⚡";
                case "Food": return "🍽️";
                case "Waste": return "♻️";
                case "Water": return "💧";
                case "Digital": return "💻";
                default: return "🌍";
            }
        }
    }
}
