<%@ Page Title="" Language="C#" MasterPageFile="~/administrator/adminPanel.Master" AutoEventWireup="true" CodeBehind="categoryBanners.aspx.cs" Inherits="eshopv2.administrator.categoryBanners" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-wrapper">Baneri kategorija</h1>
            </div>
        </div>
        <div class="row margin-top-2">
            <div class="col-lg-12">
                <div class="btn-group">
                    <asp:Button ID="btnAddCategoryBanner" runat="server" OnClick="btnAddCategoryBanner_Click" Text="Dodaj baner" CssClass="btn btn-primary" />
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12">
                <asp:GridView ID="dgvCategoryBanners" runat="server" AutoGenerateColumns="false" OnRowDeleting="dgvCategoryBanners_RowDeleting" DataKeyNames="categoryBannerID" CssClass="table table-condensed table-bordered table-hover table-striped">
                    <Columns>
                        <asp:TemplateField Visible="false">
                            <ItemTemplate>
                                <asp:Label ID="lblCategoryBannerID" runat="server" Text='<%#Eval("categoryBannerID") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Naziv">
                            <ItemTemplate>
                                <asp:HyperLink ID="lnkCategoryBanner" runat="server" NavigateUrl='<%#"/administrator/categoryBanner.aspx?categoryBannerID=" + Eval("categoryBannerID")%>'>
                                <asp:Label ID="lblName" runat="server" Text='<%#Eval("name") %>'></asp:Label>
                                </asp:HyperLink>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Banner">
                            <ItemTemplate>
                                <asp:Label ID="lblImageUrl" runat="server" Text='<%#Eval("imageUrl") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="url">
                            <ItemTemplate>
                                <asp:Label ID="lblUrl" runat="server" Text='<%#Eval("url") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:CommandField ShowDeleteButton="true" ControlStyle-Width="20px" DeleteImageUrl="~/images/delete_icon.png" ButtonType="Image" />
                            
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderFooter" runat="server">
</asp:Content>
