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
del grepsemware_knud.zip
REM
REM ===
REM
REM zipping all these files
REM
pkzipc -add -dir grepsemware_knud.zip *.*
REM
REM view the result in the zip file
REM
echo zipview grepsemware_knud.zip
REM
echo To install
echo 1. -Store all the files in this directory in some temporary directory
echo 2. -Change directory to that temporary directory
echo 3. -Then run this batch file
echo 4. -That will recompile all or only the relevant .s and .si files and collect the necessary other files
echo 5. -Then the resulting .zip file contains all the necessary files to run it on your computer
echo 6. -Then unzip that resulting .zip file in some new arbitrary directory
echo 7. -Then run in TSE
echo 8. -execute this macro (you must supply the full path to this macro)
echo grepsemware.mac
