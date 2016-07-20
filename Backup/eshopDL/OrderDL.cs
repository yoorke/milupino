using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using eshopBE;
using eshopUtilities;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;

namespace eshopDL
{
    public class OrderDL
    {
        public int SaveOrder(Order order)
        {
            int status = 0;
            SqlTransaction transaction = null;
            try
            {
                using (SqlConnection objConn = new SqlConnection(WebConfigurationManager.ConnectionStrings["eshopConnectionString"].ConnectionString))
                {
                    objConn.Open();
                    using (SqlCommand objComm = objConn.CreateCommand())
                    {
                        objComm.Connection = objConn;
                        objComm.CommandText = "saveOrder";
                        objComm.CommandType = CommandType.StoredProcedure;
                        using (transaction = objConn.BeginTransaction())
                        {
                            objComm.Transaction = transaction;

                            objComm.Parameters.Add("@date", SqlDbType.DateTime).Value = order.Date;
                            objComm.Parameters.Add("@userID", SqlDbType.Int).Value = order.User.UserID;
                            objComm.Parameters.Add("@firstName", SqlDbType.NVarChar, 50).Value = order.Firstname;
                            objComm.Parameters.Add("@lastName", SqlDbType.NVarChar, 50).Value = order.Lastname;
                            objComm.Parameters.Add("@address", SqlDbType.NVarChar, 100).Value = order.Address;
                            objComm.Parameters.Add("@city", SqlDbType.NVarChar, 50).Value = order.City;
                            objComm.Parameters.Add("@phone", SqlDbType.NVarChar, 50).Value = order.Phone;
                            objComm.Parameters.Add("@email", SqlDbType.NVarChar, 50).Value = order.Email;
                            objComm.Parameters.Add("@couponID", SqlDbType.Int).Value = order.Coupon.CouponID;
                            objComm.Parameters.Add("@name", SqlDbType.NVarChar, 50).Value = order.Name;
                            objComm.Parameters.Add("@pib", SqlDbType.NChar, 9).Value = order.Pib;
                            objComm.Parameters.Add("@paymentID", SqlDbType.Int).Value = order.Payment.PaymentID;
                            objComm.Parameters.Add("@deliveryID", SqlDbType.Int).Value = order.Delivery.DeliveryID;
                            objComm.Parameters.Add("@statusID", SqlDbType.Int).Value = order.OrderStatus.OrderStatusID;
                            objComm.Parameters.Add("@zip", SqlDbType.NVarChar, 5).Value = order.Zip;
                            objComm.Parameters.Add("@comment", SqlDbType.NVarChar).Value = order.Comment;
                            objComm.Parameters.Add("@cartID", SqlDbType.NVarChar, 32).Value = order.CartID;
                            

                            SqlParameter orderID = new SqlParameter("@orderID", SqlDbType.Int);
                            orderID.Direction = ParameterDirection.Output;
                            objComm.Parameters.Add(orderID);

                            status = objComm.ExecuteNonQuery();
                            order.OrderID = int.Parse(objComm.Parameters["@orderID"].Value.ToString());

                            if (status > 0)
                            {
                                objComm.CommandText = "saveOrderItem";
                                for (int i = 0; i < order.Items.Count; i++)
                                {
                                    objComm.Parameters.Clear();
                                    objComm.Parameters.Add("@orderID", SqlDbType.Int).Value = order.OrderID;
                                    objComm.Parameters.Add("@productID", SqlDbType.Int).Value = order.Items[i].ProductID;
                                    objComm.Parameters.Add("@productPrice", SqlDbType.Float).Value = order.Items[i].ProductPrice;
                                    objComm.Parameters.Add("@userPrice", SqlDbType.Float).Value = order.Items[i].UserPrice;
                                    objComm.Parameters.Add("@quantity", SqlDbType.Float).Value = order.Items[i].Quantity;

                                    status = objComm.ExecuteNonQuery();
                                }
                            }
                            transaction.Commit();
                        }
                    }
                }
            }
            catch (SqlException ex)
            {
                ErrorLog.LogError(ex);
                transaction.Rollback();
                throw new DLException("Error while saving order.", ex);
            }
            return status;
        }

        public Order GetOrder(int orderID)
        {
            Order order = null;
            using (SqlConnection objConn = new SqlConnection(WebConfigurationManager.ConnectionStrings["eshopConnectionString"].ConnectionString))
            {
                using (SqlCommand objComm = new SqlCommand("getOrder", objConn))
                {
                    objConn.Open();
                    objComm.Parameters.Add("@orderID", SqlDbType.Int).Value = orderID;
                    objComm.CommandType = CommandType.StoredProcedure;
                    using(SqlDataReader reader=objComm.ExecuteReader())
                    {
                        if (reader.HasRows)
                        {
                            order = new Order();
                            while (reader.Read())
                            {
                                order.OrderID = orderID;
                                order.Date = reader.GetDateTime(1);
                                order.User = new User(reader.GetInt32(2), string.Empty, string.Empty, reader.GetString(3), string.Empty, string.Empty, string.Empty, string.Empty, null, string.Empty, string.Empty);
                                order.Firstname = reader.GetString(4);
                                order.Lastname = reader.GetString(5);
                                order.Address = reader.GetString(6);
                                order.City = reader.GetString(7);
                                order.Phone = reader.GetString(8);
                                order.Email = reader.GetString(9);
                                order.Name = reader.GetString(10);
                                order.Pib = reader.GetString(11);
                                order.Payment = new Payment(reader.GetInt32(12), reader.GetString(13));
                                order.Delivery = new Delivery(reader.GetInt32(14), reader.GetString(15));
                                if (Convert.IsDBNull(reader[16]) == false)
                                    order.Zip = reader.GetString(16);
                                order.Items = getOrderItems(orderID);
                                order.Coupon = new Coupon(reader.GetInt32(17), reader.GetString(18), reader.GetDouble(19), string.Empty);
                                order.OrderStatus = new OrderStatus(reader.GetInt32(20), reader.GetString(21));
                                order.Code = reader.GetString(23);

                                if (Convert.IsDBNull(reader[22]) == false)
                                    order.Comment = reader.GetString(22);
                            }
                        }
                    }
                }
            }
            return order;
        }

        private List<OrderItem> getOrderItems(int orderID)
        {
            List<OrderItem> items = null;
            //Order order = null;
            using (SqlConnection objConn = new SqlConnection(WebConfigurationManager.ConnectionStrings["eshopConnectionString"].ConnectionString))
            {
                using (SqlCommand objComm = new SqlCommand("getOrderItems", objConn))
                {
                    objConn.Open();
                    objComm.Parameters.Add("@orderID", SqlDbType.Int).Value = orderID;
                    objComm.CommandType = CommandType.StoredProcedure;
                    using (SqlDataReader reader = objComm.ExecuteReader())
                    {
                        if (reader.HasRows)
                            items = new List<OrderItem>();
                        while (reader.Read())
                        {
                            items.Add(new OrderItem(reader.GetInt32(0), reader.GetInt32(1), reader.GetInt32(2), reader.GetDouble(3), reader.GetDouble(5), reader.GetDouble(4)));
                        }
                    }
                }
            }
            return items;
        }

        public DataTable GetOrderItemsFull(int orderID)
        {
            DataTable items = null;
            using (SqlConnection objConn = new SqlConnection(WebConfigurationManager.ConnectionStrings["eshopConnectionString"].ConnectionString))
            {
                using (SqlCommand objComm = new SqlCommand("getOrderItemsFull", objConn))
                {
                    objConn.Open();
                    objComm.Parameters.Add("@orderID", SqlDbType.Int).Value = orderID;
                    objComm.CommandType = CommandType.StoredProcedure;
                    using (SqlDataReader reader = objComm.ExecuteReader())
                    {
                        if (reader.HasRows)
                        {
                            items = new DataTable();
                            items.Load(reader);
                        }
                    }
                }
            }
            return items;
        }

        public DataTable GetOrders(int statusID, DateTime dateFrom, DateTime dateTo)
        {
            DataTable orders = null;
            using (SqlConnection objConn = new SqlConnection(WebConfigurationManager.ConnectionStrings["eshopConnectionString"].ConnectionString))
            {
                using (SqlCommand objComm = new SqlCommand("getOrders", objConn))
                {
                    objConn.Open();
                    objComm.CommandType = CommandType.StoredProcedure;
                    objComm.Parameters.Add("@orderStatusID", SqlDbType.Int).Value = statusID;
                    objComm.Parameters.Add("@dateFrom", SqlDbType.Date).Value = dateFrom;
                    objComm.Parameters.Add("@dateTo", SqlDbType.Date).Value = dateTo;
                    using (SqlDataReader reader = objComm.ExecuteReader())
                    {
                        if (reader.HasRows)
                        {
                            orders = new DataTable();
                            orders.Load(reader);
                        }
                    }
                }
            }
            return orders;
        }

        public DataTable GetOrderStatuses()
        {
            DataTable statuses = null;
            using (SqlConnection objConn = new SqlConnection(WebConfigurationManager.ConnectionStrings["eshopConnectionString"].ConnectionString))
            {
                using (SqlCommand objComm = new SqlCommand("getOrderStatuses", objConn))
                {
                    objConn.Open();
                    objComm.CommandType = CommandType.StoredProcedure;
                    using (SqlDataReader reader = objComm.ExecuteReader())
                    {
                        if (reader.HasRows)
                        {
                            statuses = new DataTable();
                            statuses.Load(reader);
                        }
                    }
                }
            }
            return statuses;
        }
         
        public int UpdateOrderStatus(int orderID, int orderStatusID)
        {
            int status = 0;
            using (SqlConnection objConn = new SqlConnection(WebConfigurationManager.ConnectionStrings["eshopConnectionString"].ConnectionString))
            {
                using (SqlCommand objComm = new SqlCommand("updateOrderStatus", objConn))
                {
                    objConn.Open();
                    objComm.CommandType = CommandType.StoredProcedure;
                    objComm.Parameters.Add("@orderID", SqlDbType.Int).Value = orderID;
                    objComm.Parameters.Add("@orderStatusID", SqlDbType.Int).Value = orderStatusID;

                    status = objComm.ExecuteNonQuery();
                }
            }
            return status;
        }

        public int DeleteOrder(int orderID)
        {
            int status = 0;
            using (SqlConnection objConn = new SqlConnection(WebConfigurationManager.ConnectionStrings["eshopConnectionString"].ConnectionString))
            {
                using (SqlCommand objComm = new SqlCommand("deleteOrder", objConn))
                {
                    objConn.Open();
                    objComm.Parameters.Add("@orderID", SqlDbType.Int).Value = orderID;
                    objComm.CommandType = CommandType.StoredProcedure;

                    status = objComm.ExecuteNonQuery();
                }
            }
            return status;
        }
    }
}
