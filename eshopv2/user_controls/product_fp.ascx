<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="product_fp.ascx.cs" Inherits="eshopv2.user_controls.product_fp" %>
<div class="product_fp" onmouseover="ShowHideButtons('<%=divButtons.ClientID %>', true)" onmouseout="ShowHideButtons('<%=divButtons.ClientID %>', false)">
    <div class="wrapper">
        <asp:LinkButton ID="btnDeleteFromWishList" runat="server" CssClass="btn_deleteFromWishList" OnClick="btnDeleteFromWishList_Click" Visible="false"><span class="glyphicon glyphicon-remove"></span></asp:LinkButton>
        <asp:HyperLink ID="lnkEditProduct" runat="server" CssClass="btn_editProduct" Visible="false" Target="_blank" ToolTip="Izmeni proizvod"></asp:HyperLink>
        <div class="photo">
            <asp:HyperLink ID="lnkPhoto" runat="server">
                <asp:Image ID="imgPhoto" runat="server" ImageUrl="~/images/no-image.jpg" CssClass="img-responsive" />
            </asp:HyperLink>
        </div><!--photo-->
        <h3><asp:Label ID="lblBrand" runat="server"></asp:Label></h3>
        <h4><asp:HyperLink ID="lblName" runat="server">ewqew</asp:HyperLink></h4>
        <asp:Image ID="imgPromotion" runat="server" CssClass="img_promotion" Visible="false" />
        <div class="price_div" runat="server" visible="false" id="price_div">
            <span class="price_label">M.P.</span>
            <asp:Label ID="lblPrice" runat="server" CssClass="price">312</asp:Label>
            <span class="price_label">din</span>
        </div><!--price_div-->
        <div class="webprice_div" id="webprice_div">
            <span class="webprice_label"></span>
            <asp:Label ID="lblWebPrice" runat="server">12313,12</asp:Label>
            <span class="webprice_label">din</span>
        </div>
        <div class="saving_div" runat="server" visible="false" id="saving_div">
            <span class="saving_label">Ušteda</span>
            <asp:Label ID="lblSaving" runat="server" CssClass="saving">3213,32</asp:Label>
            <span class="saving_label">din</span>
        </div>
        <div class="buttons" id="divButtons" runat="server" style="display:none">
            <%--<asp:LinkButton ID="btnCart" runat="server" CssClass="btn_cart" OnClick="btnCart_Click" Text=""></asp:LinkButton>--%>
            <button type="button" id="btnCart" class="btn_cart" onclick="AddToCart('<%=lblProductID.ClientID %>')"></button>
            <!--<asp:LinkButton ID="btnDetails" runat="server" Text="Detalji" CssClass="btn_details"></asp:LinkButton>-->
            <asp:HyperLink ID="lblDetails" runat="server" Text="Detalji" CssClass="btn_details"></asp:HyperLink>
            <%--<asp:LinkButton ID="btnCompare" runat="server" Text="Uporedi" CssClass="btn_compare" OnClientClick="function(){ $('#messageBoxCompare').show()}"></asp:LinkButton>--%>
            <button type="button" id="btnCompare" class="btn_compare" onclick="btnCompare_Click('<%=lblProductID.ClientID %>')">Uporedi</button>
            
        </div><!--buttons-->
        <asp:HiddenField ID="lblProductID" runat="server" />
    </div><!--wrapper-->
</div><!--product_fp-->
<script>
    

    
</script>