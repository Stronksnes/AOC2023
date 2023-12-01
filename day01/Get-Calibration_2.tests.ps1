Describe 'Get-Calibration' {

    It 'Test known output'{Get-Calibration -DocString "1abc2"       | Should Be 12}
    It 'Test known output'{Get-Calibration -DocString "pqr3stu8vwx" | Should Be 38}
    It 'Test known output'{Get-Calibration -DocString "a1b2c3d4e5f" | Should Be 15}
    It 'Test known output'{Get-Calibration -DocString "treb7uchet"  | Should Be 77}

}