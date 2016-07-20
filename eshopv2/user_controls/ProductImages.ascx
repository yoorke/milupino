<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ProductImages.ascx.cs" Inherits="eshopv2.user_controls.ProductImages" %>

<%--<asp:ScriptManager runat="server"></asp:ScriptManager>--%>
<%--<asp:UpdatePanel runat="server">
    <ContentTemplate>--%>
        <div class="row">
            <div class="col-lg-12">
                <div id="thumbnails">
                    <asp:HyperLink ID="lnkImage" runat="server" CssClass="mainImage">
                        <asp:Image ID="imgMain" runat="server" CssClass="img-responsive" />
                    </asp:HyperLink>
                </div>
            </div>
        </div><!--row-->

        <%--<div class="row">--%>
            <asp:Panel ID="pnlThumbs" runat="server" CssClass="thumbs row"></asp:Panel>
        <%--</div><!--row-->--%>
    <%--</ContentTemplate>
</asp:UpdatePanel>--%>

<script type="text/javascript">
    function changeImg(imageUrl)
    {
        var image = document.getElementById("ctl00_ContentPlaceHolder1_priProductImages_imgMain");
        image.src = imageUrl.toString().substring(0, imageUrl.toString().indexOf("-small")) + "-large.jpg";
        var link = document.getElementById("ctl00_ContentPlaceHolder1_priProductImages_lnkImage");
        link.href = imageUrl.toString().substring(0, imageUrl.toString().indexOf("-small"))+".jpg";
    }
    
</script>