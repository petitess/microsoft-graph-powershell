#https://learn.microsoft.com/en-us/graph/api/driveitem-get-content?view=graph-rest-1.0&tabs=http
#https://learn.microsoft.com/en-us/graph/api/range-update?view=graph-rest-1.0&tabs=http
#Personal
Connect-MgGraph -Scopes "Files.ReadWrite.All", "User.ReadWrite.All"
(Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/v1.0/me/drive/root/children").value.name
(Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/v1.0/me/drive/items/root/children").value.name
$FolderId = (Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/v1.0/me/drive/items/root/children?`$filter=name eq 'PRAG2024'").value.id

$Items = (Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/v1.0/me/drive/items/$FolderId/children").value
$Items[0] | ForEach-Object { 
    Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/v1.0/me/drive/items/$($_.id)/content" -OutputFilePath "./$($_.name)" 
}

$Body = @{
    name                                = "customer"
    folder                              = @{}
    "@microsoft.graph.conflictBehavior" = "rename" #fail, replace
}

$NewFolder = (Invoke-MgGraphRequest -Method POST -Uri "https://graph.microsoft.com/v1.0/me/drive/items/$FolderId/children" -Body $Body)

$Body = @{
    "name" = "new_file.xlsx"
    "file" = @{}
}
#Xlsx works only in webbrowser
$NewFile = (Invoke-MgGraphRequest -Method POST -Uri "https://graph.microsoft.com/v1.0/me/drive/items/$($NewFolder.Id)/children" -Body $Body -ContentType "application/json")

#Add array of values to Sheet1
$People = @(
    @{ Name = "Name"; Age = "Age" }, 
    @{ Name = "Cathy"; Age = 6 },
    @{ Name = "David"; Age = 8 },
    @{ Name = "Eve"; Age = 10 },
    @{ Name = "Frank"; Age = 12 },
    @{ Name = "Grace"; Age = 14 },
    @{ Name = "Hank"; Age = 16 },
    @{ Name = "Ivy"; Age = 18 },
    @{ Name = "Jack"; Age = 20 }
)

$Values = @()
$People.Count
$People | ForEach-Object { 
    $Values += , @($_.Name, $_.Age)
}
$Values.Count
$Content = @{
    "values" = @($Values)
}
$Row = 1
$Column = $Row + $People.Count - 1
#The name of the shit is Blad1 in Swedish, but it is Sheet1 in English, so be careful with that
(Invoke-MgGraphRequest -Method PATCH -Uri "https://graph.microsoft.com/v1.0/me/drive/items/$($NewFile.Id)/workbook/worksheets('Blad1')/range(address='A$($Row):B$($Column)')" -Body $Content -ContentType "application/json")

$Content = @"
# New File

This is the content of the new file.
"@

(Invoke-MgGraphRequest -Method PUT -Uri "https://graph.microsoft.com/v1.0/me/drive/items/$($NewFolder.Id):/my_file.md:/content" -Body $Content -ContentType "text/markdown")
