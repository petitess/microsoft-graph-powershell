Get-MgUser -All -Property DisplayName, UserPrincipalName, CompanyName `
-ConsistencyLevel eventual -CountVariable userCount `
-Filter "startsWith(CompanyName, 'Abc Invest')" |
Select-Object DisplayName, UserPrincipalName, CompanyName
