Get-MgApplication -All -Property displayName,appId,web,spa,publicClient |
? { $_.Web.RedirectUris -or $_.Spa.RedirectUris -or $_.PublicClient.RedirectUris } |
Select-Object DisplayName,AppId,
@{n="RedirectUris";e={($_.Web.RedirectUris + $_.Spa.RedirectUris + $_.PublicClient.RedirectUris) -join "; "}} |
Export-Csv redirect-uris.csv -NoTypeInformation

$apps = (Invoke-GraphRequest -Uri "/v1.0/applications?`$select=displayName,appId,web,spa,publicClient").value
$apps |
Where-Object {
    ($_.web.redirectUris.Count -eq 0) -and
    ($_.spa.redirectUris.Count -eq 0) -and
    ($_.publicClient.redirectUris.Count -eq 0)
} | Select-Object displayName, appId

(Invoke-GraphRequest -Uri "/v1.0/applications?`$select=displayName,appId,web").value | `
Where-Object { $_.web.redirectUris -gt 0 } | Select-Object displayName, appId, @{n="RedirectUris";e={($_.web.redirectUris) -join "; "}} | Export-Csv web-redirect-uris.csv -NoTypeInformation
