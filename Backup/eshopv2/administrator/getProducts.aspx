<%@ Page Language="C#" MasterPageFile="~/administrator/adminPanel.Master" AutoEventWireup="true"
    CodeBehind="getProducts.aspx.cs" Inherits="eshopv2.administrator.productsEwe" Title="Preuzimanje artikala | Admin panel" %>
<%@ Register src="../user_controls/CustomStatus.ascx" tagname="CustomStatus" tagprefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<asp:ScriptManager runat="server"></asp:ScriptManager>
<asp:UpdatePanel runat="server">
<ContentTemplate>
<div id="divPleaseWait" runat="server" class="pleaseWait" style="display:none">
    <span>Molim, sačekajte</span>
</div>

    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">Preuzimanje proizvoda Ewe</h1>
            </div>
        </div><!--row-->
        <div class="row">
            <div class="col-lg-5">
                <div class="form-group">
                    <label for="cmbCategory">Kategorija:</label>
                    <asp:DropDownList ID="cmbCategory" runat="server" OnSelectedIndexChanged="cmbCategory_SelectedIndexChanged" AutoPostBack="true" CssClass="form-control"></asp:DropDownList>
                </div><!--form-group-->
            </div><!--col-->
            <div class="col-lg-6 col-lg-offset-1">
                <div class="form-group">
                    <label for="cmbEweCategory">Ewe kategorija:</label>
                    <asp:DropDownList ID="cmbEweCategory" runat="server" OnSelectedIndexChanged="cmbEweCategory_SelectedIndexChanged" AutoPostBack="true" CssClass="form-control"></asp:DropDownList>
                </div><!--form-group-->
            </div><!--col-->
        </div><!--row-->
        <div class="row">
            <div class="col-lg-5">
                <asp:ListBox ID="lstCategory" runat="server" Width="100%" Height="200px" SelectionMode="Multiple" CssClass="form-control"></asp:ListBox>
            </div><!--col-->
            <div class="col-lg-1">
                <asp:Button ID="btnAddCategory" runat="server" Text="<" OnClick="btnAddCategory_Click" CssClass="btn btn-default" />
                <asp:Button ID="btnRemoveCategory" runat="server" Text=">" OnClick="btnRemoveCategory_Click" CssClass="btn btn-default" />    
            </div><!--col-->
            <div class="col-lg-6">
                <asp:ListBox ID="lstSubCategory" runat="server" Width="100%" Height="200px" SelectionMode="Multiple" OnDataBound="lstSubCategory_DataBound" OnDataBinding="lstSubCategory_DataBinding" CssClass="form-control"></asp:ListBox>
            </div><!--col-->
        </div><!--row-->
        <div class="row margin-top-05">
            <div class="col-lg-6">
                <asp:Button ID="btnUpdateStockPrice" runat="server" OnClick="btnUpdateStockPrice_Click" Text="Ažuriraj lager i cene" OnClientClick="showPleaseWait()" CssClass="btn btn-primary" />
                <asp:Button ID="btnGetProducts" runat="server" OnClick="btnGetProducts_Click" Text="Učitaj" OnClientClick="showPleaseWait()" CssClass="btn btn-primary" />
            </div><!--col-->
            <div class="col-lg-6">
                <asp:Button ID="btnUpdateCategories" runat="server" Text="Osveži kategorije" OnClick="btnUpdateCategories_Click" OnClientClick="showPleaseWait()" CssClass="btn btn-primary" />
            </div><!--col-->
        </div><!--row-->
        <div class="row">
            <div class="col-lg-5">
                <asp:Panel ID="pnlOptions" runat="server" Visible="false">
                    <div role="form">
                        <div class="form-group">
                            <asp:CheckBox ID="chkImages" runat="server" Text="Preuzmi slike" Visible="false" CssClass="checkbox" />
                        </div><!--form-group-->
                        <div class="form-group">
                            <asp:CheckBox ID="chkAttributes" runat="server" Text="Preuzmi atribute" Visible="false" CssClass="checkbox" />
                        </div><!--form-group-->
                        <div class="form-group">
                            <asp:CheckBox ID="chkOverwrite" runat="server" Text="Prepiši postojeće" Visible="false" CssClass="checkbox" />
                        </div><!--form-group-->
                        <div class="form-group">
                            <asp:CheckBox ID="chkSelectNew" runat="server" Text="Obeleži nove" OnCheckedChanged="chkSelectNew_CheckedChanged" AutoPostBack="true" CssClass="checkbox" />
                        </div><!--form-group-->
                        <div class="form-group">
                            <asp:CheckBox ID="chkActive" runat="server" Text="Aktiviraj" CssClass="checkbox" />
                        </div><!--form-group-->
                        <div class="form-group">
                            <asp:CheckBox ID="chkApproved" runat="server" Text="Odobri" CssClass="checkbox" />
                        </div><!--form-group-->
                        <div class="form-group">
                            <asp:Button ID="btnSaveProducts" runat="server" Text="Sačuvaj" OnClick="btnSaveProducts_Click" OnClientClick="showPleaseWait()" CssClass="btn btn-primary" />
                        </div><!--form-group-->
                    </div><!--form-->
                </asp:Panel>    
            </div><!--col-->
        </div><!--row-->
        <div class="row">
            <div class="col-lg-12">
                <uc1:CustomStatus ID="csStatus" runat="server" />
            </div>
        </div><!--row-->
        <div class="row">
            <div class="col-lg-12">
                <asp:GridView ID="dgvProducts" runat="server" AutoGenerateColumns="false" CssClass="table table-hover table-bordered table-condensed table-striped"
                    OnRowDataBound="dgvProducts_RowDataBound">
                    <Columns>
                        <%--<asp:TemplateField ControlStyle-Width="30px">
                                <HeaderTemplate>
                                    <asp:CheckBox ID="chkSelectAll" runat="server" />
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkSelect" runat="server" />
                                </ItemTemplate>
                            </asp:TemplateField>--%>
                
                        <asp:TemplateField HeaderText="Šifra" ControlStyle-Width="100px">
                            <ItemTemplate>
                                <asp:Label ID="lblSupplierCode" runat="server" Text='<%#Eval("code") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                
                        <asp:TemplateField HeaderText="Barkod" ControlStyle-Width="100px">
                            <ItemTemplate>
                                <asp:Label ID="lblEan" runat="server" Text='<%#Eval("ean") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                
                        <asp:TemplateField HeaderText="Proizvođač" ControlStyle-Width="100px">
                            <ItemTemplate>
                                <asp:Label ID="lblManufacturer" runat="server" Text='<%#Eval("manufacturer") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                
                        <asp:TemplateField HeaderText="Naziv" ControlStyle-Width="200px">
                            <ItemTemplate>
                                <asp:Label ID="lblName" runat="server" Text='<%#Eval("name") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                
                        <asp:TemplateField HeaderText="Cena" ControlStyle-Width="100px" ItemStyle-HorizontalAlign="Right">
                            <ItemTemplate>
                                <asp:Label ID="lblPrice" runat="server" Text='<%#String.Format("{0:N2}", Eval("price")) %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                
                        <asp:TemplateField ControlStyle-Width="20px">
                            <ItemTemplate>
                                <asp:Image ID="imgStatus" runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>
                
                        <asp:TemplateField HeaderText="Postoji" ControlStyle-Width="100px" Visible="false">
                            <ItemTemplate>
                                <asp:CheckBox ID="chkExists" runat="server" Checked='<%#Eval("exists") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                
                        <asp:TemplateField HeaderText="Sačuvaj" ControlStyle-Width="50px">
                            <HeaderTemplate>
                                <asp:CheckBox ID="chkSelectAll" runat="server" />
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:CheckBox ID="chkSave" runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>        
            </div>
        </div><!--row-->
        <div class="row">
            <div class="col-lg-12">
                <asp:GridView ID="dgvNewCategories" runat="server" CssClass="grid" RowStyle-CssClass="gridRow" AlternatingRowStyle-CssClass="gridAltRow"
                    EditRowStyle-CssClass="gridEditRow" FooterStyle-CssClass="gridFooterRow" AutoGenerateColumns="false"
                    OnSelectedIndexChanged="dgvNewCategories_SelectedIndexChanged">
                    <Columns>
                        <asp:TemplateField Visible="false">
                            <ItemTemplate>
                                <asp:Label ID="lblParentCategoryID" runat="server" Text='<%#Eval("parentCategoryID") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Kategorija" ControlStyle-Width="200px">
                            <ItemTemplate>
                                <asp:Label ID="lblCategory" runat="server" Text='<%#Eval("parentName") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Nove podkategorija" ControlStyle-Width="200px">
                            <ItemTemplate>
                                <asp:Label ID="lblSubCategory" runat="server" Text='<%#Eval("name") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:CommandField ShowSelectButton="true" SelectText="Učitaj" ControlStyle-Width="50px" />
                    </Columns>
                </asp:GridView>        
            </div>
        </div><!--row-->
    </div><!--page-wrapper-->

    
    
    
    
    
    
    
    <%--<div id="topMenu">
        
            
        
        
        <div class="column">
            <p class="row">
                
                
            </p>
            <p class="row">
                
            </p>
        </div>
        <div class="column50">
            
        </div>
        <div class="column">
            <p class="row">
            
            </p>
            <p class="row">
                
                
            </p>
            
            <p class="row">
                
            </p>
            <p class="row">
                
                
            </p>
        </div>
            
        </div>
        
        
    </div>
    
    <div id="mainContent">
        
        
        
    </div>--%>
    </ContentTemplate>
    </asp:UpdatePanel>
    <script type="text/javascript">
    function SelectAll(id) {

        //get reference of GridView control
        var grid = document.getElementById("<%= dgvProducts.ClientID %>");

        //variable to contain the cell of the grid
        var cell;

        if (grid.rows.length > 0) {
            //loop starts from 1. rows[0] points to the header.

            for (i = 1; i < grid.rows.length; i++) {
                //get the reference of first column
                cell = grid.rows[i].cells[6];

                //loop according to the number of childNodes in the cell

                for (j = 0; j < cell.childNodes.length; j++) {
                    //if childNode type is CheckBox
                    for (k = 0; k < cell.childNodes[j].childNodes.length; k++) {

                        if (cell.childNodes[j].childNodes[k].type == "checkbox") {
                            //assign the status of the Select All checkbox to the cell checkbox within the grid
                            cell.childNodes[j].childNodes[k].checked = document.getElementById(id).checked;
                        }
                    }
                }
            }
        }
    }
    </script>
    <script type="text/javascript">
        function showPleaseWait() {
            var divPleaseWait = document.getElementById("ctl00_ContentPlaceHolder1_divPleaseWait").style.display = "block";
        }
    </script>
</asp:Content>
