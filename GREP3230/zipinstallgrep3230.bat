REM
REM compile all relevant .s and .si files to .mac (do not compile all)
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
del grep3230_knud.zip
REM
REM ===
REM
REM zipping all these files
REM
REM ===
REM
pkzipc -add grep3230_knud.zip dialog.si
pkzipc -add grep3230_knud.zip dialog.mac
REM
pkzipc -add grep3230_knud.zip dialogp.s
pkzipc -add grep3230_knud.zip dialogp.mac
REM
pkzipc -add grep3230_knud.zip gethelp.si
pkzipc -add grep3230_knud.zip gethelp.mac
REM
pkzipc -add grep3230_knud.zip grep.hlp
REM
pkzipc -add grep3230_knud.zip grep.s
pkzipc -add grep3230_knud.zip grep.mac
REM
pkzipc -add grep3230_knud.zip grep.txt
REM
pkzipc -add grep3230_knud.zip grepdlg.d
pkzipc -add grep3230_knud.zip grepdlg.dlg
pkzipc -add grep3230_knud.zip grepdlg.si
REM
pkzipc -add grep3230_knud.zip guiinc.inc
REM
pkzipc -add grep3230_knud.zip helphelp.s
pkzipc -add grep3230_knud.zip helphelp.mac
REM
pkzipc -add grep3230_knud.zip scpaint.si
REM
pkzipc -add grep3230_knud.zip zipgrep3230.bat
REM
REM view the result in the zip file
REM
zipview grep3230_knud.zip
REM
REM after running the installation batch file, load this file in your TSE and run it
REM
md grep
pkzipc -extract -dir grep3230_knud.zip grep
REM
echo now run in TSE
echo execute this macro
echo grep\grep.s
echo (or run grep\grep.mac)
REM
