@echo off
rem TCDSCAN.BAT 05/21/1993 05/22/1993
if .%1. == .. goto Help
if exist c:\tcd.dir del c:\tcd.dir
:Again
if .%1. == .. goto Alldone
 echo Scanning %1
 echo %1\>>c:\tcd.dir
 dir %1\ /s /b /ad /on >>c:\tcd.dir
 rem subdir, barebones, directories only and sort on name
 shift
 goto Again
:Help
cls
echo 旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
echo ? Usage: TCDSCAN d: [[d:] ...]         ?
echo ?                                      ?
echo ? Example: TCDSCAN c: d:               ?
echo 읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
pause
:Alldone
