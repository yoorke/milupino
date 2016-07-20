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

namespace eshopv2
{
    public partial class checkout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                loadCheckout();   
            }
            /*eshopBE.User user=null;
            if (User.Identity.IsAuthenticated)
            {
                user = UserBL.GetUser(-1, User.Identity.Name);
                
            }*/
            //checkout1.User = user;
                
        }

        private void loadCheckout()
        {
            CartBL cartBL = new CartBL();
            checkoutInfo1.CartItems = cartBL.GetProducts(Session["cartID"].ToString());
        }
    }
}
