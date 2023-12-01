function Get-Calibration {

    param (

        [string]$DocString

    )
    
    $charArray = $DocString.ToCharArray()

    ForEach($char in $charArray){

        if ($char -in ("1", "2", "3", "4", "5", "6", "7", "8", "9")){
            
            if (!$firstInt){$firstInt = $char}
            else {$lastInt = $char}
        
        }

    }

    if(!$lastInt){$calibrationInt = $firstInt + $firstInt}
    else{$calibrationInt = $firstInt + $lastInt}

    [int]$calibrationInt

}