<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="product_slider.ascx.cs" Inherits="eshopv2.user_controls.product_slider" %>
<%@ Register Src="product_fp.ascx" TagName="ProductFirstPage" TagPrefix="product_fp" %>
<div class="row product_slider_header">
    <div class="col-md-8">
        <h2><asp:Label ID="lblName" runat="server" Text='<%#Eval("name") %>'></asp:Label></h2>
    </div>
    <div class="col-md-4">
        <!-- Controls -->
        <div class="controls pull-right hidden-xs">
            <asp:Literal ID="lblPrev" runat="server"></asp:Literal>
            <asp:Literal ID="lblNext" runat="server"></asp:Literal>
            <!--<a id="prev" runat="server" href="#carousel-example" data-slide="prev"><img src="<%=ResolveUrl("~/images/prev_next.gif") %>" alt="Prethodni" /></a>
            <a id="next" runat="server" href="#carousel-example" data-slide="next" class="next_button"><img src="<%=ResolveUrl("~/images/prev_next.gif") %>" alt="Sledeći" /></a>-->
        </div><!--controls-->
    </div><!--col-->
</div><!--row-->
<div class="row margin-top-05">
<div class="col-lg-12">
<asp:Literal ID="lblCarousel" runat="server"></asp:Literal>
<!--<div id="carouselexample" class="carousel slide" data-ride="" runat="server">-->
    <!-- Wrapper for slides -->
    <div class="carousel-inner">
        <asp:Repeater ID="rptSlides" runat="server" OnItemDataBound="rptSlides_ItemDataBound">
            <HeaderTemplate>
                
            </HeaderTemplate>
            <ItemTemplate>
                <div class="item" id="divHeader" runat="server">
                    <div class="row padding-left-05 padding-right-05">
                        <asp:Repeater ID="rptProducts" runat="server">
                            <ItemTemplate>
                                <div class="col-lg-2 col-md-3 col-sm-3 col-xs-6 padding-left-0 padding-right-0">
                                    <product_fp:ProductFirstPage ID="productFirstPage1" runat="server" ProductItem='<%#Container.DataItem %>' />
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div><!--row-->
                </div><!--item-->
            </ItemTemplate>
            <FooterTemplate>
                    
            </FooterTemplate>
        </asp:Repeater>
        
                <%--<div class="col-lg-2 col-md-2 col-sm-3 col-xs-12 padding-left-0 padding-right-0">
                    <product_fp:ProductFirstPage ID="product_fp1" runat="server" />
                </div><!--col-->
                <div class="col-lg-2 col-md-2 col-sm-3 col-xs-12 padding-left-0 padding-right-0">
                    <product_fp:ProductFirstPage ID="ProductFirstPage1" runat="server" />
                </div><!--col-->
                <div class="col-lg-2 col-md-2 col-sm-3 col-xs-12 padding-left-0 padding-right-0">
                    <product_fp:ProductFirstPage ID="ProductFirstPage2" runat="server" />
                </div><!--col-->
                <div class="col-lg-2 col-md-2 col-sm-3 col-xs-12 padding-left-0 padding-right-0">
                    <product_fp:ProductFirstPage ID="ProductFirstPage3" runat="server" />
                </div><!--col-->
                <div class="col-lg-2 col-md-2 col-sm-3 col-xs-12 padding-left-0 padding-right-0">
                    <product_fp:ProductFirstPage ID="ProductFirstPage8" runat="server" />
                </div><!--col-->
                <div class="col-lg-2 col-md-2 col-sm-3 col-xs-12 padding-left-0 padding-right-0">
                    <product_fp:ProductFirstPage ID="ProductFirstPage9" runat="server" />
                </div><!--col-->
            
        <div class="item">
            <div class="row">
                <div class="col-lg-2 col-md-2 col-sm-4 col-xs-12">
                    <product_fp:ProductFirstPage ID="ProductFirstPage4" runat="server" />
                </div><!--col-->
                <div class="col-lg-2 col-md-2 col-sm-4 col-xs-12">
                    <product_fp:ProductFirstPage ID="ProductFirstPage5" runat="server" />
                </div><!--col-->
                <div class="col-lg-2 col-md-2 col-sm-4 col-xs-12">
                    <product_fp:ProductFirstPage ID="ProductFirstPage6" runat="server" />
                </div><!--col-->
                <div class="col-lg-2 col-md-2 col-sm-4 col-xs-12">
                    <product_fp:ProductFirstPage ID="ProductFirstPage7" runat="server" />
                </div><!--col-->
            </div><!--row-->
        </div><!--item-->--%>
    </div><!--carusel-->
</div><!--carousel-->
</div><!--col-->
</div><!--row-->
