<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:local="http://dse-static.foo.bar"
    version="2.0" exclude-result-prefixes="xsl tei xs local">
    <xsl:output encoding="UTF-8" media-type="text/html" method="html" version="5.0" indent="yes" omit-xml-declaration="yes"/>

    <xsl:import href="./partials/html_head.xsl"/>
    <xsl:import href="./partials/html_navbar.xsl"/>
    <xsl:import href="./partials/html_footer.xsl"/>
    <xsl:import href="./partials/one_time_alert.xsl"/>

    <xsl:template match="/">
        <xsl:variable name="doc_title">
            <xsl:value-of select='"DHd-Abstracts"'/>
        </xsl:variable>
        <html class="h-100" lang="de">
            <head>
                <xsl:call-template name="html_head">
                    <xsl:with-param name="html_title" select="$doc_title"></xsl:with-param>
                </xsl:call-template>
            </head>            
            <body class="d-flex flex-column h-100">
                <xsl:call-template name="nav_bar"/>
                <main class="flex-shrink-0 flex-grow-1">
                    <div class="px-4 py-5 my-5 text-center">
                            <h1 class="display-5 fw-bold text-body-emphasis">DHd Abstracts</h1>
                            <div class="col-lg-6 mx-auto">
                                <p class="lead mb-4">Auf dieser Seite können Sie alle Abstracts der vergangenen DHd-Konferenzen im Volltext durchsuchen. Die Daten dafür wurden vom <a href="https://github.com/DHd-Verband">DHd-Verband via GitHub-Repos</a> veröffentlicht.</p>
                                <div class="d-grid gap-2 d-sm-flex justify-content-sm-center">
                                    <a href="search.html" class="btn btn-outline-secondary btn-lg px-4 gap-3">Suchen</a>
                                    <a href="toc.html" class="btn btn-outline-secondary btn-lg px-4">Stöbern</a>
                                </div>
                            </div>
                    </div>
                </main>
                <xsl:call-template name="html_footer"/>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>