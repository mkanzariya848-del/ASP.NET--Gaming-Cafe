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
        SqlDataAdapter da;
        DataSet ds;

        ReportDocument cr = new ReportDocument();

        string s = ConfigurationManager.ConnectionStrings["dbcon"].ConnectionString;

        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        protected void Page_Init(object sender, EventArgs e)
        {
            if (Session["CurrentReport"] != null)
            {
                bindCrystalOnly(Session["CurrentReport"].ToString());
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string initial = "booking";
                if (Session["CurrentReport"] != null)
                {
                    initial = Session["CurrentReport"].ToString();
                }
                drpReport.SelectedValue = initial;
                showReport(initial);
            }
        }

        string getQuery(string reportType, out string rptFileName, out string exportTitle, out string displayName, out string tableName)
        {
            switch (reportType.ToLower())
            {
                case "food":
                    rptFileName = "food.rpt";
                    exportTitle = "Cafe_Food_Menu_Report";
                    displayName = "2. Cafe Food & Beverages Menu";
                    tableName = "tbl_food";
                    return "select food_id, food_name, category, price from tbl_food order by category asc, food_name asc";

                case "station":
                    rptFileName = "station.rpt";
                    exportTitle = "Gaming_Stations_Status_Report";
                    displayName = "3. Gaming Stations & Hardware Status";
                    tableName = "tbl_station";
                    return "select s.station_id, s.station_name, isnull(c.cat_name, 'Standard') as cat_name, s.rate_per_hour, s.status from tbl_station s left join tbl_category c on s.cat_id = c.cat_id order by s.station_id asc";

                case "user":
                    rptFileName = "user.rpt";
                    exportTitle = "Registered_Users_Report";
                    displayName = "4. Registered Users & Members Directory";
                    tableName = "tbl_user";
                    return "select user_id, name, email, role from tbl_user order by user_id asc";

                case "games":
                    rptFileName = "games.rpt";
                    exportTitle = "Games_Library_Catalog_Report";
                    displayName = "5. Games Library Catalog";
                    tableName = "tbl_games";
                    return "select game_id, game_name, category, platform from tbl_games order by platform asc, game_name asc";

                case "tournament":
                    rptFileName = "tournament.rpt";
                    exportTitle = "Esports_Tournaments_Report";
                    displayName = "6. Esports Tournaments & Championships";
                    tableName = "tbl_tournament";
                    return "select tour_id, tour_name, game_name, tour_date, entry_fee, prize_pool from tbl_tournament order by tour_id desc";

                case "billing":
                    rptFileName = "billing.rpt";
                    exportTitle = "Daily_Revenue_Billing_Report";
                    displayName = "7. Confirmed Bookings & Revenue Summary";
                    tableName = "tbl_booking (Confirmed)";
                    return "select booking_id, user_name, station_name, booking_date, time_slot, duration_hours, total_amount, status from tbl_booking where status='Confirmed' order by booking_id desc";

                case "booking":
                default:
                    rptFileName = "booking.rpt";
                    exportTitle = "Station_Bookings_Report";
                    displayName = "1. Station Bookings Report";
                    tableName = "tbl_booking";
                    return "select booking_id, user_name, station_name, booking_date, time_slot, duration_hours, total_amount, status from tbl_booking order by booking_id desc";
            }
        }

        protected void btn_xml_Click(object sender, EventArgs e)
        {
            string rptFile, title, dName, tName;
            string q = getQuery(drpReport.SelectedValue, out rptFile, out title, out dName, out tName);

            getcon();
            da = new SqlDataAdapter(q, con);
            ds = new DataSet();
            da.Fill(ds);

            string sPath = Server.MapPath("~/data.xml");
            ds.WriteXmlSchema(sPath);

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
                string rptFile, title, dName, tName;
                string q = getQuery(r, out rptFile, out title, out dName, out tName);
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

        protected void btnCurrentPdf_Click(object sender, EventArgs e)
        {
            string current = Session["CurrentReport"] != null ? Session["CurrentReport"].ToString() : drpReport.SelectedValue;
            exportReport(current);
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
            string rptFile, title, displayName, tableName;
            string q = getQuery(reportType, out rptFile, out title, out displayName, out tableName);
            string path = Server.MapPath("~/" + rptFile);

            getcon();
            da = new SqlDataAdapter(q, con);
            ds = new DataSet();
            da.Fill(ds);
            con.Close();

            // 1. Bind the Live Data Table (GridView) immediately
            gvReportData.DataSource = ds.Tables[0];
            gvReportData.DataBind();

            // 2. Update Header Titles & Badges
            lblReportHeading.InnerText = displayName;
            lblReportSub.InnerText = "Database Table: " + tableName + " | Crystal Report: " + rptFile + " | " + ds.Tables[0].Rows.Count + " Records Loaded";

            // 3. Bind Crystal Report Viewer
            if (File.Exists(path))
            {
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
                    System.Diagnostics.Debug.WriteLine("CrystalReportViewer error: " + ex.Message);
                }
            }

            // 4. Smooth scroll to table view so user immediately sees their data
            ClientScript.RegisterStartupScript(this.GetType(), "scrollToTable",
                "setTimeout(function() { var el = document.getElementById('reportDisplayArea'); if (el) el.scrollIntoView({ behavior: 'smooth', block: 'start' }); }, 150);", true);
        }

        void bindCrystalOnly(string reportType)
        {
            string rptFile, title, displayName, tableName;
            string q = getQuery(reportType, out rptFile, out title, out displayName, out tableName);
            string path = Server.MapPath("~/" + rptFile);

            if (File.Exists(path))
            {
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
                    System.Diagnostics.Debug.WriteLine("bindCrystalOnly error: " + ex.Message);
                }
            }
        }

        void exportReport(string reportType)
        {
            string rptFile, title, displayName, tableName;
            string q = getQuery(reportType, out rptFile, out title, out displayName, out tableName);
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

            try
            {
                cr.Load(path);
                cr.SetDataSource(ds.Tables[0]);
                cr.Refresh();
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

        protected void gvReportData_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.Header)
            {
                for (int i = 0; i < e.Row.Cells.Count; i++)
                {
                    e.Row.Cells[i].Text = formatColumnName(e.Row.Cells[i].Text);
                }
            }
            else if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DataRowView drv = e.Row.DataItem as DataRowView;
                if (drv != null)
                {
                    for (int i = 0; i < e.Row.Cells.Count && i < drv.DataView.Table.Columns.Count; i++)
                    {
                        string colName = drv.DataView.Table.Columns[i].ColumnName.ToLower();
                        string val = drv[i].ToString();

                        if (colName.EndsWith("_id") || colName == "id")
                        {
                            e.Row.Cells[i].Text = "<span class=\"badge-id\">#" + Server.HtmlEncode(val) + "</span>";
                        }
                        else if (colName == "status")
                        {
                            if (val.Equals("Confirmed", StringComparison.OrdinalIgnoreCase) ||
                                val.Equals("Available", StringComparison.OrdinalIgnoreCase) ||
                                val.Equals("Active", StringComparison.OrdinalIgnoreCase))
                            {
                                e.Row.Cells[i].Text = "<span class=\"badge-status badge-status-confirmed\"><i class=\"fa-solid fa-circle-check\"></i> " + Server.HtmlEncode(val) + "</span>";
                            }
                            else
                            {
                                e.Row.Cells[i].Text = "<span class=\"badge-status badge-status-pending\"><i class=\"fa-solid fa-clock\"></i> " + Server.HtmlEncode(val) + "</span>";
                            }
                        }
                        else if (colName == "role")
                        {
                            if (val.Equals("Admin", StringComparison.OrdinalIgnoreCase))
                            {
                                e.Row.Cells[i].Text = "<span class=\"badge-status badge-status-admin\"><i class=\"fa-solid fa-shield-halved\"></i> Admin</span>";
                            }
                            else
                            {
                                e.Row.Cells[i].Text = "<span class=\"badge-status\" style=\"background: rgba(59, 130, 246, 0.15); color: #60a5fa; border: 1px solid rgba(59, 130, 246, 0.3);\">" + Server.HtmlEncode(val) + "</span>";
                            }
                        }
                        else if (colName.Contains("price") || colName.Contains("amount") || colName.Contains("rate") || colName.Contains("fee") || colName.Contains("pool"))
                        {
                            if (decimal.TryParse(val, out decimal amt))
                            {
                                e.Row.Cells[i].Text = "<strong>₹ " + amt.ToString("N2") + "</strong>";
                            }
                            else
                            {
                                e.Row.Cells[i].Text = "₹ " + Server.HtmlEncode(val);
                            }
                        }
                        else if (colName.Contains("date"))
                        {
                            if (DateTime.TryParse(val, out DateTime dt))
                            {
                                e.Row.Cells[i].Text = dt.ToString("dd-MMM-yyyy");
                            }
                        }
                    }
                }
            }
        }

        string formatColumnName(string raw)
        {
            switch (raw.ToLower())
            {
                case "booking_id": return "Booking ID";
                case "user_name": return "Customer Name";
                case "station_name": return "Gaming Station";
                case "booking_date": return "Booking Date";
                case "time_slot": return "Time Slot";
                case "duration_hours": return "Duration (Hrs)";
                case "total_amount": return "Total Amount";
                case "status": return "Status";
                case "food_id": return "Food ID";
                case "food_name": return "Food Item Name";
                case "category": return "Category";
                case "price": return "Price";
                case "station_id": return "Station ID";
                case "cat_name": return "Station Category";
                case "rate_per_hour": return "Rate / Hr";
                case "user_id": return "User ID";
                case "name": return "Full Name";
                case "email": return "Email Address";
                case "role": return "User Role";
                case "game_id": return "Game ID";
                case "game_name": return "Game Title";
                case "platform": return "Platform";
                case "tour_id": return "Tournament ID";
                case "tour_name": return "Tournament Name";
                case "tour_date": return "Tournament Date";
                case "entry_fee": return "Entry Fee";
                case "prize_pool": return "Prize Pool";
                default:
                    return System.Globalization.CultureInfo.CurrentCulture.TextInfo.ToTitleCase(raw.Replace("_", " "));
            }
        }
    }
}
