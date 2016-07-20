using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Xml.Linq;
using eshopBE;
using eshopBL;
using eshopUtilities;
using System.Text;
using NReco.PdfGenerator;

namespace eshopv2.administrator
{
    public partial class order : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                int orderID = 0;
                if (Request.QueryString.ToString().Contains("orderID"))
                {
                    loadStatuses();
                    orderID = int.Parse(Request.QueryString["orderID"]);
                    loadOrder(orderID);
                }
            }
        }

        private void loadOrder(int orderID)
        {
            OrderBL orderBL = new OrderBL();
            Order order = orderBL.GetOrder(orderID);

            lblDate.Text = order.Date.ToString();
            lblFirstname.Text = order.Firstname;
            lblLastname.Text = order.Lastname;
            lblUserType.Text = lblName.Text.Length > 0 ? "Pravno lice" : "Fizičko lice";//order.UserType;
            lblName.Text = order.Name.Length > 0 ? order.Name : "-";
            lblPib.Text = order.Pib.Trim().Length > 0 ? order.Pib : "-";
            lblAddress.Text = order.Address;
            lblCity.Text = order.City;
            lblZip.Text = order.Zip;
            lblEmail.Text = order.Email;
            lblPhone.Text = order.Phone;
            lblComment.Text = order.Comment.Trim().Length > 0 ? order.Comment : "-";
            lblPayment.Text = order.Payment.Name;
            lblDelivery.Text = order.Delivery.Name;
            cmbStatus.SelectedValue = order.OrderStatus.OrderStatusID.ToString();
            lblCoupon.Text = order.Coupon.Name;
            lblCode.Text = order.Code;
            this.Title = "Narudžbenica - " + order.Firstname + " " + order.Lastname + " | Admin panel";
            lblOrderID.Value = order.OrderID.ToString();

            dgvItems.DataSource = orderBL.GetOrderItemsFull(orderID);
            dgvItems.DataBind();

            double total = 0;
            for (int i = 0; i < dgvItems.Rows.Count; i++)
            {
                total += double.Parse(((Label)dgvItems.Rows[i].FindControl("lblTotal")).Text);
            }

            lblTotal.Text = string.Format("{0:N2}", total);
        }

        private void loadStatuses()
        {
            OrderBL orderBL = new OrderBL();
            cmbStatus.DataSource = orderBL.GetOrderStatuses(false);
            cmbStatus.DataValueField = "orderStatusID";
            cmbStatus.DataTextField = "name";
            cmbStatus.DataBind();
        }

        protected void btnClose_Click(object sender, EventArgs e)
        {
            Response.Redirect("/administrator/orders.aspx");
        }

        protected void btnPrint_Click(object sender, EventArgs e)
        {
            DataSet print = new DataSet();
            print.Tables.Add("order");
            print.Tables[0].Columns.Add("number");
            print.Tables[0].Columns.Add("date");
            print.Tables[0].Columns.Add("firstName");
            print.Tables[0].Columns.Add("lastName");
            print.Tables[0].Columns.Add("name");
            print.Tables[0].Columns.Add("pib");
            print.Tables[0].Columns.Add("address");
            print.Tables[0].Columns.Add("city");
            print.Tables[0].Columns.Add("zip");
            print.Tables[0].Columns.Add("email");
            print.Tables[0].Columns.Add("phone");
            print.Tables[0].Columns.Add("comment");
            print.Tables[0].Columns.Add("payment");
            print.Tables[0].Columns.Add("delivery");
            print.Tables[0].Columns.Add("total", typeof(double));
            print.Tables[0].Columns.Add("code");
            print.Tables[0].Columns.Add("deliveryPrice", typeof(double));

            print.Tables.Add("orderItem");
            print.Tables[1].Columns.Add("code");
            print.Tables[1].Columns.Add("name");
            print.Tables[1].Columns.Add("webPrice");
            print.Tables[1].Columns.Add("userPrice");
            print.Tables[1].Columns.Add("quantity");
            print.Tables[1].Columns.Add("total");

            DataRow newRow = print.Tables[0].NewRow();
            newRow["number"] = "1";
            newRow["date"] = lblDate.Text;
            newRow["firstName"] = lblFirstname.Text;
            newRow["lastName"] = lblLastname.Text;
            newRow["name"] = lblName.Text;
            newRow["pib"] = lblPib.Text;
            newRow["address"] = lblAddress.Text;
            newRow["city"] = lblCity.Text;
            newRow["zip"] = lblZip.Text;
            newRow["email"] = lblEmail.Text;
            newRow["phone"] = lblPhone.Text;
            newRow["comment"] = lblComment.Text;
            newRow["payment"] = lblPayment.Text;
            newRow["delivery"] = lblDelivery.Text;
            newRow["total"] = lblTotal.Text;
            newRow["code"] = lblCode.Text;
            newRow["deliveryPrice"] = double.Parse(lblTotal.Text) > 10000 ? 0 : 350;
            print.Tables[0].Rows.Add(newRow);

            for (int i = 0; i < dgvItems.Rows.Count; i++)
            {
                newRow = print.Tables[1].NewRow();
                newRow["code"] = ((Label)dgvItems.Rows[i].FindControl("lblProductCode")).Text;
                newRow["name"] = ((Label)dgvItems.Rows[i].FindControl("lblProductName")).Text;
                newRow["webPrice"] = ((Label)dgvItems.Rows[i].FindControl("lblWebPrice")).Text;
                newRow["userPrice"] = ((Label)dgvItems.Rows[i].FindControl("lblPrice")).Text;
                newRow["quantity"] = ((Label)dgvItems.Rows[i].FindControl("lblQuantity")).Text;
                newRow["total"] = ((Label)dgvItems.Rows[i].FindControl("lblTotal")).Text;
                print.Tables[1].Rows.Add(newRow);
            }

            //CrystalDecisions.CrystalReports.Engine.ReportDocument rp = new CrystalDecisions.CrystalReports.Engine.ReportDocument();
            //rp.Load(Server.MapPath("~") + "/administrator/reports/rptOrder.rpt");
            //rp.SetDataSource(print);
            //Session.Add("orderRp", rp);

            //rp.ExportToDisk(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Server.MapPath("~/administrator/reports/" + lblCode.Text.Replace("/", "-") + ".pdf"));

            StringBuilder html = new StringBuilder();
            html.Append("<html><head><meta charset='UTF-8' /></head>");
            html.Append("<body>");
            html.Append("<br/><br/><span style='font-size:2em;font-weight:bold;text-align:center;width:100%;display:block'>Narudžbenica broj: " + lblCode.Text + "</span>");
            html.Append("<br/>");

            html.Append("<div style='width:100px;float:left;margin-top:20px'>");
            html.Append("<div><strong>Broj</strong></div>");
            html.Append("<div><strong>Datum</strong></div>");
            html.Append("<div><strong>Prezime i ime</strong></div>");
            html.Append("<div><strong>Naziv</strong></div>");
            html.Append("<div><strong>PIB</strong></div>");
            html.Append("<div><strong>Adresa</strong></div>");
            html.Append("<div><strong>Mesto</strong></div>");
            html.Append("<div><strong>Napomena</strong></div>");
            html.Append("</div>");

            html.Append("<div style='width:200px;float:left;margin-top:20px'>");
            html.Append("<div>" + lblCode.Text + "</div>");
            html.Append("<div>" +lblDate.Text + "</div>");
            html.Append("<div>" + lblFirstname.Text + " " + lblLastname.Text + "</div>");
            html.Append("<div>" + lblName.Text + "</div>");
            html.Append("<div>" + lblPib.Text + "</div>");
            html.Append("<div>" + lblAddress.Text + "</div>");
            html.Append("<div>" + lblCity.Text + "</div>");
            html.Append("<div>" + lblComment.Text + "</div>");
            html.Append("</div>");

            html.Append("<div style='width:100px;float:left;margin-top:20px'>");
            html.Append("<div><strong>Email</strong></div>");
            html.Append("<div><strong>Telefon</strong></div>");
            html.Append("<div><strong>Plaćanje</strong></div>");
            html.Append("<div><strong>Dostava</strong></div>");
            html.Append("</div>");

            html.Append("<div style='width:200px;float:left;margin-top:20px'>");
            html.Append("<div>" + lblEmail.Text + "</div>");
            html.Append("<div>" + lblPhone.Text + "</div>");
            html.Append("<div>" + lblPayment.Text + "</div>");
            html.Append("<div>" + lblDelivery.Text + "</div>");
            html.Append("</div>");

            html.Append("<br/><br/><br/>");
            html.Append("<div style='width:100%;float:left;margin-top:50px'>");
            html.Append("<table style='width:100%'>");
            html.Append("<tr>");
            html.Append("<th style='width:5%'>Rb</th>");
            html.Append("<th style='width:10%'>Šifra</th>");
            html.Append("<th style='width:50%'>Naziv</th>");
            html.Append("<th style='width:10%'>Cena</th>");
            html.Append("<th style='width:10%'>Količina</th>");
            html.Append("<th style='width:10%'>Ukupno</th>");
            html.Append("</tr>");
            for (int i = 0; i < dgvItems.Rows.Count; i++)
            {
                html.Append("<tr style='background-color:#" + (i % 2 == 0 ? "eeeeee" : "ffffff") + "'>");
                html.Append("<td>" + (i + 1).ToString() + "</td>");
                html.Append("<td>" + ((Label)dgvItems.Rows[i].FindControl("lblProductCode")).Text + "</td>");
                html.Append("<td>" + ((Label)dgvItems.Rows[i].FindControl("lblProductName")).Text + "</td>");
                html.Append("<td style='text-align:right'>" + ((Label)dgvItems.Rows[i].FindControl("lblPrice")).Text + "</td>");
                html.Append("<td style='text-align:right'>" + ((Label)dgvItems.Rows[i].FindControl("lblQuantity")).Text + "</td>");
                html.Append("<td style='text-align:right'>" + ((Label)dgvItems.Rows[i].FindControl("lblTotal")).Text + "</td>");
                html.Append("</tr>");
            }
            html.Append("</table>");
            html.Append("</div>");

            html.Append("<div style='float:right;padding:0.5em;background-color:#eeeeee;margin-top:20px'>");
            html.Append("<div><strong>Ukupno:</strong> " + lblTotal.Text + "</div>");
            html.Append("<div><strong>Dostava:</strong> " + (double.Parse(lblTotal.Text) > 10000 ? "0,00" : "350,00") + "</div>");
            html.Append("<div><strong>Ukupno:</strong> " + string.Format("{0:N2}", (double.Parse(lblTotal.Text) + (double.Parse(lblTotal.Text) > 10000 ? 0 : 350))) + "</div>");
            html.Append("</div>");

            html.Append("</body></html>");

            var htmlToPdf = new NReco.PdfGenerator.HtmlToPdfConverter();
            htmlToPdf.Margins.Top = 24;
            htmlToPdf.Margins.Left = 24;
            htmlToPdf.Margins.Right = 24;
            htmlToPdf.Margins.Bottom = 24;
            htmlToPdf.Size = NReco.PdfGenerator.PageSize.A4;

            var pdfBytes = htmlToPdf.GeneratePdf(html.ToString());

            System.IO.FileStream fs = new System.IO.FileStream(Server.MapPath("/administrator/pdf/" + lblCode.Text.Replace("/", "-") + ".pdf"), System.IO.FileMode.Create, System.IO.FileAccess.Write);
            fs.Write(pdfBytes, 0, pdfBytes.Length);
            fs.Close();

            Response.Redirect("/administrator/pdf/" + lblCode.Text.Replace("/", "-") + ".pdf");
        }

        protected void cmbStatus_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (cmbStatus.SelectedIndex > -1)
            {
                OrderBL orderBL = new OrderBL();
                orderBL.UpdateOrderStatus(int.Parse(lblOrderID.Value), int.Parse(cmbStatus.SelectedValue));
            }
        }

        protected void dgvItems_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                HyperLink lnkProduct = (HyperLink)e.Row.FindControl("lnkProduct");
                lnkProduct.NavigateUrl = "~/proizvodi/" + Common.CreateFriendlyUrl(((Label)e.Row.FindControl("lblCategory")).Text + "/" + ((Label)e.Row.FindControl("lblProductName")).Text + "-" + ((Label)e.Row.FindControl("lblProductID")).Text);
            }
        }
    }
}
