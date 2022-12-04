TSE grep.s has been extended to do the search instead
of using the default

TSE Semware grep.exe (located in your <TSE> installation directory)
to optionally and alternatively also do the grep using
GNU grep
Pcre2grep grep
Embarcadero BCC version 1.02 grep
Embarcadero BCC version 55 grep
Cygwin grep
MingW grep
Julia grep
Octave grep

1. To download goto
https://github.com/knudvaneeden/ddd/blob/TRUNK/GREPSEMWARE/grepsemware_knud.zip
and click on the 3 dots '...' at the bottom right and select 'Download'.

2. To install unzip the file grepsemware_knud.zip in any arbitrary directory.

3. Then run the file 'zipinstallgrepsemware.bat'

4. That will re-compile the .s and .si files in that directory.

5. Make sure that sc32.exe is in your PATH, otherwise edit that .bat file and replace 'sc32' with the full path to your sc32.exe (located in your TSE installation directory), then save the file and run it again.

6. That creates thus a new grepsemware_knud.zip file.

7. Take that file and unzip it again in any arbitrary other directory).

8. Then run this TSE macro in that directory

grepsemware.mac

9. Advised is in general to save your work in TSE first.

10. This program is with regard to TSE fully stand alone thus. It can be run anywhere basically. So no dependence on LoadDir() directories, TSE mac directory, ... Because all information should be stored in one and the same directory. It does also not use tse.ini but a stand alone .ini in this directory.

11. You should backup and open the file grepsemware.ini in which you will find the different grep information in the format:

[grepsemware]
// format: comma separated list with: name of grep, TSE macro name which handles the grep output, the parameters to always add the line number + always add the filename in front, the executable filename

E.g. in each line a different grep implementation:

grep01S=tse, grepsemwaretse, , f:\wordproc\tse32_v44200\grep.exe
grep02S=gnu, grepsemwaregnu, -n -H, g:\search\regularexpression\gnu\bin\grep.exe
grep03S=pcre2grep, grepsemwarepcre2grep, -n -H, g:\search\regularexpression\pcregrep\pcre2grep.exe
grep04S=embarcaderobcc55, grepsemwareembarcaderobcc55, -n+ -o+, g:\borland\bcc55\bin\grep.exe
grep05S=embarcaderobcc102, grepsemwareembarcaderobcc102, -n+ -o+, g:\borland\bcc102\bin\grep.exe
grep06S=cygwin, grepsemwarecygwin, -n -H, g:\cygwin\bin\grep.exe
grep07S=mingw, grepsemwaremingw, -n -H, g:\language\computer\cpp\mingw\msys\1.0\bin\grep.exe
grep08S=julia, grepsemwarejulia, -n -H, g:\language\computer\julia\git\bin\grep.exe
grep09S=octave, grepsemwareoctave, -n -H, g:\language\computer\octave\octave-4.2.0-w64\bin\grep.exe

you should change the file path on your system to match that of the installation of your grep (e.g. GNU, pcre2grep, ...), backup and save the file.
---

The method used to run these different grep versions is to

a. force those different grep versions to always include line numbers in each found line

b. force those different grep versions to always include the filename in front of each line

Typical parameters for that are '-n -H' in the Unix like grep implementations.
Note that Semware TSE grep also uses this method, as it always concatenates '-n' to the search options which always includes thus line numbers. But TSE grep.s does not use the -f parameter to add also the filename in front of each line. In this version you can also use -f as parameter.

So for each grep version you convert from this format to the TSE Semware grep.s default format:

--- cut here: begin --------------------------------------------------
c:\temp\foobar1.txt:1       a
c:\temp\foobar1.txt:2       a
c:\temp\foobar1.txt:3       a
c:\temp\foobar1.txt:4       a
c:\temp\foobar2.txt:1       a
c:\temp\foobar2.txt:2       a
c:\temp\foobar2.txt:3       a
c:\temp\foobar2.txt:4       a
--- cut here: end ----------------------------------------------------
 */
 //
 // Output:
 //
 /*
--- cut here: begin --------------------------------------------------
c:\temp\foobar1.txt
1: a
2: a
3: a
4: a
c:\temp\foobar2.txt
1: a
2: a
3: a
4: a
--- cut here: end ----------------------------------------------------


Note further that you yourself will have to choose the correct search option parameters for each of the grep.

type e.g.
grep.exe --help
or grep.exe ?
to see options.

To recursively search directories you use for most implementations e.g.
--directories=recurse
(in TSE Semware grep this has to be '-s' for example)

with friendly greetings
Knud van Eeden
