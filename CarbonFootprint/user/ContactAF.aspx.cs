using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace CarbonFootprint.user
{
    public partial class ContactAF : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            phUserLinks.Visible = Session["UserID"] != null;
            phAdminLinks.Visible = Session["Admin"] != null;

            if (!IsPostBack && Session["UserID"] != null)
            {
                PrefillUserInfo();
            }
        }

        private void PrefillUserInfo()
        {
            string cs = ConfigurationManager.ConnectionStrings["CarbonDB"].ConnectionString;
            int userId = Convert.ToInt32(Session["UserID"]);
            using (SqlConnection con = new SqlConnection(cs))
            using (SqlCommand cmd = new SqlCommand("SELECT FullName, Email FROM Users WHERE UserID=@UserID", con))
            {
                cmd.Parameters.AddWithValue("@UserID", userId);
                con.Open();
                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    if (dr.Read())
                    {
                        txtContactName.Text = dr["FullName"].ToString();
                        txtContactEmail.Text = dr["Email"].ToString();
                    }
                }
            }
        }

        protected void ContactSubmit_Click(object sender, EventArgs e)
        {
            lblContactStatus.Text = string.Empty;
            lblContactStatus.Visible = true;

            string name = txtContactName.Text.Trim();
            string email = txtContactEmail.Text.Trim();
            string subject = txtContactSubject.Text.Trim();
            string message = txtContactMessage.Text.Trim();

            if (string.IsNullOrWhiteSpace(name) || string.IsNullOrWhiteSpace(email) || string.IsNullOrWhiteSpace(message))
            {
                lblContactStatus.Text = "Please fill all required fields.";
                lblContactStatus.ForeColor = System.Drawing.Color.OrangeRed;
                return;
            }

            if (string.IsNullOrWhiteSpace(subject))
                subject = "Contact Message";

            string cs = ConfigurationManager.ConnectionStrings["CarbonDB"].ConnectionString;
            try
            {
                using (SqlConnection con = new SqlConnection(cs))
                using (SqlCommand cmd = new SqlCommand(@"
INSERT INTO ContactMessages (UserID, FullName, Email, Subject, Message, Status)
VALUES (@UserID, @FullName, @Email, @Subject, @Message, 'New');", con))
                {
                    object userId = Session["UserID"] ?? DBNull.Value;
                    cmd.Parameters.AddWithValue("@UserID", userId);
                    cmd.Parameters.AddWithValue("@FullName", name);
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@Subject", subject);
                    cmd.Parameters.AddWithValue("@Message", message);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }

                lblContactStatus.Text = "Message sent successfully.";
                lblContactStatus.ForeColor = System.Drawing.Color.LimeGreen;
                txtContactSubject.Text = string.Empty;
                txtContactMessage.Text = string.Empty;
            }
            catch
            {
                lblContactStatus.Text = "Unable to send message right now. Please try again.";
                lblContactStatus.ForeColor = System.Drawing.Color.OrangeRed;
            }
        }

        protected void FeedbackSubmit_Click(object sender, EventArgs e)
        {
            lblFeedbackStatus.Text = string.Empty;
            lblFeedbackStatus.Visible = true;

            string subject = txtFeedbackSubject.Text.Trim();
            string message = txtFeedbackMessage.Text.Trim();
            string type = ddlFeedbackType.SelectedValue;
            int rating = int.TryParse(hdnRating.Value, out int r) ? r : 0;

            if (string.IsNullOrWhiteSpace(message))
            {
                lblFeedbackStatus.Text = "Please enter your feedback.";
                lblFeedbackStatus.ForeColor = System.Drawing.Color.OrangeRed;
                return;
            }

            if (string.IsNullOrWhiteSpace(subject))
                subject = "Website Feedback";

            string cs = ConfigurationManager.ConnectionStrings["CarbonDB"].ConnectionString;
            try
            {
                using (SqlConnection con = new SqlConnection(cs))
                using (SqlCommand cmd = new SqlCommand(@"
INSERT INTO Feedback (UserID, FeedbackType, Subject, Message, Rating, Status)
VALUES (@UserID, @FeedbackType, @Subject, @Message, @Rating, 'Pending');", con))
                {
                    object userId = Session["UserID"] ?? DBNull.Value;
                    cmd.Parameters.AddWithValue("@UserID", userId);
                    cmd.Parameters.AddWithValue("@FeedbackType", type);
                    cmd.Parameters.AddWithValue("@Subject", subject);
                    cmd.Parameters.AddWithValue("@Message", message);
                    cmd.Parameters.AddWithValue("@Rating", rating == 0 ? (object)DBNull.Value : rating);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }

                lblFeedbackStatus.Text = "Thanks! Your feedback was submitted.";
                lblFeedbackStatus.ForeColor = System.Drawing.Color.LimeGreen;
                txtFeedbackSubject.Text = string.Empty;
                txtFeedbackMessage.Text = string.Empty;
                hdnRating.Value = "0";
            }
            catch
            {
                lblFeedbackStatus.Text = "Unable to submit feedback right now. Please try again.";
                lblFeedbackStatus.ForeColor = System.Drawing.Color.OrangeRed;
            }
        }
    }
}
