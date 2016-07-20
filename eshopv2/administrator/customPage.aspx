<%@ Page Language="C#" MasterPageFile="~/administrator/adminPanel.Master" AutoEventWireup="true" CodeBehind="customPage.aspx.cs" Inherits="eshopv2.administrator.customPage" Title="Untitled Page" ValidateRequest="false" %>
<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header"><asp:Literal ID="lblTitleHeading" runat="server" Text="Unos nove stranice"></asp:Literal></h1>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12">
                <div ID="divAlert" runat="server" visible="false">
                    <a href="#" class="close" data-dismiss="alert">&times;</a>
                    <asp:Label ID="lblAlert" runat="server"></asp:Label>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12">
                <div class="btn-group margin-bottom-10">
                    <asp:Button ID="btnSave" runat="server" Text="Sačuvaj" CssClass="btn btn-primary" OnClick="btnSave_Close" />
                    <asp:Button ID="btnSaveClose" runat="server" Text="Sačuvaj i zatvori" CssClass="btn btn-primary" OnClick="btnSaveClose_Click" />
                    <asp:Button ID="btnClose" runat="server" Text="Zatvori" CssClass="btn btn-primary" OnClick="btnClose_Click" />
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-6">
                <div class="form-horizontal">
                <div class="form-group">
                    <label for="cmbCustomPageCategory" class="control-label col-sm-2">Kategorija: </label>
                    <asp:DropDownList ID="cmbCustomPageCategory" runat="server" CssClass="form-control" Width="50%"></asp:DropDownList>
                </div>
                <div class="form-group">
                    <label for="txtTitle" class="control-label col-sm-2">Title: </label>
                    <asp:TextBox ID="txtTitle" runat="server" CssClass="form-control" Width="50%"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label for="txtDescription" class="control-label col-sm-2">Opis: </label>
                    <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" Width="50%" TextMode="MultiLine" Height="50px"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label for="txtUrl" class="control-label col-sm-2">Url: </label>
                    <asp:TextBox ID="txtUrl" runat="server" CssClass="form-control" Width="50%"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label for="txtHead" class="control-label col-sm-2">Head: </label>
                    <asp:TextBox ID="txtHead" runat="server" CssClass="form-control" Width="50%"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label for="txtHead" class="control-label col-sm-2">Naslov: </label>
                    <asp:TextBox ID="txtHeading" runat="server" CssClass="form-control" Width="50%"></asp:TextBox>
                </div>
                
                </div>
                
            
            </div>
            <div class="col-lg-6">
                <div class="form-horizontal">
                <div class="form-group">
                    <label for="txtInsertDate" runat="server" class="control-label col-sm-3">Datum unosa: </label>    
                    <asp:TextBox ID="txtInsertDate" runat="server" CssClass="form-control" Width="50%" Enabled="false"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label for="txtUpdateDate" runat="server" class="control-label col-sm-3">Datum izmene: </label>
                    <asp:TextBox ID="txtUpdateDate" runat="server" CssClass="form-control" Width="50%" Enabled="false"></asp:TextBox>
                </div>
                <div class="form-group">
                    <asp:CheckBox ID="chkIsActive" runat="server" CssClass="checkbox-inline" Text="Aktivan" />
                </div>
                
                </div>
                </div>
        </div>
        <div class="row">
            <div class="col-lg-12">
            <div class="form-group">
                <asp:TextBox ID="txtContent" TextMode="MultiLine" runat="server"></asp:TextBox>
                    <%--<label for="txtContent" class="control-label col-sm-1">Sadržaj: </label>--%>
                    <%--<CKEditor:CKEditorControl ID="txtContent" runat="server" BasePath="/ckeditor" Width="100%" Height="300px"></CKEditor:CKEditorControl>--%>
             </div>
            </div>
        </div>
        
    </div>
</asp:Content>
<asp:Content ID="Content3" runat="server" ContentPlaceHolderID="ContentPlaceHolderFooter">
    <script type="text/javascript">
        //$(function(){
        CKEDITOR.replace('<%=txtContent.ClientID %>',
        {
            filebrowserUploadUrl: '/administrator/uploadImage.ashx'
        });
        //});
    </script>
</asp:Content>
