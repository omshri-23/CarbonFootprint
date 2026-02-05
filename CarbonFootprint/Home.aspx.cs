using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CarbonFootprint
{
    public partial class Home : System.Web.UI.Page
    {
            // Get connection string from Web.config
            string connStr = ConfigurationManager.ConnectionStrings["CarbonDB"].ConnectionString;

            protected void Page_Load(object sender, EventArgs e)
            {
                bool isLoggedIn = Session["UserID"] != null;
                phAnonLinks.Visible = !isLoggedIn;
                phAuthLinks.Visible = isLoggedIn;

                if (!IsPostBack)
                {
                    LoadStatistics();
                }
            }

            private void LoadStatistics()
            {
                try
                {
                    using (SqlConnection conn = new SqlConnection(connStr))
                    {
                        conn.Open();

                        // Get Total Users
                        string userQuery = "SELECT COUNT(*) FROM Users";
                        using (SqlCommand cmd = new SqlCommand(userQuery, conn))
                        {
                            object result = cmd.ExecuteScalar();
                            lblTotalUsers.Text = result != null ? result.ToString() : "0";
                        }

                        // Get Total Calculations
                        string calcQuery = "SELECT COUNT(*) FROM EmissionCalculation";
                        using (SqlCommand cmd = new SqlCommand(calcQuery, conn))
                        {
                            object result = cmd.ExecuteScalar();
                            lblTotalCalculations.Text = result != null ? result.ToString() : "0";
                        }

                        // Get Total Emission Factors
                        string factorQuery = "SELECT COUNT(*) FROM EmissionFactors";
                        using (SqlCommand cmd = new SqlCommand(factorQuery, conn))
                        {
                            object result = cmd.ExecuteScalar();
                            lblTotalFactors.Text = result != null ? result.ToString() : "0";
                        }
                    }
                }
                catch (Exception ex)
                {
                    // Log error (you can use logging framework)
                    System.Diagnostics.Debug.WriteLine("Error loading statistics: " + ex.Message);

                    // Set default values on error
                    lblTotalUsers.Text = "0";
                    lblTotalCalculations.Text = "0";
                    lblTotalFactors.Text = "0";
                }
            }
        }
    }
