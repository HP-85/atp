# AWS Tools for PowerShell - cross platform installer
This script downloads the AWS.Tools.zip file containing all AWS.Tool PowerShell modules, 
and extracts them to the user's PSModules folder in their home directory as described in the 2nd install option on this page:
* https://docs.aws.amazon.com/powershell/latest/userguide/pstools-getting-set-up-windows.html#ps-installing-awstools

This eliminiates the time and effort involved with determining which moduels are needed, and using the Install-AWSToolsModule tool (1st and 3rd option).

It also addresses the issue described on this page:
* https://github.com/aws/aws-tools-for-powershell/issues/172


Tested on:
* Windows 10 PS5 and PS7
* Windows 11 PS5 and PS7
* Ubuntu 22.04 PS7
* macos 14 PS7


Sample Output:
```
PS /home/cc/Desktop> ./AWS.Tools.Install.ps1
Detected home folder for PowerShell Modules: /home/cc/.local/share/powershell/Modules
AWS.Tools detected in /home/cc/.local/share/powershell/Modules - removing currently installed AWS.Tools modules.
Downloading AWS.Tools.zip to: /home/cc/.local/share/powershell/Modules/AWS.Tools.zip
Expanding AWS.Tools.zip to: /home/cc/.local/share/powershell/Modules
Deleting AWS.Tools.zip                                                                                                  
Time to Download and Install: 
TotalSeconds : 10.2948905


AWS.Tools for PowerShell installed - running Get-AWSPowerShellVersion 

AWS Tools for PowerShell
Version 4.1.447
Copyright 2012-2023 Amazon.com, Inc. or its affiliates. All Rights Reserved.

Amazon Web Services SDK for .NET
Core Runtime Version 3.7.204.14
Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.

Release notes: https://github.com/aws/aws-tools-for-powershell/blob/master/CHANGELOG.md

This software includes third party software subject to the following copyrights:
- Logging from log4net, Apache License
[http://logging.apache.org/log4net/license.html]

Completed
```
