function Get-Winners {
    param (
        $Cardlines
    )
    
    for ($i = 0; $i -lt $Cardlines.Count; $i++) {
        $Cardlines[$i].CardCount += 1

        $winningNumbers = $null
        [array]$winningNumbers = $Cardlines[$i].Numbers | where {$_ -in $Cardlines[$i].Winners}

        if($winningNumbers){
            for ($j = 1; $j -le $winningNumbers.Length; $j++) {
                if (($i + $j) -lt $Cardlines.Count) {
                    $Cardlines[$i + $j].CardCount += 1
                }
            }
            Get-Winners -Cardlines $Cardlines[($i+1)..($Cardlines.Count - 1)]
        }
    }
}

$lines = Get-Content .\testinput.txt
$lines = $lines | % {Transform-Cards -Cardline $_}

Get-Winners -Cardlines $lines

$lines
