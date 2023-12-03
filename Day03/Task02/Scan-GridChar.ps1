function Scan-GridChar {
    
    param (
        $Array,
        $X,
        $Y
    )
    
    $numberStringArray = "1", "2", "3", "4", "5", "6", "7", "8", "9", "0"

    if($Array[$X][$Y] -notin $numberStringArray){exit}

    $start = $Y
    if($Array[$X][$Y-1] -in $numberStringArray){
        
        $start = $Y-1
        if($Array[$X][$Y-2] -in $numberStringArray){$start = $Y-2}

    }

    $end = $Y
    if($Array[$X][$Y+1] -in $numberStringArray){
        
        $end = $Y+1
        if($Array[$X][$Y+2] -in $numberStringArray){$end = $Y+2}

    }

    $number += $Array[$X][$start..$end] -join ""
    $start..$end | % {$coordinates += "$x" + "$_"}

    $obj = [PSCustomObject]@{

        Number = $number
        Coordinates = $coordinates

    }

    $obj

}