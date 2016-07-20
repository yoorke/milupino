<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MainMenu.ascx.cs" Inherits="eshopv2.user_controls.MainMenu" %>
<div id="product-menu">
    <div class="container">
        <div class="row">
            <div class="col-lg-12 padding-left-0 padding-right-0">
                <nav class="navbar navbar-default">
                    <div class="container-fluid">
                        <div class="navbar-header">
                            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#product-menu-items">
                                <span class="icon-bar"></span>
                                <span class="icon-bar"></span>
                                <span class="icon-bar"></span>
                            </button>
                        </div><!--navbar-header-->
                        <div class="collapse navbar-collapse" id="product-menu-items">
                            <ul class="nav navbar-nav navbar-left">
                            
                                <asp:Repeater ID="rptMainMenu" runat="server" OnItemDataBound="rptMainMenu_ItemDataBound">
                                    <ItemTemplate>
                                        <li id="li" runat="server">
                                            <asp:HyperLink ID="lnkMainMenu" runat="server" NavigateUrl='<%#Eval("url") %>' Text='<%#Eval("name") %>'></asp:HyperLink>
                                            
                                            <asp:Repeater ID="rptSubMenu" runat="server" DataSource='<%#Eval("SubCategory") %>'>
                                                <HeaderTemplate>
                                                    <ul class="dropdown-menu">
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <li>
                                                        <asp:HyperLink ID="lnkSubMenu" runat="server" NavigateUrl='<%#Eval("url") %>'>
                                                            <asp:Image ID="lnkImage" runat="server" ImageUrl='<%#Eval("imageurl") %>' runat="server" />
                                                            <asp:Label ID="lblName" runat="server" Text='<%#Eval("name") %>'></asp:Label>
                                                        </asp:HyperLink>
                                                    </li>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    </ul>
                                                </FooterTemplate>
                                            </asp:Repeater>
                                            
                                        </li>
                                    </ItemTemplate>
                                </asp:Repeater>
                                
                            </ul>
                        </div><!--navbar-collapse-->
                    </div><!--container fluid-->
                </nav><!--nav-->
            </div><!--col-->
        </div><!--row-->
    </div><!--container-->
</div><!--product-menu-->