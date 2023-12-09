function Beat-Record {
    param (
        $TotalTime,
        $TotalDistance
    )
    
    $waysToWinCount = 0

    ### $I is number of ms holding down the button
    for ($i = 0; $i -lt $TotalTime; $i++) {

        $speed = $i
        $distance = $speed * ($TotalTime - $i)

        if ($distance -gt $TotalDistance){$waysToWinCount++}

    }

    $waysToWinCount

}

$input = Get-Content .\input.txt
$parsed = New-Object System.Collections.Generic.List[PSObject]
$lines = $input -split "`n"
$headers = $lines[0] -split "\s+" | ? { $_ }
$values = $lines[1] -split "\s+" | ? { $_ }
for ($i=1; $i -lt $headers.Length; $i++) {
    $parsed.add([PSCustomObject]@{
        Time = $headers[$i]
        Distance = $values[$i]
    })
}

$time = $parsed.Time -join ""
$distance = $parsed.Distance -join ""

Beat-Record -TotalTime $time -TotalDistance $distance

