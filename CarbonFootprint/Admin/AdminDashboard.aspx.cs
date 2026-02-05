using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;

namespace CarbonFootprint.Admin
{
    public partial class AdminDashboard : System.Web.UI.Page
    {
            string conStr = ConfigurationManager.ConnectionStrings["CarbonDB"].ConnectionString;

         
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
                LoadDashboardData();
                LoadRecentUsers();
            }
        }

        private void LoadDashboardData()
        {
            GetDateRange(out DateTime? from, out DateTime? to);

            lblTotalUsers.Text = GetTotalUsers(from, to).ToString();
            lblTotalCalculations.Text = GetTotalCalculations(from, to).ToString();
            lblAvgFootprint.Text = GetAverageFootprint(from, to).ToString("F1");
            lblActiveToday.Text = GetActiveTodayCount(from, to).ToString();
        }

            #region Data Retrieval Methods

            private int GetTotalUsers(DateTime? from, DateTime? to)
            {
                const string sql = @"
IF COL_LENGTH('Users','CreatedDate') IS NOT NULL
    SELECT COUNT(*) FROM Users
    WHERE (@From IS NULL OR CreatedDate >= @From)
      AND (@To IS NULL OR CreatedDate < DATEADD(day, 1, @To));
ELSE
    SELECT COUNT(*) FROM Users;";
                return ExecuteScalarInt(sql, from, to);
            }

            private int GetTotalCalculations(DateTime? from, DateTime? to)
            {
                const string sql = @"
IF COL_LENGTH('EmissionCalculation','CalculationDate') IS NOT NULL
    SELECT COUNT(*) FROM EmissionCalculation
    WHERE (@From IS NULL OR CalculationDate >= @From)
      AND (@To IS NULL OR CalculationDate < DATEADD(day, 1, @To));
ELSE
    SELECT COUNT(*) FROM EmissionCalculation;";
                return ExecuteScalarInt(sql, from, to);
            }

            private decimal GetAverageFootprint(DateTime? from, DateTime? to)
            {
                const string sql = @"
IF COL_LENGTH('EmissionCalculation','CO2Equivalent') IS NULL
    SELECT CAST(0 AS decimal(18,4));
ELSE
BEGIN
    IF COL_LENGTH('EmissionCalculation','CalculationDate') IS NOT NULL
        SELECT ISNULL(AVG(CAST(CO2Equivalent AS decimal(18,4))), 0)
        FROM EmissionCalculation
        WHERE (@From IS NULL OR CalculationDate >= @From)
          AND (@To IS NULL OR CalculationDate < DATEADD(day, 1, @To));
    ELSE
        SELECT ISNULL(AVG(CAST(CO2Equivalent AS decimal(18,4))), 0) FROM EmissionCalculation;
END";
                return ExecuteScalarDecimal(sql, from, to);
            }

            private int GetActiveTodayCount(DateTime? from, DateTime? to)
            {
                if (from.HasValue || to.HasValue)
                {
                    const string sql = @"
IF COL_LENGTH('EmissionCalculation','CalculationDate') IS NOT NULL
    SELECT COUNT(DISTINCT UserID) FROM EmissionCalculation
    WHERE (@From IS NULL OR CalculationDate >= @From)
      AND (@To IS NULL OR CalculationDate < DATEADD(day, 1, @To));
ELSE
    SELECT 0;";
                    return ExecuteScalarInt(sql, from, to);
                }

                const string todaySql = @"
IF COL_LENGTH('Users','LastLoginDate') IS NOT NULL
    SELECT COUNT(*) FROM Users WHERE CAST(LastLoginDate AS date) = CAST(GETDATE() AS date);
ELSE IF COL_LENGTH('EmissionCalculation','CreatedDate') IS NOT NULL AND COL_LENGTH('EmissionCalculation','UserID') IS NOT NULL
    SELECT COUNT(DISTINCT UserID) FROM EmissionCalculation WHERE CAST(CreatedDate AS date) = CAST(GETDATE() AS date);
ELSE
    SELECT 0;";
                return ExecuteScalarInt(todaySql, null, null);
            }

            #endregion

            private void LoadRecentUsers()
            {
                GetDateRange(out DateTime? from, out DateTime? to);
                const string sql = @"
SELECT TOP 10
    u.UserID,
    u.FullName,
    u.Email,
    u.CreatedDate,
    u.IsActive,
    ISNULL(c.CalcCount, 0) AS CalcCount,
    ISNULL(c.AvgCO2e, 0) AS AvgCO2e
FROM Users u
LEFT JOIN (
    SELECT UserID, COUNT(*) AS CalcCount, AVG(CO2Equivalent) AS AvgCO2e
    FROM EmissionCalculation
    GROUP BY UserID
) c ON u.UserID = c.UserID
WHERE u.Role = 'User'
  AND (@From IS NULL OR COL_LENGTH('Users','CreatedDate') IS NULL OR u.CreatedDate >= @From)
  AND (@To IS NULL OR COL_LENGTH('Users','CreatedDate') IS NULL OR u.CreatedDate < DATEADD(day, 1, @To))
ORDER BY u.CreatedDate DESC;";

                try
                {
                    using (SqlConnection con = new SqlConnection(conStr))
                    using (SqlCommand cmd = new SqlCommand(sql, con))
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        cmd.Parameters.AddWithValue("@From", (object)from ?? DBNull.Value);
                        cmd.Parameters.AddWithValue("@To", (object)to ?? DBNull.Value);
                        DataTable dt = new DataTable();
                        da.Fill(dt);

                        if (!dt.Columns.Contains("Initials"))
                            dt.Columns.Add("Initials", typeof(string));
                        if (!dt.Columns.Contains("StatusClass"))
                            dt.Columns.Add("StatusClass", typeof(string));
                        if (!dt.Columns.Contains("StatusText"))
                            dt.Columns.Add("StatusText", typeof(string));
                        if (!dt.Columns.Contains("AvgFootprintText"))
                            dt.Columns.Add("AvgFootprintText", typeof(string));

                        foreach (DataRow row in dt.Rows)
                        {
                            string fullName = row["FullName"]?.ToString() ?? "";
                            row["Initials"] = GetInitials(fullName);
                            bool isActive = row["IsActive"] != DBNull.Value && Convert.ToBoolean(row["IsActive"]);
                            row["StatusClass"] = isActive ? "status-active" : "status-inactive";
                            row["StatusText"] = isActive ? "Active" : "Inactive";
                            decimal avg = row["AvgCO2e"] == DBNull.Value ? 0m : Convert.ToDecimal(row["AvgCO2e"]);
                            row["AvgFootprintText"] = $"{avg:F1} kg CO₂e";
                        }

                        rptRecentUsers.DataSource = dt;
                        rptRecentUsers.DataBind();
                    }
                }
                catch
                {
                    rptRecentUsers.DataSource = null;
                    rptRecentUsers.DataBind();
                }
            }

        private static string GetInitials(string fullName)
        {
            if (string.IsNullOrWhiteSpace(fullName)) return "NA";
            string[] parts = fullName.Trim().Split(new[] { ' ' }, StringSplitOptions.RemoveEmptyEntries);
            if (parts.Length == 1) return parts[0].Substring(0, 1).ToUpperInvariant();
            return (parts[0].Substring(0, 1) + parts[1].Substring(0, 1)).ToUpperInvariant();
        }

        protected void rptRecentUsers_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int userId = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "EditUser")
            {
                Session["SelectedUserId"] = userId;
                Response.Redirect("Viewusers.aspx");
                return;
            }

            using (SqlConnection con = new SqlConnection(conStr))
            {
                con.Open();

                if (e.CommandName == "ToggleStatus")
                {
                    string q = "UPDATE Users SET IsActive = CASE WHEN IsActive = 1 THEN 0 ELSE 1 END WHERE UserID=@id AND Role='User'";
                    using (SqlCommand cmd = new SqlCommand(q, con))
                    {
                        cmd.Parameters.AddWithValue("@id", userId);
                        cmd.ExecuteNonQuery();
                    }
                }

                if (e.CommandName == "DeleteUser")
                {
                    string q = "DELETE FROM Users WHERE UserID=@id AND Role='User'";
                    using (SqlCommand cmd = new SqlCommand(q, con))
                    {
                        cmd.Parameters.AddWithValue("@id", userId);
                        cmd.ExecuteNonQuery();
                    }
                }
            }

            LoadRecentUsers();
        }

            #region Optional: Real-time Data Methods

            // These can be called via AJAX for live updates
            [System.Web.Services.WebMethod]
            public static string GetLatestStats()
            {
                string conStr = ConfigurationManager.ConnectionStrings["CarbonDB"].ConnectionString;

                int totalUsers = ExecuteScalarInt(conStr, "SELECT COUNT(*) FROM Users", null, null);
                int totalCalculations = ExecuteScalarInt(conStr, "SELECT COUNT(*) FROM EmissionCalculation", null, null);
                decimal avgFootprint = ExecuteScalarDecimal(conStr, @"
IF COL_LENGTH('EmissionCalculation','CO2Equivalent') IS NULL
    SELECT CAST(0 AS decimal(18,4));
ELSE
    SELECT ISNULL(AVG(CAST(CO2Equivalent AS decimal(18,4))), 0) FROM EmissionCalculation;
", null, null);
                int activeToday = ExecuteScalarInt(conStr, @"
IF COL_LENGTH('Users','LastLoginDate') IS NOT NULL
    SELECT COUNT(*) FROM Users WHERE CAST(LastLoginDate AS date) = CAST(GETDATE() AS date);
ELSE IF COL_LENGTH('EmissionCalculation','CreatedDate') IS NOT NULL AND COL_LENGTH('EmissionCalculation','UserID') IS NOT NULL
    SELECT COUNT(DISTINCT UserID) FROM EmissionCalculation WHERE CAST(CreatedDate AS date) = CAST(GETDATE() AS date);
ELSE
    SELECT 0;
", null, null);

                var stats = new
                {
                    totalUsers,
                    totalCalculations,
                    avgFootprint = Math.Round(avgFootprint, 1),
                    activeToday
                };

                return new JavaScriptSerializer().Serialize(stats);
            }

            [System.Web.Services.WebMethod]
            public static string GetRecentActivity()
            {
                // Placeholder: wire this to a real activity table if/when available.
                return new JavaScriptSerializer().Serialize(Array.Empty<object>());
            }

            #endregion

            private int ExecuteScalarInt(string sql)
            {
                return ExecuteScalarInt(conStr, sql, null, null);
            }

            private int ExecuteScalarInt(string sql, DateTime? from, DateTime? to)
            {
                return ExecuteScalarInt(conStr, sql, from, to);
            }

            private static int ExecuteScalarInt(string cs, string sql, DateTime? from, DateTime? to)
            {
                try
                {
                    using (SqlConnection con = new SqlConnection(cs))
                    using (SqlCommand cmd = new SqlCommand(sql, con))
                    {
                        cmd.Parameters.AddWithValue("@From", (object)from ?? DBNull.Value);
                        cmd.Parameters.AddWithValue("@To", (object)to ?? DBNull.Value);
                        con.Open();
                        object result = cmd.ExecuteScalar();
                        return result == null || result == DBNull.Value ? 0 : Convert.ToInt32(result);
                    }
                }
                catch
                {
                    return 0;
                }
            }

            private decimal ExecuteScalarDecimal(string sql)
            {
                return ExecuteScalarDecimal(conStr, sql, null, null);
            }

            private decimal ExecuteScalarDecimal(string sql, DateTime? from, DateTime? to)
            {
                return ExecuteScalarDecimal(conStr, sql, from, to);
            }

            private static decimal ExecuteScalarDecimal(string cs, string sql, DateTime? from, DateTime? to)
            {
                try
                {
                    using (SqlConnection con = new SqlConnection(cs))
                    using (SqlCommand cmd = new SqlCommand(sql, con))
                    {
                        cmd.Parameters.AddWithValue("@From", (object)from ?? DBNull.Value);
                        cmd.Parameters.AddWithValue("@To", (object)to ?? DBNull.Value);
                        con.Open();
                        object result = cmd.ExecuteScalar();
                        return result == null || result == DBNull.Value ? 0m : Convert.ToDecimal(result);
                    }
                }
                catch
                {
                    return 0m;
                }
            }

        private void PopulateFilterOptions()
        {
            ddlMonth.Items.Clear();
            ddlMonth.Items.Add(new System.Web.UI.WebControls.ListItem("All Months", ""));
            for (int m = 1; m <= 12; m++)
            {
                ddlMonth.Items.Add(new System.Web.UI.WebControls.ListItem(
                    new DateTime(2000, m, 1).ToString("MMMM"), m.ToString()));
            }

            ddlYear.Items.Clear();
            ddlYear.Items.Add(new System.Web.UI.WebControls.ListItem("All Years", ""));
            int currentYear = DateTime.Today.Year;
            for (int y = currentYear; y >= currentYear - 5; y--)
            {
                ddlYear.Items.Add(new System.Web.UI.WebControls.ListItem(y.ToString(), y.ToString()));
            }
        }

        private void GetDateRange(out DateTime? from, out DateTime? to)
        {
            from = null;
            to = null;

            if (DateTime.TryParse(txtFromDate.Text, out DateTime f))
                from = f.Date;
            if (DateTime.TryParse(txtToDate.Text, out DateTime t))
                to = t.Date;

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
            LoadDashboardData();
            LoadRecentUsers();
        }

        protected void ClearFilters_Click(object sender, EventArgs e)
        {
            txtFromDate.Text = string.Empty;
            txtToDate.Text = string.Empty;
            ddlMonth.SelectedIndex = 0;
            ddlYear.SelectedIndex = 0;
            LoadDashboardData();
            LoadRecentUsers();
        }

        protected void Refresh_Click(object sender, EventArgs e)
        {
            LoadDashboardData();
            LoadRecentUsers();
        }

        protected void ExportCsv_Click(object sender, EventArgs e)
        {
            GetDateRange(out DateTime? from, out DateTime? to);
            DataTable dt = FetchRecentUsersForExport(from, to);

            Response.Clear();
            Response.ContentType = "text/csv";
            Response.AddHeader("Content-Disposition", "attachment; filename=recent-users.csv");

            Response.Write("FullName,Email,CreatedDate,Calculations,AvgCO2e,IsActive\r\n");
            foreach (DataRow row in dt.Rows)
            {
                string line = string.Format("\"{0}\",\"{1}\",\"{2}\",\"{3}\",\"{4}\",\"{5}\"\r\n",
                    row["FullName"]?.ToString().Replace("\"", "\"\""),
                    row["Email"]?.ToString().Replace("\"", "\"\""),
                    row["CreatedDate"] == DBNull.Value ? "" : Convert.ToDateTime(row["CreatedDate"]).ToString("yyyy-MM-dd"),
                    row["CalcCount"]?.ToString(),
                    row["AvgCO2e"]?.ToString(),
                    row["IsActive"]?.ToString());
                Response.Write(line);
            }
            Response.End();
        }

        private DataTable FetchRecentUsersForExport(DateTime? from, DateTime? to)
        {
            const string sql = @"
SELECT TOP 1000
    u.FullName,
    u.Email,
    u.CreatedDate,
    ISNULL(c.CalcCount, 0) AS CalcCount,
    ISNULL(c.AvgCO2e, 0) AS AvgCO2e,
    u.IsActive
FROM Users u
LEFT JOIN (
    SELECT UserID, COUNT(*) AS CalcCount, AVG(CO2Equivalent) AS AvgCO2e
    FROM EmissionCalculation
    GROUP BY UserID
) c ON u.UserID = c.UserID
WHERE u.Role = 'User'
  AND (@From IS NULL OR COL_LENGTH('Users','CreatedDate') IS NULL OR u.CreatedDate >= @From)
  AND (@To IS NULL OR COL_LENGTH('Users','CreatedDate') IS NULL OR u.CreatedDate < DATEADD(day, 1, @To))
ORDER BY u.CreatedDate DESC;";

            using (SqlConnection con = new SqlConnection(conStr))
            using (SqlCommand cmd = new SqlCommand(sql, con))
            using (SqlDataAdapter da = new SqlDataAdapter(cmd))
            {
                cmd.Parameters.AddWithValue("@From", (object)from ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@To", (object)to ?? DBNull.Value);
                DataTable dt = new DataTable();
                da.Fill(dt);
                return dt;
            }
        }
        }
    }
