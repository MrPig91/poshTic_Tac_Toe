function New-HardBotMove($grid){
    for ($x = 0; $x -le 8; $x += 3){
        if ($grid[$x].Value -eq " " -and $grid[$x+1].Value -eq $grid[$x+2].Value -and $grid[$x+1].Value -ne " "){
          return $x;
        }
        elseif ($grid[$x+1].Value -eq " " -and $grid[$x].Value -eq $grid[$x+2].Value -and $grid[$x].Value -ne " "){
          return $x+1;

        }
        elseif ($grid[$x+2].Value -eq " " -and $grid[$x].Value -eq $grid[$x+1].Value -and $grid[$x].Value -ne " "){
          return $x+2;
        }
    }
    for ($x = 0; $x -le 2; $x++){
      if ($grid[$x].Value -eq " " -and $grid[$x+3].Value -eq $grid[$x + 6].Value -and $grid[$x+3].Value -ne " "){
        return $x;
      }
      elseif ($grid[$x+3].Value -eq " " -and $grid[$x].Value -eq $grid[$x+6].Value -and $grid[$x].Value -ne " "){
          return $x+3;
      }
      elseif ($grid[$x+6].Value -eq " " -and $grid[$x].Value -eq $grid[$x+3].Value -and $grid[$x].Value -ne " "){
          return $x+6;
      }
    }
    if ($grid[0].Value -eq " " -and $grid[4].Value -eq $grid[8].Value -and $grid[4].Value -ne " "){
      return 0;
    }
    elseif ($grid[4].Value -eq " " -and $grid[0].Value -eq $grid[8].Value -and $grid[0].Value -ne " "){
      return 4;
    }
    elseif ($grid[8].Value -eq " " -and $grid[0].Value -eq $grid[4].Value -and $grid[4].Value -ne " "){
      return 8;
    }
    elseif ($grid[2].Value -eq " " -and $grid[4].Value -eq $grid[6].Value -and $grid[4].Value -ne " "){
      return 2;
    }
    elseif ($grid[4].Value -eq " " -and $grid[2].Value -eq $grid[6].Value -and $grid[2].Value -ne " "){
      return 4;
    }
    elseif ($grid[6].Value -eq " " -and $grid[2].Value -eq $grid[4].Value -and $grid[4].Value -ne " "){
      return 6;
    }
    return 9;
}