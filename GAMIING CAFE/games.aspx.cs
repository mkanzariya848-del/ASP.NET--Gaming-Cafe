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
    public partial class GamesPage : System.Web.UI.Page
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
                fillgames("All");
            }
        }

        void fillgames(string platform)
        {
            getcon();
            if (platform == "All")
            {
                da = new SqlDataAdapter("select * from tbl_games", con);
            }
            else
            {
                da = new SqlDataAdapter("select * from tbl_games where platform like '%" + platform + "%'", con);
            }
            ds = new DataSet();
            da.Fill(ds);
            rptGames.DataSource = ds;
            rptGames.DataBind();
            con.Close();
        }

        protected void btnPlatform_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            string platform = btn.CommandArgument;
            fillgames(platform);

            btnAllGames.CssClass = "btn-outline game-cat-btn";
            btnPCGames.CssClass = "btn-outline game-cat-btn";
            btnPS5Games.CssClass = "btn-outline game-cat-btn";
            btnVRGames.CssClass = "btn-outline game-cat-btn";

            btn.CssClass = "btn-cyber game-cat-btn";
        }

        protected void btnGameSearch_Click(object sender, EventArgs e)
        {
            getcon();
            string keyword = txtGameSearch.Text.Trim();
            da = new SqlDataAdapter("select * from tbl_games where game_name like '%" + keyword + "%' or category like '%" + keyword + "%' or platform like '%" + keyword + "%'", con);
            ds = new DataSet();
            da.Fill(ds);
            rptGames.DataSource = ds;
            rptGames.DataBind();
            con.Close();
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            txtGameSearch.Text = "";
            fillgames("All");
            btnAllGames.CssClass = "btn-cyber game-cat-btn";
            btnPCGames.CssClass = "btn-outline game-cat-btn";
            btnPS5Games.CssClass = "btn-outline game-cat-btn";
            btnVRGames.CssClass = "btn-outline game-cat-btn";
        }
    }
}
