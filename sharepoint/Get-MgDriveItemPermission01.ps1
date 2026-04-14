$siteId = (Get-MgSite -All | Where-Object DisplayName -eq "#TEST#UAT-ADL-Labels").Id
$driveId = (Get-MgSiteDrive -SiteId $siteId | Where-Object Name -eq "E-arkiv").Id 
$driveIdSubFolder1 = (Get-MgDriveItemChild -DriveId $driveId -DriveItemId "root" -Filter "name eq '004400-4400 Rapport 1930'").Id
$driveIdSubFolder2 = (Get-MgDriveItemChild -DriveId $driveId -DriveItemId $driveIdSubFolder1 -Filter "name eq '0044'").Id
$fileId = (Get-MgDriveItemChild -DriveId $driveId -DriveItemId $driveIdSubFolder2 -Filter "name eq 'Forsakran.pdf'").Id

(Get-MgDriveItemPermission -DriveId $driveId -DriveItemId $driveId).GrantedToV2.SiteUser.DisplayName

(Get-MgDriveItemPermission -DriveId $driveId -DriveItemId $driveIdSubFolder1) | Select-Object {$_.GrantedToV2.SiteUser.DisplayName}

Get-MgDriveItemPermission -DriveId $driveId -DriveItemId $driveIdSubFolder2 | Select-Object {$_.GrantedToV2.SiteUser.DisplayName}

Get-MgDriveItemPermission -DriveId $driveId -DriveItemId $fileId | Select-Object {$_.GrantedToV2.SiteUser.DisplayName}
