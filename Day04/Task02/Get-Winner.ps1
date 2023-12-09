$lines = Get-Content .\testinput.txt
$lines = $lines | % {Transform-Cards -Cardline $_}

Get-Winners -Cardlines $lines

$lines | ft