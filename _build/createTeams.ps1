$basisPfad = "$PSScriptRoot\.."

$teamVorlage = @'
# Team: {0}

Mannschaft:

{1}
'@

$teamIndexVorlage = @'
# Fußball Teams

{0}
'@

Remove-Item -Path "$basisPfad\Teams\*"

$teamLinks = foreach ($teamFolder in Get-ChildItem "$basisPfad\_database\teams") {
    $teamName = $teamFolder.Name
    Write-Host "Verarbeite Team: $teamName"

    $team = foreach ($mitgliedDatei in Get-ChildItem -Path $teamFolder.FullName -Filter *.json) {
        Get-Content -Path $mitgliedDatei.FullName | ConvertFrom-Json
    }
    $teamText = foreach ($teamObject in $team) {
        '|{0}|{1}|{2}|' -f $teamObject.Name, $teamObject.Alter, $teamObject.Position
    }

    $teamVorlage -f $teamName, ($teamText -join "`n") | Set-Content -Path "$basisPfad\Teams\$teamName.md"

    '+ [{0}](Teams/{0}.html)' -f $teamName
}

$teamIndexVorlage -f ($teamLinks -join "`n") | Set-Content -Path "$basisPfad\Teams.md"