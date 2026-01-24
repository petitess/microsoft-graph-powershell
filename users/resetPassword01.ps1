#UserAuthenticationMethod.ReadWrite.All
#Only personal account

(Invoke-MgGraphRequest -Uri "/v1.0/users?`$filter=userPrincipalName eq 'pim.karol.sek@abc.onmicrosoft.com'").value
(Invoke-MgGraphRequest -Uri "/v1.0/users/kar.sek.ext@abc.se/authentication/methods").value
$body = @{
    "newPassword"= "xyz.123"
}
Invoke-MgGraphRequest -Method POST -Uri "/v1.0/users/kar.sek.ext@abc.se/authentication/methods/28c10230-6103-485e-b985-444c60001490/resetPassword" -Body $body
