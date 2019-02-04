<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="DateControl.ascx.vb"
    Inherits="DataSprings.Modules.DynamicForms.DateControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="dnn" Namespace="DotNetNuke.Web.UI.WebControls" Assembly="DotNetNuke.Web" %>

<asp:panel id="pnlDateOne" runat="server">
	<dnn:DnnDatePicker ID="txtDate" runat="server" /> 
</asp:panel>
<asp:Panel ID="pnlDateTwo" runat="server">
    <asp:DropDownList ID="cboDateTwoMonth" runat="server" AutoPostBack="True">
        <asp:ListItem Value="January">January</asp:ListItem>
    </asp:DropDownList>
    &nbsp;&nbsp;&nbsp;
    <asp:DropDownList ID="cboDay" runat="server">
    </asp:DropDownList>
</asp:Panel>
<asp:Panel ID="pnlDateThree" runat="server">
    <table id="datefield3" width="100%">
        <tr>
            <td width="100%">
                <asp:DropDownList ID="cboMonth" runat="server">
                    <asp:ListItem Value="January">January</asp:ListItem>
                </asp:DropDownList>
                &nbsp;&nbsp;&nbsp;<asp:DropDownList ID="cboYear" runat="server">
                </asp:DropDownList>
            </td>
        </tr>
    </table>
</asp:Panel>
<asp:Panel ID="pnlDateFour" runat="server">
    <asp:TextBox ID="TextBox1" runat="server" Width="32px"></asp:TextBox>&nbsp;
    <asp:TextBox ID="TextBox2" runat="server" Width="32px"></asp:TextBox>&nbsp;
    <asp:TextBox ID="TextBox3" runat="server" Width="64px"></asp:TextBox></asp:Panel>
<asp:Panel ID="pnlDateFive" runat="server">
    <asp:DropDownList ID="cboMonth_ComboType" runat="server" AutoPostBack="True">
    </asp:DropDownList>
    &nbsp;&nbsp;<asp:DropDownList ID="cboDay_ComboType" runat="server">
    </asp:DropDownList>
    <asp:DropDownList ID="cboYear_ComboType" runat="server">
    </asp:DropDownList>
</asp:Panel>
