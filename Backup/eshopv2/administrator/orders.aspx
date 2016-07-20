<%@ Page Language="C#" MasterPageFile="~/administrator/adminPanel.Master" AutoEventWireup="true" CodeBehind="orders.aspx.cs" Inherits="eshopv2.administrator.orders" Title="Narudžbine | Admin panel" %>
<%@ Register Src="../user_controls/CustomStatus.ascx" TagName="CustomStatus" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">Narudžbine</h1>
            </div><!--col-->
        </div><!--row-->
        <div class="row">
            <div class="col-sm-4">
                <ajaxtoolkit:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server" EnablePartialRendering="true"></ajaxtoolkit:ToolkitScriptManager>
                <div role="form">
                    <div class="form-group">
                        <label for="cmbStatus">Status: </label>
                        <asp:DropDownList ID="cmbStatus" runat="server" CssClass="form-control"></asp:DropDownList>            
                    </div><!--form-group-->
                </div><!--form-->
            </div><!--col-->
            <div class="col-sm-3">
                <div role="form">
                    <div class="form-group">
                        <label for="txtDateFrom">Datum od: </label>
                        <asp:TextBox ID="txtDateFrom" runat="server" CssClass="form-control"></asp:TextBox>
                        <ajaxtoolkit:CalendarExtender ID="dtpDateFrom" runat="server" TargetControlID="txtDateFrom" Format="dd.MM.yyyy"></ajaxtoolkit:CalendarExtender>            
                    </div><!--form-group-->
                </div><!--form-->
            </div><!--col-->
            <div class="col-sm-3">
                <div role="form">
                    <div class="form-group">
                        <label for="txtDateTo">Datum do: </label>
                        <asp:TextBox ID="txtDateTo" runat="server" CssClass="form-control"></asp:TextBox>
                        <ajaxtoolkit:CalendarExtender ID="dtpDateTo" runat="server" TargetControlID="txtDateTo" Format="dd.MM.yyyy"></ajaxtoolkit:CalendarExtender>
                    </div><!--form-group-->
                </div>
            </div><!--col-->
            <div class="col-sm-2">
                <asp:Button ID="btnShowOrders" runat="server" Text="Prikaži" OnClick="btnShowOrders_Click" CssClass="btn btn-primary" />
            </div><!--col-->
        </div><!--row-->
        <div class="row">
            
            
        </div><!--row-->
        <div class="row">
            <div class="col-lg-12">
                
            </div><!--col-->
        </div><!--row-->
        <div class="row">
            <div class="col-lg-12">
                <uc1:CustomStatus ID="customStatus1" runat="server" />        
            </div><!--col-->
        </div><!--row-->
        <div class="row margin-top-05">
            <div class="col-lg-12">
                <asp:GridView ID="dgvOrders" runat="server" AutoGenerateColumns="false" OnRowDeleting="dgvOrders_RowDeleting"
                    DataKeyNames="orderID" CssClass="table table-condensed table-bordered table-hover table-striped"
                    OnRowDataBound="dgvOrders_RowDataBound">
                    <Columns>
                        <asp:TemplateField Visible="false">
                            <ItemTemplate>
                                <asp:Label ID="lblOrderID" runat="server" Text='<%#Eval("orderID") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                
                        <asp:TemplateField HeaderText="Datum" ControlStyle-Width="120px">
                            <ItemTemplate>
                                <asp:Label ID="lblDate" runat="server" Text='<%#Eval("date") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                
                        <asp:TemplateField HeaderText="Broj" ControlStyle-Width="100px">
                            <ItemTemplate>
                                <asp:Label ID="lblCode" runat="server" Text='<%#Eval("code") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                
                        <asp:TemplateField HeaderText="Naziv" ControlStyle-Width="200px">
                            <ItemTemplate>
                                <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%#"/administrator/order.aspx?orderID=" + Eval("orderID") %>'>
                                    <asp:Label ID="lblName" runat="server" Text='<%#Eval("name") %>'></asp:Label>
                                </asp:HyperLink>
                            </ItemTemplate>
                        </asp:TemplateField>
                
                        <asp:TemplateField HeaderText="Iznos" ControlStyle-Width="100px" ItemStyle-HorizontalAlign="right">
                            <ItemTemplate>
                                <asp:Label ID="lblTotal" runat="server" Text='<%#String.Format("{0:N2}", Eval("total")) %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                
                        <asp:TemplateField Visible="false">
                            <ItemTemplate><asp:Label ID="lblColor" runat="server" Text='<%#Eval("color") %>'></asp:Label></ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField HeaderText="Status">
                            <ItemTemplate>
                                <asp:Label ID="lblStatus" runat="server" Text='<%#Eval("status") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                
                
                
                        <asp:CommandField ShowDeleteButton="true" DeleteImageUrl="~/images/delete_icon.png" ControlStyle-Width="20px" DeleteText="" ButtonType="Image" />
                    </Columns>
                </asp:GridView>        
            </div><!--col-->
        </div><!--row-->
    </div><!--page-wrapper-->
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    <div id="topMenu">
        <p class="row">
            
        </p>
        <p class="row">
            
            
        </p>
        
    </div>
    
    <div id="mainContent">
        
        
        
    </div>
</asp:Content>
