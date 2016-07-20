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
using System.Web.Configuration;

namespace eshopv2.administrator
{
    public partial class getProductsKimtec : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (User.Identity.IsAuthenticated && User.IsInRole("Administrator"))
            {
                if (!Page.IsPostBack)
                {
                    loadIntoForm();
                }
            }
            else
                Response.Redirect("/administrator/login.aspx?returnUrl=" + Page.Request.RawUrl.Substring(15, Page.Request.RawUrl.Length - 15));
        }

        protected void btnGetProducts_Click(object sender, EventArgs e)
        {
            try
            {
                new KimtecBL().SaveProductsFromKimtec();
                Configuration configuration = WebConfigurationManager.OpenWebConfiguration("/");
                lblProductsLoaded.Text = DateTime.Now.AddHours(9).ToString("dd/MM/yyyy hh:mm");
                configuration.AppSettings.Settings["productsLoaded"].Value = lblProductsLoaded.Text;
                configuration.Save();

                divPleaseWait.Style.Add("display", "none");
            }
            catch (Exception ex)
            {
                Response.Write(ex.Message);
            }
        }

        protected void btnGetPrice_Click(object sender, EventArgs e)
        {
            new KimtecBL().SavePrice();
        }

        protected void btnGetBarcode_Click(object sender, EventArgs e)
        {
            new KimtecBL().SaveBarcode();
        }

        protected void btnGetCategories_Click(object sender, EventArgs e)
        {
            try
            {
                new KimtecBL().GetCategoriesFromKimtec();
                divPleaseWait.Style.Add("display", "none");
                checkCategories();
            }
            catch (Exception ex)
            {
                Response.Write(ex.Message);
            }
        }

        private void loadIntoForm()
        {
            cmbCategory.DataSource = new CategoryBL().GetCategories();
            cmbCategory.DataTextField = "name";
            cmbCategory.DataValueField = "categoryID";
            cmbCategory.DataBind();

            cmbKimtecCategory.DataSource = new KimtecBL().GetCategories(0, null, true);
            cmbKimtecCategory.DataTextField = "name";
            cmbKimtecCategory.DataValueField = "kimtecCategoryID";
            cmbKimtecCategory.DataBind();

            lblProductsLoaded.Text = ConfigurationManager.AppSettings["productsLoaded"];
            //lblCategoriesLoaded.Text = ConfigurationManager.AppSettings["categoriesLoaded"];
            //lblSpecificationLoaded.Text = ConfigurationManager.AppSettings["specificationLoaded"];

            checkCategories();
        }

        private void checkCategories()
        {
            bool hasCategories = new KimtecBL().GetKimtecCategoryCount() > 0;
            //btnGetProducts.Enabled = hasCategories;
            //btnGetSpecification.Enabled = hasCategories;
        }

        protected void cmbCategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (cmbCategory.SelectedIndex > -1)
            {
                lstCategory.Items.Clear();
                int kimtecCategory = new KimtecBL().GetKimtecCategoryForCategory(int.Parse(cmbCategory.SelectedValue));
                if (kimtecCategory > 0 && cmbKimtecCategory.Items.FindByValue(kimtecCategory.ToString()) != null)
                {
                    
                    
                        cmbKimtecCategory.SelectedValue = kimtecCategory.ToString();
                        cmbKimtecCategory_SelectedIndexChanged(this, null);
                    
                    
                    
                    
                }
                else
                {
                    cmbKimtecCategory.SelectedIndex = 0;
                    lstKimtecCategory.Items.Clear();
                }
            }
        }

        protected void cmbKimtecCategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (cmbKimtecCategory.SelectedIndex > 0)
            {
                lstKimtecCategory.Items.Clear();
                DataTable categories = new KimtecBL().GetCategories(int.Parse(cmbKimtecCategory.SelectedValue), int.Parse(cmbCategory.SelectedValue), false);
                for (int i = 0; i < categories.Rows.Count; i++)
                {
                    lstKimtecCategory.Items.Add(new ListItem(categories.Rows[i]["name"].ToString(), categories.Rows[i]["kimtecCategoryID"].ToString()));
                    lstKimtecCategory.Items[i].Selected = categories.Rows[i]["selected"].ToString() == "1" ? true : false;
                    if (categories.Rows[i]["isNew"].ToString() == "1")
                        lstKimtecCategory.Items[i].Attributes.Add("style", "background-color:yellow");
                }

                lstCategory.Items.Clear();
                addCategories();
            }
        }

        protected void btnLoadProducts_Click(object sender, EventArgs e)
        {
            DataTable subcategories=null;
            string subcategory = string.Empty;
            string subcategoryID = string.Empty;
            //string subcategoriesID = string.Empty;
            //for (int i = 0; i < lstKimtecCategory.Items.Count; i++)
            for (int i = 0; i < lstCategory.Items.Count; i++)
            {
                //if (lstCategory.Items[i].Selected)
                //{
                    //subcategories = new KimtecBL().GetKimtecSubCategoriesByCategoryID(int.Parse(lstKimtecCategory.Items[i].Value));

                    //for (int j = 0; j < subcategories.Rows.Count; j++)
                    //{
                        subcategoryID += lstCategory.Items[i].Value + ",";
                        subcategory += lstCategory.Items[i].Text + ",";
                    //}
                //}
            }
                //if (lstKimtecCategory.Items[i].Selected)
                //{
                    //subcategories += lstKimtecCategory.Items[i].Text + ",";
                    //subcategoriesID += lstKimtecCategory.Items[i].Value + ",";
                //}

            if (subcategory != string.Empty)
            {
                dgvProducts.DataSource = new KimtecBL().GetProductsFromDatabase(subcategory.Substring(0, subcategory.Length - 1).Split(','), subcategoryID.Substring(0, subcategoryID.Length - 1).Split(','));
                dgvProducts.DataBind();
            }
            pnlOptions.Visible = true;

            new KimtecBL().DeleteCategoryKimtecCategory(int.Parse(cmbCategory.SelectedValue));

            for (int i = 0; i < lstCategory.Items.Count; i++)
            {
                new KimtecBL().SaveKimtecCategoryForCategory(int.Parse(cmbCategory.SelectedValue), int.Parse(lstCategory.Items[i].Value), false);
            }
            new KimtecBL().SaveKimtecCategoryForCategory(int.Parse(cmbCategory.SelectedValue), int.Parse(cmbKimtecCategory.SelectedValue), true);

            divPleaseWait.Style.Add("display", "none");
        }

        protected void dgvProducts_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if (((Label)e.Row.FindControl("lblExist")).Text == "1")
                    ((Image)e.Row.FindControl("imgStatus")).ImageUrl = "/images/exists.jpg";
            }
            else if (e.Row.RowType == DataControlRowType.Header)
                ((CheckBox)e.Row.FindControl("chkSelectAll")).Attributes.Add("onclick", "javascript:SelectAll('" + ((CheckBox)e.Row.FindControl("chkSelectAll")).ClientID + "')");
        }

        protected void btnSaveProducts_Click(object sender, EventArgs e)
        {
            try
            {
                int newProducts = 0;
                int updatedProducts = 0;
                int[] status;
                KimtecBL kimtecBL = new KimtecBL();
                for (int i = 0; i < dgvProducts.Rows.Count; i++)
                {
                    if (((CheckBox)dgvProducts.Rows[i].FindControl("chkSave")).Checked)
                    {
                        status = kimtecBL.SaveProduct(dgvProducts.Rows[i], int.Parse(cmbCategory.SelectedValue), chkApprove.Checked, chkActive.Checked, int.Parse(cmbKimtecCategory.SelectedValue));
                        newProducts += status[0];
                        updatedProducts += status[1];
                    }
                }
                
                divAlert.Visible = true;
                divAlert.Attributes["class"] = "alert alert-success text-center";
                lblAlert.Text = "Dodato " + newProducts.ToString() + " proizvoda. Izmenjeno " + updatedProducts.ToString() + "proizvoda";
                divPleaseWait.Style.Add("display", "none");
            }
            catch (Exception ex)
            {
                //Response.Write(ex.Message);
                divAlert.Visible = true;
                divAlert.Attributes["class"] = "alert alert-danger text-center";
                lblAlert.Text = ex.Message;
            }
        }

        protected void btnGetSpecification_Click(object sender, EventArgs e)
        {
            try
            {
                new KimtecBL().SaveProductSpecification();
                new KimtecBL().SaveKimtecAttribute();
                divPleaseWait.Style.Add("display", "none");
            }
            catch (Exception ex)
            {
                Response.Write(ex.Message);
            }
        }

        protected void btnAddCategory_Click(object sender, EventArgs e)
        {
            for (int i = 0; i < lstKimtecCategory.Items.Count; i++)
            {
                if (lstKimtecCategory.Items[i].Selected)
                    lstCategory.Items.Add(new ListItem(lstKimtecCategory.Items[i].Text, lstKimtecCategory.Items[i].Value));
            }
        }

        protected void btnRemoveCategory_Click(object sender, EventArgs e)
        {
            for (int i = 0; i < lstCategory.Items.Count; i++)
                if (lstCategory.Items[i].Selected)
                    lstCategory.Items.RemoveAt(i);
        }

        protected void chkSelectNew_CheckedChanged(object sender, EventArgs e)
        {
            for (int i = 0; i < dgvProducts.Rows.Count; i++)
            {
                if (((Image)dgvProducts.Rows[i].FindControl("imgStatus")).ImageUrl == string.Empty)
                    ((CheckBox)dgvProducts.Rows[i].FindControl("chkSave")).Checked = chkSelectNew.Checked;
            }
        }

        private void addCategories()
        {
            for (int i = 0; i < lstKimtecCategory.Items.Count; i++)
            {
                if (lstKimtecCategory.Items[i].Selected)
                    lstCategory.Items.Add(new ListItem(lstKimtecCategory.Items[i].Text, lstKimtecCategory.Items[i].Value));
            }
        }
    }
}
