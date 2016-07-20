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

namespace eshopv2.administrator
{
    public partial class print : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            CrystalDecisions.CrystalReports.Engine.ReportDocument rp = (CrystalDecisions.CrystalReports.Engine.ReportDocument)Session["orderRp"];
            CrystalReportViewer1.ReportSource = rp;
            CrystalReportViewer1.DataBind();
        }
    }
}
