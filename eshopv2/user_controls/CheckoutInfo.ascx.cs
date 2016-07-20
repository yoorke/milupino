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
    public partial class CheckoutInfo : System.Web.UI.UserControl
    {
        private DataTable _cart;

        public DataTable CartItems
        {
            set
            {
                _cart = value;
                setValues();
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        private void setValues()
        {
            double cartTotal=0;
            double taxBase = 0;
            double tax = 0;
            double discount = 0;
            double delivery = 0;
            double total = 0;

            for (int i = 0; i < _cart.Rows.Count; i++)
            {
                cartTotal += double.Parse(_cart.Rows[i]["productPrice"].ToString()) * double.Parse(_cart.Rows[i]["quantity"].ToString());
                discount += double.Parse(_cart.Rows[i]["productPrice"].ToString()) * double.Parse(_cart.Rows[i]["quantity"].ToString()) - double.Parse(_cart.Rows[i]["total"].ToString());
            }
            lblNumberOfProducts.Text = _cart.Rows.Count.ToString();

            taxBase = cartTotal / 1.2;
            tax = cartTotal - taxBase;

            delivery = (cartTotal > 10000) ? 0 : 350;

            total = cartTotal - discount + delivery;

            lblTaxBase.Text = string.Format("{0:N2}", taxBase);
            lblPdv.Text = string.Format("{0:N2}", tax);
            lblTotalWithTax.Text = string.Format("{0:N2}", taxBase + tax);
            lblDiscount.Text = string.Format("-{0:N2}", discount);
            lblDelivery.Text = string.Format("{0:N2}", delivery);
            lblTotal.Text = string.Format("{0:N2}", total);
        }

        protected void btnShowCart_Click(object sender, EventArgs e)
        {
            Response.Redirect("/korpa");
        }
    }
}