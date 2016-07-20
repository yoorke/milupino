<%@ Page Language="C#" MasterPageFile="~/administrator/adminPanel.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="eshopv2.administrator._default" Title="Admin panel | Milupino" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="page-wrapper">
        <div class="container-fluid">
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">Admin panel</h1>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-4">
                    <div class="panel panel-primary">
                        <div class="panel-heading">
                            <p>Poslednjih 10 porudžbina</p>
                        </div>
                        <div class="panel-body">
                            <asp:GridView ID="dgvOrders" runat="server" CssClass="table table-condensed table-striped table-bordered font-08" AutoGenerateColumns="false" OnRowDataBound="dgvOrders_RowDataBound">
                                <Columns>
                                    <asp:TemplateField Visible="false">
                                        <ItemTemplate>
                                            <asp:Label ID="lblOrderID" runat="server" Text='<%#Eval("orderID") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Datum" ItemStyle-Width="110px">
                                        <ItemTemplate>
                                            <asp:Label ID="lblDate" runat="server" Text='<%#Eval("date") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Kupac">
                                        <ItemTemplate>
                                            <asp:HyperLink ID="lnkOrder" runat="server" NavigateUrl='<%#"/administrator/order.aspx?orderID=" + Eval("orderID") %>' Target="_blank">
                                                <asp:Label ID="lblUser" runat="server" Text='<%#Eval("firstName") +" " + Eval("lastName") %>'></asp:Label>
                                            </asp:HyperLink>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Iznos" ItemStyle-HorizontalAlign="Right">
                                        <ItemTemplate>
                                            <asp:Label ID="lblSum" runat="server" Text='<%#string.Format("{0:N2}", Eval("sum")) %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField ItemStyle-Width="50px">
                                        <ItemTemplate>
                                            <asp:Label ID="lblIsNew" runat="server" Text='<%#Eval("isNew") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                            <asp:HyperLink ID="lnkOrders" runat="server" NavigateUrl="/administrator/orders.aspx" CssClass="pull-right">Sve</asp:HyperLink>
                        </div>
                    </div>
                </div>
                
                <div class="col-lg-4">
                    <div class="panel panel-primary">
                        <div class="panel-heading">
                            <p>Poslednjih 10 registrovanih korisnika</p>
                        </div>
                        <div class="panel-body">
                            <asp:GridView ID="dgvUsers" runat="server" AutoGenerateColumns="false" CssClass="table table-condensed table-striped table-bordered font-08">
                                <Columns>
                                    <asp:TemplateField Visible="false">
                                        <ItemTemplate>
                                            <asp:Label ID="lblUserID" runat="server" Text='<%#Eval("userID") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Datum" ItemStyle-Width="100px">
                                        <ItemTemplate>
                                            <asp:Label ID="lblDate" runat="server" Text='<%#Eval("insertDate") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Prezime i ime" ItemStyle-Width="100px">
                                        <ItemTemplate>
                                            <asp:Label ID="lblLastName" runat="server" Text='<%#Eval("lastName") + " " + Eval("firstName") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Korisničko ime" ItemStyle-Width="100px">
                                        <ItemTemplate>
                                            <asp:Label ID="lblUsername" runat="server" Text='<%#Eval("username") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                            <asp:HyperLink ID="lnkUsers" runat="server" NavigateUrl="/administrator/users.aspx" CssClass="pull-right">Sve</asp:HyperLink>
                        </div>
                    </div>
                </div>
                
                <div class="col-lg-4">
                    <div class="panel panel-primary">
                        <div class="panel-heading">
                            <p>Poslednjhi 10 dodatih proizvoda</p>
                        </div>
                        <div class="panel-body">
                            <asp:GridView ID="dgvProducts" runat="server" AutoGenerateColumns="false" CssClass="table table-condensed table-striped table-bordered font-08">
                                <Columns>
                                    <asp:TemplateField Visible="false">
                                        <ItemTemplate>
                                            <asp:Label ID="lblProductID" runat="server" Text='<%#Eval("productID") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Datum" ItemStyle-Width="110px">
                                        <ItemTemplate>
                                            <asp:Label ID="lblDate" runat="server" Text='<%#Eval("insertDate") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Naziv">
                                        <ItemTemplate>
                                            <asp:HyperLink ID="lnkProduct" runat="server" NavigateUrl='<%#"/administrator/product.aspx?id=" + Eval("productID") %>' Target="_blank">
                                                <asp:Label ID="lblName" runat="server" Text='<%#Eval("name").ToString().Substring(0, Math.Min(30, Eval("name").ToString().Length)) %>'></asp:Label>
                                            </asp:HyperLink>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Kategorija">
                                        <ItemTemplate>
                                            <asp:HyperLink ID="lnkCategory" runat="server" NavigateUrl='<%#"/administrator/category.aspx?id=" + Eval("categoryID") %>' Target="_blank">
                                                <asp:Label ID="lblCategory" runat="server" Text='<%#Eval("categoryName") %>'></asp:Label>
                                            </asp:HyperLink>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                            <asp:HyperLink ID="lnkProducts" runat="server" NavigateUrl="/administrator/products.aspx" CssClass="pull-right">Sve</asp:HyperLink>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-4">
                    
                </div>
            </div>
            <div class="row">
                <div class="col-lg-4">
                    <div class="panel panel-primary">
                        <div class="panel-heading">
                            <p>Aktivne promocije</p>
                        </div>
                        <div class="panel-body">
                            <asp:GridView ID="dgvPromotions" runat="server" AutoGenerateColumns="false" CssClass="table table-condensed table-striped table-bordered font-08">
                                <Columns>
                                    <asp:TemplateField Visible="false">
                                        <ItemTemplate>
                                            <asp:Label ID="lblPromotionID" runat="server" Text='<%#Eval("promotionID") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Naziv">
                                        <ItemTemplate>
                                            <asp:HyperLink ID="lnkPromotion" runat="server" NavigateUrl='<%#"/administrator/promotion.aspx?promotionID=" + Eval("promotionID") %>' Target="_blank">
                                                <asp:Label ID="lblName" runat="server" Text='<%#Eval("name") %>'></asp:Label>
                                            </asp:HyperLink>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Do" ItemStyle-Width="100px">
                                        <ItemTemplate>
                                            <asp:Label ID="lblDate" runat="server" Text='<%#DateTime.Parse(Eval("dateTo").ToString()).ToShortDateString() %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="panel panel-primary">
                        <div class="panel-heading">
                            <p>Najposećeniji proizvodi</p>
                        </div>
                        <div class="panel-body">
                            <asp:GridView ID="dgvTopAccessProducts" runat="server" AutoGenerateColumns="false" CssClass="table table-condensed table-striped table-bordered font-08">
                                <Columns>
                                    <asp:TemplateField Visible="false">
                                        <ItemTemplate>
                                            <asp:Label ID="lblProductID" runat="server" Text='<%#Eval("productID") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Naziv">
                                        <ItemTemplate>
                                            <asp:HyperLink ID="lnkProduct" runat="server" NavigateUrl='<%#"/administrator/product.aspx?id=" + Eval("productID") %>' Target="_blank">
                                                <asp:Label ID="lblName" runat="server" Text='<%#Eval("name") %>'></asp:Label>
                                            </asp:HyperLink>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Broj prikaza" ItemStyle-Width="50px">
                                        <ItemTemplate>
                                            <asp:Label ID="lblNumber" runat="server" Text='<%#Eval("number") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="panel panel-primary">
                        <div class="panel-heading">
                            <p>Najprodavaniji proizvodi</p>
                        </div>
                        <div class="panel-body">
                            <asp:GridView ID="dgvTopOrderProducts" runat="server" AutoGenerateColumns="false" CssClass="table table-condensed table-striped table-bordered font-08">
                                <Columns>
                                    <asp:TemplateField Visible="false">
                                        <ItemTemplate>
                                            <asp:Label ID="lblProductID" runat="server" Text='<%#Eval("productID") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Naziv">
                                        <ItemTemplate>
                                            <asp:HyperLink ID="lblProduct" runat="server" NavigateUrl='<%#"/administrator/product.aspx?id=" + Eval("productID") %>' Target="_blank">
                                                <asp:Label ID="lblName" runat="server" Text='<%#Eval("name") %>'></asp:Label>
                                            </asp:HyperLink>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Broj naručivanja" ItemStyle-Width="50px">
                                        <ItemTemplate>
                                            <asp:Label ID="lblNumber" runat="server" Text='<%#Eval("number") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>
                </div>
                <!--<div class="col-lg-4">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <p>Poslednjih 10 ažuriranja</p>
                        </div>
                        <div class="panel-body"></div>
                    </div>
                </div>-->
            </div>
        </div>
    </div>
</asp:Content>
