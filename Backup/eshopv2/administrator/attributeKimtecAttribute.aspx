<%@ Page Language="C#" MasterPageFile="~/administrator/adminPanel.Master" AutoEventWireup="true" CodeBehind="attributeKimtecAttribute.aspx.cs" Inherits="eshopv2.administrator.attributeKimtecAttribute" Title="Povezivanje atributa | Admin panel" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">Povezivanje atributa</h1>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-6">
                <asp:DropDownList ID="cmbCategory" runat="server" OnSelectedIndexChanged="cmbCategory_SelectedIndexChanged" CssClass="form-control"></asp:DropDownList>
            </div>
            <div class="col-lg-6">
                <asp:DropDownList ID="cmbKimtecCategory" runat="server" OnSelectedIndexChanged="cmbKimtecCategory_SelectedIndexChanged" CssClass="form-control"></asp:DropDownList>
            </div>
        </div>
        <div class="row margin-bottom-10 margin-top-05">
            <div class="col-lg-12">
                <div class="btn-group">
                    <asp:Button ID="btnShowAttributes" runat="server" Text="Prikaži" OnClick="btnShowAttributes_Click" CssClass="btn btn-primary" />
                    <asp:Button ID="btnSave" runat="server" Text="Sačuvaj" OnClick="btnSave_Click" CssClass="btn btn-primary" />
                </div>
            </div>
        </div>
        
        <div class="row">
            <div class="col-lg-12">
                <asp:GridView ID="dgvAttribute" runat="server" AutoGenerateColumns="false" OnRowDataBound="dgvAttribute_RowDataBound"
                CssClass="table table-bordered table-hover table-striped">
                    <Columns>
                        <asp:TemplateField Visible="false">
                            <ItemTemplate>
                                <asp:Label ID="lblAttributeID" runat="server" Text='<%#Eval("attributeID") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:Label ID="lblAttributeName" runat="server" Text='<%#Eval("name") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:DropDownList ID="cmbKimtecAttribute" runat="server"></asp:DropDownList>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField Visible="false">
                            <ItemTemplate>
                                <asp:Label ID="lblKimtecAttributeID" runat="server" Text='<%#Eval("kimtecAttributeID") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>
</asp:Content>
