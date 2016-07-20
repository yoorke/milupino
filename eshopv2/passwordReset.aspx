<%@ Page Title="" Language="C#" MasterPageFile="~/eshop2.Master" AutoEventWireup="true" CodeBehind="passwordReset.aspx.cs" Inherits="eshopv2.passwordReset" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="col-lg-12 page-content">
        <div class="row text-center">
            <div class="col-lg-12">
                <h1 class="heading">Kreiranje šifre</h1>
            </div>
        </div>
        <div class="row" id="divPasswordReset" runat="server">
            <div class="col-md-4 col-md-offset-4 text-center margin-top-2 margin-bottom-2">
                <div class="row">
                    <p>Dobrodošli, <asp:Literal ID="txtUsername" runat="server"></asp:Literal></p>
                    <asp:HiddenField ID="lblUserID" runat="server" />
                    <div role="form">
                        <div class="form-group">
                            <label for="txtPassword" class="col-xs-5 text-left">Nova šifra:</label>
                            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password"></asp:TextBox>
                            <span id="passwordStatus"></span>
                        </div>
                        <div class="form-group">
                            <label for="txtPasswordConfirm" class="col-xs-5 text-left">Potvrdite šifru:</label>
                            <asp:TextBox ID="txtPasswordConfirm" runat="server" TextMode="Password"></asp:TextBox>
                        </div>
                        <asp:Button ID="btnChangePassword" runat="server" Text="Kreiraj šifru" OnClick="btnChangePassword_Click" />
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
    <%--<script>
        $(document).ready(function () {
            //$('#txtPassword').focusout(function () {
            //    checkPassword($('#txtPassword').val(), 'passwordStatus');
            //    alert('werwerwer');
            //})
        });

        //function checkPassword(password, status) {
        //    if (password.length < 8)
        //        status = 'Šifra mora biti minimalne dužine 8.';
        //}
    </script>--%>
</asp:Content>
