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
using eshopUtilities;
using eshopBE;

namespace eshopv2.administrator
{
    public partial class customPages : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (User.Identity.IsAuthenticated && User.IsInRole("Administrator"))
            {
                if (!Page.IsPostBack)
                {
                    loadCustomPages();
                }
            }
            else
                Response.Redirect("/administrator/login.aspx?returnUrl=" + Page.Request.RawUrl);
        }

        protected void btnAddCustomPage_Click(object sender, EventArgs e)
        {
            Response.Redirect("/administrator/customPage.aspx");
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
        }

        protected void dgvCustomPages_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "deleteCustomPage")
            {
                CustomPage customPage = new CustomPageBL().GetCustomPage(int.Parse(e.CommandArgument.ToString()));
                new CustomPageBL().Delete(int.Parse(e.CommandArgument.ToString()));
                
                //Common.RemoveUrlRewrite(customPage.Url);
                loadCustomPages();
            }
            
        }

        protected void dgvCustomPages_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
        }

        private void loadCustomPages()
        {
            dgvCustomPages.DataSource = new CustomPageBL().GetCustomPages();
            dgvCustomPages.DataBind();
        }
    }
}
