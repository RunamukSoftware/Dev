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
    <tr class="dnnGridItem">
      <td>
        <xsl:call-template name="EditLink" />
      </td>
      <td>
        <a href="{udt:LinkURL_UDT_Url}" target="_blank">
          <xsl:value-of select="udt:Category" disable-output-escaping="yes" /> - <xsl:value-of select="udt:Title" disable-output-escaping="yes" /></a>
      </td>
    </tr>
  </xsl:template>

  <xsl:template match="/udt:UserDefinedTable">
    <xsl:variable name="currentData" select="udt:Data" />
    <xsl:if test="$currentData">
      <table class="dnnFormItem">
        <xsl:apply-templates select="$currentData" mode="list">
        </xsl:apply-templates>
      </table>
    </xsl:if>
  </xsl:template>

  <xsl:template name="EditLink">
    <xsl:if test="udt:EditLink">
      <a href="{udt:EditLink}">
        <img border="0" alt="edit" src="{//udt:Context/udt:ApplicationPath}/images/edit.gif" />
      </a>
    </xsl:if>
  </xsl:template>
<udt:template listType="table" delimiter=";" listView="&lt;tr class=&quot;dnnGridItem&quot;&gt;&#xD;&#xA;  &lt;td&gt;[UDT:EditLink]&lt;/td&gt;&#xD;&#xA;  &lt;td&gt;&lt;a href=&quot;[LinkURL_UDT_Url]&quot; target=&quot;_blank&quot;&gt;[Category] - [Title]&lt;/a&gt;&lt;/td&gt;&#xD;&#xA;&lt;/tr&gt;" headerView="" detailView="[UDT:ListView][UDT:EditLink]&#xD;&#xA;&lt;table&gt;&#xD;&#xA;  &lt;tr&gt;&#xD;&#xA;    &lt;td class=&quot;normalBold&quot;&gt;Category&lt;/td&gt;&#xD;&#xA;    &lt;td class=&quot;Normal&quot;&gt;[Category]&lt;/td&gt;&#xD;&#xA;  &lt;/tr&gt;&#xD;&#xA;  &lt;tr&gt;&#xD;&#xA;    &lt;td class=&quot;normalBold&quot;&gt;Title&lt;/td&gt;&#xD;&#xA;    &lt;td class=&quot;Normal&quot;&gt;[Title]&lt;/td&gt;&#xD;&#xA;  &lt;/tr&gt;&#xD;&#xA;  &lt;tr&gt;&#xD;&#xA;    &lt;td class=&quot;normalBold&quot;&gt;Link URL&lt;/td&gt;&#xD;&#xA;    &lt;td class=&quot;Normal&quot;&gt;[Link URL]&lt;/td&gt;&#xD;&#xA;  &lt;/tr&gt;&#xD;&#xA;  &lt;tr&gt;&#xD;&#xA;    &lt;td class=&quot;normalBold&quot;&gt;Created by&lt;/td&gt;&#xD;&#xA;    &lt;td class=&quot;Normal&quot;&gt;[Created by]&lt;/td&gt;&#xD;&#xA;  &lt;/tr&gt;&#xD;&#xA;  &lt;tr&gt;&#xD;&#xA;    &lt;td class=&quot;normalBold&quot;&gt;Created at&lt;/td&gt;&#xD;&#xA;    &lt;td class=&quot;Normal&quot;&gt;[Created at_UDT_Value]&lt;/td&gt;&#xD;&#xA;  &lt;/tr&gt;&#xD;&#xA;  &lt;tr&gt;&#xD;&#xA;    &lt;td class=&quot;normalBold&quot;&gt;Changed by&lt;/td&gt;&#xD;&#xA;    &lt;td class=&quot;Normal&quot;&gt;[Changed by]&lt;/td&gt;&#xD;&#xA;  &lt;/tr&gt;&#xD;&#xA;  &lt;tr&gt;&#xD;&#xA;    &lt;td class=&quot;normalBold&quot;&gt;Changed at&lt;/td&gt;&#xD;&#xA;    &lt;td class=&quot;Normal&quot;&gt;[Changed at_UDT_Value]&lt;/td&gt;&#xD;&#xA;  &lt;/tr&gt;&#xD;&#xA;&lt;/table&gt;" trackingEmail="" />
</xsl:stylesheet>