#https://learn.microsoft.com/en-us/graph/api/driveitem-put-content?view=graph-rest-1.0&tabs=http
#Files.ReadWrite.All 	Sites.ReadWrite.All
(Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/v1.0/sites/root" )
(Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/v1.0/sites/companyname.sharepoint.com" )
(Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/v1.0/sites/companyname.sharepoint.com:/sites/ADL-B3" )

$siteId = (Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/v1.0/sites/root:/sites/ADL-A3" ).id

(Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/v1.0/sites/$siteId/drive" ).name

(Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/v1.0/sites/$siteId/drive")

(Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/v1.0/sites/$siteId/drives")

(Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/v1.0/sites/$siteId/drive/items/root/children").value

(Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/v1.0/sites/$siteId/drive/items/01RRNAIB7RYVUGBUMQEJAKG7QJUIJIYR2B/children").value

$Body = @{
    name = "new_folder"
    folder = @{}
    "@microsoft.graph.conflictBehavior" = "rename" #fail, replace
}

(Invoke-MgGraphRequest -Method POST -Uri "https://graph.microsoft.com/v1.0/sites/$siteId/drive/items/01RRNAIB7RYVUGBUMQEJAKG7QJUIJIYR2B/children" -Body $Body)

(Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/v1.0/sites/$siteId/drive/items/01RRNAIB7Q67ULQW52SVDKAQQLVXSSF5SG/content" -OutputFilePath ./test.md)

$Content = @"
# New File

This is the content of the new file.
"@

(Invoke-MgGraphRequest -Method PUT -Uri "https://graph.microsoft.com/v1.0/sites/$siteId/drive/items/01RRNAIB7RYVUGBUMQEJAKG7QJUIJIYR2B:/new_file.md:/content" -Body $Content -ContentType "text/markdown")
