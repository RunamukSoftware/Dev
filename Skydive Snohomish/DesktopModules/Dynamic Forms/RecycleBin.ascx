<%@ Control Inherits="DataSprings.Modules.DynamicForms.RecycleBin" Language="vb"
    AutoEventWireup="false" Explicit="True" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register TagPrefix="dnn" Namespace="DotNetNuke.UI.WebControls" Assembly="DotNetNuke" %>
<asp:UpdatePanel ID="UpdatePanelRecycle" runat="server">
    <contenttemplate>
 <asp:UpdateProgress ID="UpdateProgress2" runat="server" AssociatedUpdatePanelID="UpdatePanelRecycle"> 
            <ProgressTemplate> 
               <asp:Image ID="imgProgress" runat="server" ImageUrl="~/desktopmodules/Dynamic Forms/Progress.gif" ></asp:Image>
                  
                     </ProgressTemplate> 
        </asp:UpdateProgress> 
        <div class="dnnForm">
            <fieldset>
                <div class="dnnFormItem">
                    <asp:Literal ID="litHeader" runat="server"></asp:Literal>
                </div>
                <div class="dnnFormItem">
                    <dnn:label id="lblWizardQuestions" runat="server" suffix=":"></dnn:label>
                    <asp:CheckBoxList runat="server" ID="chkQuestions" RepeatColumns="3" CssClass="dnnFormRadioButtons" RepeatLayout="Table" CellSpacing="6"></asp:CheckBoxList>
                </div>
                <div class="dnnFormItem">
                    <dnn:label id="lblCompletionEvents" runat="server" suffix=":"></dnn:label>
                    <asp:CheckBoxList runat="server" ID="chkCompletionEvents" RepeatColumns="3" CssClass="dnnFormRadioButtons" RepeatLayout="Table"
							CellSpacing="6"></asp:CheckBoxList>
                </div>
                <div class="dnnFormItem">
                    <dnn:label id="lblQuestionEvents" runat="server" suffix=":"></dnn:label>
                    <asp:CheckBoxList runat="server" ID="chkQuestionEvents" RepeatColumns="3" RepeatLayout="Table" CssClass="dnnFormRadioButtons"
							CellSpacing="6"></asp:CheckBoxList>
                </div>
            </fieldset>
            <ul class="dnnActions dnnClear">
                <li>
                    <asp:LinkButton ID="lnkUnDeleteObjects" CssClass="dnnPrimaryAction" resourcekey="RestoreObjects" runat="server"></asp:LinkButton>
                </li>
                <li>
                    <asp:LinkButton ID="lnkClearReycleBin" CssClass="dnnPrimaryAction" resourcekey="ClearRecycleBin"  runat="server"></asp:LinkButton>
                </li>
                <li>
                    <asp:LinkButton ID="lnkExit" CssClass="dnnPrimaryAction" resourcekey="Exit"  runat="server"></asp:LinkButton>
                </li>
            </ul>
        </div>

 </contenttemplate>
</asp:UpdatePanel>