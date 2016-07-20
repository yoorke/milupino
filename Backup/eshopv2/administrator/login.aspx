<%@ Page Language="C#" MasterPageFile="~/administrator/adminPanel.Master" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="eshopv2.administrator.login" Title="Prijava korisnika | Admin panel" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <div id="page-wrapper">
    <div class="container-fluid">
    <div class="row">
    <div class="col-md-4 col-md-offset-4 login-panel">
    <asp:Panel ID="pnlLogin" runat="server" DefaultButton="Login1$LoginButton"></asp:Panel>
    <div class="loginBox">
    <div class="panel panel-default">
    <div class="panel-heading">
        Login
    </div>
    <div class="panel-body">
    <asp:Login ID="Login1" runat="server" CssClass="login" FailureText="Prijava nije uspešna" PasswordRequiredErrorMessage="Morate uneti šifru" RememberMeText="Zapamti me" Width="100%">
        <LayoutTemplate>
            <table border="0" cellpadding="1" cellspacing="0" width="100%">
                <tr>
                    <td>
                        <table border="0" cellpadding="0" width="100%">
                            <tr>
                                <td align="right">
                                    <!--<asp:Label ID="lblUsername" runat="server" AssociatedControlID="UserName">Korisnièko ime:</asp:Label>-->
                                </td>
                                <td>
                                    <asp:TextBox ID="UserName" runat="server" CssClass="form-control" placeholder="username"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="usernameRequired" runat="server" ControlToValidate="UserName" ErrorMessage="Morate uneti korisnièko ime"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <!--<asp:Label ID="lblPassword" runat="server" AssociatedControlID="Password">Šifra: </asp:Label>-->
                                </td>
                                <td>
                                    <asp:TextBox ID="Password" runat="server" TextMode="Password" CssClass="form-control" placeholder="password"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="passordRequired" runat="server" ControlToValidate="Password" ErrorMessage="Morate uneti šifru"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" colspan="2">
                                    <asp:Button ID="LoginButton" runat="server" CommandName="Login" Text="Log in" CssClass="btn btn-lg btn-success btn-block" />
                                </td>
                            </tr>
                            
                            <tr>
                                <td colspan="2">
                                    <div class="form-group">
                                        <asp:CheckBox ID="RememberMe" runat="server" Text="Zapamti me" CssClass="checkbox-inline" />
                                    </div>
                                </td>
                            </tr>
                            
                            <tr>
                                <td align="center" colspan="2" style="color:Red;">
                                    <asp:Literal ID="FailureText" runat="server" EnableViewState="true"></asp:Literal>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </LayoutTemplate>
    </asp:Login>
    </div>
    </div>
    </div>
    </div>
    </div>
    </div>
    </div>
</asp:Content>
