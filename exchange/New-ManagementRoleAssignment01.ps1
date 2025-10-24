###https://learn.microsoft.com/en-us/exchange/permissions-exo/application-rbac#define-resource-scope
###Install-Module -Name ExchangeOnlineManagement
###Install-Module Microsoft.Graph

#Authenticate to graph with sp
$appid = "abc"
$tenantid = 'abc'
$secret = 'abc'
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

#Authenticate to exchange online
Connect-ExchangeOnline
#Create App Registration without Calendars.ReadWrite MailboxSettings.ReadWrite. RBAC will provide these.
#Get the id of the app
$App = Get-MgServicePrincipal -Filter "DisplayName eq 'sp-mail-limited-test'"
#Create new app in exchange
New-ServicePrincipal -AppId $App.AppId -ObjectId $App.Id -DisplayName $App.DisplayName
#Create a scope
#Properties: https://learn.microsoft.com/en-us/powershell/exchange/recipientfilter-properties?view=exchange-ps
$ScopeName = "AbcInvest"
New-ManagementScope -Name $ScopeName -RecipientRestrictionFilter {Company -eq "Abc Invest AB"}
#Get users with company name
Get-MgUser -All -Property DisplayName, UserPrincipalName, CompanyName `
-ConsistencyLevel eventual -CountVariable userCount `
-Filter "startsWith(CompanyName, 'Abc Invest')" |
Select-Object DisplayName, UserPrincipalName, CompanyName
#Get managed roles
Get-ManagementRole
#Assign the scoped role to the application
New-ManagementRoleAssignment -App $App.AppId -Role "Application Calendars.ReadWrite" -CustomResourceScope $ScopeName
New-ManagementRoleAssignment -App $App.AppId -Role "Application MailboxSettings.ReadWrite" -CustomResourceScope $ScopeName
#Test a user
Test-ServicePrincipalAuthorization -Identity $App.AppId -Resource "user.one@abcd.se"
Test-ServicePrincipalAuthorization -Identity $App.AppId -Resource "user.two@abcd.se"
#If yoou own app registration, login with service principal used for exchange online(sp-mail-limited-test)
#Make Api Call to get user calendar
Invoke-GraphRequest -Uri "/v1.0/users/user.one@abcd.se/calendar"
Invoke-GraphRequest -Uri "/v1.0/users/user.two@abcd.se/calendar"
