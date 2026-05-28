$User = "kurt.holm@abc.se"
(Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/beta/users/$($User)/drive/items/root/children")
$sourceDriveId = (Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/v1.0/users/$($User)/drive/items/root").parentReference.driveId
$DocId = (Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/beta/users/$($User)/drive/items/root/children?`$filter=name eq 'Dokument'").value.id
$SubFolderId = (Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/beta/users/$($User)/drive/items/$($DocId)/children?`$filter=name eq 'Mod MANUALER KPB_26'").value.id
$SubSubFolderId = (Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/beta/users/$($User)/drive/items/$($SubFolderId)/children?`$filter=name eq 'Förberedelse HandOver'").value.id
$Files = (Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/beta/users/$($User)/drive/items/$($SubSubFolderId)/children").value

$siteId = (Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/v1.0/sites/root:/sites/AlmiInvestBusinessControlochSupport-BusinessSupport-O" ).id
$destDriveId = (Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/v1.0/sites/$siteId/drive/items/root/").parentReference.driveId
$FolderId = (Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/v1.0/sites/$siteId/drive/items/root/children?`$filter=name eq 'System support'").value.id
$DesSubFolderId = (Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/v1.0/sites/$siteId/drive/items/$FolderId/children?`$filter=name eq 'Mod MANUALER KPB_26'").value.id

function Copy-DriveItemRecursive {
    param (
        [string]$SourceDriveId,
        [string]$ItemId,
        [string]$DestDriveId,
        [string]$DestParentFolderId
    )

    $children = (Invoke-MgGraphRequest `
        -Method GET `
        -Uri "https://graph.microsoft.com/v1.0/drives/$SourceDriveId/items/$ItemId/children"
    ).value

    foreach ($item in $children) {

        if ($item.folder) {
            # Create folder in destination
            $newFolder = Invoke-MgGraphRequest `
                -Method POST `
                -Uri "https://graph.microsoft.com/v1.0/drives/$DestDriveId/items/$DestParentFolderId/children" `
                -Body @{
                    name = $item.name
                    folder = @{}
                    "@microsoft.graph.conflictBehavior" = "rename"
                }

            # Recurse
            Copy-DriveItemRecursive `
                -SourceDriveId $SourceDriveId `
                -ItemId $item.id `
                -DestDriveId $DestDriveId `
                -DestParentFolderId $newFolder.id
        }
        elseif ($item.file) {
            # Copy file
            Invoke-MgGraphRequest `
                -Method POST `
                -Uri "https://graph.microsoft.com/v1.0/drives/$SourceDriveId/items/$($item.id)/copy" `
                -Body @{
                    parentReference = @{
                        driveId = $DestDriveId
                        id      = $DestParentFolderId
                    }
                    name = $item.name
                }
        }
    }
}

Copy-DriveItemRecursive `
    -SourceDriveId $sourceDriveId `
    -ItemId $SubSubFolderId `
    -DestDriveId $destDriveId `
    -DestParentFolderId $DesSubFolderId
