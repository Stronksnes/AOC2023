Describe 'Get-Calibration' {

    It 'Test known output'{Get-Calibration -DocString "two1nine"                    | Should Be 29}
    It 'Test known output'{Get-Calibration -DocString "eightwothree"                | Should Be 83}
    It 'Test known output'{Get-Calibration -DocString "abcone2threexyz"             | Should Be 13}
    It 'Test known output'{Get-Calibration -DocString "xtwone3four"                 | Should Be 24}
    It 'Test known output'{Get-Calibration -DocString "4nineeightseven2"            | Should Be 42}
    It 'Test known output'{Get-Calibration -DocString "zoneight234"                 | Should Be 14}
    It 'Test known output'{Get-Calibration -DocString "7pqrstsixteen"               | Should Be 76}
    It 'Test known output'{Get-Calibration -DocString "5qcmjsfk6zxjld1"             | Should Be 51}
    It 'Test known output'{Get-Calibration -DocString "stsninecqxpfmdhk41vlpq"      | Should Be 91}
    It 'Test known output'{Get-Calibration -DocString "flghzhfgmn9tckbpmkgsix9"     | Should Be 99}
    It 'Test known output'{Get-Calibration -DocString "15six44qndpslhnine8twonehkb" | Should Be 11}
    It 'Test known output'{Get-Calibration -DocString "912"                         | Should Be 92}
    It 'Test known output'{Get-Calibration -DocString "3blcn"                       | Should Be 33}
    It 'Test known output'{Get-Calibration -DocString "two"                         | Should Be 22}
    It 'Test known output'{Get-Calibration -DocString "zfivejfgfgdhfrhr6"           | Should Be 56}

}