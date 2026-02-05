using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace CarbonFootprint.Admin
{
    public partial class Reports : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Admin"] == null)
            {
                Response.Redirect("Adminlogin.aspx");
                return;
            }

            if (!IsPostBack)
            {
                PopulateFilterOptions();
                LoadReports();
            }
        }

        private void LoadReports()
        {
            GetDateRange(out DateTime? from, out DateTime? to);
            string cs = ConfigurationManager.ConnectionStrings["CarbonDB"].ConnectionString;
            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                // Top stats
                lblUsers.Text = ExecuteScalarInt(con, @"
IF COL_LENGTH('Users','CreatedDate') IS NOT NULL
    SELECT COUNT(*) FROM Users
    WHERE (@From IS NULL OR CreatedDate >= @From)
      AND (@To IS NULL OR CreatedDate < DATEADD(day, 1, @To));
ELSE
    SELECT COUNT(*) FROM Users;", from, to).ToString();

                lblCalculations.Text = ExecuteScalarInt(con, @"
IF COL_LENGTH('EmissionCalculation','CalculationDate') IS NOT NULL
    SELECT COUNT(*) FROM EmissionCalculation
    WHERE (@From IS NULL OR CalculationDate >= @From)
      AND (@To IS NULL OR CalculationDate < DATEADD(day, 1, @To));
ELSE
    SELECT COUNT(*) FROM EmissionCalculation;", from, to).ToString();

                lblEmissions.Text = ExecuteScalarDecimal(con, @"
IF COL_LENGTH('EmissionCalculation','CO2Equivalent') IS NULL
    SELECT CAST(0 AS decimal(18,4));
ELSE
BEGIN
    IF COL_LENGTH('EmissionCalculation','CalculationDate') IS NOT NULL
        SELECT ISNULL(SUM(CAST(CO2Equivalent AS decimal(18,4))), 0)
        FROM EmissionCalculation
        WHERE (@From IS NULL OR CalculationDate >= @From)
          AND (@To IS NULL OR CalculationDate < DATEADD(day, 1, @To));
    ELSE
        SELECT ISNULL(SUM(CAST(CO2Equivalent AS decimal(18,4))), 0) FROM EmissionCalculation;
END", from, to).ToString("F1");

                lblActiveUsers.Text = ExecuteScalarInt(con, @"
IF COL_LENGTH('Users','LastLoginDate') IS NOT NULL
    SELECT COUNT(*) FROM Users WHERE CAST(LastLoginDate AS date) = CAST(GETDATE() AS date);
ELSE IF COL_LENGTH('EmissionCalculation','CreatedDate') IS NOT NULL AND COL_LENGTH('EmissionCalculation','UserID') IS NOT NULL
    SELECT COUNT(DISTINCT UserID) FROM EmissionCalculation WHERE CAST(CreatedDate AS date) = CAST(GETDATE() AS date);
ELSE
    SELECT 0;", null, null).ToString();

                // Category breakdown
                using (SqlCommand cmd = new SqlCommand(@"
SELECT Category, COUNT(*) AS Calculations, ISNULL(SUM(CO2Equivalent), 0) AS TotalCO2e
FROM EmissionCalculation
WHERE (@From IS NULL OR CalculationDate >= @From)
  AND (@To IS NULL OR CalculationDate < DATEADD(day, 1, @To))
GROUP BY Category
ORDER BY TotalCO2e DESC;", con))
                {
                    cmd.Parameters.AddWithValue("@From", (object)from ?? DBNull.Value);
                    cmd.Parameters.AddWithValue("@To", (object)to ?? DBNull.Value);
                    DataTable dt = new DataTable();
                    new SqlDataAdapter(cmd).Fill(dt);
                    gvCategory.DataSource = dt;
                    gvCategory.DataBind();
                }

                // Top users by emissions
                using (SqlCommand cmd = new SqlCommand(@"
SELECT TOP 10 u.FullName, u.Email, ISNULL(SUM(e.CO2Equivalent), 0) AS TotalCO2e
FROM Users u
JOIN EmissionCalculation e ON u.UserID = e.UserID
WHERE (@From IS NULL OR e.CalculationDate >= @From)
  AND (@To IS NULL OR e.CalculationDate < DATEADD(day, 1, @To))
GROUP BY u.FullName, u.Email
ORDER BY TotalCO2e DESC;", con))
                {
                    cmd.Parameters.AddWithValue("@From", (object)from ?? DBNull.Value);
                    cmd.Parameters.AddWithValue("@To", (object)to ?? DBNull.Value);
                    DataTable dt = new DataTable();
                    new SqlDataAdapter(cmd).Fill(dt);
                    gvTopUsers.DataSource = dt;
                    gvTopUsers.DataBind();
                }
            }
        }

        private void PopulateFilterOptions()
        {
            ddlMonth.Items.Clear();
            ddlMonth.Items.Add(new System.Web.UI.WebControls.ListItem("All Months", ""));
            for (int m = 1; m <= 12; m++)
                ddlMonth.Items.Add(new System.Web.UI.WebControls.ListItem(
                    new DateTime(2000, m, 1).ToString("MMMM"), m.ToString()));

            ddlYear.Items.Clear();
            ddlYear.Items.Add(new System.Web.UI.WebControls.ListItem("All Years", ""));
            int currentYear = DateTime.Today.Year;
            for (int y = currentYear; y >= currentYear - 5; y--)
                ddlYear.Items.Add(new System.Web.UI.WebControls.ListItem(y.ToString(), y.ToString()));
        }

        private void GetDateRange(out DateTime? from, out DateTime? to)
        {
            from = null;
            to = null;
            if (DateTime.TryParse(txtFromDate.Text, out DateTime f)) from = f.Date;
            if (DateTime.TryParse(txtToDate.Text, out DateTime t)) to = t.Date;

            if (!from.HasValue && !to.HasValue &&
                int.TryParse(ddlMonth.SelectedValue, out int month) &&
                int.TryParse(ddlYear.SelectedValue, out int year))
            {
                from = new DateTime(year, month, 1);
                to = from.Value.AddMonths(1).AddDays(-1);
            }
        }

        protected void ApplyFilters_Click(object sender, EventArgs e)
        {
            LoadReports();
        }

        protected void ClearFilters_Click(object sender, EventArgs e)
        {
            txtFromDate.Text = string.Empty;
            txtToDate.Text = string.Empty;
            ddlMonth.SelectedIndex = 0;
            ddlYear.SelectedIndex = 0;
            LoadReports();
        }

        protected void ExportCsv_Click(object sender, EventArgs e)
        {
            GetDateRange(out DateTime? from, out DateTime? to);
            DataTable dt = new DataTable();

            string cs = ConfigurationManager.ConnectionStrings["CarbonDB"].ConnectionString;
            using (SqlConnection con = new SqlConnection(cs))
            using (SqlCommand cmd = new SqlCommand(@"
SELECT TOP 1000 u.FullName, u.Email, ISNULL(SUM(e.CO2Equivalent), 0) AS TotalCO2e
FROM Users u
JOIN EmissionCalculation e ON u.UserID = e.UserID
WHERE (@From IS NULL OR e.CalculationDate >= @From)
  AND (@To IS NULL OR e.CalculationDate < DATEADD(day, 1, @To))
GROUP BY u.FullName, u.Email
ORDER BY TotalCO2e DESC;", con))
            {
                cmd.Parameters.AddWithValue("@From", (object)from ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@To", (object)to ?? DBNull.Value);
                new SqlDataAdapter(cmd).Fill(dt);
            }

            Response.Clear();
            Response.ContentType = "text/csv";
            Response.AddHeader("Content-Disposition", "attachment; filename=top-users.csv");
            Response.Write("FullName,Email,TotalCO2e\r\n");
            foreach (DataRow row in dt.Rows)
            {
                Response.Write(string.Format("\"{0}\",\"{1}\",\"{2}\"\r\n",
                    row["FullName"]?.ToString().Replace("\"", "\"\""),
                    row["Email"]?.ToString().Replace("\"", "\"\""),
                    row["TotalCO2e"]?.ToString()));
            }
            Response.End();
        }

        private static int ExecuteScalarInt(SqlConnection con, string sql, DateTime? from, DateTime? to)
        {
            using (SqlCommand cmd = new SqlCommand(sql, con))
            {
                cmd.Parameters.AddWithValue("@From", (object)from ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@To", (object)to ?? DBNull.Value);
                object result = cmd.ExecuteScalar();
                return result == null || result == DBNull.Value ? 0 : Convert.ToInt32(result);
            }
        }

        private static decimal ExecuteScalarDecimal(SqlConnection con, string sql, DateTime? from, DateTime? to)
        {
            using (SqlCommand cmd = new SqlCommand(sql, con))
            {
                cmd.Parameters.AddWithValue("@From", (object)from ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@To", (object)to ?? DBNull.Value);
                object result = cmd.ExecuteScalar();
                return result == null || result == DBNull.Value ? 0m : Convert.ToDecimal(result);
            }
        }
    }
}
