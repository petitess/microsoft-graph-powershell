### Assign permission for a service principal to a specific file in sharepoint
##### https://learn.microsoft.com/en-us/graph/permissions-selected-overview
App Registration needs this permission: `Files.SelectedOperations.Selected`

Authenticate to graph with a personal account

```pwsh
Connect-MgGraph -Scopes "Sites.FullControl.All"
```

Assign permission to a specific file
```pwsh
$siteId = (Get-MgSite | Where-Object DisplayName -eq "Power BI rapporter").Id
$driveId = (Get-MgSiteDrive -SiteId $siteId | Where-Object Name -eq "Dokument").Id  # Library name
$KonkursId = (Get-MgDriveItemChild -DriveId $driveId -DriveItemId "root" -Filter "name eq 'Konkurs'").Id
$fileId = (Get-MgDriveItemChild -DriveId $driveId -DriveItemId $KonkursId -Filter "name eq 'Konkurs och rekonstruktionslista.xlsx'").Id
$params = @{
    roles = @("read")
    grantedTo = @{
            application = @{
                id = "12345678-5bf6-4029-12345678"
                displayName = "sp-fabric-read-01"
            }
    }
}
New-MgDriveItemPermission -DriveId $driveId -DriveItemId $fileId -BodyParameter $params

Get-MgDriveItemPermission -DriveId $driveId -DriveItemId $fileId 
Remove-MgDriveItemPermission -DriveId $driveId -DriveItemId $fileId -PermissionId "acb123"
```
Make API call using service principal to download a file
```pwsh
#Get graph token
#Sites.Read.All & Files.SelectedOperations.Selected
$appid = "12345678-5bf6-4029-12345678"
$tenantid = '12345678-ae44-48b7-a392-12345678'
$secret = '12345678GEIGgzOQ2mvs-vLOmPaXfvqaVP'
$body =  @{
    Grant_Type    = "client_credentials"
    Scope         =  "https://graph.microsoft.com/.default"
    Client_Id     = $appid
    Client_Secret = $secret
}
$connection = Invoke-RestMethod `
    -Uri "https://login.microsoftonline.com/$tenantid/oauth2/v2.0/token" `
    -Method POST `
    -Body $body
$token = $connection.access_token
$secureToken = ConvertTo-SecureString $token -AsPlainText -Force
Connect-MgGraph -AccessToken $secureToken
#Get download link to the file
$headers = @{
    "Authorization" = "Bearer $token"
    "Content-type"  = "application/json"
}
$SiteId = (Get-MgSite | Where-Object DisplayName -eq "Power BI rapporter").Id
$DriveId = (Get-MgSiteDrive -SiteId $siteId | Where-Object Name -eq "Documets").Id
$FilePath = "Konkurs/Konkurs och rekonstruktionslista.xlsx"
$UrlD = "https://graph.microsoft.com/v1.0/sites/$SiteId/drives/$DriveId/root:/$($FilePath):/"
$Download = (Invoke-RestMethod `
-Uri $UrlD `
-Method GET `
-Headers $headers)."@microsoft.graph.downloadUrl"
#Download the file
Invoke-RestMethod -Uri $Download -OutFile "Konkurs och rekonstruktionslista.xlsx"
```
