<%@ Page Language="C#" MasterPageFile="~/eshop2.Master" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="eshopv2.login" Title="Prijava | Milupino" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <asp:Literal ID="canonicalUrl" runat="server"></asp:Literal>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="col-lg-12 page-content">
        <div class="row text-center">
            <div class="col-lg-12">
                <h1 class="heading">Prijava</h1>
            </div>
        </div>
        <div class="row">
            <div class="login col-md-4 col-md-offset-4">
                <asp:Login ID="login1" runat="server" Width="100%" DestinationPageUrl="/" FailureText="Prijava nije uspešna" LoginButtonText="Prijavi se" OnLoginError="login1_LoginError">
                    <LayoutTemplate>
                        <table border="0" cellpadding="1" cellspacing="0" 
                            style="border-collapse:collapse;" width="100%">
                            <tr>
                                <td>
                                    <table border="0" cellpadding="0" width="100%">
                                        <tr style="margin-bottom:20px">
                                            <td align="center" colspan="2">
                                                </td>
                                        </tr>
                                        <tr>
                                            <!--<td align="right">
                                                <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName">User 
                                                Name:</asp:Label>
                                            </td>-->
                                            <td colspan="2">
                                                <asp:TextBox ID="UserName" runat="server" Width="100%" placeholder="Korisničko ime"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" 
                                                    ControlToValidate="UserName" ErrorMessage="Unesite korisničko ime." 
                                                    ToolTip="Unesite korisničko ime." ValidationGroup="login"></asp:RequiredFieldValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <!--<td align="right">
                                                <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="Password">Password:</asp:Label>
                                            </td-->
                                            <td colspan="2">
                                                <asp:TextBox ID="Password" runat="server" TextMode="Password" Width="100%" placeholder="Šifra"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" 
                                                    ControlToValidate="Password" ErrorMessage="Unesite šifru." 
                                                    ToolTip="Unesite šifru." ValidationGroup="login">*</asp:RequiredFieldValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="1">
                                                <asp:CheckBox ID="RememberMe" runat="server" Text="Zapamti me." />
                                            </td>
                                            <td class="text-right">
                                                <asp:HyperLink ID="lnkRestPassword" runat="server" NavigateUrl="/resetovanje-sifre">Zaboravili ste šifru?</asp:HyperLink>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="center" colspan="2" style="color:Red;">
                                                <asp:Literal ID="FailureText" runat="server" EnableViewState="False"></asp:Literal>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right" colspan="2">
                                                <asp:Button ID="LoginButton" runat="server" CommandName="Login" Text="Log In" 
                                                    ValidationGroup="login" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </LayoutTemplate>
                </asp:Login>
            </div><!--col-->
        </div><!--row-->
        <div class="row">
            <div class="col-lg-12">
                <div class="loginMessage" runat="server" id="divLoginMessage" visible="false">
                    <p>Poštovani, u cilju povećanja bezbednosti uveli smo nove mere za skladištenje podataka. Samim tim, nije moguća prijava sa Vašom starom šifrom.</p>
                    <p>Ukoliko želite, možete podneti zahtev za resetovanje šifre klikom na sledeći link: <asp:LinkButton id="lnkPasswordReset" runat="server" OnClick="lnkPasswordReset_Click">Reset</asp:LinkButton>. Na Vašu e-mail adresu koju se uneli prilikom kreiranje naloga
                        biće poslat mail sa linkom za kreiranje nove šifre.
                    </p>
                </div>
            </div><!--col-->
        </div><!--row-->
    </div><!--col-->
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderFooter" runat="server">
</asp:Content>
