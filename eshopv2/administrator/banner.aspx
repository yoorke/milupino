<%@ Page Language="C#" MasterPageFile="~/administrator/adminPanel.Master" AutoEventWireup="true" CodeBehind="banner.aspx.cs" Inherits="eshopv2.administrator.banner" Title="Baneri | Admin panel" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">Baneri</h1>
            </div><!--col-->
        </div><!--row-->
        <div class="row">
            <div class="col-lg-12">
                <div class="btn-group">
                    <asp:Button ID="btnSave" runat="server" OnClick="btnSave_Click" Text="Sačuvaj" CssClass="btn btn-primary" />
                    <asp:Button ID="btnSaveClose" runat="server" OnClick="btnSaveClose_Click" Text="Sačuvaj i zatvori" CssClass="btn btn-default" />
                    <asp:Button ID="btnClose" runat="server" OnClick="btnClose_Click" Text="Zatvori" CssClass="btn btn-default" CausesValidation="false" />
                </div><!--btn-group-->
            </div><!--col-->
        </div><!--row-->
        <div class="row margin-top-2">
            <div class="col-lg-5 col-md-5 col-sm-10 col-xs-12">
                <div role="form">
                    <div class="form-group">
                        <label for="cmbPosition">Pozicija: </label>
                        <asp:DropDownList ID="cmbPosition" runat="server" OnSelectedIndexChanged="cmbPosition_SelectedIndexChanged" AutoPostBack="true" CssClass="form-control"></asp:DropDownList>
                    </div><!--form-group-->
                    <div class="form-group">
                        <label for="fluBanner">Dodaj baner: </label>
                        <asp:FileUpload ID="fluBanner" runat="server" />            
                    </div><!--form-group-->
                    <div class="form-group">
                        <label for="txtUrl">Url:</label>
                        <asp:TextBox ID="txtUrl" runat="server" CssClass="form-control"></asp:TextBox>
                    </div><!--form-group-->
                    <div class="form-group">
                        <asp:Button ID="btnUpload" runat="server" OnClick="btnUpload_Click" Text="Dodaj" CssClass="btn btn-primary" />
                    </div><!--form-group-->
                </div><!--form-->
            </div><!--col-->
        </div><!--row-->
        <div class="row">
            <div class="col-lg-5">
                <asp:GridView ID="dgvBanners" runat="server" AutoGenerateColumns="false" CssClass="table table-condensed table-bordered table-hover table-striped"
                    OnRowDeleting="dgvBanners_RowDeleting"
                    DataKeyNames="bannerID">
                    <Columns>
                        <asp:TemplateField Visible="false">
                            <ItemTemplate>
                                <asp:Label ID="lblBannerID" runat="server" Text='<%#Eval("bannerID") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField ItemStyle-Width="200px">
                            <ItemTemplate>
                                <asp:Image ID="imgBanner" runat="server" ImageUrl='<%#Eval("imageUrl") %>' CssClas="img-responsive" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Link">
                            <ItemTemplate>
                                <asp:TextBox ID="txtLink" runat="server" Text='<%#Eval("url") %>'></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:CommandField ShowDeleteButton="true" DeleteImageUrl="~/images/delete_icon.png" ButtonType="Image" ControlStyle-Width="20px" />
                    </Columns>
                </asp:GridView>
            </div><!--col-->
        </div><!--row-->
    </div><!--page-wrapper-->
    
    
    
    
    
    
    
    
    
    <%--
    <div id="topMenu">
        <p class="row">
            
        </p>
        <p class="row">
            
        </p>
    </div>
    
    <div id="mainContent">
    
        <p class="row">
            
        </p>
        <p class="row">
            
        </p>
        <p class="row">
            
            
        </p>
        
    </div>--%>
</asp:Content>
