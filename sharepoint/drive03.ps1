#Files.ReadWrite.All 	Sites.ReadWrite.All
$siteId = (Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/v1.0/sites/root:/sites/ADL-A3" ).id
$DocId = ((Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/v1.0/sites/$siteId/drives").value | Where-Object {$_.name -eq "SYSTEM"}).id

(Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/v1.0/sites/$siteId/drives/$DocId")

(Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/v1.0/sites/$siteId/drives/$DocId/items/root/children").value

$Body = @{
    name = "customer"
    folder = @{}
    "@microsoft.graph.conflictBehavior" = "rename" #fail, replace
}

(Invoke-MgGraphRequest -Method POST -Uri "https://graph.microsoft.com/v1.0/sites/$siteId/drives/$DocId/items/root/children" -Body $Body)
