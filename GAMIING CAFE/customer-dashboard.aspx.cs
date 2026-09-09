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
    public partial class CustomerDashboardPage : System.Web.UI.Page
    {
        SqlConnection con;
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
                fillprofile();
                fillbookings();
            }
        }

        void fillprofile()
        {
            if (Session["user"] != null)
            {
                lblUserName.Text = Session["user"].ToString();
            }

            if (Session["email"] != null)
            {
                lblUserEmail.Text = Session["email"].ToString();

                getcon();
                da = new SqlDataAdapter("select * from tbl_user where email='" + Session["email"].ToString() + "'", con);
                ds = new DataSet();
                da.Fill(ds);

                if (ds.Tables[0].Rows.Count > 0)
                {
                    lblUserName.Text = ds.Tables[0].Rows[0]["name"].ToString();
                    string phone = ds.Tables[0].Rows[0]["phone"].ToString();
                    if (!string.IsNullOrEmpty(phone))
                    {
                        lblUserPhone.Text = phone;
                        phoneSep.Visible = true;
                        lblUserPhone.Visible = true;
                    }
                    else
                    {
                        phoneSep.Visible = false;
                        lblUserPhone.Visible = false;
                    }
                }
                con.Close();
            }
        }

        void fillbookings()
        {
            getcon();
            string uname = Session["user"] != null ? Session["user"].ToString() : "Alex Mercer";
            da = new SqlDataAdapter("select * from tbl_booking where user_name='" + uname + "' order by booking_id desc", con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                rptCustomerBookings.DataSource = ds;
                rptCustomerBookings.DataBind();
                trNoBookings.Visible = false;

                hfBookingId.Value = ds.Tables[0].Rows[0]["booking_id"].ToString();
                hfStationName.Value = ds.Tables[0].Rows[0]["station_name"].ToString();
                hfDurationHours.Value = ds.Tables[0].Rows[0]["duration_hours"].ToString();
                hfTotalAmount.Value = ds.Tables[0].Rows[0]["total_amount"].ToString();
                hfBookingStatus.Value = ds.Tables[0].Rows[0]["status"].ToString();
            }
            else
            {
                da = new SqlDataAdapter("select * from tbl_booking order by booking_id desc", con);
                ds = new DataSet();
                da.Fill(ds);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    rptCustomerBookings.DataSource = ds;
                    rptCustomerBookings.DataBind();
                    trNoBookings.Visible = false;

                    hfBookingId.Value = ds.Tables[0].Rows[0]["booking_id"].ToString();
                    hfStationName.Value = ds.Tables[0].Rows[0]["station_name"].ToString();
                    hfDurationHours.Value = ds.Tables[0].Rows[0]["duration_hours"].ToString();
                    hfTotalAmount.Value = ds.Tables[0].Rows[0]["total_amount"].ToString();
                    hfBookingStatus.Value = ds.Tables[0].Rows[0]["status"].ToString();
                }
                else
                {
                    trNoBookings.Visible = true;
                    hfBookingId.Value = "0";
                    hfStationName.Value = "No Active Station";
                    hfDurationHours.Value = "0";
                    hfTotalAmount.Value = "0";
                    hfBookingStatus.Value = "None";
                }
            }
            con.Close();
        }
    }
}
