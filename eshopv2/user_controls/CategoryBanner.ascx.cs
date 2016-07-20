using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using eshopBE;
using eshopBL;

namespace eshopv2.user_controls
{
    public partial class CategoryBanner : System.Web.UI.UserControl
    {
        private int _categoryBannerID;

        public int CategoryBannerID
        {
            get { return _categoryBannerID; }
            set { _categoryBannerID = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            loadCategoryBanner();
        }

        private void loadCategoryBanner()
        {
            if (_categoryBannerID > 0)
            {
                eshopBE.CategoryBanner categoryBanner = new CategoryBannerBL().GetCategoryBanner(_categoryBannerID);
                lnkCategoryBanner.NavigateUrl = "/" + categoryBanner.Url;
                imgCategoryBanner.ImageUrl = "~/images/" + categoryBanner.ImageUrl;
            }
            else
                this.Visible = false;
        }
    }
}