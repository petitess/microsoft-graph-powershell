# Connect with the necessary admin scopes
Connect-MgGraph -Scopes "DelegatedPermissionGrant.ReadWrite.All", "Application.Read.All"

$serverApplicationName = "GroupAccessTest"
$sp = Get-MgServicePrincipal -Filter "DisplayName eq '$serverApplicationName'"

# Microsoft Graph Service Principal
$graphSP = Get-MgServicePrincipal -Filter "appId eq '00000003-0000-0000-c000-000000000000'"

# Delegated permissions you want to grant (common set including openid)
$delegatedPermissions = @(
    "openid"
    "profile"
    "User.Read"
)

# Find the IDs of these delegated permissions (Scope = OAuth2 permission)
$scopeIds = foreach ($perm in $delegatedPermissions) {
    ($graphSP.OAuth2PermissionScopes | Where-Object { $_.Value -eq $perm }).Id
}

# Create the delegated permission grant (pre-consent for the entire tenant)
New-MgOauth2PermissionGrant `
    -ClientId $sp.Id `
    -ConsentType "AllPrincipals" `
    -ResourceId $graphSP.Id `
    -Scope ($delegatedPermissions -join " ")


#Update existing permission
Get-MgOauth2PermissionGrant -Filter "clientId eq '$($sp.Id)'"
Update-MgOauth2PermissionGrant -Oauth2PermissionGrantId "kn7-eF-rzEy4pXnE9MOScdYtylZJDTZEtOx_3STqvtw" -Scope "openid profile User.Read email"
