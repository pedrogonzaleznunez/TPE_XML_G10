<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="html" encoding="UTF-8" indent="yes" />

    <!-- Root -->
    <xsl:template match="data">
        <html>
            <body>
                <xsl:choose>
                    <xsl:when test="error">                        
                        <!-- Mostrar mensajes de error -->
                        <h1 style="color: red; text-align: center;">Error</h1>
                        <xsl:for-each
                            select="error">
                            <div style="color: red; font-weight: bold; text-align: center;">
                                <xsl:value-of select="." />
                            </div>
                        </xsl:for-each>
                    </xsl:when>
                    <xsl:otherwise>
                        <!-- Congreso Titulo Principal -->
                        <h1 align="center">
                            <xsl:value-of select="congress/name" />
                        </h1>
                        <h3
                            align="center"> From <xsl:value-of select="congress/period/@from" /> to <xsl:value-of
                                select="congress/period/@to" />
                        </h3>
                    <hr />

                        <!-- House of Representatives -->
                    <h2 align="center">House of Representatives</h2>
                    <h4 align="center">Members</h4>
                    <table
                            border="1" frame="1" align="center">
                            <thead bgcolor="grey">
                                <tr>
                                    <th>Image</th>
                                    <th>Name</th>
                                    <th>State</th>
                                    <th>Party</th>
                                    <th>Period</th>
                                </tr>
                            </thead>
                            <tbody>
                                <xsl:for-each
                                    select="congress/chambers/chamber[name = 'House of Representatives']/members/member">
                                    <tr>
                                        <td>
                                            <img height="50" width="50">
                                                <xsl:attribute name="src">
                                                    <xsl:value-of select="image_url" />
                                                </xsl:attribute>
                                            </img>
                                        </td>
                                        <td>
                                            <xsl:value-of select="name" />
                                        </td>
                                        <td>
                                            <xsl:value-of select="state" />
                                        </td>
                                        <td>
                                            <xsl:value-of select="party" />
                                        </td>
                                        <td> From <xsl:value-of select="period/@from" />
                                    <xsl:if
                                                test="period/@to != ''"> to <xsl:value-of
                                                    select="period/@to" />
                                            </xsl:if>
                                        </td>
                                    </tr>
                                </xsl:for-each>
                            </tbody>
                        </table>

                <h4 align="center">Sessions</h4>
                <table border="1" frame="1" align="center">
                            <thead bgcolor="grey">
                                <tr>
                                    <th>Number</th>
                                    <th>Type</th>
                                    <th>Period</th>
                                </tr>
                            </thead>
                            <tbody>
                                <xsl:for-each select="congress/chambers/chamber[name = 'House of Representatives']/sessions/session">
                                    <xsl:sort select="number" order="ascending" data-type="number"/>
                                    <tr>
                                        <td>
                                            <xsl:value-of select="number" />
                                        </td>
                                        <td>
                                            <xsl:value-of select="type" />
                                        </td>
                                        <td> From <xsl:value-of select="period/@from" /> to <xsl:value-of
                                                select="period/@to" />
                                        </td>
                                    </tr>
                                </xsl:for-each>
                            </tbody>
                        </table>

            <hr />

                        <!-- Senate -->
            <h2 align="center">Senate</h2>
            <h4 align="center">Members</h4>
            <table
                            border="1" frame="1" align="center">
                            <thead bgcolor="grey">
                                <tr>
                                    <th>Image</th>
                                    <th>Name</th>
                                    <th>State</th>
                                    <th>Party</th>
                                    <th>Period</th>
                                </tr>
                            </thead>
                            <tbody>
                                <xsl:for-each
                                    select="congress/chambers/chamber[name = 'Senate']/members/member">
                                    <tr>
                                        <td>
                                            <img height="50" width="50">
                                                <xsl:attribute name="src">
                                                    <xsl:value-of select="image_url" />
                                                </xsl:attribute>
                                            </img>
                                        </td>
                                        <td>
                                            <xsl:value-of select="name" />
                                        </td>
                                        <td>
                                            <xsl:value-of select="state" />
                                        </td>
                                        <td>
                                            <xsl:value-of select="party" />
                                        </td>
                                        <td> From <xsl:value-of select="period/@from" />
                            <xsl:if
                                                test="period/@to != ''"> to <xsl:value-of
                                                    select="period/@to" />
                                            </xsl:if>
                                        </td>
                                    </tr>
                                </xsl:for-each>
                            </tbody>
                        </table>

        <h4 align="center">Sessions</h4>
        <table border="1" frame="1" align="center">
                            <thead bgcolor="grey">
                                <tr>
                                    <th>Number</th>
                                    <th>Type</th>
                                    <th>Period</th>
                                </tr>
                            </thead>
                            <tbody>
                                <xsl:for-each select="congress/chambers/chamber[name = 'Senate']/sessions/session">
                                    <xsl:sort select="number" order="ascending" data-type="number"/>
                                    <tr>
                                        <td>
                                            <xsl:value-of select="number" />
                                        </td>
                                        <td>
                                            <xsl:value-of select="type" />
                                        </td>
                                        <td> From <xsl:value-of select="period/@from" /> to <xsl:value-of
                                                select="period/@to" />
                                        </td>
                                    </tr>
                                </xsl:for-each>
                            </tbody>
                        </table>
                    </xsl:otherwise>
                </xsl:choose>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>