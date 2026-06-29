#DelegatedPermissionGrant.ReadWrite.All
$MicrosoftGraphCommandLineTools = (Invoke-GraphRequest -Uri "/v1.0/servicePrincipals?`$filter=appId eq '14d82eec-204b-4c2f-b7e8-296a70dab67e'").value.id
$mGraphId = (Invoke-GraphRequest -Uri "/v1.0/servicePrincipals?`$filter=appId eq '00000003-0000-0000-c000-000000000000'").value.id
$body = @{
    clientId    = $MicrosoftGraphCommandLineTools
    consentType = "Principal"
    resourceId  = $mGraphId
    scope       = "User.Read.All Group.Read.All"
    principalId = "xyz" #User Obejct Id
}
Invoke-MgGraphRequest -Method POST -Uri "/v1.0/oauth2PermissionGrants" -Body $body

Invoke-MgGraphRequest -Method DELETE -Uri "/v1.0/oauth2PermissionGrants/xyz"
