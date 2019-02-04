<%@ Control Language="vb" CodeBehind="DynamicFileUploadControl.ascx.vb" AutoEventWireup="false"
    Explicit="True" Inherits="DataSprings.Modules.DynamicForms.FileUpload" %>
<%@ Register TagPrefix="wc" Namespace="DotNetNuke.UI.WebControls" Assembly="CountryListBox" %>
<%@ Register TagPrefix="dnn" TagName="label" Src="~/controls/labelControl.ascx" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<div class="dnnForm" id="tblMain" runat="server">
    <fieldset>
        <div class="dnnFormItem" id="rowStreet" runat="server">
            <asp:FileUpload ID="fileupload" runat="server" />
        </div>
        <div class="dnnFormItem">
            <asp:Label ID="lblError" runat="server"></asp:Label>
        </div>
    </fieldset>
</div>
<div class="dnnForm" id="tblTelerik" runat="server">
    <fieldset>
        <div class="dnnFormItem" id="Tr1" runat="server">
 <asp:Panel runat="server" ID="pnlTelerik"> </asp:Panel>
          
        </div>
        <div class="dnnFormItem">
            <asp:Literal ID="litFiles" runat="server"></asp:Literal>
<asp:Label id="lblError2" runat="server"></asp:Label>
        </div>
    </fieldset>
    <ul class="dnnActions dnnClear">
        <li>
            <asp:LinkButton ID="lnkClearFiles" CssClass="dnnPrimaryAction" Visible="False" runat="server"></asp:LinkButton>
        </li>
    </ul>
</div>
