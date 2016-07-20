using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using eshopBL;
using eshopBE;
using System.Web.UI.HtmlControls;

namespace eshopv2.user_controls
{
    public partial class MainMenuVertical : System.Web.UI.UserControl
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
                    ((HtmlControl)e.Item.FindControl("li")).Attributes["class"] = "has-children";
                }
            }
        }

        protected void rptSubMenu_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                //((CategoryBanner)e.Item.FindControl("categoryBanner1")).CategoryBannerID = (int)((Category)e.Item.DataItem).ParentCategoryID;
                if (((Category)e.Item.DataItem).SubCategory != null && ((Category)e.Item.DataItem).SubCategory.Count > 0)
                {
                    ((HtmlControl)e.Item.FindControl("secondLi")).Attributes["class"] = "has-children";
                    
                }
            }
        }
    }
}