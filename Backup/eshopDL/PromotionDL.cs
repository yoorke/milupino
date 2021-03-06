﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SqlClient;
using eshopBE;
using System.Web.Configuration;
using System.Data;

namespace eshopDL
{
    public class PromotionDL
    {
        public int SavePromotion(Promotion promotion)
        {
            int promotionID = 0;
            using (SqlConnection objConn = new SqlConnection(WebConfigurationManager.ConnectionStrings["eshopConnectionString"].ConnectionString))
            {
                using (SqlCommand objComm = new SqlCommand("INSERT INTO promotion (name, value, imageUrl, showOnFirstPage, dateFrom, dateTo) VALUES (@name, @value, @imageUrl, @showOnFirstPage, @dateFrom, @dateTo); SELECT SCOPE_IDENTITY()", objConn))
                {
                    objConn.Open();
                    objComm.Parameters.Add("@name", SqlDbType.NVarChar, 50).Value = promotion.Name;
                    objComm.Parameters.Add("@value", SqlDbType.Float).Value = promotion.Value;
                    objComm.Parameters.Add("@imageUrl", SqlDbType.NVarChar, 50).Value = promotion.ImageUrl;
                    objComm.Parameters.Add("@showOnFirstPage", SqlDbType.Bit).Value = promotion.ShowOnFirstPage;
                    objComm.Parameters.Add("@dateFrom", SqlDbType.Date).Value = promotion.DateFrom;
                    objComm.Parameters.Add("@dateTo", SqlDbType.Date).Value = promotion.DateTo;

                    promotionID = int.Parse(objComm.ExecuteScalar().ToString());
                }
            }
            return promotionID;
        }

        public int UpdatePromotion(Promotion promotion)
        {
            int status = 0;
            using (SqlConnection objConn = new SqlConnection(WebConfigurationManager.ConnectionStrings["eshopConnectionString"].ConnectionString))
            {
                using (SqlCommand objComm = new SqlCommand("UPDATE promotion SET name=@name, value=@value, imageUrl=@imageUrl, showOnFirstPage=@showOnFirstPage, dateFrom=@dateFrom, dateTo=@dateTo WHERE promotionID=@promotionID", objConn))
                {
                    objConn.Open();
                    objComm.Parameters.Add("@name", SqlDbType.NVarChar, 50).Value = promotion.Name;
                    objComm.Parameters.Add("@value", SqlDbType.Float).Value = promotion.Value;
                    objComm.Parameters.Add("@imageUrl", SqlDbType.NVarChar, 50).Value = promotion.ImageUrl;
                    objComm.Parameters.Add("@promotionID", SqlDbType.Int).Value = promotion.PromotionID;
                    objComm.Parameters.Add("@showOnFirstPage", SqlDbType.Bit).Value = promotion.ShowOnFirstPage;
                    objComm.Parameters.Add("@dateFrom", SqlDbType.Date).Value = promotion.DateFrom;
                    objComm.Parameters.Add("@dateTo", SqlDbType.Date).Value = promotion.DateTo;

                    status = objComm.ExecuteNonQuery();
                }
            }
            return status;
        }

        public List<Promotion> GetPromotions(bool? showOnFirstPage)
        {
            List<Promotion> promotions = null;
            using (SqlConnection objConn = new SqlConnection(WebConfigurationManager.ConnectionStrings["eshopConnectionString"].ConnectionString))
            {
                using (SqlCommand objComm = new SqlCommand("SELECT promotionID, name, value FROM promotion", objConn))
                {
                    objConn.Open();
                    if (showOnFirstPage != null)
                    {
                        objComm.CommandText += " WHERE showOnFirstPage=@showOnFirstPage";
                        objComm.Parameters.Add("@showOnFirstPage", SqlDbType.Bit).Value = showOnFirstPage;
                        objComm.CommandText += " AND dateFrom<=GETDATE() AND dateTo>=GETDATE()";
                    }
                    objComm.CommandText += " ORDER BY name";
                    using (SqlDataReader reader = objComm.ExecuteReader())
                    {
                        if (reader.HasRows)
                            promotions = new List<Promotion>();
                        while (reader.Read())
                            promotions.Add(new Promotion(reader.GetInt32(0), reader.GetString(1), reader.GetDouble(2), string.Empty, 0, false, DateTime.MinValue, DateTime.Now.AddDays(1)));
                    }
                }
            }
            return promotions;
        }

        public Promotion GetPromotion(int promotionID)
        {
            Promotion promotion = null;
            using (SqlConnection objConn = new SqlConnection(WebConfigurationManager.ConnectionStrings["eshopConnectionString"].ConnectionString))
            {
                using (SqlCommand objComm = new SqlCommand("SELECT promotionID, name, value, imageUrl, showOnFirstPage, dateFrom, dateTo FROM promotion WHERE promotionID=@promotionID", objConn))
                {
                    objConn.Open();
                    objComm.Parameters.Add("@promotionID", SqlDbType.Int).Value = promotionID;
                    using (SqlDataReader reader = objComm.ExecuteReader())
                    {
                        while (reader.Read())
                            promotion = new Promotion(reader.GetInt32(0), reader.GetString(1), reader.GetDouble(2), reader.GetString(3), 0, reader.GetBoolean(4), reader.GetDateTime(5), reader.GetDateTime(6));
                    }
                }
            }
            return promotion;
        }

        public int DeletePromotion(int promotionID)
        {
            int status = 0;
            using (SqlConnection objConn = new SqlConnection(WebConfigurationManager.ConnectionStrings["eshopConnectionString"].ConnectionString))
            {
                using (SqlCommand objComm = new SqlCommand("DELETE FROM promotion WHERE promotionID=@promotionID", objConn))
                {
                    objConn.Open();
                    objComm.Parameters.Add("@promotionID", SqlDbType.Int).Value = promotionID;
                    status = objComm.ExecuteNonQuery();
                }
            }
            return status;
        }
    }
}
