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
    public partial class sliders : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (User.Identity.IsAuthenticated && User.IsInRole("administrator"))
            {
                SliderBL sliderBL = new SliderBL();
                dgvSliders.DataSource = sliderBL.GetSliders();
                dgvSliders.DataBind();
            }
            else
                Response.Redirect("/administrator/login.aspx?returnUrl=" + Page.Request.RawUrl.Substring(15, Page.Request.RawUrl.Length - 15));
        }

        protected void dgvSliders_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            SliderBL sliderBL = new SliderBL();
            int status = sliderBL.DeleteSlider(int.Parse(dgvSliders.DataKeys[e.RowIndex].Values[0].ToString()));

            Response.Redirect("/administrator/sliders.aspx");
        }

        protected void btnAddSlider_Click(object sender, EventArgs e)
        {
            Response.Redirect("/administrator/slider.aspx");
        }
    }
}
