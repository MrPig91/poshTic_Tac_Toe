function Clear-GameScreen {
    [console]::SetCursorPosition(0,$top)
    $WhiteSpace = (0.. ([console]::WindowWidth - 2) | foreach {"$([char]32)"})
    Write-Host "`n$WhiteSpace`n$WhiteSpace`n$WhiteSpace`n$WhiteSpace`n$WhiteSpace`n$WhiteSpace`n$WhiteSpace"
    [console]::SetCursorPosition(0,$top)
}