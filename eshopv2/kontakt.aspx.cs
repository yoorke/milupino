using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using eshopUtilities;
using System.Configuration;

namespace eshopv2
{
    public partial class kontakt : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            txtEmail.Focus();
            canonicalUrl.Text = @"<link rel=""canonical"" href=""" + ConfigurationManager.AppSettings["webShopUrl"] + "/kontakt" + @"""/>";
        }

        protected void btnSend_Click(object sender, EventArgs e)
        {
            try
            {
                Common.SendMessage(txtEmail.Text, txtSubject.Text, txtMessage.Text);
                lblStatus.Text = "Vaša poruka je uspešno poslata.";
            }
            catch
            {
                lblStatus.Text = "Greška prilikom slanja";
                
            }
            lblStatus.Visible = true;
            rowStatus.Visible = true;
        }
    }
}