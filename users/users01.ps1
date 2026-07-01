$Uri = "/v1.0/users"
$Users = @()
do {
    $Response = Invoke-MgGraphRequest -Uri $Uri
    $Users += $Response.value
    $Uri = $Response.'@odata.nextLink'
} while ($Uri)
$Users
