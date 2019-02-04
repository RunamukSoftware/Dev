<%@ WebHandler Language="VB" Class="CustomHandlerVB"  %>
 
imports System
imports System.Web
imports Telerik.Web.UI
 
Public Class CustomHandlerVB: 
    Inherits AsyncUploadHandler 
    Protected Overrides Function Process(file As UploadedFile, context As HttpContext, configuration As IAsyncUploadConfiguration, tempFileName As String) As IAsyncUploadResult
try

        configuration.TimeToLive = TimeSpan.FromHours(4)
        Return MyBase.Process(file, context, configuration, tempFileName)
catch
end try

    End Function

End Class
