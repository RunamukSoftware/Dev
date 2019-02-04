' 
' DotNetNuke® - http:'www.dotnetnuke.com
' Copyright (c) 2002-2011
' by DotNetNuke Corporation
' 
' Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated 
' documentation files (the "Software"), to deal in the Software without restriction, including without limitation 
' the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and 
' to permit persons to whom the Software is furnished to do so, subject to the following conditions:
' 
' The above copyright notice and this permission notice shall be included in all copies or substantial portions 
' of the Software.
' 
' THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED 
' TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL 
' THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF 
' CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER 
' DEALINGS IN THE SOFTWARE.

Imports DotNetNuke
Imports System.Web.UI
Imports System.Collections.Generic
Imports System.Reflection

Namespace YourCompany.Modules.rxzChildNav

    ''' -----------------------------------------------------------------------------
    ''' <summary>
    ''' The ViewDynamicModule class displays the content
    ''' </summary>
    ''' <remarks>
    ''' </remarks>
    ''' <history>
    ''' </history>
    ''' -----------------------------------------------------------------------------
    Partial Class ViewrxzChildNav
        Inherits Entities.Modules.PortalModuleBase
        Implements Entities.Modules.IActionable

#Region "Private Members"

        Private strTemplate As String

#End Region

#Region "Event Handlers"

        ''' -----------------------------------------------------------------------------
        ''' <summary>
        ''' Page_Load runs when the control is loaded
        ''' </summary>
        ''' <remarks>
        ''' </remarks>
        ''' <history>
        ''' </history>
        ''' -----------------------------------------------------------------------------
        Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
            Try
                If Not Page.IsPostBack Then
                    If CType(Settings("template"), String) <> "" Then
                        strTemplate = CType(Settings("template"), String)
                    Else
                        strTemplate = Localization.GetString("Template.Text", LocalResourceFile)
                    End If

                    Dim lt As List(Of DotNetNuke.Entities.Tabs.TabInfo)
                    Dim str As String = ""
                    lt = TabController.GetTabsByParent(TabId, Me.PortalId)
                    If lt.Count > 0 Then
                        str = ""
                        str = "<nav id='subnav' class='panel'><ul>"
                        For Each itm As DotNetNuke.Entities.Tabs.TabInfo In lt
                            If itm.IsVisible And Not itm.IsDeleted Then
                                str &= "<li><div class='l2 lo'><div class='b1'></div><div class='b2'></div></div><div class='l1 lo'><a href='" & itm.FullUrl & "'>" & itm.TabName & "</a></div></li>"
                            End If
                        Next
                        str &= "</ul><div class='clearfix'>&nbsp;</div></nav>"
                        litSubNav.Text = str
                    Else
                        lt = TabController.GetTabsByParent(TabController.CurrentPage.ParentId, Me.PortalId)
                        str = ""
                        str = "<nav id='subnav' class='panel'><ul>"
                        For Each itm As DotNetNuke.Entities.Tabs.TabInfo In lt
                            If itm.IsVisible And Not itm.IsDeleted Then
                                If itm.TabID = TabId Then
                                    str &= "<li class='current'><div class='l2 lo'><div class='b1'></div><div class='b2'></div></div><div class='l1 lo'><a href='" & itm.FullUrl & "'>" & itm.TabName & "</a></div></li>"
                                Else
                                    str &= "<li><div class='l2 lo'><div class='b1'></div><div class='b2'></div></div><div class='l1 lo'><a href='" & itm.FullUrl & "'>" & itm.TabName & "</a></div></li>"
                                End If
                            End If
                        Next
                        str &= "</ul><div class='clearfix'>&nbsp;</div></nav>"
                        litSubNav.Text = str
                    End If

                End If
            Catch exc As Exception        'Module failed to load
                ProcessModuleLoadException(Me, exc)
            End Try
        End Sub

#End Region

#Region "Optional Interfaces"

        ''' -----------------------------------------------------------------------------
        ''' <summary>
        ''' Registers the module actions required for interfacing with the portal framework
        ''' </summary>
        ''' <value></value>
        ''' <returns></returns>
        ''' <remarks></remarks>
        ''' <history>
        ''' </history>
        ''' -----------------------------------------------------------------------------
        Public ReadOnly Property ModuleActions() As Entities.Modules.Actions.ModuleActionCollection Implements Entities.Modules.IActionable.ModuleActions
            Get
                Dim Actions As New Entities.Modules.Actions.ModuleActionCollection
                Actions.Add(GetNextActionID, Localization.GetString(Entities.Modules.Actions.ModuleActionType.AddContent, LocalResourceFile), Entities.Modules.Actions.ModuleActionType.AddContent, "", "", EditUrl(), False, Security.SecurityAccessLevel.Edit, True, False)
                Return Actions
            End Get
        End Property

#End Region

    End Class

End Namespace
