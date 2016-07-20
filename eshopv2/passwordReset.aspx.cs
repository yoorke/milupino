using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using eshopBL;
using eshopBE;

namespace eshopv2
{
    public partial class passwordReset : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                if (Page.Request.QueryString.ToString().Contains("id"))
                {
                    string token = Page.Request.QueryString["id"];
                    if (validToken(token))
                    {
                        txtPassword.Focus();
                    }
                    else
                    {
                        divPasswordReset.Visible = false;
                        divMessageBox.Visible = true;
                        lblMessage.Text = "Korisnik za kojeg ste zahtevali resetovanje šifre ne postoji ili je period za reset šifre istekao.";
                    }
                }
            }
        }

        private bool validToken(string token)
        {
            User user = new UserBL().GetUserFromToken(token);
            if (user != null)
            {
                txtUsername.Text = user.Username;
                lblUserID.Value = user.UserID.ToString();
                return true;
            }

            return false;
        }

        protected void btnChangePassword_Click(object sender, EventArgs e)
        {
            if (lblUserID.Value != null)
            {
                if (txtPassword.Text == txtPasswordConfirm.Text)
                {
                    if (new UserBL().ChangePassword(int.Parse(lblUserID.Value), txtPassword.Text))
                        Server.Transfer("/passwordChanged.aspx");
                }
                else
                {
                    divMessageBox.Visible = true;
                    lblMessage.Text = "Uneta šifra se ne poklapa sa šifrom u polju: Potvrdite šifru";
                }
            }
            

        }
    }
}