<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fo="http://www.w3.org/1999/XSL/Format">

  <xsl:output method="xml" indent="yes"/>

  <xsl:template match="/handball_data">
    <fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
      <fo:layout-master-set>
        <fo:simple-page-master master-name="A4" page-height="29.7cm" page-width="21cm" margin="2cm">
          <fo:region-body/>
        </fo:simple-page-master>
      </fo:layout-master-set>

      <fo:page-sequence master-reference="A4">
        <fo:flow flow-name="xsl-region-body">
          
          <fo:block font-size="14pt" font-weight="bold" space-after="10pt">
            Handball Season Summary
          </fo:block>
          
          <fo:block>
            <xsl:text>Season: </xsl:text>
            <xsl:value-of select="season/name"/>
            <xsl:text> (</xsl:text>
            <xsl:value-of select="season/year"/>
            <xsl:text>)</xsl:text>
          </fo:block>

          <fo:block font-weight="bold" space-before="10pt">Standings:</fo:block>
          
          <xsl:for-each select="standings/team">
            <fo:block>
              <xsl:value-of select="rank"/>. 
              <xsl:value-of select="name"/>
            </fo:block>
          </xsl:for-each>

        </fo:flow>
      </fo:page-sequence>
    </fo:root>
  </xsl:template>

</xsl:stylesheet>