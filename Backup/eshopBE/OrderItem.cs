using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace eshopBE
{
    public class OrderItem
    {
        private int _orderItemID;
        private int _orderID;
        private int _productID;
        private double _productPrice;
        private double _userPrice;
        private double _quantity;
        

        public OrderItem()
        {
        }

        public OrderItem(int orderItemID, int orderID, int productID, double price, double userPrice, double quantity)
        {
            _orderItemID = orderItemID;
            _orderID = orderID;
            _productID = productID;
            _productPrice = price;
            _userPrice = userPrice;
            _quantity = quantity;
        }

        public int OrderItemID
        {
            get { return _orderItemID; }
            set { _orderItemID = value; }
        }

        public int OrderID
        {
            get { return _orderID; }
            set { _orderID = value; }
        }

        public int ProductID
        {
            get { return _productID; }
            set { _productID = value; }
        }

        public double ProductPrice
        {
            get { return _productPrice; }
            set { _productPrice = value; }
        }

        public double Quantity
        {
            get { return _quantity; }
            set { _quantity = value; }
        }

        public double UserPrice
        {
            get { return _userPrice; }
            set { _userPrice = value; }
        }
    }
}
