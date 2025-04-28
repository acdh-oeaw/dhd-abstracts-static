<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:template match="tei:figure">
        <figure class="figure">
            <svg class="bd-placeholder-img card-img-top" width="100%" height="180" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Placeholder" preserveAspectRatio="xMidYMid slice"><title>Placeholder</title><rect width="100%" height="100%" fill="#868e96"></rect></svg>
                <figcaption class="figure-caption">
                    <xsl:value-of select="./tei:*"/>
                </figcaption>
        </figure>
    </xsl:template>
    
    <xsl:template match="tei:div">
        <div><xsl:apply-templates/></div>
    </xsl:template>
    
   
    <xsl:template match="tei:lb">
        <br/>
    </xsl:template>
    
    <xsl:template match="tei:quote">
        <blockquote class="blockquote">
            <p><xsl:apply-templates/></p>
        </blockquote>
    </xsl:template>
    
    <xsl:template match="tei:ref">
        <a class="ref {@type}" href="{@target}">
            <xsl:apply-templates/>
        </a>
    </xsl:template>
    
    <xsl:template match="tei:ref[@n]">
        <a id="{'ftn_a'||@n}" href="{'#ftn'||@n}">
            <sup>
                <xsl:value-of select="@n"/>
            </sup>
        </a>
        <xsl:text>&#160;</xsl:text>
    </xsl:template>

    

    <xsl:template match="tei:list[@type='unordered']">
        <xsl:choose>
            <xsl:when test="ancestor::tei:body">
                <ul class="yes-index">
                    <xsl:apply-templates/>
                </ul>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="tei:item">
        <xsl:choose>
            <xsl:when test="parent::tei:list[@type='unordered']|ancestor::tei:body">
                <li><xsl:apply-templates/></li>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    

    
    <xsl:template match="tei:p">
       <p><xsl:apply-templates/></p>
    </xsl:template>
    
    <xsl:template match="tei:table/tei:head"/>
    
    <xsl:template match="tei:table">
        <xsl:element name="table">
            <xsl:attribute name="class">
                <xsl:text>table table-bordered table-striped table-condensed table-hover</xsl:text>
            </xsl:attribute>
            <xsl:choose>
                <xsl:when test="./tei:head">
                    <caption><xsl:value-of select="."/></caption>
                </xsl:when>
            </xsl:choose>
            <xsl:element name="tbody">
                <xsl:apply-templates/>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    <xsl:template match="tei:row">
        <xsl:element name="tr">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="tei:cell">
        <xsl:element name="td">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="tei:head">
        <xsl:variable name="level">
            <xsl:value-of select="count(ancestor-or-self::tei:div)"/>
        </xsl:variable>
        <xsl:element name="{concat('h', $level + 1)}">
            <xsl:attribute name="class">
                <xsl:value-of select="'text-start'"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
</xsl:stylesheet>
