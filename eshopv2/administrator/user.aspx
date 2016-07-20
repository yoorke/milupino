<%@ Page Language="C#" MasterPageFile="~/administrator/adminPanel.Master" AutoEventWireup="true" CodeBehind="user.aspx.cs" Inherits="eshopv2.administrator.user" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">Korisnik</h1>
            </div><!--col-->
        </div><!--row-->
        <div class="row">
            <div class="col-lg-12">
                <div class="btn-group">
                    <asp:Button ID="btnSave" runat="server" Text="Sačuvaj" OnClick="btnSave_Click" CssClass="btn btn-primary" />
                    <asp:Button ID="btnSaveClose" runat="server" Text="Sačuvaj i zatvori" OnClick="btnSaveClose_Click" CssClass="btn btn-default" />
                    <asp:Button ID="btnClose" runat="server" Text="Zatvori" OnClick="btnClose_Click" CssClass="btn btn-default" />
                </div><!--btn-group-->
            </div><!--col-->
        </div><!--row-->
        <div class="row">
            <div class="col-lg-5 col-md-5 col-sm-10 col-xs-12">
                <div role="form">
                    <div class="form-group">
                        <label for="txtLastName">Prezime: </label>
                        <asp:TextBox ID="txtLastName" runat="server" CssClass="form-control"></asp:TextBox>
                    </div><!--form-group-->
                    <div class="form-group">
                        <label for="txtFirstName">Ime: </label>
                        <asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control"></asp:TextBox>
                    </div><!--form-group-->
                    <div class="form-group">
                        <label for="txtUsername">Username: </label>
                        <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control"></asp:TextBox>
                    </div><!--form-group-->
                    <div class="form-group">
                        <label for="txtPassword">Šifra: </label>
                        <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control"></asp:TextBox>
                    </div><!--form-group-->
                    <div class="form-group">
                        <label for="txtEmail">Email: </label>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control"></asp:TextBox>
                    </div><!--form-group-->
                    <div class="form-group">
                        <label for="cmbUserType">Tip: </label>
                        <asp:DropDownList ID="cmbUserType" runat="server" CssClass="form-control"></asp:DropDownList>
                    </div><!--form-group-->
                </div><!--form-->
            </div><!--col-->
        </div><!--row-->
    </div><!--page-wrapper-->
    <%--<div id="topMenu">
        
    </div>
    
    <div id="mainContent">
    
        
    
    
    
    
    
    
    
    
    
    
    
    
    
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
    </div>--%>
</asp:Content>
