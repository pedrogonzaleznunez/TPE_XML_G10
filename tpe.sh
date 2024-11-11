#!/bin/bash

# Importar la libreria de funciones 
source tools/lib.sh

CONGRESS_NUMBER=$1
CONGRESS_INFO="data/congress_info.xml"
CONGRESS_MEMBERS_INFO="data/congress_members_info.xml"
CONGRESS_DATA="data/congress_data.xml"
CONGRESS_DATA_SCHEMA="schemas/congress_data.xsd"
CONGRESS_PAGE="congress_page.html"
GENERATE_HTML="tools/generate_html.xsl"
EXTRACT_CONGRESS_DATA="extractors/extract_congress_data.xq"

# Creacion de directorios si no existen
mkdir -p "data" "schemas" "tools" "extractors"

# Borrado de archivos temporales de ejecuciones anteriores, si existen
rm -rf data/* $CONGRESS_PAGE

# Verificacion de argumentos
if [ -z "$CONGRESS_NUMBER" ]; then
    echo "Error: Congress number must be provided." >&2
    generate_error_xml "Congress number must be provided"
fi

if [ "$CONGRESS_NUMBER" -lt 1 ] || [ "$CONGRESS_NUMBER" -gt 118 ]; then
    echo "Error: Congress number must be between 1 and 118." >&2
    generate_error_xml "Congress number must be between 1 and 118"
fi

# Verificacion de la variable de entorno CONGRESS_API
if [ -z "$CONGRESS_API" ]; then
    echo "Error: CONGRESS_API environment variable is not set." >&2
    generate_error_xml "CONGRESS_API environment variable is not set"
fi

# Descargar datos del Congreso
download_data "https://api.congress.gov/v3/congress/$CONGRESS_NUMBER?format=xml&api_key=${CONGRESS_API}" $CONGRESS_INFO
# Descargar datos de los Miembros
download_data "https://api.congress.gov/v3/member/congress/$CONGRESS_NUMBER?format=xml&currentMember=false&limit=500&api_key=${CONGRESS_API}" $CONGRESS_MEMBERS_INFO

validate_xml $CONGRESS_INFO
validate_xml $CONGRESS_MEMBERS_INFO

# Combinar los archivos de datos en un unico XML
echo "Combining $CONGRESS_INFO and $CONGRESS_MEMBERS_INFO into $CONGRESS_DATA..."
java net.sf.saxon.Query -s:$CONGRESS_INFO -q:$EXTRACT_CONGRESS_DATA \
    congress_members_info="../$CONGRESS_MEMBERS_INFO" \
    congress_info="../$CONGRESS_INFO" \
    -o:$CONGRESS_DATA -ext:on -t > /dev/null 2>&1

validate_xml_with_schema $CONGRESS_DATA $CONGRESS_DATA_SCHEMA

# Procesar el archivo combinado con XSLT
echo "Generating HTML page from $CONGRESS_DATA..."
xsltproc $GENERATE_HTML $CONGRESS_DATA > $CONGRESS_PAGE

echo "HTML page generated: $CONGRESS_PAGE"
