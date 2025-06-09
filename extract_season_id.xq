declare variable $prefix as xs:string external;

let $filtered := 
  for $season in doc("seasons_list.xml")//season[starts-with(@name, $prefix)]
  order by xs:date($season/@start_date) ascending
  return $season

return string($filtered[1]/@id)