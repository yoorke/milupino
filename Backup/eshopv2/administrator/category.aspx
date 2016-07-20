<%@ Page Language="C#" MasterPageFile="~/administrator/adminPanel.Master" AutoEventWireup="True" CodeBehind="category.aspx.cs" Inherits="eshopv2.administrator.category" Title="Nova kategorija" %>
<%--@ Register src="../user_controls/CustomStatus.ascx" tagname="CustomStatus" tagprefix="uc1"--%>
<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor"%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">Kategorija: <asp:Literal ID="lblCategoryName" runat="server"></asp:Literal></h1>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12">
                <div class="btn-group">
                    <asp:Button id="btnSave" runat="server" Text="Sačuvaj" OnClick="btnSave_Click" CssClass="btn btn-primary" />
                    <asp:Button ID="btnSaveClose" runat="server" Text="Sačuvaj i zatvori" OnClick="btnSaveClose_Click" CssClass="btn btn-default" />
                    <asp:Button ID="btnClose" runat="server" Text="Zatvori" OnClick="btnClose_Click" CssClass="btn btn-default" />
                </div>
            </div>
        </div><!--row-->
        <div class="row">
            <div class="col-lg-12">
                <%--<uc1:CustomStatus ID="csStatus" runat="server" />--%>
            </div>
        </div><!--row-->
        <div class="row margin-top-05">
            <div class="col-lg-12">
                <ul class="nav nav-tabs" id="tabs" data-tabs="tabs">
                    <li class="active"><a href="#kategorija" data-toggle="tab">Kategorija</a></li>
                    <li><a href="#atributi" data-toggle="tab">Atributi</a></li>
                    <li><a href="#izracunavanjeCene" data-toggle="tab">Izračunavanje cene</a></li>
                    <li><a href="#prvaStrana" data-toggle="tab">Prva strana</a></li>
                </ul><!--tabs-->
                <div id="tab-content"  class="tab-content">
                    <div class="tab-pane active" id="kategorija">
                        <div class="row">
                            <div class="col-lg-5">
                                <asp:HiddenField ID="lblCategoryID" runat="server" />
                                <div role="form">
                                    <div class="form-group">
                                        <label for="txtName">Naziv:</label>
                                        <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Naziv"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="txtName" ErrorMessage="Unesite naziv" runat="server" Display="Dynamic"></asp:RequiredFieldValidator>
                                    </div><!--form-group-->
                                    <div class="form-group">
                                        <label for="cmbParent">Nadkategorija:</label>
                                        <asp:DropDownList ID="cmbParent" runat="server" CssClass="form-control"></asp:DropDownList>    
                                    </div><!--form-group-->
                                    <div class="form-group">
                                        <label for="txtUrl">Url:</label>
                                        <asp:TextBox ID="txtUrl" runat="server" CssClass="form-control" placeholder="Url"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="txtUrl" ErrorMessage="Unesite url kategorije" runat="server" Display="Dynamic"></asp:RequiredFieldValidator>
                                    </div><!--form-group-->
                                    <div class="form-group">
                                        <label for="txtImageUrl">Image url:</label>
                                        <asp:TextBox ID="txtImageUrl" runat="server" CssClass="form-control" placeholder="ImageUrl"></asp:TextBox>
                                    </div><!--form-group-->
                                    <div class="form-group">
                                        <label for="txtSortOrder">Redni broj:</label>
                                        <asp:TextBox ID="txtSortOrder" runat="server" CssClass="form-control" placeholder="Redni broj"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ControlToValidate="txtSortOrder" ErrorMessage="Unesite redni broj" runat="server" Display="Dynamic"></asp:RequiredFieldValidator>
                                        <asp:RangeValidator ID="RangeValidator1" ControlToValidate="txtSortOrder" MinimumValue="1" MaximumValue="1000" ErrorMessage="Redni broj mora imati celobrojnu vrednost" Type="Integer" runat="server" Display="Dynamic"></asp:RangeValidator>
                                    </div><!--form-group-->
                                    
                                </div><!--form-->
                            </div><!--col-->
                        </div><!--row-->
                        <div class="row">
                            <div class="col-lg-12">
                                <div role="form">
                                    <div class="form-group">
                                        <label for="txtDescription">Opis: </label>
                                        <CKEditor:CKEditorControl ID="txtDescription" runat="server" BasePath="/ckeditor" Height="300px" CssClass="form-control"></CKEditor:CKEditorControl>
                                        <%--<asp:TextBox ID="txtDescription" runat="server" Width="500px" Height="300px" TextMode="MultiLine"></asp:TextBox>--%>
                                    </div><!--form-group-->
                                </div>  
                            </div><!--col-->
                        </div><!--row-->
                    </div><!--kategorija-->
                    <div class="tab-pane" id="atributi">
                        <div class="row margin-top-05">
                            <div class="col-lg-12">
                                <div class="btn-group">
                                    <asp:Button ID="btnSavePositions" runat="server" Text="Sačuvaj pozicije" OnClick="btnSavePositions_Click" CssClass="btn btn-primary" />
                                </div>
                            </div><!--col-->
                         </div><!--row-->
                        <div class="row margin-top-05">
                            <div class="col-lg-12">
                                <asp:GridView ID="dgvAttributes" runat="server" AutoGenerateColumns="false"
                                CssClass="table table-condesed table-hover table-bordered table-striped" OnRowDeleting="dgvAttributes_RowDeleting" DataKeyNames="attributeID">
                                <Columns>
                                    <asp:TemplateField HeaderText="attributeID" Visible="false">
                                        <ItemTemplate>
                                            <asp:Label ID="lblAttributeID" runat="server" Text='<%#Eval("attributeID") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                        
                                    <asp:TemplateField HeaderText="Naziv" ControlStyle-Width="300px">
                                        <ItemTemplate>
                                            <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%#"/administrator/attribute.aspx?id=" + Eval("attributeID") %>'>
                                                <asp:Label ID="lblName" runat="server" Text='<%#Eval("name") %>'></asp:Label>
                                            </asp:HyperLink>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                        
                                    <asp:TemplateField HeaderText="Filter" ControlStyle-Width="50px">
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chkFilter" runat="server" Checked='<%#Eval("filter") %>' OnCheckedChanged="chkFilter_CheckedChanged" AutoPostBack="true" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                        
                                    <asp:TemplateField HeaderText="Opis" ControlStyle-Width="50px">
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chkIsDescription" runat="server" Checked='<%#Eval("isDescription") %>' OnCheckedChanged="chkIsDescription_CheckedChanged" AutoPostBack="true" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                        
                                    <asp:TemplateField HeaderText="Pozicija" ControlStyle-Width="50px">
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtPosition" runat="server" Text='<%#Eval("position") %>'></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                        
                                    <asp:CommandField ShowDeleteButton="true" DeleteText="Obriši" ControlStyle-Width="50px" />
                                </Columns>
                                </asp:GridView>
                
                                
                            </div><!--col-->
                                
                            
                        </div><!--row-->
                        <div class="row margin-top-05">
                            <div class="col-lg-12">
                                <asp:DropDownList ID="cmbAttribute" runat="server" CssClass="form-control"></asp:DropDownList>
                                <asp:Button ID="btnAddAttribute" Text="Dodaj" OnClick="btnAddAttribute_Click" runat="server" CssClass="btn btn-primary" />
                            </div>
                        </div>
                    </div><!--atributi-->
                    <div class="tab-pane" id="izracunavanjeCene">
                        <div class="row">
                            <div class="col-lg-5">
                                <div role="form">
                                    <div class="form-group">
                                        <label for="txtPricePercent">MP cena [%]: </label>
                                        <div class="input-group">
                                            <asp:TextBox ID="txtPricePercent" runat="server" CssClass="form-control" placeholder="MP cena [%]"></asp:TextBox>
                                            <span class="input-group-addon"><i>%</i></span>
                                            <%--<span class="glyphicon glyphicon-user form-control-feedback"></span>--%>
                                        </div><!--input-group-->
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" ControlToValidate="txtPricePercent" ErrorMessage="Morate uneti MP procenat" runat="server"></asp:RequiredFieldValidator>
                                    </div><!--form-group-->
                                    <div class="form-group">
                                        <label for="txtWebPricePercent">Web cena [%]: </label>
                                        <div class="input-group">
                                            <asp:TextBox ID="txtWebPricePercent" runat="server" CssClass="form-control" placeholder="Web cena [%]"></asp:TextBox>
                                            <span class="input-group-addon"><i>%</i></span>
                                        </div><!--input-group-->
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" ControlToValidate="txtWebPricePercent" ErrorMessage="Morate uneti Web cena procenat" runat="server"></asp:RequiredFieldValidator>
                                    </div><!--form-group-->
                                    <div class="form-group">
                                        <p>Maloprodajna cena se izračunava tako što se na nabavnu cenu doda procenat unet u polje MP cena i iznos PDV-a.<br />
                                            Web cena se izračunava tako što se na nabavnu cenu doda procenat unet u polje Web cena i iznos PDV-a.
                                        </p>
                                    </div><!--form-group-->
                                </div><!--form-->
                            </div><!--col-->
                        </div><!--row-->
                    </div><!--izracunavanjeCene-->
                    <div class="tab-pane" id="prvaStrana">
                        <div class="row">
                            <div class="col-lg-5">
                                <div role="form">
                                    <div class="form-group">
                                        <asp:CheckBox ID="chkShowOnFirstPage" runat="server" Text="Prikaži na prvoj strani" OnCheckedChanged="chkShowOnFirstPage_CheckedChanged" AutoPostBack="true" CssClass="checkbox" />
                                    </div><!--form-group-->
                                    <div class="form-group">
                                        <label for="txtNumber">Broj proizvoda: </label>
                                        <asp:TextBox ID="txtNumber" runat="server" CssClass="form-control" placeholder="Broj proizvoda"></asp:TextBox>
                                    </div><!--form-group-->
                                    <div class="form-group">
                                        <label for="txtSortOrderFirstPage">Redni broj: </label>
                                        <asp:TextBox ID="txtSortOrderFirstPage" runat="server" CssClass="form-control" placeholder="Redni broj"></asp:TextBox>
                                    </div><!--form-group-->
                                    <div class="form-group">
                                        <label for="cmbCriterion">Kriterijum: </label>
                                        <asp:DropDownList ID="cmbCriterion" runat="server" CssClass="form-control"></asp:DropDownList>
                                    </div><!--form-group-->
                                </div><!--form-->
                            </div><!--col-->
                        </div><!--row-->
                    </div><!--prvaStrana-->
                </div><!--tab-content-->
            </div>
        </div>
    </div><!--page-wrapper-->
    <%--<div id="topMenu">
        
    </div>
    
    <div id="mainContent">
    
    <ajaxtoolkit:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server" EnablePartialRendering="true"></ajaxtoolkit:ToolkitScriptManager>

    <ajaxtoolkit:TabContainer ID="TabContainer1" runat="server" Width="700px">
    
        <ajaxtoolkit:TabPanel ID="TabPanel1" HeaderText="Kategorija" runat="server">
            <ContentTemplate>
                
                
                
                
            </ContentTemplate>
        </ajaxtoolkit:TabPanel>
        
        <ajaxtoolkit:TabPanel ID="TabPanel2" HeaderText="Atributi" runat="server">
            <ContentTemplate>
                
                
            </ContentTemplate>
        </ajaxtoolkit:TabPanel>
        
        <ajaxtoolkit:TabPanel ID="tbpPrice" HeaderText="Izračunavanje cene" runat="server">
            <ContentTemplate>
                
                
            </ContentTemplate>
        </ajaxtoolkit:TabPanel>   
        
        <ajaxtoolkit:TabPanel ID="tbpFirstPage" HeaderText="Prva strana" runat="server">
            <ContentTemplate>
                
            </ContentTemplate>
        </ajaxtoolkit:TabPanel>
        
    </ajaxtoolkit:TabContainer>
    
    
    </div>
--%>
<%--<script type="text/javascript">
    jQuery(document).ready(function($) {
        $('#tabs').tab();
    });
</script>--%>
</asp:Content>
