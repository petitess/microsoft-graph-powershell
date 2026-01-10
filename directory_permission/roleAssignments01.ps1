$RoleAssignments = (Invoke-GraphRequest -Uri "/v1.0/roleManagement/directory/roleAssignments").value

$RoleAssignments | ForEach-Object {
    try {
        $Sp = (Get-MgServicePrincipal -ServicePrincipalId $_.principalId -ErrorAction SilentlyContinue).DisplayName
        $Def = (Get-MgRoleManagementDirectoryRoleDefinition -UnifiedRoleDefinitionId $_.roleDefinitionId -ErrorAction SilentlyContinue).DisplayName
        Write-Output "$($Sp) : $($Def)"
    }
    catch {
        Write-Output "NOT FOUND: $($_)"
    }
} 
