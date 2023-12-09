### GONNA TAKE A LONG TIME

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

$loc = 0
$steps = 0


$startLocations = $locations.location | where {$_ -like "*A"} | % {$locations.location.IndexOf($_)}

while (1) {
    
    if(($loc) -eq $instructions.Count){$loc = 0}

    $direction = $instructions[$loc]

    switch ($direction) {

        L {$tDir = "LEFT"}
        R {$tDir = "RIGHT"}

    }

    $zCount = 0

    $Ghostlocations = $startLocations
    $startLocations = @()

    foreach($Ghostlocation in $Ghostlocations){

        $location = $locations[$Ghostlocation]
        $startLocations += $locations.location.IndexOf($location.$tDir)

        if($location.location -like "*Z"){$zCount++}

    }

    $loc++
    $steps++
    $steps -1

    if($zCount -eq $startLocations.Count){Write-Host "Booooo! $($steps -1)";break}

}