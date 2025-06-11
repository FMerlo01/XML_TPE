# Antes de ejecutar declarar variable de entorno SPORTRADAR_API con: 
# export SPORTRADAR_API="Clave generada"
# o settear en .bashrc
# Incluir en $PATH el path al Java y al Fop instalados
# Incluir en $CLASSPATH el path al Saxon 

#!/bin/bash


prefix="$1"

# Conexión con la API y extraigo seasons_list.xml. Eliminación de su XML Schema Namespace

curl -X GET https://api.sportradar.com/handball/trial/v2/en/seasons.xml \
  --header "accept: application/json" \
  --header "x-api-key: $SPORTRADAR_API" \
  -o seasons_list.xml

sed -i 's|xmlns="http://schemas.sportradar.com/sportsapi/handball/v2"||' seasons_list.xml

# Extracción la season_id a partir de la variable de entrada y filtrado de la salida

SEASON_ID=$(java net.sf.saxon.Query extract_season_id.xq prefix="$prefix" | grep -o 'sr.*')

# Mismo proceso para los otros .xml, extracción usando season_id

curl -X GET https://api.sportradar.com/handball/trial/v2/en/seasons/$SEASON_ID/info.xml \
    --header 'accept: application/json' \
    --header "x-api-key: ${SPORTRADAR_API}" \
    -o season_info.xml

sed -i 's|xmlns="http://schemas.sportradar.com/sportsapi/handball/v2"||' season_info.xml


curl -X GET https://api.sportradar.com/handball/trial/v2/en/seasons/$SEASON_ID/standings.xml \
    --header 'accept: application/json' \
    --header "x-api-key: ${SPORTRADAR_API}" \
    -o season_standings_prev.xml

sed -i 's|xmlns="http://schemas.sportradar.com/sportsapi/handball/v2"||' season_standings_prev.xml

# Generación del handball_data.xml

java net.sf.saxon.Query extract_handball_data.xq > handball_data.xml

# Utilización del .xml y la hoja XSL para generar el .fo 

java net.sf.saxon.Transform -s:handball_data.xml -xsl:generate_fo.xsl -o:handball_page.fo

# Generación del .pdf final a partir del .fo

fop -fo handball_page.fo -pdf handball_report.pdf