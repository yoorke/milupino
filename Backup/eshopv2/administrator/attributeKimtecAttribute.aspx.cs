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
    public partial class attributeKimtecAttribute : System.Web.UI.Page
    {
        DataTable kimtecAttributes;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (User.Identity.IsAuthenticated && User.IsInRole("administrator"))
            {
                if (!Page.IsPostBack)
                {
                    loadInfoForm();
                }
            }
            else
                Response.Redirect("/administrator/login.aspx?returnUrl=" + Page.Request.RawUrl.Substring(15, Page.Request.RawUrl.Length - 15));
        }

        private void loadAttributes()
        {

        }

        private void loadInfoForm()
        {
            cmbCategory.DataSource = new CategoryBL().GetCategories();
            cmbCategory.DataTextField = "name";
            cmbCategory.DataValueField = "categoryID";
            cmbCategory.DataBind();

            cmbKimtecCategory.DataSource = new KimtecBL().GetKimtecCategoriesWithAttribute();
            cmbKimtecCategory.DataTextField = "name";
            cmbKimtecCategory.DataValueField = "kimtecCategoryID";
            cmbKimtecCategory.DataBind();
        }

        protected void cmbCategory_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void cmbKimtecCategory_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void btnShowAttributes_Click(object sender, EventArgs e)
        {
            loadKimtecAttributes();
            //dgvAttribute.DataSource = new AttributeBL().GetAttributesForCategory(int.Parse(cmbCategory.SelectedValue));
            dgvAttribute.DataSource = new AttributeBL().GetAttributesForMapping(int.Parse(cmbCategory.SelectedValue), int.Parse(cmbKimtecCategory.SelectedValue));
            dgvAttribute.DataBind();
        }

        protected void dgvAttribute_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DropDownList cmbKimtecAttribute = ((DropDownList)e.Row.FindControl("cmbKimtecAttribute"));
                //cmbKimtecAttribute.DataSource = new KimtecBL().GetKimtecAttributesForCategory(int.Parse(cmbKimtecCategory.SelectedValue), true);
                cmbKimtecAttribute.DataSource = kimtecAttributes;
                cmbKimtecAttribute.DataTextField = "name";
                cmbKimtecAttribute.DataValueField = "kimtecAttributeID";
                cmbKimtecAttribute.DataBind();

                if (((Label)e.Row.FindControl("lblKimtecAttributeID")).Text != string.Empty)
                    cmbKimtecAttribute.SelectedValue = ((Label)e.Row.FindControl("lblKimtecAttributeID")).Text;
            }
        }

        private void loadKimtecAttributes()
        {
            if (cmbKimtecCategory.SelectedValue != null)
                kimtecAttributes = new KimtecBL().GetKimtecAttributesForCategory(int.Parse(cmbKimtecCategory.SelectedValue), true);
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            new KimtecBL().DeleteKimtecAttributeForAttribute(int.Parse(cmbCategory.SelectedValue), int.Parse(cmbKimtecCategory.SelectedValue));
            for (int i = 0; i < dgvAttribute.Rows.Count; i++)
            {
                if (((DropDownList)dgvAttribute.Rows[i].FindControl("cmbKimtecAttribute")).SelectedIndex > 0)
                {
                    new KimtecBL().SaveKimtecAttributeForAttribute(int.Parse(((DropDownList)dgvAttribute.Rows[i].FindControl("cmbKimtecAttribute")).SelectedValue), int.Parse(((Label)dgvAttribute.Rows[i].FindControl("lblAttributeID")).Text));
                }
            }
        }
    }
}
