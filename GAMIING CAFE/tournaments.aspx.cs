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
    public partial class TournamentsPage : System.Web.UI.Page
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
                fillTournaments();
            }
        }

        void fillTournaments()
        {
            getcon();
            da = new SqlDataAdapter("select * from tbl_tournament order by tour_id desc", con);
            ds = new DataSet();
            da.Fill(ds);
            rptTournaments.DataSource = ds;
            rptTournaments.DataBind();
            con.Close();
        }

        protected void rptTournaments_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "cmd_register")
            {
                if (Session["user"] == null)
                {
                    Response.Write("<script>alert('Please Login first to register for tournaments!');window.location='login.aspx';</script>");
                }
                else
                {
                    string tourName = e.CommandArgument.ToString();
                    Response.Write("<script>alert('Registered successfully for " + tourName + " as " + Session["user"] + "! Check-in details sent to your registered email.');</script>");
                }
            }
        }
    }
}
