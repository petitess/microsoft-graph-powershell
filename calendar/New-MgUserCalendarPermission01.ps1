$appid = "123-790e-4081-866e-123"
$tenantid = '123-ae44-48b7-a392-123'
$secret = '123kUmofs1Uwk3gN~aXC'
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
$headers = @{
    "Authorization" = "Bearer $token"
    "Content-type"  = "application/json"
}
$secureToken = ConvertTo-SecureString $token -AsPlainText -Force
Connect-MgGraph -AccessToken $secureToken

$KonfUsers = Get-MgUser -All -Filter "startswith(displayName,'Konf Big')"
$delegateUser = "comeen@abc.se"

$KonfUsers | ForEach-Object {

    New-MgUserCalendarPermission -UserId $_.UserPrincipalName -EmailAddress @{Address = $delegateUser } -IsInsideOrganization -IsRemovable -Role "write"
}

$KonfUsers | ForEach-Object {
    $Perm = Get-MgUserCalendarPermission -UserId $_.UserPrincipalName | Where-Object { $_.EmailAddress.Name -eq "Comeen" } 
    $Perm
    if ($null -ne $Perm) {
        Remove-MgUserCalendarPermission -CalendarPermissionId $Perm.Id -UserId $_.UserPrincipalName
    }
}
