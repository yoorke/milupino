<%@ Page Language="C#" MasterPageFile="~/administrator/adminPanel.Master" AutoEventWireup="true" CodeBehind="kimtecCategories.aspx.cs" Inherits="eshopv2.administrator.kimtecCategories" Title="Kimtec kategorija | Admin panel" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">Kimtec kategorije</h1>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12">
                <asp:DataGrid ID="dgvCategories" runat="server" AutoGenerateColumns="false" CssClass="table table-bordered table-condensed table-hover table-striped">
                    <Columns>
                        <asp:TemplateColumn Visible="false">
                            <ItemTemplate>
                                <asp:Label ID="lblKimtecCategoryID" runat="server" Text='<%#Eval("kimtecCategoryID") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateColumn>
                        <asp:TemplateColumn HeaderText="Naziv">
                            <ItemTemplate>
                                <asp:Label ID="lblName" runat="server" Text='<%#Eval("name") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateColumn>
                        <asp:TemplateColumn HeaderText="Prikaži kao osnovnu">
                            <ItemTemplate>
                                <asp:CheckBox ID="chkShowAsRoot" runat="server" Checked='<%#Eval("isRoot") %>' AutoPostBack="true" OnCheckedChanged="chkShowAsRoot_CheckedChanged" />
                            </ItemTemplate>
                        </asp:TemplateColumn>
                    </Columns>
                </asp:DataGrid>
            </div>
        </div>
    </div>
</asp:Content>
