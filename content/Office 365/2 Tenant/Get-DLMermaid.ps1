<#
.SYNOPSIS
Visualize nested distribution lists as a mermaid chart

.DESCRIPTION
This script will output a Mermaid file that can be used to visualize how distribution groups are nested within each other.

.PARAMETER TopDistributionList
This is the distribution list you want to start with, at the top of the nesting

.PARAMETER Path
This is where you want to save the mermaid file

.PARAMETER Levels
The maximum number of levels to traverse

.PARAMETER IncludeUsers
Enable to show users (not just nested DLs) in the output

.EXAMPLE
Get-DLMermaid -TopDistributionList "Entire-Company" -Path "Entire-Company.mmd"

graph LR
    Entire-Company(Company - All)
    Entire-Company --> Sales-Department(Company - Sales)
    Entire-Company --> Marketing-Department(Company - Marketing)
    Entire-Company --> Manufacturing-Department(Company - Manufacturing)
    Sales-Department(Company - Sales)
    Sales-Department --> Sales-East(Company - Sales - East)
    Sales-Department --> Sales-West(Company - Sales - West)
    Marketing-Department(Company - Marketing)
    Marketing-Department --> Marketing-East(Company - Marketing - East)
    Marketing-Department --> Marketing-West(Company - Marketing - West)
    Manufacturing-Department(Company - Manufacturing)
    Manufacturing-Department --> Manufacturing-East(Company - Manufacturing - East)
    Manufacturing-Department --> Manufacturing-West(Company - Manufacturing - West)
#>
Function Get-DLMermaid
{
    [CmdletBinding()]
    param (
        [parameter(Mandatory)]
        [string]
        $TopDistributionList,
        [parameter(Mandatory)]
        [string]
        $Path,
        [parameter()]
        [int]
        $levels = 10,
        [Parameter()]
        [switch]
        $IncludeUsers
    )

    begin
    {
        $TopDL = $TopDistributionList
    }

    process
    {
        $Output = do
        {
            "graph LR"
            $TopDLs = Get-DistributionGroup -Identity $TopDL
            do
            {
                $l++
                Write-Progress -Activity "Level" -Status "$($l)" -Id 1
                $NextDLs = $null
                for ($d = 0; $d -lt $TopDls.count; $d++)
                {
                    Write-Progress -Activity "DLs" -Status "$($TopDLs[$d].DisplayName)" -Id 2 -ParentId 1 -PercentComplete (($d / $TopDls.count) * 100)
                    "    $($TopDLs[$d].Alias)($($TopDLs[$d].DisplayName))"
                    $DlMembers = Get-DistributionGroupMember -Identity $TopDls[$d] | Where-Object {$_.RecipientType -EQ "MailUniversalDistributionGroup"}
                    foreach ($Member in $DlMembers)
                    {
                        "    $($TopDLs[$d].Alias) --> $($Member.Alias)($($Member.DisplayName))"
                    }
                    $NextDLs += $DlMembers
                }
                $TopDls = $NextDLs
                Write-Progress -Id 2 -ParentId 1 -Completed
            } until (($null -eq $TopDLs) -or ($l -eq $levels))
        } until ($true)
        Write-Progress -Id 1 -Completed
    }

    end
    {
        $Output | Out-File -Path $Path
        return $Output
    }
}
