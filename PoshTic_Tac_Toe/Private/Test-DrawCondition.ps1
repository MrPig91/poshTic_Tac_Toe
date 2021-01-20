function Test-DrawCondition {
    param(
        $game
    )

  for ($x = 0; $x -le 8; $x++){
    if ($game[$X].Value -eq " "){
      return $false
    }
  }
  return $true;
}