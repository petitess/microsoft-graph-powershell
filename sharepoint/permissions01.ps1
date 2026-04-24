#Files.ReadWrite.All 	Sites.ReadWrite.All Files.SelectedOperations.Selected Files.ReadWrite.AppFolder
$siteId = (Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/v1.0/sites/root:/sites/ADL-A3" ).id

$Body = @{
    name                                = "new_sys"
    folder                              = @{}
    "@microsoft.graph.conflictBehavior" = "rename" #fail, replace
}

$newFolder = (Invoke-MgGraphRequest -Method POST -Uri "https://graph.microsoft.com/v1.0/sites/$siteId/drive/items/root/children"-Body $Body)

$newFolder = (Invoke-MgGraphRequest -Method POST -Uri "https://graph.microsoft.com/v1.0/sites/$siteId/drive/items/01RRNAIB7RYVUGBUMQEJAKG7QJUIJIYR2B/children" -Body $Body)

$Body = @{
    roles       = @("write")
    grantedToV2 = @{
        application = @{
            id          = "1d2c3bef-77e8-4ff6-a399-8efa5dc20f10"
            displayName = "sp-shp-adl-a3"
        }
    }
}

$newPermission = (Invoke-MgGraphRequest -Method POST -Uri "https://graph.microsoft.com/v1.0/sites/$siteId/drive/items/$($newFolder.id)/permissions" -Body $Body -ContentType "application/json")

(Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/v1.0/sites/$siteId/drive/items/$($newFolder.id)/permissions"-Body $Body).value.grantedToV2

$DeletePermission = (Invoke-MgGraphRequest -Method DELETE -Uri "https://graph.microsoft.com/v1.0/sites/$siteId/drive/items/$($newFolder.id)/permissions/$($newPermission.id)")
