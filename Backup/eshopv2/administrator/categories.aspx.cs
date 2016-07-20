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
using eshopBE;
using eshopBL;
using eshopUtilities;

namespace eshopv2.administrator
{
    public partial class categories : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (User.Identity.IsAuthenticated && User.IsInRole("administrator"))
            {
                CategoryBL categoryBL = new CategoryBL();
                dgvCategory.DataSource = categoryBL.GetNestedCategoriesDataTable();
                dgvCategory.DataBind();
            }
            else
                Page.Response.Redirect("/administrator/login.aspx?returnUrl=" + Page.Request.RawUrl.Substring(15, Page.Request.RawUrl.Length - 15));
        }

        protected void dgvCategory_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            /*if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if (int.Parse(((Label)e.Row.FindControl("lblParentID")).Text) > int.Parse(((Label)e.Row.FindControl("lblId")).Text))
                    ((Label)e.Row.FindControl("lblName")).Text = " -" + ((Label)e.Row.FindControl("lblName")).Text;
            }*/
        }

        protected void dgvCategory_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                CategoryBL categoryBL = new CategoryBL();
                int status = categoryBL.DeleteCategory(int.Parse(dgvCategory.DataKeys[e.RowIndex].Values[0].ToString()));

                Response.Redirect("/administrator/categories.aspx");
            }
            catch (BLException ex)
            {
                setStatus(ex.Message, System.Drawing.Color.Red, true);
            }
        }

        protected void btnAddCategory_Click(object sender, EventArgs e)
        {
            Response.Redirect("/administrator/category.aspx");
        }

        /*private void products()
        {
            System.Collections.Generic.List<AttributeValue> attributes = new System.Collections.Generic.List<AttributeValue>();
            AttributeValue attributeValue = new AttributeValue();
            attributeValue.AttributeValueID = 9;
            attributeValue.Value = "1 GB";

            attributes.Add(attributeValue);

            attributeValue = new AttributeValue();
            attributeValue.AttributeValueID = 13;
            attributeValue.Value = "i3";

            attributes.Add(attributeValue);

            ProductBL productBL = new ProductBL();
            int count = productBL.GetProducts(attributes).Count;
        }*/

        private void setStatus(string text, System.Drawing.Color foreColor, bool visible)
        {
            csStatus.Text = text;
            csStatus.Visible = visible;
            csStatus.ForeColor = foreColor;
            csStatus.Show();
        }
    }
}
