#DelegatedPermissionGrant.ReadWrite.All
$params = @{
	clientId = "19f91dcb-54a9-4de7-a6f7-56d54397af0d" ##Microsoft Graph PowerShell 14d82eec-204b-4c2f-b7e8-296a70dab67e
	consentType = "Principal"
	resourceId = "e795411f-0c3a-49dd-8caf-487af9d67636" #Microsoft Graph 00000003-0000-0000-c000-000000000000
	scope = "User.ReadWrite.All"
  principalId = "" #User Object Id
}

New-MgOauth2PermissionGrant -BodyParameter $params

Remove-MgOauth2PermissionGrant -OAuth2PermissionGrantId
