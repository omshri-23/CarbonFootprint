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
    public partial class Viewusers : System.Web.UI.Page
    {
            string cs = ConfigurationManager.ConnectionStrings["CarbonDB"].ConnectionString;

            protected void Page_Load(object sender, EventArgs e)
            {
                if (Session["Admin"] == null)
                    Response.Redirect("~/Admin/Adminlogin.aspx");

                if (!IsPostBack)
                    LoadUsers();
            }

            private void LoadUsers()
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    SqlDataAdapter da = new SqlDataAdapter("SELECT * FROM Users ORDER BY CreatedDate DESC", con);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    gvUsers.DataSource = dt;
                    gvUsers.DataBind();
                }

                // Clear highlight after binding
                if (Session["SelectedUserId"] != null)
                    Session["SelectedUserId"] = null;
            }

            protected void gvUsers_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
            {
                int userId = Convert.ToInt32(e.CommandArgument);

                using (SqlConnection con = new SqlConnection(cs))
                {
                    con.Open();

                    if (e.CommandName == "ToggleStatus")
                    {
                        string q = "UPDATE Users SET IsActive = CASE WHEN IsActive = 1 THEN 0 ELSE 1 END WHERE UserID=@id";
                        SqlCommand cmd = new SqlCommand(q, con);
                        cmd.Parameters.AddWithValue("@id", userId);
                        cmd.ExecuteNonQuery();
                    }

                    if (e.CommandName == "DeleteUser")
                    {
                        string q = "DELETE FROM Users WHERE UserID=@id";
                        SqlCommand cmd = new SqlCommand(q, con);
                        cmd.Parameters.AddWithValue("@id", userId);
                        cmd.ExecuteNonQuery();
                    }
                }

                LoadUsers();
            }

            protected void gvUsers_RowDataBound(object sender, GridViewRowEventArgs e)
            {
                if (e.Row.RowType != DataControlRowType.DataRow) return;
                if (Session["SelectedUserId"] == null) return;

                int selectedId = Convert.ToInt32(Session["SelectedUserId"]);
                int rowUserId = Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "UserID"));
                if (rowUserId == selectedId)
                    e.Row.CssClass = "selected-row";
            }
        }
    }
