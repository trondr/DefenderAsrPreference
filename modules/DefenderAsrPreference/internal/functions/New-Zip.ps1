function New-Zip
{
    <#
		.SYNOPSIS
		Zip two arrays
		
		.DESCRIPTION
		Zip two arrays

        .EXAMPLE
		Write-Host "Parameter input"
        $first = 1..10
        $second = 100..3
        $first | New-zip -First $first -Second $second -ResultSelector {"$first : $second"}

		.EXAMPLE
		Write-Host "Pipeline input"
        $first = 1..10
        $second = 100..3
        $first | New-zip -Second $second -ResultSelector {"$first : $second"}

		.NOTES     
        Source:         https://gist.githubusercontent.com/guitarrapc/0c043019b775552e53b4/raw/02df6b57b1778a1ce9fbcff2df31c5c6da370845/New-Zip.ps1   
		Version:        1.0
		Author:         github/trondr
		Company:        github/trondr
		Repository:     https://github.com/trondr/DefenderAsrPreference.git
	#>
    [CmdletBinding()]
    param
    (
        [parameter(
            Mandatory = 0,
            Position = 0,
            ValueFromPipeline = 1,
            ValueFromPipelineByPropertyName = 1)]
        [PSObject[]]
        $First,
 
        [parameter(
            Mandatory = 0,
            Position = 1,
            ValueFromPipelineByPropertyName = 1)]
        [PSObject[]]
        $Second,

        [parameter(
            Mandatory = 0,
            Position = 2,
            ValueFromPipelineByPropertyName = 1)]
        [scriptBlock]
        $ResultSelector
    )

    process
    {
        if ([string]::IsNullOrWhiteSpace($First)){ break }        
        if ([string]::IsNullOrWhiteSpace($Second)){ break }
        
        try
        {
            $e1 = @($First).GetEnumerator()

            while ($e1.MoveNext() -and $e2.MoveNext())
            {
                if ($PSBoundParameters.ContainsKey('ResultSelector'))
                {
                    $First = $e1.Current
                    $Second = $e2.Current
                    $context = $ResultSelector.InvokeWithContext(
                        $null,
                        ($psvariable),
                        {
                            (New-Object System.Management.Automation.PSVariable ("First", $First)),
                            (New-Object System.Management.Automation.PSVariable ("Second", $Second))
                        }
                    )
                    $context
                }
                else
                {
                    $tuple = New-Object 'System.Tuple[PSObject, PSObject]' ($e1.Current, $e2.current)
                    $tuple
                }
            }
        }
        finally
        {
            if($null -ne ($d1 = $e1 -as [IDisposable]) ) { $d1.Dispose() }
            if($null -ne ($d2 = $e2 -as [IDisposable]) ) { $d2.Dispose() }
            if($null -ne ($d3 = $psvariable -as [IDisposable]) ) {$d3.Dispose() }
            if($null -ne ($d4 = $context -as [IDisposable]) ) {$d4.Dispose() }
            if($null -ne ($d5 = $tuple -as [IDisposable]) ) {$d5.Dispose() }
        }
    }

    begin
    {
        $e2 = @($second).GetEnumerator()
        $psvariable = New-Object 'System.Collections.Generic.List[PSVariable]]'
    }
}
#TEST:
#$first = 1..10
#$second = 100..3
#$first | New-zip -second $second -resultSelector {"$first : $second"}

#$first = 1..10
#$second = 100..3
#$first | New-zip -second $second