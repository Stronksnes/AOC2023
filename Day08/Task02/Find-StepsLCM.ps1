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

$stepsForNodes = @()
$ghosts = $locations.location | where {$_ -like "*A"} | % {$locations.location.IndexOf($_)}

foreach($ghost in $ghosts){

    $pos = $ghost
    $loc = 0
    $steps = 0

    $location = $locations[$pos]

    while ($location.location -notlike "*Z") {
        
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

    $stepsForNodes += ($steps -1)

}

### Help from copilot
# Function to calculate GCD (Greatest Common Divisor)
function Get-GCD {
    param(
        [long]$a,
        [long]$b
    )
    while ($b -ne 0) {
        $remainder = $a % $b
        $a = $b
        $b = $remainder
    }
    return $a
}

# Function to calculate LCM (Least Common Multiple)
function Get-LCM {
    param(
        [long]$a,
        [long]$b
    )
    return ($a * $b) / (Get-GCD $a $b)
}

# Calculate LCM
$lcm = 1
foreach ($steps in $stepsForNodes) {
    $lcm = Get-LCM $lcm $steps
}

# Output the result
Write-Output "The number of steps before you're only on nodes that end with Z is: $lcm"
