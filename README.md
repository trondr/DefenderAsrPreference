# DefenderAsrPreference
PowerShell module providing CmdLet for getting human readable information about attack surface reduction rules configured on a Windows Defender client

```PowerShell
Get-DefenderAsrPreference
```
### Example Output
```PowerShell
Id                                   Action Description
--                                   ------ -----------
01443614-cd74-433a-b99e-2ecdc07bfc25 Audit  Block executable files from running unless they meet a prevalence, age, ...
26190899-1602-49e8-8b27-eb1d0a1ce869 Audit  Block Office communication application from creating child processes
3b576869-a4ec-4529-8536-b80a7769e899 Audit  Block Office applications from creating executable content
5beb7efe-fd9a-4556-801d-275e5ffc04cc Block  Block execution of potentially obfuscated scripts
75668c1f-73b5-4cf0-bb93-3ecf5cb7cc84 Block  Block Office applications from injecting code into other processes
7674ba52-37eb-4a4f-a9a1-f0f9a1619a2c Block  Block Adobe Reader from creating child processes
92e97fa1-2edf-4476-bdd6-9dd0b4dddc7b Audit  Block Win32 API calls from Office macros
9e6c4e1f-7d60-472f-ba1a-a39ef669e4b2 Audit  Block credential stealing from the Windows local security authority subs...
b2b3f03d-6a65-4f7b-a9c7-1c7ef74a9ba4 Block  Block untrusted and unsigned processes that run from USB
be9ba2d9-53ea-4cdc-84e5-9b1eeee46550 Block  Block executable content from email client and webmail
c1db55ab-c21a-4637-bb3f-a12568109d35 Block  Use advanced protection against ransomware
d1e49aac-8f56-4280-b9ba-993a6d77406c Audit  Block process creations originating from PSExec and WMI commands
d3e037e1-3eb8-44c8-a917-57927947596d Block  Block JavaScript or VBScript from launching downloaded executable content
d4f940ab-401b-4efc-aadc-ad5f3c50688a Block  Block all Office applications from creating child processes
e6db77e5-3df2-4cf1-b95a-636979351e5b Block  Block persistence through WMI event subscription
```

## Import module for development and testing
```powershell
Import-Module -Path ".\modules\DefenderAsrPreference"
```

## Setup local repository
```powershell
New-Item -Path C:\ -Name "PSModuleRepository" -ItemType Directory
Register-PSRepository -Name 'PSModuleRepository' -SourceLocation 'C:\PSModuleRepository' -PublishLocation 'C:\PSModuleRepository' -InstallationPolicy Trusted
```

## Publish Module to local repository
```powershell
Publish-Module -Path ".\modules\DefenderAsrPreference" -Repository LocalPSModuleRepository
```

## Install Module from local repository
```powershell
Install-Module -Name DefenderAsrPreference -Repository LocalPSModuleRepository
Import-Module v
```

## Publish Module to PowerShell Gallery
```powershell
$ApiKey="...api...key...here..."
Publish-Module -Path ".\modules\DefenderAsrPreference" -Repository PSGallery -NuGetApiKey $ApiKey
