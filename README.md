# microsoft-graph-powershell

### Authenticate to Microsoft Graph PowerShell using secret
1. Entra Id > App registration > New registration
2. API permissions > Add a permission > Microsoft Graph > Application permissions
3. Create a secret
4. Run the script:
```pwsh
$appid = "abc"
$tenantid = 'abc'
$secretPlain = 'abc'
$secret = ConvertTo-SecureString -String $secretPlain -AsPlainText -Force
$ClientSecretCredential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $appid, $secret
Connect-MgGraph -TenantId $tenantid -ClientSecretCredential $ClientSecretCredential -NoWelcome
Get-MgContext
``` 
### Authenticate to Microsoft Graph PowerShell using secret - Invoke-RestMethod
```pwsh
$appid = $env:mg_x_root_01_id
$tenantid = $env:x_tenant
$secret = $env:mg_x_root_01_secret
$body =  @{
    Grant_Type    = "client_credentials"
    Scope         =  "https://graph.microsoft.com/.default"
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
```
### Authenticate to Microsoft Graph PowerShell using personal account and custom app registration

Assign Delegated permission to the app e.g `User.ReadWrite.All, UserAuthenticationMethod.ReadWrite.All`

Add Redirect URI: Authentication → Add a platform → Mobile and desktop applications

Add: `http://localhost`, `https://login.microsoftonline.com/common/oauth2/nativeclient` and `ms-appx-web://Microsoft.AAD.BrokerPlugin/<client_id>`
```pwsh
Connect-MgGraph -Scopes "User.ReadWrite.All","UserAuthenticationMethod.ReadWrite.All" -ClientId "abc" -TenantId "abc"
```
### Filter
```pwsh
Invoke-MgGraphRequest -Uri "/v1.0/policies/roleManagementPolicies?`$filter=scopeId eq '/' and scopeType eq 'DirectoryRole'"
```
