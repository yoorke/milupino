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
    public partial class kimtecCategories : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (User.Identity.IsAuthenticated && User.IsInRole("Administrator"))
            {
                if (!Page.IsPostBack)
                {
                    dgvCategories.DataSource = new KimtecBL().GetNestedCategoriesDataTable();
                    dgvCategories.DataBind();
                }
            }
            else
                Response.Redirect("/administrator/login.aspx?returnUrl=" + Request.RawUrl.Substring(15,Request.RawUrl.Length-15));
        }

        protected void chkShowAsRoot_CheckedChanged(object sender, EventArgs e)
        {
            CheckBox checkBox = (CheckBox)sender;
            DataGridItem row = (DataGridItem)checkBox.NamingContainer;

            new KimtecBL().SetIsRoot(int.Parse(((Label)row.FindControl("lblKimtecCategoryID")).Text), bool.Parse(((CheckBox)row.FindControl("chkShowAsRoot")).Checked.ToString()));
        }
    }
}
