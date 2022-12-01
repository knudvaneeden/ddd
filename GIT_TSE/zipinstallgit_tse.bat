REM
REM compile all .s and .si files to .mac
REM
sc32 git_tse.s
sc32 savefisp.s
sc32 savefisi.s
sc32 savefigs.s
sc32 setwiyde.s
REM
REM ===
REM
REM zipping all this information
REM
REM ===
REM
REM refresh the zip file
REM
del zipgit_tse.zip
REM
REM ===
REM
REM zipping all these files
REM
REM ===
REM
REM composite commands
REM
pkzipc -add zipgit_tse.zip git_tse.s
pkzipc -add zipgit_tse.zip git_tse.mac
REM
REM single commands
REM
pkzipc -add zipgit_tse.zip savefisp.s
pkzipc -add zipgit_tse.zip savefisp.mac
REM
REM initialize strings
REM
pkzipc -add zipgit_tse.zip savefisi.s
pkzipc -add zipgit_tse.zip savefisi.mac
REM
REM menu
REM
pkzipc -add zipgit_tse.zip savefigs.s
pkzipc -add zipgit_tse.zip savefigs.mac
REM
REM add to your tse.ini file
pkzipc -add zipgit_tse.zip addtotseini.txt
REM
REM position popup windows on the screen
REM
pkzipc -add zipgit_tse.zip setwiyde.s
pkzipc -add zipgit_tse.zip setwiyde.mac
REM
REM to be added at the end of tse.ini
REM
pkzipc -add zipgit_tse.zip addthistoyourtseinifile_git_tse.txt
REM
REM installation batch file to run first
REM
pkzipc -add zipgit_tse.zip zipinstallgit_tse.bat
REM
REM view the result in the zip file
REM
zipview zipgit_tse.zip
REM
REM after running the installation batch file, load this file in your TSE and run it
REM
echo now run in TSE
REM
echo savefigs.s
echo (or run savefigs.mac)
REM
