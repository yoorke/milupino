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
    public partial class Banner : System.Web.UI.UserControl
    {
        private string _position;

        public string Position
        {
            get { return _position; }
            set
            {
                _position = value;
                loadBanner();
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        private void loadBanner()
        {
            BannerItem banner = new BannerBL().GetBanner(_position);
            imgBanner.ImageUrl = banner != null ? "~" + banner.ImageUrl : string.Empty;
            lnkBanner.NavigateUrl = banner != null ? banner.Url : string.Empty;
            if (banner == null)
                this.Visible = false;
        }
    }
}