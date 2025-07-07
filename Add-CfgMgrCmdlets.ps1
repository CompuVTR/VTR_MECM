<#
    .SYNOPSIS
     Run Configuration Manager cmdlets and scripts in PowerShell.

    .DESCRIPTION
     Run Configuration Manager cmdlets and scripts in PowerShell.

    .NOTES
     Version    : 1.0
     Author     : Victor Michael
     License    : MIT License
     Copyright  : 2025 CompuVTR

    .PARAMETER SiteCode
     Specifies the SCCM Site Code.
     
    .PARAMETER SiteServer
     Specifies the SCCM Site Server.

    .EXAMPLE
     Add-CfgMgrCmdlets -SC "V01" -SS "siteserver.compuvtr.com"
    
    .LINK
     https://learn.microsoft.com/en-us/powershell/sccm/overview
#>

param
(
    [Parameter(Mandatory)]
    [Alias("SC")][string]$SiteCode,

    [Parameter(Mandatory)]
    [Alias("SS")][string]$SiteServer
)

if (!(Get-Module -Name "ConfigurationManager"))
{
    if (Test-Path -Path "C:\Program Files (x86)\Microsoft Endpoint Manager\AdminConsole\bin")
    {
        Import-Module .\ConfigurationManager.psd1
    }
    else
    {
        Write-Host "Configuration Manager Console is not installed" -ForegroundColor Red
        exit
    }
}

try
{
    Get-PSDrive -Name $SiteCode -PSProvider "CMSite" -ErrorAction Stop
}
catch
{
    New-PSDrive -Name $SiteCode -PSProvider CMSite -Root $SiteServer
}

Set-Location -Path ($SiteCode + ":")

Get-CMSite
