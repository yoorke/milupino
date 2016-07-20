<%@ Page Title="Registracija korisnika | Milupino" Language="C#" MasterPageFile="~/eshop2.Master" AutoEventWireup="true" CodeBehind="registration.aspx.cs" Inherits="eshopv2.registration" %>
<%@ Register Assembly="BotDetect" Namespace="BotDetect.Web.UI" TagPrefix="BotDetect" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="col-lg-12 page-content">
        <div class="row text-center">
            <div class="col-lg-12">
                <h1 class="heading">Registracija</h1>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12">
                <div class="loginMessage text-center" runat="server" id="divLoginMessage" visible="false">
                    <span id="lblLoginText" runat="server"></span>
                </div>
            </div>
        </div>
        <div class="row" id="divRegistration" runat="server">
            <div class="login col-md-4 col-md-offset-4">
                <div role="form" class="form-horizontal">
                    <div class="form-group">
                        <label class="control-label col-sm-3">Prezime: </label>
                        <div class="col-sm-9">
                            <asp:TextBox ID="txtLastname" runat="server" Width="95%" data-required="true"></asp:TextBox><span class="glyphicon glyphicon-asterisk requiredField" title="Obavezan podatak"></span>
                            <asp:RequiredFieldValidator ID="requiredFieldValidator1" runat="server" ControlToValidate="txtLastName"></asp:RequiredFieldValidator>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-3">Ime: </label>
                        <div class="col-sm-9">
                            <asp:TextBox ID="txtFirstname" runat="server" Width="95%" data-required="true"></asp:TextBox><span class="glyphicon glyphicon-asterisk requiredField" title="Obavezan podatak"></span>
                            <asp:RequiredFieldValidator ID="requiredFieldValidator2" runat="server" ControlToValidate="txtFirstname"></asp:RequiredFieldValidator>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-3">Adresa: </label>
                        <div class="col-sm-9">
                            <asp:TextBox ID="txtAddress" runat="server" Width="95%" data-required="true"></asp:TextBox><span class="glyphicon glyphicon-asterisk requiredField" title="Obavezan podatak"></span>
                            <asp:RequiredFieldValidator ID="requiredFieldValidator3" runat="server" ControlToValidate="txtAddress"></asp:RequiredFieldValidator>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-3">PTT: </label>
                        <div class="col-sm-9">
                            <asp:TextBox ID="txtZip" runat="server" Width="50%" data-required="true" data-type="numeric"></asp:TextBox><span class="glyphicon glyphicon-asterisk requiredField" title="Obavezan podatak"></span>
                            <asp:RequiredFieldValidator ID="requiredFieldValidator4" runat="server" ControlToValidate="txtZip"></asp:RequiredFieldValidator>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-3">Mesto:</label>
                        <div class="col-sm-9">
                            <asp:TextBox ID="txtCity" runat="server" Width="95%" data-required="true"></asp:TextBox><span class="glyphicon glyphicon-asterisk requiredField" title="Obavezan podatak"></span>
                            <asp:RequiredFieldValidator ID="requiredFieldValidator5" runat="server" ControlToValidate="txtCity"></asp:RequiredFieldValidator>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-3">Telefon: </label>
                        <div class="col-sm-9">
                            <asp:TextBox ID="txtPhone" runat="server" Width="95%" data-required="true"></asp:TextBox><span class="glyphicon glyphicon-asterisk requiredField" title="Obavezan podatak"></span>
                            <asp:RequiredFieldValidator ID="requiredFieldValidator6" runat="server" ControlToValidate="txtPhone"></asp:RequiredFieldValidator>
                        </div>
                    </div>
                    <hr />
                    <div class="form-group">
                        <label class="control-label col-sm-3">Email: </label>
                        <div class="col-sm-9">
                            <asp:TextBox ID="txtEmail" runat="server" Width="95%" data-required="true"></asp:TextBox><span class="glyphicon glyphicon-asterisk requiredField" title="Obavezan podatak"></span>
                            <asp:RequiredFieldValidator ID="requiredFieldValidator7" runat="server" ControlToValidate="txtEmail"></asp:RequiredFieldValidator>
                        </div>
                        
                    </div>
                    <div id="divEmailStatus" style="display:none">
                        <span class="col-sm-3"></span>
                        <div class="col-sm-9 controlStatus">
                            <span id="EmailStatus">eweqwe</span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-3">Šifra:</label>
                        <div class="col-sm-9">
                            <asp:TextBox ID="txtPassword" runat="server" Width="95%" TextMode="Password" data-required="true"></asp:TextBox><span class="glyphicon glyphicon-asterisk requiredField" title="Obavezan podatak"></span>
                            <asp:RequiredFieldValidator ID="requiredFieldValidator8" runat="server" ControlToValidate="txtPassword"></asp:RequiredFieldValidator>
                        </div>
                    </div>
                    <div id="divPasswordStatus" style="display:none">
                        <span class="col-sm-3"></span>
                        <div class="col-sm-9 controlStatus">
                            <span id="PasswordStatus"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-3">Ponovite šifru:</label>
                        <div class="col-sm-9">
                            <asp:TextBox ID="txtConfirmPassword" runat="server" Width="95%" TextMode="Password" data-required="true"></asp:TextBox><span class="glyphicon glyphicon-asterisk requiredField" title="Obavezan podatak"></span>
                        </div>
                    </div>
                    <div id="divConfirmPasswordStatus" style="display:none">
                        <span class="col-sm-3"></span>
                        <div class="col-sm-9 controlStatus">
                            <span id="ConfirmPasswordStatus"></span>
                        </div>
                    </div>
                    <div class="text-center">
                        <!--<span class="col-sm-3"></span>-->
                        <div class="col-sm-12 margin-top-2 margin-bottom-2">
                            <BotDetect:Captcha ID="botDetect1" runat="server" />
                            <asp:TextBox ID="CaptchaCode" runat="server"></asp:TextBox>
                            <asp:Label ID="CaptchaErrorLabel" runat="server"></asp:Label>
                        </div>
                    </div>
                    <hr />
                    <div class="text-center">
                        <asp:Button ID="btnCreateUser" runat="server" OnClick="btnCreateUser_Click" CssClass="btn btn-red" Text="Kreiraj nalog" OnClientClick="return Validate()" />
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderFooter" runat="server">
    <script src="/js/registration.js"></script>
</asp:Content>
