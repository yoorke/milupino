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
using eshopBL;
using eshopUtilities;

namespace eshopv2.administrator
{
    public partial class orders : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (User.Identity.IsAuthenticated)
            {
                if (!Page.IsPostBack)
                {

                    loadStatuses();
                    txtDateFrom.Text = Common.ConvertToLocalTime(DateTime.UtcNow.AddMonths(-1)).ToShortDateString();
                    txtDateTo.Text = Common.ConvertToLocalTime(DateTime.UtcNow).ToShortDateString();
                    loadOrders();
                }
            }
            else Response.Redirect("/administrator/login.aspx?returnUrl=" + Page.Request.RawUrl);
        }

        private void loadOrders()
        {
            OrderBL orderBL = new OrderBL();
            dgvOrders.DataSource = orderBL.GetOrders(cmbStatus.SelectedIndex > 0 ? int.Parse(cmbStatus.SelectedValue) : -1, DateTime.Parse(txtDateFrom.Text), DateTime.Parse(txtDateTo.Text), null);
            dgvOrders.DataBind();
        }

        private void loadStatuses()
        {
            OrderBL orderBL = new OrderBL();
            cmbStatus.DataSource = orderBL.GetOrderStatuses(true);
            cmbStatus.DataTextField = "name";
            cmbStatus.DataValueField = "orderStatusID";
            cmbStatus.DataBind();
        }

        protected void dgvOrders_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                OrderBL orderBL = new OrderBL();
                int status = orderBL.DeleteOrder(int.Parse(dgvOrders.DataKeys[e.RowIndex].Values[0].ToString()));
                Response.Redirect("/administrator/orders.aspx");
            }
            catch (BLException ex)
            {
                
            }
        }

        protected void dgvOrders_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //if (((Label)e.Row.FindControl("lblStatus")).Text == "1")
                    //e.Row.BackColor = System.Drawing.Color.FromArgb(0);
                e.Row.BackColor = System.Drawing.ColorTranslator.FromHtml(((Label)e.Row.FindControl("lblColor")).Text);
            }
        }

        protected void btnShowOrders_Click(object sender, EventArgs e)
        {
            loadOrders();
        }
    }
}
