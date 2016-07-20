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
using eshopUtilities;

namespace eshopv2.administrator
{
    public partial class promotions : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (User.Identity.IsAuthenticated && User.IsInRole("administrator"))
            {
                if (!Page.IsPostBack)
                {
                    loadPromotions();
                }
            }
            else
                Page.Response.Redirect("/administrator/login.aspx?returnUrl=" + Page.Request.RawUrl.Substring(15, Page.Request.RawUrl.Length - 15));
        }

        private void loadPromotions()
        {
            PromotionBL promotionBL = new PromotionBL();
            dgvPromotions.DataSource = promotionBL.GetPromotions(false, null);
            dgvPromotions.DataBind();
        }

        protected void btnAddPromotion_Click(object sender, EventArgs e)
        {
            Page.Response.Redirect("/administrator/promotion.aspx");
        }

        protected void dgvPromotions_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                PromotionBL promotionBL = new PromotionBL();
                int status = promotionBL.DeletePromotion(int.Parse(dgvPromotions.DataKeys[e.RowIndex].Values[0].ToString()));

                Response.Redirect("/administrator/promotions.aspx");
            }
            catch (BLException ex)
            {
                setStatus(ex.Message, System.Drawing.Color.Red, true);
            }
        }

        private void setStatus(string text, System.Drawing.Color foreColor, bool visible)
        {
            csStatus.Text = text;
            csStatus.ForeColor = foreColor;
            csStatus.Visible = visible;
            csStatus.Show();
        }
    }
}
