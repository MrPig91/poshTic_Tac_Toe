<#
.SYNOPSIS
    This starts an interactive Tic_Tac_Toe game in the console.
.DESCRIPTION
    This starts an interactive Tic_Tac_Toe game in the console. Mostly using using mostly [System.Console] class.

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
    General notes
#>
function Start-Tic_Tac_Toe{
    param(
        [ValidateSet("Easy","Hard")]
        [string]$DifficultyLevel = "Hard",
        [ValidateSet(1,3,5)]
        [int]$Bestof
    )

    $Player = "X" 
    $top = [console]::CursorTop
    $PlayerOScore = 0
    $PLayerXScore = 0

    $cursor = 0

    $gameGrid = New-VirtualGameBoard

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
            }
        }
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

            if (CheckWinConditions $gameGrid){
                $PLayerXScore++
                $gameGrid = New-GameBoard
                [console]::SetCursorPosition(0,$top)
                Write-GameResults -Results "X"
                sleep 2
                [console]::SetCursorPosition(0,$top)
                $WhiteSpace = (0.. ([console]::WindowWidth - 2) | foreach {"$([char]32)"})
                Write-Host "`n$WhiteSpace`n$WhiteSpace`n$WhiteSpace`n$WhiteSpace`n$WhiteSpace`n$WhiteSpace`n$WhiteSpace"
                [console]::SetCursorPosition(0,$top)
                Draw-Board -PlayerXScore $PLayerXScore -PlayerOScore $PlayerOScore
            }

            $Player = 'O'
            [console]::CursorVisible = $false
            sleep -Milliseconds (Get-Random -Minimum 10 -Maximum 1000)
            $botMove = New-BotMove -Difficulty $DifficultyLevel -Grid $gameGrid
            [console]::SetCursorPosition(0,$top)
            [console]::CursorVisible = $true
            Draw-Board -PlayerXScore $PLayerXScore -PlayerOScore $PlayerOScore
            if (CheckWinConditions $gameGrid){
                $PLayerOScore++
                $gameGrid = New-GameBoard
                [console]::SetCursorPosition(0,$top)
                Write-GameResults -Results "O"
                sleep 1
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
