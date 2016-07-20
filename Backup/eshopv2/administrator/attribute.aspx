<%@ Page Language="C#" MasterPageFile="~/administrator/adminPanel.Master" AutoEventWireup="true" CodeBehind="attribute.aspx.cs" Inherits="eshopv2.administrator.attribute" Title="Novi atribut" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">Atribut</h1>
            </div>
        </div><!--row-->
        <div class="row">
            <div class="col-lg-6">
                <div class="btn-group">
                    <asp:Button ID="btnSaveAttribute" runat="server" Text="Sačuvaj" OnClick="btnSaveAttribute_Click" CssClass="btn btn-primary" />                
                    <asp:Button ID="btnSaveClose" runat="server" Text="Sačuvaj i zatvori" OnClick="btnSaveClose_Click" CssClass="btn btn-default" />
                    <asp:Button ID="btnClose" runat="server" Text="Zatvori" OnClick="btnClose_Click" CssClass="btn btn-default" />
                    
                </div>
            </div>
            <div class="col-lg-6 text-right">
                <div class="btn-group">
                    <asp:Button ID="btnSaveSort" runat="server" Text="Sačuvaj sortiranje" OnClick="btnSaveSort_Click" CssClass="btn btn-primary" />
                </div>
            </div>
        </div><!--row-->
        <div class="row margin-top-05">
            <div class="col-lg-12">
                <ul class="nav nav-tabs" id="tabs" data-tabs="tabs">
                    <li class="active"><a href="#atribut" data-toggle="tab">Atribut</a></li>
                    <li><a href="#vrednosti" data-toggle="tab">Vrednosti</a></li>
                </ul>
                <div id="tab-content" class="tab-content">
                    <div class="tab-pane active" id="atribut">
                        <div class="row">
                            <div class="col-lg-5">
                                <div role="form">
                                    <div class="form-group">
                                        <asp:HiddenField ID="lblAttributeID" runat="server" />
                                        <label for="txtName">Naziv:</label>
                                        <asp:TextBox ID="txtName" runat="server" CssClass="form-control"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="requireFieldValidator1" runat="server" ControlToValidate="txtName" ErrorMessage="Unesite naziv" Display="Dynamic"></asp:RequiredFieldValidator>
                                    </div><!--form-group-->
                                    <div class="form-group">
                                        <asp:CheckBox ID="chkIsDescription" runat="server" Text="Opis" CssClass="checkbox" />
                                    </div><!--form-group-->
                                </div>
                            </div>
                        </div><!--row-->
                    </div><!--tab-pane-->
                    <div class="tab-pane" id="vrednosti">
                        <div class="row">
                            <div class="col-lg-12">
                                <asp:GridView ID="dgvAttributeValues" runat="server" AutoGenerateColumns="false"
                                CssClass="table table-condesed table-hover table-bordered table-striped" OnRowDeleting="dgvAttributeValues_RowDeleting" DataKeyNames="attributeValueID">
                                <Columns>
                                    <asp:TemplateField HeaderText="AttributeID" ControlStyle-Width="50px">
                                        <ItemTemplate>
                                            <asp:Label ID="lblAttributeValueID" runat="server" Text='<%#Eval("attributeValueID") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
            
                                    <asp:TemplateField HeaderText="Vrednost" ControlStyle-Width="100px">
                                        <ItemTemplate>
                                            <asp:Label ID="lblValue" runat="server" Text='<%#Eval("value") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                    <asp:TemplateField HeaderText="Sort" ControlStyle-Width="50px">
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtSortIndex" runat="server" Text='<%#Eval("sort") %>'></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                    <asp:TemplateField HeaderText="Kimtec value" ControlStyle-Width="100px">
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtKimtecValue" runat="server" Text='<%#Eval("kimtecValue") %>'></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                    <asp:TemplateField HeaderText="Proizvoda">
                                        <ItemTemplate>
                                            <asp:Label ID="lblCount" runat="server" Text='<%#Eval("count") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                
                                    <asp:CommandField ShowDeleteButton="true" DeleteText="Obriši" ControlStyle-Width="50px" />
                                </Columns>
                                </asp:GridView>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-5">
                                <div role="form">
                                    <div class="form-group">
                                        <label for="txtValue">Nova vrednost: </label>
                                        <asp:TextBox ID="txtValue" runat="server" CssClass="form-control"></asp:TextBox>
                                        <asp:Button ID="btnAddValue" runat="server" Text="Dodaj" OnClick="btnAddValue_Click" CssClass="btn btn-primary" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div><!--tab-pane-->
                </div><!--tab-content-->
            </div>
        </div><!--row-->
    </div>
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    <%--<div id="mainContent">
    <ajaxtoolkit:ToolkitScriptManager ID="toolKitScriptManager1" runat="server" EnablePartialRendering="true"></ajaxtoolkit:ToolkitScriptManager>
    <ajaxtoolkit:TabContainer id="TabContainer1" runat="server" Width="700px">
        <ajaxtoolkit:TabPanel ID="tabPanel1" HeaderText="Atribut" runat="server">
            <ContentTemplate>
                <p class="row">
                
                </p>
                <p class="row">
                    
                </p>
            </ContentTemplate>
        </ajaxtoolkit:TabPanel>
        
        <ajaxtoolkit:TabPanel ID="tabPanel2" HeaderText="Vrednosti" runat="server">
            <ContentTemplate>
                <p class="row">
                    <%--<label class="label">Vrednosti:</label>--%>
                    
                <%--</p>
    
                <p class="row">
                    
                </p>
    
            </ContentTemplate>
    </ajaxtoolkit:TabPanel>
    </ajaxtoolkit:TabContainer>
    
    </div>--%>

</asp:Content>
