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
using eshopBE;

namespace eshopv2.administrator
{
    public partial class user : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (User.Identity.IsAuthenticated && User.IsInRole("administrator"))
            {
                if (!Page.IsPostBack)
                {
                    loadIntoForm();

                    int userID = (Request.QueryString.ToString().Contains("userID")) ? int.Parse(Request.QueryString["userID"]) : -1;
                    if (userID > 0)
                        loadUser(userID);
                }
                else
                {
                    Page.Title = ViewState["pageTitle"].ToString();
                }
            }
            else
                Page.Response.Redirect("/administrator/login.aspx?returnUrl=" + Page.Request.RawUrl.Substring(15, Page.Request.RawUrl.Length - 15));
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {

        }

        protected void btnSaveClose_Click(object sender, EventArgs e)
        {

        }

        protected void btnClose_Click(object sender, EventArgs e)
        {

        }

        private void loadIntoForm()
        {
            cmbUserType.DataSource = UserBL.GetUserTypes();
            cmbUserType.DataValueField = "userTypeID";
            cmbUserType.DataTextField = "name";
            cmbUserType.DataBind();
        }

        private void loadUser(int userID)
        {
            User user = UserBL.GetUser(userID, string.Empty);

            txtFirstName.Text = user.FirstName;
            txtLastName.Text = user.LastName;
            txtUsername.Text = user.Username;
            txtPassword.Text = user.Password;
            cmbUserType.SelectedValue = cmbUserType.Items.FindByValue(user.UserType.UserTypeID.ToString()).Value;
            txtEmail.Text = user.Email;
            Page.Title = user.Username;
            ViewState.Add("pageTitle", user.Username);
        }

        private void saveUser()
        {
            
        }

        protected void CreateUserWizard1_CreatingUser(object sender, LoginCancelEventArgs e)
        {
            
        }
    }
}
