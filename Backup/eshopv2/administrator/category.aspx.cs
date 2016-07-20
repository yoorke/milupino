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
    public partial class category : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (User.Identity.IsAuthenticated && User.IsInRole("administrator"))
            {
                if (!Page.IsPostBack)
                {
                    loadIntoForm();

                    int categoryID = (Request.QueryString.ToString().Contains("id")) ? int.Parse(Request.QueryString["id"]) : 0;
                    if (categoryID > 0)
                        loadCategory(categoryID);
                }
                else
                {
                    Page.Title = (ViewState["pageTitle"] != null) ? ViewState["pageTitle"].ToString() : "Kategorija";
                }
            }
            else
                Page.Response.Redirect("/administrator/login.aspx?returnUrl=" + Page.Request.RawUrl.Substring(15, Page.Request.RawUrl.Length - 15));
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            saveCategory();
        }

        private void saveCategory()
        {
            try
            {
                Category category = new Category();
                category.Name = txtName.Text;
                category.Url = txtUrl.Text;
                category.ImageUrl = txtImageUrl.Text;
                category.ParentCategoryID = int.Parse(cmbParent.SelectedValue);
                if (lblCategoryID.Value != string.Empty)
                    category.CategoryID = int.Parse(lblCategoryID.Value);
                category.SortOrder = (int.Parse(txtSortOrder.Text));
                category.PricePercent = double.Parse(txtPricePercent.Text);
                category.WebPricePercent = double.Parse(txtWebPricePercent.Text);
                category.ShowOnFirstPage = chkShowOnFirstPage.Checked;
                category.NumberOfProducts = (txtNumber.Text.Length > 0) ? int.Parse(txtNumber.Text) : 0;
                category.firstPageSortOrder = (txtSortOrderFirstPage.Text.Length > 0) ? int.Parse(txtSortOrderFirstPage.Text) : 0;
                category.firstPageOrderBy = cmbCriterion.SelectedItem.Text;
                category.Description = txtDescription.Text;

                CategoryBL categoryBl = new CategoryBL();
                categoryBl.SaveCategory(category);


            }
            catch (BLException ex)
            {
                setStatus(ex.Message, System.Drawing.Color.Red, true);
            }

        }

        private void loadIntoForm()
        {
            CategoryBL categoryBl = new CategoryBL();
            cmbParent.DataSource = categoryBl.GetCategories();
            cmbParent.DataTextField = "name";
            cmbParent.DataValueField = "categoryID";
            cmbParent.DataBind();

            AttributeBL attributeBL = new AttributeBL();
            cmbAttribute.DataSource = attributeBL.GetAllAttributes();
            cmbAttribute.DataTextField = "name";
            cmbAttribute.DataValueField = "attributeID";
            cmbAttribute.DataBind();

            cmbCriterion.Items.Add("Novi");
            cmbCriterion.Items.Add("Ceni");
            cmbCriterion.Items.Add("Slučajni");

            txtPricePercent.Text = "0,00";
            txtWebPricePercent.Text = "0,00";
        }

        private void loadCategory(int categoryID)
        {
            CategoryBL categoryBL = new CategoryBL();
            Category category = categoryBL.GetCategory(categoryID);

            txtName.Text = category.Name;
            txtUrl.Text = category.Url;
            txtImageUrl.Text = category.ImageUrl;
            cmbParent.SelectedValue = cmbParent.Items.FindByValue(category.ParentCategoryID.ToString()).Value;
            txtSortOrder.Text = category.SortOrder.ToString();
            lblCategoryID.Value = category.CategoryID.ToString();
            txtPricePercent.Text = category.PricePercent.ToString();
            txtWebPricePercent.Text = category.WebPricePercent.ToString();
            chkShowOnFirstPage.Checked = category.ShowOnFirstPage;
            txtNumber.Text = category.NumberOfProducts.ToString();
            txtSortOrderFirstPage.Text = category.firstPageSortOrder.ToString();
            if (category.firstPageOrderBy != string.Empty && category.firstPageOrderBy != null)
                cmbCriterion.SelectedValue = cmbCriterion.Items.FindByText(category.firstPageOrderBy).Value;
            setFirstPageControls(category.ShowOnFirstPage);
            Page.Title = category.Name + " | Admin panel";
            ViewState.Add("pageTitle", Page.Title);
            txtDescription.Text = category.Description;


            if (lblCategoryID.Value != string.Empty)
            {
                AttributeBL attributeBL = new AttributeBL();
                dgvAttributes.DataSource = attributeBL.GetAttributesForCategory(categoryID);
                dgvAttributes.DataBind();
            }
        }

        protected void btnAddAttribute_Click(object sender, EventArgs e)
        {
            try
            {
                AttributeBL attributeBL = new AttributeBL();
                attributeBL.SaveAttributeForCategory(int.Parse(lblCategoryID.Value), int.Parse(cmbAttribute.SelectedValue));

                loadAttributes();
            }
            catch (BLException blException)
            {
                setStatus(blException.Message, System.Drawing.Color.Red, true);
            }
        }

        protected void dgvAttributes_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                AttributeBL attributeBL = new AttributeBL();
                int status = attributeBL.DeleteAttributeForCategory(int.Parse(lblCategoryID.Value), int.Parse(dgvAttributes.DataKeys[e.RowIndex].Values[0].ToString()));

                loadAttributes();
            }
            catch (BLException ex)
            {
                setStatus(ex.Message, System.Drawing.Color.Red, true);
            }
        }

        private void loadAttributes()
        {
            AttributeBL attributeBL = new AttributeBL();
            dgvAttributes.DataSource = attributeBL.GetAttributesForCategory(int.Parse(lblCategoryID.Value));
            dgvAttributes.DataBind();
        }

        private void setStatus(string text, System.Drawing.Color foreColor, bool visible)
        {
            //csStatus.Text = text;
            //csStatus.Visible = visible;
            //csStatus.ForeColor = foreColor;
            //csStatus.Show();
        }

        protected void btnSaveClose_Click(object sender, EventArgs e)
        {
            saveCategory();
            Response.Redirect("/administrator/categories.aspx");
        }

        protected void btnClose_Click(object sender, EventArgs e)
        {
            Page.Response.Redirect("/administrator/categories.aspx");
        }

        protected void chkFilter_CheckedChanged(object sender, EventArgs e)
        {
            CheckBox checkBox = (CheckBox)sender;
            GridViewRow row = (GridViewRow)checkBox.NamingContainer;

            AttributeBL attributeBL = new AttributeBL();
            attributeBL.SetFilter(int.Parse(lblCategoryID.Value), int.Parse(((Label)row.FindControl("lblAttributeID")).Text), bool.Parse(((CheckBox)row.FindControl("chkFilter")).Checked.ToString()));
        }

        protected void chkIsDescription_CheckedChanged(object sender, EventArgs e)
        {
            CheckBox checkBox = (CheckBox)sender;
            GridViewRow row = (GridViewRow)checkBox.NamingContainer;

            AttributeBL attributeBL = new AttributeBL();
            attributeBL.SetIsDescription(int.Parse(lblCategoryID.Value), int.Parse(((Label)row.FindControl("lblAttributeID")).Text), bool.Parse(((CheckBox)row.FindControl("chkIsDescription")).Checked.ToString()));
        }

        protected void chkShowOnFirstPage_CheckedChanged(object sender, EventArgs e)
        {
            setFirstPageControls(chkShowOnFirstPage.Checked);
        }

        private void setFirstPageControls(bool state)
        {
            txtNumber.Enabled = state;
            txtSortOrderFirstPage.Enabled = state;
            cmbCriterion.Enabled = state;
        }

        protected void btnSavePositions_Click(object sender, EventArgs e)
        {
            int categoryID = int.Parse(lblCategoryID.Value);
            AttributeBL attributeBL = new AttributeBL();
            for (int i = 0; i < dgvAttributes.Rows.Count; i++)
            {
                int attributeID = int.Parse(((Label)dgvAttributes.Rows[i].FindControl("lblAttributeID")).Text);
                int position = 0;
                int.TryParse(((TextBox)dgvAttributes.Rows[i].FindControl("txtPosition")).Text, out position);

                attributeBL.SaveAttributePositionForCategory(attributeID, categoryID, position);
            }
        }
    }
}
