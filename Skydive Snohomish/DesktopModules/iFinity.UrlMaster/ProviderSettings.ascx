<%@ Control Language="C#" AutoEventWireup="false" Inherits="iFinity.DNN.Modules.UrlMaster.UI.ProviderSettings" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register TagPrefix="ifty" TagName="SaveMessage" Src="SaveMessage.ascx" %>
<dnn:Label id="lblHeader" runat="server" CssClass="LabelHeader" ResourceKey="Header" Text="Module Friendly Url Provider Settings" />
<asp:Panel ID="pnlSettings" runat="server">
</asp:Panel>
<div id="pageListButtons" class="fieldOption">
    <asp:button ID="btnSave" runat="server" /><asp:Button ID="btnReturn" runat="server" CausesValidation="false" /><asp:Button ID="btnCancel" runat="server" CausesValidation="false"/>
    <ifty:SaveMessage id="ctlSaveMessage" runat="server" />
</div>

