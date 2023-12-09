function Get-Winners {
    
    param (
        [array]$Cardlines
    )
    
    for ($i = 0; $i -lt $Cardlines.Count; $i++) {

        $Cardlines[$i].CardCount += 1

        $winningNumbers = $null
        [array]$winningNumbers = $Cardlines[$i].Numbers | where {$_ -in $Cardlines[$i].Winners}

        $obj = $null
        $obj = [PSCustomObject]@{

            CardNumber = $Cardlines[$i].cardNumber
            Winningcount = $winningNumbers.Length

        }

        if($winningNumbers){

            $Cardlines[$i].WinnersCount = $obj.Winningcount
            Get-Winners -Cardlines $Cardlines[($i+1)..($i + $obj.Winningcount)]

        }

    }

}