function Determine-HandType {

    param (
        [array]$hand
    )
    
    ###1 = AAAAA; 2 = AAAAX; 3 = AAABB; 4 = AAAXX; 5 = AABBX; 6 = AAXXX; 7 = ABCDE

    $groups = ($hand | Group-Object | select -ExpandProperty count | sort -Descending) -join ""

    switch($groups){

        5       {$handType = 1}
        41      {$handType = 2}
        32      {$handType = 3}
        311     {$handType = 4}
        221     {$handType = 5}
        2111    {$handType = 6}
        11111   {$handType = 7}
            
        ###Dumbass example; Wasted so much time on this
            #$sorted = ($Hand | sort -Descending)
            #if($sorted[0] -eq ($sorted[0]-4)){$handType = 7}
            #else{$handType = $null}
        
    }

    Return $handType

}

function Transform-Hand {
    param (
        $Hand
    )
    
    $Hand = $hand.ToCharArray()
    $dict = [ordered]@{'A' = 14; 'K' = 13; 'Q' = 12; 'J' = 11; 'T' = 10; '9' = 9; '8' = 8; '7' = 7; '6' = 6; '5' = 5; '4' = 4; '3' = 3; '2' = 2; '1' = 1}
    $tHand = @()

    foreach($card in $Hand){ $tHand += ($dict."$card") }

    $outHand = [PSCustomObject]@{
        Hand = $tHand
        Type = (Determine-HandType -hand $tHand)
    }

    return $outHand

}

$lines = Get-Content .\input.txt

$allHands = New-Object System.Collections.Generic.List[PSObject]

foreach ($line in $lines) {

    $hand, $bet = $line -split " "
    $handFunc = Transform-Hand -Hand $hand
    
    $outHand = [PSCustomObject]@{
        Hand =      $handFunc.Hand
        Type =      $handFunc.Type
        Bet =       [int]$bet

    }

    $allHands.add($outHand)

}

$allHands | % {
    $_.hand = $_.hand | % {
        if($_ -lt 10){"0$_"}
        else{$_}
    }
}

$groupTypes = $allHands | where {$_.Type -ne $null} | Group-Object Type | sort name -Descending

$ordered = @()

foreach($groupType in $groupTypes){

    $handGroups = $groupType.Group
    $ordered += $handGroups | Sort-Object @{E={$_.hand[0..4]}}

}

$sum = $null

for ($i = 0; $i -lt $ordered.Count; $i++) {
    
    $sum = $sum + ($ordered[$i].Bet * ($i+1))
 
}

$sum