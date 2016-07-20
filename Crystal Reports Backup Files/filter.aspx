<%@ Page Language="C#" MasterPageFile="~/eshop2.Master" AutoEventWireup="true" CodeBehind="filter.aspx.cs" Inherits="eshopv2.filter" Title="Untitled Page" %>
<%@ Register Src="user_controls/Pager.ascx" TagName="Pager" TagPrefix="pager" %>
<%@ Register Src="user_controls/product_fp.ascx" TagName="product_fp" TagPrefix="product_fp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!--FILTER-->
    <div class="col-xs-5 col-sm-2 col-md-2 col-lg-2 left-column filter">
        <h2>Proizvođač</h2>
        <div class="filterBox">
            <asp:CheckBoxList ID="chkAttributes" runat="server" AutoPostBack="true" OnSelectedIndexChanged="chkAttributes_SelectedIndexChanged">
            </asp:CheckBoxList>
        </div><!--filterBox-->
        
        <h2>Cena</h2>
        <div class="filterBox">
            <label class="before">Od:</label><asp:DropDownList ID="cmbPriceFrom" runat="server" AutoPostBack="true" OnSelectedIndexChanged="cmbPriceFrom_SelectedIndexChanged"></asp:DropDownList><label><small>din</small></label><br />
            <label class="before">Do:</span></label><asp:DropDownList ID="cmbPriceTo" runat="server" AutoPostBack="true" OnSelectedIndexChanged="cmbPriceTo_SelectedIndexChanged"></asp:DropDownList><label><small>din</small></label>
        </div><!--filterBox-->
        
        <asp:Repeater ID="rptFilter" runat="server">
            <ItemTemplate>
                <h2><asp:Literal ID="lblFilterName" runat="server" Text='<%#Eval("nameScreen") %>'></asp:Literal></h2>
                <asp:HiddenField ID="hdnAttributeID" runat="server" Value='<%#Eval("attributeID") %>' />
                <div class="filterBox">
                    <asp:CheckBoxList ID="chkValues" runat="server" DataSource='<%#Eval("values") %>' DataTextField="value" DataValueField="attributeValueID" OnSelectedIndexChanged="chkValues_SelectedIndexChanged" AutoPostBack="true"></asp:CheckBoxList>
                </div><!--filterBox-->
            </ItemTemplate>
        </asp:Repeater>
    </div><!--filter-->
    
    <!--MAIN CONTENT-->
    <div class="col-xs-7 col-sm-10 col-md-10 col-lg-10 main-content first-page">
        <div class="row">
            <div class="col-lg-5">
                <pager:Pager ID="pgrPager" runat="server" OnOnClick="pgrPages_Click" />
            </div><!--col-->
            <div class="col-lg-7">
                <div class="row sort pull-right">
                    <div class="col-lg-6 col-xs-12">
                        <asp:DropDownList ID="cmbPageSize" runat="server" AutoPostBack="true" OnSelectedIndexChanged="cmbPageSize_SelectedIndexChanged" CssClass="pull-right"></asp:DropDownList>
                        <label class="pull-right">Prikaži po stranici:&nbsp</label>
                    </div>
                    <div class="col-lg-6 col-xs-12">
                        <asp:DropDownList ID="cmbSort" runat="server" AutoPostBack="true" OnSelectedIndexChanged="cmbSort_SelectedIndexChanged" Width="50%" CssClass="pull-right"></asp:DropDownList>
                        <label class="pull-right">Sortitaj po:&nbsp</label>
                    </div>
                </div>
            </div><!--col-->
        </div><!--row-pager-sort-->
        
        <div class="row product_box padding-left-05 padding-right-05">
                <asp:Repeater ID="rptProducts" runat="server">
                    <ItemTemplate>
                        <div class="col-lg-3 col-md-3 col-sm-3 col-xs-12 padding-left-0 padding-right-0 margin-top-05">
                            <product_fp:product_fp ID="product_fp1" runat="server" ProductItem='<%#Container.DataItem %>' />
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
        </div><!--product_box-->
        <div class="row">
            <div class="col-lg-5">
                <pager:Pager ID="pgrPager1" runat="server" OnOnClick="pgrPages_Click" />
            </div>
        </div>
    </div><!--main-content-->
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderFooter" runat="server">
</asp:Content>
