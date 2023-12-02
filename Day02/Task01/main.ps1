$ruleObj = [PSCustomObject]@{
    
    Red = 12
    Green = 13
    Blue = 14

}

$lines = (get-Content .\testinput.txt)
$sum = $null

Foreach($line in $lines){

    $lineCheck = Create-Check -GameLine $line

    $calc = @{

        Rules = $ruleObj
        Red = $lineCheck.Red
        Green = $lineCheck.Green
        Blue = $lineCheck.Blue

    }

    $result = Calculate-Possible $calc
    $result
    if($result){$Sum += [int]$lineCheck.GameNumber}

}

$Sum