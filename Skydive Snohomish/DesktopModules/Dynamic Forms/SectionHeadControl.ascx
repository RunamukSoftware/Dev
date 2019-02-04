<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="SectionHeadControl.ascx.vb"
    Inherits="DataSprings.Modules.DynamicForms.SectionHeadControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<div>
    <asp:ImageButton ID="imgIcon" runat="server" EnableViewState="False" TabIndex="-1">
    </asp:ImageButton>&nbsp;
    <asp:Label ID="lblTitle" runat="server" EnableViewState="False"></asp:Label>
</div>
<asp:Panel ID="pnlRule" runat="server" EnableViewState="False">
    <hr noshade="noshade" size="1" />
</asp:Panel>
         