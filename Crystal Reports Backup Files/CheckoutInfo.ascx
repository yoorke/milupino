<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CheckoutInfo.ascx.cs" Inherits="eshopv2.user_controls.CheckoutInfo" %>
<%--<div class="row">
    <div class="col-lg-12">
        <div class="heading">Podaci o narudžbini</div>
    </div><!--col-->
</div><!--row-->--%>
<div class="checkout-info">
<div class="row margin-top-2">
    <div class="col-lg-10 col-lg-offset-1">
    <div class="panel panel-default">
        <div class="panel-heading">
            <span>Podaci o narudžbini</span>
        </div><!--panel-heading-->
        <div class="panel-body">
            <div class="row">
                <div class="col-lg-3">
                    <div role="form" class="form-horizontal">
                        <div class="form-group">
                            <label for="lblNumberOfProducts" class="control-label col-sm-7">Broj artikala: </label>
                            <div class="col-sm-5">
                                <asp:Label ID="lblNumberOfProducts" runat="server" Text="0" CssClass="form-control"></asp:Label>
                            </div>
                        </div><!--form-group-->
                        <div class="form-group">
                            <label for="lblTaxBase" class="control-label col-sm-7"><small>Osnovica: </small></label>
                            <div class="col-sm-5">
                                <asp:Label ID="lblTaxBase" runat="server" Text="0,00" CssClass="form-control small"></asp:Label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="lblPdv" class="control-label col-sm-7"><small>PDV: </small></label>
                            <div class="col-sm-5">
                                <asp:Label ID="lblPdv" runat="server" Text="0,00" CssClass="form-control small"></asp:Label>
                            </div>
                        </div>
                        <hr />
                        <div class="form-group">
                            <label for="lblTotalWithTax" class="control-label col-sm-7">Iznos: </label>
                            <div class="col-sm-5">
                                <asp:Label ID="lblTotalWithTax" runat="server" Text="0,00" CssClass="form-control"></asp:Label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="lblDiscount" class="control-label col-sm-7">Popust: </label>
                            <div class="col-sm-5">
                                <asp:Label ID="lblDiscount" runat="server" Text="0,00" CssClass="form-control"></asp:Label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="lblDelivery" class="control-label col-sm-7">Dostava: </label>
                            <div class="col-sm-5">
                                <asp:Label ID="lblDelivery" runat="server" Text="0,00" CssClass="form-control"></asp:Label>
                            </div>
                        </div>
                        <hr />
                        <div class="form-group">
                            <label for="lblTotal" class="control-label col-sm-7 total">Ukupno: </label>
                            <div class="col-sm-5">
                                <asp:Label ID="lblTotal" runat="server" Text="0,00" CssClass="form-control total"></asp:Label>
                            </div>
                        </div>
                        
                    </div><!--form-->
                </div><!--col-->
                <div class="col-lg-8 col-lg-offset-1">
                    <p>
                        Cena dostave iznosi <span class="green">200,00</span> dinara za sve narudžbine čiji iznos ne prelazi <span class="green">5.000,00</span> dinara.
                        Za iznose preko <span class="green"><b>5.000,00</b></span> dinara dostava je <span class="green"><b>BESPLATNA</b></span>.
                    </p>
                    <p>
                        Sve narudžbine pristigle do 12:00 časova šalju se istog dana.
                    </p>
                </div><!--col-->
            </div><!--row-->
            <div class="row">
                <div class="col-lg-12">
                    <!--<div class="form-group">-->
                    <div class="btn-group pull-right">
                        <asp:LinkButton ID="btnShowCart" runat="server" Text="Vrati se na korpu" CssClass="btn btn-default" OnClick="btnShowCart_Click"></asp:LinkButton>
                        <asp:LinkButton ID="btnAccount" runat="server" Text="Unesi podatke" CssClass="btn btn-default" OnClientClick="scrollToAccount();return false;"></asp:LinkButton>
                    </div>
                    <!--</div>-->
                </div><!--col-->
            </div><!--row-->
        </div><!--panel-body-->
    </div><!--panel-->
    </div><!--col-->
</div><!--row-->
</div>