<%@ Control Language="C#" AutoEventWireup="true" CodeFile="TripleSEditor.ascx.cs" Inherits="DesktopModules_TripleS_TripleSEditor" %>

<div id="TripleSEditor" class="Content">
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:SiteSqlServer %>"
        SelectCommand="SELECT [ClassStatusID], [ClassStatus] 
	    FROM [SkySno_ClassStatus] 
	    ORDER BY [ClassStatusID]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:SiteSqlServer %>"
        DeleteCommand="EXECUTE [dbo].[SkySno_uspDelClassStatusEditForDay] @DayTimeID;"
        InsertCommand="EXECUTE [dbo].[SkySno_uspInsClassStatusEditForDay] @Day nchar(10), @Time smalldatetime, @ClassStatusID;"
        SelectCommand="EXECUTE [dbo].[SkySno_uspSelClassStatusEditForDay];"
        UpdateCommand="EXECUTE [dbo].[SkySno_uspUpdClassStatusEditForDay] @ClassStatusID, @DayTimeID;">
        <DeleteParameters>
            <asp:Parameter Name="DayTimeID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="Day" Type="String" />
            <asp:Parameter Name="Time" Type="DateTime" />
            <asp:Parameter Name="ClassStatusID" Type="Int32" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="ClassStatusID" Type="Int32" />
            <asp:Parameter Name="DayTimeID" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <h1>Triple S Editor</h1>
    <p>
        <asp:LoginName ID="LoginName1" runat="server" FormatString="Welcome, {0}" />
    </p>
    <asp:ListView ID="ListView1" runat="server" DataKeyNames="DayTimeID" DataSourceID="SqlDataSource2">
        <AlternatingItemTemplate>
            <tr class="<%# Eval("CSSStyle") %>">
                <td>
                    <asp:Label ID="DayLabel" runat="server" Text='<%# Eval("Day") %>' />
                </td>
                <td>
                    <asp:Label ID="TimeLabel" runat="server" Text='<%# Eval("ClassTime") %>' />
                </td>
                <td>
                    <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSource1" DataTextField="ClassStatus" DataValueField="ClassStatusID" SelectedValue='<%# Bind("ClassStatusID") %>' Enabled="false" CssClass="DropDownList" />
                </td>
                <td>
                    <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Edit" />
                </td>
            </tr>
        </AlternatingItemTemplate>
        <EditItemTemplate>
            <tr class="Edit <%# Eval("CSSStyle") %>">
                <td>
                    <asp:Label ID="DayTextBox" runat="server" Text='<%# Eval("Day") %>' />
                </td>
                <td>
                    <asp:Label ID="TimeTextBox" runat="server" Text='<%# Eval("ClassTime") %>' />
                </td>
                <td>
                    <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSource1" DataTextField="ClassStatus" DataValueField="ClassStatusID"
                        SelectedValue='<%# Bind("ClassStatusID") %>' CssClass="DropDownList" />
                </td>
                <td>
                    <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Update" />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" />
                </td>
            </tr>
        </EditItemTemplate>
        <EmptyDataTemplate>
            <table runat="server" class="Empty">
                <tr>
                    <td>No data was returned.</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        <InsertItemTemplate>
            <tr>
                <td>&nbsp;
                </td>
                <td>
                    <asp:TextBox ID="DayTextBox" runat="server" Text='<%# Bind("Day") %>' />
                </td>
                <td>
                    <asp:TextBox ID="TimeTextBox" runat="server" Text='<%# Bind("ClassTime") %>' />
                </td>
                <td>
                    <asp:TextBox ID="ClassStatusIDTextBox" runat="server" Text='<%# Bind("ClassStatusID") %>' />
                </td>
                <td>
                    <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Insert" />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Clear" />
                </td>
            </tr>
        </InsertItemTemplate>
        <ItemTemplate>
            <tr class="<%# Eval("CSSStyle") %>">
                <td>
                    <asp:Label ID="DayLabel" runat="server" Text='<%# Eval("Day") %>' />
                </td>
                <td>
                    <asp:Label ID="TimeLabel" runat="server" Text='<%# Eval("ClassTime") %>' />
                </td>
                <td>
                    <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSource1" DataTextField="ClassStatus" DataValueField="ClassStatusID"
                        SelectedValue='<%# Bind("ClassStatusID") %>' Enabled="false" CssClass="DropDownList" />
                </td>
                <td>
                    <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Edit" />
                </td>
            </tr>
        </ItemTemplate>
        <LayoutTemplate>
            <table runat="server">
                <tr runat="server">
                    <td runat="server">
                        <table id="itemPlaceholderContainer" runat="server" class="itemPlaceholderContainer">
                            <tr class="Heading" runat="server">
                                <th runat="server">Day</th>
                                <th runat="server">Time</th>
                                <th runat="server">Class Status Select</th>
                                <th runat="server"></th>
                            </tr>
                            <tr id="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </LayoutTemplate>
        <SelectedItemTemplate>
            <tr class="Selected <%# Eval("CSSStyle") %>">
                <td>
                    <asp:Label ID="DayLabel" runat="server" Text='<%# Eval("Day") %>' />
                </td>
                <td>
                    <asp:Label ID="TimeLabel" runat="server" Text='<%# Eval("ClassTime") %>' />
                </td>
                <td>
                    <asp:Label ID="ClassStatusIDLabel" runat="server" Text='<%# Eval("ClassStatusID") %>' />
                </td>
                <td>
                    <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Edit" />
                </td>
            </tr>
        </SelectedItemTemplate>
    </asp:ListView>
</div>
