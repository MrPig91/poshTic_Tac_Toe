function New-BotMove {
    param(
        $Difficulty,
        $grid
    )

    $freeSquares = $grid | where Value -eq " "
    if ($Difficulty -eq "Easy"){
      $randomNumber = $freeSquares | Get-Random
      $grid[$randomNumber.ID].Value = "O"
      return
    }
    elseif ($Difficulty -eq "Hard"){
      $hardMove = New-HardBotMove $grid
      if ($hardMove -eq 9){
        New-BotMove -Difficulty "Easy" -grid $grid
      }
      else{
          $grid[$hardMove].Value = "O"
      }
    }
}