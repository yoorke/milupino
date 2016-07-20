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
using eshopUtilities;

namespace eshopv2.administrator
{
    public partial class attributes : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (User.Identity.IsAuthenticated && User.IsInRole("administrator"))
            {
                if (!Page.IsPostBack)
                {
                    loadAttributes();
                    loadCategories();
                }
            }
            else
                Page.Response.Redirect("/administrator/login.aspx?returnUrl=" + Page.Request.RawUrl.Substring(15, Page.Request.RawUrl.Length - 15));
        }

        private void loadAttributes()
        {
            AttributeBL attributeBL = new AttributeBL();
            dgvAttributes.DataSource = (cmbCategory.SelectedIndex > 0) ? attributeBL.GetAttributesForCategory(int.Parse(cmbCategory.SelectedValue)) : attributeBL.GetAllAttributes();
            dgvAttributes.DataBind();
        }

        protected void dgvAttributes_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                AttributeBL attributeBL = new AttributeBL();
                attributeBL.DeleteAttribute(int.Parse(dgvAttributes.DataKeys[e.RowIndex].Values[0].ToString()));

                loadAttributes();
            }
            catch (BLException ex)
            {
                setStatus(ex.Message, System.Drawing.Color.Red, true);
            }
        }

        protected void btnAddAttribute_Click(object sender, EventArgs e)
        {
            /*AttributeBL attributeBL = new AttributeBL();
            eshopBE.Attribute attribute = new eshopBE.Attribute();
            //attribute.Name = txtName.Text;

            attributeBL.SaveAttribute(attribute);

            loadAttributes();*/

            Response.Redirect("/administrator/attribute.aspx");
        }

        private void setStatus(string text, System.Drawing.Color foreColor, bool visible)
        {
            csStatus.Text = text;
            csStatus.Visible = visible;
            csStatus.ForeColor = foreColor;
            csStatus.Show();
        }

        protected void cmbCategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            loadAttributes();
        }

        private void loadCategories()
        {
            CategoryBL categoryBL = new CategoryBL();
            cmbCategory.DataSource = categoryBL.GetCategories();
            cmbCategory.DataTextField = "name";
            cmbCategory.DataValueField = "categoryID";
            cmbCategory.DataBind();
        }
    }
}
