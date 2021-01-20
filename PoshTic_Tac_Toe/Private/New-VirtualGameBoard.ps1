function New-GameBoard{
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