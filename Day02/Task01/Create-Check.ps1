function Create-Check {
    param (
        $GameLine
    )
    
    $test = $GameLine.Split(":")[1].split(",").Split(";")

    $red = 0
    $green = 0
    $blue = 0

    foreach($t in $test){

        $color = $t.split(" ")[2]
        $count = $t.split(" ")[1]    

        $expression = '${0}+={1}' -f $color, $count
        Invoke-Expression -Command $expression

    }

    $outObj = [PSCustomObject]@{
        GameNumber = [int]($GameLine.Split(":")[0].Split(" ")[-1])
        Red = $red
        Green = $green
        Blue = $blue
    }

    $outObj

}