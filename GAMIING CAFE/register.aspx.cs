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
    public partial class RegisterPage : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter da;
        DataSet ds;

        string s = ConfigurationManager.ConnectionStrings["dbcon"].ConnectionString;

        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        void clear()
        {
            txtName.Text = "";
            txtEmail.Text = "";
            txtPhone.Text = "";
            txtPassword.Text = "";
            txtConfirmPassword.Text = "";
            ddlRole.ClearSelection();
            ddlMembership.ClearSelection();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

            }
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            if (txtPassword.Text.Trim() != txtConfirmPassword.Text.Trim())
            {
                Response.Write("<script>alert('Password and Confirm Password do not match');</script>");
            }
            else
            {
                getcon();
                da = new SqlDataAdapter("select * from tbl_user where email='" + txtEmail.Text.Trim() + "'", con);
                ds = new DataSet();
                da.Fill(ds);

                if (ds.Tables[0].Rows.Count > 0)
                {
                    con.Close();
                    Response.Write("<script>alert('Email already registered! Please login or use different email.');</script>");
                }
                else
                {
                    cmd = new SqlCommand("insert into tbl_user(name,email,phone,password,role) values('" + txtName.Text.Trim() + "','" + txtEmail.Text.Trim() + "','" + txtPhone.Text.Trim() + "','" + txtPassword.Text.Trim() + "','" + ddlRole.SelectedValue + "')", con);
                    cmd.ExecuteNonQuery();
                    con.Close();
                    clear();
                    Response.Write("<script>alert('Record inserted successfully');window.location='login.aspx';</script>");
                }
            }
        }
    }
}
