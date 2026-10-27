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
    public partial class StaffDashboardPage : System.Web.UI.Page
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
                fillFloorStations();
                fillBookings();
            }
        }

        void fillFloorStations()
        {
            getcon();
            da = new SqlDataAdapter("select * from tbl_station order by station_id asc", con);
            ds = new DataSet();
            da.Fill(ds);
            rptStaffStations.DataSource = ds;
            rptStaffStations.DataBind();
            con.Close();
        }

        void fillBookings()
        {
            getcon();
            da = new SqlDataAdapter("select * from tbl_booking where status='Confirmed' order by booking_id desc", con);
            ds = new DataSet();
            da.Fill(ds);
            rptStaffBookings.DataSource = ds;
            rptStaffBookings.DataBind();
            con.Close();
        }

        protected void rptStaffStations_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "cmd_toggle")
            {
                string[] parts = e.CommandArgument.ToString().Split('|');
                int stationId = Convert.ToInt32(parts[0]);
                string currentStatus = parts[1];
                string nextStatus = currentStatus == "Available" ? "Occupied" : "Available";

                getcon();
                cmd = new SqlCommand("update tbl_station set status='" + nextStatus + "' where station_id=" + stationId, con);
                cmd.ExecuteNonQuery();
                con.Close();

                fillFloorStations();
                Response.Write("<script>alert('Station status updated to " + nextStatus + "');</script>");
            }
        }

        protected void rptStaffBookings_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "cmd_complete")
            {
                int bookingId = Convert.ToInt32(e.CommandArgument);
                getcon();
                cmd = new SqlCommand("update tbl_booking set status='Completed' where booking_id=" + bookingId, con);
                cmd.ExecuteNonQuery();
                con.Close();

                fillBookings();
                Response.Write("<script>alert('Booking marked as Completed');</script>");
            }
        }
    }
}
