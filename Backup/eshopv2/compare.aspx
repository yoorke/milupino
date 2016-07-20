<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="compare.aspx.cs" Inherits="eshopv2.compare" %>
<%@ Register Src="user_controls/ProductCompare.ascx" TagName="ProductCompare" TagPrefix="ProductCompare" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Upoređivanje proizvoda | PinShop</title>
    <link href="<%=ResolveUrl("~/css/bootstrap.min.css") %>" rel="Stylesheet" />
    <link href="<%=ResolveUrl("~/css/StyleV2.css") %>" rel="Stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:Repeater ID="rptProducts" runat="server">
            <HeaderTemplate>
                <div class="row">
            </HeaderTemplate>
            <ItemTemplate>
                <div class="col-lg-3">
                    <ProductCompare:ProductCompare ID="productCompare" runat="server" Product='<%#Container.DataItem %>' />
                </div>
            </ItemTemplate>
             <FooterTemplate>
                </div>
            </FooterTemplate>
        </asp:Repeater>
    </div>
    </form>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
    <script src="<%=ResolveUrl("~/js/bootstrap.min.js") %>"></script>
    <script src="<%=ResolveUrl("~/js/product.js") %>"></script>
</body>
</html>
