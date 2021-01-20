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