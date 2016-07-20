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

namespace eshopv2
{
    public partial class filter : System.Web.UI.Page
    {
        private int currentPage
        {
            get
            {
                if (ViewState["currentPage"] != null)
                    return int.Parse(ViewState["currentPage"].ToString());
                else return 0;
            }
            set { ViewState["currentPage"] = value; }
        }

        private int pageSize
        {
            get
            {
                if (ViewState["pageSize"] == null)
                    return 16;
                    
                else
                    return int.Parse(ViewState["pageSize"].ToString());
            }
            set { ViewState["pageSize"] = value; }
        }

        private string sort
        {
            get
            {
                if (ViewState["sort"] != null)
                    return ViewState["sort"].ToString();
                else
                    return "Nazivu";
            }
            set { ViewState["sort"] = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            Category category = null;
            if (!Page.IsPostBack)
            {
                string categoryName = string.Empty;
                if (Page.Request.QueryString.ToString().Contains("category"))
                    categoryName = Page.Request.QueryString["category"];
                if (new CategoryBL().GetCategoryByUrl(categoryName) == null)
                {
                    Server.Transfer("/not-found.aspx");
                }   
                ViewState.Add("category", categoryName);
                loadIntoForm();
                loadBrands();
                loadFilter(categoryName);
                loadPrices();
                createQueryString();
                category = new CategoryBL().GetCategoryByUrl(categoryName);
                //ViewState["pageTitle"] = categoryName.Replace(categoryName[0].ToString(), categoryName[0].ToString().ToUpper()) + " | Milupino";
                ViewState["pageTitle"] = category.Name + " | Milupino";
                ViewState["categoryUrl"] = category.Url;
                
            }
            Page.Title = ViewState["pageTitle"].ToString();

            canonicalUrl.Text = @"<link rel=""canonical"" href=""" + ConfigurationManager.AppSettings["webShopUrl"] + "/proizvodi/" + ViewState["categoryUrl"].ToString() + @"""/>";
        }

        private void loadBrands()
        {
            List<Brand> brands = new BrandBL().GetBrands(Page.Request.QueryString["category"]);

            chkAttributes.DataSource = brands;
            chkAttributes.DataTextField = "name";
            chkAttributes.DataValueField = "brandID";
            chkAttributes.DataBind();
        }

        private void loadPrices()
        {
            cmbPriceFrom.Items.Add("-");
            cmbPriceTo.Items.Add("-");

            double[] prices = new ProductBL().GetMinMaxPrice(ViewState["category"].ToString());

            for (int i = (int)prices[0]; i < (int)prices[1]; i += (int)(prices[1] - prices[0]) / 10)
            {
                cmbPriceFrom.Items.Add(string.Format("{0:N2}", i));
                cmbPriceTo.Items.Add(string.Format("{0:N2}", i));
            }
        }

        private void loadIntoForm()
        {
            cmbPageSize.Items.Add("16");
            cmbPageSize.Items.Add("32");
            cmbPageSize.Items.Add("96");

            cmbSort.Items.Add("Nazivu");
            cmbSort.Items.Add("Ceni opadajuće");
            cmbSort.Items.Add("Ceni rastuće");
        }

        protected void chkAttributes_SelectedIndexChanged(object sender, EventArgs e)
        {
            createQueryString();
        }

        private void loadFilter(string categoryUrl)
        {
            rptFilter.DataSource = new AttributeBL().GetAttributeListForFilter(categoryUrl);
            rptFilter.DataBind();
        }

        protected void chkValues_SelectedIndexChanged(object sender, EventArgs e)
        {
            currentPage = 0;
            createQueryString();
        }

        private void createQueryString()
        {
            List<string> brands = new List<string>();
            List<AttributeValue> attributes = new List<AttributeValue>();
            int attributeID = 0;

            foreach (ListItem value in chkAttributes.Items)
            {
                if (value.Selected)
                    brands.Add(value.Value);
            }

            foreach (RepeaterItem repeaterItem in rptFilter.Items)
            {
                foreach (Control control in repeaterItem.Controls)
                {
                    if (control is HiddenField)
                        attributeID = int.Parse(((HiddenField)control).Value);
                    if(control is CheckBoxList)
                        foreach (ListItem value in ((CheckBoxList)control).Items)
                        {
                            if (value.Selected)
                                attributes.Add(new AttributeValue(int.Parse(value.Value), value.Text, attributeID, 0, string.Empty, 0));
                        }
                }
            }

            List<Product> products = new ProductBL().GetProducts(Page.Request.QueryString["category"], brands, attributes, sort, cmbPriceFrom.SelectedItem.Text, cmbPriceTo.SelectedItem.Text);

            PagedDataSource pagedDataSource = new PagedDataSource();
            pagedDataSource.DataSource = products;
            pagedDataSource.AllowPaging = true;
            pagedDataSource.PageSize = pageSize;
            pagedDataSource.CurrentPageIndex = currentPage;
            ViewState["totalPages"] = pagedDataSource.PageCount;

            if (products != null)
            {
                pgrPager.TotalPages = int.Parse(ViewState["totalPages"].ToString());
                pgrPager.currentPage = this.currentPage;
                pgrPager.doPaging();                
                pgrPager1.TotalPages = int.Parse(ViewState["totalPages"].ToString());
                pgrPager1.currentPage = this.currentPage;
                pgrPager1.doPaging();
                

                rptProducts.DataSource = pagedDataSource;
                rptProducts.DataBind();
            }
            else
            {
                rptProducts.DataSource = null;
                rptProducts.DataSourceID = null;
                rptProducts.DataBind();
                divStatus.Visible = true;
            }
        }

        protected void cmbPageSize_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (cmbPageSize.SelectedIndex > -1)
            {
                pageSize = int.Parse(cmbPageSize.SelectedValue);
                createQueryString();
            }
        }

        protected void cmbSort_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (cmbSort.SelectedIndex > -1)
            {
                sort = cmbSort.SelectedItem.Text;
                createQueryString();
            }
        }

        protected void pgrPages_Click(int currentPage)
        {
            this.currentPage = currentPage;
            createQueryString();
        }

        protected void cmbPriceFrom_SelectedIndexChanged(object sender, EventArgs e)
        {
            createQueryString();
        }

        protected void cmbPriceTo_SelectedIndexChanged(object sender, EventArgs e)
        {
            createQueryString();
        }
    }
}
