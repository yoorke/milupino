<%@ Page Language="C#" MasterPageFile="~/administrator/adminPanel.Master" AutoEventWireup="true" CodeBehind="createUser.aspx.cs" Inherits="eshopv2.administrator.createUser" Title="Novi korisnik | Admin panel" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <%--<div id="topMenu">
    </div>
    
    <div id="mainContent">--%>
    <div id="page-wrapper">
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">Create user</h1>
        </div><!--col-->
    </div><!--row-->
    <div class="row">
        <div class="col-lg-5 col-md-5 col-sm-10 col-xs-12">
            <asp:CreateUserWizard ID="CreateUserWizard1" runat="server" OnCreatingUser="CreateUserWizard1_CreatingUser"
                CompleteSuccessText="Korisnik uspešno kreiran" ContinueButtonText="Nastavi" ContinueDestinationPageUrl="/administrator/users.aspx"
                CreateUserButtonText="Sačuvaj" OnLoad="CreateUserWizard1_Load" CssClass="table">
                <WizardSteps>
                    <asp:CreateUserWizardStep ID="CreateUserWizardStep1" runat="server">
                        <ContentTemplate>
                            <table border="0" class="table table-condensed table-bordered table-hover table-striped">
                                <tr>
                                    <td align="center" colspan="2">
                                        Novi korisnik</td>
                                </tr>
                                
                                <tr>
                                    <td align="right">
                                        <asp:Label ID="lblFirstName" runat="server" AssociatedControlID="txtFirstName">Ime:</asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="firstNameRequired" runat="server"
                                        ControlToValidate="txtFirstName" ErrorMessage="Morate uneti ime"
                                        ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                            
                                <tr>
                                    <td align="right">
                                        <asp:Label ID="lblLastName" runat="server" AssociatedControlID="txtLastName">Prezime:</asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtLastName" runat="server" CssClass="form-control"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="lastNameRequired" runat="server"
                                        ControlToValidate="txtLastName" ErrorMessage="Morate uneti prezime"
                                        ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                            
                                <tr>
                                    <td align="right">
                                        <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName">Username:</asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="UserName" runat="server" CssClass="form-control"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" 
                                            ControlToValidate="UserName" ErrorMessage="User Name is required." 
                                            ToolTip="Morate uneti username." ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">
                                        <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="Password">Šifra:</asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="Password" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" 
                                            ControlToValidate="Password" ErrorMessage="Morate uneti šifru." 
                                            ToolTip="Password is required." ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">
                                        <asp:Label ID="ConfirmPasswordLabel" runat="server" 
                                            AssociatedControlID="ConfirmPassword">Potvrda šifre:</asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="ConfirmPassword" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="ConfirmPasswordRequired" runat="server" 
                                            ControlToValidate="ConfirmPassword" 
                                            ErrorMessage="Confirm Password is required." 
                                            ToolTip="Confirm Password is required." ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">
                                        <asp:Label ID="EmailLabel" runat="server" AssociatedControlID="Email">E-mail:</asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="Email" runat="server" CssClass="form-control"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="EmailRequired" runat="server" 
                                            ControlToValidate="Email" ErrorMessage="E-mail is required." 
                                            ToolTip="E-mail is required." ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                            
                                <tr>
                                    <td align="right">
                                        <asp:Label ID="lblUserType" runat="server" AssociatedControlID="cmbUserType">Tip:</asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="cmbUserType" runat="server" CssClass="form-control"></asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="userTypeRequiredFieldValidator" runat="server" ControlToValidate="cmbUserType" ErrorMessage="Odaberite tip"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                            
                            <%--<tr>
                                    <td align="right">
                                        <asp:Label ID="lblAddress" runat="server" AssociatedControlID="txtAddress">Adresa:</asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtAddress" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="addressRequired" runat="server"
                                        ControlToValidate="txtAddress" ErrorMessage="Morate uneti adresu"
                                        ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                            
                                <tr>
                                    <td align="right">
                                        <asp:Label ID="lblCity" runat="server" AssociatedControlID="txtCity">Mesto:</asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtCity" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="cityRequired" runat="server"
                                        ControlToValidate="txtCity" ErrorMessage="Morate uneti mesto"
                                        ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                            
                                <tr>
                                    <td align="right">
                                        <asp:Label ID="lblPhone" runat="server" AssociatedControlID="txtPhone">Telefon:</asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtPhone" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="phoneRequired" runat="server"
                                        ControlToValidate="txtPhone" ErrorMessage="Morate uneti telefon"
                                        ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                            
                                <tr>
                                    <td align="right">
                                        <asp:Label ID="QuestionLabel" runat="server" AssociatedControlID="Question">Security Question:</asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="Question" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="QuestionRequired" runat="server" 
                                            ControlToValidate="Question" ErrorMessage="Security question is required." 
                                            ToolTip="Security question is required." ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">
                                        <asp:Label ID="AnswerLabel" runat="server" AssociatedControlID="Answer">Security Answer:</asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="Answer" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="AnswerRequired" runat="server" 
                                            ControlToValidate="Answer" ErrorMessage="Security answer is required." 
                                            ToolTip="Security answer is required." ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
                                    </td>
                                </tr>--%>
                                <tr>
                                    <td align="center" colspan="2">
                                        <asp:CompareValidator ID="PasswordCompare" runat="server" 
                                            ControlToCompare="Password" ControlToValidate="ConfirmPassword" 
                                            Display="Dynamic" 
                                            ErrorMessage="The Password and Confirmation Password must match." 
                                            ValidationGroup="CreateUserWizard1"></asp:CompareValidator>
                                    </td>   
                                </tr>
                                <tr>
                                    <td align="center" colspan="2" style="color:Red;">
                                        <asp:Literal ID="ErrorMessage" runat="server" EnableViewState="False"></asp:Literal>
                                    </td>
                                </tr>
                            </table>
                        </ContentTemplate>
                    </asp:CreateUserWizardStep>
                    <asp:CompleteWizardStep ID="CompleteWizardStep1" runat="server" Title="Uspešno">
                    </asp:CompleteWizardStep>
                </WizardSteps>
            </asp:CreateUserWizard>
        </div><!--col-->
    </div><!--row-->
    </div>
        
    <%--</div>--%>
</asp:Content>
