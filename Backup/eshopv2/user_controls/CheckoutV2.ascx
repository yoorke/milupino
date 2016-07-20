<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CheckoutV2.ascx.cs" Inherits="eshopv2.user_controls.CheckoutV2" %>
<%@ Register src="CustomStatus.ascx" tagname="CustomStatus" tagprefix="uc1" %>
<div class="checkout">
    <a id="account" name="account"></a>
    <div class="row">
        <div class="col-lg-12">
            <uc1:CustomStatus ID="csStatus" runat="server" />
        </div><!--col-->
    </div><!--row-->
    <asp:Panel ID="pnlLogin" DefaultButton="btnLogin" runat="server">
        <div class="row margin-top-2">
            <div class="col-lg-10 col-lg-offset-1">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <span>Prijava</span>
                    </div><!--panel-heading-->
                    <div class="panel-body">
                        <div class="row text-center">
                            <span>Ukoliko već posedujete korisnički nalog, prijavite se sa svojim korisničkim imenom i šifrom.</span>
                        </div>
                        <div class="row margin-top-05">
                            <div class="col-lg-5">
                                <div role="form" class="form-horizontal">
                                    <div class="form-group">
                                        <label for="txtUsername" class="control-label col-sm-5">Korisničko ime:</label>
                                        <div class="col-sm-6">
                                            <asp:TextBox ID="txtUsername" runat="server"></asp:TextBox>
                                        </div>
                                    </div><!--form-group-->
                                </div><!--form-->
                            </div><!--col-->
                            <div class="col-lg-5">
                                <div role="form" class="form-horizontal">
                                    <div class="form-group">
                                        <label for="txtPassword" class="control-label col-sm-4">Šifra:</label>
                                        <div class="col-sm-8">
                                            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password"></asp:TextBox>
                                        </div>
                                    </div><!--form-group-->
                                </div><!--form-->
                            </div><!--col-->
                            <div class="col-lg-2">
                                <asp:Button ID="btnLogin" runat="server" Text="Prijavi se" OnClick="btnLogin_Click" CausesValidation="false" CssClass="btn btn-default" />
                            </div>
                        </div><!--row-->
                    </div><!--panel-body-->
                </div><!--panel-->
            </div><!--col-->
        </div><!--login-->
    </asp:Panel>
    <div class="row margin-top-2">
        <div class="col-lg-10 col-lg-offset-1">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <span>Podaci o dostavi</span>
                </div><!--panel-heading-->
                <div class="panel-body">
                    <div class="row">
                        <div class="col-lg-6">
                            <div role="form" class="form-horizontal">
                                <div class="form-group">
                                    <label for="rdbUserType" class="control-label col-sm-4">Tip kupca: </label>
                                    <div class="col-sm-8">
                                        <asp:RadioButtonList ID="rdbUserType" runat="server" RepeatColumns="2" RepeatDirection="Horizontal" RepeatLayout="Flow" CssClass="radio">
                                            <asp:ListItem Text="Fizičko lice" Value="1" onClick="userTypeChanged(this)" Selected="True"></asp:ListItem>
                                            <asp:ListItem Text="Pravno lice" Value="2" onClick="userTypeChanged(this)"></asp:ListItem>
                                        </asp:RadioButtonList>
                                    </div><!--col-->
                                </div><!--form-group-->
                            </div><!--form-->
                        </div><!--col-->
                    </div><!--row-->
                    <div class="row">
                        <div class="col-lg-6">
                            <div role="form" class="form-horizontal">
                                <div class="form-group">
                                    <label for="txtLastname" class="control-label col-sm-4">Prezime: </label>
                                    <div class="col-sm-8">
                                        <asp:TextBox ID="txtLastname" runat="server" CssClass="textbox"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="requiredFieldValidator1" runat="server" ControlToValidate="txtLastname" ErrorMessage="*"></asp:RequiredFieldValidator>
                                    </div><!--col-->
                                </div><!--form-group-->
                            </div><!--form-->
                        </div><!--col-->
                        <div class="col-lg-6">
                            <div role="form" class="form-horizontal">
                                <label for="txtFirstname" class="control-label col-sm-4">Ime: </label>
                                <div class="col-sm-8">
                                    <asp:TextBox ID="txtFirstname" runat="server" CssClass="textbox"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="requiredFiledValidator2" runat="server" ControlToValidate="txtFirstname" ErrorMessage="*"></asp:RequiredFieldValidator>
                                </div><!--col-->
                            </div><!--form-->
                        </div><!--col-->
                        
                    </div><!--row-->
                    <div class="row">
                        <div class="col-lg-6">
                            <div role="form" class="form-horizontal">
                                <div class="form-group">
                                    <label for="txtEmail" class="control-label col-sm-4">Email: </label>
                                    <div class="col-sm-8">
                                        <asp:TextBox ID="txtEmail" runat="server" CssClass="textbox"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="requiredFieldValidator3" runat="server" ControlToValidate="txtEmail" ErrorMessage="*" Display="Dynamic"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="regularExpressionValidator1" runat="server" ControlToValidate="txtEmail" ErrorMessage="*" ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ToolTip="Email adresa nije u odgovarajućem formatu" Display="Dynamic"></asp:RegularExpressionValidator>
                                    </div><!--col-->
                                </div><!--form-group-->
                            </div><!--form-->
                        </div><!--col-->
                    </div><!--row-->
                    <div class="row" id="divCompany" style="display:none">
                        <div class="col-lg-6">
                            <div role="form" class="form-horizontal">
                                <div class="form-group">
                                    <label for="txtCompanyName" class="control-label col-sm-4">Naziv: </label>
                                    <div class="col-sm-8">
                                        <asp:TextBox ID="txtCompanyName" runat="server" CssClass="textbox" Text="0"></asp:TextBox>
                                        <%--<asp:CustomValidator ID="customValidator1" runat="server" ClientValidationFunction="companyNameValidation" ErrorMessage="*" ValidateEmptyText="true" ControlToValidate="txtCompanyName" EnableClientScript="true"></asp:CustomValidator>--%>
                                        <asp:RequiredFieldValidator ID="requiredFieldValidator8" ControlToValidate="txtCompanyName" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>
                                    </div><!--col-->
                                </div><!--form-group-->
                            </div><!--form-->
                        </div><!--col-->
                        <div class="col-lg-6">
                            <div role="form" class="form-horizontal">
                                <div class="form-group">
                                    <label for="txtPib" class="control-label col-sm-4">PIB: </label>
                                    <div class="col-sm-8">
                                        <asp:TextBox ID="txtPib" runat="server" Text="0"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="requiredFieldValidator9" ControlToValidate="txtPib" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>
                                    </div><!--col-->
                                </div><!--form-group-->
                            </div><!--form-group-->
                        </div><!--col-->
                    </div><!--row-->
                    <div class="row">
                        <div class="col-lg-6">
                            <div role="form" class="form-horizontal">
                                <div class="form-group">
                                    <label for="txtAddress" class="control-label col-sm-4">Adresa: </label>
                                    <div class="col-sm-8">
                                        <asp:TextBox ID="txtAddress" runat="server" CssClass="textbox"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="requiredFieldValidator4" runat="server" ControlToValidate="txtAddress" ErrorMessage="*"></asp:RequiredFieldValidator>
                                    </div><!--col-->
                                </div><!--form-group-->
                            </div><!--form-->
                        </div><!--col-->
                    </div><!--row-->
                    <div class="row">
                        <div class="col-lg-6">
                            <div for="form" class="form-horizontal">
                                <div class="form-group">
                                    <label for="txtCity" class="control-label col-sm-4">Mesto: </label>
                                    <div class="col-sm-8">
                                        <asp:TextBox ID="txtCity" runat="server" CssClass="textbox"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="requiredFieldValidator5" runat="server" ControlToValidate="txtCity" ErrorMessage="*"></asp:RequiredFieldValidator>
                                    </div><!--col-->
                                </div><!--form-group-->
                            </div><!--col-->
                        </div>
                        <div class="col-lg-6">
                            <div role="form" class="form-horizontal">
                                <div class="form-group">
                                    <label for="txtZip" class="control-label col-sm-4">Ptt: </label>
                                    <div class="col-sm-8">
                                        <asp:TextBox ID="txtZip" runat="server" CssClass="textbox"></asp:TextBox>
                                        <asp:RegularExpressionValidator ID="regularExpressionValidator2" runat="server" ControlToValidate="txtZip" ErrorMessage="*" ValidationExpression="^\d{5}$"></asp:RegularExpressionValidator>
                                        <asp:RequiredFieldValidator ID="requiredFiledValidator6" runat="server" ControlToValidate="txtZip" ErrorMessage="*"></asp:RequiredFieldValidator>                                    
                                    </div><!--col-->
                                </div><!--form-group-->
                            </div><!--form-->
                        </div><!--col-->
                    </div><!--row-->
                    <div class="row">
                        <div class="col-lg-6">
                            <div role="form" class="form-horizontal">
                                <div class="form-group">
                                    <label for="txtPhone" class="control-label col-sm-4">Telefon: </label>
                                    <div class="col-sm-8">
                                        <asp:TextBox ID="txtPhone" runat="server" CssClass="textbox"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="requiredFieldValidator7" runat="server" ControlToValidate="txtPhone" ErrorMessage="*"></asp:RequiredFieldValidator>
                                    </div>
                                </div><!--form-group-->
                            </div><!--form-->
                        </div><!--col-->
                    </div><!--row-->
                    <div class="row" id="divCompanyPayment" style="display:none">
                        <div class="col-lg-8">
                            <div role="form" class="form-horizontal">
                                <div class="form-group">
                                    <label for="rdbPaymentCompany" class="control-label col-sm-3">Način plaćanja:</label>
                                    <div class="col-sm-9">
                                        <asp:RadioButtonList ID="rdbPaymentCompany" runat="server" RepeatColumns="2" RepeatDirection="Horizontal" RepeatLayout="Flow" CssClass="radio">
                                            <asp:ListItem Text="Gotovina" Value="1"></asp:ListItem>
                                            <asp:ListItem Text="Virman" Value="2" Selected="True"></asp:ListItem>
                                        </asp:RadioButtonList>
                                    </div>
                                </div><!--form-group-->
                            </div><!--form-->
                        </div><!--col-->
                    </div><!--row-->
                    <div class="row" id="divPersonPayment">
                        <div class="col-lg-8">
                            <div role="form" class="form-horizontal">
                                <div class="form-group">
                                    <label for="rdbPayment" class="control-label col-sm-3">Način plaćanja:</label>
                                    <div class="col-sm-9">
                                        <asp:RadioButtonList ID="rdbPayment" runat="server" RepeatColumns="3" RepeatDirection="Horizontal" RepeatLayout="Flow" CssClass="radio">
                                            <asp:ListItem Text="Gotovina" Value="1" Selected="True"></asp:ListItem>
                                            <asp:ListItem Text="Čekovima" Value="3"></asp:ListItem>
                                            <asp:ListItem Text="Uplatnica" Value="4"></asp:ListItem>
                                        </asp:RadioButtonList>
                                    </div><!--col-->
                                </div><!--form-group-->
                            </div><!--form-->
                        </div><!--col-->
                    </div><!--row-->
                    <div class="row">
                        <div class="col-lg-8">
                            <div role="form" class="form-horizontal">
                                <div class="form-group">
                                    <label for="rdbDelivery" class="control-label col-sm-3">Način preuzimanja: </label>
                                    <div class="col-sm-9">
                                        <asp:RadioButtonList ID="rdbDelivery" runat="server" RepeatColumns="2" RepeatDirection="Horizontal" RepeatLayout="Flow" CssClass="radio">
                                            <asp:ListItem Text="Lično" Value="1" Selected="True"></asp:ListItem>
                                            <asp:ListItem Text="Dostava kurirskom službom" Value="2"></asp:ListItem>
                                        </asp:RadioButtonList>
                                    </div><!--col-->
                                </div><!--form-group-->
                            </div><!--form-->
                        </div><!--col-->
                    </div><!--row-->
                    <div class="row">
                        <div class="col-lg-6">
                            <div role="form" class="form-horizontal">
                                <div class="form-group">
                                    <label for="txtRemark" class="control-label col-sm-4">Napomena: </label>
                                    <div class="col-sm-8">
                                        <asp:TextBox ID="txtRemark" runat="server" TextMode="MultiLine" Height="50px" Width="450px"></asp:TextBox>
                                    </div>
                                </div><!--form-group-->
                            </div><!--form-->
                        </div><!--col-->
                    </div><!--row-->
                    <div class="row">
                        <div class="col-lg-6">
                            <div role="form" class="form-horizontal">
                                <div class="form-group">
                                    <label for="chkCreateAccount" class="control-label col-sm-4"></label>
                                    <div class="col-sm-8">
                                        <asp:CheckBox ID="chkCreateAccount" runat="server" Text="Kreiraj korisnički nalog" Checked="true" CssClass="checkbox" />
                                    </div>
                                </div>
                            </div><!--form-->
                        </div><!--col-->
                    </div><!--row-->
                    <div class="row">
                        <div class="col-lg-12">
                            <p class="small">
                                Kreiranjem korisničkog naloga dobijate mogućnost praćenja statusa vaše narudžbine, kao i uvid u sve prošle
                                narudžbine. Takođe, prilikom svake sledeće narudžbine podaci neophodni za dostavu će automatski biti popunjeni.
                            </p>    
                        </div><!--col-->
                    </div><!--row-->
                    <div class="row">
                        <div class="col-lg-12">
                            <asp:LinkButton ID="btnBack" runat="server" Text="Vrati se na korpu" CssClass="btn btn-default" OnClick="btnBack_Click" CausesValidation="false"></asp:LinkButton>
                            <asp:LinkButton ID="btnOrder" runat="server" Text="Naruči" CssClass="btn btn-default pull-right" OnClick="btnOrder_Click"></asp:LinkButton>
                        </div><!--col-->
                    </div><!--row-->
                </div><!--panel-body-->
            </div><!--panel-->
       </div><!--col-->
   </div><!--row-->
</div><!--checkout-->
                    
                    
                                <!--<div class="form-group">-->
                                    
                                <!--</div>--><!--form-group-->
                                
                                
                            <!--</div>--><!--form-->
                        <!--</div>--><!--col-->
                    <!--</div>--><!--row-->
                    <!--<div class="row">-->
                    <!--</div>--><!--row-->
                    <!--<div class="row">-->
                    <!--</div>--><!--row-->
                    <!--<div class="row">-->
                    <!--</div>--><!--row-->
                <!--</div>--><!--panel-body-->
            <!--</div>--><!--panel-->
        <!--</div>--><!--col-->
    <!--</div>--><!--row-->
                    
                    <!--<div class="column column600">
                        <p class="row">
                            
                        </p>
                        <p class="row">
                            
                            
                        </p>
            
                        <p class="row">
                            
                
                
                        </p>
            
                        <div class="group" id="divCompany" style="display:none">
                            <p class="row">
                                
                                
                            </p>
                        </div>
                        <div class="group"><%--</div>--%>
                        <p class="row">
                            
                        </p>
                        <p class="row">
                            
                            
                        </p>
                        </div>
                        <p class="row">
                            
                        </p>
                        
                        
                        
                        <div id="divCompanyPayment" style="display:none">
                            <p class="row">
                                
                            </p>
                        </div>
                        <div id="divPersonPayment" style="display:block">
                            <p class="row">
                                
                            </p>
                        </div>
                        <p class="row">
                            
                        </p>
                        
                        
                        <p class="row">
                            
                        </p>
                        <p class="row">
                            
                        </p>
                        
                        
                        
                        <div class="buttons">
                            
                        </div>
                        
                    </div>
                
</div>-->
<script type="text/javascript">
    function userTypeChanged(radioButton) {
        //var divCompany = document.getElementById("divCompany");
        if (radioButton.value == 2) {
            document.getElementById("divCompany").style.display = "block";
            document.getElementById("ctl00_ContentPlaceHolder1_checkout1_txtCompanyName").value = "";
            document.getElementById("ctl00_ContentPlaceHolder1_checkout1_txtPib").value = "";
            document.getElementById("divCompanyPayment").style.display = "block";
            document.getElementById("divPersonPayment").style.display = "none";
        }
        //divCompany.style = "display:block;";
        else {
            document.getElementById("divCompany").style.display = "none";
            document.getElementById("ctl00_ContentPlaceHolder1_checkout1_txtCompanyName").value = "fizicko lice";
            document.getElementById("ctl00_ContentPlaceHolder1_checkout1_txtPib").value = "000000000";
            document.getElementById("divCompanyPayment").style.display = "none";
            document.getElementById("divPersonPayment").style.display = "block";
        }
    }
</script>

<script language="javascript">
    function companyNameValidation(oSrc, args) {
        var radioButton = document.getElementById("ctl00_ContentPlaceHolder1_checkout1_rdbUserType_1");
        var textbox = document.getElementById("ctl00_ContentPlaceHolder1_checkout1_txtCompanyName");

        if (radioButton.checked) {
            if (textbox.value == "") {
                args.isValid = false;
                alert("false");
            }
            else
                args.isValid = true;
        }
        else
            args.isValid = true;
    }
</script>