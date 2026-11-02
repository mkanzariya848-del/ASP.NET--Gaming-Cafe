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
    public partial class AdminDashboardPage : System.Web.UI.Page
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
                fillcounts();
                fillbookings();
                fillstations();
                fillCategories();
            }
        }

        void fillcounts()
        {
            getcon();

            cmd = new SqlCommand("select isnull(sum(total_amount), 0) from tbl_booking", con);
            int rev = Convert.ToInt32(cmd.ExecuteScalar());
            lblTotalRevenue.Text = "&#8377;" + rev;

            cmd = new SqlCommand("select count(*) from tbl_booking", con);
            lblTotalBookings.Text = cmd.ExecuteScalar().ToString();

            cmd = new SqlCommand("select count(*) from tbl_station", con);
            lblTotalStations.Text = cmd.ExecuteScalar().ToString();

            cmd = new SqlCommand("select count(*) from tbl_station where status='Available'", con);
            lblActiveStations.Text = cmd.ExecuteScalar().ToString() + " Available";

            cmd = new SqlCommand("select count(*) from tbl_user", con);
            lblTotalUsers.Text = cmd.ExecuteScalar().ToString();

            con.Close();
        }

        void fillbookings()
        {
            getcon();
            da = new SqlDataAdapter("select * from tbl_booking order by booking_id desc", con);
            ds = new DataSet();
            da.Fill(ds);
            rptBookings.DataSource = ds;
            rptBookings.DataBind();
            con.Close();
        }

        void fillstations()
        {
            getcon();
            da = new SqlDataAdapter("select s.station_id, s.station_name, isnull(c.cat_name, 'Gaming Rig') as cat_name, s.rate_per_hour, s.status from tbl_station s left join tbl_category c on s.cat_id = c.cat_id order by s.station_id asc", con);
            ds = new DataSet();
            da.Fill(ds);
            rptStations.DataSource = ds;
            rptStations.DataBind();
            con.Close();
        }

        void fillCategories()
        {
            getcon();
            da = new SqlDataAdapter("select * from tbl_category", con);
            ds = new DataSet();
            da.Fill(ds);
            drpNewStationCat.DataSource = ds;
            drpNewStationCat.DataTextField = "cat_name";
            drpNewStationCat.DataValueField = "cat_id";
            drpNewStationCat.DataBind();
            con.Close();
        }

        
        protected void btnAddStation_Click(object sender, EventArgs e)
        {
        }

protected void rptBookings_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "cmd_delete")
            {
                int bookingId = Convert.ToInt32(e.CommandArgument);
                getcon();
                cmd = new SqlCommand("delete from tbl_booking where booking_id=" + bookingId, con);
                cmd.ExecuteNonQuery();
                con.Close();

                fillcounts();
                fillbookings();

                Response.Write("<script>alert('Booking #" + bookingId + " deleted successfully!');</script>");
            }
        }

        protected void rptStations_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "cmd_del_station")
            {
                int stationId = Convert.ToInt32(e.CommandArgument);
                getcon();
                cmd = new SqlCommand("delete from tbl_station where station_id=" + stationId, con);
                cmd.ExecuteNonQuery();
                con.Close();

                fillcounts();
                fillstations();

                Response.Write("<script>alert('Station deleted successfully!');</script>");
            }
        }
    }
}
