<%@ Register TagPrefix="dnn" TagName="SectionHead" Src="~/controls/SectionHeadControl.ascx" %>
<%@ Control Language="vb" AutoEventWireup="false" Explicit="True" CodeBehind="ViewFormResults.ascx.vb"
    Inherits="DataSprings.Modules.DynamicForms.ViewFormResults" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register TagPrefix="Portal" TagName="URL" Src="~/controls/URLControl.ascx" %>
<%@ Register TagPrefix="dnn" TagName="TextEditor" Src="~/controls/TextEditor.ascx" %>
<script language="javascript">



    function InsertEmailToken(token, myobject) {
        var MyValue;
        MyValue = document.getElementById(token).value;



        if (window.FTB_API) {
            FTB_API[myobject].InsertHtml(MyValue);
        } else if (window.FCKeditorAPI) {
            var oEditor = FCKeditorAPI.GetInstance(myobject);
            oEditor.InsertHtml(MyValue);
        } else if (window.GetRadEditor) {
            var editor = RadEditorGlobalArray[0];
            editor.SetFocus();
            editor.SetActive();
            editor.PasteHtml(MyValue);

        } else {
            if (document.getElementById(myobject).createTextRange) { //Basically if the browser is IE
                var text;
                document.getElementById(myobject).focus(document.getElementById(myobject).caretPos);
                document.getElementById(myobject).caretPos = document.selection.createRange().duplicate();
                if (document.getElementById(myobject).caretPos.text.length > 0) {
                    document.getElementById(myobject).caretPos.text = document.getElementById(myobject).caretPos.text;
                } else {
                    document.getElementById(myobject).caretPos.text = MyValue;
                }
            }
            else { document.getElementById(myobject).value += MyValue; }
        }
    }


    function SetAuthParamByField(field1, field2) {



        document.getElementById(field2).value = document.getElementById(field2).value + document.getElementById(field1).value;


    }




    function SetAuthParam(field1, field2) {


        document.getElementById(field2).value = document.getElementById(field2).value + '&' + document.getElementById(field1).value + '=';


    }



</script>
<asp:UpdatePanel ID="UpdatePanelResults" runat="server">
    <ContentTemplate>
        <asp:UpdateProgress ID="UpdateProgress2" runat="server" AssociatedUpdatePanelID="UpdatePanelResults">
            <ProgressTemplate>
                <asp:Image ID="imgProgress" runat="server" ImageUrl="~/desktopmodules/Dynamic Forms/Progress.gif">
                </asp:Image>
            </ProgressTemplate>
        </asp:UpdateProgress>
        <div class="dnnForm" id="tblControls" runat="server">
            <ul class="dnnActions dnnClear">
                <li>
                    <asp:LinkButton ID="lnkExit" runat="server" CssClass="dnnPrimaryAction">Exit</asp:LinkButton>
                </li>
            </ul>
            <ul class="dnnActions dnnClear">
                <li>
                    <asp:Panel ID="pnlManageResultsTemplate" runat="server">
                        <asp:LinkButton ID="lnkManageTemplate" runat="server" CssClass="dnnSecondaryAction">Manage Results Template</asp:LinkButton>
                    </asp:Panel>
                </li>
                <li>
                    <asp:Panel ID="pnlExportResults" runat="server">
                        <asp:LinkButton ID="lnkExport" runat="server" CssClass="dnnSecondaryAction">Export to Excel</asp:LinkButton>
                    </asp:Panel>
                </li>
                <li>
                    <asp:Panel ID="pnlPurge" runat="server">
                        <asp:LinkButton ID="lnkPurge" runat="server" ResouceKey="lnkPurge" Text="Purge All Results" CssClass="dnnSecondaryAction"></asp:LinkButton>
                    </asp:Panel>
                </li>
            </ul>
        </div>
        <div class="dnnForm" id="tblResultsGrid" runat="server">
            <fieldset>
                <div class="dnnFormItem" runat="server" visible="true">
                    <asp:Panel ID="pnlPageCount" runat="Server">
                        <dnn:Label ID="lblPageSize" runat="server" Suffix=":"></dnn:Label>
                        <asp:DropDownList ID="cboPageCount" runat="server" Width="100px" AutoPostBack="True"
                            CssClass="NormalTextBox">
                            <asp:ListItem Value="10">10</asp:ListItem>
                            <asp:ListItem Value="50">50</asp:ListItem>
                            <asp:ListItem Value="100">100</asp:ListItem>
                            <asp:ListItem Value="250">250</asp:ListItem>
                            <asp:ListItem Value="500">500</asp:ListItem>
                        </asp:DropDownList>
                    </asp:Panel>
                </div>
                <div class="dnnFormItem" runat="server" visible="true">
    <asp:panel id="pnlSaveForLater" runat="Server">
  <dnn:label id="lblFilterBySaveForLater" runat="server" suffix=":"></dnn:label>

 <asp:DropDownList ID="cboFireEvent" runat="server" CssClass="NormalTextbox" AutoPostBack="True">
                                <asp:ListItem Value="0"></asp:ListItem>
                                <asp:ListItem Value="1"></asp:ListItem>
                                <asp:ListItem Value="2"></asp:ListItem>
                            </asp:DropDownList>

	</asp:panel>

                    <asp:Panel ID="pnlFilter" runat="Server">
   <div class="dnnFormItem">
                        <dnn:Label ID="lblFilter" runat="server" Suffix=":"></dnn:Label>
                       
                                    <asp:DropDownList ID="cboFilter" runat="server"  Width="150px">
                                    </asp:DropDownList>
                                </div>
   <div class="dnnFormItem">
                             
                                 <dnn:Label ID="lblFilterSearch" runat="server" Suffix=":"></dnn:Label>
                       
                                    <asp:TextBox ID="txtSearch" runat="server" Visible="True" Width="200px"></asp:TextBox>

                                    <asp:LinkButton ID="lnkSearch" runat="server" ResouceKey="lnkSearch" CssClass="dnnSecondaryAction">Search</asp:LinkButton>
                               </div>
                    </asp:Panel>
                </div>
                <div class="dnnFormItem">
                    <asp:DataGrid ID="dgResults" runat="server" AutoGenerateColumns="False" Width="550px"
                        AllowPaging="True" CssClass="dnnGrid">
                        <Columns>
                            <asp:BoundColumn ReadOnly="true" DataField="UniqueResponseID" Visible="false"></asp:BoundColumn>
                            <asp:BoundColumn DataField="ResponseDateTime" SortExpression="ResponseDateTime|ASC"
                                HeaderText="Results Date  / Time">
                                <HeaderStyle Wrap="False"></HeaderStyle>
                            </asp:BoundColumn>
                            <asp:TemplateColumn Visible="False" HeaderText="Summary">
                                <ItemTemplate>
                                    <asp:Label ID="lblSummary" Text='<%#getSummaryFiledValue(DataBinder.Eval(Container,"DataItem.UniqueResponseID"))%>'
                                        runat="server">
                                    </asp:Label>
                                </ItemTemplate>
                            </asp:TemplateColumn>
                            <asp:TemplateColumn>
                                <ItemTemplate>
                                    <asp:ImageButton ID="imgView" runat="server" AlternateText="Edit" resourceKey="dgviewtext.Text"
                                        CommandName="View" ImageUrl="~/images/view.gif" CommandArgument='<%#DataBinder.Eval(Container,"DataItem.UniqueResponseID")%>'>
                                    </asp:ImageButton>&nbsp;&nbsp;
                                    <asp:LinkButton ID="lnkViewResults" runat="server" CommandName="View" CommandArgument='<%#DataBinder.Eval(Container,"DataItem.UniqueResponseID")%>'>View Results</asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateColumn>
                            <asp:TemplateColumn>
                                <ItemTemplate>
                                    <asp:ImageButton ID="imgDelete" runat="server" AlternateText="Delete" ResourceKey="dgdeletetext.Text"
                                        CommandName="Delete" ImageUrl="~/images/delete.gif" CommandArgument='<%#DataBinder.Eval(Container,"DataItem.UniqueResponseID")%>'
                                        OnClientClick="javascript:return confirm('Are you sure you want to delete this form submission? This cannot be undone!');">
                                    </asp:ImageButton>&nbsp;&nbsp;
                                    <asp:LinkButton ID="lnkDeleteResults" OnClientClick="javascript:return confirm('Are you sure you want to delete this form submission? This cannot be undone!');"
                                        runat="server" CommandName="Delete" CommandArgument='<%#DataBinder.Eval(Container,"DataItem.UniqueResponseID")%>'>Delete</asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateColumn>
                            <asp:TemplateColumn>
                                <ItemTemplate>
                                    <asp:ImageButton ID="imgEdit" runat="server" AlternateText="Edit" resourceKey="dgedittext.Text"
                                        CommandName="Edit" ImageUrl="~/images/edit.gif" CommandArgument='<%#DataBinder.Eval(Container,"DataItem.UniqueResponseID")%>'>
                                    </asp:ImageButton>&nbsp;&nbsp;
                                    <asp:LinkButton ID="lnkEditResults" runat="server" CommandName="Edit" CommandArgument='<%#DataBinder.Eval(Container,"DataItem.UniqueResponseID")%>'>Edit</asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateColumn>
                            <asp:TemplateColumn>
                                <ItemTemplate>
                                    <asp:ImageButton ID="imgManageTeasers" runat="server" AlternateText="Start From..."
                                        resourceKey="dglistTeasers.Text" CommandName="Copy" ImageUrl="~/images/icon_tabs_16px.gif"
                                        CommandArgument='<%#DataBinder.Eval(Container,"DataItem.UniqueResponseID")%>'>
                                    </asp:ImageButton>&nbsp;&nbsp;
                                    <asp:LinkButton ID="lnkCreateCopy" runat="server" CommandName="Copy" CommandArgument='<%#DataBinder.Eval(Container,"DataItem.UniqueResponseID")%>'>Create Copy</asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateColumn>
                        </Columns>
                        <PagerStyle HorizontalAlign="Center" Position="TopAndBottom" Mode="NumericPages">
                        </PagerStyle>
                    </asp:DataGrid>
                </div>
                <div class="dnnFormItem">
                    <div class="dnnForm" id="tblResults" runat="server">
                        <fieldset>
                            <div class="dnnFormItem">
                                <asp:Literal ID="litResults" runat="server"></asp:Literal>
                            </div>
                            <div class="dnnFormItem">
                                <asp:LinkButton ID="lnkBack" runat="server" CssClass="dnnPrimaryAction">Back</asp:LinkButton>
                            </div>
                        </fieldset>
                    </div>
                </div>
</div>


                <div class="dnnFormItem">
                    <div class="dnnForm" id="tblManageTemplate" runat="server">
                        <fieldset>
                            <div class="dnnFormItem">

                                <asp:RadioButtonList ID="optResultsType" runat="server" AutoPostBack="True"  Enabled="True" RepeatDirection="Horizontal">
                                    <asp:ListItem Value="0" ResourceKey="StandardTemplate"></asp:ListItem>
                                    <asp:ListItem Value="1" ResourceKey="CustomTemplate"></asp:ListItem>
                                </asp:RadioButtonList>
                            </div>
                            <div class="dnnFormItem" id="rowCustomTemplate" runat="server" visible="true">
                                <table>
                                    <tr>
                                        <td>
                                            <asp:ListBox ID="lstDynamicTemplateTokens" runat="server" CssClass="NormalTextBox"
                                                Visible="True" Width="160px" Height="295"></asp:ListBox>
                                        </td>
                                        <td>
                                            <dnn:TextEditor ID="txtResultsTemplate" runat="server" Width="450" Height="300">
                                            </dnn:TextEditor>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div class="dnnFormItem">
                                <asp:Label ID="lblParameters" runat="server" CssClass="SubHead" Visible="False"></asp:Label>
                            </div>
                            <div class="dnnFormItem" style="padding-top:40px;">
                                <asp:LinkButton ID="lnkGenResults" runat="Server" ResourceKey="GenResults" CssClass="dnnSecondaryAction">test</asp:LinkButton>&nbsp;
                                <asp:LinkButton ID="lnkGenFullResults" runat="Server" ResourceKey="GenFullResults"
                                    CssClass="dnnSecondaryAction">test2</asp:LinkButton>
                            </div>
                        </fieldset>
                        <ul class="dnnActions dnnClear" id="RowCustomTemplateUpdate" runat="server" visible="true">
                            <li>
                                <asp:LinkButton ID="lnkUpdateTemplate" runat="server" CssClass="dnnPrimaryAction">Update Template</asp:LinkButton>
                            </li>
                            <li>
                                <asp:LinkButton ID="lnkCancelTemplate" runat="server" CssClass="dnnSecondaryAction">Cancel</asp:LinkButton>
                            </li>
                        </ul>
                    </div>
                </div>
            
    </ContentTemplate>
    <Triggers>
        <asp:PostBackTrigger ControlID="lnkExport" />
    </Triggers>
</asp:UpdatePanel>
