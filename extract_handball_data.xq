declare variable $season-info := doc("season_info.xml");
declare variable $season-standings := doc("season_standings_prev.xml");

<handball_data>
  {
    if (not(doc-available("season_info.xml"))) then
      <error>Season info file not found or not accessible</error>
    else if (not(doc-available("season_standings_prev.xml"))) then  
      <error>Season standings file not found or not accessible</error>
    else 
      let $season := $season-info//season
      return
        if (not(exists($season))) then
          <error>No season information found in season_info.xml</error>
        else (
          <season>
            <name>{string($season/@name)}</name>
            <year>{string($season/@year)}</year>
            <category>{string($season-info//category/@name)}</category>
            <gender>{string($season-info//competition/@gender)}</gender>
          </season>,
          
          <competitors>
            {
              for $competitor in $season-info//stages//competitors/competitor
              let $competitor-id := string($competitor/@id)
              let $competitor-name := string($competitor/@name)
              let $competitor-country := string($competitor/@country)
              return
                <competitor name="{$competitor-name}" country="{$competitor-country}">
                  <standings>
                    {
                      for $standing in $season-standings//season_standing[@type="total"]/groups/group/standings/standing[competitor/@id = $competitor-id]
                      let $group := $standing/ancestor::group
                      return
                        <standing 
                          group_name_code="{string($group/@group_name)}"
                          group_name="{string($group/@name)}"
                          rank="{string($standing/@rank)}"
                          played="{string($standing/@played)}"
                          win="{string($standing/@win)}"
                          loss="{string($standing/@loss)}"
                          draw="{string($standing/@draw)}"
                          goals_for="{string($standing/@goals_for)}"
                          goals_against="{string($standing/@goals_against)}"
                          goals_diff="{string($standing/@goals_diff)}"
                          points="{string($standing/@points)}">
                        </standing>
                    }
                  </standings>
                </competitor>
            }
          </competitors>
        )
  }
</handball_data>