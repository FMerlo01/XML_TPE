# Primero declarar variable de entorno SPORTRADAR_API con: 
# export SPORTRADAR_API="Clave generada"
# o agregar a .bashrc

#!/bin/bash

prefix="$1"

curl -X GET https://api.sportradar.com/handball/trial/v2/en/seasons.xml \
  --header "accept: application/json" \
  --header "x-api-key: $SPORTRADAR_API" \
  -o seasons_list.xml

sed -i 's|xmlns="http://schemas.sportradar.com/sportsapi/handball/v2"||' seasons_list.xml


SEASON_ID=$(java net.sf.saxon.Query extract_season_id.xq prefix="$prefix" | grep -o 'sr.*')


curl -X GET https://api.sportradar.com/handball/trial/v2/en/seasons/$SEASON_ID/info.xml \
    --header 'accept: application/json' \
    --header "x-api-key: ${SPORTRADAR_API}" \
    -o season_info.xml

#sed -i 's|xmlns="http://schemas.sportradar.com/sportsapi/handball/v2"||' season_info.xml


curl -X GET https://api.sportradar.com/handball/trial/v2/en/seasons/$SEASON_ID/standings.xml \
    --header 'accept: application/json' \
    --header "x-api-key: ${SPORTRADAR_API}" \
    -o season_standings_prev.xml

#sed -i 's|xmlns="http://schemas.sportradar.com/sportsapi/handball/v2"||' season_standings_prev.xml

