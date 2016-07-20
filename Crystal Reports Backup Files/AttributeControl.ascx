<%@ Control ClassName="AttributeControl" Language="C#" AutoEventWireup="true" CodeBehind="AttributeControl.ascx.cs" Inherits="eshopv2.administrator.customControls.AttributeControl" %>
<div class="input-group">
    <asp:DropDownList ID="cmbAttribute" runat="server" CssClass="form-control"></asp:DropDownList>
    <span class="input-group-addon"><i id="btnAddValue" runat="server" class="glyphicon glyphicon-plus cursor-pointer"  onclick="ShowModalPopup(this.id);return false;"></i></span>
</div>
<asp:HiddenField ID="lblAttributeID" runat="server" />

<%--<asp:LinkButton ID="btnAddValue" runat="server" OnClientClick="ShowModalPopup(this.id);return false;">
    <asp:Image ImageUrl="../../images/add_icon.png" AlternateText="Dodaj vrednost" runat="server" />
</asp:LinkButton>--%>
