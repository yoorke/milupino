using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using eshopBL;

namespace eshopv2.administrator.customControls
{
    public partial class AttributeControl : System.Web.UI.UserControl
    {
        private int _attributeID;

        public int AttributeID
        {
            get { return _attributeID; }
            set
            {
                _attributeID = value;
                setValues();
            }
        }

        public int AttributeValueID
        {
            get
            {
                if (cmbAttribute.SelectedIndex > -1)
                    return int.Parse(cmbAttribute.SelectedValue);
                else
                    return -1;
            }
            set { cmbAttribute.SelectedValue = cmbAttribute.Items.FindByValue(value.ToString()).Value; }
        }

        public string AttributeValue
        {
            get
            {
                if (cmbAttribute.SelectedIndex > -1)
                    return cmbAttribute.SelectedItem.Text;
                else
                    return string.Empty;
            }
            set { cmbAttribute.SelectedValue = cmbAttribute.Items.FindByText(value).Value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public void setValues()
        {
            AttributeBL attributeBL = new AttributeBL();

            cmbAttribute.DataSource = attributeBL.GetAttributeValues(_attributeID);
            cmbAttribute.DataValueField = "attributeValueID";
            cmbAttribute.DataTextField = "value";
            cmbAttribute.DataBind();
            cmbAttribute.SelectedValue = cmbAttribute.Items.FindByText("NP").Value;
            lblAttributeID.Value = _attributeID.ToString();
        }

        protected void btnAddValue_Click(object sender, EventArgs e)
        {
            
        }

        protected void btnAddAttributeValue_Click(object sender, EventArgs e)
        {
            //AttributeBL attributeBL = new AttributeBL();
            //attributeBL.SaveAttributeValue(new eshopBE.AttributeValue(-1, txtAttributeValue.Text, int.Parse(lblAttributeID.Value)));
            //setValues();
        }
    }
}