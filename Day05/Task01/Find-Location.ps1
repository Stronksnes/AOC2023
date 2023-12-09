$lines = Get-Content .\testinput.txt | Out-String

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

$map = $maps[1].Split("`n")
$type = $map.split(":")[0].trim(" map")

foreach($map in $maps[1..($maps.Count - 1)]){

    $map = $map.Split("`n")
    $type = $map.split(":")[0].trim(" map")

    $prev = $order[($order.IndexOf($type)) - 1]

    foreach($entry in $map[1..($map.Count)]){

        [long]$dest, [long]$src, [long]$rangeLength = $entry.Split(" ")
        
        $destRange = 0
        $srcRange = 0
        [array]$destRange += for ($i = 0; $i -lt $rangeLength; $i++){ $dest + $i }
        [array]$srcRange += for ($i = 0; $i -lt $rangeLength; $i++){ $src + $i }

        foreach($SRE in $srcRange){

            if($SRE -in $completeMaps.$prev) {

                ($completeMaps | where {$_.$prev -eq $SRE}).$type = $dest + ($SRE - $src)

            }

        }

    }

    $completeMaps | % {($_ | where {$_.$type -eq ""}).$type = $_.$prev}

}

$completeMaps | ft