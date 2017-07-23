file_name = programs_list
file_extension = txt
file_path = %A_ScriptDir%\%file_name%.%file_extension%
configuration_file_path = %A_ScriptDir%\programs_list_conf.ini


IniRead, second_delay, %configuration_file_path%, Configuration, delay_between_programs
fileread, file, %file_path%

Sleep 1000
MsgBox, 4, ,Opening these programs:`r`n(Type "exit1" to quit)`r`n`r`n%file%,5

IfMsgBox, No
ExitApp

IfMsgBox, Timeout
ExitApp

Loop, read, %file_path%
{
Loop, parse, A_LoopReadLine, %A_Tab%
{
counter += %A_Index%
}
}
part := 100 / counter
part2 := part
Loop, read, %file_path%
{
Loop, parse, A_LoopReadLine, %A_Tab%
{
Progress, b FM11 fs10 CBGreen CWGray CTBlack w500, %A_LoopField% %A_Space%, Opening..., Opening, Verdana
Try
{
Run, %A_LoopField%
}
catch e
{
Progress, Off
Progress, b FM11 fs10 CBRed CWGray CTBlack w500, Invalid path or filename`r`n`r`n%A_LoopField%, Cannot Open, Opening, Verdana
Progress, %part%
WinMove, Opening, , 0, 0
MsgBox, 262160, ,Error:`r`nCannot continue because of invalid path or filename at:`r`n`r`n%A_LoopField%`r`n`r`nSolution:`r`nCorrect or remove the invalid path/filename in your configuration file "programs_list.txt"
Progress, Off
Run, %file_path%
WinActivate, A
Sleep 200
Send ^f
SendInput %A_LoopField%
Send {Enter}
Sleep 100
Send {Escape}
ExitApp
}
Progress, %part%
}
part += %part2%
Sleep %second_delay%
}
Progress, Off
ExitApp
return
:*:exit1::
ExitApp
return
