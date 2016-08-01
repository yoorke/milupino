using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using eshopBE;
using eshopBL;

namespace eshopv2
{
    public partial class promotion : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!Page.IsPostBack)
            {
                //if(Page.Request.QueryString.ToString().Contains("akcija"))
                if(Page.RouteData.Values["url"] != null)
                {
                    //string url = Page.Request.QueryString["akcija"].ToString();
                    string url = Page.RouteData.Values["url"].ToString();
                    loadPromotion(url);
                }
            }
        }

        private void loadPromotion(string url)
        {
            Promotion promotion = new PromotionBL().GetPromotion(url);
            rptProducts.DataSource = new ProductBL().GetProductsForPromotion(promotion.PromotionID);
            rptProducts.DataBind();
            lblPromotionName.Text = promotion.Name;
        }
    }
}