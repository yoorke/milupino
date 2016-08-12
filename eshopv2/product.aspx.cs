using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Xml.Linq;
using eshopBE;
using eshopBL;
using System.Collections.Generic;
using System.Text;
using System.Web.Services;

namespace eshopv2
{
    public partial class product : System.Web.UI.Page
    {
        /*private List<string> images
        {
            get{if(ViewState["images"]!=null)
                return (List<string>)ViewState["images"];
            else
                return null;
            }
            set { ViewState["images"] = value; }
        }*/

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                //string productName = (Page.Request.QueryString.ToString().Contains("productID")) ? Page.Request.QueryString["productID"] : string.Empty;
                string productName = Page.RouteData.Values["product"] != null ? Page.RouteData.Values["product"].ToString() : string.Empty;

                if (productName != string.Empty)
                {
                    StringBuilder sb = new StringBuilder();
                    for (int i = productName.Length - 1; i > 0; i--)
                        if (productName[i] == '-')
                            break;
                        else
                            if (char.IsDigit(productName[i]))
                                sb.Insert(0, productName[i]);

                    int productID;
                    int.TryParse(sb.ToString(), out productID);
                    loadProduct(productID);
                    
                }
            }
            else
            {
                //priProductImages.Images = images;
                Page.Title = ViewState["pageTitle"].ToString();
                
            }
            lblProductFacebookLike.InnerHtml = "<div class='fb-like' data-href='http://www.milupino.rs" + Page.Request.RawUrl + "' data-width='100' data-layout='button_count' data-action='like' data-show-faces='true' data-share='true'></div>";
            createProductTags();
            canonicalUrl.Text = @"<link rel=""canonical"" href=""" + ConfigurationManager.AppSettings["webShopUrl"] + ViewState["productUrl"] + @"""/>";
        }

        private void loadProduct(int productID)
        {
            ProductBL productBL = new ProductBL();
            Product product = productBL.GetProduct(productID, string.Empty, true);

            //images = product.Images;
            priProductImages.Images = product.Images;
            priProductImages.ShowImages();

            lblBrand.Text = product.Brand.Name;
            lblName.Text = product.Name;
            lblNamePrimary.Text = product.Name;
            lblDescription.Text = product.Description;
            lblPrice.Text = "MP cena: " + string.Format("{0:N2}", product.Price) + " din";
            lblWebPrice.Text = (product.Promotion == null) ? string.Format("{0:N2}", product.WebPrice) + " din" : string.Format("{0:N2}", product.Promotion.Price) + " din";
            lblSaving.Text = "Ušteda: " + string.Format("{0:N2}", product.Price - double.Parse(lblWebPrice.Text.Substring(0, lblWebPrice.Text.IndexOf(" din")))) + " din";
            lblSpecification.Text = (product.Specification != null) ? (!product.Specification.Contains("<table class='table table-striped'><tbody></table>") ? product.Specification : "Nema podataka") : "Nema podataka";
            lblDescription.Text = product.Description;
            if (product.Promotion != null)
            {
                imgPromotion.ImageUrl = "/images/" + product.Promotion.ImageUrl;
                imgPromotion.Visible = true;
            }
            lblProductID.Value = product.ProductID.ToString();
            Page.Title = product.Brand.Name + " " + product.Name;
            ViewState.Add("pageTitle", Page.Title);
            ViewState.Add("productDescription", product.Description);
            ViewState.Add("image", product.Images != null ? product.Images[0] : string.Empty);

            lnkCategory.NavigateUrl = "/proizvodi/" + product.Categories[0].Url;
            lnkCategory.Text = product.Categories[0].Name;
            ViewState["productUrl"] = product.Url;
            loadProductSliders(product.Brand, product.Categories[0]);
        }

        protected void btnCart_Click(object sender, EventArgs e)
        {
            CartBL cartBL = new CartBL();
            cartBL.AddProductToCart(int.Parse(lblProductID.Value), Session["cartID"].ToString(), 1, double.Parse(lblWebPrice.Text.Substring(0, lblWebPrice.Text.IndexOf(" din"))), double.Parse(lblWebPrice.Text.Substring(0, lblWebPrice.Text.IndexOf(" din"))));
            Response.Redirect("/korpa");
        }

        protected void btnCompare_Click(object sender, EventArgs e)
        {

        }

        

        private void createProductTags()
        {
            HtmlMeta tag = new HtmlMeta();
            tag.Attributes.Clear();
            tag.Attributes.Add("property", "fb:admins");
            tag.Attributes.Add("content", "");
            Header.Controls.Add(tag);

            tag = new HtmlMeta();
            tag.Attributes.Clear();
            tag.Attributes.Add("property", "og:title");
            tag.Attributes.Add("content", (ViewState["pageTitle"] != null ? ViewState["pageTitle"].ToString(): string.Empty) + " " + (ViewState["productDescription"] != null ? ViewState["productDescription"].ToString() : string.Empty));
            Header.Controls.Add(tag);

            tag = new HtmlMeta();
            tag.Attributes.Clear();
            tag.Attributes.Add("property", "og:type");
            tag.Attributes.Add("content", "product");
            Header.Controls.Add(tag);

            tag = new HtmlMeta();
            tag.Attributes.Clear();
            tag.Attributes.Add("property", "og:url");
            tag.Attributes.Add("content", "http://www.milupino.rs" + Page.Request.RawUrl);
            Header.Controls.Add(tag);

            tag = new HtmlMeta();
            tag.Attributes.Clear();
            tag.Attributes.Add("property", "og:image");
            tag.Attributes.Add("content", "http://www.milupino.rs" + ViewState["image"] != null ? ViewState["image"].ToString() : string.Empty);
            Header.Controls.Add(tag);

            tag = new HtmlMeta();
            tag.Attributes.Clear();
            tag.Attributes.Add("property", "og:site_name");
            tag.Attributes.Add("content", "Milupino | Vaša online prodavnica");
            Header.Controls.Add(tag);

            tag = new HtmlMeta();
            tag.Attributes.Clear();
            tag.Attributes.Add("property", "og:description");
            tag.Attributes.Add("content", string.Empty);
            Header.Controls.Add(tag);

            HtmlLink link = new HtmlLink();
            link.Attributes.Add("rel", "canonical");
            link.Attributes.Add("href", "http://www.milupino.rs" + Page.Request.RawUrl);
            Header.Controls.Add(link);
        }

        private void loadProductSliders(Brand brand, Category category)
        {
            sliderBrand.NumberOfProducts = 6;
            //sliderBrand.Products = new ProductBL().GetProducts(-1, -1, string.Empty, string.Empty, brand.BrandID);
            sliderBrand.Products = new ProductBL().GetProductsForFirstPage(-1, brand.BrandID, 12, "Slučajni");
            sliderBrand.Name = "Ostali proizvodi kompanije " + brand.Name;
            ((Literal)sliderBrand.FindControl("lblPrev")).Text = @"<a id=""prev"" runat=""server"" href=""#carouselBrand"" data-slide=""prev""><img src=" + Page.ResolveUrl("~/images/prev_next.gif") + @" alt=""Prethodni"" /></a>";
            ((Literal)sliderBrand.FindControl("lblNext")).Text = @"<a id=""next"" runat=""server"" href=""#carouselBrand"" data-slide=""next"" class=""next_button""><img src=" + Page.ResolveUrl("~/images/prev_next.gif") + @" alt=""Sledeći"" /></a>";
            ((Literal)sliderBrand.FindControl("lblCarousel")).Text = @"<div id=""carouselBrand"" class=""carousel slide"" data-ride="""" runat=""server"">";
            ((Literal)sliderBrand.FindControl("lblCarouselClose")).Text = "</div>";

            sliderCategory.NumberOfProducts = 6;
            //sliderCategory.Products = new ProductBL().GetProductsForCategory(category.CategoryID, true, true);
            sliderCategory.Products = new ProductBL().GetProductsForFirstPage(category.CategoryID, -1, 12, "Slučajni");
            sliderCategory.Name = category.Name;
            ((Literal)sliderCategory.FindControl("lblPrev")).Text = @"<a id=""prev"" runat=""server"" href=""#carouselCategory"" data-slide=""prev""><img src=" + Page.ResolveUrl("~/images/prev_next.gif") + @" alt=""Prethodni"" /></a>";
            ((Literal)sliderCategory.FindControl("lblNext")).Text = @"<a id=""next"" runat=""server"" href=""#carouselCategory"" data-slide=""next"" class=""next_button""><img src=" + Page.ResolveUrl("~/images/prev_next.gif") + @" alt=""Sledeći"" /></a>";
            ((Literal)sliderCategory.FindControl("lblCarousel")).Text = @"<div id=""carouselCategory"" class=""carousel slide"" data-ride="""" runat=""server"">";
            ((Literal)sliderCategory.FindControl("lblCarouselClose")).Text = "</div>";
        }
    }
}
