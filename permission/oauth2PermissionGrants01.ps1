#DelegatedPermissionGrant.ReadWrite.All Directory.ReadWrite.All
$SpObjectId = (Invoke-MgGraphRequest -Uri "/v1.0/servicePrincipals?`$filter=appId eq 'fd642066-7bfc-4b65-9463-6a08841c12f0'").value.id
$GraphResourceId = (Invoke-MgGraphRequest -Uri "/v1.0/servicePrincipals?`$filter=appId eq '00000003-0000-0000-c000-000000000000'").value.id
$Body = ConvertTo-Json @{
  clientId    = $SpObjectId
  consentType = "AllPrincipals"
  resourceId  = $GraphResourceId
  scope       = "DataProtection.Read.All DataProtection.ReadWrite.All BackupRestore-Configuration.ReadWrite.All BackupRestore-Control.Read.All"
}
$IMg = Invoke-MgGraphRequest -Uri "/v1.0/oauth2PermissionGrants" -Method POST -Body $Body
$IMg

Invoke-MgGraphRequest -Uri "/v1.0/oauth2PermissionGrants/IIpVCLIqmEqCMASBVVulIh9Blec6DN1JjK9IevnWdjY" -Method DELETE
