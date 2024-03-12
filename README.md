# AWS Tools for PowerShell - cross platform installer
This script downloads the AWS.Tools.zip file containing all AWS.Tool PowerShell modules, 
and extracts them to the user's PSModules folder in their home directory (does not require elevated permissions) as described in the second install method described on this page:
* https://docs.aws.amazon.com/powershell/latest/userguide/pstools-getting-set-up-windows.html#ps-installing-awstools

It also addresses the issue described on this page:
* https://github.com/aws/aws-tools-for-powershell/issues/172


Tested on:
* Windows 10 PowerShell 5 and 7
* Windows 11 PowerShell 5 and 7
* Ubuntu 22.04 PowerShell 7
* macos 14 PowerShell 7

Command to run this script from github:
```powershell
Invoke-RestMethod -Uri "github.com/HP-85/atp/raw/main/AWS.Tools.Install.ps1" | Invoke-Expression
```

Sample Output:

![image](https://github.com/HP-85/atp/blob/main/awsps.png)
