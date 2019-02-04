<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="LabelControl.ascx.vb"
    Inherits="DataSprings.Modules.DynamicForms.DSLabelControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="dnn" Assembly="DotNetNuke" Namespace="DotNetNuke.UI.WebControls" %>
<%@ Register TagPrefix="dnn" Namespace="DotNetNuke.UI.WebControls" Assembly="DotNetNuke.WebControls" %>
<label id="label" runat="server">
    <asp:LinkButton ID="cmdHelp" TabIndex="-1" runat="server" CausesValidation="False">
        <asp:Image ID="imgHelp" TabIndex="-1" runat="server" ImageUrl="~/images/help.gif">
        </asp:Image>
    </asp:LinkButton>
    <asp:Label ID="lblUserLabel" runat="server" EnableViewState="False"></asp:Label>
</label>
<dnn:dnnlabeledit id="lblLabel" runat="server" cssclass="Normal" enableviewstate="False"
    mouseovercssclass="LabelEditOverClassML" labeleditcssclass="LabelEditTextClass"
    editenabled="True" multiline="True" richtextenabled="False" toolbarid="tbDynamicF"
    renderasdiv="True" eventname="none" lostfocussave="False" callbacktype="ProcessPage"
    clientapiscriptpath="" labeleditscriptpath="" workcssclass=""></dnn:dnnlabeledit>
<dnn:dnntoolbar id="tbDynamicF" runat="server" cssclass="eipbackimg" reusetoolbar="true"
    defaultbuttoncssclass="eipbuttonbackimg" defaultbuttonhovercssclass="eipborderhover">
	<DNN:DNNToolBarButton ControlAction="edit" ID="tbEdit" ToolTip="Edit" CssClass="eipbutton_edit" runat="server"/>
	<DNN:DNNToolBarButton ControlAction="save" ID="tbSave" ToolTip="Update" CssClass="eipbutton_save" runat="server"/>
	<DNN:DNNToolBarButton ControlAction="cancel" ID="tbCancel" ToolTip="Cancel" runat="server"/>
</dnn:dnntoolbar>
<br />
<asp:Panel ID="pnlHelp" runat="server" CssClass="Help">
    <asp:Label ID="lblHelp" runat="server" EnableViewState="False"></asp:Label>
</asp:Panel>
