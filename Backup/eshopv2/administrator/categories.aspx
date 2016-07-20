<%@ Page Language="C#" MasterPageFile="~/administrator/adminPanel.Master" AutoEventWireup="true" CodeBehind="categories.aspx.cs" Inherits="eshopv2.administrator.categories" Title="Kategorije | Admin panel" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register src="../user_controls/CustomStatus.ascx" tagname="CustomStatus" tagprefix="uc1" %>
<%--<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>---%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">Kategorije</h1>
            </div><!--col-->
        </div><!--row-->
        <div class="row margin-top-05">
            <div class="col-lg-12">
                <asp:Button ID="btnAddCategory" runat="server" Text="Dodaj kategoriju" OnClick="btnAddCategory_Click" CssClass="btn btn-primary" />
            </div><!--col-->
        </div><!--row-->
        <div class="row margin-top-05">
            <div class="col-lg-12">
                <uc1:CustomStatus ID="csStatus" runat="server" />
    <asp:GridView ID="dgvCategory" runat="server" AutoGenerateColumns="false" OnRowDataBound="dgvCategory_RowDataBound"
        OnRowDeleting="dgvCategory_RowDeleting" DataKeyNames="categoryID"
        CssClass="table table-hover table-bordered table-condensed table-striped">
        <Columns>
            
            <asp:TemplateField HeaderText="Id" ControlStyle-Width="50px">
                <ItemTemplate>
                    <asp:Label ID="lblId" runat="server" Text='<%#Eval("categoryID") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            
            <asp:TemplateField HeaderText="Naziv" ControlStyle-Width="500px">
                <ItemTemplate>
                    <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%#"/administrator/category.aspx?id=" + Eval("categoryID") %>'>
                        <asp:Label ID="lblName" runat="server" Text='<%#Eval("name") %>'></asp:Label>
                    </asp:HyperLink>
                </ItemTemplate>
            </asp:TemplateField>
            
            <asp:CommandField ShowDeleteButton="true" DeleteText="" ControlStyle-Width="20px" DeleteImageUrl="~/images/delete_icon.png" ButtonType="Image" />                
        </Columns>
    </asp:GridView>
            </div><!--col-->
        </div><!--row-->
    </div><!--page-wrapper-->
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    <%--<div id="topMenu">--%>
        
        
    <%--</div>--%>
    
    <%--<div id="mainContent">--%>
    <%--<ajaxtoolkit:ToolkitScriptManager runat="server" EnablePartialRendering="true"></ajaxtoolkit:ToolkitScriptManager>
    <ajaxtoolkit:TabContainer runat="server" Width="400px" Height="150px">
    
        <ajaxtoolkit:TabPanel HeaderText="Kategorija" runat="server">
            <ContentTemplate>
                <asp:TextBox runat="server"></asp:TextBox>
            </ContentTemplate>
        </ajaxtoolkit:TabPanel>
        
        <ajaxtoolkit:TabPanel HeaderText="Atributi" runat="server">
            <ContentTemplate>
                <asp:TextBox runat="server"></asp:TextBox>
            </ContentTemplate>
        </ajaxtoolkit:TabPanel>    
        
    </ajaxtoolkit:TabContainer>--%>
    
    <%--<asp:HyperLink ID="lnkAddCategory" runat="server" Text="Dodaj kategoriju" CssClass="button" NavigateUrl="/administrator/category.aspx"></asp:HyperLink>--%>
    
    
            <%--<asp:TemplateField HeaderText="ParentID" Visible="false">
                <ItemTemplate>
                    <asp:Label ID="lblParentID" runat="server" Text='<%#Eval("parentID") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>--%>
        
    <%--<CKEditor:CKEditorControl ID="txtdede" runat="server" BasePath="/ckeditor" Width="600px" Height="300px"></CKEditor:CKEditorControl>--%>
    <%--</div>--%>
    
</asp:Content>
