
# Validamos los parametros ingresados
if [ -z "$1" ]; then
     echo "Error: congress_number is required." >&2
     exit 1
fi

# Variables de entorno
CONGRESS_NUMBER=$1
API_KEY=${lj0DLch6RQjj2bLAMSft5DcrBbpajXTxPncuyHr0}

# Descarga de XMLs
curl -s -X GET "https://api.congress.gov/v3/congress/$CONGRESS_NUMBER?format=xml&api_key=$API_KEY" \
    -H "accept: application/xml" -o "$DATA_DIR/congress_info.xml"

curl -s -X GET "https://api.congress.gov/v3/member/congress/$CONGRESS_NUMBER?format=xml&currentMember=false&limit=500&api_key=$API_KEY" \
    -H "accept: application/xml" -o "$DATA_DIR/congress_members_info.xml"

# Validación de archivos descargados
if [ ! -s "$DATA_DIR/congress_info.xml" ] || [ ! -s "$DATA_DIR/congress_members_info.xml" ]; then
  echo "Error: Failed to download required data." >&2
  exit 1
fi

# Ejecución de XQuery para generar congress_data.xml
basex -i "$SRC_DIR/extract_congress_data.xq" -o "$DATA_DIR/congress_data.xml"

# Transformación XSLT para generar la página HTML
xsltproc -o "$OUTPUT_DIR/congress_page.html" "$SRC_DIR/generate_html.xsl" "$DATA_DIR/congress_data.xml"

echo "HTML page generated successfully at $OUTPUT_DIR/congress_page.html"









