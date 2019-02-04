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
    <style>
article {
border-top: 1px solid #ddd;
padding-top: 15px;
clear: both;
}
article img {
float: right;
padding: 5px 0 10px 20px;
}
.author {
font-weight: bold;
}
</style>
    <xsl:call-template name="EditLink" />
    <article class="Normal">
      <xsl:value-of select="udt:Review_x0020_Text" disable-output-escaping="yes" />
      <p class="author">
        <xsl:value-of select="udt:Author" disable-output-escaping="yes" />
        <span style="visibility:hidden;">(<xsl:value-of select="udt:Review_x0020_Date_UDT_Value" disable-output-escaping="yes" />)</span>
      </p>
    </article>
  </xsl:template>

  <xsl:template match="/udt:UserDefinedTable">
    <xsl:variable name="currentData" select="udt:Data" />
    <xsl:if test="$currentData">
      <xsl:apply-templates select="$currentData" mode="list">
      </xsl:apply-templates>
    </xsl:if>
  </xsl:template>

  <xsl:template name="EditLink">
    <xsl:if test="udt:EditLink">
      <a href="{udt:EditLink}">
        <img border="0" alt="edit" src="{//udt:Context/udt:ApplicationPath}/images/edit.gif" />
      </a>
    </xsl:if>
  </xsl:template>
<udt:template listType="div" delimiter=";" listView="&lt;style&gt;&#xD;&#xA;article {&#xD;&#xA;border-top: 1px solid #ddd;&#xD;&#xA;padding-top: 15px;&#xD;&#xA;clear: both;&#xD;&#xA;}&#xD;&#xA;article img {&#xD;&#xA;float: right;&#xD;&#xA;padding: 5px 0 10px 20px;&#xD;&#xA;}&#xD;&#xA;.author {&#xD;&#xA;font-weight: bold;&#xD;&#xA;}&#xD;&#xA;&lt;/style&gt;&#xD;&#xA;[UDT:EditLink]&#xD;&#xA;&lt;article class=&quot;Normal&quot;&gt;&#xD;&#xA;[Review Text]&#xD;&#xA;&lt;p class=&quot;author&quot;&gt;[Author] &lt;span style=&quot;visibility:hidden;&quot;&gt;([Review Date_UDT_Value])&lt;/span&gt;&lt;/p&gt;&#xD;&#xA;&#xD;&#xA;&lt;/article&gt;" headerView="" detailView="[UDT:ListView][UDT:EditLink]&#xD;&#xA;&lt;table&gt;&#xD;&#xA;  &lt;tr&gt;&#xD;&#xA;    &lt;td class=&quot;normalBold&quot;&gt;Created by&lt;/td&gt;&#xD;&#xA;    &lt;td class=&quot;Normal&quot;&gt;[Created by]&lt;/td&gt;&#xD;&#xA;  &lt;/tr&gt;&#xD;&#xA;  &lt;tr&gt;&#xD;&#xA;    &lt;td class=&quot;normalBold&quot;&gt;Created at&lt;/td&gt;&#xD;&#xA;    &lt;td class=&quot;Normal&quot;&gt;[Created at_UDT_Value]&lt;/td&gt;&#xD;&#xA;  &lt;/tr&gt;&#xD;&#xA;  &lt;tr&gt;&#xD;&#xA;    &lt;td class=&quot;normalBold&quot;&gt;Changed by&lt;/td&gt;&#xD;&#xA;    &lt;td class=&quot;Normal&quot;&gt;[Changed by]&lt;/td&gt;&#xD;&#xA;  &lt;/tr&gt;&#xD;&#xA;  &lt;tr&gt;&#xD;&#xA;    &lt;td class=&quot;normalBold&quot;&gt;Changed at&lt;/td&gt;&#xD;&#xA;    &lt;td class=&quot;Normal&quot;&gt;[Changed at_UDT_Value]&lt;/td&gt;&#xD;&#xA;  &lt;/tr&gt;&#xD;&#xA;  &lt;tr&gt;&#xD;&#xA;    &lt;td class=&quot;normalBold&quot;&gt;Review Text&lt;/td&gt;&#xD;&#xA;    &lt;td class=&quot;Normal&quot;&gt;[Review Text]&lt;/td&gt;&#xD;&#xA;  &lt;/tr&gt;&#xD;&#xA;  &lt;tr&gt;&#xD;&#xA;    &lt;td class=&quot;normalBold&quot;&gt;Author&lt;/td&gt;&#xD;&#xA;    &lt;td class=&quot;Normal&quot;&gt;[Author]&lt;/td&gt;&#xD;&#xA;  &lt;/tr&gt;&#xD;&#xA;  &lt;tr&gt;&#xD;&#xA;    &lt;td class=&quot;normalBold&quot;&gt;Review Date&lt;/td&gt;&#xD;&#xA;    &lt;td class=&quot;Normal&quot;&gt;[Review Date_UDT_Value]&lt;/td&gt;&#xD;&#xA;  &lt;/tr&gt;&#xD;&#xA;&lt;/table&gt;" trackingEmail="" />
</xsl:stylesheet>