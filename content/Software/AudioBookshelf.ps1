$Server = "https://abs.oriontech.info"
$Creds = Get-Credential


$LoginParams = @{
    'Uri' = "$($Server)/login"
    'Headers' = @{
        'Content-Type' = 'application/json'
    }
    'Body' = @{
        "username" = $Creds.UserName
        "password" = ConvertFrom-SecureString -AsPlainText -SecureString $Creds.Password
    } | ConvertTo-Json
    'Method' = 'Post'
}

$Authentication = Invoke-RestMethod @LoginParams

$Token = ConvertTo-SecureString -AsPlainText -String $Authentication.user.token -Force

$Libraries = Invoke-RestMethod -Uri "$($Server)/api/libraries"

$AudiobooksID = $Libraries.libraries.id

$SeriesParams = @{
    'Uri' = "$($Server)//api/libraries/$($AudiobooksID)/series?limit=100&page=0&sort=totalDuration&desc=1"
    'Method' = 'Get'
    'Authentication' = 'Bearer'
    'Token' = $Token
    'Headers' = @{
        'Content-Type' = 'application/json'
    }
}

$AllSeries = Invoke-RestMethod @SeriesParams

$Array = foreach ($Series in $AllSeries.results) {
    $Properies = [ordered]@{
        'name' = $Series.Name
        'nameIgnorePrefix' = $Series.nameIgnorePrefix
        'totalDuration' = [timespan]::fromseconds($Series.totalDuration)
        'x1.2-Speed' = [timespan]::fromseconds($Series.totalDuration/1.2)
    }
    New-Object -TypeName psobject -Property $Properies
}