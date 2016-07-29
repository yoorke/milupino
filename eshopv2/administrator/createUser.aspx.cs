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

namespace eshopv2.administrator
{
    public partial class createUser : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void CreateUserWizard1_CreatingUser(object sender, LoginCancelEventArgs e)
        {
            (Membership.Provider as CustomMembershipProvider).FirstName = (CreateUserWizard1.CreateUserStep.ContentTemplateContainer.FindControl("txtFirstName") as TextBox).Text;
            (Membership.Provider as CustomMembershipProvider).LastName = (CreateUserWizard1.CreateUserStep.ContentTemplateContainer.FindControl("txtLastName") as TextBox).Text;
            (Membership.Provider as CustomMembershipProvider).Address = string.Empty;
            (Membership.Provider as CustomMembershipProvider).City = string.Empty;
            (Membership.Provider as CustomMembershipProvider).Phone = string.Empty;
            (Membership.Provider as CustomMembershipProvider).UserType = (CreateUserWizard1.CreateUserStep.ContentTemplateContainer.FindControl("cmbUserType") as DropDownList).SelectedItem.Text;
            (Membership.Provider as CustomMembershipProvider).Zip = string.Empty;
        }

        protected void CreateUserWizard1_Load(object sender, EventArgs e)
        {
            DropDownList cmbUserType = (CreateUserWizard1.CreateUserStep.ContentTemplateContainer.FindControl("cmbUserType") as DropDownList);

            cmbUserType.DataSource = UserBL.GetUserTypes();
            cmbUserType.DataTextField = "name";
            cmbUserType.DataValueField = "userTypeID";
            cmbUserType.DataBind();
        }
    }
}
