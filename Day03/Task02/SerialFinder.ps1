$lines = Get-Content .\input.txt

$numberStringArray = "1", "2", "3", "4", "5", "6", "7", "8", "9", "0"

$total = for ($X = 0; $X -lt $lines.Count; $X++) {
    
    for ($Y = 0; $Y -lt $lines[$X].Length; $Y++) {

        if($lines[$X][$Y] -eq '*'){
            
            $result = new-object System.Collections.Generic.List[PSObject]

            if($X -ne 0){

                if($lines[$X-1][$Y-1] -in $numberStringArray){$result.add((Scan-GridChar $lines -X ($X-1) -Y ($Y-1)))}
                if($lines[$X-1][$Y]   -in $numberStringArray){$result.add((Scan-GridChar $lines -X ($X-1) -Y $Y))}
                if($lines[$X-1][$Y+1] -in $numberStringArray){$result.add((Scan-GridChar $lines -X ($X-1) -Y ($Y+1)))}

            }

            if($lines[$X][$Y-1]   -in $numberStringArray){$result.add((Scan-GridChar $lines -X $X -Y ($Y-1)))}
            if($lines[$X][$Y+1]   -in $numberStringArray){$result.add((Scan-GridChar $lines -X $X -Y ($Y+1)))}
            
            if($X -ne $lines.Count-1){

                if($lines[$X+1][$Y-1] -in $numberStringArray){$result.add((Scan-GridChar $lines -X ($X+1) -Y ($Y-1)))}
                if($lines[$X+1][$Y]   -in $numberStringArray){$result.add((Scan-GridChar $lines -X ($X+1) -Y $Y))}
                if($lines[$X+1][$Y+1] -in $numberStringArray){$result.add((Scan-GridChar $lines -X ($X+1) -Y ($Y+1)))}

            }

            [array]$numbers = ($result | select Number, Coordinates -Unique).Number
            
            if($numbers.Length -eq 2){
                
                $multi = [int]$numbers[0] * [int]$numbers[1] 
                Write-Host "Adding numbers: " $numbers[0] "x" $numbers[1]
                $multi

            }

        }
 
    }

}

$sum = 0
$total | % {$sum += $_}
$sum