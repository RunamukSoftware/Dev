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
    <style type="text/css">
.normal, .normalBold {font-family: Verdana, Tahoma, Arial, Helvetica;font-size: 11px;font-weight: normal;}
.normalBold{font-weight: bold;}
</style>
    <table>
      <tr>
        <td class="normalBold">First Name</td>
        <td class="Normal">
          <xsl:value-of select="udt:First_x0020_Name" disable-output-escaping="yes" />
        </td>
      </tr>
      <tr>
        <td class="normalBold">Last Name</td>
        <td class="Normal">
          <xsl:value-of select="udt:Last_x0020_Name" disable-output-escaping="yes" />
        </td>
      </tr>
      <tr>
        <td class="normalBold">Phone Number</td>
        <td class="Normal">
          <xsl:value-of select="udt:Phone_x0020_Number" disable-output-escaping="yes" />
        </td>
      </tr>
      <tr>
        <td class="normalBold">Email Address</td>
        <td class="Normal">
          <xsl:value-of select="udt:Email_x0020_Address" disable-output-escaping="yes" />
        </td>
      </tr>
      <tr>
        <td class="normalBold">Response Method</td>
        <td class="Normal">
          <xsl:value-of select="udt:Response_x0020_Method" disable-output-escaping="yes" />
        </td>
      </tr>
      <tr>
        <td class="normalBold">Message</td>
        <td class="Normal">
          <xsl:value-of select="udt:Message" disable-output-escaping="yes" />
        </td>
      </tr>
      <tr>
        <td class="normalBold">Created by</td>
        <td class="Normal">
          <xsl:value-of select="udt:Created_x0020_by" disable-output-escaping="yes" />
        </td>
      </tr>
      <tr>
        <td class="normalBold">Created at</td>
        <td class="Normal">
          <xsl:value-of select="udt:Created_x0020_at_UDT_Value" disable-output-escaping="yes" />
        </td>
      </tr>
      <tr>
        <td class="normalBold">Changed by</td>
        <td class="Normal">
          <xsl:value-of select="udt:Changed_x0020_by" disable-output-escaping="yes" />
        </td>
      </tr>
      <tr>
        <td class="normalBold">Changed at</td>
        <td class="Normal">
          <xsl:value-of select="udt:Changed_x0020_at_UDT_Value" disable-output-escaping="yes" />
        </td>
      </tr>
    </table>
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
<udt:template listType="table" delimiter=";" listView="" headerView="" detailView="" trackingEmail="&lt;style type=&quot;text/css&quot;&gt;&#xD;&#xA;.normal, .normalBold {font-family: Verdana, Tahoma, Arial, Helvetica;font-size: 11px;font-weight: normal;}&#xD;&#xA;.normalBold{font-weight: bold;}&#xD;&#xA;&lt;/style&gt;&#xD;&#xA;&lt;table&gt;&#xD;&#xA;  &lt;tr&gt;&#xD;&#xA;    &lt;td class=&quot;normalBold&quot;&gt;First Name&lt;/td&gt;&#xD;&#xA;    &lt;td class=&quot;Normal&quot;&gt;[First Name]&lt;/td&gt;&#xD;&#xA;  &lt;/tr&gt;&#xD;&#xA;  &lt;tr&gt;&#xD;&#xA;    &lt;td class=&quot;normalBold&quot;&gt;Last Name&lt;/td&gt;&#xD;&#xA;    &lt;td class=&quot;Normal&quot;&gt;[Last Name]&lt;/td&gt;&#xD;&#xA;  &lt;/tr&gt;&#xD;&#xA;  &lt;tr&gt;&#xD;&#xA;    &lt;td class=&quot;normalBold&quot;&gt;Phone Number&lt;/td&gt;&#xD;&#xA;    &lt;td class=&quot;Normal&quot;&gt;[Phone Number]&lt;/td&gt;&#xD;&#xA;  &lt;/tr&gt;&#xD;&#xA;  &lt;tr&gt;&#xD;&#xA;    &lt;td class=&quot;normalBold&quot;&gt;Email Address&lt;/td&gt;&#xD;&#xA;    &lt;td class=&quot;Normal&quot;&gt;[Email Address]&lt;/td&gt;&#xD;&#xA;  &lt;/tr&gt;&#xD;&#xA;  &lt;tr&gt;&#xD;&#xA;    &lt;td class=&quot;normalBold&quot;&gt;Response Method&lt;/td&gt;&#xD;&#xA;    &lt;td class=&quot;Normal&quot;&gt;[Response Method]&lt;/td&gt;&#xD;&#xA;  &lt;/tr&gt;&#xD;&#xA;  &lt;tr&gt;&#xD;&#xA;    &lt;td class=&quot;normalBold&quot;&gt;Message&lt;/td&gt;&#xD;&#xA;    &lt;td class=&quot;Normal&quot;&gt;[Message]&lt;/td&gt;&#xD;&#xA;  &lt;/tr&gt;&#xD;&#xA;  &lt;tr&gt;&#xD;&#xA;    &lt;td class=&quot;normalBold&quot;&gt;Created by&lt;/td&gt;&#xD;&#xA;    &lt;td class=&quot;Normal&quot;&gt;[Created by]&lt;/td&gt;&#xD;&#xA;  &lt;/tr&gt;&#xD;&#xA;  &lt;tr&gt;&#xD;&#xA;    &lt;td class=&quot;normalBold&quot;&gt;Created at&lt;/td&gt;&#xD;&#xA;    &lt;td class=&quot;Normal&quot;&gt;[Created at_UDT_Value]&lt;/td&gt;&#xD;&#xA;  &lt;/tr&gt;&#xD;&#xA;  &lt;tr&gt;&#xD;&#xA;    &lt;td class=&quot;normalBold&quot;&gt;Changed by&lt;/td&gt;&#xD;&#xA;    &lt;td class=&quot;Normal&quot;&gt;[Changed by]&lt;/td&gt;&#xD;&#xA;  &lt;/tr&gt;&#xD;&#xA;  &lt;tr&gt;&#xD;&#xA;    &lt;td class=&quot;normalBold&quot;&gt;Changed at&lt;/td&gt;&#xD;&#xA;    &lt;td class=&quot;Normal&quot;&gt;[Changed at_UDT_Value]&lt;/td&gt;&#xD;&#xA;  &lt;/tr&gt;&#xD;&#xA;&lt;/table&gt;" isTrackingMode="true" />
</xsl:stylesheet>