$lines = Get-Content .\input.txt

$totalScore = foreach($line in $lines){

    $score = 0

    $cardNumber = ($line.split(":"))[0]
    $cardValues = ($line.split(":"))[1]

        $winners = ($cardValues.split("|"))[0].split(" ") | where {$_ -ne ""}
        $numbers = ($cardValues.split("|"))[1].split(" ") | where {$_ -ne ""}

    [array]$winningNumbers = $numbers | where {$_ -in $winners}
    
    if($winningNumbers){

        $score = 1
        for ($i = 0; $i -lt ($winningNumbers.Count -1); $i++) {
            
            $score = $score * 2

        }

    }

    [PSCustomObject]@{

        CardNumber = $cardNumber
        WinningNumbers = $winningNumbers
        Score = $score

    }

}

$sum = 0
$totalScore | % {$sum += $_.Score}
$sum