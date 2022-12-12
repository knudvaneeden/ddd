@REM 1. You have to replace the path to your TSE sc32.exe to that on your system
@REM
@REM 2. Then put this .bat file in the root directory of your unzipped download file and run it
@REM
@REM 3. It will then automatically recompile all .s and .si in all the TSE macros
@REM
for /R %%f in (*.s) DO f:\wordproc\tse32_v44200\sc32.exe %%f
@REM
for /R %%f in (*.si) DO f:\wordproc\tse32_v44200\sc32.exe %%f
