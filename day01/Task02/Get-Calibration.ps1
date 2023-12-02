function Get-Calibration {

    param (

        [string]$DocString

    )
    
    $sIntArray     = "1", "2", "3", "4", "5", "6", "7", "8", "9"
    $spelledArray  = "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"  

    $sIntPattern = $sIntArray -join "|"
    $spelledPattern =  "(?=(" + ($spelledArray -join "|") + "))"

    $sIntCheck = ($DocString | Select-String -Pattern $sIntPattern -AllMatches).Matches
    $spelledCheck = ($DocString | Select-String -Pattern $spelledPattern -AllMatches).Matches
    if($spelledCheck){$spelledCheck = $spelledCheck | % {$_.Groups[1]}}

    if($spelledCheck -in ($null,"")){$combined = $sIntCheck}
    elseif($sIntCheck -in ($null,"")){$combined = $spelledCheck}
    else{$combined = $sIntCheck + $spelledCheck}

    $first, $last = $null

    foreach ($entry in $combined) {

        if($first -eq $null){$first = $entry}
        elseif($entry.Index -le $first.Index){$first = $entry}
        if($entry.Index -gt $last.Index){$last = $entry}

    }

    if($first.Value.Length -eq 1){$calOut += $first.Value}
    else{$firstAct = $sIntArray[[Array]::IndexOf($spelledArray, $first.Value)]; $calOut += $firstAct}

    if(!$last){
        
        if($first.Value.Length -eq 1){$calOut += $first.Value}
        else{$calOut += $firstAct}

    }
    elseif($last.Value.Length -eq 1){$calOut += $last.Value}
    else{$calOut += $sIntArray[[Array]::IndexOf($spelledArray, $last.Value)]}
    
    $calOut = $calOut -as [int]
    $calOut

}