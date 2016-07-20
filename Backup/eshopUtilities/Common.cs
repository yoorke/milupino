using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.ComponentModel;
using System.Net.Mail;
using System.Net;
using System.Web.Configuration;
using System.Configuration;
using System.Collections.Specialized;
using System.Xml;
using System.Web;
using System.Drawing;
using System.Drawing.Imaging;
using System.Drawing.Drawing2D;
using eshopBE;

namespace eshopUtilities
{
    public static class Common
    {
        public static DataTable ConvertToDataTable<T>(this IEnumerable<T> data)
        {
            List<IDataRecord> list = data.Cast<IDataRecord>().ToList();

            PropertyDescriptorCollection props = null;
            DataTable table = new DataTable();
            if (list != null && list.Count > 0)
            {
                props = TypeDescriptor.GetProperties(list[0]);
                for (int i = 0; i < props.Count; i++)
                {
                    PropertyDescriptor prop = props[i];
                    table.Columns.Add(prop.Name, Nullable.GetUnderlyingType(prop.PropertyType) ?? prop.PropertyType);
                }
            }
            if (props != null)
            {
                object[] values = new object[props.Count];
                foreach (T item in data)
                {
                    for (int i = 0; i < values.Length; i++)
                    {
                        values[i] = props[i].GetValue(item) ?? DBNull.Value;
                    }
                    table.Rows.Add(values);
                }
            }
            return table;
        }

        public static int SendOrderConfirmationMail(string email, string name, Order order)
        {
            MailMessage message = new MailMessage();
            //message.From = new MailAddress("office@pinservis.com");
            message.From = new MailAddress(ConfigurationManager.AppSettings["orderEmail"]);
            message.To.Add(new MailAddress(email));
            //message.CC.Add(new MailAddress("info@pinservis.co.rs.gladiolus.arvixe.com"));
            message.Subject = "Potvrda narudžbine - " + ConfigurationManager.AppSettings["companyName"];
            message.BodyEncoding=Encoding.UTF8;
            message.IsBodyHtml = true;
            StringBuilder body = new StringBuilder();
            body.Append("<img src='" + ConfigurationManager.AppSettings["logoUrl"].ToString() + "' style='width:100px;margin-bottom:20px' />");
            body.Append("<h1>Potvrda porudžbine</h1>");
            body.Append("<br/><strong>Poštovani " + name + "</strong><br><br>Vaša porudžbina je uspešno prosleđena.");
            body.Append("<br/><br/>U nastavku možete videti detalje Vaše narudžbine");
            body.Append("<br/><br/>");
            body.Append("<table width='100%' border='0'>");
            body.Append("<tr bgcolor='#cccccc'>");
            body.Append("<th align='center'>Rbr</th><th>Naziv</th><th>Količina</th><th>Cena</th><th>Ukupno</th>");
            body.Append("</tr>");
            
            for(int i=0;i<order.Items.Count;i++)
            {
                
                body.Append("<tr height='20px' valign='middle'>");
                body.Append("<td align='center'>" + (i + 1).ToString() + "</td><td>" + order.Items[i].ProductID.ToString() + "</td><td align='right'>" + order.Items[i].Quantity.ToString() + "</td><td align='right'>" + string.Format("{0:N2}", order.Items[i].UserPrice) + "</td><td align='right'>" + string.Format("{0:N2}", order.Items[i].Quantity * order.Items[i].UserPrice) + "</td>");
                body.Append("</tr>");
            }

            body.Append("<br/>");
            if(order.Lastname != string.Empty || order.Firstname != string.Empty)
                body.Append("<p><strong>Prezime i ime: </strong>" + order.Lastname + " " + order.Firstname + "</p>");
            else if (order.Name != string.Empty)
            {
                body.Append("<p><strong>Naziv: </strong>" + order.Name + "</p>");
                body.Append("<p><strong>PIB: </strong>" + order.Pib + "</p>");
            }
            body.Append("<p><strong>Adresa: </strong>" + order.Address + " " + order.Code + " " + order.City + " " + order.Zip + "</p>");
            body.Append("<p><strong>Telefon: </strong>" + order.Phone + "</p>");
            body.Append("<p><strong>Način plaćanja: </strong>" + order.Payment + "</p>");
            body.Append("<p><strong>Način preuzimanja: </strong>" + order.Delivery + "</p>");
            body.Append("<p><strong>Napomena: </strong>" + order.Comment + "</p>");
            
            body.Append("<br/><br/>Vaša online prodavnica ");
            body.Append("<span style='font-weight:bold;color:#174e87'>PinShop</span>");
            message.Body = body.ToString();


            SmtpClient smtp = getSmtp(message.From.ToString(), "orderEmail");
            smtp.Send(message);

            return 0;
        }

        public static int SendUserCreatedConfirmationMail(string email, string password)
        {
            try
            {
                MailMessage message = new MailMessage();
                //message.From = new MailAddress("office@pinservis.com");
                message.From = new MailAddress(ConfigurationManager.AppSettings["infoEmail"].ToString(), ConfigurationManager.AppSettings["companyName"].ToString());
                //message.From = new MailAddress("office@pinshop.co.rs");
                message.To.Add(new MailAddress(email));
                message.Subject = "Korisnički nalog kreiran - " + ConfigurationManager.AppSettings["companyName"];
                message.BodyEncoding = Encoding.UTF8;
                StringBuilder body = new StringBuilder();
                body.Append("<img src='" + ConfigurationManager.AppSettings["logoUrl"].ToString() + "' style='width:150px;margin-bottom:20px' /><br/>Poštovani,<br/><br/>Vaš korisnički nalog na web portalu <a href='" + ConfigurationManager.AppSettings["webShopUrl"] + "'>" + ConfigurationManager.AppSettings["companyName"] + "</a> je uspešno kreiran.<br/><br/>");
                body.Append("<br/>Za pristup portalu možete koristiti sledeće korisničke podatke:<br/><br/>Vaše korisničko ime je: <b>" + email + "</b><br>Vaša šifra je: <b>" + password+"</b><br/>");
                body.Append("<br/>Za prijavu koristite stranicu <a href='" + ConfigurationManager.AppSettings["webShopLoginUrl"] + "'>Prijava</a>");
                body.Append("<br/><br/>Vaša online prodavnica ");
                body.Append("<span style='font-weight:bold;color:#174e87'>PinShop</span>");
                message.Body = body.ToString();
                message.IsBodyHtml = true;

                SmtpClient smtp = getSmtp(message.From.ToString(), "infoEmail");
                smtp.Send(message);
            }
            catch (Exception ex)
            {
                throw new BLException("Nije moguće poslati mail", ex);
            }
            return 0;
        }

        private static SmtpClient getSmtp(string email, string type)
        {
            SmtpClient smtp = new SmtpClient();
            NetworkCredential networkCredential = new NetworkCredential(email, ConfigurationManager.AppSettings[type + "Password"].ToString());
            //NetworkCredential networkCredential = new NetworkCredential("office@pinshop.co.rs", "webprodaja023");
            smtp.UseDefaultCredentials = false;
            smtp.Credentials = networkCredential;
            smtp.Host = ConfigurationManager.AppSettings["smtp"].ToString();
            //smtp.Host = "mail.pinshop.co.rs";
            smtp.Port = 25;
            smtp.EnableSsl = false;

            return smtp;
        }

        public static string CreateFriendlyUrl(string url)
        {
            url = url.ToLower();
            char[] notAllwed = { 'š', 'ć', 'č', 'ž', ',', '.', '"', ' ', '(', ')' };
            char[] replacement = { 's', 'c', 'c', 'z', '-', '-', '-', '-', '-', '-' };

            url = url.Replace("\n", "-");
            for (int i = 0; i < notAllwed.Length; i++)
                url = url.Replace(notAllwed[i], replacement[i]);

            url = url.Replace("đ", "dj");

            url = url.Replace("--", "-");
            url = url.Replace("---", "-");
            url = url.Trim();

            return url;
        }

        public static void SendOrder()
        {
            MailMessage mail = new MailMessage();
            mail.From = new MailAddress("office@pinservis.com");
            mail.To.Add(new MailAddress("office@pinservis.com"));
            mail.Subject = "Nova porudžbina";
            mail.BodyEncoding=Encoding.UTF8;
            mail.Body="Imate novu porudžbinu sa sajta.<br/>Sve porudžbine možete videti na stranici <a href='http://www.pinservis.co.rs/administrator/orders.aspx'>www.pinservis.co.rs/administrator/orders.aspx</a>";
            mail.IsBodyHtml=true;

            //SmtpClient smtp = getSmtp();
            //smtp.Send(mail);
        }

        public static void AddUrlRewrite(string url, string page)
        {
            //Configuration configuration = WebConfigurationManager.OpenWebConfiguration("~");
            //NameValueCollection collection = WebConfigurationManager.GetSection("rewriter") as NameValueCollection;
            //System.Configuration.DefaultSection rewriter = (System.Configuration.DefaultSection)configuration.GetSection("rewriter");
            //foreach (string key in rewriter.ElementInformation.Properties.Keys)
                //continue;

            XmlDocument doc = new XmlDocument();
            doc.Load(HttpContext.Current.Server.MapPath("~/Web.config"));

            XmlNode rewriterNode = doc.DocumentElement.SelectSingleNode("rewriter");

            XmlElement element = doc.CreateElement("rewrite");
            element.SetAttribute("url", "^/" + url + "/?$");
            element.SetAttribute("to", "~/customPage.aspx?url=$0");
            element.SetAttribute("processing", "stop");

            rewriterNode.AppendChild(element);

            doc.Save(HttpContext.Current.Server.MapPath("~/Web.config"));
        }

        public static void RemoveUrlRewrite(string url)
        {
            XmlDocument doc = new XmlDocument();
            doc.Load(HttpContext.Current.Server.MapPath("~/Web.config"));

            XmlNode rewriteNode = doc.DocumentElement.SelectSingleNode("rewriter");
            foreach (XmlNode node in rewriteNode.ChildNodes)
                if (node.Attributes["url"].Value.ToString().Contains(url))
                {
                    rewriteNode.RemoveChild(node);
                    break;
                }
            doc.Save(HttpContext.Current.Server.MapPath("~/Web.config"));
        }

        public static Image CreateThumb(Image imgPhoto, int Width, int Height)
        {
            int sourceWidth = imgPhoto.Width;
            int sourceHeight = imgPhoto.Height;
            int sourceX = 0;
            int sourceY = 0;
            int destX = 0;
            int destY = 0;

            float nPercent = 0;
            float nPercentW = 0;
            float nPercentH = 0;

            nPercentW = ((float)Width / (float)sourceWidth);
            nPercentH = ((float)Height / (float)sourceHeight);
            if (nPercentH < nPercentW)
            {
                nPercent = nPercentH;
                destX = System.Convert.ToInt16((Width -
                              (sourceWidth * nPercent)) / 2);
            }
            else
            {
                nPercent = nPercentW;
                destY = System.Convert.ToInt16((Height -
                              (sourceHeight * nPercent)) / 2);
            }

            int destWidth = (int)(sourceWidth * nPercent);
            int destHeight = (int)(sourceHeight * nPercent);

            Bitmap bmPhoto = new Bitmap(Width, Height,
                              PixelFormat.Format24bppRgb);
            bmPhoto.SetResolution(imgPhoto.HorizontalResolution,
                             imgPhoto.VerticalResolution);

            Graphics grPhoto = Graphics.FromImage(bmPhoto);
            grPhoto.Clear(Color.White);
            grPhoto.InterpolationMode =
                    InterpolationMode.HighQualityBicubic;

            grPhoto.DrawImage(imgPhoto,
                new Rectangle(destX, destY, destWidth, destHeight),
                new Rectangle(sourceX, sourceY, sourceWidth, sourceHeight),
                GraphicsUnit.Pixel);

            grPhoto.Dispose();
            return bmPhoto;
        }
    }
}
