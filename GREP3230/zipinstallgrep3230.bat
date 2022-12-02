REM
REM compile all .s and .si files to .mac
REM
sc32 dialog.si
sc32 dialogp.s
sc32 gethelp.si
sc32 grep3230.s
sc32 grepdlg.si
sc32 scpaint.si
REM
REM ===
REM
REM refresh the zip file
REM
del zipgrep3230.zip
REM
REM ===
REM
REM zipping all these files
REM
REM ===
REM
pkzipc -add zipgrep3230.zip dialog.si
pkzipc -add zipgrep3230.zip dialog.mac
REM
pkzipc -add zipgrep3230.zip dialogp.s
pkzipc -add zipgrep3230.zip dialogp.mac
REM
pkzipc -add zipgrep3230.zip gethelp.si
pkzipc -add zipgrep3230.zip gethelp.mac
REM
pkzipc -add zipgrep3230.zip grep.hlp
REM
pkzipc -add zipgrep3230.zip grep3230.s
pkzipc -add zipgrep3230.zip grep3230.mac
REM
pkzipc -add zipgrep3230.zip grep.txt
REM
pkzipc -add zipgrep3230.zip grepdlg.d
pkzipc -add zipgrep3230.zip grepdlg.dlg
pkzipc -add zipgrep3230.zip grepdlg.si
REM
pkzipc -add zipgrep3230.zip guiinc.inc
REM
pkzipc -add zipgrep3230.zip helphelp.s
pkzipc -add zipgrep3230.zip helphelp.mac
REM
pkzipc -add zipgrep3230.zip scpaint.si
REM
pkzipc -add zipgrep3230.zip zipgrep3230.bat
REM
REM view the result in the zip file
REM
zipview zipgrep3230.zip
REM
REM after running the installation batch file, load this file in your TSE and run it
REM
md grep
pkzipc -extract -dir zipgrep3230.zip grep
REM
echo now run in TSE
echo execute this macro
echo grep\grep.s
echo (or run grep\grep.mac)
REM


