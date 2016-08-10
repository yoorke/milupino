using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using eshopBE;
using eshopBL;
using System.Collections.Generic;
using System.Configuration;

namespace eshopv2
{
    public partial class products : System.Web.UI.Page
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
            if (!Page.IsPostBack)
            {
                Category category = null;
                string categoryUrl = string.Empty;
                string brands = string.Empty;
                string priceFrom = string.Empty;
                string priceTo = string.Empty;
                string attributes = string.Empty;
                string pageSize = string.Empty;
                string pageIndex = string.Empty;
                string sort = string.Empty;

                if (Page.Request.QueryString.ToString().Contains("category"))
                    categoryUrl = Page.Request.QueryString["category"];
                if (Page.Request.QueryString.ToString().Contains("brands"))
                    brands = Page.Request.QueryString["brands"];
                if (Page.Request.QueryString.ToString().Contains("priceFrom"))
                    priceFrom = Page.Request.QueryString["priceFrom"];
                if (Page.Request.QueryString.ToString().Contains("priceTo"))
                    priceTo = Page.Request.QueryString["priceTo"];
                if (Page.Request.QueryString.ToString().Contains("attributes"))
                    attributes = Page.Request.QueryString["attributes"];
                if (Page.Request.QueryString.ToString().Contains("pageSize"))
                    pageSize = Page.Request.QueryString["pageSize"];
                if (Page.Request.QueryString.ToString().Contains("pageIndex"))
                    pageIndex = Page.Request.QueryString["pageIndex"];
                if (Page.Request.QueryString.ToString().Contains("sort"))
                    sort = Page.Request.QueryString["sort"];

                if (Page.RouteData.Values["category"] != null)
                    categoryUrl = Page.RouteData.Values["category"].ToString();

                if (new CategoryBL().GetCategoryByUrl(categoryUrl) == null)
                    Server.Transfer("/not-found.aspx");
                string[] brandIDs = brands != string.Empty ? brands.Split(',') : new string[] {};
                string[] attributeIDs = attributes != string.Empty ? attributes.Split(',') : new string[] { };

                if (pageSize != string.Empty)
                {
                    this.pageSize = int.Parse(pageSize);
                    cmbPageSize.SelectedValue = this.pageSize.ToString();
                }
                else
                    this.pageSize = 16;

                if (pageIndex != string.Empty)
                {
                    this.currentPage = int.Parse(pageIndex);
                }
                else
                    this.currentPage = 0;

                if (sort != string.Empty)
                    this.sort = sort;
                else
                    sort = "Nazivu";

                category = new CategoryBL().GetCategoryByUrl(categoryUrl);
                ViewState.Add("category", categoryUrl);
                loadIntoForm();
                loadBrands(categoryUrl, brandIDs, category.ParentCategoryID == 1);
                loadFilter(categoryUrl, attributeIDs);
                loadPrices(categoryUrl, priceFrom, priceTo, category.ParentCategoryID == 1);

                
                ViewState["pageTitle"] = category.Name + " | Milupino";
                ViewState["categoryUrl"] = category.Url;

                lblParentCategory.Text = new CategoryBL().GetCategory((int)category.ParentCategoryID).Name;
                loadSubcategories(category);

                

                createQueryString();
            }
            Page.Title = ViewState["pageTitle"].ToString();
            canonicalUrl.Text = @"<link rel=""canonical"" href=""" + ConfigurationManager.AppSettings["webShopUrl"] + "/proizvodi/" + ViewState["categoryUrl"].ToString() + @"""/>";
        }

        private void loadIntoForm()
        {
            cmbPageSize.Items.Add("16");
            cmbPageSize.Items.Add("32");
            cmbPageSize.Items.Add("96");
            cmbPageSize.SelectedValue = this.pageSize.ToString();

            cmbSort.Items.Add(new ListItem("Nazivu", "name"));
            cmbSort.Items.Add(new ListItem("Ceni opadajuće", "priceDesc"));
            cmbSort.Items.Add(new ListItem("Ceni rastuće", "priceAsc"));
            cmbSort.SelectedValue = this.sort;
        }

        private void loadBrands(string categoryUrl, string[] brandIDs, bool showOnlySelectedBrands)
        {
            chkBrands.DataSource = new BrandBL().GetBrands(categoryUrl, showOnlySelectedBrands);
            chkBrands.DataTextField = "name";
            chkBrands.DataValueField = "brandID";
            chkBrands.DataBind();

            if (chkBrands.DataSource == null)
                brandLabel.Visible = false;

            foreach (ListItem li in chkBrands.Items)
            {
                li.Attributes.Add("attributeValue", li.Value);
                foreach (string brandID in brandIDs)
                    if (int.Parse(brandID) == int.Parse(li.Value))
                        li.Selected = true;
                    else
                        li.Attributes.Add("style", "display:none");
                        
            }
        }

        private void loadFilter(string categoryUrl, string[] attributeIDs)
        {
            rptFilter.DataSource = new AttributeBL().GetAttributeListForFilter(categoryUrl);
            rptFilter.DataBind();

            foreach (RepeaterItem repeaterItem in rptFilter.Items)
            {
                foreach(Control control in repeaterItem.Controls)
                    if (control is CheckBoxList)
                    {
                        foreach (ListItem li in ((CheckBoxList)control).Items)
                        {
                            li.Attributes.Add("attributeValue", li.Value);
                            foreach (string attributeID in attributeIDs)
                                if (int.Parse(attributeID) == int.Parse(li.Value))
                                    li.Selected = true;
                        }
                    }
            }
        }

        private void loadPrices(string categoryUrl, string priceFrom, string priceTo, bool includeChildrenCategories)
        {
            cmbPriceFrom.Items.Add("-");
            cmbPriceTo.Items.Add("-");

            double[] prices = new ProductBL().GetMinMaxPrice(categoryUrl, includeChildrenCategories);
            for (int i = (int)prices[0]; i < (int)prices[1]; i += (int)(prices[1] - prices[0]) / 10)
            {
                cmbPriceFrom.Items.Add(string.Format("{0:N2}", i));
                cmbPriceTo.Items.Add(string.Format("{0:N2}", i));
            }
            if (priceFrom != string.Empty)
                cmbPriceFrom.SelectedValue = priceFrom;
            if (priceTo != string.Empty)
                cmbPriceTo.SelectedValue = priceTo;
        }

        protected void chkBrands_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void chkCategory_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void cmbPriceFrom_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void cmbPriceTo_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void chkValues_SelectedIndexChanged(object sender, EventArgs e)
        {

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

        protected void pgrPager_OnClick()
        {

        }

        protected void pgrPages_Click(int currentPage)
        {
            this.currentPage = currentPage;
            createQueryString();
        }

        private void createQueryString()
        {
            List<string> brands = new List<string>();
            List<AttributeValue> attributes = new System.Collections.Generic.List<AttributeValue>();
            int attributeID = 0;

            foreach (ListItem value in chkBrands.Items)
                if (value.Selected)
                    brands.Add(value.Value);

            foreach(RepeaterItem repeaterItem in rptFilter.Items)
                foreach (Control control in repeaterItem.Controls)
                {
                    if (control is HiddenField)
                        attributeID = int.Parse(((HiddenField)control).Value);
                    if (control is CheckBoxList)
                        foreach (ListItem value in ((CheckBoxList)control).Items)
                            if (value.Selected)
                                attributes.Add(new AttributeValue(int.Parse(value.Value), value.Text, attributeID, 0, string.Empty, 0));
                }

            List<Product> products = new ProductBL().GetProducts(ViewState["categoryUrl"].ToString(), brands, attributes, sort, cmbPriceFrom.SelectedItem.Text, cmbPriceTo.SelectedItem.Text);

            PagedDataSource pagedDataSource = new PagedDataSource();
            pagedDataSource.DataSource = products;
            pagedDataSource.AllowPaging = true;
            pagedDataSource.PageSize = pageSize;
            //if (currentPage >= pagedDataSource.PageCount)
                //currentPage = pagedDataSource.PageCount - 1;
            //if (currentPage < 0)
                //currentPage = 0;
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

        private void loadSubcategories(Category category)
        {
            rptSubcategories.DataSource = new CategoryBL().GetChildrenCategories((int)category.ParentCategoryID);
            rptSubcategories.DataBind();
        }
    }
}