<%@ Page Title="" Language="C#" MasterPageFile="~/eshop2.Master" AutoEventWireup="true" CodeBehind="passwordChange.aspx.cs" Inherits="eshopv2.passwordChange" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="col-lg-12 page-content">
        <div class="row text-center">
            <div class="col-lg-12">
                <h1 class="heading">Izmena šifre</h1>
            </div>
        </div>
        <div class="row">
            <div class="col-md-4 col-md-offset-4 login">
                <div class="form-horizontal" role="form">
                    <div class="form-group">
                        <label for="txtPassword" class="control-label col-md-4">Stara šifra: </label>
                        <div class="col-md-8">
                            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" Width="100%"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="txtNewPassword" class="control-label col-md-4">Nova šifra: </label>
                        <div class="col-md-8">
                            <asp:TextBox ID="txtNewPassword" runat="server" TextMode="Password" Width="100%"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="txtNewPasswordConfirm" class="control-label col-md-4">Nova šifra ponovo: </label>
                        <div class="col-md-8">
                            <asp:TextBox ID="txtNewPasswordConfirm" runat="server" TextMode="Password" Width="100%"></asp:TextBox>
                        </div>
                    </div>
                    <div class="text-center">
                        <div class="col-md-4"></div>
                        <asp:Button ID="btnChangePassword" runat="server" Text="Izmeni šifru" OnClick="btnChangePassword_Click" CssClass="btn btn-red" />
                    </div>
                </div>
                
            </div>
            
        </div>
        <div class="row">
            <div class="status" id="divStatus" runat="server" visible="false">
                <asp:Label ID="lblStatus" runat="server"></asp:Label>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderFooter" runat="server">
</asp:Content>
