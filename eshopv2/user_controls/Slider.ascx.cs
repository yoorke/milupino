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
using eshopBE;

namespace eshopv2.user_controls
{
    public partial class Slider : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
                loadSlider();
        }

        private void loadSlider()
        {
            rptSlider.DataSource = new SliderBL().GetSliderItems(12);
            rptSlider.DataBind();
        }
    }
}