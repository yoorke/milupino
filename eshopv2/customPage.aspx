<%@ Page Language="C#" MasterPageFile="~/eshop2.Master" AutoEventWireup="true" CodeBehind="customPage.aspx.cs" Inherits="eshopv2.customPage" Title="Untitled Page" %>
<%@ Register Src="user_controls/Banner.ascx" TagName="Banner" TagPrefix="banner" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <asp:Literal ID="canonicalUrl" runat="server"></asp:Literal>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="col-xs-2 left-column visible-lg visible-md">
        <banner:Banner ID="banner1" runat="server" Position="FP1" />
        <banner:Banner ID="banner2" runat="server" Position="FP2" />        
    </div>
    <div class="col-lg-10 col-md-10 col-sm-12 col-xs-12" id="customPage">
        <h1 class="heading"><asp:Literal ID="lblHeading" runat="server"></asp:Literal></h1>
        
        <div id="divContent" runat="server"></div>
    </div>
</asp:Content>
