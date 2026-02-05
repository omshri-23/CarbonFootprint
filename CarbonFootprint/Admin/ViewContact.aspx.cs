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
    public partial class ViewContact : System.Web.UI.Page
    {
            string cs = ConfigurationManager.ConnectionStrings["CarbonDB"].ConnectionString;

            protected void Page_Load(object sender, EventArgs e)
            {
                if (!IsPostBack)
                {
                    LoadContacts();
                }
            }

            private void LoadContacts()
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    string query = "SELECT MessageID, FullName, Email, Subject, Status, CreatedDate FROM ContactMessages ORDER BY CreatedDate DESC";
                    SqlDataAdapter da = new SqlDataAdapter(query, con);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    gvContacts.DataSource = dt;
                    gvContacts.DataBind();
                }
            }

            protected void gvContacts_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
            {
                int id = Convert.ToInt32(e.CommandArgument);

                using (SqlConnection con = new SqlConnection(cs))
                {
                    con.Open();

                    if (e.CommandName == "ReadMsg")
                    {
                        string q = "UPDATE ContactMessages SET Status='Read', ReadDate=GETDATE() WHERE MessageID=@ID";
                        SqlCommand cmd = new SqlCommand(q, con);
                        cmd.Parameters.AddWithValue("@ID", id);
                        cmd.ExecuteNonQuery();
                    }
                    else if (e.CommandName == "DeleteMsg")
                    {
                        string q = "DELETE FROM ContactMessages WHERE MessageID=@ID";
                        SqlCommand cmd = new SqlCommand(q, con);
                        cmd.Parameters.AddWithValue("@ID", id);
                        cmd.ExecuteNonQuery();
                    }
                }

                LoadContacts();
            }
        }
    }
