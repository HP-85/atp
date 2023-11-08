# atp
This script downloads the AWS.Tools.zip file containing all AWS.Tool PowerShell modules, 
and extracts them to the user's PSModules folder in their home directory as described in the 2nd install option on this page:
* https://docs.aws.amazon.com/powershell/latest/userguide/pstools-getting-set-up-windows.html#ps-installing-awstools

This eliminiates the time and effort involved with determining which moduels are needed, and using the Install-AWSToolsModule tool (1st and 3rd option).

It also addresses the issue described on this page:
* https://github.com/aws/aws-tools-for-powershell/issues/172


Tested on
* Windows 10 PS5 and PS7
* Windows 11 PS5 and PS7
* Ubuntu 22.04 PS7
* macos 14 PS7
