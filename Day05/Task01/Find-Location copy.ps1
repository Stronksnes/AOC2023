$lines = Get-Content .\input.txt | Out-String

$nl = [System.Environment]::NewLine
[array]$maps = ($lines -split "$nl$nl")

$completeMaps = New-Object System.Collections.Generic.List[PSObject] 

$seeds = ($maps[0].Split(":").trim())[1].split(" ")

foreach($seed in $seeds){

    $completeMap = [PSCustomObject]@{

        'seed'                      = $seed
        'seed-to-soil'              = ""
        'soil-to-fertilizer'        = ""
        'fertilizer-to-water'       = ""
        'water-to-light'            = ""
        'light-to-temperature'      = ""
        'temperature-to-humidity'   = ""
        'humidity-to-location'      = ""

    }

    $completeMaps.Add($completeMap)
}

$order = 'seed', 'seed-to-soil', 'soil-to-fertilizer', 'fertilizer-to-water', 'water-to-light', 'light-to-temperature', 'temperature-to-humidity', 'humidity-to-location'

$mapCount = 0

foreach ($map in $maps[1..($maps.Count - 1)]){

    $mapCount++
    $entryCount = 0

    $map = $map.Split("`n")
    $type = $map.split(":")[0].trim(" map")

    $prev = $order[($order.IndexOf($type)) - 1]

    Write-Progress -Activity "Checking Maps" -Status "Checking map: $mapCount / $($maps.Count -1) - $type" -PercentComplete (($mapCount/($maps.Count -1))*100) -Id 0

    foreach ($entry in $map[1..($map.Count)]){

        $entryCount++

        Write-Progress -Activity "Checking entries" -Status "checking entry $entryCount / $($map.Count -1)" -PercentComplete (($entryCount / $map.Count)*100) -Id 1 -ParentId 0

        [long]$dest, [long]$src, [long]$rangeLength = $entry.Split(" ")
        
        for ($i = 0; $i -lt $rangeLength; $i++) {

            Write-Progress -Activity "Checking source" -Status "Checking sourcerange: $($i+1) / $rangeLength" -PercentComplete (($i/$rangeLength)*100) -id 2 -ParentId 1

            [long]$destRange = $dest + $i
            [long]$srcRange = $src + $i

            if($srcRange -in $completeMaps.$prev) {

                ($completeMaps | where {$_.$prev -eq $srcRange}).$type = $destRange

            }

        }

    }

    $completeMaps | % {($_ | where {$_.$type -eq ""}).$type = $_.$prev}

}

$completeMaps | ft