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
using System.Collections.Generic;
using eshopBE;

namespace eshopv2.user_controls
{
    public partial class product_slider : System.Web.UI.UserControl
    {
        private List<Product> _products;
        private int _numberOfProducts;
        private int _slidesCount;

        public List<Product> Products
        {
            get { return _products; }
            set
            {
                _products = value;
                setValues();
            }
        }

        public int NumberOfProducts
        {
            get { return _numberOfProducts; }
            set { _numberOfProducts = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        private void setValues()
        {
            _slidesCount = 0;
            if (_products != null)
            {
                int numberOfSlides = _products.Count / _numberOfProducts;
                List<List<Product>> slides = new List<List<Product>>();
                int count = 0;
                while (_products.Count > 0)
                {
                    if (count == 0)
                        slides.Add(new List<Product>());
                    slides[slides.Count - 1].Add(_products[0]);
                    _products.RemoveAt(0);
                    if (++count == _numberOfProducts)
                        count = 0;
                }

                rptSlides.DataSource = slides;
                rptSlides.DataBind();
            }
        }

        protected void rptSlides_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                if (_slidesCount++ == 0)
                {
                    HtmlControl divHeader = (HtmlControl)e.Item.FindControl("divHeader");
                    divHeader.Attributes["class"] = "item active";
                }
                Repeater rptProducts = (Repeater)e.Item.FindControl("rptProducts");
                rptProducts.DataSource = e.Item.DataItem;
                rptProducts.DataBind();
            }
        }
    }
}