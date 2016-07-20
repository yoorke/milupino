<%@ Page Language="C#" MasterPageFile="~/administrator/adminPanel.Master" AutoEventWireup="true" CodeBehind="attributes.aspx.cs" Inherits="eshopv2.administrator.attributes" Title="Atributi | Admin panel" %>
<%@ Register src="../user_controls/CustomStatus.ascx" tagname="CustomStatus" tagprefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">Atributi</h1>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12">
                <div class="btn-group">
                    <asp:Button ID="btnAddAttribute" runat="server" Text="Dodaj atribut" OnClick="btnAddAttribute_Click" CssClass="btn btn-primary" />            
                </div>
            </div>
        </div>
        <div class="row margin-top-05">
            <div class="col-lg-5">
                <label for="cmbCategory">Kategorija: </label>
                <asp:DropDownList ID="cmbCategory" runat="server" OnSelectedIndexChanged="cmbCategory_SelectedIndexChanged" AutoPostBack="true" CssClass="form-control"></asp:DropDownList>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12">
                <uc1:CustomStatus ID="csStatus" runat="server" />            
            </div>
        </div>
        <div class="row margin-top-05">
            <div class="col-lg-12">
                <asp:GridView ID="dgvAttributes" runat="server" AutoGenerateColumns="false" CssClass="table table-condesed table-bordered table-hover table-striped"
                    OnRowDeleting="dgvAttributes_RowDeleting" DataKeyNames="attributeID">
                    <Columns>
                        <asp:TemplateField HeaderText="AttributeID" ItemStyle-Width="50px">
                            <ItemTemplate>
                                <asp:Label ID="lblAttributeID" runat="server" Text='<%#Eval("attributeID") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField HeaderText="Naziv">
                            <ItemTemplate>
                                <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%#"/administrator/attribute.aspx?id=" + Eval("attributeID") %>'>
                                    <asp:Label ID="lblName" runat="server" Text='<%#Eval("name") %>'></asp:Label>
                                </asp:HyperLink>
                            </ItemTemplate>
                        </asp:TemplateField>
            
                        <asp:CommandField ShowDeleteButton="true" DeleteText="" DeleteImageUrl="/images/delete_icon.png" ButtonType="Image" />
                    </Columns>
                </asp:GridView>            
            </div>
        </div>
    </div><!--page-wrapper-->
    
    
    
    
    
    
    
    
    
    
    <%--<div id="topMenu">--%>
        
        
    <%--</div>--%>
    
    <%--<div id="mainContent">--%>
    
    <%--<asp:HyperLink ID="lnkAddAttribute" runat="server" Text="Dodaj atribut" CssClass="button" NavigateUrl="/administrator/attribute.aspx"></asp:HyperLink>--%>
    
    
        
    
    
    
    <%--<p class="row">
        <label class="label">Naziv: </label><asp:TextBox ID="txtName" runat="server"></asp:TextBox>
        <asp:Button ID="btnAddAttribute" runat="server" Text="Dodaj" OnClick="btnAddAttribute_Click" />
    </p>--%>
    <%--</div>--%>
    
</asp:Content>
