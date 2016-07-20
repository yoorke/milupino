<%@ Page Language="C#" MasterPageFile="~/eshop2.Master" AutoEventWireup="true" CodeBehind="product.aspx.cs" Inherits="eshopv2.product" Title="Untitled Page" %>
<%@ Register Src="user_controls/ProductImages.ascx" TagName="ProductImages" TagPrefix="uc1" %>
<%@ Register Src="user_controls/Banner.ascx" TagName="Banner" TagPrefix="banner" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!--<script type="text/javascript" src="/js/jquery-1.10.1.min.js"></script>-->
    <link rel="stylesheet" type="text/css" media="all" href="<%# ResolveUrl("~/css/jquery.lightbox-0.5.css")  %>" />
    <asp:Literal ID="canonicalUrl" runat="server"></asp:Literal>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!--BANNER-->
    <div class="col-xs-2 left-column visible-lg visible-md">
        <banner:Banner ID="banner1" runat="server" Position="FP1" />
        <banner:Banner ID="banner2" runat="server" Position="FP2" />
    </div><!--col-banner-->
            
    <!--MAIN CONTENT-->
    <div class="col-xs-12 col-sm-12 col-md-10 col-lg-10 main-content product-content">
        <!--images, name, price-->
        <div class="row">
            <div class="col-sm-5">
                <uc1:ProductImages ID="priProductImages" runat="server" />
                <asp:Image ID="imgPromotion" runat="server" Visible="false" CssClass="imgPromotion" />
            </div><!--col-->
            <div class="col-sm-7">
                <asp:HiddenField ID="lblProductID" runat="server" />
                <h1><asp:Literal ID="lblBrand" runat="server"></asp:Literal></h1>
                <h2><asp:Literal ID="lblName" runat="server"></asp:Literal></h2>
                <p>Pogledajte i ostale proizvode iz kategorije <asp:HyperLink ID="lnkCategory" runat="server" CssClass="underline"></asp:HyperLink></p>
                
                <!--Kredit i rate-->
                <%--<div class="row loanBox">
                    <div class="col-sm-1">
                        <img src='<%=Page.ResolveUrl("~/images/loan.gif") %>' />
                    </div>
                    <div class="col-sm-4">
                        
                        <span><label onclick="loan()" class="cursor-pointer bold-none">Prijavite se za beskamatni kredit</label></span>
                    </div>
                    <div class="col-sm-1">
                        <img src='<%=Page.ResolveUrl("~/images/calculator.gif") %>' />
                    </div>
                    <div class="col-sm-3">
                        <span><label onclick="calculateLoan()" class="cursor-pointer bold-none">Izračunajte vašu ratu</label></span>
                    </div>
                    <div class="col-sm-3">
                        Rata već od <span class="color-red">3.688,55</span> din
                    </div>
                </div><!--row-kredit-i-rate-->--%>
                
                <div class="row priceBox color-gray">
                    <div class="col-sm-6">
                        <p>Dostupnost:</p>
                        <p class="bold uppercase"><asp:Literal ID="txtAvailability" runat="server" Text="Na stanju"></asp:Literal></p>
                        <p class="margin-top-2">Očekivani rok isporuke:</p>
                        <p><asp:Literal ID="txtDelivery" runat="server" Text="-"></asp:Literal></p>
                    </div>
                    <div class="col-sm-6 text-right">
                        <p class="margin-bottom-0"><asp:Literal ID="lblPrice" runat="server" Text="MP 110.989 din"></asp:Literal></p>
                        <p class="font-2em color-blue bold margin-bottom-0"><asp:Label ID="lblWebPrice" runat="server" Text="99.890 din"></asp:Label></p>
                        <p><asp:Literal ID="lblSaving" runat="server" Text="Ušteda: 2.548,00 din"></asp:Literal></p>
                        <!--<asp:Button ID="btnCart" runat="server" CssClass="btnAddToCart" Text="Dodaj u korpu" OnClick="btnCart_Click" />-->
                        <button type="button" id="btnCart" class="btnAddToCart" onclick="AddToCart('<%=lblProductID.ClientID %>')">Dodaj u korpu</button>
                    </div>
                </div><!--row-->
                <div class="row icons">
                    <div class="col-xs-1">
                        <img src='<%=Page.ResolveUrl("~/images/compare.gif") %>' />
                        
                    </div>
                    <div class="col-xs-3"><!--<asp:LinkButton ID="btnCompare" runat="server" Text="Uporedi" OnClientClick="btnCompare_Click('<%=lblProductID.ClientID %>')"></asp:LinkButton>-->
                        <!--<button type="button" id="btnCompare" onclick="btnCompare_Click('<%=lblProductID.ClientID %>')">Uporedi</button>-->
                        <label onclick="btnCompare_Click('<%=lblProductID.ClientID %>')" class="cursor-pointer bold-none">Uporedi</label>

                    </div>
                    <div class="col-xs-1">
                        <img src='<%=Page.ResolveUrl("~/images/wishlist.gif") %>' />
                        
                    </div>
                    <div class="col-xs-3"><label onclick="AddToWishList()" class="cursor-pointer bold-none">Lista želja</label></div>
                    <div class="col-xs-1">
                        <img src='<%=Page.ResolveUrl("~/images/recommend.gif") %>' />
                        
                    </div>
                    <div class="col-xs-3"><label onclick="recommend()" class="cursor-pointer bold-none">Preporučite</label></div>
                </div><!--row-->
                <div class="row margin-top-2">
                    <div class="col-lg-12 text-right">
                        <div id="lblProductFacebookLike" runat="server"></div>
                    </div>
                </div>
                <%--<div class="row">
                    <div class="col-lg-12">
                        Redovna cena: <asp:Label ID="lblPrice1" runat="server" CssClass="regular"></asp:Label> din<br />
                        Web cena: <asp:Label ID="lblWebPrice1" runat="server" CssClass="web"></asp:Label> din<br />
                        Ušteda: <asp:Label ID="lblSaving1" runat="server" CssClass="saving"></asp:Label> din
                
                    </div><!--col-->
                </div><!--row-->
        <div class="row">
            <asp:LinkButton ID="btnCart" runat="server" CssClass="button" OnClick="btnCart_Click">Ubaci u korpu</asp:LinkButton>
        </div>--%>
            </div><!--col-->
        </div><!--row-->
        
        
        <!--description-->
        <div class="row">
            <div class="col-lg-12">
                <h3>Opis</h3>
                <asp:Literal ID="lblDescription" runat="server"></asp:Literal>
            </div><!--col-->
        </div><!--row-->
        
        <!--specification-->
        <div class="row">
            <div class="col-lg-12 specification">
                <h3>Specifikacije i detalji</h3>
                <asp:Literal ID="lblSpecification" runat="server"></asp:Literal>
            </div><!--col-->
        </div><!--row-->
    </div><!--col main-->
    <div class="messageBoxWrapper" id="wishListMessageBox" style="display:none">
        <div class="messageBox" id="wishListMessageBoxText">
            <span>Proizvod dodat u listu želja</span>
            <div>
                <button type="button" id="btnWishListMessageBoxOk" onclick="WishListMessageBoxOk_Click()">Zatvori</button>
                <button type="button" id="btnWishListShowList" onclick="window.location='/wishList.aspx'">Prikaži listu</button>
            </div>
        </div>
        
    </div><!--messageBox-->
    
    
    <%--<div class="bannerColumn">
        <div class="banner"></div>    
    </div>
    
    <div class="productColumn">
        <div class="productBox">
            <div class="images">
                
            </div>
            
            <div class="description"></asp:Literal></div>
            <div class="prices">
                
            </div>
            <div class="cartButton">
                
            </div>
        </div>
        
        
        <div id="tabsContainer">
            <ul class="tabs">
                <li class="tab-link current" data-tab="tab-1">Specifikacija</li>
                <li class="tab-link" data-tab="tab-2">Opis</li>
            </ul>
            
            <div id="tab-1" class="tab-content current">
                <div class="specification">
                    <h2>Specifikacija</h2>
                    
                </div>
            </div>
            <div id="tab-2" class="tab-content">
                
            </div>
        </div>--%>
        <%--<ajaxtoolkit:ToolkitScriptManager ID="toolkitScriptManager1" runat="server" EnablePartialRendering="true"></ajaxtoolkit:ToolkitScriptManager>
        <ajaxtoolkit:TabContainer ID="tabContainer1" runat="server" Width="640px">
            <ajaxtoolkit:TabPanel ID="tbpSpecification" runat="server" HeaderText="Specifikacija">
                <ContentTemplate>
                    
                </ContentTemplate>
            </ajaxtoolkit:TabPanel>
            <ajaxtoolkit:TabPanel ID="tbpDescription" runat="server" HeaderText="Opis">
                <ContentTemplate>
                    <asp:Literal runat="server"></asp:Literal>
                </ContentTemplate>
            </ajaxtoolkit:TabPanel>
        </ajaxtoolkit:TabContainer>--%>
        
    <%--</div>--%>
    
    <%--<div class="bannerColumn">
        <div class="banner"></div>
    </div>--%>
    
    
    

    <%--<script type="text/javascript">
        $(document).ready(function() {
            $('ul.tabs li').click(function(){
                                        var tab_id=$(this).attr('data-tab');
                                        $('ul.tabs li').removeClass('current');
                                        $('.tab-content').removeClass('current');
                                        $(this).addClass('current');
                                        $("#"+tab_id).addClass('current');
                                    })
        });
    </script>--%>
</asp:Content>

    <asp:Content ID="Content3" runat="server" ContentPlaceHolderID="ContentPlaceHolderFooter">
    <script type="text/javascript" src="<%=ResolveUrl("~/js/jquery.lightbox-0.5.min.js") %>"></script>
    
    <script type="text/javascript">
        jQuery(function() {
            jQuery('#thumbnails a').lightBox();
        });
</script>
</asp:Content>