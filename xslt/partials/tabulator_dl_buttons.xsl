<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
    <xsl:template name="tabulator_dl_buttons">
        <div class="pt-3 text-end">
            <h4>Download Table</h4>
            <div class="button-group">
                <button type="button" class="btn btn-outline-secondary" id="download-csv"
                    title="Download CSV">
                    <i class="bi bi-filetype-csv"/>
                    <span class="visually-hidden">Download CSV</span>
                </button>
                <button type="button" class="btn btn-outline-secondary" id="download-json"
                    title="Download JSON">
                    <i class="bi bi-filetype-json"/>
                    <span class="visually-hidden">Download JSON</span>
                </button>
                <button type="button" class="btn btn-outline-secondary" id="download-html"
                    title="Download HTML">
                    <i class="bi bi-filetype-html"/>
                    <span class="visually-hidden">Download HTML</span>
                </button>
            </div>
        </div>
    </xsl:template>
</xsl:stylesheet>
