using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using eshopBL;
using eshopUtilities;

namespace eshopv2
{
    public partial class passwordChange : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!User.Identity.IsAuthenticated)
                Response.Redirect("~/prijava?returnUrl=" + Page.Request.RawUrl);
            txtPassword.Focus();
        }

        protected void btnChangePassword_Click(object sender, EventArgs e)
        {
            try
            {
                if (checkValues())
                {
                    string status = new UserBL().ChangePassword(User.Identity.Name, txtPassword.Text, txtNewPassword.Text);
                    divStatus.Visible = true;
                    lblStatus.Text = status;
                    divStatus.Attributes["class"] = "status success";
                }
                else
                {
                    divStatus.Visible = true;
                    lblStatus.Text = "Morate uneti podatke. Polje 'Nova šifra' i 'Nova šifra ponovo' moraju da budu identična.";
                    divStatus.Attributes["class"] = "status danger";
                }
            }
            catch (BLException ex)
            {
                divStatus.Visible = true;
                lblStatus.Text = ex.Message;
                divStatus.Attributes["class"] = "status danger";
            }
        }

        private bool checkValues()
        {
            return txtPassword.Text.Length > 0 && txtNewPassword.Text.Length > 0 && txtNewPassword.Text.Equals(txtNewPasswordConfirm.Text);
        }
    }
}