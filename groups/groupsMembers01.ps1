$user1 = (Invoke-MgGraphRequest -Uri "/v1.0/users?`$filter=mail eq 'Dennis.alfredsson@abc.se'").Value.id
$user2 = (Invoke-MgGraphRequest -Uri "/v1.0/users?`$filter=mail eq 'sara.goden@abc.se'").Value.id

(Invoke-MgGraphRequest -Uri "/v1.0/groups?`$filter=startswith(displayName, 'EpiserverAbcPublic-')&`$select=displayName,id").value[0] | ForEach-Object {
    Write-Output "Group Name: $($_.displayName) - Group ID: $($_.id)"

    $Exists1 = (Invoke-MgGraphRequest -Uri "/v1.0/groups/$($_.id)/members").value.id | Where-Object { $_ -eq $user1 }
    if ($Exists1) {
        Write-Output "User1 already a member."
    }
    else {
        Write-Output "Adding User1 to group..."
        $body = @{
            "@odata.id" = "https://graph.microsoft.com/v1.0/directoryObjects/$user1"
        } | ConvertTo-Json

        Invoke-MgGraphRequest -Method POST -Body $body -Uri "/v1.0/groups/$($_.id)/members/$('$ref')"
    }

    $Exists2 = (Invoke-MgGraphRequest -Uri "/v1.0/groups/$($_.id)/members").value.id | Where-Object { $_ -eq $user2 }
    if ($Exists2) {
        Write-Output "User2 already a member."
    }
    else {
        Write-Output "Adding User2 to group..."
        $body = @{
            "@odata.id" = "https://graph.microsoft.com/v1.0/directoryObjects/$user2"
        } | ConvertTo-Json

        Invoke-MgGraphRequest -Method POST -Body $body -Uri "/v1.0/groups/$($_.id)/members/$('$ref')"
    }
}
