<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:output method="html"/>
  <xsl:template match="/ClientExportReport">
    <html>
      <head>
        <title>GALSync Client Export Report</title>
      </head>
      <body>
        <h1>GALSync Client Export Report</h1>
        <xsl:apply-templates select="." mode="General"/>
        <xsl:apply-templates select="Update" mode="Update"/>
        <xsl:apply-templates select="Summary" mode="Summary"/>
        <xsl:apply-templates select="ConfigurationParameters" mode="ConfigurationParameters"/>
        <xsl:apply-templates select="Errors" mode="Errors"/>
        <xsl:apply-templates select="Warnings" mode="Warnings"/>
        <xsl:apply-templates select="InvalidReferences" mode="InvalidReferences"/>
      </body>
    </html>
  </xsl:template>
  <xsl:template match="/ClientExportReport" mode="General">
    <p>
      <h2>General Information</h2>
      <table border="1" width="100%">
        <tr>
          <td>Report Creation Time</td>
          <td>
            <xsl:value-of select="ReportCreationTime"/>
          </td>
        </tr>
        <tr>
          <td>Begin Export Time</td>
          <td>
            <xsl:value-of select="BeginExportTime"/>
          </td>
        </tr>
        <tr>
          <td>End Export Time</td>
          <td>
            <xsl:value-of select="EndExportTime"/>
          </td>
        </tr>
      </table>
    </p>
  </xsl:template>
  <xsl:template match="/ClientExportReport/Summary" mode="Summary">
    <p>
      <h2>Summary</h2>
      <xsl:for-each select="*">
        <p>
          <xsl:value-of select="name(.)"/>
        </p>
        <table border="1" width="100%">
          <tr>
            <td>&#xa0;</td>
            <td>Succeed</td>
            <td>Failed</td>
            <td>Total</td>
          </tr>
          <xsl:for-each select="*">
            <tr>
              <td>
                <xsl:value-of select="name(.)"/>
              </td>
              <td>
                <xsl:value-of select="@Succeed"/>
              </td>
              <td>
                <xsl:value-of select="@Failed"/>
              </td>
              <td>
                <xsl:value-of select="sum(@*)"/>
              </td>
            </tr>
          </xsl:for-each>
        </table>
      </xsl:for-each>
  </p>
  </xsl:template>
  <xsl:template match="/ClientExportReport/ConfigurationParameters" mode="ConfigurationParameters">
    <p>
      <h2>Configuration Parameters</h2>
      <table border="1" width="100%">
        <xsl:for-each select="Parameter">
          <tr>
            <td>
              <xsl:value-of select="@Name"/>
            </td>
            <td>
              <xsl:value-of select="."/>&#xa0;
            </td>
          </tr>
        </xsl:for-each>
      </table>
    </p>
  </xsl:template>
  <xsl:template match="/ClientExportReport/Errors" mode="Errors">
    <p>
      <h2>Errors</h2>
      <xsl:for-each select="Entry">
        <table border="1" width="100%">
          <tr>
            <td>DN</td>
            <td>
              <xsl:value-of select="@DN"/>
            </td>
          </tr>
          <xsl:for-each select="*">
            <tr>
              <td>
                <xsl:value-of select="name(.)"/>
              </td>
              <td>
                <xsl:value-of select="."/>
              </td>
            </tr>
          </xsl:for-each>
        </table>
      </xsl:for-each>
    </p>
  </xsl:template>
  <xsl:template match="/ClientExportReport/Warnings" mode="Warnings">
    <p>
      <h2>Warnings</h2>
      <xsl:for-each select="Entry">
        <table border="1" width="100%">
          <tr>
            <td>DN</td>
            <td>
              <xsl:value-of select="@DN"/>
            </td>
          </tr>
          <xsl:for-each select="*">
            <tr>
              <td>
                <xsl:value-of select="name(.)"/>
              </td>
              <td>
                <xsl:value-of select="."/>
              </td>
            </tr>
          </xsl:for-each>
        </table>
      </xsl:for-each>
    </p>
  </xsl:template>
  <xsl:template match="/ClientExportReport/Update" mode="Update">
    <p>
      <h2>Update</h2>
      <table border="1" width="100%">
        <tr>
          <td>Current GALSync Binary Version</td>
          <td>
            <xsl:value-of select="@CurrentBinaryVersion"/>
          </td>
        </tr>
        <tr>
          <td>New GALSync Binary Version</td>
          <td>
            <xsl:value-of select="@NewBinaryVersion"/>
          </td>
        </tr>
        <tr>
          <td>Download URL</td>
          <td>
            <xsl:value-of select="@DownloadURL"/>
          </td>
        </tr>
      </table>
    </p>
  </xsl:template>
  <xsl:template match="/ClientExportReport/InvalidReferences" mode="InvalidReferences">
    <p>
      <h2>Invalid Reference</h2>
      <table border="1" width="100%">
        <tr>
          <td>Entry DN</td>
          <td>Entry Primary SMTP Address</td>
          <td>Attribute</td>
          <td>Reference</td>
        </tr>
        <xsl:for-each select="InvalidReference">
          <tr>
            <td>
              <xsl:value-of select="Entry/@DN"/>
            </td>
            <td>
              <xsl:value-of select="Entry"/>
            </td>
            <td>
              <xsl:value-of select="Attribute"/>
            </td>
            <td>
              <xsl:for-each select="Reference">
                [<xsl:value-of select="@DN"/>] <xsl:value-of select="."/><br/>
              </xsl:for-each>
            </td>
          </tr>
        </xsl:for-each>
      </table>
    </p>
  </xsl:template>
</xsl:stylesheet>