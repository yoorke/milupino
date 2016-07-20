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
            if (HttpContext.Current.User.Identity.IsAuthenticated)
            {
                new WishListBL().SaveProductToWishList(int.Parse(Membership.GetUser().ProviderUserKey.ToString()), productID);
            }
            else
                //throw new Exception("Not loggedin");
                return "Not loggedin";
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

        [WebMethod()]
        public static string AddToCart(int productID, double webPrice)
        {
            CartBL cartBL = new CartBL();
            cartBL.AddProductToCart(productID, System.Web.HttpContext.Current.Session["cartID"].ToString(), 1, webPrice, webPrice);
            return JsonConvert.SerializeObject((cartBL.GetProductsCount(System.Web.HttpContext.Current.Session["cartID"].ToString()).ToString() + "|" + string.Format("{0:N2}", cartBL.GetTotal(System.Web.HttpContext.Current.Session["cartID"].ToString()))).Split('|'));
        }

        [WebMethod()]
        public static string CheckEmail(string email)
        {
            bool exists = new UserBL().UserExists(email);
            return JsonConvert.SerializeObject(exists);
        }

        [WebMethod()]
        public static string GetNumberOfOrdersByDay(DateTime dateFrom, DateTime dateTo)
        {
            return JsonConvert.SerializeObject(new OrderBL().GetNumberOfOrdersByDay(dateFrom, dateTo));
        }

        [WebMethod()]
        public static string GetNumberOfOrdersByMonth(DateTime dateFrom, DateTime dateTo)
        {
            return JsonConvert.SerializeObject(new OrderBL().GetNumberOfOrdersByMonth(dateFrom, dateTo));
        }

        [WebMethod()]
        public static string GetValuesByMonth(DateTime dateFrom, DateTime dateTo)
        {
            return JsonConvert.SerializeObject(new OrderBL().GetValuesByMonth(dateFrom, dateTo));
        }

        [WebMethod()]
        public static string GetValuesByDay(DateTime dateFrom, DateTime dateTo)
        {
            return JsonConvert.SerializeObject(new OrderBL().GetValuesByDay(dateFrom, dateTo));
        }

        [WebMethod()]
        public static string GetCategoryPercentage(DateTime dateFrom, DateTime dateTo)
        {
            return JsonConvert.SerializeObject(new OrderBL().GetCategoryPercentage(dateFrom, dateTo));
        }

        [WebMethod()]
        public static string GetCategoryValue(DateTime dateFrom, DateTime dateTo)
        {
            return JsonConvert.SerializeObject(new OrderBL().GetCategoryValue(dateFrom, dateTo));
        }

        [WebMethod()]
        public static string GetCart()
        {
            return JsonConvert.SerializeObject(new CartBL().GetProducts(HttpContext.Current.Session["cartID"].ToString()));
        }
    }
}
