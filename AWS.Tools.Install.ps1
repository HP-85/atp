# Install AWS.Tools for PowerShell 7 on Windows, Mac, or Linux, and PowerShell 5 on Windows
# Installs to user's PS Modules folder so installation does not require eleveated prompt
# Deletes existing AWS.Tools module directories to clear older versions
# coolcrai 2023-11-08

# Linux and macOS PS7
If ($IsLinux -eq $true -or $IsMacOS -eq $true) {
    $PSMUserPath = $env:PSModulePath -split ':' | Where-Object { $_ -like "$env:HOME*" }
}

# Windows PS5 PS7  (PS5 does not support $IsWindows, so check for $env:OS instead)
If ($env:OS -eq "Windows_NT") {
    $PSMUserPath = $env:PSModulePath -split ';' | Where-Object { $_ -like "*$env:HOMEPATH*" }
}

Write-Host "Detected home folder for PowerShell Modules: " -ForegroundColor Cyan -NoNewline
Write-Host "$PSMUserPath"
#need if 'null' write-host 'error' and quit

Measure-Command {
    #Delete current AWS Modules:
    #If you see errors like 'Access to the path 'aws-crt-auth.dll' is denied.' quit and re-leaunch PowerShell to unload AWS modules
    If (Test-Path $PSMUserPath/Aws.Tools.*) {
        Write-Host "AWS.Tools detected in " -NoNewline -ForegroundColor Cyan
        Write-Host "$PSMUserPath" -NoNewline
        Write-Host " - removing currently installed AWS.Tools modules." -ForegroundColor Cyan
        Remove-Item -Path $PSMUserPath/Aws.Tools.* -Force -Recurse 
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
    Write-Host "Downloading AWS.Tools.zip to: " -ForegroundColor Cyan -NoNewline
    Write-Host "$PSMUserPath/AWS.Tools.zip" 
    Invoke-WebRequest `
        -Uri https://sdk-for-net.amazonwebservices.com/ps/v4/latest/AWS.Tools.zip `
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