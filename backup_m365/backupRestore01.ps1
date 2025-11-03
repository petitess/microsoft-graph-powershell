#https://learn.microsoft.com/en-us/microsoft-365/backup/storage/backup-3p-lifecycle?view=o365-worldwide
#Sign in with app registration which will be connected to M365 backup 
$appid = "abc"
$tenantid = 'abc'
$secret = 'abc'
$body = @{
  Grant_Type    = "client_credentials"
  Scope         = "https://graph.microsoft.com/.default"
  Client_Id     = $appid
  Client_Secret = $secret
}
$connection = Invoke-RestMethod `
  -Uri "https://login.microsoftonline.com/$tenantid/oauth2/v2.0/token" `
  -Method POST `
  -Body $body
$token = $connection.access_token
$secureToken = ConvertTo-SecureString $token -AsPlainText -Force
Connect-MgGraph -AccessToken $secureToken
Get-MgContext


Invoke-MgGraphRequest -Uri "/v1.0/solutions/backupRestore"
$Body = @"
{
    "appOwnerTenantId": "abc"
}
"@
Invoke-MgGraphRequest -Uri "/v1.0/solutions/backupRestore/enable" -Method POST -Body $Body
Invoke-MgGraphRequest -Uri "/v1.0/solutions/backupRestore/protectionPolicies"
Invoke-MgGraphRequest -Uri "/v1.0/solutions/backupRestore/protectionUnits/microsoft.graph.siteProtectionUnit"
Invoke-MgGraphRequest -Uri "/v1.0/solutions/backupRestore/sharePointProtectionPolicies"

#Activate your application to be the Microsoft 365 Backup Storage Controller
$Body = @"
{
    "effectiveDateTime" :"$([System.DateTime]::Parse("2024-04-19T12:01:03.45Z"))",
}
"@
Invoke-MgGraphRequest -Uri "/v1.0/solutions/backupRestore/serviceApps/123-abc/activate" -Method POST -Body $Body

$Error01 = @"
{
    "error": {
        "code": "OperationNotAllowed",
        "message": "This operation is not allowed for controllerProtectionPolicies.POST",
        "innerError": {
            "date": "2025-10-23T12:48:09",
            "request-id": "4021929c-f143-4653-9118-169b88f7692c",
            "client-request-id": "61c25ac4-8271-4d37-92a0-2c06b4c2b5bd"
        }
    }
}
"@
$Error02 = @"
{
    "error": {
        "code": "OperationNotAllowed",
        "message": "This operation is not allowed for controllerProtectionPolicies.GET",
        "innerError": {
            "date": "2025-10-23T12:50:04",
            "request-id": "dfe0cc16-79bf-49d0-922e-c7031a345cde",
            "client-request-id": "37f53651-fb6a-41e9-980b-ebf2fd75da6b"
        }
    }
}
"@
