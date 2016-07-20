using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;

namespace eshopv2.user_controls
{
    public partial class Pager : System.Web.UI.UserControl
    {
        public delegate void ChangePage(int currentPage);
        public event ChangePage OnClick;

        private string _cssClass;
        private int _totalPages;

        private PagedDataSource _pagedDataSource;

        public string CssClass
        {
            get { return _cssClass; }
            set { _cssClass = value; }
        }

        public int currentPage
        {
            get
            {
                if (ViewState["currentPage"] != null)
                    return int.Parse(ViewState["currentPage"].ToString());
                else return 0;
            }
            set { ViewState["currentPage"] = value; }
        }

        private int firstIndex
        {
            get
            {
                if (ViewState["firstIndex"] != null)
                    return int.Parse(ViewState["firstIndex"].ToString());
                else return 0;
            }
            set { ViewState["firstIndex"] = value; }
        }

        private int lastIndex
        {
            get
            {
                if (ViewState["lastIndex"] != null)
                    return int.Parse(ViewState["lastIndex"].ToString());
                else return 0;
            }
            set { ViewState["lastIndex"] = value; }
        }

        public int TotalPages { set { _totalPages = value; } }

        public PagedDataSource DataSource
        {
            get { return _pagedDataSource; }
            set { _pagedDataSource = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void rptPaging_ItemCommand(object sender, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "paging")
            {
                currentPage = int.Parse(e.CommandArgument.ToString());
                if (OnClick != null)
                    OnClick(currentPage);
            }
        }

        protected void rptPaging_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                LinkButton lnkPage = (LinkButton)e.Item.FindControl("lnkPage");
                if (lnkPage.CommandArgument.ToString() == currentPage.ToString())
                {
                    lnkPage.Enabled = false;
                    lnkPage.Font.Bold = true;
                }
            }
        }

        public void doPaging()
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("PageIndex");
            dt.Columns.Add("PageText");

            firstIndex = currentPage - 5;

            if (currentPage > 5)
                lastIndex = currentPage + 5;
            else
                lastIndex = 10;

            if (lastIndex > _totalPages)
            {
                lastIndex = _totalPages;
                firstIndex = lastIndex - 10;
            }

            if (firstIndex < 0)
                firstIndex = 0;

            for (int i = firstIndex; i < lastIndex; i++)
            {
                DataRow dr = dt.NewRow();
                dr[0] = i;
                dr[1] = i + 1;
                dt.Rows.Add(dr);
            }

            rptPaging.DataSource = dt;
            rptPaging.DataBind();
        }
    }
}