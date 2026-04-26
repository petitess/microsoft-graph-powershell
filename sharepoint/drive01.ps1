#https://learn.microsoft.com/en-us/graph/api/driveitem-get-content?view=graph-rest-1.0&tabs=http
#Files.Read.All

(Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/v1.0/sites/root" )
(Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/v1.0/sites/companyname.sharepoint.com" )
(Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/v1.0/sites/companyname.sharepoint.com:/sites/ADL-B3" )

$siteId = (Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/v1.0/sites/root:/sites/ADL-A3" ).id

(Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/v1.0/sites/$siteId/drive").name
(Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/v1.0/sites/$siteId/drives").name
#Download from root library
$FolderId = (Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/v1.0/sites/$siteId/drive/items/root/children?`$filter=name eq 'new_sys'").value.id
$Files = (Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/v1.0/sites/$siteId/drive/items/$FolderId/children").value
$Files | ForEach-Object {
    (Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/v1.0/sites/$siteId/drive/items/$($_.id)/content" -OutputFilePath "./$($_.name)")
}

(Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/v1.0/sites/$siteId/drive/items/01RRNAIB7RYVUGBUMQEJAKG7QJUIJIYR2B/children").value

(Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/v1.0/sites/$siteId/drive/items/$FolderId/content" -OutputFilePath ./test.md)
#Download from new library
$DocId = ((Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/v1.0/sites/$siteId/drives").value | Where-Object { $_.name -eq "SYSTEM" }).id
$FolderId = (Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/v1.0/sites/$siteId/drives/$DocId/items/root/children?`$filter=name eq 'customerX'").value.id
$Files = (Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/v1.0/sites/$siteId/drives/$DocId/items/$FolderId/children").value

$Files | ForEach-Object {
    (Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/v1.0/sites/$siteId/drives/$DocId/items/$($_.id)/content" -OutputFilePath "./$($_.name)")
}
