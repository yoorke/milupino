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
        if (imageUrl.toString().indexOf("-small") > 0)
            image.src = imageUrl.toString().substring(0, imageUrl.toString().indexOf("-small")) + "-large.jpg";
        else
            image.src = imageUrl.toString().substring(0, imageUrl.toString().indexOf("-thumb")) + "-large.jpg";
        var link = document.getElementById("ctl00_ContentPlaceHolder1_priProductImages_lnkImage");
        if (imageUrl.toString().indexOf("-small") > 0)
            link.href = imageUrl.toString().substring(0, imageUrl.toString().indexOf("-small")) + ".jpg";
        else
            link.href = imageUrl.toString().substring(0, imageUrl.toString().indexOf("-thumb")) + ".jpg";
    }
    
</script>