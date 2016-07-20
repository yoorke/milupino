<%@ Page Language="C#" MasterPageFile="~/administrator/adminPanel.Master" AutoEventWireup="true" CodeBehind="promotion.aspx.cs" Inherits="eshopv2.administrator.promotion" Title="Untitled Page" %>
<%@ Register src="../user_controls/CustomStatus.ascx" tagname="CustomStatus" tagprefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">Promocija</h1>
            </div><!--col-->
        </div><!--row-->
        <div class="row">
            <div class="col-lg-12">
                <div class="btn-group">
                    <asp:Button ID="btnSave" runat="server" Text="Sačuvaj" OnClick="btnSave_Click" CssClass="btn btn-primary" />
                    <asp:Button ID="btnSaveClose" runat="server" Text="Sačuvaj i zatvori" OnClick="btnSaveClose_Click" CssClass="btn btn-default" />
                    <asp:Button ID="btnClose" runat="server" Text="Zatvori" OnClick="btnClose_Click" CssClass="btn btn-default" />
                </div><!--brn-group-->
            </div><!--col-->
        </div><!--row-->
        <div class="row">
            <div class="col-lg-12">
                <uc1:CustomStatus ID="csStatus" runat="server" />
                <asp:HiddenField ID="lblPromotionID" runat="server" />
            </div><!--col-->
        </div><!--row-->
        <div class="row">
            <div class="col-lg-5 col-md-6 col-sm-10 col-xs-12">
                <div role="form">
                    <div class="form-group">
                        <label for="txtName">Naziv: </label>
                        <asp:TextBox ID="txtName" runat="server" CssClass="form-control"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="requireFieldValidator1" runat="server" ControlToValidate="txtName" ErrorMessage="Unesite naziv"></asp:RequiredFieldValidator>                        
                    </div><!--form-group-->
                    <div class="form-group">
                        <label for="txtValue">Popust: </label>
                        <asp:TextBox ID="txtValue" runat="server" CssClass="form-control"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="requireFieldValidator2" runat="server" ControlToValidate="txtValue" ErrorMessage="Unesite naziv"></asp:RequiredFieldValidator>
                        <asp:RangeValidator ID="rangeValidator1" runat="server" ControlToValidate="txtValue" MinimumValue="1" MaximumValue="100" Type="Integer" ErrorMessage="Popust mora da ima celobrojnu vrednost"></asp:RangeValidator>            
                    </div><!--form-group-->
                    <div class="form-group">
                        <asp:CheckBox ID="chkShowOnFirstPage" runat="server" Text="Prikaži na prvoj strani" CssClass="checkbox" />            
                    </div><!--form-group-->
                    <div class="form-group">
                        <label for="txtDateFrom">Od: </label>
                        <asp:TextBox ID="txtDateFrom" runat="server" CssClass="form-control"></asp:TextBox>            
                    </div><!--form-group-->
                    <div class="form-group">
                        <label for="txtDateTo">Do: </label>
                        <asp:TextBox ID="txtDateTo" runat="server" CssClass="form-control"></asp:TextBox>            
                    </div><!--form-group-->
                    <div class="form-group">
                        <label for="txtImageUrl">Slika url: </label>
                        <asp:TextBox ID="txtImageUrl" runat="server" CssClass="form-control"></asp:TextBox>            
                    </div><!--form-group"-->
                    <div class="form-group">
                        <asp:Image ID="imgPromotion" runat="server" CssClass="promotion" Width="50px" Height="50px" /><br />
                        <asp:FileUpload ID="fluImage" runat="server" />
                        <asp:Button ID="btnImageUpload" runat="server" Text="Dodaj sliku" OnClick="btnImageUpload_Click" CssClass="btn btn-primary" />
                    </div><!--form-group-->
                </div><!--form-->
            </div><!--col-->
        </div><!--row-->
    </div><!--page-wrapper-->
    
    
    
    
    
    
    
    
    
    
    
    
    <%--<ajaxtoolkit:ToolkitScriptManager ID="toolkitScriptManager1" runat="server" EnablePartialRendering="true"></ajaxtoolkit:ToolkitScriptManager>
    <div id="topMenu">
        
    </div>
    
    <div id="mainContent">
        
        
        <p class="row">
            
        </p>
        
        <p class="row">
            
        </p>
        
        <p class="row">
            
        </p>
        
        <p class="row">
                        <ajaxtoolkit:CalendarExtender ID="dtpDateFrom" runat="server" TargetControlID="txtDateFrom" Format="dd.MM.yyyy"></ajaxtoolkit:CalendarExtender>
        </p>
        
        <p class="row">
            
            <ajaxtoolkit:CalendarExtender ID="dtpDateTo" runat="server" TargetControlID="txtDateTo" Format="dd.MM.yyyy"></ajaxtoolkit:CalendarExtender>
        </p>
        
        <p class="row">
            
        </p>
        <p class="row">
            
        
        </p>
    </div>--%>
    
</asp:Content>
