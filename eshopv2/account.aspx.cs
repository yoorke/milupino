using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using eshopBE;
using eshopBL;
using System.Web.Security;
using System.Data;

namespace eshopv2
{
    public partial class account : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!User.Identity.IsAuthenticated)
                Response.Redirect("~/login.aspx?returnUrl=" + Page.Request.RawUrl);

            if (!Page.IsPostBack)
            {
                loadUser();
                loadOrders();
            }
        }

        private void loadUser()
        {
            User user = UserBL.GetUser(-1, HttpContext.Current.User.Identity.Name);

            txtFirstname.Text = user.FirstName;
            txtLastname.Text = user.LastName;
            txtEmail.Text = user.Email;
            txtAddress.Text = user.Address;
            txtCity.Text = user.City;
            txtZip.Text = user.Zip;
            txtPhone.Text = user.Phone;
        }

        private void loadOrders()
        {
            rptOrders.DataSource = new OrderBL().GetOrders(-1, DateTime.Parse("01/01/2015"), DateTime.Now.AddDays(1), int.Parse(Membership.GetUser().ProviderUserKey.ToString()));
            rptOrders.DataBind();
        }

        protected void rptOrders_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                ((Repeater)e.Item.FindControl("rptItems")).DataSource = new OrderBL().GetOrderItemsFull(int.Parse(((DataRowView)e.Item.DataItem)["orderID"].ToString()));
                ((Repeater)e.Item.FindControl("rptItems")).DataBind();
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            User user = new User();
            user.UserID = int.Parse(Membership.GetUser().ProviderUserKey.ToString());
            user.LastName = txtLastname.Text;
            user.FirstName = txtFirstname.Text;
            user.Email = txtEmail.Text;
            user.Address = txtAddress.Text;
            user.City = txtCity.Text;
            user.Zip = txtZip.Text;
            user.Phone = txtPhone.Text;

            new UserBL().UpdateUser(user);

            lblStatus.Text = "Podaci o korisniku uspešno izmenjeni.";
            divStatus.Visible = true;
            divStatus.Attributes["class"] = "status success";
        }

        protected void btnChangePassword_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/izmena-sifre");
        }

    }
}