#!/bin/bash

# Funcion para manejar errores y generar XML de error
generate_error_xml() {
    local error_message=$1
    echo '<?xml version="1.0" encoding="UTF-8"?>' > $CONGRESS_DATA
    echo '<data>' >> $CONGRESS_DATA
    echo "  <error>$error_message</error>" >> $CONGRESS_DATA
    echo '</data>' >> $CONGRESS_DATA
    xsltproc $GENERATE_HTML $CONGRESS_DATA > $CONGRESS_PAGE
    exit 1
}

# Funcion para descargar datos y manejar errores
download_data() {
    local url=$1
    local output_file=$2
    curl -# -X GET "$url" -H "accept: application/xml" -o $output_file
    if [ $? -ne 0 ] || [ ! -s $output_file ]; then
        echo "Error: Failed to fetch data from $url" >&2
        generate_error_xml "Failed to fetch data from $url"
    fi
}

# Validar archivos XML
validate_xml() {
    local xml_file=$1
    echo "Validating $xml_file..."
    java sax.Writer $xml_file 2>&1 >/dev/null
    if [ $? -ne 0 ]; then
        echo "Error: $xml_file is not a valid XML file." >&2
        generate_error_xml "$xml_file is not a valid XML file."
    else
        echo "$xml_file - Validation completed"
    fi
}

# Validar el XML combinado
validate_xml_with_schema() {
    local xml_file=$1
    local schema_file=$2
    echo "Validating $xml_file with schema $schema_file..."
    java sax.Writer -v -n -s -f $xml_file > /dev/null 2>&1
    if [ $? -ne 0 ]; then
        echo "Error: $xml_file is not a valid XML file according to the schema $schema_file." >&2
        generate_error_xml "$xml_file is not a valid XML file according to the schema $schema_file."
    else
        echo "$xml_file - Validation completed"
    fi
}
