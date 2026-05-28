#https://learn.microsoft.com/en-us/graph/api/driveitem-get-content?view=graph-rest-1.0&tabs=http
$User = "kurt.holm@abc.se"
(Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/beta/users/$($User)/drive/items/root/children")
$DocId = (Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/beta/users/$($User)/drive/items/root/children?`$filter=name eq 'Dokument'").value.id
$SubFolderId = (Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/beta/users/$($User)/drive/items/$($DocId)/children?`$filter=name eq 'Mod MANUALER KPB_26'").value.id
$SubSubFolderId = (Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/beta/users/$($User)/drive/items/$($SubFolderId)/children?`$filter=name eq 'Förberedelse HandOver'").value.id
$Files = (Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/beta/users/$($User)/drive/items/$($SubSubFolderId)/children").value
function Download-DriveItemRecursive {
    param (
        [string]$UserUPN,
        [string]$ItemId,
        [string]$LocalPath
    )

    if (-not (Test-Path $LocalPath)) {
        New-Item -ItemType Directory -Path $LocalPath | Out-Null
    }

    $children = (Invoke-MgGraphRequest `
        -Method GET `
        -Uri "https://graph.microsoft.com/v1.0/users/$UserUPN/drive/items/$ItemId/children"
    ).value

    foreach ($item in $children) {
        $itemPath = Join-Path $LocalPath $item.name

        if ($item.folder) {
            # Folder → recurse
            Download-DriveItemRecursive `
                -UserUPN $UserUPN `
                -ItemId $item.id `
                -LocalPath $itemPath
        }
        elseif ($item.file) {
            # File → download
            Invoke-MgGraphRequest `
                -Method GET `
                -Uri "https://graph.microsoft.com/v1.0/users/$UserUPN/drive/items/$($item.id)/content" `
                -OutputFilePath $itemPath
        }
    }
}

$DownloadPath = "./onedrive"

Download-DriveItemRecursive `
    -UserUPN $User `
    -ItemId $SubSubFolderId `
    -LocalPath $DownloadPath
