@echo off
rem TCD.BAT 05/21/1993 05/26/1993
if .%1. == .. goto Help
echo %1>%MACPATH%tcd.tmp
%MACPATH%e.exe c:\tcd.dir -etcd
del %MACPATH%tcd.tmp
goto Alldone
:Help
cls
echo 旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴?
echo ? Usage: TCD {directory}                  ?
echo ?                                         ?
echo ? Note: DOS wildcard characters (* and ?) ?
echo ?       and TSE Regular Expressions are   ?
echo ?       supported                         ?
echo ?                                         ?
echo ? Example: TCD *r?m*  ; finds c:\procomm  ?
echo ?          TCD e:*tse ; finds e:\tse      ?
echo 읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴?
pause
goto TheEnd
:Alldone
rem NOW, Execute a command
if .%2. == .. goto TheEnd
%2 %3 %4 %5 %6 %7 %8 %9
:TheEnd
