#Remove
(Invoke-MgGraphRequest -Uri "/v1.0/groups?`$filter=startswith(displayName, 'EpiserverAlmiPublic-')&`$select=displayName,id").value | ForEach-Object {
    Write-Output "Group Name: $($_.displayName) - Group ID: $($_.id)"
    $groupId = $_.id

    $Exists1 = ((Invoke-MgGraphRequest -Uri "/v1.0/groups/$($groupId)/members").value | Where-Object { $_.mail -like "*abcevry.com" }) | ForEach-Object {
        Write-Output "Removing: $($_.mail) is a member of the group."
        (Invoke-MgGraphRequest -Method DELETE -Uri "/v1.0/groups/$($groupId)/members/$($_.id)/$('$ref')")
    }
    $Exists1
}
#List
(Invoke-MgGraphRequest -Uri "/v1.0/groups?`$filter=startswith(displayName, 'EpiserverAbcPublic-')&`$select=displayName,id").value | ForEach-Object {
    Write-Output "_________________________"
    Write-Output "$($_.displayName.ToUpper()):`n"

    $Exists1 = (Invoke-MgGraphRequest -Uri "/v1.0/groups/$($_.id)/members").value.mail
    $Exists1
}
