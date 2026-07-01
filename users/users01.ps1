$Uri = "/v1.0/users?$filter=memberType eq 'Member'&$select=id,displayName,userPrincipalName,createdDateTime&$top=999"
$Uri = "/v1.0/users?`$filter=userType eq 'Member' and OnPremisesSyncEnabled eq true"
$Users = @()
do {
    $Response = Invoke-MgGraphRequest -Uri $Uri
    $Users += $Response.value
    $Uri = $Response.'@odata.nextLink'
} while ($Uri)
$Users.Count
$Users[0] | ConvertTo-Json -Depth 10
