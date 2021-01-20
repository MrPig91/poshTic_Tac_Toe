function Test-WinConditions{
    param(
        $moves
    )
    for ($x = 0;$x -le 8; $x += 3){
      if ($moves[$x].Value -ne " "){
        if (($moves[$x].Value -eq $moves[$x+1].Value) -and ($moves[$x].Value -eq $moves[$x+2].Value)){
        return $true;
        }
      }
    }
    for ($x = 0; $x -le 2; $x++){
      if (($moves[$x].Value -ne " ") -and ($moves[$x].Value -eq $moves[$x + 3].Value) -and ($moves[$x].Value -eq $moves[$x + 6].Value)){
        return $true;
      }
    }
    if (($moves[0].Value -ne " ") -and ($moves[0].Value -eq $moves[4].Value) -and ($moves[0].Value -eq $moves[8].Value)){
      return $true;
    }
    elseif (($moves[2].Value -ne " ") -and ($moves[2].Value -eq $moves[4].Value) -and ($moves[2].Value -eq $moves[6].Value)){
      return $true;
    }
    else{
     return $false; 
    }
}