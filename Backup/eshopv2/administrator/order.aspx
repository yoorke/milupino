<%@ Page Language="C#" MasterPageFile="~/administrator/adminPanel.Master" AutoEventWireup="true" CodeBehind="order.aspx.cs" Inherits="eshopv2.administrator.order" Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">Narudžbenica</h1>
            </div><!--col-->
        </div><!--row-->
        <div class="row">
            <div class="col-lg-12">
                <div class="btn-group">
                    <asp:Button ID="btnClose" runat="server" Text="Zatvori" OnClick="btnClose_Click" CssClass="btn btn-primary" />
                    <asp:Button ID="btnPrint" runat="server" Text="Štampaj" OnClick="btnPrint_Click" CssClass="btn btn-primary" />
                </div><!--btn-group-->
            </div><!--col-->
        </div><!--row-->
        <div class="row margin-top-05">
            <div class="col-sm-4">
                <div role="form" class="form-horizontal">
                    <div class="form-group">
                        <label for="lblCode" class="control-label col-sm-3">Broj:</label>
                        <div class="col-sm-9">
                            <asp:Label ID="lblCode" runat="server" CssClass="form-control"></asp:Label>
                        </div>
                    </div><!--form-group-->
                    <div class="form-group">
                        <label for="lblDate" class="control-label col-sm-3">Datum:</label>
                        <div class="col-sm-9">
                            <asp:Label ID="lblDate" runat="server" CssClass="form-control"></asp:Label>
                        </div>
                    </div><!--form-group-->
                    <div class="form-group">
                        <label for="lblFirstName" class="control-label col-sm-3">Ime:</label>
                        <div class="col-sm-9">
                            <asp:Label ID="lblFirstname" runat="server" CssClass="form-control"></asp:Label>
                        </div>
                    </div><!--form-group-->
                    <div class="form-group">
                        <label for="lblLastname" class="control-label col-sm-3">Prezime:</label>
                        <div class="col-sm-9">
                            <asp:Label ID="lblLastname" runat="server" CssClass="form-control"></asp:Label>
                        </div>
                    </div><!--form-group-->
                    <div class="form-group">
                        <label for="lblUserType" class="control-label col-sm-3">Tip kupca:</label>
                        <div class="col-sm-9">
                            <asp:Label ID="lblUserType" runat="server" CssClass="form-control"></asp:Label>
                        </div>
                    </div><!--form-group-->
                    <div class="form-group">
                        <label for="lblName" class="control-label col-sm-3">Naziv firme:</label>
                        <div class="col-sm-9">
                            <asp:Label ID="lblName" runat="server" CssClass="form-control"></asp:Label>
                        </div>
                    </div><!--form-group-->
                    <div class="form-group">
                        <label for="lblPib" class="control-label col-sm-3">PIB:</label>
                        <div class="col-sm-9">
                            <asp:Label ID="lblPib" runat="server" CssClass="form-control"></asp:Label>
                        </div>
                    </div><!--form-group-->
                </div><!--form-->
            </div><!--col-->
            <div class="col-sm-4">
                <div role="form" class="form-horizontal">
                    <div class="form-group">
                        <label for="lblAddress" class="control-label col-sm-3">Adresa:</label>
                        <div class="col-sm-9">
                            <asp:Label ID="lblAddress" runat="server" CssClass="form-control"></asp:Label>         
                        </div>
                    </div><!--form-group-->
                    <div class="form-group">
                        <label for="lblCity" class="control-label col-sm-3">Mesto:</label>
                        <div class="col-sm-9">
                            <asp:Label ID="lblCity" runat="server" CssClass="form-control"></asp:Label>
                        </div>
                    </div><!--form-group-->
                    <div class="form-group">
                        <label for="lblZip" class="control-label col-sm-3">Ptt:</label>
                        <div class="col-sm-9">
                            <asp:Label ID="lblZip" runat="server" CssClass="form-control"></asp:Label>        
                        </div>
                    </div><!--form-group-->
                    <div class="form-group">
                        <label for="lblEmail" class="control-label col-sm-3">Email:</label>
                        <div class="col-sm-9">
                            <asp:Label ID="lblEmail" runat="server" CssClass="form-control"></asp:Label>
                       </div>
                    </div><!--form-group-->
                    <div class="form-group">
                        <label for="lblPhone" class="control-label col-sm-3">Telefon:</label>
                        <div class="col-sm-9">
                            <asp:Label ID="lblPhone" runat="server" CssClass="form-control"></asp:Label>        
                        </div>
                    </div><!--form-group-->
                </div><!--form-->
            </div><!--col-->
            <div class="col-sm-4">
                <div role="form" class="form-horizontal">
                    <div class="form-group">
                        <label for="lblComment" class="control-label col-sm-3">Napomena:</label>
                        <div class="col-sm-9">
                            <asp:Label ID="lblComment" runat="server" CssClass="form-control"></asp:Label>        
                        </div>
                    </div><!--form-group-->
                    <div class="form-group">
                        <label for="lblPaymeny" class="control-label col-sm-3">Plaćanje:</label>
                        <div class="col-sm-9">
                            <asp:Label ID="lblPayment" runat="server" CssClass="form-control"></asp:Label>        
                        </div>
                    </div><!--form-group-->
                    <div class="form-group">
                        <label for="lblDelivery" class="control-label col-sm-3">Dostava:</label>
                        <div class="col-sm-9">
                            <asp:Label ID="lblDelivery" runat="server" CssClass="form-control"></asp:Label>        
                        </div>
                    </div><!--form-group-->
                    <div class="form-group">
                        <label for="lblCoupon" class="control-label col-sm-3">Kupon:</label>
                        <div class="col-sm-9">
                            <asp:Label ID="lblCoupon" runat="server" CssClass="form-control"></asp:Label>        
                        </div>
                    </div><!--form-group-->
                    <div class="form-group">
                        <label for="cmbStatus" class="control-label col-sm-3">Status:</label>
                        <div class="col-sm-9">
                            <asp:DropDownList ID="cmbStatus" runat="server" AutoPostBack="true" OnSelectedIndexChanged="cmbStatus_SelectedIndexChanged" CssClass="form-control"></asp:DropDownList>
                        </div>
                    </div><!--form-group-->
                    <asp:HiddenField ID="lblOrderID" runat="server" />
                </div><!--form-->
            </div><!--col-->
        </div><!--row-->
        <div class="row margin-top-05">
            <div class="col-lg-12">
                <asp:GridView ID="dgvItems" runat="server" AutoGenerateColumns="false" CssClass="table table-condensed table-bordered table-hover table-striped" OnRowDataBound="dgvItems_RowDataBound">
                    <Columns>
                        <%--<asp:TemplateField Visible="false">
                            <ItemTemplate>
                                <asp:Label ID="lblOrderItemID" runat="server" Text='<%#Eval("orderItemID") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>--%>
                        <%--<asp:TemplateField Visible="false">
                            <ItemTemplate>
                                <asp:Label ID="lblOrderID" runat="server" Text='<%#Eval("orderID") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>--%>
                        <asp:TemplateField Visible="false">
                            <ItemTemplate>
                                <asp:Label ID="lblProductID" runat="server" Text='<%#Eval("productID") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField Visible="false">
                            <ItemTemplate>
                                <asp:Label ID="lblBrand" runat="server" Text='<%#Eval("brandName") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField Visible="false">
                            <ItemTemplate>
                                <asp:Label ID="lblCategory" runat="server" Text='<%#Eval("categoryName") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Šifra" ControlStyle-Width="100px">
                            <ItemTemplate>
                                <asp:Label ID="lblProductCode" runat="server" Text='<%#Eval("code") %>'></asp:Label>
                        </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Naziv" ControlStyle-Width="500px">
                            <ItemTemplate>
                                <asp:HyperLink ID="lnkProduct" runat="server" Target="_blank">
                                    <asp:Label ID="lblProductName" runat="server" Text='<%#Eval("brandName") + " " + Eval("name") %>'></asp:Label>
                                </asp:HyperLink>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Web cena" ControlStyle-Width="100px" ItemStyle-HorizontalAlign="Right">
                            <ItemTemplate>
                                <asp:Label ID="lblWebPrice" runat="server" Text='<%#String.Format("{0:N2}", Eval("webPrice")) %>'></asp:Label>
                        </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Cena" ControlStyle-Width="100px" ItemStyle-HorizontalAlign="Right">
                            <ItemTemplate>
                                <asp:Label ID="lblPrice" runat="server" Text='<%#String.Format("{0:N2}", Eval("userPrice")) %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Količina" ControlStyle-Width="50px" ItemStyle-HorizontalAlign="Right">
                            <ItemTemplate>
                                <asp:Label ID="lblQuantity" runat="server" Text='<%#String.Format("{0:N2}", Eval("quantity")) %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Iznos" ControlStyle-Width="100px" ItemStyle-HorizontalAlign="Right">
                            <ItemTemplate>
                                <asp:Label ID="lblTotal" runat="server" Text='<%#String.Format("{0:N2}", Eval("total")) %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>        
            </div><!--col-->
        </div><!--row-->
        <div class="row">
            <div class="col-lg-2 pull-right">
                <label for="lblTotal">Ukupno: </label>
                <asp:Label ID="lblTotal" runat="server" CssClass="form-control text-right alert-info"></asp:Label>    
            </div><!--col-->
        </div><!--row-->
    </div><!--page-wrapper-->
    
    
    
    
    
    
    
    
    
    <%--<div id="topMenu">
        
    </div>
    <div id="mainContent">
        <h1>
            Narudžbenica</h1>
        <div class="column">
            <p class="row">
                
            </p>
            <p class="row">
                
            </p>
            <p class="row">
                
            </p>
            <p class="row">
                
            </p>
            <p class="row">
                
            </p>
            <p class="row">
                
            </p>
            <p class="row">
                
            </p>
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
            <p class="row">
                
            </p>
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
            <p class="row">
                
            </p>
            
        </div>
        
        
        <p class="row floatRight">
            
        </p>
    </div>--%>
</asp:Content>
