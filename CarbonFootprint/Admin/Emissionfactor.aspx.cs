using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CarbonFootprint.Admin
{
    public partial class Emissionfactor : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Admin"] == null)
            {
                Response.Redirect("Adminlogin.aspx");
                return;
            }

            if (!IsPostBack)
                LoadFactors();
        }

        private void LoadFactors()
        {
            string cs = ConfigurationManager.ConnectionStrings["CarbonDB"].ConnectionString;

            try
            {
                using (SqlConnection con = new SqlConnection(cs))
                using (SqlDataAdapter da = new SqlDataAdapter("SELECT * FROM EmissionFactors", con))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    gvFactors.DataSource = dt;
                    gvFactors.DataBind();
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Unable to load emission factors. " + ex.Message;
                lblMessage.Visible = true;
                gvFactors.DataSource = null;
                gvFactors.DataBind();
            }
        }
    }
}
