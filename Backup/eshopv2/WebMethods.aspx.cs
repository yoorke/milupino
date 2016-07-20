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
using System.Web.Services;
using eshopBL;
using Newtonsoft.Json;

namespace eshopv2
{
    public partial class WebMethods : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        [WebMethod()]
        public static string AddToWishList(int productID)
        {
            new WishListBL().SaveProductToWishList(int.Parse(Membership.GetUser().ProviderUserKey.ToString()), productID);
            return "rewrer";
        }

        [WebMethod()]
        public static string AddToCompare(int productID)
        {
         
            if (System.Web.HttpContext.Current.Session["compare"] != null)
            {
                if (!((System.Collections.Generic.List<int>)System.Web.HttpContext.Current.Session["compare"]).Contains(productID))
                    ((System.Collections.Generic.List<int>)System.Web.HttpContext.Current.Session["compare"]).Add(productID);

            }
            else
            {
                System.Collections.Generic.List<int> compareList = new System.Collections.Generic.List<int>();
                compareList.Add(productID);
                System.Web.HttpContext.Current.Session.Add("compare", compareList);
            }

            return ((System.Collections.Generic.List<int>)System.Web.HttpContext.Current.Session["compare"]).Count.ToString();
        }

        [WebMethod()]
        public static string GetCompareProductList()
        {
            System.Collections.Generic.List<int> productList = new System.Collections.Generic.List<int>();
            if(System.Web.HttpContext.Current.Session["compare"] != null)
                productList = (System.Collections.Generic.List<int>)System.Web.HttpContext.Current.Session["compare"];

            return JsonConvert.SerializeObject(productList);
        }

        [WebMethod()]
        public static string DeleteFromProductCompare(int productID)
        {
            if(System.Web.HttpContext.Current.Session["compare"] != null)
            {
                ((System.Collections.Generic.List<int>)System.Web.HttpContext.Current.Session["compare"]).Remove(productID);
            }
            return string.Empty;
        }
    }
}
