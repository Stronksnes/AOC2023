$lines = Get-Content .\input.txt

$instructions, $tempLocations = $lines.Split('`n')

$instructions = ($instructions.Trim()).ToCharArray()
$tempLocations = $tempLocations | where {$_}

$locations = New-Object System.Collections.Generic.List[PSObject]

foreach($tempLocation in $tempLocations){

    $obj = [PSCustomObject]@{
        location    = $tempLocation.Split("=")[0].trim()
        Left        = $tempLocation.Split("=")[1].split(",").trim().trim(")(")[0]
        Right       = $tempLocation.Split("=")[1].split(",").trim().trim(")(")[1]
    }

    $locations.Add($obj)

}

$pos = $locations.location.IndexOf("AAA")
$loc = 0
$steps = 0

$location = $locations[$pos]

while ($location.location -ne "ZZZ") {
    
    if(($loc) -eq $instructions.Count){$loc = 0}

    $location = $locations[$pos]
    $direction = $instructions[$loc]

    switch ($direction) {

        L {$tDir = "LEFT"}
        R {$tDir = "RIGHT"}

    }

    $pos = $locations.location.IndexOf($location.$tDir)

    $loc++
    $steps++

    $location
    $tDir
    $steps -1

}