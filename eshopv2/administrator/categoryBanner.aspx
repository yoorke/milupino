<%@ Page Title="" Language="C#" MasterPageFile="~/administrator/adminPanel.Master" AutoEventWireup="true" CodeBehind="categoryBanner.aspx.cs" Inherits="eshopv2.administrator.categoryBanner" %>
<%@ Register Src="../user_controls/CustomStatus.ascx" TagName="CustomStatus" TagPrefix="customStatus" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header"><asp:Literal ID="lblCategoryBannerName" runat="server"></asp:Literal></h1>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12">
                <div class="btn-group">
                    <asp:Button ID="btnSave" runat="server" OnClick="btnSave_Click" Text="Sačuvaj" CssClass="btn btn-primary" />
                    <asp:Button ID="btnSaveClose" runat="server" OnClick="btnSaveClose_Click" Text="Sačuvaj i zatvori" CssClass="btn btn-default" />
                    <asp:Button ID="btnClose" runat="server" OnClick="btnClose_Click" Text="Zatvori" CssClass="btn btn-default" CausesValidation="false" />
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12">
                <customStatus:CustomStatus ID="csStatus" runat="server" />
            </div>
        </div>
        <div class="row margin-top-2">
            <div class="col-lg-5 col-md-5 col-sm-10 col-xs-12">
                <div role="form">
                    <asp:HiddenField ID="lblCategoryBannerID" runat="server" />
                    <div class="form-group">
                        <label for="txtCategoryBannerName">Naziv: </label>
                        <asp:TextBox ID="txtCategoryBannerName" runat="server" CssClass="form-control"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="requiredFieldValidator1" runat="server" ControlToValidate="txtCategoryBannerName" ErrorMessage="Unesite naziv"></asp:RequiredFieldValidator>
                    </div>
                    <div class="form-group">
                        <label>Baner:</label>
                        <asp:Image ID="imgCategoryBanner" runat="server" />
                        <asp:FileUpload ID="fluImage" runat="server" />
                        <asp:Button ID="btnImageUpload" runat="server" Text="Dodaj baner" OnClick="btnImageUpload_Click" CssClass="btn btn-primary margin-top-05" CausesValidation="false" />
                    </div>
                    <div class="form-group">
                        <label for="txtUrl">Url:</label>
                        <asp:TextBox ID="txtUrl" runat="server" CssClass="form-control"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="requiredFieldValidator2" runat="server" ControlToValidate="txtUrl" ErrorMessage="Unesite url"></asp:RequiredFieldValidator>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderFooter" runat="server">
</asp:Content>
