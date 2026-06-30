#https://learn.microsoft.com/en-us/graph/api/user-list-contactfolders?view=graph-rest-1.0&tabs=http
#Contacts.ReadWrite
$Folders = (Invoke-MgGraphRequest -Uri "/v1.0/users/ven.ops.hp@compx.onmicrosoft.com/contactFolders").value
$Folders | ForEach-Object {
    $Contacts = (Invoke-MgGraphRequest -Uri "/v1.0/users/ven.ops.hp@compx.onmicrosoft.com/contactFolders/$($_.id)/contacts").value
    $Contacts.emailAddresses.address
    $Contacts | ForEach-Object {
        $Contact =(Invoke-MgGraphRequest -Uri "/v1.0/users/ven.ops.hp@compx.onmicrosoft.com/contactFolders/$($_.id)/contacts/$($_.id)")
        $Contact.emailAddresses[0].address
        # (Invoke-MgGraphRequest -Uri "/v1.0/users/ven.ops.hp@compx.onmicrosoft.com/contactFolders/$($_.id)/contacts/$($_.id)" -Method DELETE)
    }
}

(Invoke-MgGraphRequest -Uri "/v1.0/users/ven.ops.hp@compx.onmicrosoft.com/contacts").value[0]

#CREATE
$Folders = (Invoke-MgGraphRequest -Uri "/v1.0/users/ven.ops.hp@compx.onmicrosoft.com/contactFolders").value
$Folders | ForEach-Object {
    $params = @{
        givenName      = "Karol"
        surname        = "Sek"
        emailAddresses = @(
            @{
                address = "karol.sek@comp.se"
                name    = "Karol Sek"
            }
        )
        businessPhones = @(
            "+1 732 555 0102"
        )
    }
    $Create = (Invoke-MgGraphRequest -Uri "/v1.0/users/ven.ops.hp@compx.onmicrosoft.com/contactFolders/$($_.id)/contacts" -Method POST -Body $params)
    $Create
}
