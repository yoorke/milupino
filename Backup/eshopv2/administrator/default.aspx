<%@ Page Language="C#" MasterPageFile="~/administrator/adminPanel.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="eshopv2.administrator._default" Title="Admin panel | PinShop" %>
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
                        <div class="panel-body"></div>
                    </div>
                </div>
                
                <div class="col-lg-4">
                    <div class="panel panel-primary">
                        <div class="panel-heading">
                            <p>Poslednjih 10 registrovanih korisnika</p>
                        </div>
                        <div class="panel-body"></div>
                    </div>
                </div>
                
                <div class="col-lg-4">
                    <div class="panel panel-primary">
                        <div class="panel-heading">
                            <p>Poslednjhi 10 dodatih proizvoda</p>
                        </div>
                        <div class="panel-body"></div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-4">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <p>Najposećeniji proizvodi</p>
                        </div>
                        <div class="panel-body"></div>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <p>Najprodavaniji proizvodi</p>
                        </div>
                        <div class="panel-body"></div>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <p>Poslednjih 10 ažuriranja</p>
                        </div>
                        <div class="panel-body"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
