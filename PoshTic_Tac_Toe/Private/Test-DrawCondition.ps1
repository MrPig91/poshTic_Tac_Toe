Test-DrawCondition {
    param(
        $game
    )

  for ($x = 0; $x -le 8; $x++){
    if ($game[$X].Value -eq $null){
      return $false
    }
  }
  return $true;
}