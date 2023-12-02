function Calculate-Possible {
    
    param (

        $Rules,
        [Int]$Red,
        [Int]$Green,
        [Int]$Blue
        
    )
    
    $output = $true

    if($Red -gt $rules.Red){$output = $false}
    elseif($Green -gt $rules.Green){$output = $false}
    elseif($Blue -gt $rules.Blue){$output = $false}
    
    $output

}

