using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace CarbonFootprint.user
{
    public partial class Dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadDashboard();
            }
        }

        private void LoadDashboard()
        {
            string cs = ConfigurationManager.ConnectionStrings["CarbonDB"].ConnectionString;
            int userId = Convert.ToInt32(Session["UserID"]);

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                using (SqlCommand cmd = new SqlCommand(
                    "SELECT FullName, Email, LastLoginDate FROM Users WHERE UserID=@UserID", con))
                {
                    cmd.Parameters.AddWithValue("@UserID", userId);
                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        if (dr.Read())
                        {
                            lblUserName.Text = dr["FullName"].ToString();
                            lblEmail.Text = dr["Email"].ToString();
                            lblLastLogin.Text = dr["LastLoginDate"] == DBNull.Value
                                ? "Never"
                                : Convert.ToDateTime(dr["LastLoginDate"]).ToString("MMM d, yyyy h:mm tt");
                        }
                    }
                }

                decimal today = ExecuteScalarDecimal(con, @"
SELECT ISNULL(SUM(DailyCO2e), 0)
FROM EmissionHistory
WHERE UserID=@UserID AND RecordDate = CAST(GETDATE() AS date)", userId);

                decimal month = ExecuteScalarDecimal(con, @"
SELECT ISNULL(SUM(DailyCO2e), 0)
FROM EmissionHistory
WHERE UserID=@UserID
  AND YEAR(RecordDate) = YEAR(GETDATE())
  AND MONTH(RecordDate) = MONTH(GETDATE())", userId);

                decimal lastMonth = ExecuteScalarDecimal(con, @"
SELECT ISNULL(SUM(DailyCO2e), 0)
FROM EmissionHistory
WHERE UserID=@UserID
  AND YEAR(RecordDate) = YEAR(DATEADD(MONTH, -1, GETDATE()))
  AND MONTH(RecordDate) = MONTH(DATEADD(MONTH, -1, GETDATE()))", userId);

                lblTodayCarbon.Text = today.ToString("F1");
                lblMonthCarbon.Text = month.ToString("F1");
                lblTotalFootprint.Text = month.ToString("F1");

                string trendText = "No data for last month";
                string changeText = "0";
                if (lastMonth > 0)
                {
                    decimal change = ((month - lastMonth) / lastMonth) * 100m;
                    string direction = change < 0 ? "less" : "more";
                    trendText = $"{Math.Abs(change):F1}% {direction} than last month";
                    changeText = change.ToString("F1");
                }
                lblMonthTrend.Text = trendText;
                lblMonthChange.Text = changeText;

                string ecoScore = ExecuteScalarString(con, "SELECT dbo.fn_GetCarbonFootprintLevel(@UserID)", userId);
                if (string.IsNullOrWhiteSpace(ecoScore)) ecoScore = "No Data";
                lblEcoScore.Text = ecoScore;

                if (ecoScore == "Excellent")
                {
                    lblEcoRating.Text = "Excellent progress - keep it up!";
                }
                else if (ecoScore == "Good")
                {
                    lblEcoRating.Text = "Good progress - keep going!";
                }
                else if (ecoScore == "Average")
                {
                    lblEcoRating.Text = "Average - room to improve";
                }
                else if (ecoScore == "High")
                {
                    lblEcoRating.Text = "High - consider reducing emissions";
                }
                else if (ecoScore == "Very High")
                {
                    lblEcoRating.Text = "Very high - action needed";
                }
                else
                {
                    lblEcoRating.Text = "Start tracking to see your rating";
                }

                string insight = ExecuteScalarString(con, @"
SELECT TOP 1 RecommendationText 
FROM Recommendations 
WHERE UserID=@UserID 
ORDER BY CreatedDate DESC", userId);

                if (string.IsNullOrWhiteSpace(insight))
                    insight = "Track your daily activities to get personalized tips.";

                lblInsight.Text = insight;
            }
        }

        private static decimal ExecuteScalarDecimal(SqlConnection con, string sql, int userId)
        {
            using (SqlCommand cmd = new SqlCommand(sql, con))
            {
                cmd.Parameters.AddWithValue("@UserID", userId);
                object result = cmd.ExecuteScalar();
                return result == null || result == DBNull.Value ? 0m : Convert.ToDecimal(result);
            }
        }

        private static string ExecuteScalarString(SqlConnection con, string sql, int userId)
        {
            using (SqlCommand cmd = new SqlCommand(sql, con))
            {
                cmd.Parameters.AddWithValue("@UserID", userId);
                object result = cmd.ExecuteScalar();
                return result == null || result == DBNull.Value ? string.Empty : result.ToString();
            }
        }
    }
}
