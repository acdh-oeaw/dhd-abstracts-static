<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:local="http://dse-static.foo.bar"
    version="2.0" exclude-result-prefixes="xsl tei xs local">
    <xsl:output encoding="UTF-8" media-type="text/html" method="html" version="5.0" indent="yes" omit-xml-declaration="yes"/>
    
    <xsl:import href="./partials/shared.xsl"/>
    <xsl:import href="./partials/html_navbar.xsl"/>
    <xsl:import href="./partials/html_head.xsl"/>
    <xsl:import href="./partials/html_footer.xsl"/>

    <xsl:variable name="prev">
        <xsl:value-of select="replace(tokenize(data(tei:TEI/@prev), '/')[last()], '.xml', '.html')"/>
    </xsl:variable>
    <xsl:variable name="next">
        <xsl:value-of select="replace(tokenize(data(tei:TEI/@next), '/')[last()], '.xml', '.html')"/>
    </xsl:variable>
    <xsl:variable name="teiSource">
        <xsl:value-of select="data(tei:TEI/@xml:id)"/>
    </xsl:variable>
    <xsl:variable name="link">
        <xsl:value-of select="replace($teiSource, '.xml', '.html')"/>
    </xsl:variable>
    <xsl:variable name="doc_title">
        <xsl:value-of select=".//tei:titleStmt/tei:title[1]/text()"/>
    </xsl:variable>


    <xsl:template match="/">
        <html class="h-100" lang="de">
            <head>
                <xsl:call-template name="html_head">
                    <xsl:with-param name="html_title" select="$doc_title"></xsl:with-param>
                </xsl:call-template>
            </head>
            <body class="d-flex flex-column h-100">
                <xsl:call-template name="nav_bar"/>
                <main class="flex-shrink-0 flex-grow-1">
                    <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb" class="ps-5 p-3">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item">
                                <a href="index.html"><xsl:value-of select="$project_short_title"/></a>
                            </li>
                            <li class="breadcrumb-item">
                                <a href="toc.html">Alle Abstracts</a>
                            </li>
                            <li class="breadcrumb-item active" aria-current="page"><xsl:value-of select="$doc_title"/></li>
                        </ol>
                    </nav>
                    <div class="container">
                        <div class="row">
                            <div class="col-md-2 col-lg-2 col-sm-12 text-start">
                                <xsl:if test="ends-with($prev,'.html')">
                                    <a>
                                        <xsl:attribute name="href">
                                            <xsl:value-of select="$prev"/>
                                        </xsl:attribute>
                                        <i class="fs-2 bi bi-chevron-left" title="Zurück zum vorigen Dokument" visually-hidden="true">
                                            <span class="visually-hidden">Zurück zum vorigen Dokument</span>
                                        </i>
                                    </a>
                                </xsl:if>
                            </div>
                            <div class="col-md-8 col-lg-8 col-sm-12 text-center">
                                <h1>
                                    <xsl:value-of select="$doc_title"/>
                                </h1>
                                <div>
                                    <cite title="Autor*Innen">
                                        <xsl:value-of select="string-join(//tei:titleStmt//tei:persName/@n, '; ')"/>
                                        <xsl:choose>
                                            <xsl:when test=".//tei:idno[@subtype='zenodo']">
                                                <br />
                                                <a>
                                                    <xsl:attribute name="href">
                                                        <xsl:value-of select=".//tei:idno[@subtype='zenodo']/text()"/>
                                                    </xsl:attribute>
                                                    <xsl:value-of select=".//tei:idno[@subtype='zenodo']/text()"/>
                                                </a>
                                            </xsl:when>
                                        </xsl:choose>
                                    </cite>
                                </div>
                                <div>
                                    <a href="{$teiSource}">
                                        <i class="bi bi-download fs-2" title="Zum TEI/XML Dokument" visually-hidden="true">
                                            <span class="visually-hidden">Zum TEI/XML Dokument</span>
                                        </i>
                                    </a>
                                </div>
                            </div>
                            <div class="col-md-2 col-lg-2 col-sm-12 text-end">
                                <xsl:if test="ends-with($next, '.html')">
                                    <a>
                                        <xsl:attribute name="href">
                                            <xsl:value-of select="$next"/>
                                        </xsl:attribute>
                                        <i class="fs-2 bi bi-chevron-right" title="Weiter zum nächsten Dokument" visually-hidden="true">
                                            <span class="visually-hidden">Weiter zum nächsten Dokument</span>
                                        </i>
                                    </a>
                                </xsl:if>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-2"></div>
                            <div class="col-lg-8">
                                <xsl:apply-templates select=".//tei:body"></xsl:apply-templates>
                                <xsl:if test=".//tei:div[contains(@type, 'otes')]">
                                    <hr />
                                    <h2>Fußnoten</h2>
                                    <xsl:for-each select=".//tei:div[contains(@type, 'otes')]/tei:note">
                                        <div>
                                            <a id="{'ftn'||@n}" href="{'#ftn_a'||@n}">
                                                <sup>
                                                    <xsl:value-of select="./@n"/>
                                                </sup>
                                            </a>
                                            <xsl:text> </xsl:text>
                                            <xsl:apply-templates/>
                                        </div>
                                    </xsl:for-each>
                                </xsl:if>
                                <xsl:if test=".//tei:listBibl">
                                    <hr />
                                    <h2>Bibliographie</h2>
                                    <ul>
                                        <xsl:for-each select=".//tei:listBibl//tei:bibl">
                                            <li><xsl:apply-templates/></li>
                                        </xsl:for-each>
                                    </ul>
                                </xsl:if>
                            </div>
                            <div class="col-lg-2"></div>
                        </div>
                        
                    </div>
                </main>
                <xsl:call-template name="html_footer"/>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
