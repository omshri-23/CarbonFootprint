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

namespace CarbonFootprint.Admin
{
        public partial class Adminlogin : System.Web.UI.Page
        {
            protected void Login_Click(object sender, EventArgs e)
            {
                string cs = ConfigurationManager.ConnectionStrings["CarbonDB"].ConnectionString;

                using (SqlConnection con = new SqlConnection(cs))
                {
                    string plain = txtPassword.Text.Trim();
                    string hashed = HashPassword(plain);
                    string query = @"SELECT UserID, FullName, Email 
FROM Users 
WHERE Email=@Email AND (Password=@Pass OR Password=@Plain) AND Role='Admin' AND IsActive=1";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@Email", txtEmail.Text);
                    cmd.Parameters.AddWithValue("@Pass", hashed);
                    cmd.Parameters.AddWithValue("@Plain", plain);

                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();

                    if (dr.Read())
                    {
                        Session["Admin"] = dr["Email"].ToString();
                        Session["AdminName"] = dr["FullName"].ToString();
                        Session["AdminID"] = dr["UserID"];
                        Session["Role"] = "Admin";
                        Response.Redirect("AdminDashboard.aspx");
                    }
                    else
                    {
                        lblError.Text = "Invalid Credentials";
                    }
                }
            }

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
        }
    }
