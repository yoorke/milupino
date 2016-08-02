<%@ Page Language="C#" MasterPageFile="~/eshop2.Master" AutoEventWireup="true" CodeBehind="wishList.aspx.cs" Inherits="eshopv2.wishList" Title="Lista želja | Milupino" %>
<%@ Register Src="user_controls/Banner.ascx" TagName="Banner" TagPrefix="banner" %>
<%@ Register Src="user_controls/product_fp.ascx" TagName="ProductFP" TagPrefix="product_fp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!--BANNER-->
    <div class="col-xs-2 left-column visible-lg visible-md">
        <banner:Banner ID="banner1" runat="server" Position="FP1" />
        <banner:Banner ID="banner2" runat="server" Position="FP2" />
    </div>
    <!--MAIN CONTENT-->
    <div class="col-xs-12 col-sm-12 col-md-10 col-lg-10 main-content product-content">
        <div class="row">
            <div class="col-lg-12">
                <h1>Lista želja</h1>
            </div>
        </div>
        <div class="row padding-left-05 padding-right-05">
            <asp:Repeater ID="rptProducts" runat="server">
                <ItemTemplate>
                    <div class="col-lg-3 col-md-3 col-sm-3 col-xs-12 padding-left-0 padding-right-0 margin-top-05">
                        <product_fp:ProductFP ID="product_fp1" runat="server" ProductItem='<%#Container.DataItem %>' WishList="true" />
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderFooter" runat="server">
</asp:Content>
