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
