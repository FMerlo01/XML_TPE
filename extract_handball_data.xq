declare variable $season-info := doc("season_info.xml");
declare variable $standings := doc("season_standings_prev.xml");

<handball_data>
  <season>
    <id>{ $season-info//season/@id }</id>
    <name>{ $season-info//season/@name }</name>
    <year>{ $season-info//season/@year }</year>
  </season>
  
  <standings>
    {
      for $team in $standings//team
      return
        <team>
          <id>{ $team/@id }</id>
          <name>{ $team/@name }</name>
          <rank>{ $team/@rank }</rank>
        </team>
    }
  </standings>
</handball_data>