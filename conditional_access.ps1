#Policy.Read.All Policy.ReadWrite.ConditionalAccess

(Invoke-MgGraphRequest -Uri "/v1.0/identity/conditionalAccess/policies").value

$Policy = (Invoke-MgGraphRequest -Uri "/v1.0/identity/conditionalAccess/policies/e7ca806e-8d8b-48bf-a9b7-76fc2282f8a4") | ConvertTo-Json -Depth 10

$Policy = @{
    grantControls    = @{
        "operator"                    = "OR"
        "builtInControls"             = @(
            "compliantDevice"
        )
        "termsOfUse"                  = @()
        "authenticationStrength"      = $null
        "customAuthenticationFactors" = @()
    }
    sessionControls  = $null
    templateId       = $null
    displayName      = "Require Intune managed and compliant device (ekonomi) Test"
    "@odata.context" = "https=//graph.microsoft.com/v1.0/$metadata#identity/conditionalAccess/policies/$entity"
    conditions       = @{
        "devices"                    = $null
        "users"                      = @{
            includeUsers                 = @(
                "a8c3b9a3-8bd4-4bd8-aadf-5bbfb222f9e4"
            )
            excludeGuestsOrExternalUsers = $null
            includeGroups                = @(
                "2fe02df3-6b9f-456d-ab46-7d45931fab68"
            )
            includeRoles                 = @()
            excludeRoles                 = @()
            includeGuestsOrExternalUsers = $null
            excludeUsers                 = @()
            excludeGroups                = @(
                "247d0629-2400-404a-a8b0-6dcbc00a99a3"
            )
        }
        "servicePrincipalRiskLevels" = @()
        "applications"               = @{
            includeUserActions                          = @()
            applicationFilter                           = $null
            includeApplications                         = @(
                "88bb0908-2ac4-4fcd-8f14-85e72dbf6413"
                "cb07fe18-05be-47c7-a945-27872d9ac3a2"
            )
            excludeApplications                         = @()
            includeAuthenticationContextClassReferences = @()
        }
        authenticationFlows          = $null
        clientApplications           = $null
        signInRiskLevels             = @()
        locations                    = $null
        userRiskLevels               = @()
        clientAppTypes               = @(
            "browser"
            "mobileAppsAndDesktopClients"
        )
        "platforms"                  = @{
            includePlatforms = @(
                "windows"
                "macOS"
                "linux"
            )
            excludePlatforms = @(
                "android"
                "iOS"
            )
        }
        "insiderRiskLevels"          = $null
    }
    state            = "enabled"
}

$NewPolicy = Invoke-MgGraphRequest -Uri "/v1.0/identity/conditionalAccess/policies" -Method POST -Body ($Policy | ConvertTo-Json -Depth 10)

$Policy = @{
    "grantControls"   = @{
        "operator"                    = "OR"
        "builtInControls"             = @()
        "termsOfUse"                  = @()
        "authenticationStrength"      = @{
            "description"               = "Passwordless methods that satisfy strong authentication such as Passwordless sign-in with the Microsoft Authenticator"
            "combinationConfigurations" = @()
            "displayName"               = "Passwordless MFA"
            "allowedCombinations"       = @(
                # "windowsHelloForBusiness"
                # "fido2"
                # "x509CertificateMultiFactor"
                # "deviceBasedPush"
            )
            "policyType"                = "builtIn"
            "requirementsSatisfied"     = "mfa"
            "id"                        = "00000000-0000-0000-0000-000000000003"
        }
        "customAuthenticationFactors" = @()
    }
    "sessionControls" = $null
    "templateId"      = $null
    "displayName"     = "Require MFA for Privileged Role assignment TEST"
    # "@odata.context"  = "https://graph.microsoft.com/v1.0/$metadata#identity/conditionalAccess/policies/$entity"
    "conditions"      = @{
        "@odata.type"                = "microsoft.graph.conditionalAccessConditionSet"
        "devices"                    = $null
        "users"                      = @{
            "includeUsers"                 = @()
            "excludeGuestsOrExternalUsers" = $null
            "includeGroups"                = @(
                "7527eb76-8b0b-4c49-8b86-30fe03a16857"
                "8926c165-6d85-4165-b177-95192ad40654"
                "81bc011e-fdaf-4bb7-a16e-72e86b3f00c9"
            )
            "includeRoles"                 = @()
            "excludeRoles"                 = @()
            "includeGuestsOrExternalUsers" = $null
            "excludeUsers"                 = @(
                "a6f702d3-97c1-4f8c-8554-643fc557cfda"
                "d7a4a984-a7c0-4c5b-a4f9-547f24cf6891"
                "dfe3f5f0-d74c-4558-b730-a235f2d8235c"
            )
            "excludeGroups"                = @(
                "95e99329-060e-4da6-a5f5-3371c92397fc"
            )
        }
        "servicePrincipalRiskLevels" = @()
        "applications"               = @{
            "includeUserActions"                          = @()
            "applicationFilter"                           = $null
            "includeApplications"                         = @()
            "excludeApplications"                         = @()
            "includeAuthenticationContextClassReferences" = @(
                "c1"
            )
        }
        "authenticationFlows"        = $null
        "clientApplications"         = $null
        "signInRiskLevels"           = @()
        "locations"                  = $null
        "userRiskLevels"             = @()
        "clientAppTypes"             = @(
            "all"
        )
        "platforms"                  = $null
        "insiderRiskLevels"          = $null
    }
    "state"           = "enabledForReportingButNotEnforced"
}

$NewPolicy = Invoke-MgGraphRequest -Uri "/v1.0/identity/conditionalAccess/policies" -Method POST -Body ($Policy | ConvertTo-Json -Depth 20)
