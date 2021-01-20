function New-ASCIIArt {
    param(
        $Text,
        $Font
    )
    Invoke-RestMethod -Uri "https://artii.herokuapp.com/make?text=$Text"
}