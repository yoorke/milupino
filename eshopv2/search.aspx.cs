using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using eshopBL;

namespace eshopv2
{
    public partial class search : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                string searchString = string.Empty;
                if (Request.QueryString.ToString().Contains("a="))
                {
                    searchString = Request.QueryString["a"].ToString();
                    lblHeading.Text = "Pretraga: " + searchString;
                    searchProducts(searchString);
                }
            }
        }

        private void searchProducts(string searchString)
        {
            rptProducts.DataSource = new ProductBL().SearchProducts(searchString);
            rptProducts.DataBind();
        }
    }
}