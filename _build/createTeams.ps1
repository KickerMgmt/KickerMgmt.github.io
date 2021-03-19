$basisPfad = "$PSScriptRoot\.."

foreach ($teamFolder in Get-ChildItem "$basisPfad\_database\teams") {
    $teamName = $teamFolder.Name
    Write-Host "Verarbeite Team: $teamName"

    $teamName | Set-Content -Path "$basisPfad\Teams\$teamName.md"
}