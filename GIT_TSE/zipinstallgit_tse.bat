REM
REM compile all .s and .si files to .mac
REM
sc32 *.s
sc32 *.si
REM
REM ===
REM
REM refresh the zip file
REM
del git_tse_knud.zip
REM
REM ===
REM
REM zipping all these files
REM
pkzipc -add -dir git_tse_knud.zip *.*
REM
REM view the result in the zip file
REM
zipview git_tse_knud.zip
REM
REM after running the installation batch file, load this file in your TSE and run it
REM
echo now run in TSE
REM
echo savefigs.s
echo (or run savefigs.mac)
REM
