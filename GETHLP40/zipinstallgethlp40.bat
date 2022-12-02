REM
REM compile all .s and .si files to .mac
REM
sc32 *.s
sc32 *.si
REM
REM ===
REM
REM zipping all these files
REM
REM ===
REM
REM refresh the zip file
REM
del gethlp40_knud.zip
REM
REM add all files
REM
pkzipc -add -dir gethlp40_knud.zip *.*
REM
zipview gethlp40_knud.zip
REM
REM after running the installation batch file, load this file in your TSE and run it
REM
echo now run in TSE
REM
echo gethelp.si
echo (or compile and run gethelp.mac)
