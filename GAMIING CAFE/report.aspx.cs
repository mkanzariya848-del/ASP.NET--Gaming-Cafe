using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using System.IO;
using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;
using CrystalDecisions.Web;

namespace GAMIING_CAFE
{
    public partial class ReportPage : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter da;
        DataSet ds;

        ReportDocument cr = new ReportDocument();
        static string Crypath = "";

        string s = ConfigurationManager.ConnectionStrings["mycon"].ConnectionString;

        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        protected void Page_Init(object sender, EventArgs e)
        {
            if (Session["CurrentReport"] != null)
            {
                showReport(Session["CurrentReport"].ToString());
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Page_Unload(object sender, EventArgs e)
        {
            if (cr != null)
            {
                cr.Close();
                cr.Dispose();
            }
        }

        string getQuery(string reportType, out string rptFileName, out string exportTitle)
        {
            switch (reportType.ToLower())
            {
                case "food":
                    rptFileName = "food.rpt";
                    exportTitle = "Cafe_Food_Menu_Report";
                    return "select * from tbl_food";

                case "station":
                    rptFileName = "station.rpt";
                    exportTitle = "Gaming_Stations_Status_Report";
                    return "select s.station_id, s.station_name, isnull(c.cat_name, 'Standard') as cat_name, s.rate_per_hour, s.status from tbl_station s left join tbl_category c on s.cat_id = c.cat_id order by s.station_id asc";

                case "user":
                    rptFileName = "user.rpt";
                    exportTitle = "Registered_Users_Report";
                    return "select user_id, name, email, role from tbl_user order by user_id asc";

                case "games":
                    rptFileName = "games.rpt";
                    exportTitle = "Games_Library_Catalog_Report";
                    return "select game_id, game_name, category, platform from tbl_games order by platform asc, game_name asc";

                case "tournament":
                    rptFileName = "tournament.rpt";
                    exportTitle = "Esports_Tournaments_Report";
                    return "select tour_id, tour_name, game_name, tour_date, entry_fee, prize_pool from tbl_tournament order by tour_id desc";

                case "billing":
                    rptFileName = "billing.rpt";
                    exportTitle = "Daily_Revenue_Billing_Report";
                    return "select booking_id, user_name, station_name, booking_date, time_slot, duration_hours, total_amount, status from tbl_booking where status='Confirmed' order by booking_id desc";

                case "booking":
                default:
                    rptFileName = "booking.rpt";
                    exportTitle = "Station_Bookings_Report";
                    return "select * from tbl_booking order by booking_id desc";
            }
        }

        protected void btn_xml_Click(object sender, EventArgs e)
        {
            string rptFile, title;
            string q = getQuery(drpReport.SelectedValue, out rptFile, out title);

            getcon();
            da = new SqlDataAdapter(q, con);
            ds = new DataSet();
            da.Fill(ds);

            string s = Server.MapPath("~/data.xml");
            ds.WriteXmlSchema(s);

            string dir = Server.MapPath("~/xml_schemas/");
            if (!Directory.Exists(dir))
            {
                Directory.CreateDirectory(dir);
            }
            string specificSchema = Server.MapPath("~/xml_schemas/" + drpReport.SelectedValue + ".xml");
            ds.WriteXmlSchema(specificSchema);

            con.Close();
            Response.Write("<script>alert('XML File Created Successfully for " + title + "');</script>");
        }

        protected void btn_xml_all_Click(object sender, EventArgs e)
        {
            string[] reports = new string[] { "booking", "food", "station", "user", "games", "tournament", "billing" };
            getcon();
            string dir = Server.MapPath("~/xml_schemas/");
            if (!Directory.Exists(dir))
            {
                Directory.CreateDirectory(dir);
            }

            foreach (string r in reports)
            {
                string rptFile, title;
                string q = getQuery(r, out rptFile, out title);
                da = new SqlDataAdapter(q, con);
                ds = new DataSet(r);
                da.Fill(ds);
                string specificSchema = Server.MapPath("~/xml_schemas/" + r + ".xml");
                ds.WriteXmlSchema(specificSchema);
            }

            da = new SqlDataAdapter("select * from tbl_booking", con);
            ds = new DataSet("GamingCafeReports");
            da.Fill(ds);
            ds.WriteXmlSchema(Server.MapPath("~/data.xml"));

            con.Close();
            Response.Write("<script>alert('All 7 XML Schemas Generated Successfully in ~/xml_schemas/ and ~/data.xml');</script>");
        }

        protected void btn_view_Click(object sender, EventArgs e)
        {
            showReport(drpReport.SelectedValue);
        }

        protected void btn_export_Click(object sender, EventArgs e)
        {
            exportReport(drpReport.SelectedValue);
        }

        protected void btnQuickAction_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            string arg = btn.CommandArgument;
            if (arg.EndsWith("_pdf"))
            {
                string rType = arg.Replace("_pdf", "");
                drpReport.SelectedValue = rType;
                exportReport(rType);
            }
            else
            {
                drpReport.SelectedValue = arg;
                showReport(arg);
            }
        }

        void showReport(string reportType)
        {
            Session["CurrentReport"] = reportType;
            string rptFile, title;
            string q = getQuery(reportType, out rptFile, out title);
            string path = Server.MapPath("~/" + rptFile);

            if (!File.Exists(path))
            {
                Response.Write("<script>alert('Report file " + rptFile + " not found!');</script>");
                return;
            }

            getcon();
            da = new SqlDataAdapter(q, con);
            ds = new DataSet();
            da.Fill(ds);
            con.Close();

            try
            {
                if (cr != null)
                {
                    cr.Close();
                    cr.Dispose();
                }
                cr = new ReportDocument();
                cr.Load(path);
                cr.SetDataSource(ds.Tables[0]);
                CrystalReportViewer1.ReportSource = cr;
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Crystal Report: " + ex.Message.Replace("'", "") + "');</script>");
            }
        }

        void exportReport(string reportType)
        {
            string rptFile, title;
            string q = getQuery(reportType, out rptFile, out title);
            string path = Server.MapPath("~/" + rptFile);

            if (!File.Exists(path))
            {
                Response.Write("<script>alert('Report file " + rptFile + " not found! Please create " + rptFile + " in Visual Studio');</script>");
                return;
            }

            getcon();
            da = new SqlDataAdapter(q, con);
            ds = new DataSet();
            da.Fill(ds);

            try
            {
                cr.Load(path);
                cr.SetDataSource(ds.Tables[0]);
                cr.Refresh();
                CrystalReportViewer1.ReportSource = cr;
                cr.ExportToHttpResponse(ExportFormatType.PortableDocFormat, Response, true, title);
            }
            catch (Exception ex)
            {
                if (ex.Message.Contains("has no tables"))
                {
                    Response.Write("<script>alert('Step 4 & 5 Notice: " + rptFile + " has no tables linked yet! Please open " + rptFile + " in Visual Studio -> Database Expert -> select data.xml to add fields.');</script>");
                }
                else
                {
                    Response.Write("<script>alert('Crystal Report: " + ex.Message.Replace("'", "") + "');</script>");
                }
            }
            finally
            {
                con.Close();
            }
        }
    }
}
