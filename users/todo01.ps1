#To Do and Planner
#https://learn.microsoft.com/en-us/graph/api/todotasklist-list-tasks?view=graph-rest-1.0&tabs=http
#Tasks.ReadWrite
$TodoLists = (Invoke-MgGraphRequest -Uri "/v1.0/users/82a90c41-0ae9-42a7-8599-b84f529ec33d/todo/lists").value
$TodoLists | ForEach-Object {
    $List = $_
    $Tasks = (Invoke-MgGraphRequest -Uri "/v1.0/users/82a90c41-0ae9-42a7-8599-b84f529ec33d/todo/lists/$($List.id)/tasks").value
    $Tasks | ForEach-Object {
        $Task = $_
        (Invoke-MgGraphRequest -Uri "/v1.0/users/82a90c41-0ae9-42a7-8599-b84f529ec33d/todo/lists/$($List.id)/tasks/$($Task.id)").id
        if ((Get-Date).AddDays(-1).ToUniversalTime() -gt [datetime]::Parse($Task.createdDateTime).ToUniversalTime()) {
            Write-Output "Old task: $($Task.createdDateTime) - $($Task.title)"
            (Invoke-MgGraphRequest -Uri "/v1.0/users/82a90c41-0ae9-42a7-8599-b84f529ec33d/todo/lists/$($List.id)/tasks/$($Task.id)" -Method DELETE)
        }
    }
}
