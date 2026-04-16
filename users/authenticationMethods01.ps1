#UserAuthenticationMethod.Read.All 	UserAuthenticationMethod.ReadWrite.All
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
