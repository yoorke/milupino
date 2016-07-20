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
    public class CouponDL
    {
        public Coupon GetCoupon(string code)
        {
            Coupon coupon = null;
            using (SqlConnection objConn = new SqlConnection(WebConfigurationManager.ConnectionStrings["eshopConnectionString"].ConnectionString))
            {
                using (SqlCommand objComm = new SqlCommand("getCouponByCode", objConn))
                {
                    objConn.Open();
                    objComm.Parameters.Add("@code", SqlDbType.NChar, 10).Value = code;
                    objComm.CommandType = CommandType.StoredProcedure;
                    using (SqlDataReader reader = objComm.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            coupon = new Coupon(reader.GetInt32(0), reader.GetString(1), reader.GetDouble(2), code);
                        }
                    }
                }
            }
            return coupon;
        }
    }
}
