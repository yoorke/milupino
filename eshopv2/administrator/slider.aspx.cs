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
using System.Collections.Generic;

namespace eshopv2.administrator
{
    public partial class slider : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(User.Identity.IsAuthenticated && User.IsInRole("administrator"))
            {
                if (!Page.IsPostBack)
                {
                    int sliderID = (Request.QueryString.ToString().Contains("id")) ? int.Parse(Request.QueryString["id"]) : 0;
                    if (sliderID > 0)
                        loadSlider(sliderID);
                }
                else
                    if (lblSliderID.Value != null && lblSliderID.Value != string.Empty)
                        fluImage.Enabled = btnImageUpload.Enabled = true;
            }
            else
                Response.Redirect("/administrator/login.aspx?returnUrl="+Page.Request.RawUrl.Substring(15,Page.Request.RawUrl.Length-15));
        }

        private void loadSlider(int sliderID)
        {
            SliderBL sliderBL = new SliderBL();
            Slider slider = sliderBL.GetSlider(sliderID);

            txtName.Text = slider.Name;
            chkActive.Checked = slider.Active;

            if (slider.Items != null)
            {
                ViewState["images"] = slider.Items;
                loadImages();
            }

            lblSliderID.Value = slider.SliderID.ToString();
        }

        protected void dgvImages_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            List<SliderItem> images = (List<SliderItem>)ViewState["images"];

            for (int i = 0; i < images.Count; i++)
                if (images[i].ImageUrl == ((Label)dgvImages.Rows[e.RowIndex].FindControl("lblImageUrl")).Text)
                {
                    images.RemoveAt(i);
                    break;
                }
            loadImages();
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            SaveSlider();
            Response.Redirect(Page.Request.RawUrl);
        }

        protected void btnSaveClose_Click(object sender, EventArgs e)
        {
            SaveSlider();
            Response.Redirect("/administrator/sliders.aspx");
        }

        protected void btnClose_Click(object sender, EventArgs e)
        {
            Response.Redirect("/administrator/sliders.aspx");
        }

        protected void btnImageUpload_Click(object sender, EventArgs e)
        {
            if (fluImage.HasFile)
            {
                fluImage.SaveAs(Server.MapPath("~")+"/images/"+fluImage.FileName);
                List<SliderItem> images;
                if (ViewState["images"] != null)
                    images = (List<SliderItem>)ViewState["images"];
                else
                    images = new List<SliderItem>();

                images.Add(new SliderItem(-1, -1, "/images/" + fluImage.FileName, images.Count + 1, txtUrl.Text));
                ViewState["images"] = images;

                loadImages();
                //SaveSlider();
            }
        }

        private void SaveSlider()
        {
            Slider slider = new Slider();
            slider.SliderID = (lblSliderID.Value != null && lblSliderID.Value != string.Empty) ? int.Parse(lblSliderID.Value) : -1;
            slider.Name = txtName.Text;
            slider.Active = chkActive.Checked;
            slider.InsertDate = DateTime.Now.ToUniversalTime();
            slider.UpdateDate = DateTime.Now.ToUniversalTime();

            if (ViewState["images"] != null)
            {
                int index = 0;
                foreach (GridViewRow row in dgvImages.Rows) { 
                    ((List<SliderItem>)ViewState["images"])[index].Url = ((TextBox)row.FindControl("txtUrl")).Text;
                    ((List<SliderItem>)ViewState["images"])[index].SortIndex = index;
                    index++;
                }
                List<SliderItem> images = (List<SliderItem>)ViewState["images"];
                slider.Items = new List<SliderItem>();
                foreach (SliderItem item in images)
                    slider.Items.Add(item);
            }

            SliderBL sliderBL = new SliderBL();
            slider.SliderID = sliderBL.SaveSlider(slider);
            if (slider.SliderID > 0)
            {
                lblSliderID.Value = slider.SliderID.ToString();
                //fluImage.Enabled = true;
                //btnImageUpload.Enabled = true;
            }

            setStatus("Slider uspešno sačuvan.", System.Drawing.Color.Green, true);
        }

        private void loadImages()
        {
            List<SliderItem> images = null;
            if (ViewState["images"] != null)
                images = (List<SliderItem>)ViewState["images"];

            dgvImages.DataSource = images;
            dgvImages.DataBind();
        }

        private void setStatus(string text, System.Drawing.Color foreColor, bool visible)
        {
            csStatus.Text = text;
            csStatus.Visible = visible;
            csStatus.ForeColor = foreColor;
            csStatus.Show();
        }

        protected void dgvImages_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            //if (e.CommandName == "sortUp" || e.CommandName == "sortDown")
            //{
                
            //}
            switch (e.CommandName)
            {

                case "sortUp":
                    {
                        GridViewRow row = (GridViewRow)(((ImageButton)e.CommandSource).NamingContainer);
                        int sliderItemID = int.Parse(((Label)row.Cells[0].FindControl("lblSliderItemID")).Text);
                        reorderSliderItems(sliderItemID, -1);
                        
                        break;
                    }
                case "sortDown":
                    {
                        GridViewRow row = (GridViewRow)(((ImageButton)e.CommandSource).NamingContainer);
                        int sliderItemID = int.Parse(((Label)row.Cells[0].FindControl("lblSliderItemID")).Text);
                        reorderSliderItems(sliderItemID, 1);
                        break;
                    }
            }
        }

        private void reorderSliderItems(int sliderItemID, int index)
        {
            SliderBL sliderBL = new SliderBL();
            sliderBL.ReorderSliderItems(sliderItemID, index, int.Parse(lblSliderID.Value));

            loadSlider(int.Parse(lblSliderID.Value));
        }
    }
}
