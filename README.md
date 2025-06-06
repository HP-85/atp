# AWS Tools for PowerShell - multi platform install script
This script downloads the AWS.Tools.zip file containing all AWS.Tools PowerShell modules, 
and extracts them to the user's PSModules folder in their home directory (does not require elevated permissions) as described in the second install method described on this page:

>**Install AWS.Tools**
>  https://docs.aws.amazon.com/powershell/latest/userguide/pstools-getting-set-up-windows.html#ps-installing-awstools
>  "Downloading the modules from AWS.Tools.zip and...."

It also addresses the issue described here:
* https://github.com/aws/aws-tools-for-powershell/issues/172

Tested on:
* Windows 11 PowerShell 5 and 7.5.1 (x64 and arm64)
* Ubuntu 22.04 PowerShell 7.5.1 (x64 and arm64)
* macos 15 PowerShell 7.5.1 (arm64)

Possible issues:
* If you have AWS.Tools installed for 'all users' or another 'AWS Tools for PowerShell' package installed (such as AWSPowerShell.NetCore or AWSPowerShell), you may need to remove that to avoid conflicts.
* On Windows - you may need to run `Set-ExecutionPolicy RemoteSigned` 

Command to run this script from github:
```powershell
Invoke-RestMethod -Uri "https://github.com/HP-85/atp/raw/main/AWS.Tools.Install.ps1" | Invoke-Expression
```

To run directly from github with `-Installv5Preview` or `-Remove` parameters, use the following syntax:

Install v5 Preview (replaces existing AWS.Tools files user's PSModules folder):
* https://docs.aws.amazon.com/powershell/v5/userguide/pstools-welcome.html

```powershell
& ([ScriptBlock]::Create((Invoke-RestMethod -Uri "https://github.com/HP-85/atp/raw/main/AWS.Tools.Install.ps1"))) -Installv5Preview
```
Remove all AWS.Tools modules from user's PSModules folder:
```powershell
& ([ScriptBlock]::Create((Invoke-RestMethod -Uri "https://github.com/HP-85/atp/raw/main/AWS.Tools.Install.ps1"))) -remove
```

Sample Output:

![image](https://github.com/HP-85/atp/blob/main/awsps.png)
