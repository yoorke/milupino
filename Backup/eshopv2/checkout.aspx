<%@ Page Language="C#" MasterPageFile="~/eshop2.Master" AutoEventWireup="true" CodeBehind="checkout.aspx.cs" Inherits="eshopv2.checkout" Title="Podaci o narudžbini | Webshop" %>
<%--@ Register src="user_controls/checkout.ascx" TagName="Checkout" TagPrefix="uc1"--%>
<%@ Register Src="user_controls/CheckoutV2.ascx" TagName="CheckoutV2" TagPrefix="uc2" %>
<%@ Register Src="user_controls/CheckoutInfo.ascx" TagName="CheckoutInfo" TagPrefix="uc3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%--<div class="bannerColumn">
        <div class="banner"></div>
    </div>--%>
    
    <div class="row">
        <div class="col-lg-12">
            <uc3:CheckoutInfo ID="checkoutInfo1" runat="server" />
            <uc2:CheckoutV2 ID="checkout1" runat="server" />
            <%--<uc1:Checkout ID="checkout1" runat="server" />--%>
        </div>
    </div><!--row-->
    
    <%--<div class="bannerColumn">
        <div class="banner"></div>
    </div>--%>
    
    <script type="text/javascript">
        function scrollToAccount() {
            var a = document.getElementById("account");
            a.scrollIntoView();
            var txtLastname = document.getElementById("ctl00_ContentPlaceHolder1_checkout1_txtLastname");
            txtLastname.focus();
        }
    </script>
</asp:Content>
