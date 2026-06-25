Invoke-MgGraphRequest -Uri "/v1.0/groups?`$filter=groupId eq '2095c832-2768-4ce9-a248-9815a0f0917d'"
Invoke-MgGraphRequest -Uri "/v1.0/groups?`$filter=startswith(displayName, 'a')&`$count=true&`$top=1"
Invoke-MgGraphRequest -Uri "/v1.0/groups?`$filter=NOT groupTypes/any(c:c eq 'Unified') and mailEnabled eq true and securityEnabled eq true&`$count=true"
Invoke-MgGraphRequest -Uri "/v1.0/groups?`$filter=mailEnabled eq false&securityEnabled eq true"
Invoke-MgGraphRequest -Uri "/v1.0/groups?`$orderby=displayName&)"
Invoke-MgGraphRequest -Uri "/v1.0/groups"

$groups = @(
    [PSCustomObject]@{ Name = "grp-dev-sys1-user-PIM-DEV"; Des = "This is a dev group" }
    [PSCustomObject]@{ Name = "grp-dev-sys1-user-PIM-TEST"; Des = "This is a test group" }
) 

$groups | ForEach-Object {
    $newName = $_.Name
    $newName
    $Body = ConvertTo-Json @{
        description     = $_.Des
        displayName     = $newName
        groupTypes      = @()
        mailEnabled     = $false
        mailNickname    = $newName
        securityEnabled = $true
        uniqueName      = $newName
    }
    Invoke-MgGraphRequest -Uri "/v1.0/groups" -Method POST -Body $Body
}
#PATCH uniqueName can be udated only once, immutable
$groups = @(
    [PSCustomObject]@{ Name = "grp-dev-sys1-user-PIM-DEV"; Id = "2095c832-2768-4ce9-a248-9815a0f0917d" }
    [PSCustomObject]@{ Name = "grp-dev-sys1-user-PIM-TEST"; Id = "62a4f638-2a82-41af-913c-3d01370be77a" }
) 

$groups | ForEach-Object {
    Write-Output $_.Name
    Write-Output "/v1.0/groups/$($_.Id)"
    $Body = ConvertTo-Json @{
        uniqueName = $_.Name
    }
    $Body
    Invoke-MgGraphRequest -Uri "/v1.0/groups/$($_.Id)" -Method PATCH -Body $Body
}
