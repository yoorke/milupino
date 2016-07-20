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
using eshopBL;

namespace eshopv2
{
    public partial class login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ((TextBox)login1.FindControl("UserName")).Focus();

            string returnUrl = Request.QueryString.ToString().Contains("returnUrl") ? Request.QueryString["returnUrl"] : string.Empty;
            if (returnUrl != string.Empty)
                login1.DestinationPageUrl = returnUrl;
            else login1.DestinationPageUrl = "~/";

            canonicalUrl.Text = @"<link rel=""canonical"" href=""" + ConfigurationManager.AppSettings["webShopUrl"] + "/prijava" + @"""/>";
        }

        protected void login1_LoginError(object sender, EventArgs e)
        {
            if(new UserBL().UserExists(((TextBox)login1.FindControl("UserName")).Text))
                divLoginMessage.Visible = true;
        }

        protected void lnkPasswordReset_Click(object sender, EventArgs e)
        {
            //if (new UserBL().CreatePasswordResetToken(((TextBox)login1.FindControl("UserName")).Text))
                //Server.Transfer("/passwordResetMailSent.aspx");
            Response.Redirect("/passwordResetRequest.aspx");
        }
    }
}
