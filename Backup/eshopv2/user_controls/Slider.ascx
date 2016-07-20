<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Slider.ascx.cs" Inherits="eshopv2.user_controls.Slider" %>
<div class="row slider">
    <div class="col-xs-12 padding-left-0 padding-right-0">
        <asp:Repeater ID="rptSlider" runat="server">
            <HeaderTemplate>
                <div class="camera_wrap camera_azure_skin" id="camera_wrap_1">
            </HeaderTemplate>
            <ItemTemplate>
                <div data-thumb='' data-src='<%#Eval("imageUrl") %>'></div>
            </ItemTemplate>
            <FooterTemplate>
                </div>
            </FooterTemplate>
        </asp:Repeater>
    </div>
</div>