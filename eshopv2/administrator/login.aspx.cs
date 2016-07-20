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

namespace eshopv2.administrator
{
    public partial class login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string returnUrl = (Page.Request.QueryString.ToString().Contains("returnUrl")) ? Page.Request.QueryString["returnUrl"] : string.Empty;

            Login1.DestinationPageUrl = returnUrl;
            Login1.Focus();
        }

        protected void Login1_LoggedIn(object sender, EventArgs e)
        {
            //Response.Redirect("/administrator");
        }
    }
}
