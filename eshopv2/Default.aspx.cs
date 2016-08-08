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

namespace eshopv2
{
    public partial class _Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                loadPromotions();
                loadCategories();

                canonicalUrl.Text = @"<link rel=""canonical"" href=""" + ConfigurationManager.AppSettings["webShopUrl"] + @"""/>";
            }
        }

        private void loadPromotions()
        {
            PromotionBL promotionBL = new PromotionBL();
            //ProductBL productBL = new ProductBL();

            rptPromotions.DataSource = promotionBL.GetPromotions(false, true, null);
            rptPromotions.DataBind();

            //productSlider.NumberOfProducts = 4;
            //ProductBL productBL = new ProductBL();
            //productSlider.Products = productBL.GetProductsForFirstPage(3, 8, "product.name");

            //productSlider1.NumberOfProducts = 4;
            //productSlider1.Products = productBL.GetProductsForFirstPage(3, 8, "product.name");
        }

        private void loadCategories()
        {
            CategoryBL categoryBL = new CategoryBL();
            rptCategories.DataSource = categoryBL.GetCategoriesForFirstPage();
            rptCategories.DataBind();
        }

        protected void rptPromotions_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                //Repeater rptProducts = (Repeater)e.Item.FindControl("rptProducts");
               user_controls.product_slider productSlider = (user_controls.product_slider)e.Item.FindControl("productSlider1");
                ProductBL productBL = new ProductBL();
                productSlider.NumberOfProducts = 6;
                productSlider.Products = productBL.GetProductsForPromotion(int.Parse(((HiddenField)e.Item.FindControl("lblPromotionID")).Value));
                //((HtmlControl)productSlider.FindControl("carouselexample")).Attributes["id"] = "carousel" + ((HiddenField)e.Item.FindControl("lblPromotionID")).Value;
                ((Literal)productSlider.FindControl("lblPrev")).Text = @"<a id=""prev"" runat=""server"" href=" + "#carousel" + ((HiddenField)e.Item.FindControl("lblPromotionID")).Value + @" data-slide=""prev""><img src=" + Page.ResolveUrl("~/images/prev_next.gif") + @" alt=""Prethodni"" /></a>";
                ((Literal)productSlider.FindControl("lblNext")).Text = @"<a id=""next"" runat=""server"" href=" + "#carousel" + ((HiddenField)e.Item.FindControl("lblPromotionID")).Value + @" data-slide=""next"" class=""next_button""><img src=" + Page.ResolveUrl("~/images/prev_next.gif") + @" alt=""Sledeći"" /></a>";
                ((Literal)productSlider.FindControl("lblCarousel")).Text = @"<div id=" + "carousel" + ((HiddenField)e.Item.FindControl("lblPromotionID")).Value + @" class=""carousel slide"" data-ride="""" runat=""server"">";
                //rptProducts.DataSource = productBL.GetProductsForPromotion(int.Parse(((HiddenField)e.Item.FindControl("lblPromotionID")).Value));
                //rptProducts.DataBind();
            }
        }

        protected void rptCategories_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                //Repeater rptProducts = (Repeater)e.Item.FindControl("rptCategoryProducts");
                user_controls.product_slider productSlider = (user_controls.product_slider)e.Item.FindControl("productSlider2");
                ProductBL productBL = new ProductBL();
                productSlider.NumberOfProducts = 6;
                productSlider.Products = productBL.GetProductsForFirstPage(int.Parse(((HiddenField)e.Item.FindControl("lblCategoryID")).Value), 8, "Slučajni");
                //((HtmlControl)productSlider.FindControl("prev")).Attributes.Add("href", Page.ResolveUrl("~/#carousel" + ((HiddenField)e.Item.FindControl("lblCategoryID")).Value));
                //((HtmlControl)productSlider.FindControl("prev")).Attributes["href"] = ((HtmlControl)productSlider.FindControl("prev")).Attributes["href"].Remove(0, 1);
                //((HtmlControl)productSlider.FindControl("next")).Attributes["href"] = "carousel" + ((HiddenField)e.Item.FindControl("lblCategoryID")).Value;
                ((HtmlControl)productSlider.FindControl("carouselexample")).Attributes["id"] = "carousel" + ((HiddenField)e.Item.FindControl("lblCategoryID")).Value;
                ((Literal)productSlider.FindControl("lblPrev")).Text=@"<a id=""prev"" runat=""server"" href=" + "#carousel" + ((HiddenField)e.Item.FindControl("lblCategoryID")).Value + @" data-slide=""prev""><img src=" + Page.ResolveUrl("~/images/prev_next.gif") + @" alt=""Prethodni"" /></a>";
                ((Literal)productSlider.FindControl("lblNext")).Text = @"<a id=""next"" runat=""server"" href=" + "#carousel" + ((HiddenField)e.Item.FindControl("lblCategoryID")).Value + @" data-slide=""next"" class=""next_button"" ><img src=" + Page.ResolveUrl("~/images/prev_next.gif") + @" alt=""Sledeći"" /></a>";
                ((Literal)productSlider.FindControl("lblCarousel")).Text=@"<div id=" + "carousel" + ((HiddenField)e.Item.FindControl("lblCategoryID")).Value + @" class=""carousel slide"" data-ride="""" runat=""server"">";
                //rptProducts.DataSource = productBL.GetProductsForFirstPage(int.Parse(((HiddenField)e.Item.FindControl("lblCategoryID")).Value), int.Parse(((HiddenField)e.Item.FindControl("lblNumberOfProducts")).Value), ((HiddenField)e.Item.FindControl("lblFirstPageOrderBy")).Value);
                //rptProducts.DataBind();
            }
        }
    }
}
