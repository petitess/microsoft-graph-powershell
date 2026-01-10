$TenantId = "abc"
Connect-MgGraph -TenantId $TenantId -Scopes 'Application.Read.All', 'AppRoleAssignment.ReadWrite.All'
#List Role Assignments
$spObjectId = "6bd0c4a1-6983-4640-9e20-6d1a344b78cf"
$roleAssignments = (Invoke-GraphRequest -Uri "/v1.0/servicePrincipals/$spObjectId/appRoleAssignments").value
$roleAssignments | ForEach-Object {
    try {
        $AppRoleId = $_.appRoleId
        $AppRoleName = ((Invoke-GraphRequest -Uri "/v1.0/servicePrincipals?`$filter=appId eq '00000003-0000-0000-c000-000000000000'").value.appRoles | Where-Object { $_.id -eq $AppRoleId }).value
        Write-Output "$($_.principalDisplayName) : $($AppRoleName)"
    }
    catch {
        Write-Output "NOT FOUND: $($_)"
    }
} 
#Create Role Assignment
$spObjectId = (Invoke-GraphRequest -Uri "/v1.0/servicePrincipals?`$filter=displayName eq 'sp-mg-tenant-root-group'").value.id
$appRoleId = ((Invoke-GraphRequest -Uri "/v1.0/servicePrincipals?`$filter=appId eq '00000003-0000-0000-c000-000000000000'").value.appRoles | Where-Object { $_.value -eq "Mail.Send" }).id
$mGraphId = (Invoke-GraphRequest -Uri "/v1.0/servicePrincipals?`$filter=appId eq '00000003-0000-0000-c000-000000000000'").value.id
$body = @{
    "principalId" = $spObjectId
    "resourceId" = $mGraphId
    "appRoleId" = $appRoleId
}

$roleAssignment = (Invoke-GraphRequest -Method POST -Uri "/v1.0/servicePrincipals/$spObjectId/appRoleAssignments" -Body $body  )
$roleAssignment
#Delete Role Assignment
(Invoke-GraphRequest -Method DELETE -Uri "/v1.0/servicePrincipals/$spObjectId/appRoleAssignments/$($roleAssignment.id)")
