$lines = (get-Content .\input.txt)

$sum = 0

foreach($line in $lines){

    $gamenr = [int]($line.Split(":")[0].Split(" ")[-1])
    $colors = $line.Split(":")[1].split(";").split(",")

        $red = 0
        $green = 0
        $blue = 0

        foreach($color in $colors){

            $eColor = $color.split(" ")[2]
            [int]$eCount = $color.split(" ")[1]    

            if((Invoke-Expression ('${0}' -f $eColor)) -eq 0){

                $expression = '${0}={1}' -f $eColor, $eCount
                Invoke-Expression -Command $expression

            }

            elseif($eCount -gt (Invoke-Expression ('${0}' -f $eColor))){
            
                $expression = '${0}={1}' -f $eColor, $eCount
                Invoke-Expression -Command $expression
            
            }

        }

    $multi = $null        
    $multi = $red * $green * $blue
    $sum += $multi

    write-host "# - "  $gamenr "Red:"$red "x Green:"$green "x Blue:"$blue "=$multi"   " | Total: " $sum

}