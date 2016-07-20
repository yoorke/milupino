using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using eshopBE;
using eshopDL;
using System.Data;
using eshopUtilities;

namespace eshopBL
{
    public class OrderBL
    {
        public int SaveOrder(Order order)
        {
            OrderDL orderDL = new OrderDL();
            int status = orderDL.SaveOrder(order);
            Common.SendOrder();
            return status;
        }

        public Order GetOrder(int orderID)
        {
            OrderDL orderDL = new OrderDL();
            return orderDL.GetOrder(orderID);
        }

        public DataTable GetOrders()
        {
            OrderDL orderDL = new OrderDL();
            return orderDL.GetOrders(-1, DateTime.MinValue, DateTime.Now);
        }

        public DataTable GetOrders(int statusID, DateTime dateFrom, DateTime dateTo)
        {
            OrderDL orderDL = new OrderDL();
            return orderDL.GetOrders(statusID, dateFrom, dateTo);
        }
        

        public DataTable GetOrderStatuses(bool allSelection)
        {
            OrderDL orderDL = new OrderDL();
            DataTable orderStatuses = orderDL.GetOrderStatuses();
            if (allSelection)
            {
                DataRow newRow = orderStatuses.NewRow();
                newRow["orderStatusID"] = -1;
                newRow["name"] = "Sve";
                orderStatuses.Rows.InsertAt(newRow, 0);
            }
            return orderStatuses;
        }

        public DataTable GetOrderItemsFull(int orderID)
        {
            OrderDL orderDL = new OrderDL();
            return orderDL.GetOrderItemsFull(orderID);
        }

        public int UpdateOrderStatus(int orderID, int orderStatusID)
        {
            OrderDL orderDL = new OrderDL();
            return orderDL.UpdateOrderStatus(orderID, orderStatusID);
        }

        public int DeleteOrder(int orderID)
        {
            OrderDL orderDL = new OrderDL();
            return orderDL.DeleteOrder(orderID);
        }
    }
}
