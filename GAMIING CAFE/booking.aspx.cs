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
    public partial class BookingPage : System.Web.UI.Page
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
                if (Session["user"] != null)
                {
                    txtCustomerName.Text = Session["user"].ToString();
                }
                txtDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
                fillStations();
                calculateTotal();
            }
        }

        void fillStations()
        {
            getcon();
            da = new SqlDataAdapter("select * from tbl_station where status='Available'", con);
            ds = new DataSet();
            da.Fill(ds);
            drpStation.DataSource = ds;
            drpStation.DataTextField = "station_name";
            drpStation.DataValueField = "station_id";
            drpStation.DataBind();
            con.Close();
        }

        void calculateTotal()
        {
            if (drpStation.Items.Count > 0)
            {
                getcon();
                da = new SqlDataAdapter("select rate_per_hour from tbl_station where station_id='" + drpStation.SelectedValue + "'", con);
                ds = new DataSet();
                da.Fill(ds);
                con.Close();

                if (ds.Tables[0].Rows.Count > 0)
                {
                    int rate = Convert.ToInt32(ds.Tables[0].Rows[0]["rate_per_hour"]);
                    int hours = Convert.ToInt32(drpDuration.SelectedValue);
                    int total = rate * hours;
                    lblRate.Text = rate.ToString();
                    lblTotalAmount.Text = total.ToString();
                }
            }
        }

        protected void drpStation_SelectedIndexChanged(object sender, EventArgs e)
        {
            calculateTotal();
        }

        protected void drpDuration_SelectedIndexChanged(object sender, EventArgs e)
        {
            calculateTotal();
        }

        protected void btnConfirmBooking_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(txtCustomerName.Text.Trim()))
            {
                Response.Write("<script>alert('Please enter customer name');</script>");
                return;
            }

            if (string.IsNullOrEmpty(txtDate.Text))
            {
                Response.Write("<script>alert('Please select booking date');</script>");
                return;
            }

            getcon();
            string customerName = txtCustomerName.Text.Trim();
            string stationName = drpStation.SelectedItem.Text;
            string bookingDate = txtDate.Text;
            string timeSlot = drpTimeSlot.SelectedValue;
            int hours = Convert.ToInt32(drpDuration.SelectedValue);
            int total = Convert.ToInt32(lblTotalAmount.Text);

            cmd = new SqlCommand("insert into tbl_booking(user_name,station_name,booking_date,time_slot,duration_hours,total_amount,status) values('" + customerName + "','" + stationName + "','" + bookingDate + "','" + timeSlot + "'," + hours + "," + total + ",'Confirmed')", con);
            cmd.ExecuteNonQuery();
            con.Close();

            Response.Write("<script>alert('Booking successfully confirmed for " + stationName + "!');window.location='customer-dashboard.aspx';</script>");
        }
    }
}
