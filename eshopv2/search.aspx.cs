using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using eshopBL;
using eshopBE;

namespace eshopv2
{
    public partial class search : System.Web.UI.Page
    {
        private int currentPage
        {
            get { return ViewState["currentPage"] != null ? int.Parse(ViewState["currentPage"].ToString()) : 0; }
            set { ViewState["currentPage"] = value; }
        }

        private int pageSize
        {
            get { return ViewState["pageSize"] != null ? int.Parse(ViewState["pageSize"].ToString()) : 16; }
            set { ViewState["pageSize"] = value; }
        }

        private string sort
        {
            get { return ViewState["sort"] != null ? ViewState["sort"].ToString() : "priceAsc"; }
            set { ViewState["sort"] = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                string searchString = string.Empty;
                if (Request.QueryString.ToString().Contains("a="))
                {
                    searchString = Request.QueryString["a"].ToString();
                    lblHeading.Text = "Pretraga: " + searchString;
                    ViewState["searchString"] = searchString;
                    loadIntoForm();
                    searchProducts();
                }
            }
        }

        private void searchProducts()
        {
            string searchString = ViewState["searchString"].ToString();
            List<Product> products = new ProductBL().SearchProducts(searchString, sort);
            PagedDataSource pagedDataSource = new PagedDataSource();
            pagedDataSource.DataSource = products;
            pagedDataSource.AllowPaging = true;
            pagedDataSource.PageSize = pageSize;
            pagedDataSource.CurrentPageIndex = currentPage;
            ViewState["totalPages"] = pagedDataSource.PageCount;

            if(products != null)
            {
                pager1.TotalPages = int.Parse(ViewState["totalPages"].ToString());
                pager1.currentPage = currentPage;
                pager1.doPaging();

                rptProducts.DataSource = pagedDataSource;
                rptProducts.DataBind();
            }
            else
            {
                rptProducts.DataSource = null;
                rptProducts.DataSourceID = null;
                rptProducts.DataBind();
            }
            
        }

        protected void pager1_OnClick(int currentPage)
        {
            this.currentPage = currentPage;
            searchProducts();
        }

        protected void cmbPageSize_SelectedIndexChanged(object sender, EventArgs e)
        {
            if(cmbPageSize.SelectedIndex > 0)
            {
                pageSize = int.Parse(cmbPageSize.SelectedItem.Value);
                searchProducts();
            }
        }

        protected void cmbSort_SelectedIndexChanged(object sender, EventArgs e)
        {
            if(cmbSort.SelectedIndex > -1)
            {
                sort = cmbSort.SelectedItem.Value;
                searchProducts();
            }
        }

        private void loadIntoForm()
        {
            cmbPageSize.Items.Add("16");
            cmbPageSize.Items.Add("32");
            cmbPageSize.Items.Add("96");
            cmbPageSize.SelectedValue = pageSize.ToString();

            cmbSort.Items.Add(new ListItem("Nazivu", "name"));
            cmbSort.Items.Add(new ListItem("Ceni opadajuće", "priceDesc"));
            cmbSort.Items.Add(new ListItem("Ceni rastuće", "priceAsc"));
            cmbSort.SelectedValue = sort;
        }
    }
}