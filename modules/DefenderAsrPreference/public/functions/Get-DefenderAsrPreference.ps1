function Get-DefenderAsrPreference
{
	<#
		.SYNOPSIS
		Get human readable information about attack surface reduction rules configured on a Windows Defender client
		
		.DESCRIPTION
		Get human readable information about attack surface reduction rules configured on a Windows Defender client

		.EXAMPLE
		Get-DefenderAsrPreference

		.NOTES        
		Version:        1.0
		Author:         github/trondr
		Company:        github/trondr
		Repository:     https://github.com/trondr/DefenderAsrPreference.git
	#>
	[CmdletBinding()]
	Param (
		[Parameter(ValueFromPipeline=$true)]
		$InputObject
	)
	
	begin
	{
        filter ArrayToHash
        {
            begin { $hash = @{} }
            process { $hash[$_.Id] = $_ }
            end { return $hash }
        }

		$asrDescription = @(
            [PSCustomObject][Ordered]@{Id="01443614-cd74-433a-b99e-2ecdc07bfc25";Description="Block executable files from running unless they meet a prevalence, age, or trusted list criterion"},
            [PSCustomObject][Ordered]@{Id="26190899-1602-49e8-8b27-eb1d0a1ce869";Description="Block Office communication application from creating child processes"},
            [PSCustomObject][Ordered]@{Id="3b576869-a4ec-4529-8536-b80a7769e899";Description="Block Office applications from creating executable content"},
            [PSCustomObject][Ordered]@{Id="56a863a9-875e-4185-98a7-b882c64b5ce5";Description="Block abuse of exploited vulnerable signed drivers"},
            [PSCustomObject][Ordered]@{Id="5beb7efe-fd9a-4556-801d-275e5ffc04cc";Description="Block execution of potentially obfuscated scripts"},
            [PSCustomObject][Ordered]@{Id="75668c1f-73b5-4cf0-bb93-3ecf5cb7cc84";Description="Block Office applications from injecting code into other processes"},
            [PSCustomObject][Ordered]@{Id="7674ba52-37eb-4a4f-a9a1-f0f9a1619a2c";Description="Block Adobe Reader from creating child processes"},
            [PSCustomObject][Ordered]@{Id="92e97fa1-2edf-4476-bdd6-9dd0b4dddc7b";Description="Block Win32 API calls from Office macros"},
            [PSCustomObject][Ordered]@{Id="9e6c4e1f-7d60-472f-ba1a-a39ef669e4b2";Description="Block credential stealing from the Windows local security authority subsystem (lsass.exe)"},
            [PSCustomObject][Ordered]@{Id="b2b3f03d-6a65-4f7b-a9c7-1c7ef74a9ba4";Description="Block untrusted and unsigned processes that run from USB"},
            [PSCustomObject][Ordered]@{Id="be9ba2d9-53ea-4cdc-84e5-9b1eeee46550";Description="Block executable content from email client and webmail"},
            [PSCustomObject][Ordered]@{Id="c1db55ab-c21a-4637-bb3f-a12568109d35";Description="Use advanced protection against ransomware"},
            [PSCustomObject][Ordered]@{Id="d1e49aac-8f56-4280-b9ba-993a6d77406c";Description="Block process creations originating from PSExec and WMI commands"},
            [PSCustomObject][Ordered]@{Id="d3e037e1-3eb8-44c8-a917-57927947596d";Description="Block JavaScript or VBScript from launching downloaded executable content"},
            [PSCustomObject][Ordered]@{Id="d4f940ab-401b-4efc-aadc-ad5f3c50688a";Description="Block all Office applications from creating child processes"},
            [PSCustomObject][Ordered]@{Id="e6db77e5-3df2-4cf1-b95a-636979351e5b";Description="Block persistence through WMI event subscription"}
        ) | ArrayToHash

        function Get-AsrDescription {            
            param (
                [Parameter(Mandatory=$true)]
                [string]
                $AsrId
            )
            if($asrDescription.ContainsKey($AsrId))
            {
                $asrDescription[$AsrId].Description
            }
            else {
                "Uknown"
            }
        }
        #TEST: Get-Asrdescription -AsrId "e6db77e5-3df2-4cf1-b95a-636979351e5b"
        function Get-AsrAction {            
            param (
                [Parameter(Mandatory=$true)]
                [int]
                $AsrAction
            )
            if($AsrAction -eq 2){
                "Audit"
            } elseif ($AsrAction -eq 1){
                "Block"
            } else {
                "Unknown"
            }
        
        }


	}
	process
	{
		$mpPreference = Get-MpPreference 
        $asrActions = $mpPreference.AttackSurfaceReductionRules_Actions
        $asrIds = $mpPreference.AttackSurfaceReductionRules_Ids
        New-Zip -First $asrIds -Second $asrActions -ResultSelector {$id=$first[0].ToLower();$action=Get-AsrAction -AsrAction $second[0]; [PSCustomObject][Ordered]@{Id=$id;Action=$action;Description=""} } | ForEach-Object{ $_.Description = $(Get-AsrDescription -AsrId $_.Id);$_}
	}
	end
	{
	
	}
}
#TEST: Get-DefenderAsrPreference