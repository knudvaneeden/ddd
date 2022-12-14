@echo off
if "%1"== ""  goto :no2
if "%1"== "?" goto :help
if "%2"== ""  goto :help
set sstring=%1
set infile=%2
set options=%3
set ts_options=%4
set outfile=%5
set exclude=" .bak .$hp"
:no2

e -eTSGREP

rem cls
goto end

:help
echo 旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
echo ? Usage:                                                               ?
echo ?       TSGREP                                                         ?
echo ?       TSGREP searchstring infile                                     ?
echo ?       TSGREP searchstring infile [srch_opts [TSGREP_opts outfile]]   ?
echo 팠袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴孤
echo ? If no arguments given, TSGREP prompts for each one.                  ?
echo ? Searchstring may be any TSE searchstring.                            ?
echo ?      * Use -or- as the 'OR' indicator                                ?
echo ?      * Use -and- as the 'AND' indicator                              ?
echo ?      * Use \- instead of =                                           ?
echo ?      * Use _ instead of space                                        ?
echo ? Infile may be any valid filespec, wildcards included.                ?
echo ?      Files with '@' in the name are treated as list files.           ?
echo ?      Add + to the end of the filespec for recursive search.          ?
echo ?      List files may be nested to 3 levels; possibly more will work.  ?
echo ?      Use ^ as a separator for multiple filespecs.                    ?
echo ? Srch_opts may be any TSE search options except b, c, l.              ?
echo ?      * Default options = 'i                                          ?
echo ? TSGREP_opts control TSGREP operation. See TSGREP.DOC for information.?
echo ?      * Use # in options for suppress line numbers                    ?
echo ?      * Use 1 in options to stop searching each file after 1 match    ?
echo ? Outfile is optional; default is TSGREP.TMP                           ?
echo 읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
:end
die!
set sstring=
set infile=
set outfile=
set options=
set ts_options=
set exclude=
