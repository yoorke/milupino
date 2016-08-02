<%@ Page Title="" Language="C#" MasterPageFile="~/eshop2.Master" AutoEventWireup="true" CodeBehind="passwordResetRequest.aspx.cs" Inherits="eshopv2.passwordResetRequest" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="col-lg-12 page-content">
        <div class="row text-center">
            <div class="col-lg-12">
                <h1>Resetovanje korisničke šifre</h1>
                <p>Unesite email adresu koju ste korisnili pri kreiranju naloga.</p>
            </div>
        </div>
        <div class="row margin-top-2 margin-bottom-2">
            <div class="col-sm-4 col-sm-offset-4">
                <div role="form">
                    <div class="form-group text-center">
                        <asp:TextBox ID="txtEmail" runat="server" placeholder="Email adresa" CssClass="" Width="100%"></asp:TextBox>
                    </div>
                    <div class="text-center">
                        <asp:Button ID="btnSendRequest" runat="server" Text="Pošalji zahtev" CssClass="" OnClick="btnSendRequest_Click" />
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12">
                <div class="status" runat="server" id="divMessageBox" visible="false">
                    <asp:Literal ID="lblMessage" runat="server"></asp:Literal>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderFooter" runat="server">
    
</asp:Content>
