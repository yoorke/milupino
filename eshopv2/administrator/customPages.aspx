<%@ Page Language="C#" MasterPageFile="~/administrator/adminPanel.Master" AutoEventWireup="true" CodeBehind="customPages.aspx.cs" Inherits="eshopv2.administrator.customPages" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">Stranice</h1>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12 margin-bottom-10">
                <asp:Button ID="btnAddCustomPage" runat="server" Text="Dodaj stranicu" OnClick="btnAddCustomPage_Click" CssClass="btn btn-primary" />
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12">
                <asp:GridView ID="dgvCustomPages" runat="server" AutoGenerateColumns="false" OnRowDeleting="dgvCustomPages_RowDeleting"
                OnRowCommand="dgvCustomPages_RowCommand" CssClass="table table-bordered table-condensed table-striped table-hover">
                    <Columns>
                        <asp:TemplateField Visible="false">
                            <ItemTemplate><asp:Label ID="lblCustomPageID" runat="server" Text='<%#Eval("customPageID") %>'></asp:Label></ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Title">
                            <ItemTemplate><asp:HyperLink ID="lnkCustomPage" runat="server" NavigateUrl='<%#"/administrator/customPage.aspx?customPageID="+Eval("customPageID") %>'><asp:Label ID="lblTitle" runat="server" Text='<%#Eval("title") %>'></asp:Label></asp:HyperLink></ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField ItemStyle-Width="50px">
                            <ItemTemplate><asp:Button ID="btnDelete" runat="server" Text="Obriši" CommandName="deleteCustomPage" CommandArgument='<%#Eval("customPageID") %>' CssClass="btn btn-danger" OnClientClick='return confirm("Obriši?");' /></ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>
</asp:Content>
