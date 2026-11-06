using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

namespace GAMIING_CAFE
{
    public partial class LoginPage : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter da;
        DataSet ds;

        string s = ConfigurationManager.ConnectionStrings["mycon"].ConnectionString;

        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            getcon();
            cmd = new SqlCommand("select * from tbl_user where email='" + loginEmail.Text.Trim() + "' and password='" + loginPassword.Text.Trim() + "'", con);
            da = new SqlDataAdapter(cmd);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                Session["user_id"] = ds.Tables[0].Rows[0]["user_id"].ToString();
                Session["user"] = ds.Tables[0].Rows[0]["name"].ToString();
                Session["email"] = ds.Tables[0].Rows[0]["email"].ToString();
                Session["role"] = ds.Tables[0].Rows[0]["role"].ToString();

                string role = ds.Tables[0].Rows[0]["role"].ToString().ToLower();
                con.Close();

                if (role == "admin")
                {
                    Response.Redirect("admin-dashboard.aspx");
                }
                else if (role == "staff")
                {
                    Response.Redirect("staff-dashboard.aspx");
                }
                else
                {
                    Response.Redirect("customer-dashboard.aspx");
                }
            }
            else
            {
                con.Close();
                Response.Write("<script>alert('Invalid Email or Password');</script>");
            }
        }
    }
}
