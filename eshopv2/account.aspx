<%@ Page Title="" Language="C#" MasterPageFile="~/eshop2.Master" AutoEventWireup="true" CodeBehind="account.aspx.cs" Inherits="eshopv2.account" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="col-lg-12 page-content">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="heading">Moj nalog</h1>
            </div>
        </div>
        <!--<div class="row">
            <div class="col-lg-12">
                <a href="/izmena-sifre">Izmena šifre</a>
                <a href="/narudzbenice">Narudžbenice</a>
            </div>
        </div>-->
        <div class="status" id="divStatus" runat="server" visible="false">
            <asp:Label ID="lblStatus" runat="server"></asp:Label>
        </div>
        <div class="row margin-top-2">
            <div class="col-lg-5">
                <div class="form-horizontal" role="form">
                    <div class="form-group">
                        <label for="txtLastname" class="control-label col-lg-2">Prezime: </label>
                        <div class="col-lg-10">
                            <asp:TextBox ID="txtLastname" runat="server" CssClass="col-lg-12"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="txtFirstname" class="control-label col-lg-2">Ime: </label>
                        <div class="col-lg-10">
                            <asp:TextBox ID="txtFirstname" runat="server" CssClass="col-lg-12"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="txtEmail" class="control-label col-lg-2">Email: </label>
                        <div class="col-lg-10">
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="col-lg-12"></asp:TextBox>
                        </div>
                    </div>
                    
                    
                    <div class="form-group">
                        <label for="txtPhone" class="control-label col-lg-2">Telefon: </label>
                        <div class="col-lg-10">
                            <asp:TextBox ID="txtPhone" runat="server" CssClass="col-lg-12"></asp:TextBox>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-5">
                <div class="form-horizontal" role="form">
                    <div class="form-group">
                        <label for="txtAddress" class="control-label col-lg-2">Adresa: </label>
                        <div class="col-lg-10">
                            <asp:TextBox ID="txtAddress" runat="server" CssClass="col-lg-12"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="txtCity" class="control-label col-lg-2">Mesto: </label>
                        <div class="col-lg-10">
                            <asp:TextBox ID="txtCity" runat="server" CssClass="col-lg-12"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="txtZip" class="control-label col-lg-2">Ptt:</label>
                        <div class="col-lg-10">
                            <asp:TextBox ID="txtZip" runat="server" CssClass="col-lg-5"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:HyperLink ID="lnkPasswordChange" runat="server" NavigateUrl="~/passwordChange"></asp:HyperLink>
                    </div>
                </div>
            </div>
        </div>
        <div class="row margin-top-05">
            <div class="col-lg-1"></div>
            <div class="col-lg-1">
                <asp:Button ID="btnSave" runat="server" CssClass="btn btn-red" Text="Sačuvaj" OnClick="btnSave_Click" />
            </div>
            <div class="col-lg-1">
                <asp:Button ID="btnChangePassword" runat="server" CssClass="btn btn-default" Text="Izmena šifre" OnClick="btnChangePassword_Click" />
            </div>
        </div>
        <div class="row margin-top-2">
            <div class="col-lg-12">
                <asp:Repeater ID="rptOrders" runat="server" OnItemDataBound="rptOrders_ItemDataBound">
                    <HeaderTemplate>
                        <table class="table table-condensed table-striped" style="width:50%">
                            <tr>
                                <th style="width:20em">Datum</th>
                                <th>Iznos</th>
                                <th style="width:10em">Status</th>
                                <th style="width:2em"></th>
                            </tr>
                        </table>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <table class="table" style="width:50%">
                           <tr>
                               <td style="width:20em"><%#Eval("date") %></td>
                               <td style="width:10em" class="text-right"><%#string.Format("{0:N2}", double.Parse(Eval("total").ToString())) %></td>
                               <td style="width:10em"><%#Eval("status") %></td>
                               <td style="width:2em"><span class="glyphicon glyphicon-plus cursor-pointer" onclick="ShowItems(this)" runat="server" id="span"></span></td>
                            </tr>
                        </table>
                        <div id="divOrderItems" class="orderItems" runat="server" style="display:none">
                            <asp:HiddenField ID="divOrderItemsVisible" runat="server" />
                            <asp:Repeater ID="rptItems" runat="server">
                                <HeaderTemplate>
                                    <table class="table orderItems" style="width:40%">
                                        <tr>
                                            <th>Naziv</th>
                                            <th style="width:5em">Količina</th>
                                            <th style="width:5em">Cena</th>
                                            <th style="width:5em">Ukupno</th>
                                        </tr>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    
                                        
                                        <tr>
                                            <td><%#Eval("name") %></td>
                                            <td><%#string.Format("{0:N2}", Eval("quantity")) %></td>
                                            <td><%#string.Format("{0:N2}", Eval("userPrice")) %></td>
                                            <td><%#string.Format("{0:N2}", Eval("total")) %></td>
                                        </tr>
                                    
                                </ItemTemplate>
                                <FooterTemplate>
                                    </table>
                                </FooterTemplate>
                            </asp:Repeater>
                        </div>
                    </ItemTemplate>
                    <FooterTemplate>
                        
                    </FooterTemplate>
                </asp:Repeater>
            </div>

        </div>
    </div>
    <script>
        function ShowItems(div) {
            if ($('#' + div.id.toString().substring(0, div.id.toString().lastIndexOf('_') + 1) + 'divOrderItemsVisible').val() == 'false' || $('#' + div.id.toString().substring(0, div.id.toString().lastIndexOf('_') + 1) + 'divOrderItemsVisible').val() == '') {
                $('#' + div.id.toString().substring(0, div.id.toString().lastIndexOf('_') + 1) + 'divOrderItems').show();
                $(div).removeClass('glyphicon-plus');
                $(div).addClass('glyphicon-minus');
                $('#' + div.id.toString().substring(0, div.id.toString().lastIndexOf('_') + 1) + 'divOrderItemsVisible').val(true);
            }
            else {
                $('#' + div.id.toString().substring(0, div.id.toString().lastIndexOf('_') + 1) + 'divOrderItems').hide();
                $(div).removeClass('glyphicon-minus');
                $(div).addClass('glyphicon-plus');
                $('#' + div.id.toString().substring(0, div.id.toString().lastIndexOf('_') + 1) + 'divOrderItemsVisible').val(false);
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderFooter" runat="server">
</asp:Content>
