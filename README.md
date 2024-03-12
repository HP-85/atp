# AWS Tools for PowerShell - cross platform installer
This script downloads the AWS.Tools.zip file containing all AWS.Tool PowerShell modules, 
and extracts them to the user's PSModules folder in their home directory as described in the second install method described on this page:
* https://docs.aws.amazon.com/powershell/latest/userguide/pstools-getting-set-up-windows.html#ps-installing-awstools

It also addresses the issue described on this page:
* https://github.com/aws/aws-tools-for-powershell/issues/172


Tested on:
* Windows 10 PowerShell 5 and 7
* Windows 11 PowerShell 5 and 7
* Ubuntu 22.04 PowerShell 7
* macos 14 PowerShell 7

Command to run this script from the repo:
```powershell
Invoke-RestMethod -Uri "github.com/HP-85/atp/raw/main/AWS.Tools.Install.ps1" | Invoke-Expression
```

Sample Output:
```
PS /home/cc> Invoke-RestMethod -Uri "github.com/HP-85/atp/raw/main/AWS.Tools.Install.ps1" | Invoke-Expression
Detected home folder for PowerShell Modules: /home/cc/.local/share/powershell/Modules
AWS.Tools detected in /home/cc/.local/share/powershell/Modules - removing currently installed AWS.Tools modules.
Downloading AWS.Tools.zip to: /home/cc/.local/share/powershell/Modules/AWS.Tools.zip
Expanding AWS.Tools.zip to: /home/cc/.local/share/powershell/Modules
Deleting AWS.Tools.zip
Time to Download and Install: 
TotalSeconds : 5.5762452

AWS.Tools for PowerShell installed - running Get-AWSPowerShellVersion 

AWS Tools for PowerShell
Version 4.1.533
Copyright 2012-2024 Amazon.com, Inc. or its affiliates. All Rights Reserved.

Amazon Web Services SDK for .NET
Core Runtime Version 3.7.302.16
Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.

Release notes: https://github.com/aws/aws-tools-for-powershell/blob/master/CHANGELOG.md

This software includes third party software subject to the following copyrights:
- Logging from log4net, Apache License
[http://logging.apache.org/log4net/license.html]

Completed

```


