<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:udt="DotNetNuke/UserDefinedTable" exclude-result-prefixes="udt">
<xsl:output method="xml" indent="yes" omit-xml-declaration="yes" />
<!--
This prefix is used to generate module specific query strings
Each querystring or form value that starts with udt_{ModuleId}_param 
will be added as parameter starting with param
-->
<xsl:variable name="prefix_param">udt_<xsl:value-of select="//udt:Context/udt:ModuleId" />_param</xsl:variable>

<xsl:template match="udt:Data" mode="list">
	<div class="testimonial">
		<blockquote>
			<xsl:value-of select="udt:Testimonial_x0020_Text" disable-output-escaping="yes" />
		</blockquote>
		<span class="author">
			<xsl:value-of select="udt:Name" disable-output-escaping="yes" />
		</span>
		<a href="/Skydive_Snohomish_Reviews.aspx" class="more">More</a>
	</div>
</xsl:template>

<xsl:template match="/udt:UserDefinedTable">
	<xsl:variable name="Cr" select="udt:Data[1]/udt:Cr" />
	<xsl:variable name="currentData" select="udt:Data[position()=$Cr]" />
	<xsl:if test="$currentData">
		<xsl:apply-templates select="$currentData" mode="list">
		</xsl:apply-templates>
	</xsl:if>
</xsl:template>

</xsl:stylesheet>