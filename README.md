# microsoft-graph-powershell

### Authenticate to Microsoft Graph PowerShell using secret
1. Entra Id > App registration > New registration
2. API permissions > Add a permission > Microsoft Graph > Application permissions
3. Create a secret
4. Run the script:
```pwsh
$appid = "x-f137-4e11-b18e-6db395c662aa"
$tenantid = 'x-b710-439d-b5bd-f5b83846ddee'
$secret = ConvertTo-SecureString -String 'xWQlj4iWElQANwX~m4R7-MaGcr1' -AsPlainText -Force
$Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $appid, $secret
$ClientSecretCredential = Get-Credential -Credential $Credential
Connect-MgGraph -TenantId $tenantid -ClientSecretCredential $ClientSecretCredential
Get-MgContext
``` 
