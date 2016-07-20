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
using eshopBL;
using eshopBE;

namespace eshopv2.user_controls
{
    public partial class MainMenu : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            rptMainMenu.DataSource = new CategoryBL().GetNestedCategoriesList();
            rptMainMenu.DataBind();
        }

        protected void rptMainMenu_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                if (((Category)e.Item.DataItem).SubCategory != null && ((Category)e.Item.DataItem).SubCategory.Count > 0)
                {
                    ((HtmlControl)e.Item.FindControl("li")).Attributes["class"] = "dropdown";
                    ((HyperLink)e.Item.FindControl("lnkMainMenu")).Attributes["data-toggle"] = "dropdown";
                    ((HyperLink)e.Item.FindControl("lnkMainMenu")).Attributes["class"] = "dropdown-toggle";
                    ((HyperLink)e.Item.FindControl("lnkMainMenu")).Text += "<b class='caret'></b>";
                }
            }
        }
    }
}