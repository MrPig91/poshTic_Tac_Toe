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