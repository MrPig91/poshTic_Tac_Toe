<#
.SYNOPSIS
    This starts an interactive Tic_Tac_Toe game in the console. Press Esc key to exit game.
.DESCRIPTION
    This starts an interactive Tic_Tac_Toe game in the console. Mostly using using mostly [System.Console] class. Press Esc key to exit game.

    Was largely influenced and inspirated b the ASCII Box menues created by mossrich
    https://github.com/mossrich/PowershellRecipes/blob/master/AsciiMenu.ps1
    I mostly learned how to use ┌─┐│└┘ characters

    I also re-used a lot of code I wrote in my Fun.Arduino repo where I created Tic Tac Toe on an adruino with C.
.EXAMPLE
    PS C:\> Start-Tic_Tac_Toe -DifficultyLevel "Easy" -Bestof 3

    Starts a new Tic Tac Toe game on hard mode with 3 games being played and the winner of 2 wins the game.
.INPUTS
    Inputs (if any)
.OUTPUTS
    Output (if any)
.NOTES
    Module Icon was created from https://game-icons.net/1x1/delapouite/tic-tac-toe.html#download
#>
function Start-Tic_Tac_Toe{
    param(
        [ValidateSet("Easy","Hard")]
        [string]$DifficultyLevel = "Hard",
        [ValidateSet(1,3,5,99)]
        [int]$Bestof = 1
    )

    $Script:Player = "X" 
    $Script:top = [console]::CursorTop
    $Script:PlayerOScore = 0
    $Script:PLayerXScore = 0
    $Script:CurrentRound = 0
    $Script:cursor = 0
    $Script:gameGrid = New-VirtualGameBoard

    Draw-Board -PlayerXScore $PLayerXScore -PlayerOScore $PlayerOScore
    [console]::SetCursorPosition($gameGrid[0].x,$gameGrid[0].y)

    do {
        $Key = [Console]::ReadKey($true)
        if ($Key.key -eq [ConsoleKey]::DownArrow){
            $previousPosition = $cursor
            $cursor = $cursor + 3
            if ($cursor -ge 9){
                $cursor = $cursor % 9
            }
            if ($gameGrid[$cursor].Value -eq " "){
                [console]::SetCursorPosition($gameGrid[$cursor].X,$gameGrid[$cursor].Y)
            }
            else{
                $cursor = $previousPosition
                $cursor = $cursor + 6
                if ($cursor -ge 9){
                    $cursor = $cursor % 9
                }
                if ($gameGrid[$cursor].Value -eq " "){
                    [console]::SetCursorPosition($gameGrid[$cursor].X,$gameGrid[$cursor].Y)
                }
                else{
                    $cursor = $previousPosition
                }
            }
        } #if down key
        elseif ($Key.key -eq [ConsoleKey]::UpArrow){
                $previousPosition = $cursor
                $cursor = $cursor - 3
                if ($cursor -le -1){
                    $cursor = 9 + $cursor
                }
                if ($gameGrid[$cursor].Value -eq " "){
                    [console]::SetCursorPosition($gameGrid[$cursor].X,$gameGrid[$cursor].Y)
                }
                else{
                    $cursor = $previousPosition
                    $cursor = $cursor - 6
                    if ($cursor -le -1){
                        $cursor = 9 + $cursor
                    }
                    if ($gameGrid[$cursor].Value -eq " "){
                        [console]::SetCursorPosition($gameGrid[$cursor].X,$gameGrid[$cursor].Y)
                    }
                    else{
                        $cursor = $previousPosition
                    }
                }
        }
        elseif ($Key.key -eq [ConsoleKey]::RightArrow){
            $cursor = $cursor + 1
            if ($cursor -ge 9){
                $cursor = 0
            }
            while ($gameGrid[$cursor].Value -ne " "){
                $cursor++
            }
            [console]::SetCursorPosition($gameGrid[$cursor].X,$gameGrid[$cursor].Y)
        }
        elseif ($Key.key -eq [ConsoleKey]::LeftArrow){
            $cursor = $cursor - 1
            if ($cursor -lt 0){
                $cursor = 8
            }
            while ($gameGrid[$cursor].Value -ne " "){
                $cursor--
            }
            [console]::SetCursorPosition($gameGrid[$cursor].X,$gameGrid[$cursor].Y)
        }
        elseif ($key.Key -eq [ConsoleKey]::Enter){
            Set-tttSquare -Player $Player -move $cursor
            [console]::SetCursorPosition(0,$top)
            Draw-Board -PlayerXScore $PLayerXScore -PlayerOScore $PlayerOScore

            if (Test-WinConditions $gameGrid){
                $PLayerXScore++
                if (Test-BestofWinner -NumberofGames $Bestof -Score $PLayerXScore){
                    [console]::SetCursorPosition(0,$top)
                    Write-GameResults -Results "YouWin"
                    sleep 2
                    Clear-GameScreen
                    break
                }
                $CurrentRound++
                $gameGrid = New-VirtualGameBoard
                [console]::SetCursorPosition(0,$top)
                Write-GameResults -Results "X"
                sleep 2
                Clear-GameScreen
                Draw-Board -PlayerXScore $PLayerXScore -PlayerOScore $PlayerOScore
            }

            #Test Draw
             if (Test-DrawCondition -game $gameGrid){
                $gameGrid = New-VirtualGameBoard
                $CurrentRound++
                [console]::SetCursorPosition(0,$top)
                Write-GameResults -Results "Draw"
                sleep 2
                Clear-GameScreen
                Draw-Board -PlayerXScore $PLayerXScore -PlayerOScore $PlayerOScore
            }

            $Player = 'O'
            [console]::CursorVisible = $false
            sleep -Milliseconds (Get-Random -Minimum 10 -Maximum 1000)
            $botMove = New-BotMove -Difficulty $DifficultyLevel -Grid $gameGrid
            [console]::SetCursorPosition(0,$top)
            [console]::CursorVisible = $true
            Draw-Board -PlayerXScore $PLayerXScore -PlayerOScore $PlayerOScore
            if (Test-WinConditions $gameGrid){
                $PLayerOScore++
                if (Test-BestofWinner -NumberofGames $Bestof -Score $PLayerOScore){
                    [console]::SetCursorPosition(0,$top)
                    Write-GameResults -Results "YouLost"
                    sleep 2
                    Clear-GameScreen
                    break
                }
                $CurrentRound++
                $gameGrid = New-VirtualGameBoard
                [console]::SetCursorPosition(0,$top)
                Write-GameResults -Results "O"
                sleep 2
                Clear-GameScreen
                Draw-Board -PlayerXScore $PLayerXScore -PlayerOScore $PlayerOScore
            }
            
            #Test Draw
            if (Test-DrawCondition -game $gameGrid){
                $gameGrid = New-VirtualGameBoard
                $CurrentRound++
                [console]::SetCursorPosition(0,$top)
                Write-GameResults -Results "Draw"
                sleep 2
                Clear-GameScreen
                Draw-Board -PlayerXScore $PLayerXScore -PlayerOScore $PlayerOScore
            }

            $Player = 'X'
            for ($i = 0; $i -le 8; $i++){
                if ($gameGrid[$i].Value -eq " "){
                    $cursor = $i
                    [console]::SetCursorPosition($gameGrid[$cursor].x,$gameGrid[$cursor].y)
                    break
                }
            }
        }
    }
    While( -not ([ConsoleKey]::Escape -eq $key.Key) )
}
function Clear-GameScreen {
    [console]::SetCursorPosition(0,$top)
    $WhiteSpace = (0.. ([console]::WindowWidth - 2) | foreach {"$([char]32)"})
    Write-Host "`n$WhiteSpace`n$WhiteSpace`n$WhiteSpace`n$WhiteSpace`n$WhiteSpace`n$WhiteSpace`n$WhiteSpace"
    [console]::SetCursorPosition(0,$top)
}
function Draw-Board {
    param(
        $PlayerXScore,
        $PlayerOScore
    )
    $line = (0.. 12 | foreach {[char]9472}) -join ''
    $topborder = ([char]9484,$line,[char]9488) -join ''

    $middleLine = (0.. 2 | foreach {[char]9472}) -join ''
    $middleborder = $middleLine,[char]9532,$middleLine,[char]9532,$middleLine -join ''

    $bottomborder = ([char]9492,$line,[char]9496) -join ''

    $Board = "
    $topborder   $topborder
    $([char]9474)  $(Write-tttColorText -Text $gameGrid[0].Value) $([char]9474) $(Write-tttColorText -Text $gameGrid[1].Value) $([char]9474) $(Write-tttColorText -Text $gameGrid[2].Value)  $([char]9474)   $([char]9474)    SCORE    $([char]9474)
    $([char]9474) $middleborder $([char]9474)   $([char]9500)$line$([char]9508) 
    $([char]9474)  $(Write-tttColorText -Text $gameGrid[3].Value) $([char]9474) $(Write-tttColorText -Text $gameGrid[4].Value) $([char]9474) $(Write-tttColorText -Text $gameGrid[5].Value)  $([char]9474)   $([char]9474) $(Write-tttColorText -Text "Player X: " -Color "Green")$($PlayerXScore.ToString("0")) $([char]9474)  
    $([char]9474) $middleborder $([char]9474)   $([char]9474) $(Write-tttColorText -Text $("Player O: ") -Color "Red")$($PlayerOScore.ToString("0")) $([char]9474)  
    $([char]9474)  $(Write-tttColorText -Text $gameGrid[6].Value) $([char]9474) $(Write-tttColorText -Text $gameGrid[7].Value) $([char]9474) $(Write-tttColorText -Text $gameGrid[8].Value)  $([char]9474)   $bottomborder
    $bottomborder
        "
    Write-Host $Board
}
function Get-MusicNote {
    param($note)
    switch ($note){
"NOTE_B0"  {31}
"NOTE_C1"  {33}
"NOTE_CS1" {35}
"NOTE_D1"  {37}
"NOTE_DS1" {39}
"NOTE_E1"  {41}
"NOTE_F1"  {44}
"NOTE_FS1" {46}
"NOTE_G1"  {49}
"NOTE_GS1" {52}
"NOTE_A1"  {55}
"NOTE_AS1" {58}
"NOTE_B1"  {62}
"NOTE_C2"  {65}
"NOTE_CS2" {69}
"NOTE_D2"  {73}
"NOTE_DS2" {78}
"NOTE_E2"  {82}
"NOTE_F2"  {87}
"NOTE_FS2" {93}
"NOTE_G2"  {98}
"NOTE_GS2" {104}
"NOTE_A2"  {110}
"NOTE_AS2" {117}
"NOTE_B2"  {123}
"NOTE_C3"  {131}
"NOTE_CS3" {139}
"NOTE_D3"  {147}
"NOTE_DS3" {156}
"NOTE_E3"  {165}
"NOTE_F3"  {175}
"NOTE_FS3" {185}
"NOTE_G3"  {196}
"NOTE_GS3" {208}
"NOTE_A3"  {220}
"NOTE_AS3" {233}
"NOTE_B3"  {247}
"NOTE_C4"  {262}
"NOTE_CS4" {277}
"NOTE_D4"  {294}
"NOTE_DS4" {311}
"NOTE_E4"  {330}
"NOTE_F4"  {349}
"NOTE_FS4" {370}
"NOTE_G4"  {392}
"NOTE_GS4" {415}
"NOTE_A4"  {440}
"NOTE_AS4" {466}
"NOTE_B4"  {494}
"NOTE_C5"  {523}
"NOTE_CS5" {554}
"NOTE_D5"  {587}
"NOTE_DS5" {622}
"NOTE_E5"  {659}
"NOTE_F5"  {698}
"NOTE_FS5" {740}
"NOTE_G5"  {784}
"NOTE_GS5" {831}
"NOTE_A5"  {880}
"NOTE_AS5" {932}
"NOTE_B5"  {988}
"NOTE_C6"  {1047}
"NOTE_CS6" {1109}
"NOTE_DS6" {1245}
"NOTE_E6"  {1319}
"NOTE_F6"  {1397}
"NOTE_FS6" {1480}
"NOTE_G6"  {1568}
"NOTE_GS6" {1661}
"NOTE_A6"  {1760}
"NOTE_AS6" {1865}
"NOTE_B6"  {1976}
"NOTE_C7"  {2093}
"NOTE_CS7" {2217}
"NOTE_D7"  {2349}
"NOTE_DS7" {2489}
"NOTE_E7"  {2637}
"NOTE_F7"  {2794}
"NOTE_FS7" {2960}
"NOTE_G7"  {3136}
"NOTE_GS7" {3322}
"NOTE_A7"  {3520}
"NOTE_AS7" {3729}
"NOTE_B7"  {3951}
"NOTE_C8"  {4186}
"NOTE_CS8" {4435}
"NOTE_D8"  {4699}
"NOTE_DS8" {4978}
    }
}
function New-ASCIIArt {
    param(
        $Text,
        $Font
    )
    Invoke-RestMethod -Uri "https://artii.herokuapp.com/make?text=$Text"
}
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
function New-VirtualGameBoard{
    #this creates the virtual gameboard 0 being the top most left, and 8 being the right most bottom
    0.. 8 | foreach {
        $YAdjust = if ($_ -lt 3){2}
        elseif($_ -gt 5){6}
        else{4}
        [PSCustomObject]@{
            Value = " "
            X = ($_ % 3) + 7 + (($_ % 3) * 3)
            Y = ($top + $YAdjust)
            ID = $_
        }
    }
}
function Play-VictorySong{
    <#these notes were mainly adopted from https://github.com/NaWer/beep/blob/master/Gaming/Final%20Fantasy%20-%20Victory%20Theme
    and my arduino Tic Tac Toe project https://github.com/MrPig91/Fun.Arduino/tree/master/Projects#>
    
    $notes = (
        "NOTE_B5","0","NOTE_B5","0","NOTE_B5","0","NOTE_B5",
        "NOTE_G5","NOTE_A5","NOTE_B5","0","NOTE_A5","NOTE_B5",
        "NOTE_FS5","NOTE_E5","NOTE_FS5","NOTE_E5","0",
        "NOTE_A5","NOTE_A5","0","NOTE_GS5","NOTE_A5",
        "0","NOTE_GS5","NOTE_GS5","0","NOTE_FS5",
        "NOTE_E5","NOTE_DS5","NOTE_E5","0","NOTE_CS5",
        "NOTE_FS5","NOTE_E5","NOTE_FS5","NOTE_E5","0",
        "NOTE_A5","NOTE_A5","0","NOTE_GS5","NOTE_A5",
        "0","NOTE_GS5","NOTE_GS5","0","NOTE_FS5",
        "NOTE_E5","NOTE_FS5","NOTE_A5","0","NOTE_B5"
    )

    $dur = (
            100, 100, 100, 100, 100, 100, 428,
           428, 428, 175, 214, 175, 857,
           428, 428, 428, 175, 175,
           428, 175, 175, 428, 175,
           175, 428, 175, 175, 428,
           428, 428, 175, 175, 1714,
           428, 428, 428, 175, 175,
           428, 175, 175, 428, 175,
           175, 428, 175, 175, 428,
           428, 428, 175, 175, 1714
    )
    $ErrorActionPreference = "STOP"

    for ($x=0;$x -le 52;$x++){
        try{
            if ($notes[$x] -eq "0"){
                Sleep -Milliseconds $dur[$x]
            }
            else{
                [System.Console]::Beep((Get-MusicNote -Note $notes[$x]),($dur[$x]))
            }
        }
        catch{
            Write-Host $notes[$x]
        }
    }
}
function Set-tttSquare ($Player,$move){
    $gameGrid[$move].Value = $Player
}
function Test-BestofWinner {
    param(
        $NumberofGames,
        $Score
    )

    $winNeeded = switch ($NumberofGames){
        1 {1}
        3 {2}
        5 {3}
        99 {50}
    }
    if ($score -eq $winNeeded){
        $true
    }
    else{
        $false
    }
}
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
function Write-GameResults {
    param(
        $Results 
    )

    $WhiteSpace = (0.. ([console]::WindowWidth - 2) | foreach {"$([char]32)"})

    if ($Results -eq "X"){Write-Host ("
         _____  _                        __   __ __          ___             _
        |  __ \| |                       \ \ / / \ \        / (_)           | |
        | |__) | | __ _ _   _  ___ _ __   \ V /   \ \  /\  / / _ _ __  ___  | |
        |  ___/| |/ _  | | | |/ _  \ '__|  > <     \ \/  \/ / | | '_ \/ __| | |
        | |    | | (_| | |_| |  __/ |     / . \     \  /\  /  | | | | \__ \ |_|
        |_|    |_|\__,_|\__, |\___|_|    /_/ \_\     \/  \/   |_|_| |_|___/ (_)
                         __/ |
                        |___/    " -join "") -ForegroundColor Green

    }
    elseif ($Results -eq "O"){Write-Host ("
     _____  _                          ____   __          ___             _ 
    |  __ \| |                        / __ \  \ \        / (_)           | |
    | |__) | | __ _ _   _  ___ _ __  | |  | |  \ \  /\  / / _ _ __  ___  | |
    |  ___/| |/ _  | | | |/ _ \ '__| | |  | |   \ \/  \/ / | | '_ \/ __| | |
    | |    | | (_| | |_| |  __/ |    | |__| |    \  /\  /  | | | | \__ \ |_|
    |_|    |_|\__,_|\__, |\___|_|     \____/      \/  \/   |_|_| |_|___/ (_)
                     __/ |                                                  
                    |___/                                                   
   " -join "") -ForegroundColor Red
    }
    elseif ($Results -eq "YouWin"){Write-Host ("
    __     __          __          _______ _   _   _    _    _ 
    \ \   / /          \ \        / /_   _| \ | | | |  | |  | |
     \ \_/ /__  _   _   \ \  /\  / /  | | |  \| | | |  | |  | |
      \   / _ \| | | |   \ \/  \/ /   | | | .   | | |  | |  | |
       | | (_) | |_| |    \  /\  /   _| |_| |\  | |_|  |_|  |_|
       |_|\___/ \__,_|     \/  \/   |_____|_| \_| (_)  (_)  (_)
                                                               " -join "") -ForegroundColor Green
    }
    elseif ($Results -eq "YouLost"){Write-Host ("
    __     __           _      ____   _____ _______   _    _    _ 
    \ \   / /          | |    / __ \ / ____|__   __| | |  | |  | |
     \ \_/ /__  _   _  | |   | |  | | (___    | |    | |  | |  | |
      \   / _ \| | | | | |   | |  | |\___ \   | |    | |  | |  | |
       | | (_) | |_| | | |____ |__| |____) |  | |    |_|  |_|  |_|
       |_|\___/ \__,_| |______\____/|_____/   |_|    (_)  (_)  (_)                                                               
   " -join "") -ForegroundColor Red
   Write-Host "$whiteSpace`n$whiteSpace"

    }
    else{Write-Host ("
         _____  _____      __          __
        |  __ \|  __ \    /\ \        / /
        | |  | | |__) |  /  \ \  /\  / / 
        | |  | |  _  /  / /\ \ \/  \/ /  
        | |__| | | \ \ / ____ \  /\  /  
        |_____/|_|  \_\_/    \_\/  \/ $whiteSpace
$whiteSpace`n$whiteSpace" -join "")
        Write-Host "$whiteSpace`n$whiteSpace"

    }
}
function Write-tttColorText {
    param(
        [Alias("T")]
        [Parameter(Mandatory)]
        [string]$Text,
        [ValidateSet("Green","Red","Yellow")]
        [Alias("C")]
        [string]$Color
    )

    $escape = [char]27 + '['
    $resetAttributes = "$($escape)0m"
    if ($PSBoundParameters.ContainsKey("Color")){
        $FGColor = switch ($Color){
            "Green" {"92m"}
            "Red" {"91m"}
            "Yellow" {"93m"}
        }
    }
    else{
        $FGColor = switch ($Text){
            "X" {"92m"}
            "O" {"91m"}
            default {"93m"}
        }
    }

    $WriteHost = $escape + $FGColor + $Text + $resetAttributes
    $WriteHost
}
Export-ModuleMember -function Start-Tic_Tac_Toe
