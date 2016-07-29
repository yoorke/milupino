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
using eshopBE;
using eshopUtilities;

namespace eshopv2.administrator
{
    public partial class promotion : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (User.Identity.IsAuthenticated && User.IsInRole("administrator"))
            {
                if (!Page.IsPostBack)
                {
                    int promotionID = 0;
                    if (Request.QueryString.ToString().Contains("promotionID"))
                    {
                        promotionID = int.Parse(Request.QueryString["promotionID"]);
                        loadPromotion(promotionID);
                    }
                }
                else
                    Page.Title = (ViewState["pageTitle"] != null) ? ViewState["pageTitle"].ToString() : "Unos promocije";
            }
            else
                Page.Response.Redirect("/administrator/login.aspx?returnUrl=" + Page.Request.RawUrl.Substring(15, Page.Request.RawUrl.Length - 15));
        }

        private void loadPromotion(int promotionID)
        {
            PromotionBL promotionBL = new PromotionBL();
            Promotion promotion = promotionBL.GetPromotion(promotionID);

            lblPromotionID.Value = promotionID.ToString();
            txtName.Text = promotion.Name;
            txtValue.Text = promotion.Value.ToString();
            imgPromotion.ImageUrl = "/images/" + promotion.ImageUrl;
            chkShowOnFirstPage.Checked = promotion.ShowOnFirstPage;
            txtImageUrl.Text = promotion.ImageUrl;
            txtDateFrom.Text = promotion.DateFrom.ToString();
            txtDateTo.Text = promotion.DateTo.ToString();
            Page.Title = promotion.Name;
            ViewState["pageTitle"] = promotion.Name;
            txtUrl.Text = promotion.Url;
        }

        private void savePromotion()
        {
            try
            {
                Promotion promotion = new Promotion();
                promotion.Name = txtName.Text;
                promotion.Value = double.Parse(txtValue.Text);
                promotion.ImageUrl = txtImageUrl.Text;
                promotion.ShowOnFirstPage = chkShowOnFirstPage.Checked;
                promotion.DateFrom = DateTime.Parse(txtDateFrom.Text).ToUniversalTime();
                promotion.DateTo = DateTime.Parse(txtDateTo.Text).ToUniversalTime();
                if (lblPromotionID.Value != string.Empty)
                    promotion.PromotionID = int.Parse(lblPromotionID.Value);
                promotion.Url = txtUrl.Text;

                PromotionBL promotionBL = new PromotionBL();
                promotionBL.SavePromotion(promotion);
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

        protected void btnSave_Click(object sender, EventArgs e)
        {
            savePromotion();
        }

        protected void btnSaveClose_Click(object sender, EventArgs e)
        {
            savePromotion();
            Response.Redirect("/administrator/promotions.aspx");
        }

        protected void btnClose_Click(object sender, EventArgs e)
        {
            Response.Redirect("/administrator/promotions.aspx");
        }

        protected void btnImageUpload_Click(object sender, EventArgs e)
        {
            if (fluImage.HasFile)
            {
                fluImage.SaveAs(Server.MapPath("~") + "/images/" + fluImage.FileName);
                imgPromotion.ImageUrl = "/images/" + fluImage.FileName;
                txtImageUrl.Text = fluImage.FileName;
            }
        }
    }
}
