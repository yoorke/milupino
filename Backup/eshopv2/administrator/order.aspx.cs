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
            print.Tables[0].Columns.Add("total");
            print.Tables[0].Columns.Add("code");

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

            CrystalDecisions.CrystalReports.Engine.ReportDocument rp = new CrystalDecisions.CrystalReports.Engine.ReportDocument();
            rp.Load(Server.MapPath("~") + "/administrator/reports/rptOrder.rpt");
            rp.SetDataSource(print);
            Session.Add("orderRp", rp);

            Response.Redirect("/administrator/print.aspx");
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
