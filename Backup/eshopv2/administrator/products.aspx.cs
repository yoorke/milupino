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
using System.Collections.Generic;

namespace eshopv2.administrator
{
    public partial class products : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (User.Identity.IsAuthenticated && User.IsInRole("administrator"))
            {
                if (!Page.IsPostBack)
                {
                    loadIntoForm();
                    loadProducts();
                }
            }
            else
                Response.Redirect("/administrator/login.aspx?returnUrl=" + Page.Request.RawUrl.Substring(15, Page.Request.RawUrl.Length - 15));
        }

        private void loadProducts()
        {
            int categoryID = -1;
            if (cmbCategory.SelectedIndex > 0)
                categoryID = int.Parse(cmbCategory.SelectedValue);

            int supplierID = -1;
            if (cmbSupplier.SelectedIndex > 0)
                supplierID = int.Parse(cmbSupplier.SelectedValue);

            int? brandID = null;
            if (cmbBrand.SelectedIndex > 1)
                brandID = int.Parse(cmbBrand.SelectedValue);

            ProductBL productsBL = new ProductBL();

            List<Product> products = productsBL.GetProducts(categoryID, supplierID, cmbApproved.SelectedItem.Text, cmbActive.SelectedItem.Text, brandID);

            if (txtSearch.Text.Length > 0)
            {
                var productsList = (from product in products
                                    where product.Name.ToLower().Contains(txtSearch.Text.ToLower())
                                    select product);

                dgvProducts.DataSource = productsList.ToList();
                lblProductsCount.Text = productsList.Count().ToString();
            }
            else
            {
                dgvProducts.DataSource = products;
                lblProductsCount.Text = products != null ? products.Count.ToString() : "0";
            }
            dgvProducts.DataBind();

            
        }

        private void loadIntoForm()
        {
            CategoryBL categoryBL = new CategoryBL();
            cmbCategory.DataSource = categoryBL.GetCategories();
            cmbCategory.DataTextField = "name";
            cmbCategory.DataValueField = "categoryID";
            cmbCategory.DataBind();

            SupplierBL supplierBL = new SupplierBL();
            cmbSupplier.DataSource = supplierBL.GetSuppliers(true);
            cmbSupplier.DataTextField = "name";
            cmbSupplier.DataValueField = "supplierID";
            cmbSupplier.DataBind();
     

            cmbApproved.Items.Add("Sve");
            cmbApproved.Items.Add("Odobrene");
            cmbApproved.Items.Add("Neodobrene");
            

            cmbActive.Items.Add("Sve");
            cmbActive.Items.Add("Aktivne");
            cmbActive.Items.Add("Neaktivne");

            cmbPageSize.Items.Add("10");
            cmbPageSize.Items.Add("20");
            cmbPageSize.Items.Add("50");
            cmbPageSize.Items.Add("100");
            cmbPageSize.Items.Add("Sve");

            BrandBL brandBL = new BrandBL();
            cmbBrand.DataSource = brandBL.GetBrands(true);
            cmbBrand.DataTextField = "name";
            cmbBrand.DataValueField = "brandID";
            cmbBrand.DataBind();
        }

        protected void btnShowProducts_Click(object sender, EventArgs e)
        {
            loadProducts();
        }

        protected void btnAddProduct_Click(object sender, EventArgs e)
        {
            Page.Response.Redirect("/administrator/product.aspx");
        }

        protected void dgvProducts_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            ProductBL productBL = new ProductBL();
            productBL.DeleteProduct(int.Parse(dgvProducts.DataKeys[e.RowIndex].Values[0].ToString()));

            Page.Response.Redirect("/administrator/products.aspx");
        }

        protected void dgvProducts_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            dgvProducts.PageIndex = e.NewPageIndex;
            loadProducts();
        }

        protected void chkApproved_CheckChanged(object sender, EventArgs e)
        {
            CheckBox chkApproved = (CheckBox)sender;
            GridViewRow row = (GridViewRow)chkApproved.NamingContainer;

            ProductBL productBL = new ProductBL();
            if (productBL.SetApproved(int.Parse(((Label)row.FindControl("lblProductID")).Text), bool.Parse(((CheckBox)row.FindControl("chkApproved")).Checked.ToString())) > 0)
            {
                setStatus("Proizvod uspešno izmenjen", System.Drawing.Color.Green, true);
            }
        }

        protected void chkActive_CheckChanged(object sender, EventArgs e)
        {
            CheckBox chkActive = (CheckBox)sender;
            GridViewRow row = (GridViewRow)chkActive.NamingContainer;

            ProductBL productBL = new ProductBL();
            productBL.SetActive(int.Parse(((Label)row.FindControl("lblProductID")).Text), bool.Parse(((CheckBox)row.FindControl("chkActive")).Checked.ToString()));
        }

        private void setStatus(string text, System.Drawing.Color foreColor, bool visible)
        {
            csStatus.Text = text;
            csStatus.Visible = visible;
            csStatus.ForeColor = foreColor;
            csStatus.Show();
        }

        protected void dgvProducts_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.Header)
            {
                ((CheckBox)e.Row.FindControl("chkSelectAll")).Attributes.Add("onclick", "javascript:SelectAll('" + ((CheckBox)e.Row.FindControl("chkSelectAll")).ClientID + "')");
            }
        }

        protected void btnApproveAll_Click(object sender, EventArgs e)
        {
            ProductBL productBL=new ProductBL();
            for (int i = 0; i < dgvProducts.Rows.Count; i++)
            {
                if (((CheckBox)dgvProducts.Rows[i].FindControl("chkSelect")).Checked)
                    productBL.SetApproved(int.Parse(((Label)dgvProducts.Rows[i].FindControl("lblProductID")).Text), true);
            }
        }

        protected void btnActivateAll_Click(object sender, EventArgs e)
        {
            ProductBL productBL = new ProductBL();
            for (int i = 0; i < dgvProducts.Rows.Count; i++)
            {
                if (((CheckBox)dgvProducts.Rows[i].FindControl("chkSelect")).Checked)
                    productBL.SetActive(int.Parse(((Label)dgvProducts.Rows[i].FindControl("lblProductID")).Text), true);
            }
        }

        protected void cmbPageSize_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (cmbPageSize.SelectedIndex > 0 && cmbPageSize.SelectedIndex <= 3)
                dgvProducts.PageSize = int.Parse(cmbPageSize.SelectedItem.Text);
            else if (cmbPageSize.SelectedIndex == 4)
                dgvProducts.AllowPaging = false;

            loadProducts();
        }

        protected void chkLocked_CheckedChanged(object sender, EventArgs e)
        {
            CheckBox chkIsLocked = (CheckBox)sender;
            GridViewRow gridViewRow = (GridViewRow)chkIsLocked.NamingContainer;

            ProductBL productBL = new ProductBL();
            productBL.SetLocked(int.Parse(((Label)gridViewRow.FindControl("lblProductID")).Text), bool.Parse(((CheckBox)gridViewRow.FindControl("chkLocked")).Checked.ToString()));
            
        }

        protected void chkInStock_CheckedChanged(object sender, EventArgs e)
        {
            CheckBox chkIsInStock = (CheckBox)sender;
            GridViewRow gridViewRow = (GridViewRow)chkIsInStock.NamingContainer;

            ProductBL productBL = new ProductBL();
            productBL.SetIsInStock(int.Parse(((Label)gridViewRow.FindControl("lblProductID")).Text), bool.Parse(((CheckBox)gridViewRow.FindControl("chkInStock")).Checked.ToString()));
        }

        protected void btnDeleteAll_Click(object sender, EventArgs e)
        {
            ProductBL productBL = new ProductBL();
            for (int i = 0; i < dgvProducts.Rows.Count; i++)
            {
                if (((CheckBox)dgvProducts.Rows[i].FindControl("chkSelect")).Checked)
                {
                    productBL.DeleteProduct(int.Parse(((Label)dgvProducts.Rows[i].FindControl("lblProductID")).Text));
                }
            }
        }
    }
}
