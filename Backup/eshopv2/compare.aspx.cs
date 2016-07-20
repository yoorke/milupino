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
using eshopBE;
using eshopBL;
using System.Collections.Generic;

namespace eshopv2
{
    public partial class compare : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                string[] productList;
                if (Page.Request.QueryString.ToString().Contains("productList"))
                {
                    if (Page.Request.QueryString["productList"] != null)
                    {
                        productList = Page.Request.QueryString["productList"].Split('-');
                        showProducts(productList);
                    }
                }

            }
        }

        private void showProducts(string[] productList)
        {
            List<int> productsID = (List<int>)Session["compare"];
            List<Product> products = new List<Product>();
            if (productsID != null)
            {
                for (int i = 0; i < productsID.Count; i++)
                {
                    products.Add(new ProductBL().GetProduct(productsID[i], string.Empty));
                }

                rptProducts.DataSource = products;
                rptProducts.DataBind();
            }
        }
    }
}
