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
    public partial class FoodPage : System.Web.UI.Page
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
            if (!IsPostBack)
            {
                fillFood("All");
            }
        }

        void fillFood(string cat)
        {
            getcon();
            if (cat == "All")
            {
                da = new SqlDataAdapter("select * from tbl_food", con);
            }
            else
            {
                da = new SqlDataAdapter("select * from tbl_food where category='" + cat + "'", con);
            }
            ds = new DataSet();
            da.Fill(ds);
            rptFood.DataSource = ds;
            rptFood.DataBind();
            con.Close();
        }

        protected void btnFilterCategory_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            string category = btn.CommandArgument;
            fillFood(category);

            btnAll.CssClass = "btn-outline food-cat-btn";
            btnSnacks.CssClass = "btn-outline food-cat-btn";
            btnBeverages.CssClass = "btn-outline food-cat-btn";

            btn.CssClass = "btn-cyber food-cat-btn";
        }

        protected void rptFood_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "cmd_order")
            {
                if (Session["user"] == null)
                {
                    Response.Write("<script>alert('Please Login first to place a food order!');window.location='login.aspx';</script>");
                }
                else
                {
                    string foodName = e.CommandArgument.ToString();
                    Response.Write("<script>alert('Order placed successfully for " + foodName + "! Kitchen will deliver it to your station.');</script>");
                }
            }
        }
    }
}
