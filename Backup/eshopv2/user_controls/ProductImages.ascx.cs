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
using System.Collections.Generic;

namespace eshopv2.user_controls
{
    public partial class ProductImages : System.Web.UI.UserControl
    {
        private List<string> _images;

        public List<string> Images
        {
            get { return _images; }
            set { _images = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            //if (Page.IsPostBack)
                //ShowImages();
        }

        public void ShowImages()
        {
            if (_images != null)
            {
                imgMain.ImageUrl = !_images[0].Contains("no-image.jpg") ? _images[0].Substring(0, _images[0].IndexOf(".jpg")) + "-main.jpg" : _images[0];
                lnkImage.NavigateUrl = _images[0];
                pnlThumbs.Controls.Clear();
                if (_images.Count > 1)
                {
                    for (int i = 0; i < _images.Count; i++)
                    {
                        ImageButton image = new ImageButton();
                        image.ID = "imgThumb" + i.ToString();
                        image.ImageUrl = !_images[i].Contains("no-image.jpg") ? _images[i].Substring(0, _images[i].IndexOf(".jpg")) + "-thumb.jpg" : _images[i];
                        image.CssClass = "thumb img-responsive";
                        //image.Click += new ImageClickEventHandler(image_Click);
                        image.OnClientClick = "changeImg(this.src);return false;";

                        pnlThumbs.Controls.Add(new LiteralControl("<div class='col-lg-4'>"));
                        pnlThumbs.Controls.Add(image);
                        pnlThumbs.Controls.Add(new LiteralControl("</div>"));
                    }
                }
            }
        }

        /*protected void image_Click(object sender, ImageClickEventArgs e)
        {
            ImageButton image = (ImageButton)sender;
            imgMain.ImageUrl = image.ImageUrl;
        }*/
    }
}