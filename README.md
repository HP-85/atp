# AWS Tools for PowerShell - cross platform installer
This script downloads the AWS.Tools.zip file containing all AWS.Tools PowerShell modules, 
and extracts them to the user's PSModules folder in their home directory (does not require elevated permissions) as described in the second install method described on this page:

>**Install AWS.Tools**
>  https://docs.aws.amazon.com/powershell/latest/userguide/pstools-getting-set-up-windows.html#ps-installing-awstools
>  "Downloading the modules from AWS.Tools.zip and...."

It also addresses the issue described here:
* https://github.com/aws/aws-tools-for-powershell/issues/172

Tested on:
* Windows 10 PowerShell 5 and 7.4
* Windows 11 PowerShell 5 and 7.4 
* Ubuntu 22.04 PowerShell 7.4
* macos 15 PowerShell 7.4

Possible issues:
* If you have AWS.Tools installed for 'all users' or another 'AWS Tools for PowerShell' package installed (such as AWSPowerShell.NetCore or AWSPowerShell), you may need to remove that to avoid conflicts.

Command to run this script from github:
```powershell
Invoke-RestMethod -Uri "github.com/HP-85/atp/raw/main/AWS.Tools.Install.ps1" | Invoke-Expression
```

To from from github with `-Installv5Preview` or `-Remove` parameters:

```powershell
& ([ScriptBlock]::Create((Invoke-RestMethod -Uri "https://github.com/HP-85/atp/raw/main/AWS.Tools.Install.ps1"))) -Installv5Preview
& ([ScriptBlock]::Create((Invoke-RestMethod -Uri "https://github.com/HP-85/atp/raw/main/AWS.Tools.Install.ps1"))) -remove
```

Sample Output:

![image](https://github.com/HP-85/atp/blob/main/awsps.png)
