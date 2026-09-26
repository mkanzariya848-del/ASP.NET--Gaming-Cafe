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
    public partial class IndexPage : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;

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
                fillCounters();
            }
        }

        void fillCounters()
        {
            getcon();

            cmd = new SqlCommand("select count(*) from tbl_station where cat_id=1 and status='Available'", con);
            lblPcAvail.Text = cmd.ExecuteScalar().ToString();

            cmd = new SqlCommand("select count(*) from tbl_station where cat_id=2 and status='Available'", con);
            lblConsoleAvail.Text = cmd.ExecuteScalar().ToString();

            cmd = new SqlCommand("select count(*) from tbl_station where (cat_id=3 or cat_id=4) and status='Available'", con);
            lblOfflineAvail.Text = cmd.ExecuteScalar().ToString();

            con.Close();
        }
    }
}
