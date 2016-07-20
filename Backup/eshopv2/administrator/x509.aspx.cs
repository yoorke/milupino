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
using System.Security.Cryptography.X509Certificates;
using System.IO;

namespace eshop.administrator
{
    public partial class x509 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                string path = HttpContext.Current.Server.MapPath("~/b2b_pin_servis_stkr.p12");
                string virtualPath = VirtualPathUtility.ToAbsolute("~/b2b_pin_servis_stkr.p12");
                string virtualPathRelative = VirtualPathUtility.ToAppRelative("~/b2b_pin_servis_stkr.p12");
                string resolveUrl = Page.ResolveUrl("~/b2b_pin_servis_stkr.p12");

                if (File.Exists(path))
                {
                    Response.Write("postoji");
                    Response.Write(path);
                    Response.Write(virtualPath);
                    Response.Write(virtualPathRelative);
                    //string[] file = File.ReadAllLines(path);
                    //foreach (string str in file)
                        //Response.Write(str);
                    byte[] file = File.ReadAllBytes(path);
                    X509Certificate cert = new X509Certificate(file, "0328", X509KeyStorageFlags.MachineKeySet);

                    eshopUtilities.CertificateWebClient webClient = new eshopUtilities.CertificateWebClient();
                    webClient.DownloadFile("https://b2b.kimtec.rs//slike//0351617_big.jpg", Server.MapPath("~/images/"));
                }
            }
            catch (Exception ex)
            {
                Page.Response.Write(ex.Message);
            }
        }
    }
}
