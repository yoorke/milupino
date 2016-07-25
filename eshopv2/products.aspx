<%@ Page Title="" Language="C#" MasterPageFile="~/eshop2.Master" AutoEventWireup="true" CodeBehind="products.aspx.cs" Inherits="eshopv2.products" %>
<%@ Register Src="user_controls/Pager.ascx" TagName="Pager" TagPrefix="pager" %>
<%@ Register Src="user_controls/product_fp.ascx" TagName="Product_fp" TagPrefix="product_fp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <asp:Literal ID="canonicalUrl" runat="server"></asp:Literal>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="col-xs-5 col-sm-2 col-md-2 col-lg-2 left-column filter">
        <%--<h2>Kategorija</h2>
        <div class="filterBox">
            <asp:CheckBoxList ID="chkCategory" runat="server" AutoPostBack="true" OnSelectedIndexChanged="chkCategory_SelectedIndexChanged"></asp:CheckBoxList>
        </div>--%>
        <h2 id="brandLabel" runat="server">Proizvođač</h2>
        <div class="filterBox">
            <asp:CheckBoxList ID="chkBrands" runat="server" OnSelectedIndexChanged="chkBrands_SelectedIndexChanged"></asp:CheckBoxList>
        </div>
        <h2>Cena</h2>
        <div class="filterBox">
            <label class="before">Od:</label><asp:DropDownList ID="cmbPriceFrom" runat="server" OnSelectedIndexChanged="cmbPriceFrom_SelectedIndexChanged"></asp:DropDownList><label><small>din</small></label><br />
            <label class="before">Do:</label><asp:DropDownList ID="cmbPriceTo" runat="server" OnSelectedIndexChanged="cmbPriceTo_SelectedIndexChanged"></asp:DropDownList><label><small>din</small></label>
        </div>
        <asp:Repeater ID="rptFilter" runat="server">
            <ItemTemplate>
                <h2><asp:Literal ID="lblFilterName" runat="server" Text='<%#Eval("nameScreen") %>'></asp:Literal></h2>
                <asp:HiddenField ID="lblAttributeID" runat="server" Value='<%#Eval("attributeID") %>' />
                <div class="filterBox">
                    <asp:CheckBoxList ID="chkValues" runat="server" DataSource='<%#Eval("values") %>' DataTextField="value" DataValueField="attributeValueID" OnSelectedIndexChanged="chkValues_SelectedIndexChanged"></asp:CheckBoxList>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>
    <div class="col-xs-7 col-sm-10 col-md-10, col-lg-10 main-content first-page">
        <div class="row">
            <div class="col-lg-5">
                <pager:Pager ID="pgrPager" runat="server" OnOnClick="pgrPages_Click" />
            </div>
            <div class="col-lg-7">
                <div class="row sort pull-right">
                    <div class="col-sm-6 col-xs-12">
                        <div role="form" class="form-horizontal">
                            <div class="form-group">
                                <label for="cmbPageSize" class="col-xs-8 control-label">Prikaži po stranici:</label>
                                <div class="col-xs-4">
                                    <asp:DropDownList ID="cmbPageSize" runat="server" OnSelectedIndexChanged="cmbPageSize_SelectedIndexChanged" CssClass="form-control"></asp:DropDownList>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-6 col-xs-12">
                        <div role="form" class="form-horizontal">
                            <div class="form-group">
                                <label for="cmbSort" class="col-xs-5 control-label">Sortiraj po:</label>
                                <div class="col-xs-7">
                                    <asp:DropDownList ID="cmbSort" runat="server" OnSelectedIndexChanged="cmbSort_SelectedIndexChanged" CssClass="pull-right form-control"></asp:DropDownList>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row status" id="divStatus" runat="server" visible="false">
            <div class="col-lg-12">
                Nema proizvoda za traženi filter
            </div>
        </div>
        <div class="row product_box padding-left-05 padding-right-05">
            <asp:Repeater ID="rptProducts" runat="server">
                <ItemTemplate>
                    <div class="col-lg-3 col-md-3 col-sm-3 col-xs-12 padding-left-0 padding-right-0 margin-top-05">
                        <product_fp:Product_fp ID="product_fp" runat="server" ProductItem='<%#Container.DataItem %>' />
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
        <div class="row">
            <div class="col-lg-5">
                <pager:Pager ID="pgrPager1" runat="server" OnOnClick="pgrPages_Click" />
                <asp:HiddenField ID="lblPageIndex" runat="server" />
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderFooter" runat="server">
    <script>
        $(document).ready(function () {
            $('[id*=chkBrands] input').click(function () {
                //alert(this);
                $('#ctl00_ContentPlaceHolder1_lblPageIndex').val('');
                createQueryString();
               
            });
            $('[id*=cmbPrice]').change(function () {
                $('#ctl00_ContentPlaceHolder1_lblPageIndex').val('');
                createQueryString();
              
            })
            $('[id*=chkValues] input').click(function () {
                $('#ctl00_ContentPlaceHolder1_lblPageIndex').val('');
                createQueryString();
              
            })
            $('[id*=cmbPageSize]').change(function () {
                $('#ctl00_ContentPlaceHolder1_lblPageIndex').val('');
                createQueryString();
            });
            $('[id*=lnkPage]').click(function () {
                $('#ctl00_ContentPlaceHolder1_lblPageIndex').val($(this)[0].attributes['data-pageindex'].value);
                createQueryString();
                
            });
            $('[id*=cmbSort]').change(function () {
                createQueryString();
            })

        })

        function createQueryString() {
            var queryString = '';
            var exists = false;
            $.each($('[id*=chkBrands] input:checked'), function (key, value) {
                queryString += $(this).parent().attr('attributeValue') + ',';
            })
            if (queryString.length > 0) {
                queryString = 'brands=' + queryString;
                queryString = queryString.substring(0, queryString.length - 1);
                exists = true;
                
            }

            if ($('[id*=cmbPriceFrom]').val() != '-') {
                queryString += (exists ? '&' : '') + 'priceFrom=' + $('[id*=cmbPriceFrom]').val();
                exists = true;
            }

            if ($('[id*=cmbPriceTo]').val() != '-') {
                queryString += (exists ? '&' : '') + 'priceTo=' + $('[id*=cmbPriceTo]').val();
                exists = true;
            }

            var attributeQueryString = '';
            $.each($('[id*=chkValues] input:checked'), function (key, value) {
                attributeQueryString += $(this).parent().attr('attributeValue') + ',';
            })
            if (attributeQueryString != '') {
                queryString += (exists ? '&' : '') + 'attributes=' + attributeQueryString.substring(0, attributeQueryString.length - 1);
                exists = true;
            }

            if($('[id*=cmbPageSize]').val() != '16'){
                queryString += (exists ? '&' : '') + 'pageSize=' + $('[id*=cmbPageSize]').val();
                exists = true;
            }
            if($('#ctl00_ContentPlaceHolder1_lblPageIndex').val() != ''){
                queryString += (exists ? '&' : '') + 'pageIndex=' + $('#ctl00_ContentPlaceHolder1_lblPageIndex').val();
                exists = true;
            }
            if($('[id*=cmbSort]').val() != 'name'){
                queryString += (exists ? '&' : '') + 'sort=' + $('[id*=cmbSort]').val();
                exists = true;
            }

            //var category = window.location.href.substring(window.location.href.indexOf('/proizvodi/') + 11, window.location.href.indexOf('.html') + 5);
            var href = window.location.href;
            if (href.indexOf('?') > 0)
                href = href.substring(0, href.indexOf('?'));
            window.location = href + (queryString.length > 0 ? ('?' + encodeURI(queryString)) : '');
        }
    </script>
</asp:Content>
