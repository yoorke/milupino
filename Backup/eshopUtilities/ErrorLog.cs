using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using System.Web;
using System.Data.SqlClient;

namespace eshopUtilities
{
    public class ErrorLog
    {
        public static void LogError(Exception ex)
        {
            int code = 0;
            string message = string.Empty;

            if (ex is SqlException)
                code = ((SqlException)ex).Number;
            message = ex.Message;

            using (StreamWriter sw = new StreamWriter(HttpContext.Current.Server.MapPath("/") + "error.log", true))
                sw.WriteLine(DateTime.Now.ToString() + " - " + code.ToString() + " - " + message);

            if (ex.InnerException != null)
                LogError(ex.InnerException);
        }

        public static void LogMessage(string message)
        {
            using (StreamWriter sw = new StreamWriter(HttpContext.Current.Server.MapPath("/") + "/error.log", true))
                sw.WriteLine(DateTime.Now.ToString() + " - " + message);
        }
    }
}
