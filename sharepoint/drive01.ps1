#https://learn.microsoft.com/en-us/graph/api/driveitem-get-content?view=graph-rest-1.0&tabs=http
#Files.Read.All
(Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/v1.0/sites/root" )
(Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/v1.0/sites/companyname.sharepoint.com" )
(Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/v1.0/sites/companyname.sharepoint.com:/sites/ADL-B3" )

$siteId = (Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/v1.0/sites/root:/sites/ADL-A3" ).id

(Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/v1.0/sites/$siteId/drive" ).name

(Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/v1.0/sites/$siteId/drive")

(Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/v1.0/sites/$siteId/drive/items/root/children").value

(Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/v1.0/sites/$siteId/drive/items/01RRNAIB7RYVUGBUMQEJAKG7QJUIJIYR2B/children").value

(Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/v1.0/sites/$siteId/drive/items/01RRNAIB7Q67ULQW52SVDKAQQLVXSSF5SG/content" -OutputFilePath ./test.md)

(Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/v1.0/sites/$siteId/drives")
