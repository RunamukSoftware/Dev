<%@ Register TagPrefix="dnn" TagName="label" Src="~/controls/labelControl.ascx" %>
<%@ Register TagPrefix="wc" Namespace="DotNetNuke.UI.WebControls" Assembly="CountryListBox" %>
<%@ Control Language="vb" CodeBehind="DynamicImageControl.ascx.vb" AutoEventWireup="false"
    Explicit="True" Inherits="DataSprings.Modules.DynamicForms.ImageControl" %>
<div class="dnnForm" id="tblMain">
    <fieldset>
        <div class="dnnFormItem" id="rowStreet" runat="server">
            <asp:FileUpload ID="fileupload" runat="server" />
            <asp:LinkButton ID="lnkPreviewImage" runat="server" CausesValidation="False" Visible="False">Upload Picture</asp:LinkButton>
            <asp:ImageButton ID="imgPreviewImage" runat="server" CausesValidation="False" Visible="False">
            </asp:ImageButton>
        </div>
        <div class="dnnFormItem">
            <asp:HyperLink ID="imgMain" runat="server"></asp:HyperLink>
        </div>
        <div class="dnnFormItem">
            <asp:Literal ID="litNotValid" runat="server" Visible="false"></asp:Literal>
        </div>
        <div class="dnnFormItem">
            <asp:LinkButton ID="lnkUploadImage" runat="server" CausesValidation="False">Upload Picture</asp:LinkButton>
        </div>
        <div class="dnnFormItem">
            <input id="PreviewFile" type="hidden" runat="server" />
        </div>
    </fieldset>
</div>
