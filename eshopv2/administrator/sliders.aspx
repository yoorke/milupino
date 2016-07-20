<%@ Page Language="C#" MasterPageFile="~/administrator/adminPanel.Master" AutoEventWireup="true" CodeBehind="sliders.aspx.cs" Inherits="eshopv2.administrator.sliders" Title="Slajderi | Admin panel" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-wrapper">Sliders</h1>
            </div><!--col-->
        </div><!--row-->
        <div class="row">
            <div class="col-lg-12">
                <div class="btn-group">
                    <asp:Button ID="btnAddSlider" runat="server" OnClick="btnAddSlider_Click" Text="Dodaj slider" CssClass="btn btn-primary" />            
                </div><!--btn-group-->
            </div><!--col-->
        </div><!--row-->
        <div class="row">
            <div class="col-lg-12">
                <asp:GridView ID="dgvSliders" runat="server" AutoGenerateColumns="false" OnRowDeleting="dgvSliders_RowDeleting"
                    DataKeyNames="sliderID" CssClass="table table-contensed table-bordered table-hover table-striped">
                    <Columns>
                        <asp:TemplateField Visible="false">
                            <ItemTemplate>
                                <asp:Label ID="lblSliderID" runat="server" Text='<%#Eval("sliderID") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                
                        <asp:TemplateField HeaderText="Naziv" ControlStyle-Width="200px">
                            <ItemTemplate>
                                <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%#"/administrator/slider.aspx?id="+Eval("sliderID") %>'>
                                    <asp:Label ID="lblName" runat="server" Text='<%#Eval("name") %>'></asp:Label>
                                </asp:HyperLink>
                            </ItemTemplate>
                        </asp:TemplateField>
                
                        <asp:CommandField ShowDeleteButton="true" ControlStyle-Width="20px" DeleteImageUrl="~/images/delete_icon.png" ButtonType="Image" />
                    </Columns>
                </asp:GridView>        
            </div><!--col-->
        </div><!--row-->
    </div><!--page-wrapper-->
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    <%--<div id="topMenu">
        
    </div>
    
    <div id="mainContent">
        
        
        
    </div>--%>
</asp:Content>
