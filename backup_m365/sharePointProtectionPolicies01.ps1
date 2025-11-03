#https://learn.microsoft.com/en-us/graph/api/protectionpolicybase-activate?view=graph-rest-1.0&tabs=http
Connect-MgGraph -Scopes "BackupRestore-Configuration.ReadWrite.All BackupRestore-Control.ReadWrite.All BackupRestore-Monitor.Read.All BackupRestore-Restore.ReadWrite.All BackupRestore-Search.Read.All"

Get-MgSolutionBackupRestoreSharePointProtectionPolicy

Invoke-MgGraphRequest -Uri "/v1.0/solutions/backupRestore/sharePointProtectionPolicies/12345678-f230-468b-a641-a959c7fbf745/deactivate" -Method POST
Invoke-MgGraphRequest -Uri "/v1.0/solutions/backupRestore/sharePointProtectionPolicies/12345678-4a00-4398-97e9-01ebe883cee8/activate" -Method POST

Invoke-MgGraphRequest -Uri "/v1.0/solutions/backupRestore/sharePointProtectionPolicies/12345678-f230-468b-a641-a959c7fbf745/siteInclusionRules" | ConvertTo-Json -Depth 100
Invoke-MgGraphRequest -Uri "/v1.0/solutions/backupRestore/sharePointProtectionPolicies/12345678-4a00-4398-97e9-01ebe883cee8/siteInclusionRules" | ConvertTo-Json -Depth 100

Invoke-MgGraphRequest -Uri "/v1.0/solutions/backupRestore/sharePointProtectionPolicies/12345678-f230-468b-a641-a959c7fbf745/siteInclusionRules/d44b2c5f-be7d-4f41-a239-ada416ad3347" 

Invoke-MgGraphRequest -Uri "/v1.0/solutions/backupRestore/sharePointProtectionPolicies/12345678-f230-468b-a641-a959c7fbf745/siteInclusionRules/d44b2c5f-be7d-4f41-a239-ada416ad3347/run" -Method POST

$InclusionRule = @{
    isAutoApplyEnabled = $false
    siteExpression     = "((displayName -contains 'https://abconline.sharepoint.com/sites') -or (webUrl -contains 'https://abconline.sharepoint.com/sites'))"
}

Invoke-MgGraphRequest -Uri "/v1.0/solutions/backupRestore/sharePointProtectionPolicies/12345678-4a00-4398-97e9-01ebe883cee8/siteInclusionRules" -Method POST -Body $InclusionRule | ConvertTo-Json

(Invoke-MgGraphRequest -Uri "/v1.0/solutions/backupRestore/sharePointProtectionPolicies/12345678-f230-468b-a641-a959c7fbf745/siteProtectionUnits").value.siteWebUrl

Invoke-MgGraphRequest -Uri "/v1.0/solutions/backupRestore/sharePointProtectionPolicies/12345678-f230-468b-a641-a959c7fbf745/siteProtectionUnitsBulkAdditionJobs"

Get-MgSolutionBackupRestoreProtectionPolicy -ProtectionPolicyBaseId "12345678-f230-468b-a641-a959c7fbf745" | ConvertTo-Json

Remove-MgSolutionBackupRestoreProtectionPolicy -ProtectionPolicyBaseId "12345678-f230-468b-a641-a959c7fbf745"

(Get-MgSolutionBackupRestoreProtectionUnitAsSiteProtectionUnit) | ConvertTo-Json | Out-File sites.txt
