$lines = Get-Content .\input.txt

$numberStringArray = "1", "2", "3", "4", "5", "6", "7", "8", "9", "0"
$charArray = $lines.tochararray() | select -Unique
$symbols = $charArray | where {$_ -notin $numberStringArray}
$symbols = $symbols | where {$_ -ne "."}

$result = for ($X = 0; $X -lt $lines.Count; $X++) {
    
    for ($Y = 0; $Y -lt $lines[$X].Length; $Y++) {

        if($lines[$X][$Y] -eq '*'){
            
            if($X -ne 0){

                if($lines[$X-1][$Y-1] -in $numberStringArray){Scan-GridChar $lines -X ($X-1) -Y ($Y-1)}
                if($lines[$X-1][$Y]   -in $numberStringArray){Scan-GridChar $lines -X ($X-1) -Y $Y}
                if($lines[$X-1][$Y+1] -in $numberStringArray){Scan-GridChar $lines -X ($X-1) -Y ($Y+1)}

            }

            if($lines[$X][$Y-1]   -in $numberStringArray){Scan-GridChar $lines -X $X -Y ($Y-1)}
            if($lines[$X][$Y+1]   -in $numberStringArray){Scan-GridChar $lines -X $X -Y ($Y+1)}
            
            if($X -ne $lines.Count-1){

                if($lines[$X+1][$Y-1] -in $numberStringArray){Scan-GridChar $lines -X ($X+1) -Y ($Y-1)}
                if($lines[$X+1][$Y]   -in $numberStringArray){Scan-GridChar $lines -X ($X+1) -Y $Y}
                if($lines[$X+1][$Y+1] -in $numberStringArray){Scan-GridChar $lines -X ($X+1) -Y ($Y+1)}

            }

        }

    }

}

$unique = $result | select Number, Coordinates -Unique

$sum = 0
$unique | % {$sum += $_.Number}
$sum