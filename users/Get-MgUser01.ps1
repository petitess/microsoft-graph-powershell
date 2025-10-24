Get-MgUser -All -Property DisplayName, UserPrincipalName, CompanyName `
-ConsistencyLevel eventual -CountVariable userCount `
-Filter "startsWith(CompanyName, 'Abc Invest')" |
Select-Object DisplayName, UserPrincipalName, CompanyName

Get-MgUser -All -Property DisplayName, UserPrincipalName, OfficeLocation `
-ConsistencyLevel eventual -CountVariable userCount `
-Filter "startsWith(OfficeLocation, 'A1 Consulting Poland')" |
Select-Object DisplayName, UserPrincipalName, OfficeLocation
