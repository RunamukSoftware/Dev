<%@ Control Language="C#" Inherits="forDNN.Modules.DataExporter.ViewDataExporter"
	AutoEventWireup="true" CodeBehind="ViewDataExporter.ascx.cs" %>
	
<script type="text/javascript">
function sourceChanged()
{
	var objSource = document.getElementById("<%=ddlSource.ClientID%>");
	var objTables = document.getElementById("<%=ddlTables.ClientID%>");
	var objViews = document.getElementById("<%=ddlViews.ClientID%>");
	var objQuery = document.getElementById("<%=tbQuery.ClientID%>");
	
	objTables.style["display"] = "none";
	objViews.style["display"] = "none";
	objQuery.style["display"] = "none";
	
	switch(objSource.value)
	{
		case "0":
			objTables.style["display"] = "block";
			break;
		case "1":
			objViews.style["display"] = "block";
			break;
		case "2":
			objQuery.style["display"] = "block";
			break;
	}
}
</script>

<asp:Label runat="server" ID="lblSource" CssClass="SubHead" resourcekey="Source"></asp:Label><br />
<asp:DropDownList runat="server" ID="ddlSource" CssClass="DropDownClass">
	<asp:ListItem Selected="True" Value="0" resourcekey="Tables"></asp:ListItem>
	<asp:ListItem Value="1" resourcekey="Views"></asp:ListItem>
	<asp:ListItem Value="2" resourcekey="Query"></asp:ListItem>
</asp:DropDownList>
<br />
<asp:DropDownList runat="server" ID="ddlTables" CssClass="DropDownClass">
</asp:DropDownList>
<asp:DropDownList runat="server" ID="ddlViews" Style="display: none;" CssClass="DropDownClass">
</asp:DropDownList>
<asp:TextBox ID="tbQuery" runat="server" TextMode="MultiLine" CssClass="QueryClass"
	Style="display: none;"></asp:TextBox>
<br />
<asp:Label runat="server" ID="ExportType" CssClass="SubHead" resourcekey="ExportType"></asp:Label><br />
<asp:RadioButtonList runat="server" ID="rblExportType" RepeatDirection="Horizontal"
	RepeatColumns="3" RepeatLayout="Table">
	<asp:ListItem Selected="True" Value="0" resourcekey="Excel"></asp:ListItem>
	<asp:ListItem Value="1" resourcekey="XML"></asp:ListItem>
	<asp:ListItem Value="2" resourcekey="CSV"></asp:ListItem>
</asp:RadioButtonList>
<br />
<asp:LinkButton ID="btnExport" runat="server" CssClass="CommandButton" resourcekey="Export"
	OnClick="btnExport_Click"></asp:LinkButton>
<br />
<br />
<br />
<br />
<asp:Label ID="lblIcon" runat="server"></asp:Label>