<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Cart.ascx.cs" Inherits="eshopv2.user_controls.Cart" %>
<%@ Register src="CustomStatus.ascx" tagname="CustomStatus" tagprefix="uc1" %>
<div class="row">
    <div class="col-lg-12">
        <asp:Label ID="lblStatus" runat="server" Visible="false" CssClass="status"></asp:Label>
        <asp:GridView ID="dgvCart" runat="server" CssClass="table"
            AutoGenerateColumns="false" OnRowDataBound="dgvCart_RowDataBound" OnRowCommand="dgvCart_RowCommand" DataKeyNames="productID"
            OnRowDeleting="dgvCart_RowDeleting">
                <Columns>
                    <asp:TemplateField HeaderText="Rb" ControlStyle-Width="20px">
                        <ItemTemplate>
                            <asp:Label ID="lblRowIndex" runat="server"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
            
                    <asp:TemplateField Visible="false">
                        <ItemTemplate>
                            <asp:Label ID="lblProductID" runat="server" Text='<%#Eval("productID") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
            
                    <asp:TemplateField HeaderText="Naziv" ControlStyle-Width="390px">
                        <ItemTemplate>
                            <asp:Label ID="lblBrand" runat="server" Text='<%#Eval("name1") + " " + Eval("name")%>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
            
                    <%--<asp:TemplateField HeaderText="Naziv" ControlStyle-Width="100px">
                        <ItemTemplate>
                            <asp:Label ID="lblName" runat="server" Text='<%#Eval("name") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>--%>
            
                    <asp:TemplateField Visible="false">
                        <ItemTemplate>
                            <asp:Label ID="lblProductPrice" runat="server" Text='<%#Eval("productPrice") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
            
                    <asp:TemplateField HeaderText="Cena" ControlStyle-Width="70px" ItemStyle-HorizontalAlign="Right">
                        <ItemTemplate>
                            <asp:Label ID="lblUserPrice" runat="server" Text='<%#String.Format("{0:N2}", double.Parse(Eval("userPrice").ToString())) %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
            
                    <asp:TemplateField HeaderText="Količina" ControlStyle-Width="50px">
                        <ItemTemplate>
                            <asp:TextBox ID="txtQuantity" runat="server" Text='<%#Eval("quantity") %>'></asp:TextBox>
                            <asp:LinkButton ID="btnUpdateQuantity" runat="server" Text="Ažuriraj" CommandName="UpdateQuantity"></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
            
                    <asp:TemplateField HeaderText="Iznos" ControlStyle-Width="70px" ItemStyle-HorizontalAlign="Right">
                        <ItemTemplate>
                            <asp:Label ID="lblSum" runat="server" Text='<%#String.Format("{0:N2}", double.Parse(Eval("total").ToString())) %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
            
                    <asp:CommandField ShowDeleteButton="true" ControlStyle-Width="20px" DeleteImageUrl="/images/delete_icon.png" ButtonType="Image" />
                </Columns>    
            </asp:GridView>
    </div><!--col-->
</div><!--row-->
<div class="row">
    <div class="col-lg-12">
        <div class="pull-right">
            <span>Ukupno: </span>
            <asp:Label ID="lblTotal" runat="server" CssClass="totalValue"></asp:Label>
            <asp:Label ID="lblTax" runat="server"></asp:Label>
        </div>
    </div><!--col-->
</div><!--row-->
<div class="row">
    <div class="col-lg-6">
        <label>Kupon za popust: </label>
        <asp:TextBox ID="txtCoupon" runat="server"></asp:TextBox>
        <asp:LinkButton ID="btnAddCoupon" runat="server" Text="Unesi" OnClick="btnAddCoupon_Click" CssClass="standardButton"></asp:LinkButton>
        <asp:LinkButton ID="btnDeleteCoupon" runat="server" Text="Obriši kupon" OnClick="btnDeleteCoupon_Click" Visible="false"></asp:LinkButton>        
    </div><!--col-->
    <div class="col-lg-6">
        <div class="pull-right">
            <asp:LinkButton ID="btnCheckout" runat="server" Text="Naruči" OnClick="btnCheckout_Click" CssClass="btn btn-default"></asp:LinkButton>
            <asp:LinkButton ID="btnContinueShopping" runat="server" Text="Nastavi kupovinu" OnClick="btnContinueShopping_Click" CssClass="btn btn-default"></asp:LinkButton>    
        </div>
    </div><!--col-->
</div><!--row-->


















<div id="cart">
    <!--<uc1:CustomStatus ID="CustomStatus1" runat="server" Visible="false" />-->
    
    
    
    
    <div class="total">
        
    </div>
    
    <div class="buttons">
        
    </div>
    
    <div class="coupons">
        <p class="row">
            
        </p>
    </div>
</div>