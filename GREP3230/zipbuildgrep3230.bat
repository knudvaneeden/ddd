REM
REM compile all .s and .si files to .mac
REM
sc32 compat.si
sc32 gethelp.si
sc32 helphelp.s
REM
REM ===
REM
REM zipping all these files
REM
REM ===
REM
REM refresh the zip file
REM
del zipgethelp.zip
REM
REM files
REM
pkzipc -add zipgethelp.zip compat.si
pkzipc -add zipgethelp.zip compat.mac
REM
pkzipc -add zipgethelp.zip gethelp.dat
pkzipc -add zipgethelp.zip gethelp.exe
pkzipc -add zipgethelp.zip gethelp.hlp
pkzipc -add zipgethelp.zip gethelp.k32
REM
pkzipc -add zipgethelp.zip gethelp.si
pkzipc -add zipgethelp.zip gethelp.mac
REM
pkzipc -add zipgethelp.zip gethelp.txt
pkzipc -add zipgethelp.zip guiinc.inc
pkzipc -add zipgethelp.zip help26.hlp
pkzipc -add zipgethelp.zip help28.hlp
pkzipc -add zipgethelp.zip help30.hlp
REM
pkzipc -add zipgethelp.zip helphelp.s
pkzipc -add zipgethelp.zip helphelp.mac
REM
pkzipc -add zipgethelp.zip setwiyde.s
pkzipc -add zipgethelp.zip setwiyde.mac
REM
REM installation batch file to run first
REM
pkzipc -add zipgethelp.zip zipinstallgethelp.bat
REM
REM view the result in the zip file
REM
zipview zipgethelp.zip
REM
REM after running the installation batch file, load this file in your TSE and run it
REM
echo now run in TSE
REM
echo gethelp.si
echo (or run gethelp.mac)
REM
