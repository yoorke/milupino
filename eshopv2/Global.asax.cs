using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;
using System.Xml.Linq;
using System.Web.Routing;

namespace eshopv2
{
    public class Global : System.Web.HttpApplication
    {

        protected void Application_Start(object sender, EventArgs e)
        {
            RegisterRoutes(RouteTable.Routes);
        }

        protected void Session_Start(object sender, EventArgs e)
        {
            if (Request.Cookies["cartID"] != null)
                Session.Add("cartID", Request.Cookies["cartID"].Value);
            else
            {
                Guid guid = Guid.NewGuid();
                Session.Add("cartID", guid.ToString());
                HttpCookie cookie = new HttpCookie("cartID");
                cookie.Expires = DateTime.Now.AddDays(10);
                cookie.Value = guid.ToString();
                Response.Cookies.Add(cookie);
            }
        }

        protected void Application_BeginRequest(object sender, EventArgs e)
        {

        }

        protected void Application_AuthenticateRequest(object sender, EventArgs e)
        {

        }

        protected void Application_Error(object sender, EventArgs e)
        {
            Exception ex = Server.GetLastError();
            if (ex is System.Threading.ThreadAbortException)
                return;
            else
            {
                eshopUtilities.ErrorLog.LogError(ex, Request.RawUrl, Request.UserHostAddress, Request.Url.ToString());
                Server.Transfer("~/error.html");
            }
        }

        protected void Session_End(object sender, EventArgs e)
        {

        }

        protected void Application_End(object sender, EventArgs e)
        {

        }

        private void RegisterRoutes(RouteCollection routes)
        {
            routes.MapPageRoute("o-nama", "o-nama", "~/customPage.aspx", false, new RouteValueDictionary { { "url", "o-nama"} });
            routes.MapPageRoute("category", "proizvodi/{category}", "~/products.aspx");
            routes.MapPageRoute("product", "proizvodi/{category}/{product}", "~/product.aspx");
            routes.MapPageRoute("gde-kupiti", "gde-kupiti", "~/customPage.aspx", false, new RouteValueDictionary { { "url", "gde-kupiti" } });
            routes.MapPageRoute("uputstvo-za-kupovinu", "uputstvo-za-kupovinu", "~/customPage.aspx", false, new RouteValueDictionary { { "url", "uputstvo-za-kupovinu" } });
            routes.MapPageRoute("najcesca-pitanja", "najcesca-pitanja", "~/customPage.aspx", false, new RouteValueDictionary { { "url", "najcesca-pitanja" } });
            routes.MapPageRoute("nacini-placanja", "nacini-placanja", "~/customPage.aspx", false, new RouteValueDictionary { { "url", "nacini-placanja" } });
            routes.MapPageRoute("povracaj-robe", "povracaj-robe", "~/customPage.aspx", false, new RouteValueDictionary { { "url", "povracaj-robe" } });
            routes.MapPageRoute("rokovi-isporuke", "rokovi-isporuke", "~/customPage.aspx", false, new RouteValueDictionary { { "url", "rokovi-isporuke" } });
            routes.MapPageRoute("pravni-subjekti", "pravni-subjekti", "~/customPage.aspx", false, new RouteValueDictionary { { "url", "pravni-subjekti" } });
            routes.MapPageRoute("garancije-reklamacije-servis", "garancije-reklamacije-servis", "~/customPage.aspx", false, new RouteValueDictionary { { "url", "garancije-reklamacije-servis" } });
            routes.MapPageRoute("kontakti-ovlascenih-servisera", "kontakti-ovlascenih-servisera", "~/customPage.aspx", false, new RouteValueDictionary { { "url", "kontakti-ovlascenih-servisera" } });
            routes.MapPageRoute("lista-zelja", "lista-zelja", "~/wishList.aspx");
            routes.MapPageRoute("korpa", "korpa", "~/cart.aspx");
            routes.MapPageRoute("zaposlenje", "zaposlenje", "~/customPage.aspx", false, new RouteValueDictionary { { "url", "zaposlenje" } });
            routes.MapPageRoute("kako-kupiti", "kako-kupiti", "~/customPage.aspx", false, new RouteValueDictionary { { "url", "kako-kupiti" } });
            routes.MapPageRoute("porucivanje", "porucivanje", "~/checkout.aspx");
            routes.MapPageRoute("registracija", "registracija", "~/registration.aspx");
            routes.MapPageRoute("prijava", "prijava", "~/login.aspx");
            routes.MapPageRoute("resetovanje-sifre", "resetovanje-sifre", "~/passwordResetRequest.aspx");
            routes.MapPageRoute("kreiranje-korisnicke-sifre", "kreiranje-korisnicke-sifre", "~/passwordReset.aspx");
            routes.MapPageRoute("kontakt", "kontakt", "~/kontakt.aspx");
            routes.MapPageRoute("moj-nalog", "moj-nalog", "~/account.aspx");
            routes.MapPageRoute("izmena-sifre", "izmena-sifre", "~/passwordChange.aspx");
            routes.MapPageRoute("pretraga", "pretraga", "~/search.aspx");
            routes.MapPageRoute("uslovi-koriscenja", "uslovi-koriscenja", "~/customPage.aspx", false, new RouteValueDictionary { { "url", "uslovi-koriscenja" } });
        }
    }
}