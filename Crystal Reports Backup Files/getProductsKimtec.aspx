<%@ Page Language="C#" MasterPageFile="~/administrator/adminPanel.Master" AutoEventWireup="true" CodeBehind="getProductsKimtec.aspx.cs" Inherits="eshopv2.administrator.getProductsKimtec" Title="Preuzimanje proizvoda - Kimtec" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div id="divPleaseWait" runat="server" class="pleaseWait" style="display:none">
    <span>Molim, sačekajte</span>
</div>
    <div id="page-wrapper">
        
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">Preuzimanje proizvoda Kimtec</h1>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-6 btn-group">
                <%--<asp:Button ID="btnGetProducts" runat="server" Text="Učitaj proizvode" OnClick="btnGetProducts_Click" CssClass="btn btn-primary" OnClientClick="showPleaseWait()" />--%>
                <button type="button" class="btn btn-primary" id="btnGetProductsFromKimtecAjax" onclick="GetProductsFromKimtec()">Učitaj proizvode (Ajax)</button>
                <%--<asp:Button ID="btnGetCategories" runat="server" Text="Ažuriraj kategorije" OnClick="btnGetCategories_Click" CssClass="btn btn-primary" OnClientClick="showPleaseWait()" />--%>
                <button type="button" class="btn btn-primary" id="btnGetCategoriesFromKimtec" onclick="GetCategoriesFromKimtec()">Učitaj kategorije</button>
                <%--<asp:Button ID="btnGetSpecification" runat="server" Text="Učitaj specifikaciju" OnClick="btnGetSpecification_Click" CssClass="btn btn-primary" OnClientClick="showPleaseWait()" />--%>
                <button type="button" class="btn btn-primary" id="btnGetProductsSpecificationFromKimtec" onclick="GetProductsSpecificationFromKimtec()">Učitaj specifikaciju</button>
            </div>
            <div class="col-lg-6">
                Proizvodi učitani: <asp:Label ID="lblProductsLoaded" runat="server"></asp:Label>
                <asp:Label ID="lblCategoriesLoaded" runat="server"></asp:Label>
                <asp:Label ID="lblSpecificationLoaded" runat="server"></asp:Label>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12">
                
                
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12">
                
                
            </div>
        </div>
        <div class="row margin-top-05">
            <div class="col-lg-5">
                <div class="form-group">
                    <label for="cmbCategory">Kategorija:</label>
                    <asp:DropDownList ID="cmbCategory" runat="server" OnSelectedIndexChanged="cmbCategory_SelectedIndexChanged" AutoPostBack="true" CssClass="form-control"></asp:DropDownList>
                    
                </div>
            </div>
            <div class="col-lg-6 col-lg-offset-1">
                <div class="form-group">
                    <label for="cmbKimtecCategory">Kimtec kategorija:</label>
                    <asp:DropDownList ID="cmbKimtecCategory" runat="server" OnSelectedIndexChanged="cmbKimtecCategory_SelectedIndexChanged" AutoPostBack="true" CssClass="form-control"></asp:DropDownList>
                    
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-5">
                <asp:ListBox ID="lstCategory" runat="server" Height="200px" SelectionMode="Multiple" Width="100%"></asp:ListBox>
            </div>
            <div class="col-lg-1">
                <asp:Button ID="btnAddCategory" runat="server" OnClick="btnAddCategory_Click" Text="<" />
                <asp:Button ID="btnRemoveCategory" runat="server" OnClick="btnRemoveCategory_Click" Text=">" />
            </div>
            <div class="col-lg-6">
                <asp:ListBox ID="lstKimtecCategory" runat="server" Height="200px" SelectionMode="Multiple" Width="100%"></asp:ListBox>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12">
                
                <%--<asp:Button ID="btnGetPrice" runat="server" Text="Učitaj cene" OnClick="btnGetPrice_Click" />--%>
                <%--<asp:Button ID="btnGetBarcode" runat="server" Text="Učitaj barkod" OnClick="btnGetBarcode_Click" />--%>
                
                <asp:Button ID="btnLoadProducts" runat="server" Text="Učitaj" OnClick="btnLoadProducts_Click" CssClass="btn btn-primary" OnClientClick="showPleaseWait()" />
                
                
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12">
                <asp:Panel ID="pnlOptions" runat="server" Visible="false">
                    <div class="checkbox">
                        <asp:CheckBox ID="chkSelectNew" runat="server" Text="Obeleži nove" OnCheckedChanged="chkSelectNew_CheckedChanged" AutoPostBack="true" />
                    </div>
                    <div class="checkbox">
                        <asp:CheckBox ID="chkActive" runat="server" Text="Aktiviraj" />
                    </div>                    
                    <div class="checkbox">
                        <asp:CheckBox ID="chkApprove" runat="server" Text="Odobri" />
                    </div>
                    <asp:Button ID="btnSaveProducts" runat="server" Text="Sačuvaj" OnClick="btnSaveProducts_Click" CssClass="btn btn-primary" OnClientClick="showPleaseWait()" />
                </asp:Panel>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12">
                <div id="divAlert" runat="server" visible="false">
                    <asp:Label ID="lblAlert" runat="server"></asp:Label>
                </div>
            </div>
        </div>
        <div class="row margin-top-50">
            <div class="col-lg-12">
                <asp:GridView ID="dgvProducts" runat="server" CssClass="table table-hover table-bordered table-condensed table-striped" AutoGenerateColumns="false"
                OnRowDataBound="dgvProducts_RowDataBound">
                    <Columns>
                        <asp:TemplateField Visible="false">
                            <ItemTemplate>
                                <asp:Label ID="lblImageUrl" runat="server" Text='<%#Eval("imageUrl") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField Visible="false">
                            <ItemTemplate>
                                <asp:Label ID="lblKimtecProductID" runat="server" Text='<%#Eval("kimtecProductID") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <HeaderTemplate>
                                <asp:CheckBox ID="chkSelectAll" runat="server" />
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:CheckBox ID="chkSave" runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Šifra">
                            <ItemTemplate>
                                <asp:Label ID="lblCode" runat="server" Text='<%#Eval("code") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Barcode">
                            <ItemTemplate>
                                <asp:Label ID="lblBarcode" runat="server" Text='<%#Eval("barcodeValue") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Kategorija">
                            <ItemTemplate>
                                <asp:Label ID="lblType" runat="server" Text='<%#Eval("type") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Brand">
                            <ItemTemplate>
                                <asp:Label ID="lblBrand" runat="server" Text='<%#Eval("brand") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Naziv">
                            <ItemTemplate>
                                <asp:Label ID="lblName" runat="server" Text='<%#Eval("name") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Model">
                            <ItemTemplate>
                                <asp:Label ID="lblModel" runat="server" Text='<%#Eval("model") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Nabavna cena" ItemStyle-HorizontalAlign="Right">
                            <ItemTemplate>
                                <asp:Label ID="lblPartnerPrice" runat="server" Text='<%#String.Format("{0:N2}", Eval("partnerPrice")) %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField Visible="false">
                            <ItemTemplate>
                                <asp:Label ID="lblExist" runat="server" Text='<%#Eval("exist") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:Image ID="imgStatus" runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField Visible="false">
                            <ItemTemplate>
                                <asp:Label ID="lblDescription" runat="server" Text='<%#Eval("marketingDescription") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField Visible="false">
                            <ItemTemplate>
                                <asp:Label ID="lblStock" runat="server" Text='<%#Eval("availability") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>
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
                cell = grid.rows[i].cells[0];

                //loop according to the number of childNodes in the cell

                for (j = 0; j < cell.childNodes.length; j++) {
                    //if childNode type is CheckBox
                    //for (k = 0; k < cell.childNodes[j].childNodes.length; k++) {

                        if (cell.childNodes[j].type == "checkbox") {
                            //assign the status of the Select All checkbox to the cell checkbox within the grid
                            cell.childNodes[j].checked = document.getElementById(id).checked;
                        }
                    //}
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
