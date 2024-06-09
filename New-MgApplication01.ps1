$AppName = 'sp-graph-01'
$GitHubOrg = 'petitess'
$GitHubRepo = 'yaml'
$Subjects = @(
    [pscustomobject]@{ Name = 'github-main'; Subject = "repo:$GitHubOrg/$($GitHubRepo):ref:refs/heads/main" }
    [pscustomobject]@{ Name = 'github-pr'; Subject = "repo:$GitHubOrg/$($GitHubRepo):pull_request" }
    [pscustomobject]@{ Name = 'github-env'; Subject = "repo:$GitHubOrg/$($GitHubRepo):environment:dev" }
)
if (!(Get-MgApplication -Filter "DisplayName eq '$AppName'")) {
    Write-Output "Creating $AppName"
    $App = New-MgApplication -DisplayName $AppName
    Start-Sleep 20
    $Subjects | ForEach-Object {
        New-MgApplicationFederatedIdentityCredential -ApplicationId $App.Id `
            -Name $_.Name `
            -Audiences @('api://AzureADTokenExchange') `
            -Issuer 'https://token.actions.githubusercontent.com' `
            -Subject $_.Subject
    }
}
else {
    Write-Output "$AppName already exists"
    $AppId = (Get-MgApplication -Filter "DisplayName eq '$AppName'").Id
    if ($AppId.Count -gt 1) {
        Write-Output "More than 1 app with this name exists"
    }
    else {
        $Subjects | ForEach-Object {
            Write-Output "Updating federated credentials"
            $CredId = (Get-MgApplicationFederatedIdentityCredential -ApplicationId $AppId -Filter "Name eq '$($_.Name)'").Id
            Update-MgApplicationFederatedIdentityCredential -ApplicationId $AppId `
                -Name $_.Name `
                -Audiences @('api://AzureADTokenExchange') `
                -Issuer 'https://token.actions.githubusercontent.com' `
                -Subject $_.Subject `
                -FederatedIdentityCredentialId $CredId
        }
    }
}
