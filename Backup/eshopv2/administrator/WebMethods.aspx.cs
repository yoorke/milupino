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
using System.Web.Configuration;
using Newtonsoft.Json;
using System.Web.Services;

namespace eshopv2.administrator
{
    public partial class WebMethods : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod()]
        public static string GetProductsFromKimtec()
        {
            try
            {
                string status = new KimtecBL().SaveProductsFromKimtec();
                Configuration configuration = WebConfigurationManager.OpenWebConfiguration("/");
                configuration.AppSettings.Settings["productsLoaded"].Value = DateTime.Now.AddHours(9).ToString("dd/MM/yyyy hh:mm");
                configuration.Save();

                return JsonConvert.SerializeObject(status);
            }
            catch
            {
                throw;
            }
        }

        [WebMethod()]
        public static string GetProductsSpecificationFromKimtec()
        {
            try
            {
                new KimtecBL().SaveProductSpecification();
                new KimtecBL().SaveKimtecAttribute();
                return JsonConvert.SerializeObject("Specification successfully saved");
            }
            catch
            {
                throw;
            }
        }

        [WebMethod()]
        public static string GetCategoriesFromKimtec()
        {
            try
            {
                DataSet categories = new KimtecBL().GetCategoriesFromKimtec();
                return JsonConvert.SerializeObject("Preuzeto " + categories.Tables[0].Rows.Count + " kategorija");
            }
            catch
            {
                throw;
            }
        }
    }
}
