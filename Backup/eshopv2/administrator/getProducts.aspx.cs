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
using System.Xml;
using System.Net;
using eshopBE;
using eshopBL;
using System.IO;
using System.Collections.Generic;
using eshopUtilities;

namespace eshopv2.administrator
{
    public partial class productsEwe : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (User.Identity.IsAuthenticated && (User.IsInRole("administrator") || User.IsInRole("prodavac")))
            {
                if (!Page.IsPostBack)
                {
                    loadIntoForm();
                }
            }
            else
                Page.Response.Redirect("/administrator/login.aspx?returnUrl=" + Page.Request.RawUrl.Substring(15, Page.Request.RawUrl.Length - 15));

            //divPleaseWait.Visible = false;
        }

        

        

        

        

        protected void btnGetProducts_Click(object sender, EventArgs e)
        {
            try
            {
                if (lstCategory.Items.Count > 0)
                {
                    //parseProducts();
                    string subcategories = string.Empty;
                    for (int i = 0; i < lstCategory.Items.Count; i++)
                        subcategories += lstCategory.Items[i].Text + ",";
                    subcategories = subcategories.Remove(subcategories.Length - 1, 1);
                    EweBL eweBL = new EweBL();
                    dgvProducts.DataSource = eweBL.parseProductsToDataTable(cmbEweCategory.SelectedItem.Text, subcategories.Split(','));
                    dgvProducts.DataBind();
                    if(dgvProducts.Rows.Count==0)
                        SetStatus("Ne postoje proizvodi za kategoriju", System.Drawing.Color.Red, true);

                    pnlOptions.Visible = true;
                    chkSelectNew.Checked = false;
                    divPleaseWait.Style.Add("display", "none");
                    //cmbEweCategory.Enabled = false;
                    //btnGetProducts.Enabled = false;
                    /*string category = cmbEweCategory.SelectedItem.Text.Substring(0, cmbEweCategory.SelectedItem.Text.IndexOf("-"));
                    string subcategory = cmbEweCategory.SelectedItem.Text.Substring(cmbEweCategory.SelectedItem.Text.IndexOf("-") + 1, cmbEweCategory.SelectedItem.Text.Length - cmbEweCategory.SelectedItem.Text.IndexOf("-") - 1);

                    eweBL.parseProducts(category, subcategory, chkImages.Checked, chkAttributes.Checked, cmbCategory.SelectedItem.Text, int.Parse(cmbCategory.SelectedValue), chkOverwrite.Checked);

                    Page.Response.Redirect("/administrator/products.aspx");*/

                    string categoryIDs = string.Empty;
                    string selected = string.Empty;
                    eweBL.DeleteCategoryEweCategory(int.Parse(cmbCategory.SelectedValue));
                    for (int i = 0; i < lstCategory.Items.Count; i++)
                    {
                        //categoryIDs += lstSubCategory.Items[i].Value + ",";
                        //selected += lstCategory.Items.Contains(lstSubCategory.Items[i]).ToString() + ",";
                        //if (lstSubCategory.Items[i].Selected)
                            eweBL.SaveEweCategoryForCategory(int.Parse(cmbCategory.SelectedValue), int.Parse(lstCategory.Items[i].Value), false);
                    }
                    //eweBL.SaveSelected(categoryIDs.Substring(0, categoryIDs.Length - 1), selected.Substring(0, selected.Length - 1));
                    eweBL.SaveEweCategoryForCategory(int.Parse(cmbCategory.SelectedValue), int.Parse(cmbEweCategory.SelectedValue), true);
                }
                
            }
            catch (BLException ex)
            {
                SetStatus(ex.Message, System.Drawing.Color.Red, true);
            }
        }

        

        

        private void loadIntoForm()
        {
            EweBL eweBL = new EweBL();
            cmbEweCategory.DataSource = eweBL.GetEweCategories(null, null);
            cmbEweCategory.DataValueField = "eweCategoryID";
            cmbEweCategory.DataTextField = "name";
            cmbEweCategory.DataBind();

            CategoryBL categoryBL = new CategoryBL();
            cmbCategory.DataSource = categoryBL.GetCategories();
            cmbCategory.DataTextField = "name";
            cmbCategory.DataValueField = "categoryID";
            cmbCategory.DataBind();
        }

        private string[] getEweCategory(string category)
        {
            string[] eweCategory = new string[2];
            switch (category)
            {
                case "laptop":
                    {
                        eweCategory[0] = "notebook";
                        eweCategory[1] = "notebook";
                        break;
                    }

                case "tablet":
                    {
                        eweCategory[0] = "notebook";
                        eweCategory[1] = "tablet";
                        break;
                    }

                case "dodatna oprema":
                    {
                        eweCategory[0] = "notebook";
                        eweCategory[1] = "dodatna%20oprema";
                        break;
                    }

                case "konfiguracije":
                    {
                        eweCategory[0] = "racunarske%20konfiguracije";
                        eweCategory[1] = string.Empty;
                        break;
                    }
            }

            return eweCategory;
        }

        protected void btnSaveProducts_Click(object sender, EventArgs e)
        {
            //divPleaseWait.Visible = true;
            if (cmbCategory.SelectedIndex > 1)
            {
                string codes = string.Empty;

                for (int i = 0; i < dgvProducts.Rows.Count; i++)
                    if (((CheckBox)dgvProducts.Rows[i].FindControl("chkSave")).Checked)
                        codes += ((Label)dgvProducts.Rows[i].FindControl("lblSupplierCode")).Text + ",";

                if (codes.Length > 0)
                {
                    EweBL eweBL = new EweBL();
                    string subcategories = string.Empty;
                    for (int i = 0; i < lstCategory.Items.Count; i++)
                        subcategories += lstCategory.Items[i].Text + ",";
                    string status = eweBL.parseProducts(cmbEweCategory.SelectedItem.Text, subcategories.Substring(0, subcategories.Length - 1).Split(','), true, true, cmbCategory.SelectedItem.Text, int.Parse(cmbCategory.SelectedValue), chkOverwrite.Checked, codes.Substring(0, codes.Length - 1).Split(','), chkActive.Checked, chkApproved.Checked);

                    SetStatus(status, System.Drawing.Color.Green, true);
                }
                divPleaseWait.Style.Add("display", "none");
                //divPleaseWait.Visible = false;
            }
            else
                SetStatus("Odaberite kategoriju", System.Drawing.Color.Red, true);
        }

        protected void dgvProducts_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if (((CheckBox)e.Row.FindControl("chkExists")).Checked)
                    ((Image)e.Row.FindControl("imgStatus")).ImageUrl = "/images/exists.jpg";
                //else
                //((Image)e.Row.FindControl("imgStatus")).ImageUrl = "/images/notexists.jpg";
            }
            else if (e.Row.RowType == DataControlRowType.Header)
                ((CheckBox)e.Row.FindControl("chkSelectAll")).Attributes.Add("onclick", "javascript:SelectAll('" + ((CheckBox)e.Row.FindControl("chkSelectAll")).ClientID + "')");
        }

        protected void btnUpdateStockPrice_Click(object sender, EventArgs e)
        {
            if (cmbCategory.SelectedIndex > 0)
            {
                EweBL eweBL = new EweBL();
                string subcategories = string.Empty;
                for (int i = 0; i < lstCategory.Items.Count; i++)
                    subcategories += lstCategory.Items[i].Text + ",";
                string status = eweBL.parseProductsStockPrice(cmbEweCategory.SelectedItem.Text, subcategories.Substring(0, subcategories.Length - 1).Split(','), int.Parse(cmbCategory.SelectedValue), 1);
                SetStatus(status, System.Drawing.Color.Green, true);
                //Page.Response.Redirect("/administrator/products.aspx");
                divPleaseWait.Style.Add("display", "none");
            }
            else
                SetStatus("Odaberite kategoriju", System.Drawing.Color.Red, true);
        }

        private void SetStatus(string message, System.Drawing.Color foreColor, bool visible)
        {
            csStatus.Text = message;
            csStatus.ForeColor = foreColor;
            csStatus.Visible = visible;
            csStatus.Show();
        }

        protected void chkSelectNew_CheckedChanged(object sender, EventArgs e)
        {
            for (int i = 0; i < dgvProducts.Rows.Count; i++)
            {
                if (((Image)dgvProducts.Rows[i].FindControl("imgStatus")).ImageUrl == string.Empty)
                    ((CheckBox)dgvProducts.Rows[i].FindControl("chkSave")).Checked = chkSelectNew.Checked;
            }
        }

        protected void btnUpdateCategories_Click(object sender, EventArgs e)
        {
            EweBL eweBL = new EweBL();
            eweBL.UpdateEweCategories();

            loadIntoForm();
            //divPleaseWait.Style.Clear();
            divPleaseWait.Style.Add("display", "none");
            dgvNewCategories.DataSource = eweBL.GetNewCategories();
            dgvNewCategories.DataBind();
        }

        protected void cmbEweCategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            EweBL eweBL = new EweBL();
            /*lstSubCategory.DataSource = eweBL.GetEweCategories(int.Parse(cmbEweCategory.SelectedValue));
            lstSubCategory.DataTextField = "name";
            lstSubCategory.DataValueField = "eweCategoryID";
            lstSubCategory.DataBind();*/

            lstSubCategory.Items.Clear();
            DataTable categories = eweBL.GetEweCategories(int.Parse(cmbEweCategory.SelectedValue), int.Parse(cmbCategory.SelectedValue));
            for (int i = 0; i < categories.Rows.Count; i++)
            {
                lstSubCategory.Items.Add(new ListItem(categories.Rows[i]["name"].ToString(), categories.Rows[i]["eweCategoryID"].ToString()));
                lstSubCategory.Items[i].Selected = categories.Rows[i]["selected"].ToString() == "1" ? true : false;
                if (categories.Rows[i]["isNew"].ToString() == "1")
                    lstSubCategory.Items[i].Attributes.Add("style", "background-color:yellow");
            }

            lstCategory.Items.Clear();
            addCategories();
        }

        protected void btnAddCategory_Click(object sender, EventArgs e)
        {
            addCategories();
        }

        protected void btnRemoveCategory_Click(object sender, EventArgs e)
        {
            for (int i = 0; i < lstCategory.Items.Count; i++)
                if (lstCategory.Items[i].Selected)
                    lstCategory.Items.Remove(lstCategory.Items[i--]);
        }

        protected void lstSubCategory_DataBound(object sender, EventArgs e)
        {
        }

        protected void lstSubCategory_DataBinding(object sender, EventArgs e)
        {
        }

        private void addCategories()
        {
            for (int i = 0; i < lstSubCategory.Items.Count; i++)
                if (lstSubCategory.Items[i].Selected)
                    lstCategory.Items.Add(new ListItem(lstSubCategory.Items[i].Text, lstSubCategory.Items[i].Value));
        }

        protected void dgvNewCategories_SelectedIndexChanged(object sender, EventArgs e)
        {
            int parentCategoryID = int.Parse(((Label)dgvNewCategories.Rows[dgvNewCategories.SelectedIndex].FindControl("lblParentCategoryID")).Text);

            cmbEweCategory.SelectedValue = parentCategoryID.ToString();
            cmbEweCategory_SelectedIndexChanged(this, null);
        }

        protected void cmbCategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (cmbCategory.SelectedIndex > -1)
            {
                lstCategory.Items.Clear();
                EweBL eweBL=new EweBL();
                int eweCategoryID = eweBL.GetEweCategoryForCategory(int.Parse(cmbCategory.SelectedValue));
                if (eweCategoryID > 0)
                {
                    cmbEweCategory.SelectedValue = eweCategoryID.ToString();
                    cmbEweCategory_SelectedIndexChanged(this, null);
                }
                else
                {
                    cmbEweCategory.SelectedIndex = 0;
                    lstSubCategory.Items.Clear();
                }
            }
        }
    }
}
