#User.Read.All UserAuthenticationMethod.Read.All UserAuthenticationMethod.ReadWrite.All
$Users = Get-MgUser -Filter "startsWith(displayName, '365-admin')" -All
Write-Host  "`nRetreived $($users.Count) users";

$Users | ForEach-Object {
    $Upn = $_.UserPrincipalName
    $Id = $_.Id

    $Methods = (Invoke-MgGraphRequest -Uri "v1.0/users/$Id/authentication/methods").value.'@odata.type'

    if ($Methods -match "#microsoft.graph.microsoftAuthenticatorAuthenticationMethod") {
        Write-Output "$Upn : true"
    }else {
        Write-Output "$Upn : false"
    }
}

#Table output
$Users = (Invoke-MgGraphRequest -Uri "v1.0/users?`$filter=startswith(displayName, '365-admin')").value
$Results = $Users | ForEach-Object {
    $Upn = $_.UserPrincipalName
    $Id  = $_.Id

    $Methods = (Invoke-MgGraphRequest -Uri "v1.0/users/$Id/authentication/methods").value.'@odata.type'

    [pscustomobject]@{
        UserPrincipalName = $Upn
        HasAuthenticator  = $Methods -match "#microsoft.graph.microsoftAuthenticatorAuthenticationMethod" ? $true : $false 
    }
}

$Results | Format-Table -AutoSize

#Runbook
Connect-MgGraph -Identity

$Users = (Invoke-MgGraphRequest -Uri "v1.0/users?`$filter=startswith(displayName, '365-admin')").value
Write-Output  "Retreived $($Users.Count) users";

$Users | ForEach-Object {
    $Upn = $_.UserPrincipalName
    $Id  = $_.Id
    $Nr += 1

    $Methods = (Invoke-MgGraphRequest -Uri "v1.0/users/$Id/authentication/methods").value.'@odata.type'

    $Methods = (Invoke-MgGraphRequest -Uri "v1.0/users/$Id/authentication/methods").value.'@odata.type'
    $HasAuthenticator = ($Methods -match "#microsoft.graph.microsoftAuthenticatorAuthenticationMethod" ? $true : $false)
    
    Write-Output "$Nr.MFA: $HasAuthenticator; Upn: $Upn"
}
