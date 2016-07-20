using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using eshopBE;
using eshopBL;
using eshopUtilities;
using System.Web.Security;

namespace eshopv2
{
    public partial class registration : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            txtLastname.Focus();
            botDetect1.UserInputClientID = CaptchaCode.ClientID;
        }

        protected void btnCreateUser_Click(object sender, EventArgs e)
        {
            try
            {
                if (botDetect1.Validate(CaptchaCode.Text))
                {
                    if (checkData())
                    {
                        //User user = new User();
                        MembershipCreateStatus status;
                        (Membership.Provider as CustomMembershipProvider).Address = txtAddress.Text;
                        (Membership.Provider as CustomMembershipProvider).City = txtCity.Text;
                        (Membership.Provider as CustomMembershipProvider).FirstName = txtFirstname.Text;
                        (Membership.Provider as CustomMembershipProvider).LastName = txtLastname.Text;
                        (Membership.Provider as CustomMembershipProvider).Phone = txtPhone.Text;
                        (Membership.Provider as CustomMembershipProvider).Zip = txtZip.Text;
                        (Membership.Provider as CustomMembershipProvider).UserType = "kupac";
                        MembershipUser user = Membership.CreateUser(txtEmail.Text, txtPassword.Text, txtEmail.Text, "1", "1", true, out status);

                        if (status == MembershipCreateStatus.Success)
                        {
                            divRegistration.Visible = false;
                            divLoginMessage.Visible = true;
                            lblLoginText.InnerText = "Korisnički nalog je uspešno kreiran";
                        }
                    }
                    else
                    {
                        divLoginMessage.Visible = true;
                        lblLoginText.InnerText = "Unesite sve obavezne podatke.";
                    }
                }
                else
                    CaptchaErrorLabel.Text = "ewrwer";
            }
            catch (Exception ex)
            {
                divLoginMessage.Visible = true;
                lblLoginText.InnerText = ex.Message;
            }
        }

        private bool checkData()
        {
            bool isValid = true;
            int zip;

            if (txtLastname.Text.Trim() == string.Empty)
                isValid = false;
            else if (txtFirstname.Text.Trim() == string.Empty)
                isValid = false;
            else if(txtAddress.Text.Trim() == string.Empty)
                isValid = false;
            else if (txtZip.Text.Trim() == string.Empty || !int.TryParse(txtZip.Text, out zip))
                isValid = false;
            else if(txtCity.Text.Trim() == string.Empty)
                isValid = false;
            else if(txtPhone.Text.Trim() == string.Empty)
                isValid = false;
            else if(txtEmail.Text.Trim() == string.Empty || !Common.IsValidEmail(txtEmail.Text) || new UserBL().UserExists(txtEmail.Text))
                isValid = false;
            else if(txtPassword.Text.Trim() == string.Empty || txtPassword.Text.Length < 8)
                isValid = false;
            else if(!txtConfirmPassword.Text.Equals(txtPassword.Text))
                isValid =false;

            return isValid;
        
        }
    }
}