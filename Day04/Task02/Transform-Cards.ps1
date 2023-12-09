function Transform-Cards {

    param (
        $Cardline
    )

    $cardNumber = ($Cardline.split(":"))[0]
    $cardValues = ($Cardline.split(":"))[1]

    $winners = ($cardValues.split("|"))[0].split(" ") | where {$_ -ne ""}
    $numbers = ($cardValues.split("|"))[1].split(" ") | where {$_ -ne ""}

    [PSCustomObject]@{

        CardCount = 0
        CardNumber = $cardNumber
        WinnersCount = 0
        Winners = $winners
        Numbers = $numbers

    }

}