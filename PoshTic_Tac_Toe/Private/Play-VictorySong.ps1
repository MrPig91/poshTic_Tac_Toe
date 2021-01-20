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