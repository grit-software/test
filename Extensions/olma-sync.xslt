<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:output method="html"/>
  <xsl:template match="/ClientReport">
    <html>
      <head>
        <title>GALSync Client Hosted Management Agent Report</title>
      </head>
      <body>
        <h1>GALSync Client Hosted Management Agent Report</h1>
        <xsl:apply-templates select="." mode="General"/>
        <xsl:apply-templates select="DisconnectEntries" mode="DisconnectEntries"/>
        <xsl:apply-templates select="FilterEntries" mode="FilterEntries"/>
        <xsl:apply-templates select="InvalidAttributes" mode="InvalidAttributes"/>
      </body>
    </html>
  </xsl:template>
  <xsl:template match="/ClientReport" mode="General">
    <p>
      <h2>General Information</h2>
      <table border="1" width="100%">
        <tr>
          <td>Report Creation Time</td>
          <td>
            <xsl:value-of select="ReportCreationTime"/>
          </td>
        </tr>
      </table>
    </p>
  </xsl:template>
  <xsl:template match="/ClientReport/DisconnectEntries" mode="DisconnectEntries">
    <p>
      <h2>Disconnect Entries</h2>
      <table border="1" width="100%">
        <tr>
          <td>
            <b>DN</b>
          </td>
          <td>
            <b>Type</b>
          </td>
          <td>
            <b>Windows Live ID</b>
          </td>
          <td>
            <b>Disconnect Reason</b>
          </td>
        </tr>
        <xsl:for-each select="Entry">
          <tr>
            <td>
              <xsl:value-of select="@DN"/>
            </td>
            <td>
              <xsl:value-of select="Type"/>
            </td>
            <td>
              <xsl:value-of select="WindowsLiveID"/>
            </td>
            <td>
              <xsl:value-of select="DisconnectReason"/>
            </td>
          </tr>
        </xsl:for-each>
      </table>
    </p>
  </xsl:template>
    <xsl:template match="/ClientReport/FilterEntries" mode="FilterEntries">
        <p>
            <h2>Filter Entries</h2>
            <table border="1" width="100%">
                <tr>
                    <td>
                        <b>DN</b>
                    </td>
                    <td>
                        <b>Type</b>
                    </td>
                    <td>
                        <b>Category</b>
                    </td>
                    <td>
                        <b>Filter Reason</b>
                    </td>
                </tr>
                <xsl:for-each select="Entry">
                    <tr>
                        <td>
                            <xsl:value-of select="@DN"/>
                        </td>
                        <td>
                            <xsl:value-of select="Type"/>
                        </td>
                        <td>
                            <xsl:value-of select="Category"/>
                        </td>
                        <td>
                            <xsl:value-of select="FilterReason"/>
                        </td>
                    </tr>
                </xsl:for-each>
            </table>
        </p>
    </xsl:template>
    <xsl:template match="/ClientReport/InvalidAttributes" mode="InvalidAttributes">
        <p>
            <h2>Filter Invalid Attributes</h2>
            <table border="1" width="100%">
                <tr>
                    <td>
                        <b>Entry</b>
                    </td>
                    <td>
                        <b>Type</b>
                    </td>
                    <td>
                        <b>Attribute</b>
                    </td>
                    <td>
                        <b>Value</b>
                    </td>
                    <td>
                        <b>Message</b>
                    </td>
                </tr>
                <xsl:for-each select="InvalidAttribute">
                    <tr>
                        <td>
                            <xsl:value-of select="Entry"/>
                        </td>
                        <td>
                            <xsl:value-of select="Type"/>
                        </td>
                        <td>
                            <xsl:value-of select="Attribute"/>
                        </td>
                        <td>
                            <xsl:value-of select="Value"/>
                        </td>
                        <td>
                            <xsl:value-of select="Message"/>
                        </td>
                    </tr>
                </xsl:for-each>
            </table>
        </p>
    </xsl:template>
</xsl:stylesheet>