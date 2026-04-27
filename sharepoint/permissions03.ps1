#https://learn.microsoft.com/en-us/graph/api/driveitem-list-permissions?view=graph-rest-1.0&tabs=http
#Files.Read.All
$siteId = (Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/v1.0/sites/root:/sites/TESTUAT-ADL-Labels" ).id
$Drives = (Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/v1.0/sites/$siteId/drives").value
$Drives.Name
$Drives |ForEach-Object {
    $driveName = $_.name
    $driveId = $_.id
    $permissions = (Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/v1.0/sites/$siteId/drives/$driveId/items/root/permissions").value `
    | Select-Object @{Label = "Roles"; Expression = { $_.Roles } }, @{Label = "DisplayName"; Expression = { $_.GrantedToV2.SiteUser.DisplayName } }, @{Label = "DriveName"; Expression = { $driveName } } 
    $permissions
}
