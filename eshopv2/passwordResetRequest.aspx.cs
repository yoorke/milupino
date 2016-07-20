using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using eshopBE;
using eshopBL;

namespace eshopv2
{
    public partial class passwordResetRequest : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            txtEmail.Focus();
        }

        protected void btnSendRequest_Click(object sender, EventArgs e)
        {
            if (txtEmail.Text != string.Empty)
            {
                if (new UserBL().CreatePasswordResetToken(txtEmail.Text))
                    Server.Transfer("/passwordResetMailSent.aspx");
                else
                {
                    divMessageBox.Visible = true;
                    lblMessage.Text = "Ne postoji korisniči nalog za unetu email adresu";
                }
            }
        }
    }
}