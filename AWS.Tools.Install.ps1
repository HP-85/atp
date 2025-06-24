<# coolcrai
2023-11-08 Install AWS.Tools for PowerShell 7 on Windows, Mac, or Linux, and PowerShell 5.1 on Windows
2023-11-08 Installs to user's PS Modules folder so installation does not require eleveated prompt
2023-11-08 Deletes existing AWS.Tools module directories in user's home folder to clear older versions
2024-07-12 Updated PSModules home folder detection to work within VSCode
2025-01-11 Added error catch if PS Modulues are already loaded
2025-06-05 Added -Installv5Preview switch parameter to install preview version
2025-06-05 Added -Remove switch parameter to remove AWS.Tools from user PSModule Path
2025-06-24 Changed default install to AWS.Tools v5
2025-06-24 Added -v4 switch to install latest AWS.Tools v4
2025-06-24 Added -Version param to install a specific version (eg to match AWS.Tools in CloudShell)
    see https://github.com/aws/aws-tools-for-powershell/blob/main/changelogs/CHANGELOG.2025.md for versions 
#>

param(
    [switch]$v4,
    [switch]$Remove,
    [string]$Version
)
# Validate Version parameter if provided
if ($Version -and $Version -notmatch '^\d\.\d\.\d{3}$') {
    Write-Host "Version must be in format X.X.XXX (e.g., 4.1.674)" -ForegroundColor Red
    Write-Host "see https://github.com/aws/aws-tools-for-powershell/blob/main/changelogs/CHANGELOG.2025.md for versions."
    break
}

# Linux and macOS PowerShell 7
If ($IsLinux -eq $true -or $IsMacOS -eq $true) {
    $PSMUserPath = $env:PSModulePath -split ':' |
    Where-Object { $_ -like "$env:HOME*" } |
    Select-Object -First 1      # in VSCode, the PS Extention shell has a second module folder in the home directory
    #Exit if no home path is found
    if ($null -eq $PSMUserPath) {
        Write-Host "Could not determine PowerShell module folder in your home path"
        Write-Host "Current PS Module Paths:"
        $Env:PSModulePath -split "[:]"
        Write-Host "Exiting script"
        Exit
    }
}

# Windows PowerShell 5 and 7  (PS5 does not support $IsWindows, so check for $env:OS instead)
If ($env:OS -eq "Windows_NT") {
    $PSMUserPath = $env:PSModulePath -split ';' | 
    Where-Object { $_ -like "*$env:HOMEPATH*" } |
    Select-Object -First 1 # in VSCode, the PS Extention shell has a second module folder in the home directory
    if ($null -eq $PSMUserPath) {
        Write-Host "Could not determine PowerShell module folder in your home path"
        Write-Host "Current PS Module Paths:"
        $Env:PSModulePath -split "[;]"
        Write-Host "Exiting script"
        Exit
    }
}

# Show the detected home folder for PowerShell Modules
Write-Host "Detected home folder for PowerShell Modules: " -ForegroundColor Cyan -NoNewline
Write-Host "$PSMUserPath"

Measure-Command {
    #Delete current AWS Modules:
    If (Test-Path $PSMUserPath/Aws.Tools.*) {
        Write-Host "AWS.Tools detected in " -NoNewline -ForegroundColor Cyan
        Write-Host "$PSMUserPath" -NoNewline
        Write-Host " - removing currently installed AWS.Tools modules." -ForegroundColor Cyan
        try {
            Remove-Item -Path $PSMUserPath/Aws.Tools.* -Force -Recurse -ErrorAction Stop
        }
        catch {
            Write-Host "Error removing AWS.Tools modules: $_" -ForegroundColor Red
            Write-Host "Please close PowerShell and try again to ensure all AWS.Tools modules are unloaded" -ForegroundColor Yellow
            Break
        }
    }
   # exit without installing if -remove param is specified
    If ($Remove) {
            Write-Host '"-Remove" switch specified - exiting without installing.' -ForegroundColor Cyan
            Break
        }
    
    #Create PSModule User Path Directory if it doesn't exist - common after installing PS7
    If (-not (Test-Path $PSMUserPath)) { 
        Write-Host "Creating Directory: " -ForegroundColor Cyan -NoNewline
        Write-Host $PSMUserPath 
        New-Item -Path $PSMUserPath -Type Directory
    }
    
    #Download .zip file
    [System.Net.ServicePointManager]::SecurityProtocol = 'TLS12'
    $progressPreference = 'silentlyContinue'
    
    # Set download URL based on parameters
    $downloadUrl = if ($Version) {
        Write-Host "Installing AWS.Tools Version $Version" -ForegroundColor Yellow
        "https://sdk-for-net.amazonwebservices.com/ps/releases/AWS.Tools.$Version.zip"
    } elseif ($v4) {
        Write-Host 'Installing latest build of AWS.Tools v4' -ForegroundColor Yellow
        "https://sdk-for-net.amazonwebservices.com/ps/v4/latest/AWS.Tools.zip"
    } else {
        Write-Host "Installing AWS.Tools v5" -ForegroundColor Yellow
        "https://sdk-for-net.amazonwebservices.com/ps/v5/latest/AWS.Tools.zip"
    }

    Write-Host "Downloading AWS.Tools.zip from: " -ForegroundColor Cyan -NoNewline
    Write-Host $downloadUrl 
    Write-Host "Downloading AWS.Tools.zip to: " -ForegroundColor Cyan -NoNewline
    Write-Host "$PSMUserPath/AWS.Tools.zip" 
    Invoke-WebRequest `
        -Uri $downloadUrl `
        -OutFile $PSMUserPath/AWS.Tools.zip 
    
    #Expand modules to PSModule User Path Directory
    Write-Host "Expanding AWS.Tools.zip to: " -ForegroundColor Cyan -NoNewline
    Write-Host "$PSMUserPath"
    Expand-Archive -Path $PSMUserPath/AWS.Tools.zip -DestinationPath $PSMUserPath -Force
    
    #Delete AWS.Tools.zip file
    Write-Host 'Deleting AWS.Tools.zip'  -ForegroundColor Cyan
    Remove-Item $PSMUserPath/AWS.Tools.zip
    Write-Host 'Time to Download and Install: '  -ForegroundColor Cyan -NoNewline
} | Format-List TotalSeconds 

Write-Host 'AWS.Tools for PowerShell installed - running Get-AWSPowerShellVersion '  -ForegroundColor Cyan
Get-AWSPowerShellVersion
Write-Host 'Completed' -ForegroundColor Cyan
