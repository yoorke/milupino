<%@ Page Language="C#" MasterPageFile="~/eshop2.Master" AutoEventWireup="true" CodeBehind="orderSuccessful.aspx.cs" Inherits="eshopv2.orderSuccessful" Title="Narudžbina uspešno prosleđena | Webshop" %>
<%@ Register Src="user_controls/Banner.ascx" TagName="Banner" TagPrefix="banner" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!--<div class="bannerColumn">
        <div class="banner"></div>
    </div>
    <div class="checkout">
        <div class="heading">Narudžbina uspešno prosleđena</div>
        <p class="description">
            Vaša narudžbina je uspešno prosleđena. Uskoro ćete primiti potvrdu na Vašu e-mail adresu sa detaljnim informacijama.
        </p>
    </div>
    <div class="bannerColumn">
        <div class="banner"></div>
    </div>-->
    
    <div class="col-xs-2 left-column visible-md visible-lg">
        <banner:Banner ID="banner1" runat="server" Position="FP1" />
        <banner:Banner ID="banner2" runat="server" Position="FP2" />
    </div><!--col-->
    
    <div class="col-lg-10 col-md-10 col-sm-12 col-xs-12 text-center margin-top-2">
        <span>Vaša narudžbina je uspešno prosleđena. Uskoro ćete primiti potvrdu na Vašu email adresu sa detaljnim informacijama.</span>
    </div>

</asp:Content>
