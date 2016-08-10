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
using System.Text;
using eshopUtilities;

namespace eshopv2.administrator
{
    public partial class product : System.Web.UI.Page
    {
        protected void Page_PreInit(object sender, EventArgs e)
        {








            /*if (Page.IsPostBack)
            {
                if (Session["dropDownCount"] != null)
                {
                    
                }
            }*/
        }

        protected void Page_Init(object sender, EventArgs e)
        {








            /*if (Page.IsPostBack)
            {
                if (Session["dropDownCollection"] != null)
                {
                    List<string> dropDownCollection = (List<string>)Session["dropDownCollection"];
                    int dropDownCount = 1;
                    foreach (string name in dropDownCollection)
                    {
                        DropDownList dropDownAttribute = new DropDownList();
                        dropDownAttribute.ID = "cmbAttribute" + (dropDownCount++).ToString();
                        tbpCategories.Controls.Add(dropDownAttribute);
                    }
                }
            }*/
        }

        protected override void OnInit(EventArgs e)
        {








            base.OnInit(e);
            
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (User.Identity.IsAuthenticated && User.IsInRole("administrator"))
            {
                if (!Page.IsPostBack)
                {
                    loadIntoForm();
                    Session["dropDownCount"] = null;
                    int productID = (Page.Request.QueryString.ToString().Contains("id")) ? int.Parse(Page.Request.QueryString["id"]) : 0;
                    if (productID > 0)
                    {
                        loadProduct(productID);
                    }
                    else
                        ViewState.Add("pageTitle", "Novi proizvod");

                    //ViewState["dropDownCollection"] = null;

                    //TabContainer1.EnableViewState = true;
                    //tbpCategories.EnableViewState = true;
                    Page.EnableViewState = true;

                    Session["dropDownCollection"] = null;

                }
                else
                {
                    if (Session["dropDownCount"] != null)
                    {
                        createControls();
                    }

                    Page.Title = ViewState["pageTitle"].ToString();

                    TabName.Value = Request.Form[TabName.UniqueID];
                }
            }
            else
                Page.Response.Redirect("/administrator/login.aspx?returnUrl=" + Page.Request.RawUrl.Substring(15, Page.Request.RawUrl.Length - 15));
        }

        private void loadIntoForm()
        {
            loadBrands();

            CategoryBL categoryBL = new CategoryBL();
            cmbCategory.DataSource = categoryBL.GetCategories();
            cmbCategory.DataTextField = "name";
            cmbCategory.DataValueField = "categoryID";
            cmbCategory.DataBind();

            VatBL vatBL = new VatBL();
            cmbVat.DataSource = vatBL.GetVats();
            cmbVat.DataValueField = "vatID";
            cmbVat.DataTextField = "vatValue";
            cmbVat.DataBind();
            cmbVat.SelectedIndex = 3;

            loadSupplier();

            PromotionBL promotionBL = new PromotionBL();
            cmbPromotions.DataSource = promotionBL.GetPromotions(true, null, null);
            cmbPromotions.DataTextField = "name";
            cmbPromotions.DataValueField = "promotionID";
            cmbPromotions.DataBind();
        }

        private void loadSupplier()
        {
            SupplierBL supplierBL = new SupplierBL();
            cmbSupplier.DataSource = supplierBL.GetSuppliers(false);
            cmbSupplier.DataTextField = "name";
            cmbSupplier.DataValueField = "supplierID";
            cmbSupplier.DataBind();
        }

        private void loadManufacturers()
        {
            
        }

        private void loadBrands()
        {
            BrandBL brandBL = new BrandBL();
            cmbBrand.DataSource = brandBL.GetBrands(false);
            cmbBrand.DataTextField = "name";
            cmbBrand.DataValueField = "brandID";
            cmbBrand.DataBind();
        }

        private void loadProduct(int productID)
        {
            ProductBL productBL = new ProductBL();
            Product product = productBL.GetProduct(productID, string.Empty, false);

            lblProductID.Value = product.ProductID.ToString();
            txtCode.Text = product.Code;
            txtSupplierCode.Text = product.SupplierCode;
            txtName.Text = product.Name;
            cmbBrand.SelectedValue = cmbBrand.Items.FindByValue(product.Brand.BrandID.ToString()).Value;
            txtDescription.Text = product.Description;
            txtPrice.Text = string.Format("{0:N2}", product.Price);
            txtWebPrice.Text = string.Format("{0:N2}", product.WebPrice);
            txtInsertDate.Text = product.InsertDate.ToString();
            txtUpdateDate.Text = product.UpdateDate.ToString();
            cmbVat.SelectedValue = cmbVat.Items.FindByValue(product.VatID.ToString()).Value;
            cmbSupplier.SelectedValue = cmbSupplier.Items.FindByValue(product.SupplierID.ToString()).Value;
            chkApproved.Checked = product.IsApproved;
            chkActive.Checked = product.IsActive;
            chkLocked.Checked = product.IsLocked;
            chkInStock.Checked = product.IsInStock;
            txtEan.Text = product.Ean;
            txtSpecification.Text = product.Specification;
            Page.Title = product.Name + " | Admin panel";
            ViewState.Add("pageTitle", Page.Title);

            if (product.Promotion != null)
            {
                cmbPromotions.SelectedValue = cmbPromotions.Items.FindByValue(product.Promotion.PromotionID.ToString()).Value;
                txtPromotionPrice.Text = product.Promotion.Price.ToString();
            }

            if (product.Categories != null)
            {
                cmbCategory.SelectedValue = cmbCategory.Items.FindByValue(product.Categories[0].CategoryID.ToString()).Value;
                createControls();
                int i = 0;
                if (product.Attributes != null)
                {
                    int attributeID = -1;
                    foreach (object control in pnlAttributes.Controls)
                    {
                        if (control is Literal)
                        {
                            int.TryParse(((Literal)control).Text, out attributeID);
                        }
                        if (control is customControls.AttributeControl)
                        {
                            int index;
                            if ((index = hasAttribute(product.Attributes, attributeID)) > -1)
                                ((customControls.AttributeControl)control).AttributeValueID = product.Attributes[index].AttributeValueID;
                            else
                                ((customControls.AttributeControl)control).AttributeValue = "NP";
                        }
                    }
                }
            }

            if (product.Images != null)
            {
                ViewState.Add("images", product.Images);
                loadImages();

                string imageUrl = product.Images[0].Substring(0, product.Images[0].IndexOf(".jpg"));
                imgProduct.ImageUrl = createImageUrl(imageUrl, "");
                imgHome.ImageUrl = createImageUrl(imageUrl, "home");
                imgLarge.ImageUrl = createImageUrl(imageUrl, "large");
                imgThumb.ImageUrl = createImageUrl(imageUrl, "thumb");
            }
            /*rptImages.DataSource = product.Images;
            rptImages.DataBind();*/
        }

        private string createImageUrl(string imageUrl, string type)
        {
            return (System.IO.File.Exists(Server.MapPath("~/" + imageUrl + ((type != string.Empty) ? "-" : string.Empty) + type + ".jpg"))) ? imageUrl + ((type != string.Empty) ? "-" : string.Empty) + type + ".jpg" : "/images/no-image.jpg";
        }

        protected void btnImageUpload_Click(object sender, EventArgs e)
        {
            if (fluImage.HasFile)
            {
                int imageID = new ProductBL().GetMaxImageID() + (ViewState["images"] != null ? ((List<string>)ViewState["images"]).Count : 0);
                string directory = createImageUrl(imageID);
                if (!System.IO.Directory.Exists(Server.MapPath("~") + directory))
                    System.IO.Directory.CreateDirectory(Server.MapPath("~") + directory);
                //fluImage.SaveAs(Server.MapPath("~") + "/images/" + fluImage.FileName);
                fluImage.SaveAs(Server.MapPath("~") + directory + imageID.ToString() + ".jpg");
                //System.Drawing.Image original = System.Drawing.Image.FromFile(Server.MapPath("~") + "/images/" + fluImage.FileName);
                System.Drawing.Image original = System.Drawing.Image.FromFile(Server.MapPath("~") + directory + imageID.ToString() + ".jpg");
                int x = original.Width;
                int y = original.Height;

                string path=Server.MapPath("~")+"/images/";
                //System.Drawing.Image thumb = original.GetThumbnailImage(290, (int)((290*y)/x), null, IntPtr.Zero);
                System.Drawing.Image thumb = Common.CreateThumb(original, 290, 220);
                //thumb.Save(path + fluImage.FileName.Substring(0, fluImage.FileName.IndexOf(".jpg")) + "-main.jpg");
                //thumb.Save(path + fluImage.FileName.Substring(0, fluImage.FileName.IndexOf(".jpg")) + "-large.jpg");
                thumb.Save(Server.MapPath("~") + directory + imageID.ToString() + "-large.jpg");

                //thumb = original.GetThumbnailImage(110, (int)((75*y)/x), null, IntPtr.Zero);
                thumb = Common.CreateThumb(original, 160, 120);
                //thumb.Save(path + fluImage.FileName.Substring(0, fluImage.FileName.IndexOf(".jpg")) + "-list.jpg");
                //thumb.Save(path + fluImage.FileName.Substring(0, fluImage.FileName.IndexOf(".jpg")) + "-home.jpg");
                thumb.Save(Server.MapPath("~") + directory + imageID.ToString() + "-home.jpg");

                //thumb = original.GetThumbnailImage(30, (int)((10*y)/x), null, IntPtr.Zero);
                thumb = Common.CreateThumb(original, 45, 35);
                //thumb.Save(path + fluImage.FileName.Substring(0, fluImage.FileName.IndexOf(".jpg")) + "-thumb.jpg");
                thumb.Save(Server.MapPath("~") + directory + imageID.ToString() + "-thumb.jpg");
                thumb.Save(Server.MapPath("~") + directory + imageID.ToString() + "-small.jpg");

                original.Dispose();

                List<string> images;
                if (ViewState["images"] != null)
                    images = (List<string>)ViewState["images"];
                else
                    images = new List<string>();

                images.Add(directory + imageID.ToString() + ".jpg");

                ViewState.Add("images",images);

                loadImages();
            }
        }

        private string createImageUrl(int imageID)
        {
            StringBuilder directory = new StringBuilder();
            directory.Append("/images/p/");
            string imageUrl = imageID.ToString();
            for (int i = 0; i < imageUrl.Length; i++)
                directory.Append(imageUrl[i].ToString() + "/");
            return directory.ToString();
        }

        private void loadImages()
        {
            List<string> images = null;
            if (ViewState["images"] != null)
                images = (List<string>)ViewState["images"];

            rptImages.DataSource = images;
            rptImages.DataBind();
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            saveProduct();
        }

        protected void btnSaveClose_Click(object sender, EventArgs e)
        {
            saveProduct();
            Response.Redirect("/administrator/products.aspx");
        }

        protected void btnClose_Click(object sender, EventArgs e)
        {
            Response.Redirect("/administrator/products.aspx");
        }

        private void saveProduct()
        {
            //main data
            Product product = new Product();
            product.Name = txtName.Text;
            product.Code = txtCode.Text;
            product.SupplierCode = txtSupplierCode.Text;
            product.Brand = new Brand();
            product.Brand.BrandID = int.Parse(cmbBrand.SelectedValue);
            product.Description = txtDescription.Text;
            product.Price = double.Parse(txtPrice.Text);
            product.WebPrice = double.Parse(txtWebPrice.Text);
            product.VatID = int.Parse(cmbVat.SelectedValue);
            //product.InsertDate = product.UpdateDate = DateTime.Now;
            product.SupplierID = int.Parse(cmbSupplier.SelectedValue);
            product.IsApproved = chkApproved.Checked;
            product.IsActive = chkActive.Checked;
            product.IsLocked = chkLocked.Checked;
            product.IsInStock = chkInStock.Checked;
            product.Ean = txtEan.Text;
            product.Specification = txtSpecification.Text;
            product.ProductID = (lblProductID.Value != string.Empty) ? int.Parse(lblProductID.Value) : 0;

            if (cmbPromotions.SelectedIndex > 0)
            {
                product.Promotion = new Promotion();
                product.Promotion.PromotionID = int.Parse(cmbPromotions.SelectedValue);
                product.Promotion.Price = double.Parse(txtPromotionPrice.Text);
            }

            //category and attributes
            if (cmbCategory.SelectedIndex > -1)
            {
                product.Categories = new List<Category>();
                product.Categories.Add(new Category(int.Parse(cmbCategory.SelectedValue), cmbCategory.SelectedItem.Text, 0, string.Empty, string.Empty, 0, 0, 0, string.Empty, -1));
                product.Attributes = new List<AttributeValue>();

                //foreach (object obj in TabContainer1.Controls)
                //{
                //if (obj is AjaxControlToolkit.TabPanel)
                //{
                //AjaxControlToolkit.TabPanel tabPanel = obj as AjaxControlToolkit.TabPanel;

                //if (tabPanel.ID == "tbpCategories")
                //{

                foreach (object control in pnlAttributes.Controls)
                    if (control is customControls.AttributeControl)
                    {
                        //Control c = tpControl as Control;
                        //foreach (object innerCtrl in c.Controls)
                        //{
                        //if (innerCtrl is DropDownList)
                        //if (((DropDownList)tpControl).ID != "cmbCategory")
                        product.Attributes.Add(new AttributeValue(((customControls.AttributeControl)control).AttributeValueID, ((customControls.AttributeControl)control).AttributeValue, -1, 0, string.Empty, 0));
                        //}

                    }
                //}
                //}
                //}
            }

            //images
            if (rptImages.Items.Count > 0)
            {
                product.Images = new List<string>();
                List<string> images = (List<string>)ViewState["images"];
                foreach (string imageUrl in images)
                {
                    product.Images.Add(imageUrl);
                }
            }



            ProductBL productBL = new ProductBL();
            string productID = productBL.SaveProduct(product).ToString();
            if (lblProductID.Value == "")
                lblProductID.Value = productID;

            
        }

        protected void cmbCategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            createControls();






            /*AttributeBL attributeBL = new AttributeBL();
            List<eshopBE.Attribute> attributes = attributeBL.GetAttributesForCategory(int.Parse(cmbCategory.SelectedValue));

            pnlAttributes.Controls.Add(new LiteralControl("<br />"));

            List<string> dropDownCollection = new List<string>();
            Session["dropDownCollection"] = null;
            int dropDownCount = Session["dropDownCount"] == null ? 1 : int.Parse(Session["dropDownCount"].ToString());
            dropDownCount = 1;
            foreach(eshopBE.Attribute attribute in attributes)
            {
                pnlAttributes.Controls.Add(new LiteralControl("<p class='row'>"));
                pnlAttributes.Controls.Add(new LiteralControl("<label class='label'>"));
                Literal name = new Literal();
                name.Text = attribute.Name + ": ";
                pnlAttributes.Controls.Add(name);
                pnlAttributes.Controls.Add(new LiteralControl("</label>"));

                DropDownList dropDownAttribute = new DropDownList();
                dropDownAttribute.ID = "cmbAttribute" + (dropDownCount++).ToString();
                dropDownAttribute.DataSource = attributeBL.GetAttributeValues(attribute.AttributeID);
                dropDownAttribute.DataTextField = "value";
                dropDownAttribute.DataValueField = "attributeValueID";
                dropDownAttribute.DataBind();
                dropDownAttribute.EnableViewState = true;

                pnlAttributes.Controls.Add(dropDownAttribute);

                pnlAttributes.Controls.Add(new LiteralControl("</p>"));

                dropDownCollection.Add(attribute.Name);
            }

            Session.Add("dropDownCollection", dropDownCollection);
            Session.Add("dropDownCount", dropDownCount);*/
        }

        protected override object SaveViewState()
        {
            /*object[] newViewState = new object[2];

            List<int> attributeIDs = new List<int>();

            foreach(object obj in pnlAttributes.Controls)
            {
                if (obj is DropDownList)
                {
                    if (((DropDownList)obj).ID.Contains("cmbAttribute"))
                    {
                        attributeIDs.Add((int.Parse(((DropDownList)obj).SelectedValue)));
                    }
                }
            }

            newViewState[0] = attributeIDs;
            newViewState[1] = base.SaveViewState();
            return newViewState;*/
            return base.SaveViewState();
        }

        protected override void LoadViewState(object savedState)
        {
            /*if (savedState is object[] && ((object[])savedState).Length == 2 && ((object[])savedState)[0] is List<int>)
            {
                object[] newViewState = (object[])savedState;
                List<int> attributesIDs = (List<int>)(newViewState[0]);
                if (attributesIDs.Count > 0)
                {
                    int count = 1;
                    foreach (int i in attributesIDs)
                    {
                        DropDownList dropDownList = new DropDownList();
                        dropDownList.ID = "cmbAttribute" + (count++).ToString();
                        //dropDownList.SelectedValue = dropDownList.Items.FindByValue(attributesIDs[i].ToString()).Value;
                        pnlAttributes.Controls.Add(dropDownList);
                    }
                }
                base.LoadViewState(newViewState[1]);
            }
            else
            {
                base.LoadViewState(savedState);
            }*/
            base.LoadViewState(savedState);
        }

        private void createControls()
        {
            AttributeBL attributeBL = new AttributeBL();
            List<eshopBE.Attribute> attributes = attributeBL.GetAttributesForCategory(int.Parse(cmbCategory.SelectedValue));

            pnlAttributes.Controls.Add(new LiteralControl("<br />"));
            pnlAttributes.Controls.Clear();
            int count = 1;
            if (attributes != null)
            {
                foreach (eshopBE.Attribute attribute in attributes)
                {
                    pnlAttributes.Controls.Add(new LiteralControl("<div class='form-group'>"));
                    pnlAttributes.Controls.Add(new LiteralControl("<label for='cmbAttribute" + (count++).ToString() + "'>"));
                    Literal name = new Literal();
                    name.Text = attribute.Name + ": ";
                    pnlAttributes.Controls.Add(name);
                    name = new Literal();
                    name.Text = attribute.AttributeID.ToString();
                    name.Visible = false;
                    pnlAttributes.Controls.Add(name);
                    pnlAttributes.Controls.Add(new LiteralControl("</label>"));

                    /*DropDownList dropDownAttribute = new DropDownList();
                    dropDownAttribute.ID = "cmbAttribute" + (count++).ToString();
                    dropDownAttribute.DataSource = attributeBL.GetAttributeValues(attribute.AttributeID);
                    dropDownAttribute.DataTextField = "value";
                    dropDownAttribute.DataValueField = "attributeValueID";
                    dropDownAttribute.DataBind();
                    dropDownAttribute.EnableViewState = true;

                    pnlAttributes.Controls.Add(dropDownAttribute);*/

                    //attribute user control
                    //UserControl attributeControl = (UserControl)Page.LoadControl("customControls/AttributeControl.ascx");
                    Control ac = new Control();
                    ac = LoadControl("customControls/AttributeControl.ascx");
                    ac.ID = "cmbAttribute" + (count++).ToString();
                    ((customControls.AttributeControl)ac).AttributeID = attribute.AttributeID;
                    
                    pnlAttributes.Controls.Add(ac);

                    pnlAttributes.Controls.Add(new LiteralControl("</div><!--form-group-->"));


                }
            }
            Session.Add("dropDownCount", count - 1);
        }

        /*protected void btnImageUpload_Click(object sender, EventArgs e)
        {
        }*/

        protected void rptImages_ItemCommand(object sender, RepeaterCommandEventArgs e)
        {
            switch (e.CommandName)
            {
                case "delete": 
                    {
                        string imageUrl = ((Label)e.Item.FindControl("lblImageUrl")).Text;

                        List<string> images=(List<string>)ViewState["images"];
                        foreach (string url in images)
                        {
                            if (url == imageUrl)
                            {
                                images.Remove(url);
                                break;
                            }
                        }
                        ViewState.Add("images", images);
                        loadImages();
                        break; 
                    }
            }
        }

        private int hasAttribute(List<AttributeValue> attributes, int attributeID)
        {
            int attributeIndex = -1;
            int i = 0;
            foreach (AttributeValue attributeValue in attributes)
            {
                if (attributeValue.AttributeID == attributeID)
                {
                    attributeIndex = i;
                    break;
                }
                i++;
            }
            return attributeIndex;
        }

        protected void cmbPromotions_SelectedIndexChanged(object sender, EventArgs e)
        {
            //double value = cmbPromotions.SelectedItem;
            //txtPromotionPrice.Text = ((Promotion)cmbPromotions.SelectedItem).Value.ToString();

        }

        protected void btnAddAttributeValue_Click(object sender, EventArgs e)
        {
            switch(lblType.Value)
            {
                case "attribute":
                    {
                        AttributeBL attributeBL = new AttributeBL();
                        attributeBL.SaveAttributeValue(new AttributeValue(-1, txtAttributeValue.Text, int.Parse(lblAttributeID.Value), 0, string.Empty, 0), false);

                        foreach (object control in pnlAttributes.Controls)
                            if (control is customControls.AttributeControl)
                                if (((customControls.AttributeControl)control).ID == lblAttributeName.Value)
                                    ((customControls.AttributeControl)control).setValues();
                        break;
                    }
                case "supplier":
                    {
                        SupplierBL supplierBL = new SupplierBL();
                        supplierBL.SaveSupplier(new Supplier(-1, txtAttributeValue.Text));
                        loadSupplier();
                        break;
                    }

                case "brand":
                    {
                        BrandBL brandBL = new BrandBL();
                        brandBL.SaveBrand(new Brand(-1, txtAttributeValue.Text));
                        loadBrands();
                        break;
                    }
            }
            txtAttributeValue.Text = string.Empty;
        }

        protected void rptImages_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Image image = ((Image)e.Item.FindControl("imgProduct"));
                if (!image.ImageUrl.Contains("images/"))
                {
                    image.ImageUrl = "/images/" + image.ImageUrl;
                }
            }
        }

        protected void btnClearPromotion_Click(object sender, EventArgs e)
        {

        }
    }
}
