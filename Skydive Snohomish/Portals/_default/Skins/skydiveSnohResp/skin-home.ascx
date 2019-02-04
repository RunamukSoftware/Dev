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
<%@ Register TagPrefix="dnn2" TagName="COPYRIGHT" Src="~/Admin/Skins/Copyright.ascx" %>
<%@ Register TagPrefix="dnn" TagName="STYLES" Src="~/Admin/Skins/Styles.ascx" %>
<%@ Register TagPrefix="dnn" Namespace="DotNetNuke.Web.DDRMenu.TemplateEngine" Assembly="DotNetNuke.Web.DDRMenu" %>
<%@ Register TagPrefix="dnn" TagName="MENU" Src="~/DesktopModules/DDRMenu/Menu.ascx" %>
<%@ Register TagPrefix="dnn" TagName="CONTROLPANEL" Src="~/Admin/Skins/controlpanel.ascx" %>
<%@ Register TagPrefix="dnn" TagName="Meta" Src="~/Admin/Skins/Meta.ascx" %>

<dnn:Meta runat="server" Name="viewport" Content="initial-scale=1.0,width=device-width" /> 
<dnn:Meta runat="server" Name="dnncrawler" Content="doindex" />

<dnn:STYLES runat="server" ID="normalize" Name="normalize" StyleSheet="css/normalize.css" UseSkinPath="true"/>
<dnn:STYLES runat="server" ID="foundation" Name="foundation" StyleSheet="css/foundation.css" UseSkinPath="true"/>

<%
Dim isAdmin As Boolean = False
isAdmin = PortalSecurity.IsInRole("Administrators")
%>

<script src="<%= SkinPath%>js/vendor/custom.modernizr.js"></script>
<script src="<%= SkinPath%>js/respond.min.js"></script>

<div id="home">
<div id="wrapper">

<!-- Header -->

<header id="main_header" class="row">
<div id="snLogo" class="large-4 columns">
<dnn:logo ID="Logo1" runat="server" />
</div>
<div class="large-5 columns">
<div id="SloganPane" runat="server">
</div>
</div>
<div class="large-3 columns">
<div id="AddressPane" runat="server">
</div>
</div>
</header>

<!-- End Header -->

<!-- Nav Bar -->

<div class="row">
<div id="metanavx" class="large-9 columns">
<nav class="top-bar">
	<ul class="title-area">
	<!-- Title Area -->
	<li class="name">
	<h1><a></a></h1>
	</li>
	<!-- Remove the class "menu-icon" to get rid of menu icon. Take out "Menu" to just have icon alone -->
	<li class="toggle-topbar"><a href="#"><span><img width="16" height="16" title="" alt="" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAAadEVYdFNvZnR3YXJlAFBhaW50Lk5FVCB2My41LjEwMPRyoQAAADZJREFUOE/dzrEJADAQw0Dvv3TSCNwq3X+uNAicj5xHZMWukU3CM42s2DWySXimkRW7RrZfcgHdKh7wfkomXAAAAABJRU5ErkJggg==" /></span></a></li>
	</ul>
<section class="top-bar-section">
<dnn:menu ID="Menu1" runat="server" menustyle="rzxMenu">
<TemplateArguments>
<dnn:templateargument name="menuType" value="" />
</TemplateArguments>
</dnn:menu>
</section>
</nav>
</div>
<div id="search" class="large-3 columns">
<dnn:SEARCH ID="dnnSearch" runat="server" UseDropDownList="false" EnableTheming="false" ShowSite="false" ShowWeb="false" CssClass="ser" 
Submit="<span class='icon gray small' data-icon='s'></span>" />
</div>
</div>

<!-- End Nav -->


<!-- Main Page Content and Sidebar -->

<div class="row">

<!-- Main Blog Content -->
<div id="main" class="large-9 columns" role="content">
<div id="ContentPane" runat="server">
</div>
<footer class="panel show-for-medium-up">
<div>
	<div class="row">
		<div class="large-4 columns">
			<div id="CFooterPaneLeft" runat="server">
			</div>
		</div>
		<div class="large-4 columns">
			<div style="text-align:center">
			<div id="CFooterPaneCenter" runat="server">
			</div>
			<small><dnn2:COPYRIGHT ID="dnnCopyright2" runat="server" /></small>
			</div>
		</div>
		<div class="large-4 columns">
			<div id="CFooterPaneRight" runat="server">
			</div>
		</div>
	</div>
</div>
</footer>
</div>

<!-- End Main Content -->


<!-- Sidebar -->

<aside class="large-3 columns">
<div id="AsidePane" runat="server">
</div>
</aside>

<!-- End Sidebar -->
</div>

<!-- End Main Content and Sidebar -->

<!-- Footer -->
<div class="row hide-for-medium-up">
<footer class="large-9 columns">
<div class="panel">
	<div class="row">
		<div class="large-4 columns">
			<div id="FooterPaneLeft" runat="server">
			</div>
		</div>
		<div class="large-4 columns">
			<div style="text-align:center">
			<div id="FooterPaneCenter" runat="server">
			</div>
			<small><dnn:COPYRIGHT ID="dnnCopyright" runat="server" /></small>
			</div>
		</div>
		<div class="large-4 columns">
			<div id="FooterPaneRight" runat="server">
			</div>
		</div>
	</div>
</div>
</footer>
</div>
<!-- End Footer -->

<script src="<%= SkinPath%>js/plugins.js"></script>
<script src="<%= SkinPath%>js/foundation.min.js"></script>
<script src="<%= SkinPath%>js/foundation/foundation.orbit.js"></script> 
<script src="<%= SkinPath%>js/foundation/foundation.topbar.js"></script>
<script>
$(document).foundation();
$(document).ready(function(){
$('#dnn_dnnSearch_txtSearch').attr('placeholder','Search...');
if($.browser.msie){$('.top-bar-section ul li > a').css({'fontSize':'11px'});}
//$('li.toggle-topbar').trigger('click');
});
$(window).load(function(){
if($(window).width()>750){$('#hooked').height($('#featured').height());}
});
</script>


</div>
</div>




