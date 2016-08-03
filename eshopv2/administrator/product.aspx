<%@ Page Language="C#" MasterPageFile="~/administrator/adminPanel.Master" AutoEventWireup="true" CodeBehind="product.aspx.cs" Inherits="eshopv2.administrator.product" Title="Proizvod | Admin panel" ValidateRequest="false" %>
<%@ Reference Control="customControls/AttributeControl.ascx" %>
<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="page-wrapper">
    
    
        <!--PANEL POPUP-->
        <ajaxtoolkit:ToolkitScriptManager ID="ToolKitScriptManager1" runat="server" EnablePartialRendering="true"></ajaxtoolkit:ToolkitScriptManager>
        <div>
            <asp:Panel ID="pnlAddAttributeValue" runat="server" CssClass="popup">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="form-group">
                            <label for="txtAttributeValue">Vrednost: </label>
                            <asp:TextBox ID="txtAttributeValue" runat="server" CssClass="form-control"></asp:TextBox>
                        </div><!--form-group-->
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-12 text-center">
                        <asp:Button ID="btnAddAttributeValue" runat="server" Text="Sačuvaj" OnClick="btnAddAttributeValue_Click" CssClass="btn btn-primary" />
                        <asp:Button ID="btnCancelPopup" runat="server" Text="Odustani" CssClass="btn btn-primary"  />
                    </div><!--col-->
                </div><!--row-->
            </asp:Panel>
        </div>
        
        <!--MODAL EXTENDER-->
        <ajaxtoolkit:ModalPopupExtender ID="modalExtender" runat="server" PopupControlID="pnlAddAttributeValue"
            TargetControlID="lnkShowPopup" DropShadow="true" BackgroundCssClass="modalBackground" CancelControlID="btnCancelPopup"
            PopupDragHandleControlID="pnlAddAttributeValue"></ajaxtoolkit:ModalPopupExtender>
        <asp:LinkButton ID="lnkShowPopup" runat="server"></asp:LinkButton>
        <asp:HiddenField ID="lblAttributeID" runat="server" />
        <asp:HiddenField ID="lblAttributeName" runat="server" />
        <asp:HiddenField ID="lblType" runat="server" />
        <asp:HiddenField ID="lblProductID" runat="server" />
        
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">Proizvod</h1>
            </div><!--col-->
        </div><!--row-->
        <div class="row">
            <div class="col-lg-12">
                <div class="btn-group">
                    <asp:Button ID="btnSave" runat="server" Text="Sačuvaj" OnClick="btnSave_Click" CssClass="btn btn-primary" />
                    <asp:Button ID="btnSaveClose" runat="server" Text="Sačuvaj i zatvori" OnClick="btnSaveClose_Click" CssClass="btn btn-primary" />
                    <asp:Button ID="btnClose" runat="server" Text="Zatvori" OnClick="btnClose_Click" CssClass="btn btn-primary" />
                </div><!--btn-group-->
            </div><!--col-->
        </div><!--row-->
        <div class="row">
            <div class="col-lg-12">
                <asp:Label ID="lblStatus" runat="server" Visible="false"></asp:Label>
            </div><!--col-->
        </div><!--row-->
        <div class="row margin-top-05">
            <div class="col-lg-12">
                <asp:HiddenField ID="TabName" runat="server" />
                <ul class="nav nav-tabs" id="tabs" data-tabs="tabs">
                    <li class="active"><a href="#product" data-toggle="tab">Proizvod</a></li>
                    <li><a href="#images" data-toggle="tab">Slike</a></li>
                    <li><a href="#categories" data-toggle="tab">Kategorije</a></li>
                    <li><a href="#promotions" data-toggle="tab">Promocije</a></li>
                    <li><a href="#specification" data-toggle="tab">Specifikacija</a></li>
                </ul><!--tabs-->
                <div id="tab-content" class="tab-content">
                    <div class="tab-pane active" id="product">
                        <div class="row">
                            <div class="col-lg-6">
                                <div role="form">
                                    <div class="form-group">
                                        <label for="txtCode">Šifra:</label>
                                        <asp:TextBox ID="txtCode" runat="server" CssClass="form-control"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="requiredFiledValidator1" runat="server" ControlToValidate="txtCode" Display="Dynamic"></asp:RequiredFieldValidator>
                                    </div><!--form-group-->
                                    <div class="form-group">
                                        <label for="txtEan">Ean:</label>
                                        <asp:TextBox ID="txtEan" runat="server" CssClass="form-control"></asp:TextBox>                
                                    </div><!--form-group-->
                                    <div class="form-group">
                                        <label for="cmbSupplier">Dobavljač:</label>
                                        <div class="input-group">
                                            <asp:DropDownList ID="cmbSupplier" runat="server" CssClass="form-control"></asp:DropDownList>
                                            <span class="input-group-addon"><i class="glyphicon glyphicon-plus cursor-pointer" onclick="ShowModalPopupSupplier();return false;"></i></span>
                                            <%--<asp:ImageButton ID="btnAddSupplier" runat="server" ImageUrl="../images/add_icon.png" OnClientClick="ShowModalPopupSupplier();return false;" />--%>
                                        </div>
                                    </div><!--form-group-->
                                    <div class="form-group">
                                        <label for="txtSupplierCode">Šifra dobavljača:</label>
                                        <asp:TextBox ID="txtSupplierCode" runat="server" CssClass="form-control"></asp:TextBox>                
                                    </div><!--form-group-->
                                    <div class="form-group">
                                        <label for="cmbBrand">Proizvođač:</label>
                                        <div class="input-group">
                                            <asp:DropDownList ID="cmbBrand" runat="server" CssClass="form-control"></asp:DropDownList>
                                            <span class="input-group-addon"><i class="glyphicon glyphicon-plus cursor-pointer" onclick="ShowModalPopupManufacturer();return false;"></i></span>
                                        </div>
                                        <%--<asp:ImageButton ID="btnAddManufacturer" runat="server" ImageUrl="../images/add_icon.png" OnClientClick="ShowModalPopupManufacturer();return false;" />--%>
                                    </div><!--form-group-->
                                    <div class="form-group">
                                        <label role="txtName">Naziv:</label>
                                        <asp:TextBox ID="txtName" runat="server" CssClass="form-control"></asp:TextBox>                
                                        <asp:RequiredFieldValidator ID="requiredFieldValidator2" runat="server" ControlToValidate="txtName" Display="Dynamic"></asp:RequiredFieldValidator>
                                    </div><!--form-group-->
                                    <div class="form-group">
                                        <label for="txtDescription">Opis:</label>
                                        <%--<asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" CssClass="form-control"></asp:TextBox>--%>
                                        <CKEditor:CKEditorControl ID="txtDescription" runat="server" BasePath="/ckeditor" Height="300px" CssClass="form-control"></CKEditor:CKEditorControl>
                                    </div><!--form-group-->
                                </div><!--form-->
                            </div><!--col-->
                            <div class="col-lg-6">
                                <div class="row">
                                    <div class="col-lg-12 text-right">
                                        <asp:Image ID="imgProduct" runat="server" ToolTip="Main" Height="50px" />
                                        <asp:Image ID="imgLarge" runat="server" ToolTip="Large" Height="50px" />
                                        <asp:Image ID="imgHome" runat="server" ToolTip="Home" Height="50px" />
                                        <asp:Image ID="imgThumb" runat="server" ToolTip="Thumb" Height="50px" />
                                    </div>
                                </div>
                                <div role="form">
                                    <div class="form-group">
                                        <label for="txtPrice">Cena:</label>
                                        <asp:TextBox ID="txtPrice" runat="server" CssClass="form-control text-right"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="requiredFieldValidator3" runat="server" ControlToValidate="txtPrice" Display="Dynamic"></asp:RequiredFieldValidator>
                                    </div><!--form-group-->
                                    <div class="form-group">
                                        <label for="txtWebPrice">Web cena:</label>
                                        <asp:TextBox ID="txtWebPrice" runat="server" CssClass="form-control text-right"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="requiredFieldValidator4" runat="server" ControlToValidate="txtWebPrice" Display="Dynamic"></asp:RequiredFieldValidator>
                                    </div><!--form-group-->
                                    <div class="form-group">
                                        <label for="cmbVat">PDV:</label>
                                        <div class="input-group">
                                            <asp:DropDownList ID="cmbVat" runat="server" CssClass="form-control text-right"></asp:DropDownList>
                                            <span class="input-group-addon"><i>%</i></span>
                                        </div>
                                    </div><!--form-group-->
                                    <div class="form-group">
                                        <label for="txtInsertDate">Datum unosa:</label>
                                        <asp:TextBox ID="txtInsertDate" runat="server" Enabled="false" CssClass="form-control"></asp:TextBox>
                                    </div><!--form-group-->
                                    <div class="form-group">    
                                        <label for="txtUpdateDate">Datum izmene:</label>
                                        <asp:TextBox ID="txtUpdateDate" runat="server" Enabled="false" CssClass="form-control"></asp:TextBox>
                                    </div><!--form-group-->
                                </div><!--form-->
                            </div><!--col-->
                        </div><!--row-->
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="form-group">
                                        <asp:CheckBox ID="chkApproved" runat="server" Text="Odobren" CssClass="checkbox" />
                                        <asp:CheckBox ID="chkActive" runat="server" Text="Aktivan" CssClass="checkbox" />
                                        <asp:CheckBox ID="chkLocked" runat="server" Text="Zaključan" CssClass="checkbox" />
                                        <asp:CheckBox ID="chkInStock" runat="server" Text="Na stanju" CssClass="checkbox" />
                                    </div><!--form-group-->
                                </div><!--col-->
                        </div><!--row-->
                    </div><!--tab-pane-->
                    <div class="tab-pane" id="images">
                        <div class="row">
                            <div class="col-lg-5">
                                <asp:Repeater ID="rptImages" runat="server" OnItemCommand="rptImages_ItemCommand" OnItemDataBound="rptImages_ItemDataBound">
                                    <ItemTemplate>
                                        <div class="productImage">
                                  
                                            <asp:Image ID="imgProduct" runat="server" ImageUrl='<%#Container.DataItem %>' Width="50px" Height="50px" BorderStyle="Solid" />
                                            <asp:Label ID="lblImageUrl" runat="server" Text='<%# Container.DataItem %>' CssClass="imageUrl"></asp:Label>
                                            <asp:LinkButton ID="btnDelete" CommandName="delete" runat="server" Text="Obriši"></asp:LinkButton>
                                        </div><!--productImage-->
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div><!--col-->
                        </div><!--row-->
                        <div class="row margin-top-05">
                            <div class="col-lg-5">
                                <asp:FileUpload ID="fluImage" runat="server" />
                           </div><!--col-->
                        </div><!--row-->
                        <div class="row margin-top-05">
                            <div class="col-lg-5">
                                <asp:Button ID="btnImageUpload" runat="server" Text="Dodaj" OnClick="btnImageUpload_Click" CssClass="btn btn-primary" />
                            </div><!--col-->
                        </div><!--row-->
                    </div><!--tab-pane-->
                    <div class="tab-pane" id="categories">
                        <div class="row">
                            <div class="col-lg-5">
                                <div role="form">
                                    <div class="form-group">
                                        <label for="cmbCategory">Kategorija:</label>
                                        <asp:DropDownList ID="cmbCategory" runat="server" OnSelectedIndexChanged="cmbCategory_SelectedIndexChanged" AutoPostBack="true" CssClass="form-control"></asp:DropDownList>
                                    </div><!--form-group-->
                                </div><!--form-->
                            </div><!--col-->
                        </div><!--row-->
                        <div class="row">
                            <div class="col-lg-12">
                                <asp:Panel ID="pnlAttributes" runat="server">
                                    <div role="form">
                                        
                                    </div><!--form-->
                                </asp:Panel>            
                            </div><!--col-->
                        </div><!--row-->
                    </div><!--tab-pane-->
                    <div class="tab-pane" id="promotions">
                        <div class="row">
                            <div class="col-lg-5">
                                <div role="form">
                                    <div class="form-group">
                                        <label for="cmbPromotions">Promocija: </label>
                                        <asp:DropDownList ID="cmbPromotions" runat="server" OnSelectedIndexChanged="cmbPromotions_SelectedIndexChanged" CssClass="form-control"></asp:DropDownList>
                                    </div><!--form-control-->
                                    <div class="form-group">
                                        <label for="txtPromotionPrice">Cena: </label>
                                        <div class="input-group">
                                            <asp:TextBox ID="txtPromotionPrice" runat="server" CssClass="form-control"></asp:TextBox>
                                            <span class="input-group-addon">din</span>
                                        </div>
                                        <asp:RangeValidator ID="rangeValidator1" runat="server" ControlToValidate="txtPromotionPrice" MinimumValue="1" MaximumValue="100000" ErrorMessage="Morate uneti numeričku vrednost." Type="Integer"></asp:RangeValidator>
                                    </div><!--form-control-->
                                </div><!--form-->
                                <%--<asp:Button ID="btnClearPromotion" runat="server" Text="Obriši sa promocije" OnClick="btnClearPromotion_Click" />--%>
                            </div><!--col-->
                        </div><!--row-->
                    </div><!--tab-pane-->
                    <div class="tab-pane" id="specification">
                        <div class="row">
                            <div class="col-lg-12">
                                <asp:TextBox ID="txtSpecification" runat="server" TextMode="MultiLine" Width="400px" Height="500px" CssClass="form-control"></asp:TextBox>
                            </div><!--col-->
                        </div><!--row-->
                    </div><!--tab-pane-->
                </div><!--tab-content-->
            </div><!--col-->
        </div><!--row-->
    </div><!--page-wrapper-->
    
    <%--<div id="topMenu">
        
    </div>
    
    <div id="mainContent">
        
        
        
        
        <div>
                        
                        
                        
                    </div>
        
        <ajaxtoolkit:TabContainer ID="TabContainer1" runat="server" Width="900px">
            <ajaxtoolkit:TabPanel ID="TabPanel1" HeaderText="Proizvod" runat="server">
                <ContentTemplate>
                
                    
                    
                    <p class="row">
                        
                    </p>
                    
                    <p class="row">
                        
                    </p>
                    
                    <p class="row">
                        
                    </p>
                    
                    <p class="row">
                        
                        
                    </p>
                    
                    <p class="row">
                        
                    </p>
                    
                    <p class="row">
                        
                    </p>
                    
                    <p class="row">
                        
                    </p>
                    
                    <p class="row">
                        
                    </p>
                    
                    <p class="row">
                        
                    </p>
                    
                    <p class="row">
                        
                    </p>
                    
                    <p class="row">
                        
                    </p>
                    
                    <p class="row">
                        
                    </p>
                    
                    <p class="row">
                        
                    </p>
                    
                    <p class="row">
                        
                    </p>
                    
                </ContentTemplate>
            </ajaxtoolkit:TabPanel>
            
            <ajaxtoolkit:TabPanel ID="tbpImages" runat="server" HeaderText="Slike">
                <ContentTemplate>
                    
                    <div id="productImages">
                    
                    </div>

                    <p class="row">
                        
                    </p>
                </ContentTemplate>
            </ajaxtoolkit:TabPanel>
            
            <ajaxtoolkit:TabPanel ID="tbpCategories" runat="server" HeaderText="Kategorije">
                <ContentTemplate>
                    <p class="row">
                        
                    </p>
                    
                    
                    
                    
                    
                </ContentTemplate>
            </ajaxtoolkit:TabPanel>
            
            <ajaxtoolkit:TabPanel ID="tbpPromotions" runat="server" HeaderText="Promocije">
                <ContentTemplate>
                    <p class="row">
                        
                    </p>
                    
                    <p class="row">
                        
                    </p>
                </ContentTemplate>
            </ajaxtoolkit:TabPanel>
            
            <ajaxtoolkit:TabPanel ID="tbpSpecification" runat="server" HeaderText="Specifikacija">
                <ContentTemplate>
                    
                </ContentTemplate>
            </ajaxtoolkit:TabPanel>
        </ajaxtoolkit:TabContainer>
    
    
        
        
        
    </div>--%>
<script type="text/javascript">
    var modalPopup = '<%= modalExtender.ClientID %>';
    function ShowModalPopup(id) {
        var lblAttributeID = document.getElementById('<%=lblAttributeID.ClientID %>');
        var hiddenID = id.toString().substring(0, 39) + '_lblAttributeID';
        var hidden = document.getElementById(hiddenID);
        //alert(hidden);
        lblAttributeID.value = hidden.value;
        var attributeName = document.getElementById('<%=lblAttributeName.ClientID %>');
        //alert(attributeName);
        attributeName.value = id.toString().substring(54, 67);
        //alert(lblAttributeID.value);
        var type = document.getElementById('<%=lblType.ClientID %>');
        type.value = 'attribute';
        var txtAttributeValue = document.getElementById('<%=txtAttributeValue.ClientID %>');

        $find(modalPopup).show();
        txtAttributeValue.focus();
        return false;
    }
    </script>
<script type="text/javascript">
    var modalPopup = '<%= modalExtender.ClientID  %>';
    function ShowModalPopupSupplier() {
        var type = document.getElementById('<%=lblType.ClientID  %>');
        type.value = 'supplier';
        $find(modalPopup).show();
        var txtAttributeValue = document.getElementById('<%=txtAttributeValue.ClientID %>');
        txtAttributeValue.focus();
        return false;
    }
</script>
<script type="text/javascript">
    var modalPopup = '<%= modalExtender.ClientID %>';
    function ShowModalPopupManufacturer() {
        var type = document.getElementById('<%=lblType.ClientID %>');
        type.value = 'brand';
        $find(modalPopup).show();
        txtAttributeValue = document.getElementById('<%=txtAttributeValue.ClientID %>');
        txtAttributeValue.focus();
        return false;
    }
</script>

</asp:Content>
<asp:Content ID="content3" runat="server" ContentPlaceHolderID="ContentPlaceHolderFooter">
<script type="text/javascript">
    $(function() {
        var tabName = $("[id*=TabName]").val() != "" ? $("[id*=TabName]").val() : "product";
        $('#tabs a[href="#' + tabName + '"]').tab('show');
        $("#tabs a").click(function() {
            $("[id*=TabName]").val($(this).attr("href").replace("#", ""));
        });
    });
</script>
</asp:Content>