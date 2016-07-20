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

namespace eshopv2.administrator
{
    public partial class _default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (User.Identity.IsAuthenticated && User.IsInRole("administrator"))
            {
                getLast10Orders();
                getLast10Users();
                getLast10Products();
                getActivePromotions();
                getTop10AccessProducts();
                getTop10OrderProducts();
            }
            else
                Response.Redirect(Page.ResolveUrl("~/administrator/login.aspx?returnUrl=" + Request.RawUrl));
        }

        private void getLast10Orders()
        {
            dgvOrders.DataSource = new OrderBL().GetLast10();
            dgvOrders.DataBind();
        }

        private void getLast10Users()
        {
            dgvUsers.DataSource = new UserBL().GetLast10();
            dgvUsers.DataBind();
        }

        private void getLast10Products()
        {
            dgvProducts.DataSource = new ProductBL().GetLast10();
            dgvProducts.DataBind();
        }

        private void getActivePromotions()
        {
            dgvPromotions.DataSource = new PromotionBL().GetActive();
            dgvPromotions.DataBind();
        }

        protected void dgvOrders_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if(e.Row.RowType == DataControlRowType.DataRow)
                if(((Label)e.Row.FindControl("lblIsNew")).Text == "1")
                    ((Label)e.Row.FindControl("lblIsNew")).CssClass = "newOrder";
        }

        private void getTop10AccessProducts()
        {
            dgvTopAccessProducts.DataSource = new ProductBL().GetTop10Access();
            dgvTopAccessProducts.DataBind();
        }

        private void getTop10OrderProducts()
        {
            dgvTopOrderProducts.DataSource = new ProductBL().GetTop10Order();
            dgvTopOrderProducts.DataBind();
        }
    }
}
