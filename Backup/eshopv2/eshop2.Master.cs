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
    public partial class eshop : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            loadFooter();
            Page.Header.DataBind();

            if (HttpContext.Current.User.Identity.IsAuthenticated)
                ((Label)loginView1.FindControl("lblUsername")).Text = Membership.GetUser().UserName;
        }

        private void loadFooter()
        {
            rptFt1.DataSource = new CustomPageBL().GetCustomPagesForCustomPageCategory(1);
            rptFt1.DataBind();

            rptFt2.DataSource = new CustomPageBL().GetCustomPagesForCustomPageCategory(2);
            rptFt2.DataBind();

            rptFt3.DataSource = new CustomPageBL().GetCustomPagesForCustomPageCategory(3);
            rptFt3.DataBind();
        }

        protected override void Render(HtmlTextWriter writer)
        {
            CartBL cartBL = new CartBL();
            lblProductCount.Text = cartBL.GetProductsCount(Session["cartID"].ToString()).ToString();
            lblCartPrice.Text = string.Format("{0:N2}", cartBL.GetTotal(Session["cartID"].ToString()));
            base.Render(writer);

            
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            FormsAuthentication.SignOut();
            //Response.Redirect("~/");
            Response.Redirect(Request.RawUrl);
        }
    }
}
