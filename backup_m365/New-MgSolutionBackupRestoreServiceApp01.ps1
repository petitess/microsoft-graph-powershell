#BackupRestore-Control.ReadWrite.All
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
#Permission will be assigned to signed in application
$params = @{
}

New-MgSolutionBackupRestoreServiceApp -BodyParameter $params

Get-MgSolutionBackupRestoreServiceApp
Remove-MgSolutionBackupRestoreServiceApp -ServiceAppId "123-4468-a8a6-ca0e97bb9cc9"
