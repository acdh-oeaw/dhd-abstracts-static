<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    version="2.0" exclude-result-prefixes="xsl tei xs">
    
    <xsl:output encoding="UTF-8" media-type="text/html" method="html" version="5.0" indent="yes"
        omit-xml-declaration="yes"/>
    
    <xsl:import href="./partials/html_navbar.xsl"/>
    <xsl:import href="./partials/html_head.xsl"/>
    <xsl:import href="partials/html_footer.xsl"/>
    <xsl:template match="/">
        <xsl:variable name="doc_title" select="'Volltextsuche'"/>
        <html lang="de" class="h-100">
            <head>
                <xsl:call-template name="html_head">
                    <xsl:with-param name="html_title" select="$doc_title"/>
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
                            <li class="breadcrumb-item active" aria-current="page"><xsl:value-of select="$doc_title"/></li>
                        </ol>
                    </nav>
                    <div class="container pt-3">
                        
                        <div class="text-center p-3">
                            <h1 class="text-center display-2 pt-3">
                                <xsl:value-of select="$doc_title"/>
                            </h1>
                            <div id="searchbox"/>
                            <div id="stats-container"/>
                            <div id="current-refinements"/>
                            <div id="clear-refinements"/>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-3">
                                <h2>Facets</h2>
                                <div id="refinement-list-year" class="pb-3"></div>
                                <div id="refinement-list-authors" class="pb-3"></div>
                                <div id="refinement-list-category" class="pb-3"></div>
                                <div id="refinement-list-subcategory" class="pb-3"></div>
                                <div id="refinement-list-topics" class="pb-3"></div>
                                <div id="refinement-list-keywords" class="pb-3"></div>
                            </div>
                            <div class="col-md-9">
                                <div id="pagination" class="p-3"/>
                                <div id="hits"/>
                            </div>
                        </div>
                        
                    </div>
                </main>
                <xsl:call-template name="html_footer"/>
                <link rel="stylesheet"
                    href="https://cdn.jsdelivr.net/npm/instantsearch.css@7/themes/algolia-min.css"/>
                <script src="https://cdn.jsdelivr.net/npm/instantsearch.js@4.46.0"/>
                <script src="https://cdn.jsdelivr.net/npm/typesense-instantsearch-adapter@2/dist/typesense-instantsearch-adapter.min.js"/>
                <script src="js/search.js"/>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
