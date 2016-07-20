using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using eshopBE;
using eshopBL;
using eshopUtilities;
using System.Collections.Generic;

namespace eshopv2.user_controls
{
    public partial class CheckoutV2 : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (HttpContext.Current.User.Identity.IsAuthenticated)
            {
                if (!Page.IsPostBack)
                    loadUser();

                if (HttpContext.Current.User.Identity.IsAuthenticated)
                    pnlLogin.Visible = false;
                else
                    pnlLogin.Visible = true;
            }
        }

        protected void btnOrder_Click(object sender, EventArgs e)
        {
            try
            {
                int userID=1;
                if (chkCreateAccount.Checked)
                {
                    userID = createUser();
                    if (userID > 0)
                        FormsAuthentication.SetAuthCookie(txtEmail.Text, true);
                }
                else if (Membership.GetUser() != null)
                    userID = int.Parse(Membership.GetUser().ProviderUserKey.ToString());
                else userID = 42;
                Order order = createOrder(userID);
                

                Common.SendOrderConfirmationMail(txtEmail.Text, txtFirstname.Text + " " + txtLastname.Text, order);
                Common.SendNewOrderNotification(order.OrderID.ToString(), order);
                Server.Transfer("/orderSuccessful.aspx");
            }
            catch (BLException ex)
            {
                setStatus(ex.Message, System.Drawing.Color.Red, true);
            }
        }

        private List<OrderItem> getItems()
        {
            CartBL cartBL = new CartBL();
            DataTable cartItems = cartBL.GetProducts(Session["cartID"].ToString());

            List<OrderItem> items = new List<OrderItem>();
            for (int i = 0; i < cartItems.Rows.Count; i++)
            {
                items.Add(new OrderItem(-1, -1,  new ProductBL().GetProduct(int.Parse(cartItems.Rows[i]["productID"].ToString()), string.Empty, false), double.Parse(cartItems.Rows[i]["productPrice"].ToString()), double.Parse(cartItems.Rows[i]["userPrice"].ToString()), double.Parse(cartItems.Rows[i]["quantity"].ToString())));
            }
            return items;
        }

        private Order createOrder(int userID)
        {
            Order order = new Order();
            order.Date = DateTime.Now.ToUniversalTime();
            order.Firstname = txtFirstname.Text;
            order.Lastname = txtLastname.Text;
            order.Address = txtAddress.Text;
            order.City = txtCity.Text;
            order.Phone = txtPhone.Text;
            order.Email = txtEmail.Text;
            order.Items = getItems();
            order.User = new User(userID, string.Empty, string.Empty, string.Empty, string.Empty, string.Empty, string.Empty, string.Empty, null, string.Empty, string.Empty, DateTime.Now, string.Empty);
            order.Name = (rdbUserType.SelectedValue == "2") ? txtCompanyName.Text : string.Empty;
            order.Pib = (rdbUserType.SelectedValue == "2") ? txtPib.Text : string.Empty;
            order.Payment = (order.Name != string.Empty) ? new Payment(int.Parse(rdbPaymentCompany.SelectedValue), rdbPaymentCompany.SelectedItem.Text) : new Payment(int.Parse(rdbPayment.SelectedValue.ToString()), rdbPayment.SelectedItem.Text);
            order.Delivery = new Delivery(int.Parse(rdbDelivery.SelectedValue.ToString()), rdbDelivery.SelectedItem.Text);
            CartBL cartBL = new CartBL();
            order.Coupon = new Coupon(cartBL.GetCartCoupon(Session["cartID"].ToString()), string.Empty, 0, string.Empty);
            order.OrderStatus = new OrderStatus(1, string.Empty);
            order.Zip = txtZip.Text;
            order.Comment = txtRemark.Text;
            order.CartID = Session["cartID"].ToString();


            OrderBL orderBL = new OrderBL();
            orderBL.SaveOrder(order);
            return order;
        }

        private int createUser()
        {
            return UserBL.SaveUser(txtFirstname.Text, txtLastname.Text, txtEmail.Text, string.Empty, txtEmail.Text, txtAddress.Text, txtCity.Text, txtPhone.Text, "kupac", txtZip.Text);
        }

        private void loadUser()
        {
            User user = UserBL.GetUser(-1, HttpContext.Current.User.Identity.Name);

            txtFirstname.Text = user.FirstName;
            txtLastname.Text = user.LastName;
            txtEmail.Text = user.Email;
            txtAddress.Text = user.Address;
            txtCity.Text = user.City;
            txtPhone.Text = user.Phone;
            txtZip.Text = user.Zip;

            chkCreateAccount.Checked = false;
            chkCreateAccount.Enabled = false;
        }

        private void setStatus(string text, System.Drawing.Color color, bool visible)
        {
            csStatus.Text = text;
            //csStatus.ForeColor = color;
            csStatus.Visible = visible;
            csStatus.Show();
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect(Page.ResolveUrl("~/korpa"));
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (Membership.ValidateUser(txtUsername.Text, txtPassword.Text))
            {
                FormsAuthentication.SetAuthCookie(txtUsername.Text, true);
                Response.Redirect("/checkout.aspx");
            }
            else
                setStatus("Prijava nije uspešna", System.Drawing.Color.Red, true);
        }
    }
}