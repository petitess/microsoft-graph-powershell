#https://learn.microsoft.com/en-us/graph/api/user-list-approleassignments?view=graph-rest-1.0&tabs=http
#AppRoleAssignment.ReadWrite.All
(Invoke-MgGraphRequest -Uri "/v1.0/users/$userId/appRoleAssignments").value.resourceDisplayName
