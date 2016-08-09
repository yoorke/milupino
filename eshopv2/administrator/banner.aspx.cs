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
using System.Collections.Generic;

namespace eshopv2.administrator
{
    public partial class banner : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (User.Identity.IsAuthenticated && User.IsInRole("administrator"))
            {
                if (!Page.IsPostBack)
                {
                    //int bannerPositionID = (Request.QueryString.ToString().Contains("id")) ? int.Parse(Request.QueryString["id"]) : 0;
                    //if (bannerPositionID > 0)
                        //loadBanner(bannerPositionID);
                    loadPositions();
                }
            }
            else
                Response.Redirect("/administrator/login.aspx?returnUrl=" + Page.Request.RawUrl.Substring(15, Page.Request.RawUrl.Length - 15));
        }

        private void loadBanner(int bannerPositionID)
        {
            BannerBL bannerBL = new BannerBL();
            List<BannerItem> banners = bannerBL.GetBannersForPosition(bannerPositionID);
            dgvBanners.DataSource = banners;

            if (banners != null && banners.Count > 0)
            {
                ViewState["images"] = banners;
                loadImages();
                dgvBanners.Visible = true;
            }
            else
            {
                ViewState["images"] = null;
                dgvBanners.Visible = false;
            }
        }

        private void loadImages()
        {
            List<BannerItem> banners = null;
            if (ViewState["images"] != null)
            {
                banners = (List<BannerItem>)ViewState["images"];

                dgvBanners.DataSource = banners;
                dgvBanners.DataBind();
                dgvBanners.Visible = true;
            }
            
                
        }

        private void loadPositions()
        {
            BannerBL bannerBL = new BannerBL();
            cmbPosition.DataSource = bannerBL.GetBannerPositions();
            cmbPosition.DataTextField = "name";
            cmbPosition.DataValueField = "bannerPositionID";
            cmbPosition.DataBind();
            cmbPosition_SelectedIndexChanged(this, null);
        }

        protected void cmbPosition_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (cmbPosition.SelectedIndex > -1)
                loadBanner(int.Parse(cmbPosition.SelectedValue));
        }

        protected void btnUpload_Click(object sender, EventArgs e)
        {
            if (fluBanner.HasFile)
            {
                fluBanner.SaveAs(Server.MapPath("~") + "/images/" + fluBanner.FileName);
                List<BannerItem> images;
                if (ViewState["images"] != null)
                    images = (List<BannerItem>)ViewState["images"];
                else
                    images = new List<BannerItem>();

                images.Add(new BannerItem(-1, "/images/" + fluBanner.FileName, txtUrl.Text));
                ViewState["images"] = images;

                loadImages();
            }
        }

        private void save()
        {
            Banner banner = new Banner();
            banner.BannerPositionID = int.Parse(cmbPosition.SelectedValue);

            int index = 0;
            if (ViewState["images"] != null)
                foreach (GridViewRow row in dgvBanners.Rows)
                {
                    ((List<BannerItem>)ViewState["images"])[index].Url = ((TextBox)row.FindControl("txtLink")).Text;
                    index++;
                }

            banner.Banners = (List<BannerItem>)ViewState["images"];

            BannerBL bannerBL = new BannerBL();
            bannerBL.SaveBanner(banner);
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            save();
        }

        protected void btnSaveClose_Click(object sender, EventArgs e)
        {
            save();
            Response.Redirect("/administrator/");
        }

        protected void btnClose_Click(object sender, EventArgs e)
        {
            Response.Redirect("/administraor/");
        }

        protected void dgvBanners_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            List<BannerItem> images = (List<BannerItem>)ViewState["images"];

            for (int i = 0; i < images.Count; i++)
            {
                if (images[i].BannerID == int.Parse(((Label)dgvBanners.Rows[e.RowIndex].FindControl("lblBannerID")).Text))
                {
                    images.RemoveAt(i);
                    BannerBL bannerBL = new BannerBL();
                    bannerBL.DeleteBanner(int.Parse(((Label)dgvBanners.Rows[e.RowIndex].FindControl("lblBannerID")).Text));
                    break;
                }
            }
            loadImages();
        }
    }
}
