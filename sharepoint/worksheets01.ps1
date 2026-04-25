#https://learn.microsoft.com/en-us/graph/api/range-insert?view=graph-rest-1.0&tabs=http
#https://learn.microsoft.com/en-us/graph/api/range-update?view=graph-rest-1.0&tabs=http
#Files.ReadWrite
# Create empty Excel file in SharePoint
$Body = @{
    "name" = "new_file4.xlsx"
    "file" = @{}
}

(Invoke-MgGraphRequest -Method POST -Uri "https://graph.microsoft.com/v1.0/sites/$siteId/drive/items/root/children" -Body $Body -ContentType "application/json")

# Get the file ID
$FileId = (Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/v1.0/sites/$siteId/drive/items/root/children?`$filter=name eq 'new_file4.xlsx'").value.id

# Add a new worksheet (Sheet2)
$WorksheetBody = @{
    "name" = "Sheet2"
}

(Invoke-MgGraphRequest -Method POST -Uri "https://graph.microsoft.com/v1.0/sites/$siteId/drive/items/$FileId/workbook/worksheets" -Body $WorksheetBody -ContentType "application/json")

# Update data in Sheet1
$Content = @{
    "values" = @(
        @("Name", "Age"),
        @("Ann", "3"),
        @("Bob", "4")
    )
}

(Invoke-MgGraphRequest -Method PATCH -Uri "https://graph.microsoft.com/v1.0/sites/$siteId/drive/items/$FileId/workbook/worksheets('Sheet1')/range(address='A1:B3')" -Body $Content -ContentType "application/json")


#Add array of values to Sheet1
$People = @(
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
$Row = 4
$Column = $Row + $People.Count - 1
(Invoke-MgGraphRequest -Method PATCH -Uri "https://graph.microsoft.com/v1.0/sites/$siteId/drive/items/$FileId/workbook/worksheets('Sheet1')/range(address='A$($Row):B$($Column)')" -Body $Content -ContentType "application/json")

