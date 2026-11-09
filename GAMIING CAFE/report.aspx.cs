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

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btn_xml_Click(object sender, EventArgs e)
        {
            getcon();
            if (drpReport.SelectedValue == "booking")
            {
                da = new SqlDataAdapter("select * from tbl_booking", con);
            }
            else
            {
                da = new SqlDataAdapter("select * from tbl_food", con);
            }
            ds = new DataSet();
            da.Fill(ds);
            string s = Server.MapPath("~/data.xml");
            ds.WriteXmlSchema(s);
            con.Close();
            Response.Write("<script>alert('XML File Created Successfully');</script>");
        }

        protected void btn_view_Click(object sender, EventArgs e)
        {
            string path = "";
            getcon();
            if (drpReport.SelectedValue == "booking")
            {
                path = Server.MapPath("~/booking.rpt");
                da = new SqlDataAdapter("select * from tbl_booking", con);
            }
            else
            {
                path = Server.MapPath("~/product.rpt");
                da = new SqlDataAdapter("select * from tbl_food", con);
            }

            if (!File.Exists(path))
            {
                con.Close();
                Response.Write("<script>alert('Report file not found! Please create " + Path.GetFileName(path) + " in Visual Studio');</script>");
                return;
            }

            ds = new DataSet();
            da.Fill(ds);
            cr.Load(path);
            cr.SetDataSource(ds.Tables[0]);
            cr.Refresh();
            CrystalReportViewer1.ReportSource = cr;
            con.Close();
        }

        protected void btn_export_Click(object sender, EventArgs e)
        {
            string path = "";
            string fname = "Products";
            getcon();
            if (drpReport.SelectedValue == "booking")
            {
                path = Server.MapPath("~/booking.rpt");
                fname = "Bookings";
                da = new SqlDataAdapter("select * from tbl_booking", con);
            }
            else
            {
                path = Server.MapPath("~/product.rpt");
                fname = "Products";
                da = new SqlDataAdapter("select * from tbl_food", con);
            }

            if (!File.Exists(path))
            {
                con.Close();
                Response.Write("<script>alert('Report file not found! Please create " + Path.GetFileName(path) + " in Visual Studio');</script>");
                return;
            }

            ds = new DataSet();
            da.Fill(ds);
            cr.Load(path);
            cr.SetDataSource(ds.Tables[0]);
            cr.Refresh();
            CrystalReportViewer1.ReportSource = cr;
            cr.ExportToHttpResponse(ExportFormatType.PortableDocFormat, Response, true, fname);
            con.Close();
        }
    }
}
