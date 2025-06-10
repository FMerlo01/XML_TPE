# XML TPE — Handball Season Summary

Este proyecto genera un resumen en PDF de una temporada de handball,  
a partir de datos obtenidos desde la API de Sportradar en formato XML.


## Archivos

- `program.sh`: Script que automatiza la descarga de datos, procesamiento y generación del PDF.
- - `extract_season_id.xq`: Obtiene de season_info.xml el código ID asociado al String ingresado como parámetro de entrada.
- `extract_handball_data.xq`: Consulta XQuery que extrae información sobre la temporada y los competidores.
- `generate_fo.xsl`: Hoja de estilo XSLT que convierte los datos en un archivo XSL-FO imprimible.
- `handball_data.xml`: XML generado por la consulta XQuery.
- `handball_page.fo`: Documento intermedio FO, generado por la transformación XSLT.
- `handball_report.pdf`: Informe final en PDF con los standings y detalles de los equipos.


## Compilación

Desde una terminal con Java, Saxon y FOP instalados, ejecutar:

- export SPORTRADAR_API=(su api key)

- ./tpe.sh `"Prefijo"`


## Integrantes

- **Felipe Merlo**  
  - Mail: fmerlo@itba.edu.ar  
  - Legajo: 65736

- **Juan Cruz Procaccini**  
  - Mail: jprocaccini@itba.edu.ar  
  - Legajo: 64571

- **Máximo Ramos**  
  - Mail: maramos@itba.edu.ar  
  - Legajo: 64082
