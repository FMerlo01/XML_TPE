
declare variable $prefix as xs:string external;

let $match := doc("seasons_list.xml")//season[starts-with(@name, $prefix)][1]

return string($match/@id)

