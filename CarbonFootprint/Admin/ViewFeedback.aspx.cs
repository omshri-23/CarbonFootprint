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
    public partial class ViewFeedback : System.Web.UI.Page
    {
            string cs = ConfigurationManager.ConnectionStrings["CarbonDB"].ConnectionString;

            protected void Page_Load(object sender, EventArgs e)
            {
                if (!IsPostBack)
                    LoadFeedback();
            }

            private void LoadFeedback()
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    string query = @"SELECT f.FeedbackID, u.FullName, u.Email,
                                 f.Subject, f.Message, f.Rating, f.Status
                                 FROM Feedback f
                                 LEFT JOIN Users u ON f.UserID = u.UserID
                                 ORDER BY f.CreatedDate DESC";

                    SqlDataAdapter da = new SqlDataAdapter(query, con);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    gvFeedback.DataSource = dt;
                    gvFeedback.DataBind();
                }
            }

            protected void gvFeedback_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
            {
                if (e.CommandName == "ReplyFeedback")
                {
                    int id = Convert.ToInt32(e.CommandArgument);
                    int rowIndex = Convert.ToInt32(e.CommandArgument) - gvFeedback.PageIndex * gvFeedback.PageSize;

                    var row = gvFeedback.Rows[rowIndex];
                    var txtReply = (System.Web.UI.WebControls.TextBox)row.FindControl("txtReply");

                    using (SqlConnection con = new SqlConnection(cs))
                    {
                        string query = @"UPDATE Feedback 
                                     SET AdminResponse=@Reply, Status='Resolved', ResponseDate=GETDATE()
                                     WHERE FeedbackID=@ID";

                        SqlCommand cmd = new SqlCommand(query, con);
                        cmd.Parameters.AddWithValue("@Reply", txtReply.Text);
                        cmd.Parameters.AddWithValue("@ID", id);

                        con.Open();
                        cmd.ExecuteNonQuery();
                    }

                    LoadFeedback();
                }
            }
        }
    }
