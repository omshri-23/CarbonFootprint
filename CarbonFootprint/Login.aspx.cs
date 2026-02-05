using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CarbonFootprint
{
    public partial class Login : System.Web.UI.Page
    {
            // Read connection string from Web.config
            private readonly string conStr = ConfigurationManager.ConnectionStrings["CarbonDB"].ConnectionString;

         
            protected void Page_Load(object sender, EventArgs e) { }

            // ================= SIGNUP =================
            protected void Signup_Click(object sender, EventArgs e)
            {
                if (txtSignupPassword.Text != txtSignupConfirm.Text)
                {
                    ShowAlert("Passwords do not match");
                    return;
                }

                using (SqlConnection con = new SqlConnection(conStr))
                {
                    con.Open();

                    // Check email exists
                    SqlCommand check = new SqlCommand("SELECT COUNT(*) FROM Users WHERE Email=@Email", con);
                    check.Parameters.AddWithValue("@Email", txtSignupEmail.Text.Trim());

                    if ((int)check.ExecuteScalar() > 0)
                    {
                        ShowAlert("Email already registered!");
                        return;
                    }

                    string hashed = HashPassword(txtSignupPassword.Text.Trim());

                    SqlCommand cmd = new SqlCommand(@"
                INSERT INTO Users 
                (FullName, Email, Password, CreatedDate, IsActive, Role)
                VALUES
                (@FullName, @Email, @Password, GETDATE(), 1, 'User')", con);

                    cmd.Parameters.AddWithValue("@Email", txtSignupEmail.Text.Trim());
                    cmd.Parameters.AddWithValue("@Password", hashed);
                    cmd.Parameters.AddWithValue("@FullName", txtSignupName.Text.Trim());

                    cmd.ExecuteNonQuery();
                }

                ShowAlert("Signup successful! Please login.");
            }

            // ================= LOGIN =================
            protected void Login_Click(object sender, EventArgs e)
            {
                using (SqlConnection con = new SqlConnection(conStr))
                {
                    string plain = txtLoginPassword.Text.Trim();
                    string hashed = HashPassword(plain);

                    SqlCommand cmd = new SqlCommand(@"
                SELECT UserID, FullName 
                FROM Users 
                WHERE Email=@Email AND (Password=@Password OR Password=@Plain) AND IsActive=1", con);

                    cmd.Parameters.AddWithValue("@Email", txtLoginEmail.Text.Trim());
                    cmd.Parameters.AddWithValue("@Password", hashed);
                    cmd.Parameters.AddWithValue("@Plain", plain);

                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();

                    if (dr.Read())
                    {
                        Session["UserID"] = dr["UserID"];
                        Session["UserName"] = dr["FullName"];
                        Session["UserEmail"] = txtLoginEmail.Text.Trim();
                        dr.Close();

                        // Update last login
                        SqlCommand up = new SqlCommand("UPDATE Users SET LastLoginDate=GETDATE() WHERE UserID=@id", con);
                        up.Parameters.AddWithValue("@id", Session["UserID"]);
                        up.ExecuteNonQuery();

                        Response.Redirect("~/user/Dashboard.aspx");
                    }
                    else
                    {
                        ShowAlert("Invalid Email or Password");
                    }
                }
            }

            // ================= HASH PASSWORD =================
            private string HashPassword(string pass)
            {
                using (SHA256 sha = SHA256.Create())
                {
                    byte[] bytes = sha.ComputeHash(Encoding.UTF8.GetBytes(pass));
                    StringBuilder sb = new StringBuilder();
                    foreach (byte b in bytes) sb.Append(b.ToString("x2"));
                    return sb.ToString();
                }
            }

            private void ShowAlert(string msg)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('{msg}');", true);
            }
        }
    }
