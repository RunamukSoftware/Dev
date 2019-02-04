<%@ Control Language="vb" AutoEventWireup="false" Explicit="True" Inherits="DotNetNuke.UI.Skins.Skin" %>
<%@ Register TagPrefix="dnn" TagName="LANGUAGE" Src="~/Admin/Skins/Language.ascx" %>
<%@ Register TagPrefix="dnn" TagName="LOGO" Src="~/Admin/Skins/Logo.ascx" %>
<%@ Register TagPrefix="dnn" TagName="SEARCH" Src="~/Admin/Skins/Search.ascx" %>
<%@ Register TagPrefix="dnn" TagName="NAV" Src="~/Admin/Skins/Nav.ascx" %>
<%@ Register TagPrefix="dnn" TagName="TEXT" Src="~/Admin/Skins/Text.ascx" %>
<%@ Register TagPrefix="dnn" TagName="BREADCRUMB" Src="~/Admin/Skins/BreadCrumb.ascx" %>
<%@ Register TagPrefix="dnn" TagName="USER" Src="~/Admin/Skins/User.ascx" %>
<%@ Register TagPrefix="dnn" TagName="LOGIN" Src="~/Admin/Skins/Login.ascx" %>
<%@ Register TagPrefix="dnn" TagName="LEFTMENU" Src="~/Admin/Skins/LeftMenu.ascx" %>
<%@ Register TagPrefix="dnn" TagName="LINKS" Src="~/Admin/Skins/Links.ascx" %>
<%@ Register TagPrefix="dnn" TagName="PRIVACY" Src="~/Admin/Skins/Privacy.ascx" %>
<%@ Register TagPrefix="dnn" TagName="TERMS" Src="~/Admin/Skins/Terms.ascx" %>
<%@ Register TagPrefix="dnn" TagName="COPYRIGHT" Src="~/Admin/Skins/Copyright.ascx" %>
<%@ Register TagPrefix="dnn" TagName="STYLES" Src="~/Admin/Skins/Styles.ascx" %>
<%@ Register TagPrefix="dnn" Namespace="DotNetNuke.Web.DDRMenu.TemplateEngine" Assembly="DotNetNuke.Web.DDRMenu" %>
<%@ Register TagPrefix="dnn" TagName="MENU" Src="~/DesktopModules/DDRMenu/Menu.ascx" %>
<%@ Register TagPrefix="dnn" TagName="CONTROLPANEL" Src="~/Admin/Skins/controlpanel.ascx" %>

<%
    Dim isAdmin As Boolean = False
    isAdmin = PortalSecurity.IsInRole("Administrators")
%>

<script src="<%= SkinPath%>js/modernizr-1.7.min.js"></script>

<div id="wrapper" class="container_16">
    <!--[if lt IE 8]> <div style='clear: both; height: 59px; padding:0 0 0 15px; position: relative;'> <a href="http://windows.microsoft.com/en-US/internet-explorer/products/ie/home?ocid=ie6_countdown_bannercode"><img src="http://www.theie6countdown.com/images/upgrade.jpg" border="0" height="42" width="820" alt="You are using an outdated browser. For a faster, safer browsing experience, upgrade for free today." /></a></div> <![endif]-->
    <header id="main_header">
        <div class="grid_6" id="logo">
            <dnn:logo ID="Logo1" runat="server" />
        </div>
        <div class="grid_6" id="slogan">
            <div id="SloganPane" runat="server">
            </div>
        </div>
        <div class="grid_4 sidebar">
            <div id="AddressPane" runat="server">
            </div>
        </div>
        <div class="grid_12 alpha omega" id="metanav">
            <nav>
                <dnn:menu ID="Menu1" runat="server" menustyle="rzxMenu">
                    <TemplateArguments>
                        <dnn:templateargument name="menuType" value="" />
                    </TemplateArguments>
                </dnn:menu>
            </nav>
        </div>
        <div class="grid_4 sidebar" id="search">
            <dnn:SEARCH ID="dnnSearch" runat="server" UseDropDownList="false" EnableTheming="false" ShowSite="false" ShowWeb="false" CssClass="ser" 
                Submit="<span class='icon gray small' data-icon='s'></span>" />
        </div>
    </header>
    <div class="grid_12 alpha omega" id="main">
        <div id="ContentPane" runat="server">
        </div>
    </div>
    <aside class="grid_4 sidebar">
        <div id="AsidePane" runat="server">
        </div>
    </aside>
</div>
<script src="<%= SkinPath%>js/plugins.js"></script>
<script src="<%= SkinPath%>js/script.js"></script>