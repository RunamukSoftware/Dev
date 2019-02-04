<%@ Register TagPrefix="dnn" Namespace="DotNetNuke.UI.WebControls" Assembly="DotNetNuke" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Control Inherits="DataSprings.Modules.DynamicForms.SetupWizard" CodeBehind="SetupWizard.ascx.vb"
    Language="vb" AutoEventWireup="false" Explicit="True" %>
<asp:UpdatePanel ID="UpdatePanelWizard" runat="server">
    <ContentTemplate>
        <asp:UpdateProgress ID="UpdateProgress2" runat="server" AssociatedUpdatePanelID="UpdatePanelWizard">
            <ProgressTemplate>
                <asp:Image ID="imgProgress" runat="server" ImageUrl="~/desktopmodules/Dynamic Forms/Progress.gif">
                </asp:Image>
            </ProgressTemplate>
        </asp:UpdateProgress>
        <div class="dnnForm">
            <fieldset>
                <div class="dnnFormItem">
                    <asp:RadioButtonList ID="optType" runat="server" AutoPostBack="True" 
                        RepeatDirection="Vertical" CssClass="dnnFormRadioButtons">
                        <asp:ListItem Value="Standard" ResourceKey="StandardPanel"></asp:ListItem>
                        <asp:ListItem Value="Advanced" ResourceKey="AdvancedPanel"></asp:ListItem>
                        <asp:ListItem Value="ImportFromOtherPortals" ResourceKey="OtherPortals"></asp:ListItem>  
                        <asp:ListItem Value="DataSpringsRepository" ResourceKey="Repository"></asp:ListItem>  
                    </asp:RadioButtonList>
                </div>
                <div class="dnnFormItem">
                    <hr />
                </div>
                <div class="dnnFormItem" id="pnlBasic" runat="server">
                    <div class="dnnForm">
                        <fieldset>
                            <div class="dnnFormItem">
                                <asp:Literal ID="litHeader" runat="server"></asp:Literal>
                            </div>
                            <div class="dnnFormItem">
                                <dnn:Label ID="lblWizardQuestions" runat="server" Suffix=":"></dnn:Label>
                                <asp:CheckBoxList runat="server" ID="chkQuestions" RepeatColumns="4" RepeatLayout="Table"
                                    CssClass="dnnFormRadioButtons" CellSpacing="6">
                                </asp:CheckBoxList>
                            </div>
                            <div class="dnnFormItem">
                                <dnn:Label ID="lblWizardExtendedQuestions" runat="server" Suffix=":"></dnn:Label>
                                <asp:CheckBoxList runat="server" ID="chkExtendedQuestions" RepeatColumns="3" RepeatLayout="Table"
                                    CssClass="dnnFormRadioButtons" CellSpacing="6">
                                </asp:CheckBoxList>
                            </div>
                            <div class="dnnFormItem" id="trCurrentQuestions" runat="server">
                                <dnn:Label ID="lblCurrentQuestions" runat="server" Suffix=":"></dnn:Label>
                                <asp:CheckBoxList runat="server" ID="chkCurrentsQuestions" RepeatColumns="4" RepeatLayout="Table"
                                    CssClass="dnnFormRadioButtons" CellSpacing="6">
                                </asp:CheckBoxList>
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
                </div>
                <div class="dnnFormItem" id="pnlAdvanced" runat="server" visible="false">
                    <div class="dnnForm">
                        <fieldset>
                            <div class="dnnFormItem">
                                <asp:Literal ID="litHeaderAdvanced" runat="server"></asp:Literal>
                            </div>
                            <div class="dnnFormItem">
                                <dnn:Label ID="lblSQLStatement" runat="server" Suffix=":"></dnn:Label>
                                <asp:TextBox ID="txtSQLStatement" runat="server" CssClass="NormalTextBox" Height="300"
                                    TextMode="MultiLine"></asp:TextBox>
                            </div>
                            <div class="dnnFormItem">
                                <asp:LinkButton ID="lnkRunWizard" ResourceKey="RunQuery" runat="server" CssClass="dnnPrimaryAction"></asp:LinkButton>
                            </div>
                            <div class="dnnFormItem" id="trSQLQuestions" runat="server" visible="false">
                                <dnn:Label ID="lblQuestionsToGenerate" runat="server" Suffix=":"></dnn:Label>
                                <asp:CheckBox ID="chkSelectAll" runat="Server" AutoPostBack="True" ResourceKey="SelectDeSelectAll.Text">
                                </asp:CheckBox>
                                <br />
                                <asp:CheckBoxList runat="server" ID="chkQuestionsToGenerate" RepeatColumns="4" RepeatLayout="Table"
                                    CssClass="dnnFormRadioButtons" CellSpacing="6">
                                </asp:CheckBoxList>
                            </div>
                        </fieldset>
                        <ul class="dnnActions dnnClear">
                            <li>
                                <asp:LinkButton ID="lnkWizardGenerate" CssClass="dnnPrimaryAction" Enabled="False"
                                    ResourceKey="RunWizard" runat="server"></asp:LinkButton>
                            </li>
                            <li>
                                <asp:LinkButton ResourceKey="Exit" CssClass="dnnSecondaryAction" ID="lnkExit2" runat="server"></asp:LinkButton>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="dnnFormItem" id="pnlModules" runat="server" visible="false">
                    <div class="dnnForm">
                        <fieldset>
                            <div class="dnnFormItem">
                                <asp:Literal ID="litHeaderModules" runat="server"></asp:Literal>
                            </div>
                            <div class="dnnFormItem" id="trHost" runat="server" visible="false">
                                <dnn:label id="lblPortal" runat="server" suffix=":"></dnn:label>
                                <asp:DropDownList runat ="server" ID="cboPortals" AutoPostBack="True"></asp:DropDownList>
                            </div>
                            <div class="dnnFormItem">
                                <dnn:label id="lblModuleInstance" runat="server" suffix=":"></dnn:label>
                                <asp:DropDownList runat ="server" ID="cboModules" AutoPostBack="True"></asp:DropDownList>
                            </div>
                            <div class="dnnFormItem" id="trModuleQuestions" runat="server" visible="false">
                                <dnn:label id="lblQuestionsToGenerateFromModules" runat="server" suffix=":"></dnn:label>
                                <asp:checkbox id="chkSelectAllFromModules" Runat="Server" AutoPostBack="True" ResourceKey="SelectDeSelectAll.Text"></asp:checkbox>
                                <br />
                                <asp:CheckBoxList runat ="server" ID="chkQuestionsToGenerateFromModules" CssClass="dnnFormRadioButtons"
                                    RepeatColumns ="4" RepeatLayout ="Table"  CellSpacing="6"></asp:CheckBoxList>
                            </div>
                        </fieldset>
                        <ul class="dnnActions dnnClear">
                            <li>
                                <asp:LinkButton ID="lnkImportFields" Enabled="False" ResourceKey="RunWizard" runat="server" CssClass="dnnPrimaryAction"></asp:LinkButton>
                            </li>
                            <li>
                                <asp:LinkButton ResourceKey="Exit" ID="lnkExit3" runat="server" CssClass="dnnSecondaryAction"></asp:LinkButton>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="dnnFormItem" id="pnlRepository" runat="server" visible="false">
                    <div class="dnnForm">
                        <fieldset>
                            <div class="dnnFormItem">
                                <asp:Literal ID="litHeaderRepository" runat="server"></asp:Literal>
                            </div>
                            <div class="dnnFormItem">
                                <dnn:label id="lblRepositoryObjectType" runat="server" suffix=":"></dnn:label>
                                <asp:DropDownList runat ="server" ID="cboObjectType">
                                      <asp:ListItem Value="DynamicQuestion" ResourceKey="DynamicQuestion"></asp:ListItem>
		                        </asp:DropDownList>
                            </div>
                            <div class="dnnFormItem">
                                <dnn:label id="lblSearchRepositoryCategory" runat="server" suffix=":"></dnn:label>
                                <asp:DropDownList runat ="server" ID="cboRepositoryCategories"></asp:DropDownList>
                            </div>
                            <div class="dnnFormItem">
                                <dnn:label id="lblSearch" runat="server" suffix=":"></dnn:label>
                                <asp:Textbox runat ="server" ID="txtRepository" ></asp:Textbox>
                                
                            </div>
                            <div class="dnnFormItem">
                                <asp:LinkButton ID="lnkSearchRepository" ResourceKey="SearchRepository" runat="server" 
                                    CSSClass="dnnPrimaryAction">Search Repository</asp:LinkButton>
                            </div>
                            <div class="dnnFormItem" id="trRepositoryQuestions" runat="server" visible="false">
                                <hr />
                                The Datagrid of the items will go here....
                            </div>
                        </fieldset>
                        <ul class="dnnActions dnnClear">
                            <li>
                                <asp:LinkButton ID="lnkImportFieldsFromRepository" Enabled="False" 
                                    ResourceKey="RunWizard" runat="server" CSSClass="dnnPrimaryAction"></asp:LinkButton>
                            </li>
                            <li>
                                <asp:LinkButton ResourceKey="Exit" ID="lnkExit4" runat="server" CssClass="dnnSecondaryAction"></asp:LinkButton>
                            </li>
                        </ul>
                    </div>
                </div>
            </fieldset>
        </div>
    </ContentTemplate>
</asp:UpdatePanel>
