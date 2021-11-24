# DefenderAsrPreference
PowerShell module providing CmdLet for getting human readable information about attack surface reduction rules configured on a Windows Defender client

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