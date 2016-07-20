using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using eshopDL;

namespace eshopBL
{
    public class CartBL
    {
        public int AddProductToCart(int productID, string cartID, double quantity, double productPrice, double userPrice)
        {
            CartDL cartDL = new CartDL();
            return cartDL.AddProductToCart(productID, cartID, quantity, productPrice, userPrice);
        }

        public int DeleteProductFromCart(int productID, string cartID)
        {
            CartDL cartDL = new CartDL();
            return cartDL.DeleteProductFromCart(productID, cartID);
        }

        public DataTable GetProducts(string cartID)
        {
            CartDL cartDL = new CartDL();
            return cartDL.GetProducts(cartID);
        }

        public int GetProductsCount(string cartID)
        {
            CartDL cartDL = new CartDL();
            return cartDL.GetProductsCount(cartID);
        }

        public int UpdateCartProduct(string cartID, int productID, double quantity, double productPrice, double userPrice)
        {
            CartDL cartDL = new CartDL();
            return cartDL.UpdateCartProduct(cartID, productID, quantity, productPrice, userPrice);
        }

        public double GetCartDiscount(string cartID)
        {
            CartDL cartDL = new CartDL();
            return cartDL.GetCartDiscount(cartID);
        }

        public int SaveCartCoupon(string cartID, int couponID)
        {
            CartDL cartDL = new CartDL();
            return cartDL.SaveCartCoupon(cartID, couponID);
        }

        public double GetTotal(string cartID)
        {
            DataTable products = GetProducts(cartID);
            double total = 0;

            for (int i = 0; i < products.Rows.Count; i++)
                total += double.Parse(products.Rows[i]["userPrice"].ToString()) * double.Parse(products.Rows[i]["quantity"].ToString());
            return total;
        }

        public int GetCartCoupon(string cartID)
        {
            CartDL cartDL = new CartDL();
            return cartDL.GetCartCoupon(cartID);
        }
    }
}
