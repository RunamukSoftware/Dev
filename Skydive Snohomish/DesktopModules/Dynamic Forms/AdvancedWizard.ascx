<%@ Control Inherits="DataSprings.Modules.DynamicForms.AdvancedWizard" CodeBehind="AdvancedWizard.ascx.vb"
    Language="vb" AutoEventWireup="false" Explicit="True" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register TagPrefix="dnn" Namespace="DotNetNuke.UI.WebControls" Assembly="DotNetNuke" %>
<asp:UpdatePanel ID="UpdatePanelWizard" runat="server">
    <contenttemplate>
        <asp:UpdateProgress ID="UpdateProgress2" runat="server" AssociatedUpdatePanelID="UpdatePanelWizard"> 
            <ProgressTemplate> 
               <asp:Image ID="imgProgress" runat="server" ImageUrl="~/desktopmodules/Dynamic Forms/Progress.gif" ></asp:Image>
            </ProgressTemplate> 
        </asp:UpdateProgress> 
        <p align="left">
            <asp:Literal ID="litHeader" runat="server"></asp:Literal>
        </p>
        <div class="dnnForm" id="formAdvancedWizard">
            <fieldset>
                <div class="dnnFormItem">
                    <dnn:Label id="lblWizardQuestions" runat="server" suffix=":"></dnn:Label>
                    <asp:LinkButton ID="lnkSelectUnSelectAll" ResourceKey="lnkSelectUnSelectAll" runat="server"></asp:LinkButton>
                    <br />
                    <asp:CheckBoxList runat="server" width="100%" ID="chkQuestions" CssClass="dnnFormRadioButtons"
                        RepeatColumns="3" RepeatLayout="Table" CellSpacing="6"></asp:CheckBoxList>&nbsp;
                </div>
                <div class="dnnFormItem">
                    <dnn:Label id="lblWizardActionTypes" runat="server" suffix=":"></dnn:Label>
                    <asp:DropDownList ID="cboActiontypes" AutoPostBack ="true" runat="server">
                        <asp:ListItem ResourceKey="SelectAction" Value="Select"></asp:ListItem>
			            <asp:ListItem ResourceKey="ShortFieldName" Value="ShortFieldName"></asp:ListItem>
                        <asp:ListItem ResourceKey="HelpText" Value="HelpText"></asp:ListItem>
                        <asp:ListItem ResourceKey="DefaultValue" Value="DefaultValue"></asp:ListItem>
                        <asp:ListItem ResourceKey="ExampleText" Value="ExampleText"></asp:ListItem>
                        <asp:ListItem ResourceKey="ClientSideEvent" Value="ClientSideEvent"></asp:ListItem>
                        <asp:ListItem ResourceKey="HideQuestionsFromRoles" Value="HideQuestionsFromRoles"></asp:ListItem>
                        <asp:ListItem ResourceKey="HideFromAnonymous" Value="HideFromAnonymous"></asp:ListItem>
                        <asp:ListItem ResourceKey="HideUntilForcedVisible" Value="HideUntilForcedVisible"></asp:ListItem>
                        <asp:ListItem ResourceKey="PassToQuerystring" Value="PassToQuerystring"></asp:ListItem>
                        <asp:ListItem ResourceKey="RetrieveFromQuerystring" Value="RetrieveFromQuerystring"></asp:ListItem>
                        <asp:ListItem ResourceKey="PassToSession" Value="PassToSession"></asp:ListItem>
                        <asp:ListItem ResourceKey="RetrieveFromSession" Value="RetrieveFromSession"></asp:ListItem>
                        <asp:ListItem ResourceKey="PassToCookie" Value="PassToCookie"></asp:ListItem>
                        <asp:ListItem ResourceKey="RetrieveFromCookie" Value="RetrieveFromCookie"></asp:ListItem>
                        <asp:ListItem ResourceKey="HideFromViewResults" Value="HideFromViewResults"></asp:ListItem>
                        <asp:ListItem ResourceKey="NoSave" Value="NoSave"></asp:ListItem>
                        <asp:ListItem ResourceKey="LabelCellClass" Value="LabelCellClass"></asp:ListItem>
                        <asp:ListItem ResourceKey="FieldClass" Value="FieldClass"></asp:ListItem>
                        <asp:ListItem ResourceKey="ColSpan" Value="ColSpan"></asp:ListItem>
                        <asp:ListItem ResourceKey="RowSpan" Value="RowSpan"></asp:ListItem>
                        <asp:ListItem ResourceKey="FieldWidth" Value="FieldWidth"></asp:ListItem>
                        <asp:ListItem ResourceKey="SameRow" Value="SameRow"></asp:ListItem>
                        <asp:ListItem ResourceKey="SameCell" Value="SameCell"></asp:ListItem>
                        <asp:ListItem ResourceKey="LabelFieldSameColumn" Value="LabelFieldSameColumn"></asp:ListItem>
                        <asp:ListItem ResourceKey="ShowHelpTextAsPopUp" Value="ShowHelpTextAsPopUp"></asp:ListItem>
                        <asp:ListItem ResourceKey="PopUpTextWidth" Value="PopUpTextWidth"></asp:ListItem>
                        <asp:ListItem ResourceKey="TextboxMaxLength" Value="TextboxMaxLength"></asp:ListItem>
                        <asp:ListItem ResourceKey="RequiredField" Value="RequiredField"></asp:ListItem>
                        <asp:ListItem ResourceKey="RequiredFieldText" Value="RequiredFieldText"></asp:ListItem>
                        <asp:ListItem ResourceKey="RequiredFieldErrorMessage" Value="RequiredFieldErrorMessage"></asp:ListItem>
                        <asp:ListItem ResourceKey="UseRegularExpression" Value="UseRegularExpression"></asp:ListItem>
                        <asp:ListItem ResourceKey="ReqularExpression" Value="RegularExpression"></asp:ListItem>
                        <asp:ListItem ResourceKey="RegularExpressionText" Value="RegularExpressionText"></asp:ListItem>
                        <asp:ListItem ResourceKey="UseSQLOptions" Value="UseSQLOptions"></asp:ListItem>
                        <asp:ListItem ResourceKey="SQLOptionsQuery" Value="SQLOptionsQuery"></asp:ListItem>
			            <asp:ListItem ResourceKey="DeleteField" Value="Delete"></asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="dnnFormItem">
                    <dnn:Label id="lblWizardActions" runat="server" suffix=":"></dnn:Label>
                    <asp:CheckBox ID="chkAction" runat="server"></asp:CheckBox>
                    <asp:CheckBoxList runat="server" ID="chkGroupActions" CssClass="dnnFormRadioButtons" 
                        RepeatColumns="3" RepeatLayout="Table" CellSpacing="6"></asp:CheckBoxList>
                    <asp:TextBox ID="txtOption1" runat="server" Width="272px"></asp:TextBox>
                </div>
            </fieldset>
            <ul class="dnnActions dnnClear">
                <li>
                    <asp:LinkButton ID="lnkWizard" runat="server" CssClass="dnnPrimaryAction"></asp:LinkButton>
                </li>
                <li>
                    <asp:LinkButton ID="lnkExit" runat="server" CssClass="dnnSecondaryAction"></asp:LinkButton>
                </li>
            </ul>
        </div>
    </contenttemplate>
</asp:UpdatePanel>
