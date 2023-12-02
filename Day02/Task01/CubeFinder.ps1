$lines = (get-Content .\input.txt)

$threshold = @{

    Red = 12
    Green = 13
    Blue = 14

}

$sum = 0

foreach($line in $lines){

    $gamenr = [int]($line.Split(":")[0].Split(" ")[-1])
    $games = $line.Split(":")[1].split(";")

    foreach($game in $games){

        $game = $game.Split(",")
        
        $red = 0
        $green = 0
        $blue = 0
        $possible = $true

        foreach($color in $game){

            $eColor = $color.split(" ")[2]
            $eCount = $color.split(" ")[1]    

            $expression = '${0}+={1}' -f $eColor, $eCount
            Invoke-Expression -Command $expression

        }

        if($Red -gt $threshold.Red){$possible = $false; Break}
        elseif($Green -gt $threshold.Green){$possible = $false; Break}
        elseif($Blue -gt $threshold.Blue){$possible = $false; Break}

    }

    if($possible){$sum += $gamenr}
    write-host "# - "  $gamenr  "| Possible: " $possible "| Total: " $sum

}