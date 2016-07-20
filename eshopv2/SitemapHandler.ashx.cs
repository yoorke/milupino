using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml;
using System.Text;
using eshopBL;
using eshopBE;
using System.Data;

namespace eshopv2
{
    /// <summary>
    /// Summary description for SitemapHandler1
    /// </summary>
    public class SitemapHandler1 : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            //context.Response.ContentType = "text/plain";
            //context.Response.Write("Hello World");

            context.Response.ContentType = "text/xml";
            using (XmlTextWriter writer = new XmlTextWriter(context.Response.OutputStream, Encoding.UTF8))
            {
                writer.WriteStartDocument();
                writer.WriteStartElement("urlset");
                writer.WriteAttributeString("xmlns", "http://www.sitemaps.org/schemas/sitemap/0.9");

                string url = "http://www.milupino.rs";
                writer.WriteStartElement("url");
                writer.WriteElementString("loc", url);
                writer.WriteEndElement();

                writer.WriteStartElement("url");
                writer.WriteElementString("loc", url + "/lista-zelja");
                writer.WriteEndElement();

                writer.WriteStartElement("url");
                writer.WriteElementString("loc", url + "/moj-nalog");
                writer.WriteEndElement();

                writer.WriteStartElement("url");
                writer.WriteElementString("loc", url + "/korpa");
                writer.WriteEndElement();

                writer.WriteStartElement("url");
                writer.WriteElementString("loc", url + "/porucivanje");
                writer.WriteEndElement();

                writer.WriteStartElement("url");
                writer.WriteElementString("loc", url + "/kontakt");
                writer.WriteEndElement();

                writer.WriteStartElement("url");
                writer.WriteElementString("loc", url + "/prijava");
                writer.WriteEndElement();

                writer.WriteStartElement("url");
                writer.WriteElementString("loc", url + "/registracija");
                writer.WriteEndElement();

                foreach (CustomPage customPage in new CustomPageBL().GetCustomPages())
                {
                    writer.WriteStartElement("url");
                    writer.WriteElementString("loc", url + "/" + customPage.Url);
                    writer.WriteEndElement();
                }

                DataTable categories = new CategoryBL().GetCategories();
                for (int i = 0; i < categories.Rows.Count; i++)
                {
                    writer.WriteStartElement("url");
                    writer.WriteElementString("loc", url + categories.Rows[i]["url"].ToString());
                    writer.WriteEndElement();

                    foreach (Product product in new ProductBL().GetProductsForCategory(int.Parse(categories.Rows[i]["categoryID"].ToString()), true, true))
                    {
                        writer.WriteStartElement("url");
                        writer.WriteElementString("loc", url + product.Url);
                        writer.WriteEndElement();
                    }
                }

                writer.WriteEndElement();
                writer.WriteEndDocument();
                writer.Flush();

                context.Response.End();

            }
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}