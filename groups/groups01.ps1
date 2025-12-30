Invoke-MgGraphRequest -Uri "/v1.0/groups?`$filter=groupId eq '2095c832-2768-4ce9-a248-9815a0f0917d'"
Invoke-MgGraphRequest -Uri "/v1.0/groups?`$filter=startswith(displayName, 'a')&`$count=true&`$top=1"
Invoke-MgGraphRequest -Uri "/v1.0/groups?`$filter=NOT groupTypes/any(c:c eq 'Unified') and mailEnabled eq true and securityEnabled eq true&`$count=true"
Invoke-MgGraphRequest -Uri "/v1.0/groups?`$filter=mailEnabled eq false&securityEnabled eq true"
Invoke-MgGraphRequest -Uri "/v1.0/groups?`$orderby=displayName&)"
Invoke-MgGraphRequest -Uri "/v1.0/groups"

$Body = ConvertTo-Json @{
    description     = "Self help community for library"
    displayName     = "Library Assist"
    groupTypes      = @(
        "Unified"
    )
    mailEnabled     = $true
    mailNickname    = "library"
    securityEnabled = false
}

$Script = Invoke-MgGraphRequest -Uri "/v1.0/groups" -Method POST -Body $Body 
