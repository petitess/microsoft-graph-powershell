Connect-MgGraph -Scopes 'Application.ReadWrite.All' -TenantId "xxx"
$ObjectId = "xxx-25a8d733fc56"
Get-MgApplication -ApplicationId $ObjectId
Invoke-MgGraphRequest GET -Uri "https://graph.microsoft.com/v1.0/applications/$ObjectId"
$Body = ConvertTo-Json @{
    passwordCredential = @{
        displayName = "mgraph_secret"
    }
}
Invoke-MgGraphRequest POST -Uri "https://graph.microsoft.com/v1.0/applications/$ObjectId/addPassword" -Body $Body
