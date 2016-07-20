<%@ Page Title="" Language="C#" MasterPageFile="~/eshop2.Master" AutoEventWireup="true" CodeBehind="kontakt.aspx.cs" Inherits="eshopv2.kontakt" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <asp:Literal ID="canonicalUrl" runat="server"></asp:Literal>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="col-lg-12 page-content">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="heading">Kontakt</h1>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12">
                <p>Kontaktirajte nas i saznajte više o proizvodima, ili nam pošaljite komentar ili sugestiju. Odgovorićemo Vam u najkraćem roku.</p>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-5">
                <div class="form-horizontal" role="form">
                    <div class="form-group">
                        <label class="control-label col-lg-3">Vaš email:</label>
                        <div class="col-lg-9">
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-lg-3">Naslov:</label>
                        <div class="col-lg-9">
                            <asp:TextBox ID="txtSubject" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-lg-3">Poruka:</label>
                        <div class="col-lg-9">
                            <asp:TextBox ID="txtMessage" runat="server" TextMode="MultiLine" CssClass="form-control"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-lg-3"></label>
                        <div class="col-lg-9">
                            <asp:Button ID="btnSend" runat="server" CssClass="btn btn-default" OnClick="btnSend_Click" Text="Pošalji" />
                        </div>
                    </div>
                </div>
                
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12">
                <div class="status">
                    <asp:Literal ID="lblStatus" runat="server"></asp:Literal>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderFooter" runat="server">
</asp:Content>
