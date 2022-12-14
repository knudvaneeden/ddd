FORWARD INTEGER PROC FNErrorCheckSB( STRING s1 )
FORWARD INTEGER PROC FNMacroCheckExecB( STRING s1 )
FORWARD INTEGER PROC FNMacroCheckLoadB( STRING s1 )
FORWARD INTEGER PROC FNMathCheckGetLogicFalseB()
FORWARD INTEGER PROC FNMathCheckGetLogicTrueB()
FORWARD INTEGER PROC FNMathCheckLogicNotB( INTEGER i1 )
FORWARD INTEGER PROC FNMathCheckLogicOrB( INTEGER i1, INTEGER i2 )
FORWARD INTEGER PROC FNStringCheckEmptyB( STRING s1 )
FORWARD INTEGER PROC FNStringCheckEnvironmentFoundNotB( STRING s1 )
FORWARD INTEGER PROC FNStringCheckEqualB( STRING s1, STRING s2 )
FORWARD INTEGER PROC FNStringCheckEqualCharacterLastNB( STRING s1, STRING s2 )
FORWARD INTEGER PROC FNStringCheckEqualErrorOrEmptyB( STRING s1 )
FORWARD INTEGER PROC FNStringGetLengthI( STRING s1 )
FORWARD PROC Main()
FORWARD PROC PROCFileRun4NtAliasCommandListUser( STRING s1 )
FORWARD PROC PROCFileUpdateVersionControlSubversionSaveCreateCurrent( STRING s1, STRING s2, STRING s3 )
FORWARD PROC PROCMacroExec( STRING s1 )
FORWARD PROC PROCMacroRunKeep( STRING s1 )
FORWARD PROC PROCWarn( STRING s1 )
FORWARD PROC PROCWarnCons3( STRING s1, STRING s2, STRING s3 )
FORWARD STRING PROC FNStringGetAsciiToCharacterS( INTEGER i1 )
FORWARD STRING PROC FNStringGetCarS( STRING s1 )
FORWARD STRING PROC FNStringGetCharacterEndBackSlashNotEqualInsertEndS( STRING s1 )
FORWARD STRING PROC FNStringGetCharacterInsertEndIfEqualNotS( STRING s1, STRING s2 )
FORWARD STRING PROC FNStringGetCharacterSymbolCentralS( INTEGER i1 )
FORWARD STRING PROC FNStringGetCharacterSymbolSlashBackwardS()
FORWARD STRING PROC FNStringGetCharacterSymbolSpaceS()
FORWARD STRING PROC FNStringGetConcatS( STRING s1, STRING s2 )
FORWARD STRING PROC FNStringGetConcatSeparatorS( STRING s1, STRING s2, STRING s3 )
FORWARD STRING PROC FNStringGetConcatTailS( STRING s1, STRING s2 )
FORWARD STRING PROC FNStringGetCons3S( STRING s1, STRING s2, STRING s3 )
FORWARD STRING PROC FNStringGetConsS( STRING s1, STRING s2 )
FORWARD STRING PROC FNStringGetDirectoryVersionControlRepositoryS()
FORWARD STRING PROC FNStringGetDirectoryVersionControlWorkingS()
FORWARD STRING PROC FNStringGetEmptyS()
FORWARD STRING PROC FNStringGetEnvironmentS( STRING s1 )
FORWARD STRING PROC FNStringGetErrorS()
FORWARD STRING PROC FNStringGetFileDirectorySubLastS( STRING s1, STRING s2 )
FORWARD STRING PROC FNStringGetFileGetFilenamePathDefaultS( STRING s1 )
FORWARD STRING PROC FNStringGetFileIniDefaultS( STRING s1 )
FORWARD STRING PROC FNStringGetFilenameEndBackSlashNotEqualInsertEndS( STRING s1 )
FORWARD STRING PROC FNStringGetFilenameIniDefaultS()
FORWARD STRING PROC FNStringGetInitializationGlobalS( STRING s1, STRING s2, STRING s3 )
FORWARD STRING PROC FNStringGetMidStringS( STRING s1, INTEGER i1, INTEGER i2 )
FORWARD STRING PROC FNStringGetPathFileAliasUnicode4Dos4NtFilenameS()
FORWARD STRING PROC FNStringGetPathUser_DataApplicationCurrentBackslashNotS()
FORWARD STRING PROC FNStringGetPathUser_DataApplicationCurrentBackslashS()
FORWARD STRING PROC FNStringGetProgram4ntFilenameS()
FORWARD STRING PROC FNStringGetRightStringLengthEqualS( STRING s1, STRING s2 )
FORWARD STRING PROC FNStringGetRightStringS( STRING s1, INTEGER i1 )
FORWARD STRING PROC FNStringGetSectionSeparatorS()
FORWARD STRING PROC FNStringGet_FilenameIniDefaultS()


// --- MAIN --- //

PROC Main()
 // STRING s1[255] = "C:\TEMP\W1\"
 STRING s1[255] = FNStringGetDirectoryVersionControlWorkingS()
 // STRING s2[255] = "C:\TEMP\R1\"
 STRING s2[255] = FNStringGetDirectoryVersionControlRepositoryS()
 // STRING s3[255] = "changes in this revision = draft|backup|works|created|add setm|replace menu hotkey|save|major|minor|recompile|compiles|refactor|original"
 STRING s3[255] = "draft|backup|works|created|add setm|replace menu hotkey|save|major|minor|recompile|compiles|refactor|original"
 STRING s4[255] = "C:\TEMP\the-semware-editor-tse-code\TRUNK\"
 //
 INTEGER bufferI = 0
 //
 PushPosition()
 bufferI = CreateTempBuffer()
 PopPosition()
 //
 PushPosition()
 PushBlock()
 GotoBufferId( bufferI )
 //
 AddLine( s1 )
 AddLine( s4 )
 //
 PROCMacroRunKeep( "setwiyde" ) // operation: set: window: warn/yesno: position: x: y: default // new
 GotoLine( 1 )
 IF List( "Choose an option", 80 )
  s1 = Trim( GetText( 1, 255 ) )
 ELSE
  AbandonFile( bufferI )
  RETURN()
 ENDIF
 AbandonFile( bufferI )
 PopBlock()
 PopPosition()
 //
 IF ( EquiStr( s1, s4 ) ) AND ( EquiStr( "BIBTSE", SplitPath( CurrFilename(), _NAME_ ) ) )
  PROCMacroRunKeep( "setwiyde" ) // operation: set: window: warn/yesno: position: x: y: default // new
  Warn( "Do not upload your file", ":", " " , CurrFilename(), " ", "to the online repository", ":", " ", s1 )
  RETURN()
 ENDIF
 //
 PROCMacroRunKeep( "setwiyde" ) // operation: set: window: warn/yesno: position: x: y: default // new
 IF ( NOT ( Ask( "file: save: version: control: subversion: revisionChangeInformationS = ", s3, _EDIT_HISTORY_ ) ) AND ( Length( s3 ) > 0 ) ) RETURN() ENDIF
// e.g   //
 PROCFileUpdateVersionControlSubversionSaveCreateCurrent( s1, s2, s3 )
 //
 // Warn( "File", " ", CurrFilename(), " ", "is now saved in your local working directory", " ", s1, " ", "and committed as a next revision to your repository", " ", s2 )
 //
 // Message( Format( CurrFilename(), " ", "saved in time", " ", s + "-" + GetTimeStr() ) )
 //
END

<F12> Main()

// --- LIBRARY --- //

// library: string: get: directory: version: control: working <description></description> <version>1.0.0.0.2</version> <version control></version control> (filenamemacro=getstcwo.s) [<Program>] [<Research>] [kn, am, mo, 11-10-2010 10:18:56]
STRING PROC FNStringGetDirectoryVersionControlWorkingS()
 // e.g. PROC Main()
 // e.g.  Message( FNStringGetDirectoryVersionControlWorkingS() ) // gives e.g. "P:\TEMP\MYWORKINGDIRECTORY\"
 // e.g. END
 // e.g.
 // e.g. <F12> Main()
 //
 RETURN( FNStringGetFileIniDefaultS( "FNStringGetDirectoryVersionControlWorkingS" ) )
 //
END

// library: string: get: directory: version: control: repository <description></description> <version>1.0.0.0.3</version> <version control></version control> (filenamemacro=getstcrg.s) [<Program>] [<Research>] [kn, am, mo, 11-10-2010 10:18:56]
STRING PROC FNStringGetDirectoryVersionControlRepositoryS()
 // e.g. PROC Main()
 // e.g.  Message( FNStringGetDirectoryVersionControlRepositoryS() ) // gives e.g. "P:\TEMP\MYREPOSITORYDIRECTORY\"
 // e.g. END
 // e.g.
 // e.g. <F12> Main()
 //
 RETURN( FNStringGetFileIniDefaultS( "FNStringGetDirectoryVersionControlRepositoryS" ) )
 //
END

// library: macro: run: keep <description>macro: run a macro, then keep it</description> <version>1.0.0.0.1</version> <version control></version control> (filenamemacro=runmarke.s) [<Program>] [<Research>] [[kn, zoe, fr, 27-10-2000 15:59:33]
PROC PROCMacroRunKeep( STRING macronameS )
 // e.g. PROC Main()
 // e.g.  PROCMacroRunKeep( "mysubma1.mac myparameter11 myparameter12" )
 // e.g.  PROCMacroRunKeep( "mysubma2.mac myparameter21" )
 // e.g.  PROCMacroRunKeep( "mysubma3.mac myparameter31 myparameter32" )
 // e.g. END
 //
 IF FNMacroCheckLoadB( FNStringGetCarS( macronameS ) ) // necessary if you pass parameters in a string
  //
  PROCMacroExec( macronameS )
  //
 ENDIF
 //
END

// library: file: update: version: control: subversion: save: create <description>CRUD</description> <version control></version control> <version>1.0.0.0.118</version> <version control></version control> (filenamemacro=updafisc.s) [<Program>] [<Research>] [kn, zoe, mo, 20-11-2000 14:31:57]
PROC PROCFileUpdateVersionControlSubversionSaveCreateCurrent( STRING fileVersionControlDirectoryWorkingInS, STRING fileVersionControlDirectoryRepositoryS, STRING revisionChangeInformationS )
 // e.g. PROC Main()
 // e.g.  // STRING s1[255] = "C:\TEMP\W1\"
 // e.g.  STRING s1[255] = FNStringGetDirectoryVersionControlWorkingS()
 // e.g.  // STRING s2[255] = "C:\TEMP\R1\"
 // e.g.  STRING s2[255] = FNStringGetDirectoryVersionControlRepositoryS()
 // e.g.  // STRING s3[255] = "changes in this revision = draft|backup|works|created|add setm|replace menu hotkey|save|major|minor|recompile|compiles|refactor|original"
 // e.g.  STRING s3[255] = "draft|backup|works|created|add setm|replace menu hotkey|save|major|minor|recompile|compiles|refactor|original"
 // e.g.  STRING s4[255] = "C:\TEMP\the-semware-editor-tse-code\TRUNK\"
 // e.g.  //
 // e.g.  INTEGER bufferI = 0
 // e.g.  //
 // e.g.  PushPosition()
 // e.g.  bufferI = CreateTempBuffer()
 // e.g.  PopPosition()
 // e.g.  //
 // e.g.  PushPosition()
 // e.g.  PushBlock()
 // e.g.  GotoBufferId( bufferI )
 // e.g.  //
 // e.g.  AddLine( s1 )
 // e.g.  AddLine( s4 )
 // e.g.  //
 // e.g.  PROCMacroRunKeep( "setwiyde" ) // operation: set: window: warn/yesno: position: x: y: default // new
 // e.g.  GotoLine( 1 )
 // e.g.  IF List( "Choose an option", 80 )
 // e.g.   s1 = Trim( GetText( 1, 255 ) )
 // e.g.  ELSE
 // e.g.   AbandonFile( bufferI )
 // e.g.   RETURN()
 // e.g.  ENDIF
 // e.g.  AbandonFile( bufferI )
 // e.g.  PopBlock()
 // e.g.  PopPosition()
 // e.g.  //
 // e.g.  IF ( EquiStr( s1, s4 ) ) AND ( EquiStr( "BIBTSE", SplitPath( CurrFilename(), _NAME_ ) ) )
 // e.g.   PROCMacroRunKeep( "setwiyde" ) // operation: set: window: warn/yesno: position: x: y: default // new
 // e.g.   Warn( "Do not upload your file", ":", " " , CurrFilename(), " ", "to the online repository", ":", " ", s1 )
 // e.g.   RETURN()
 // e.g.  ENDIF
 // e.g.  //
 // e.g.  PROCMacroRunKeep( "setwiyde" ) // operation: set: window: warn/yesno: position: x: y: default // new
 // e.g.  IF ( NOT ( Ask( "file: save: version: control: subversion: revisionChangeInformationS = ", s3, _EDIT_HISTORY_ ) ) AND ( Length( s3 ) > 0 ) ) RETURN() ENDIF
 // e.g   //
 // e.g.  PROCFileUpdateVersionControlSubversionSaveCreateCurrent( s1, s2, s3 )
 // e.g.  //
 // e.g.  // Warn( "File", " ", CurrFilename(), " ", "is now saved in your local working directory", " ", s1, " ", "and committed as a next revision to your repository", " ", s2 )
 // e.g.  //
 // e.g.  // Message( Format( CurrFilename(), " ", "saved in time", " ", s + "-" + GetTimeStr() ) )
 // e.g.  //
 // e.g. END
 // e.g.
 // e.g. <F12> Main()
 //
 INTEGER fileExistB = FALSE
 //
 STRING fileNameS[255] = ""
 //
 STRING driveS[255] = ""
 //
 STRING directoryS[255] = ""
 //
 STRING fileVersionControlDirectoryWorkingS[255] = ""
 //
 STRING s[255] = "commit"
 //
 STRING s1[255] = ""
 //
 STRING fileNameCurrentS[255] = CurrFilename()
 //
 s1 = Query( MacroCmdLine )
 s1 = Trim( s1 )
 IF EquiStr( s1, "" )
  fileVersionControlDirectoryWorkingS = fileVersionControlDirectoryWorkingInS
 ELSE
  fileVersionControlDirectoryWorkingS = s1
 ENDIF
 //
 fileNameS = Format( AddTrailingSlash( fileVersionControlDirectoryWorkingS ), SplitPath( fileNameCurrentS, _NAME_ | _EXT_ ) )
 //
 driveS = SplitPath( fileVersionControlDirectoryWorkingS, _DRIVE_ )
 //
 directoryS = SplitPath( fileVersionControlDirectoryWorkingS, _PATH_ )
 //
 IF ( NOT ( FileExists( Format( AddTrailingSlash( fileVersionControlDirectoryRepositoryS ), "*.*" ) ) ) )
  //
  // CopyToWinclip( 'c: && cd \TEMP\ && svnadmin create R1 && md T1 && svn import T1 file:///cygdrive/c/temp/R1 -m "This is a test"' )
  CopyToWinclip( Format( "c: && cd \TEMP\ && svnadmin create R1 && md T1 && svn import T1 file:///cygdrive/c/temp/R1 -m", " ", '"', revisionChangeInformationS, '"' ) )
  //
  // Warn( "Repository not found. Please check the URL or create a new repository.", " ", "Copied to Microsoft Windows clipboard:", " ", 'c: && cd \TEMP\ && svnadmin create R1 && md T1 && svn import T1 file:///cygdrive/c/temp/R1 -m "This is a test"' ) // old [kn, ri, su, 14-08-2022 12:08:00]
  Warn( "Repository not found. Please check the URL or create a new repository.", " ", "Copied to Microsoft Windows clipboard:", " ", "c: && cd \TEMP\ && svnadmin create R1 && md T1 && svn import T1 file:///cygdrive/c/temp/R1 -m", " ", '"', revisionChangeInformationS, '"' ) // new [kn, ri, su, 14-08-2022 12:08:04]
  //
  RETURN()
  //
 ENDIF
 //
 IF ( NOT ( FileExists( Format( AddTrailingSlash( fileVersionControlDirectoryWorkingS ), "*.*" ) ) ) )
  //
  CopyToWinclip( "c: && cd \TEMP\ && svn checkout file:///cygdrive/c/temp/R1 W1" )
  //
  Warn( "Working directory not found. Please check or create a new working directory. Copied to Microsoft Windows clipboard: 'c: && cd \TEMP\ && svn checkout file:///cygdrive/c/temp/R1 W1'" )
  //
  RETURN()
  //
 ENDIF
 //
 fileExistB = FileExists( fileNameS )
 //
 SaveAs( fileNameS, _OVERWRITE_ ) // saving the file in your Subversion 'working directory'
 //
 IF ( NOT ( fileExistB ) )
  //
  // PROCFileRun4NtAliasCommandListHideUser( Format( driveS, " ", "&&", " ", "cd", " ", directoryS, " ", "&&", " ", "svn add", " ", SplitPath( fileNameS, _NAME_ | _EXT_ ) ) )
  PROCFileRun4NtAliasCommandListUser( Format( driveS, " ", "&&", " ", "cd", " ", directoryS, " ", "&&", " ", "svn add", " ", SplitPath( fileNameS, _NAME_ | _EXT_ ), " ", "2>&1" ) )
  //
  s = Format( "add + ", s )
  //
 ENDIF
 //
 // PROCFileRun4NtAliasCommandListHideUser( Format( driveS, " ", "&&", " ", "cd", " ", directoryS, " ", "&&", " ", "cd ..", " ", "&&", " ", "svn commit", " ", FNStringGetFileDirectorySubLastS( directoryS, "\" ), " ", "-m", " ", '"This is a test"' ) )
 // PROCFileRun4NtAliasCommandListUser( Format( driveS, " ", "&&", " ", "cd", " ", directoryS, " ", "&&", " ", "cd ..", " ", "&&", " ", "svn commit", " ", FNStringGetFileDirectorySubLastS( directoryS, "\" ), " ", "-m", " ", '"This is a test"' ) ) // old [kn, ri, su, 14-08-2022 12:07:49]
 PROCFileRun4NtAliasCommandListUser( Format( driveS, " ", "&&", " ", "cd", " ", directoryS, " ", "&&", " ", "cd ..", " ", "&&", " ", "svn commit", " ", FNStringGetFileDirectorySubLastS( directoryS, "\" ), " ", "-m", " ", '"', revisionChangeInformationS, '"', " ", "2>&1" ) ) // new [kn, ri, su, 14-08-2022 12:07:52]
 //
 Message( s )
 //
END

// library: file: get: ini: default: central <description></description> <version control></version control> <version>1.0.0.0.6</version> (filenamemacro=getfiidf.s) [<Program>] [<Research>] [kn, ri, we, 31-12-2003 02:17:48]
STRING PROC FNStringGetFileIniDefaultS( STRING searchS )
 // e.g. PROC Main()
 // e.g.  Message( FNStringGetFileIniDefaultS( "path4dos" ) ) // gives e.g. "c:\4dos"
 // e.g. END
 // e.g.
 // e.g. <F12> Main()
 // e.g.
 //
 // USAGE
 //
 // 1. -Choose a filename for your global variables initialization file
 //
 //    1. -E.g. default name is here
 //
 //         dddpath.ini
 //
 //    2. -You can set this name in a function in this library, if you
 //
 //        want to change the default name
 //
 // 3. -Save this file in the directory
 //
 //     (path chosen to be given by Microsoft Windows environment variable APPDATA)
 //
 //      C:\Documents and Settings\<your Microsoft Windows login name>\Application Data\
 //
 // 4. -The full path to your initialization file is thus e.g.
 //
 //      C:\Documents and Settings\Administrator\Application Data\dddpath.ini
 //
 // 5. -To keep things as simple as possible, you need to put once
 //
 //     in top of your file the word (which must start at the beginning
 //
 //     of the line). Further no more '[' characters starting at the begin of any line.
 //
 //      [default]
 //
 // 6. -This file contains 0 or more lines of the general format
 //
 //      <variable name> = <variable value>
 //
 //     1. -E.g.
 //
 //         [default]
 //
 //          path4dos = c:\4dos
 //
 //          tsevariable1 = test1
 //
 //          tsevariable2 = test2
 //
 //          tsevariable3 = test3
 //
 //          ...
 //
 //     2. -Note: you should/could put spaces before and after the '=' sign
 //
 //         (e.g. for backwards compatibility purposes)
 //
 // 7. -Using this library, you can then e.g. get the value of your global variable from this file
 //
 STRING s[255] = ""
 //
 s =FNStringGetFileGetFilenamePathDefaultS( searchS )
 //
 IF EquiStr( Trim( s ), "" )
  PROCMacroRunKeep( "setwiyde" ) // operation: set: window: warn/yesno: position: x: y: default // new
  Warn( searchS, ":", " ", "Mot found (or found but the value is the empty string). Please check dddpath.ini and adapt file bibdelph.del" )
 ENDIF
 //
 RETURN( FNStringGetFileGetFilenamePathDefaultS( searchS ) )
 //
END

// library: macro: check: load <description>macro: load: (Loads a Macro File From Disk Into Memory) R    LoadMacro(STRING macro_filename)*</description> <version>1.0.0.0.1</version> <version control></version control> (filenamemacro=checmacl.s) [<Program>] [<Research>] [[kn, zoe, we, 16-06-1999 01:07:06]
INTEGER PROC FNMacroCheckLoadB( STRING macronameS )
 // e.g. PROC Main()
 // e.g.  Message( FNMacroCheckLoadB( macronameS ) ) // gives e.g. TRUE
 // e.g. END
 // e.g.
 // e.g. <F12> Main()
 //
 RETURN( LoadMacro( macronameS ) )
 //
END

// library: string: get: word: token: get: first: FNStringGetCarS(): Get the first word of a string (words delimited by a space " " (=space delimited list)). <description></description> <version control></version control> <version>1.0.0.0.1</version> (filenamemacro=getstgca.s) [<Program>] [<Research>] [kn, ni, su, 02-08-1998 15:54:17]
STRING PROC FNStringGetCarS( STRING s )
 // e.g. PROC Main()
 // e.g.  STRING s1[255] = FNStringGetInitializeNewStringS()
 // e.g.  s1 = FNStringGetInputS( "string: get: word: token: get: first: s = ", "this is a test" )
 // e.g.  IF FNKeyCheckPressEscapeB( s1 ) RETURN() ENDIF
 // e.g.  Message( FNStringGetCarS( s1 ) ) // gives e.g. "this"
 // e.g. END
 // e.g.
 // e.g. <F12> Main()
 //
 // variation: RETURN( FNStringGetTokenFirstS( s, " " ) )
 //
 RETURN( GetToken( s, " ", 1 ) ) // faster, but not central
 //
END

// library: macro: exec <description>macro: (Executes the Requested Macro) O    ExecMacro([<Program>] [<Research>] [STRING macroname])*</description> <version>1.0.0.0.1</version> <version control></version control> (filenamemacro=execmame.s) [[kn, zoe, we, 16-06-1999 01:06:54]
PROC PROCMacroExec( STRING macronameS )
 // e.g. PROC Main()
 // e.g.  PROCMacroExec( "video" )
 // e.g. END
 // e.g.
 // e.g. <F12> Main()
 //
 IF FNMathCheckLogicNotB( FNMacroCheckExecB( macronameS ) )
  //
  PROCWarnCons3( "macro", macronameS, ": could not be executed" )
  //
 ENDIF
 //
END

// library: file: run: 4: nt: alias: command: list: user <description></description> <version control></version control> <version>1.0.0.0.199</version> (filenamemacro=run4fira.s) [<Program>] [<Research>] [kn, ri, su, 01-03-2009 15:29:03]
PROC PROCFileRun4NtAliasCommandListUser( STRING s )
 // e.g. PROC Main()
 // e.g.  STRING s1[255] = FNStringGetInitializeNewStringS()
 // e.g.  INTEGER bufferI = 0
 // e.g.  INTEGER I = 0
 // e.g.  STRING fileNameS[255] = FNStringGetProgramAliasRunFilenameListS() // casealiasinputlist.txt
 // e.g.  PushPosition()
 // e.g.  bufferI = CreateTempBuffer()
 // e.g.  GotoBufferId( bufferI )
 // e.g.  InsertFile( fileNameS )
 // e.g.  // I = List( "alias command", 115 - 21 )
 // e.g.  I = List( "FILE: RUN: 4NT: ALIAS: COMMAND: LIST: USER", FNWindowGetScreenWidthI() )
 // e.g.  IF ( NOT ( I == 0 ) )
 // e.g.   s1 = SubStr( GetText( 1, 255 ), 1, 188 - 1 )
 // e.g.   s1 = Trim( s1 )
 // e.g.   // combobox (but switched off as this is quicker)
 // e.g.   // s1 = FNStringGetInputS( "file: run: 4nt: alias: s = ", s1 )
 // e.g.   IF FNKeyCheckPressEscapeB( s1 ) RETURN() ENDIF
 // e.g.   s1 = FNStringGetTagAngularRemoveWhileS( s1, "Please replace it by information to apply" )
 // e.g.   // do not move the runprmcn line, as it seems to work better [kn, vo, mo, 13-04-2015 19:57:52]
 // e.g.   PROCMacroRunPurgeParameter( "runprmcn", Format( FNStringGetMachineNameS(), ";", FNStringGetUserNameFirstS(), ";", FNStringGetUserNameLastS(), ";", FNStringGetPortS(), ";", "Run%3A+Alias%3A+" + s1 + "&submit01=Create" ) )
 // e.g.   PROCFileRun4NtAliasCommandListUser( s1 )
 // e.g.  ENDIF
 // e.g.  PopPosition()
 // e.g.  PushPosition()
 // e.g.  GotoBufferId( bufferI )
 // e.g.  AbandonFile( bufferI )
 // e.g.  PopPosition()
 // e.g. END
 // e.g.
 // e.g. <F12> Main()
 // e.g. <CTRL L> RepeatFind()
 //
 // PROCFileChangeEditProgramRunStringAdd( "run", "", Format( "(program: 4nt: alias: general:", " ", s, ")" ) )
 //
 // LDos( QuotePath( FNStringGetProgram4ntFilenameS() ), Format( "alias", " ", FNStringGetPathFileAlias4Dos4NtFilenameS(), " ", "&&", " ", s, " ", "&& exit && exit" ), _DONT_PROMPT_ )
 // LDos( FNStringGetProgram4ntFilenameS(), Format( "alias", " ", FNStringGetPathFileAlias4Dos4NtFilenameS(), " ", "&&", " ", s, " ", "&& exit && exit" ), _DONT_PROMPT_ )
 // LDos( FNStringGetProgram4ntFilenameS(), Format( "alias", " ", FNStringGetPathFileAlias4Dos4NtFilenameS(), " ", "&&", " ", s, " ", "&& exit" ), _DONT_PROMPT_ )
 // LDos( FNStringGetProgram4ntFilenameS(), Format( "alias", " ", "/L", " ", "&&", " ", "alias", " ", FNStringGetPathFileAlias4Dos4NtFilenameS(), " ", "&&", " ", s, " ", "&& exit" ), _DONT_PROMPT_ )
 // LDos( FNStringGetProgram4ntFilenameS(), Format( "alias", " ", FNStringGetPathFileAlias4Dos4NtFilenameS(), " ", "&&", " ", s, " ", "&& exit" ), _DONT_PROMPT_ ) // old [kn, ri, su, 25-12-2016 02:18:29]
 LDos( FNStringGetProgram4ntFilenameS(), Format( "alias", " ", FNStringGetPathFileAliasUnicode4Dos4NtFilenameS(), " ", "&&", " ", s, " ", "&& exit" ), _DONT_PROMPT_ ) // new [kn, ri, su, 25-12-2016 02:18:43]
 //
 // PROCListSaveHistoryUser( s ) // old [kn, ri, su, 10-06-2012 13:44:33]
 //
 Message( Format( s, " ", ": file: run: 4nt/4dos: alias: command: list: user" ) )
 //
 // do not enable this runprmcn line, as it is run in the run part of this macro [kn, vo, mo, 13-04-2015 19:57:46]
 // PROCMacroRunPurgeParameter( "runprmcn", Format( FNStringGetMachineNameS(), ";", FNStringGetUserNameFirstS(), ";", FNStringGetUserNameLastS(), ";", FNStringGetPortS(), ";", "Run%3A+Alias%3A+" + s + "&submit01=Create" ) )
 //
END

// library: string: get: file: directory: sub: last <description></description> <version control></version control> <version>1.0.0.0.9</version> (filenamemacro=getstdla.s) [<Program>] [<Research>] [kn, ri, su, 14-02-2010 02:05:36]
STRING PROC FNStringGetFileDirectorySubLastS( STRING directoryS, STRING separatorS )
 // e.g. PROC Main()
 // e.g.  Warn( FNStringGetFileDirectorySubLastS( "c:\temp\dddd\", "\" ) ) // gives e.g. "dddd"
 // e.g.  Warn( FNStringGetFileDirectorySubLastS( "z:\webmethods7\integrationserver\packages\Default\", "\" ) ) // gives e.g. "Default"
 // e.g.  Warn( FNStringGetFileDirectorySubLastS( "z:\webmethods7\integrationserver\packages\Default", "\" ) ) // gives e.g. "Default"
 // e.g. END
 // e.g.
 // e.g. <F12> Main()
 //
 STRING s[255] = directoryS
 //
 INTEGER I = 0
 //
 IF ( RightStr( s, 1 ) == separatorS )
  //
  s = LeftStr( s, Length( s ) - 1 )
  //
 ENDIF
 //
 I = StrFind( separatorS, s, "b" )
 //
 IF ( I > 0 )
  //
  s = RightStr( s, Length( s ) - I )
  //
 ENDIF
 //
 RETURN( s )
 //
END

// library: file: get: filename: path: default <description></description> <version control></version control> <version>1.0.0.0.1</version> (filenamemacro=getfipde.s) [<Program>] [<Research>] [kn, ri, we, 31-12-2003 02:14:28]
STRING PROC FNStringGetFileGetFilenamePathDefaultS( STRING searchS )
 // e.g. PROC Main()
 // e.g.  Message( FNStringGetFileGetFilenamePathDefaultS( "path4dos" ) ) // gives e.g. "c:\4dos"
 // e.g. END
 // e.g.
 // e.g. <F12> Main()
 //
 // RETURN( FNStringGetFileGetFilenamePathS( searchS, FNStringGetFilenameIniDefaultS() ) ) // [kn, ri, mo, 22-05-2006 23:59:52]
 //
 RETURN( FNStringGetInitializationGlobalS( searchS, FNStringGetSectionSeparatorS(), FNStringGetFilenameIniDefaultS() ) )
 //
END

// library: math: check: logic: not <description></description> <version control></version control> <version>1.0.0.0.2</version> (filenamemacro=checmaln.s) [<Program>] [<Research>] [kn, ri, tu, 15-05-2001 16:54:21]
INTEGER PROC FNMathCheckLogicNotB( INTEGER B )
 // e.g. PROC Main()
 // e.g.  STRING s[255] = FNStringGetInitializeNewStringS()
 // e.g.  s = FNStringGetInputS( "math: check: logic: not: number = ", "1" )
 // e.g.  IF FNKeyCheckPressEscapeB( s ) RETURN() ENDIF
 // e.g.  Message( FNMathCheckLogicNotB( FNStringGetToIntegerI( s ) ) )
 // e.g. END
 // e.g.
 // e.g. <F12> Main()
 //
 RETURN( NOT B )
 //
END

// library: macro: check: exec <description>macro: (Executes the Requested Macro) O    ExecMacro([<Program>] [<Research>] [STRING macroname])*</description> <version>1.0.0.0.1</version> <version control></version control> (filenamemacro=checmace.s) [[kn, zoe, we, 16-06-1999 01:06:54]
INTEGER PROC FNMacroCheckExecB( STRING macronameS )
 // e.g. PROC Main()
 // e.g.  Message( FNMacroCheckExecB( macronameS ) ) // gives e.g. TRUE
 // e.g. END
 // e.g.
 // e.g. <F12> Main()
 //
 RETURN( ExecMacro( macronameS ) )
 //
END

// library: warn: cons3 <description>error: warning: give a warning message via 3 strings</description> <version>1.0.0.0.2</version> <version control></version control> (filenamemacro=conswawd.s) [<Program>] [<Research>] [[kn, ri, su, 29-07-2001 18:24:52]
PROC PROCWarnCons3( STRING s1, STRING s2, STRING s3 )
 // e.g. PROC Main()
 // e.g.  PROCWarnCons3( "error", "1", "2" ) // gives e.g. "error 1 2"
 // e.g. END
 // e.g.
 // e.g. <F12> Main()
 //
 PROCWarn( FNStringGetCons3S( s1, s2, s3 ) )
 //
END

// library: string: get: program4nt <description></description> <version control></version control> <version>1.0.0.0.1</version> (filenamemacro=getstgps.s) [<Program>] [<Research>] [kn, am, we, 29-04-2009 18:53:22]
STRING PROC FNStringGetProgram4ntFilenameS()
 // e.g. PROC Main()
 // e.g.  Message( FNStringGetProgram4ntFilenameS() ) // gives e.g. "f:\4dos\4nt.exe"
 // e.g. END
 // e.g.
 // e.g. <F12> Main()
 //
 RETURN( FNStringGetFileIniDefaultS( "ProgramName4DosS" ) )
 //
END

// library: string: get: path: file: alias: unicode4: dos4: nt: filename <description></description> <version control></version control> <version>1.0.0.0.1</version> <version control></version control> (filenamemacro=getstnfj.s) [<Program>] [<Research>] [kn, ri, su, 25-12-2016 02:20:20]
STRING PROC FNStringGetPathFileAliasUnicode4Dos4NtFilenameS()
 // e.g. PROC Main()
 // e.g.  IF ( FNMathGetNumberInputYesNoCancelPositionDefaultI( Format( "Alias command (should be similar to computer name)", " ", "=", " ", FNStringGetPathFileAliasUnicode4Dos4NtFilenameS() ) ) == 1 ) // gives e.g. "c:\4dos\aliasUnicode.dok"
 // e.g.  ENDIF
 // e.g. END
 // e.g.
 // e.g. <F12> Main()
 //
 // do not add this, it becomes too slow [kn, ri, sa, 09-02-2013 01:49:15]
 // PROCMacroRunPurgeParameter( "runprmcn", Format( FNStringGetMachineNameS(), ";", FNStringGetUserNameFirstS(), ";", FNStringGetUserNameLastS(), ";", FNStringGetPortS(), ";", "TSE%3A+String%3A+Get%3A" + "FNStringGetPathFileAlias4Dos4NtS" + "&submit01=Create" ) )
 //
 RETURN( FNStringGetFileIniDefaultS( "FNStringGetPathFileAliasUnicode4Dos4NtS" ) )
 //
END

// library: string: get: initialization: global <description></description> <version control></version control> <version>1.0.0.0.1</version> (filenamemacro=getstigl.s) [<Program>] [<Research>] [kn, ri, mo, 22-05-2006 23:44:33]
STRING PROC FNStringGetInitializationGlobalS( STRING searchS, STRING sectionS, STRING fileNameS )
 // e.g. PROC Main()
 // e.g.  Message( FNStringGetInitializationGlobalS( "path4dos", "default", FNStringGetFilenameIniDefaultS() ) ) // e.g. gives "c:\4dos"
 // e.g. END
 // e.g.
 // e.g. <F12> Main()
 //
 RETURN( GetProfileStr( sectionS, searchS, FNStringGetEmptyS(), fileNameS ) )
 //
END

// library: string: get: section: separator <description></description> <version control></version control> <version>1.0.0.0.1</version> (filenamemacro=getstssh.s) [<Program>] [<Research>] [kn, ri, mo, 22-05-2006 23:43:21]
STRING PROC FNStringGetSectionSeparatorS()
 // e.g. PROC Main()
 // e.g.  Message( FNStringGetSectionSeparatorS() ) // gives e.g. "default"
 // e.g. END
 // e.g.
 // e.g. <F12> Main()
 //
 RETURN( "default" ) // you can not put this in the initialization file, because this actually determines the default section of that file itself. Possibly pass it as a command line parameter
 //
END

// library: filename: get: filename: ini: default <description></description> <version control></version control> <version>1.0.0.0.1</version> (filenamemacro=getfiide.s) [<Program>] [<Research>] [kn, ri, we, 31-12-2003 02:15:47]
STRING PROC FNStringGetFilenameIniDefaultS()
 // e.g. PROC Main()
 // e.g.  Message( FNStringGetFilenameIniDefaultS() ) // gives e.g. "c:\documents and settings\administrator\application data\dddpath.ini"
 // e.g. END
 // e.g.
 // e.g. <F12> Main()
 //
 // RETURN( "c:\dddpath.ini" )
 //
 RETURN( FNStringGetConcatS( FNStringGetPathUser_DataApplicationCurrentBackslashS(), FNStringGet_FilenameIniDefaultS() ) )
 //
END

// library: warn <description>error: warning: give a warning message</description> <version>1.0.0.0.3</version> <version control></version control> (filenamemacro=wawarn.s)  [<Program>] [<Research>] [kn, zoe, we, 09-06-1999 22:11:07]
PROC PROCWarn( STRING s )
 // e.g. PROC Main()
 // e.g.  PROCWarn( "you have forgotten to input a value" )
 // e.g. END
 // e.g.
 // e.g. <F12> Main()
 //
 PROCMacroRunKeep( "setwiyde" ) // operation: set: window: warn/yesno: position: x: y: default // new [kn, ri, fr, 22-05-2020 20:12:39]
 Warn( s )
 //
END

// library: string: get: cons3: string: concatenation: 3 strings <description></description> <version control></version control> <version>1.0.0.0.1</version> (filenamemacro=getstgcy.s) [<Program>] [<Research>] [kn, zoe, fr, 17-11-2000 13:52:07]
STRING PROC FNStringGetCons3S( STRING s1, STRING s2, STRING s3 )
 // e.g. PROC Main()
 // e.g.  Message( FNStringGetCons3S( "a", "b", "c" ) ) // gives e.g. "a b c"
 // e.g. END
 // e.g.
 // e.g. <F12> Main()
 //
 RETURN( FNStringGetConsS( FNStringGetConsS( s1, s2 ), s3 ) )
 //
END

// library: string: get: empty (return an empty string) <description></description> <version control></version control> <version>1.0.0.0.1</version> (filenamemacro=getstgem.s) [<Program>] [<Research>] [kn, ri, sa, 20-05-2000 20:11:03]
STRING PROC FNStringGetEmptyS()
 // e.g. PROC Main()
 // e.g.  Message( FNStringGetEmptyS() ) // gives e.g. ...""
 // e.g. END
 // e.g.
 // e.g. <F12> Main()
 //
 RETURN( "" )
 //
END

// library: string: get: concat <description>concatenation 2 words tot 1 word</description> <version>1.0.0.0.3</version> (filenamemacro=getstgch.s) [<Program>] [<Research>] [kn, zoe, th, 01-02-2001 19:32:49]
STRING PROC FNStringGetConcatS( STRING s1, STRING s2 )
 // e.g. PROC Main()
 // e.g.  Message( FNStringGetConcatS( "test1", "test2" ) ) // version with test if string empty ) // gives e.g. "test1test2"
 // e.g. END
 // e.g.
 // e.g. <F12> Main()
 //
 RETURN( FNStringGetConcatSeparatorS( s1, s2, FNStringGetEmptyS() ) )
 //
END

// library: string: get: path: user: data: application: current: backslash <description></description> <version control></version control> <version>1.0.0.0.2</version> (filenamemacro=getstcbe.s) [<Program>] [<Research>] [kn, ri, sa, 21-02-2004 23:01:06]
STRING PROC FNStringGetPathUser_DataApplicationCurrentBackslashS()
 // e.g. PROC Main()
 // e.g.  Message( FNStringGetPathUser_DataApplicationCurrentBackslashS() ) // gives e.g. "c:\documents and settings\administrator\application data\" (this is a hidden directory)
 // e.g. END
 // e.g.
 // e.g. <F12> Main()
 //
 RETURN( FNStringGetFilenameEndBackSlashNotEqualInsertEndS( FNStringGetPathUser_DataApplicationCurrentBackslashNotS() ) )
 //
END

// library: string: get: filename: ini: default <description></description> <version control></version control> <version>1.0.0.0.1</version> (filenamemacro=getstide.s) [<Program>] [<Research>] [kn, ri, sa, 21-02-2004 22:54:12]
STRING PROC FNStringGet_FilenameIniDefaultS()
 // e.g. PROC Main()
 // e.g.  Message( FNStringGet_FilenameIniDefaultS() ) // gives e.g. "dddpath.ini"
 // e.g. END
 // e.g.
 // e.g. <F12> Main()
 //
 RETURN( "dddpath.ini" ) // you can not put this in the global initialization file, because this actually determines the name of that file itself. You could overrule this by passing the filename as a parameter on the command line. (if ( parameter is empty ) then ( defaultfilename = dddpath.ini ), else ( defaultfilename = <that command line parameter> ) )
 //
END

// library: string: get: cons: string: concatenation: concatenation 2 words to 1 word (separated by a space) <description></description> <version control></version control> <version>1.0.0.0.3</version> (filenamemacro=getstgcx.s) [<Program>] [<Research>] [kn, ri, we, 25-11-1998 20:15:03]
STRING PROC FNStringGetConsS( STRING s1, STRING s2 )
 // e.g. //
 // e.g. // version with test if string empty
 // e.g. //
 // e.g. PROC Main()
 // e.g.  Message( FNStringGetConsS( "john", "doe" ) ) // gives "john doe"
 // e.g. END
 // e.g.
 // e.g. <F12> Main()
 //
 RETURN( FNStringGetConcatSeparatorS( s1, s2, FNStringGetCharacterSymbolSpaceS() ) )
 //
END

// library: string: get: concat: separator: string: concatenation: concatenate 2 words to 1 word, separated by separator <description></description> <version control></version control> <version>1.0.0.0.1</version> (filenamemacro=getstcsg.s) [<Program>] [<Research>] [kn, zoe, th, 01-07-1999 01:33:18]
STRING PROC FNStringGetConcatSeparatorS( STRING s1, STRING s2, STRING separatorS )
 // e.g. PROC Main()
 // e.g.  Message( FNStringGetConcatSeparatorS( "test1", "test2", " " ) ) // gives e.g. "tes1 test2"
 // e.g. END
 // e.g.
 // e.g. <F12> Main()
 //
 IF FNStringCheckEmptyB( s1 ) RETURN( s2 ) ENDIF
 //
 IF FNStringCheckEmptyB( s2 ) RETURN( s1 ) ENDIF
 //
 RETURN( s1 + separatorS + s2 ) // leave this like this. Do not call a function, as this is a primitive function, you will get into a recursive loop, and get stack overflow
 //
END

// library: string: get: filename: end: back: slash: not: equal: insert: end <description></description> <version control></version control> <version>1.0.0.0.1</version> (filenamemacro=getstiep.s) [<Program>] [<Research>] [kn, ni, su, 17-08-2003 00:24:04]
STRING PROC FNStringGetFilenameEndBackSlashNotEqualInsertEndS( STRING s )
 // e.g. PROC Main()
 // e.g.  Message( FNStringGetFilenameEndBackSlashNotEqualInsertEndS( 'c:\temp\ddd' ) ) // gives e.g. a string 'c:\temp\ddd\' (so with always a string with a backslash '\' at the end)
 // e.g. END
 // e.g.
 // e.g. <F12> Main()
 //
 RETURN( FNStringGetCharacterEndBackSlashNotEqualInsertEndS( s ) )
 //
END

// library: string: get: path: user: data: application: current <description></description> <version control></version control> <version>1.0.0.0.2</version> (filenamemacro=getstacu.s) [<Program>] [<Research>] [kn, ri, sa, 21-02-2004 22:50:55]
STRING PROC FNStringGetPathUser_DataApplicationCurrentBackslashNotS()
 // e.g. PROC Main()
 // e.g.  Message( FNStringGetPathUser_DataApplicationCurrentBackslashNotS() ) // gives e.g. "c:\documents and settings\administrator\application data" (this is a hidden directory)
 // e.g. END
 // e.g.
 // e.g. <F12> Main()
 //
 STRING s[255] = FNStringGetEnvironmentS( "APPDATA" )
 //
 IF FNStringCheckEnvironmentFoundNotB( s )
  //
  PROCWarnCons3( "current user path to application data", s, ": not found" )
  //
  s = FNStringGetErrorS()
  //
 ENDIF
 //
 RETURN( s )
 //
END

// library: string: get: character: symbol: " " <description></description> <version control></version control> <version>1.0.0.0.1</version> (filenamemacro=getstssp.s) [<Program>] [<Research>] [kn, zoe, we, 25-10-2000 01:33:39]
STRING PROC FNStringGetCharacterSymbolSpaceS()
 // e.g. PROC Main()
 // e.g.  Message( FNStringGetCharacterSymbolSpaceS() ) // gives " "
 // e.g. END
 // e.g.
 // e.g. <F12> Main()
 //
 RETURN( FNStringGetCharacterSymbolCentralS( 32 ) )
 //
END

// library: string: check: empty <description>string: empty: is given string empty?</description> <version>1.0.0.0.1</version> <version control></version control> (filenamemacro=checstcz.s) [<Program>] [<Research>] [[kn, ri, sa, 20-05-2000 20:11:08]
INTEGER PROC FNStringCheckEmptyB( STRING s )
 // e.g. PROC Main()
 // e.g.  Message( FNStringCheckEmptyB( s ) ) // gives e.g. TRUE
 // e.g. END
 // e.g.
 // e.g. <F12> Main()
 //
 RETURN( FNStringCheckEqualB( s, FNStringGetEmptyS() ) )
 //
END

// library: string: get: backslash: if last character is not equal to '\', then concatenate a backslash to the end of the given string <description></description> <version control></version control> <version>1.0.0.0.1</version> (filenamemacro=getstien.s) [<Program>] [<Research>] [kn, ri, sa, 24-02-2001 23:48:15]
STRING PROC FNStringGetCharacterEndBackSlashNotEqualInsertEndS( STRING s )
 // e.g. PROC Main()
 // e.g.  STRING s1[255] = FNStringGetInitializeNewStringS()
 // e.g.  s1 = FNStringGetInputS( "string: get: backslash: if: not equal insert end: string = ", "this is a string without a backslash at end" )
 // e.g.  IF FNKeyCheckPressEscapeB( s1 ) RETURN() ENDIF
 // e.g.  Message( FNStringGetCharacterEndBackSlashNotEqualInsertEndS( s1 ) ) // gives e.g. "this is a string with a backslash at end\"
 // e.g. END
 // e.g.
 // e.g. <F12> Main()
 //
 RETURN( FNStringGetCharacterInsertEndIfEqualNotS( s, FNStringGetCharacterSymbolSlashBackwardS() ) )
 //
END

// library: environment: string: get (Searches for and Returns a Specified Environment Str) R    GetEnvStr(STRING s)* <description></description> <version control></version control> <version>1.0.0.0.4</version> (filenamemacro=getstgen.s) [<Program>] [<Research>] [kn, ri, th, 25-10-2001 01:44:48]
STRING PROC FNStringGetEnvironmentS( STRING s )
 // e.g. PROC Main()
 // e.g.  STRING s[255] = FNStringGetInputS( "value: environment variable = ", "windir" )
 // e.g.  IF FNKeyCheckPressEscapeB( s ) RETURN() ENDIF
 // e.g.  PROCMessageCons3( s, "=", FNStringGetEnvironmentS( s ) ) // gives e.g. "windir=C:\WINNT", when working on a Windows2000 machine
 // e.g. END
 // e.g.
 // e.g. <F12> Main()
 //
 STRING valueS[255] = GetEnvStr( s )
 //
 IF FNStringCheckEmptyB( valueS )
  //
  // PROCMessageCons3( "environment variable", s, ": not found" ) // old [kn, vo, fr, 08-02-2013 10:14:48]
  //
  valueS = FNStringGetErrorS()
  //
 ENDIF
 //
 RETURN( valueS )
 //
END

// library: environment: check: found: not <description></description> <version control></version control> <version>1.0.0.0.1</version> (filenamemacro=checenfn.s) [<Program>] [<Research>] [kn, ri, sa, 27-05-2006 20:20:03]
INTEGER PROC FNStringCheckEnvironmentFoundNotB( STRING s )
 // e.g. PROC Main()
 // e.g.  Message( FNStringCheckEnvironmentFoundNotB( FNStringGetEmptyS() ) ) // gives TRUE (thus not found) because string empty (or string error string)
 // e.g. END
 // e.g.
 // e.g. <F12> Main()
 //
 RETURN( FNStringCheckEqualErrorOrEmptyB( s ) )
 //
END

// library: string: get: error <description>general output string to recognize an error (e.g. in another routine). Central routine, only one occurrence of this constant string</description> <version>1.0.0.0.2</version> <version control></version control> (filenamemacro=getstger.s) [<Program>] [<Research>] [kn, ri, sa, 05-12-1998 20:58:17]
STRING PROC FNStringGetErrorS()
 // e.g. PROC Main()
 // e.g.  Message( FNStringGetErrorS() ) // gives e.g. "<ERROR>"
 // e.g. END
 //
 RETURN( "<ERROR>" )
 //
END

// library: string: get: character: symbol: central <description>string: get: character: symbol: central</description> <version>1.0.0.0.1</version> <version control></version control> (filenamemacro=getstscm.s) [<Program>] [<Research>] [[kn, ri, sa, 07-07-2001 22:35:39]
STRING PROC FNStringGetCharacterSymbolCentralS( INTEGER I )
 // e.g. PROC Main()
 // e.g.  Message( FNStringGetCharacterSymbolCentralS( I ) ) // gives e.g. ...""
 // e.g. END
 // e.g.
 // e.g. <F12> Main()
 //
 RETURN( FNStringGetAsciiToCharacterS( I ) )
 //
END

// library: string: check: equal <description>string: equal: are two given strings equal? (stored in 'checstcf.s')</description> <version>1.0.0.0.1</version> <version control></version control> (filenamemacro=checstcy.s) [<Program>] [<Research>] [[kn, zoe, we, 04-10-2000 18:23:27]
INTEGER PROC FNStringCheckEqualB( STRING s1, STRING s2 )
 // e.g. PROC Main()
 // e.g.  STRING s1[255] = FNStringGetInitializeNewStringS()
 // e.g.  STRING s2[255] = FNStringGetInitializeNewStringS()
 // e.g.  s1 = FNStringGetInputS( "string: check: equal: first string = ", "a" )
 // e.g.  IF FNKeyCheckPressEscapeB( s1 ) RETURN() ENDIF
 // e.g.  s2 = FNStringGetInputS( "string: check: equal: second string = ", "a" )
 // e.g.  IF FNKeyCheckPressEscapeB( s2 ) RETURN() ENDIF
 // e.g.  Message( FNStringCheckEqualB( s1, s2 ) ) // gives e.g. TRUE when string1 is equal to string2
 // e.g.  GetKey()
 // e.g.  Message( FNStringCheckEqualB( "knud", "knud" ) ) // gives TRUE
 // e.g.  GetKey()
 // e.g.  Message( FNStringCheckEqualB( "knud", "van" ) ) // gives FALSE
 // e.g. END
 // e.g.
 // e.g. <F12> Main()
 //
 RETURN( s1 == s2 )
 //
END

// library: compare if string end is equal, if not so insert that string at the end <description></description> <version control></version control> <version>1.0.0.0.1</version> (filenamemacro=getstenp.s) [<Program>] [<Research>] [kn, ri, sa, 24-02-2001 23:06:33]
STRING PROC FNStringGetCharacterInsertEndIfEqualNotS( STRING inS, STRING tailS )
 // e.g. PROC Main()
 // e.g.  STRING s1[255] = FNStringGetInitializeNewStringS()
 // e.g.  STRING s2[255] = FNStringGetInitializeNewStringS()
 // e.g.  s1 = FNStringGetInputS( "string: insert: insert: string = ", "c:\kee" )
 // e.g.  IF FNKeyCheckPressEscapeB( s1 ) RETURN() ENDIF
 // e.g.  s2 = FNStringGetInputS( "string: insert: insert: frontS = ", "\" )
 // e.g.  IF FNKeyCheckPressEscapeB( s2 ) RETURN() ENDIF
 // e.g.  Message( FNStringGetCharacterInsertEndIfEqualNotS( s1, s2 ) ) // gives e.g. "c:\kee\"
 // e.g.  GetKey()
 // e.g.  Message( FNStringGetCharacterInsertEndIfEqualNotS( "c", ":" ) ) // gives "c:"
 // e.g.  GetKey()
 // e.g.  Message( FNStringGetCharacterInsertEndIfEqualNotS( "c:", ":" ) ) // gives "c:"
 // e.g.  GetKey()
 // e.g.  Message( FNStringGetCharacterInsertEndIfEqualNotS( "c:\kee", FNStringGetCharacterSymbolSlashBackwardS() ) ) // gives "c:\kee\"
 // e.g. END
 // e.g.
 // e.g. <F12> Main()
 //
 STRING s[255] = inS
 //
 IF FNMathCheckLogicNotB( FNStringCheckEqualCharacterLastNB( s, tailS ) )
  //
  // s = FNStringGetConcatS( s, tailS )
  //
  s = FNStringGetConcatTailS( s, tailS )
  //
 ENDIF
 //
 RETURN( s )
 //
END

// library: string: get: character: symbol: "\" <description></description> <version control></version control> <version>1.0.0.0.1</version> (filenamemacro=getstsba.s) [<Program>] [<Research>] [kn, ri, su, 29-07-2001 15:41:11]
STRING PROC FNStringGetCharacterSymbolSlashBackwardS()
 // e.g. PROC Main()
 // e.g.  Message( FNStringGetCharacterSymbolSlashBackwardS() ) // gives "\"
 // e.g. END
 // e.g.
 // e.g. <F12> Main()
 //
 RETURN( FNStringGetCharacterSymbolCentralS( 92 ) )
 //
END

// library: environment: check: found: not <description></description> <version control></version control> <version>1.0.0.0.1</version> (filenamemacro=checenfn.s) [<Program>] [<Research>] [kn, ri, sa, 27-05-2006 20:20:03]
INTEGER PROC FNStringCheckEqualErrorOrEmptyB( STRING s )
 // e.g. PROC Main()
 // e.g.  Message( FNStringCheckEqualErrorOrEmptyB( FNStringGetEmptyS() ) ) // gives TRUE if string empty or string equals error string
 // e.g. END
 // e.g.
 // e.g. <F12> Main()
 //
 RETURN( FNMathCheckLogicOrB( FNErrorCheckSB( s ), FNStringCheckEmptyB( s ) ) )
 //
END

// library: string: get: ascii: to: character (given the ASCII value, what is the corresponding character? (Get Single Character Equivalent of an Integer). Syntax: Chr(INTEGER i)*) <description></description> <version control></version control> <version>1.0.0.0.2</version> (filenamemacro=getsttch.s)  [<Program>] [<Research>] [kn, zoe, we, 16-06-1999 01:06:51]
STRING PROC FNStringGetAsciiToCharacterS( INTEGER asciiI )
 // e.g. PROC Main()
 // e.g.  Warn( FNStringGetAsciiToCharacterS( 65 ) ) // gives "A"
 // e.g.  Warn( FNStringGetAsciiToCharacterS( 66 ) ) // gives "B"
 // e.g.  Warn( FNStringGetAsciiToCharacterS( 100 ) ) // gives "d"
 // e.g. END
 // e.g.
 // e.g. <F12> Main()
 //
 RETURN( Chr( asciiI ) ) // leave this keyword, otherwise possibly recursive stack overflow
 //
END

// library: string: word: equal: last: compare if a given string is equal at the end to another given string <description></description> <version control></version control> <version>1.0.0.0.2</version> (filenamemacro=checstln.s) [<Program>] [<Research>] [kn, zoe, we, 29-11-2000 19:08:34]
INTEGER PROC FNStringCheckEqualCharacterLastNB( STRING s, STRING tailS )
 // e.g. //
 // e.g. // version: first parameter s then endS
 // e.g. //
 // e.g. PROC Main()
 // e.g.  Message( FNStringCheckEqualCharacterLastNB( "knud", "d" ) ) //  gives TRUE
 // e.g. END
 // e.g.
 // e.g. <F12> Main()
 //
 RETURN( FNStringCheckEqualB( FNStringGetRightStringLengthEqualS( s, tailS ), tailS ) )
 //
END

// library: string: get: concat: tail: suffix <description></description> <version control></version control> <version>1.0.0.0.1</version> (filenamemacro=getstctb.s) [<Program>] [<Research>] [kn, ri, su, 02-09-2001 03:08:08]
STRING PROC FNStringGetConcatTailS( STRING s, STRING tailS )
 // e.g. PROC Main()
 // e.g.  Message( FNStringGetConcatTailS( "Knu", "d" ) ) // gives e.g. "Knud"
 // e.g. END
 // e.g.
 // e.g. <F12> Main()
 //
 RETURN( FNStringGetConcatS( s, tailS ) )
 //
END

// library: math: check: logic: or: 2 arguments <description></description> <version control></version control> <version>1.0.0.0.1</version> (filenamemacro=checmalo.s) [<Program>] [<Research>] [kn, ri, tu, 15-05-2001 16:54:17]
INTEGER PROC FNMathCheckLogicOrB( INTEGER B1, INTEGER B2 )
 // e.g. PROC Main()
 // e.g.  STRING s1[255] = FNStringGetInitializeNewStringS()
 // e.g.  STRING s2[255] = FNStringGetInitializeNewStringS()
 // e.g.  s1 = FNStringGetInputS( "math: check: logic: or: number1 = ", "1" )
 // e.g.  IF FNKeyCheckPressEscapeB( s1 ) RETURN() ENDIF
 // e.g.  s2 = FNStringGetInputS( "math: check: logic: or: number2 = ", "1" )
 // e.g.  IF FNKeyCheckPressEscapeB( s2 ) RETURN() ENDIF
 // e.g.  Message( FNMathCheckLogicOrB( FNStringGetToIntegerI( s1 ), FNStringGetToIntegerI( s2 ) ) ) // gives e.g. TRUE
 // e.g. END
 // e.g.
 // e.g. <F12> Main()
 //
 IF ( B1 )
  //
  RETURN( FNMathCheckGetLogicTrueB() )
  //
 ENDIF
 //
 IF ( B2 )
  //
  RETURN( FNMathCheckGetLogicTrueB() )
  //
 ENDIF
 //
 RETURN( FNMathCheckGetLogicFalseB() )
 //
END

// library: error: check <description>error: test if an error occurred, via testing the output // version with testing local variable. Better.</description> <version>1.0.0.0.3</version> <version control></version control> (filenamemacro=checercs.s) [<Program>] [<Research>] [[kn, ni, we, 05-08-1998 20:27:34]
INTEGER PROC FNErrorCheckSB( STRING s )
 // e.g. PROC Main()
 // e.g.  Message( FNErrorCheckSB( "this is an error" ) ) // version with testing local variable. Better. ) // gives TRUE or FALSE
 // e.g. END
 // e.g.
 // e.g. <F12> Main()
 //
 RETURN( FNStringCheckEqualB( s, FNStringGetErrorS() ) )
 //
END

// library: STRING: get: right: string: length: equal <description></description> <version control></version control> <version>1.0.0.0.1</version> (filenamemacro=getstler.s) [<Program>] [<Research>] [kn, ni, su, 30-11-2003 23:32:40]
STRING PROC FNStringGetRightStringLengthEqualS( STRING s, STRING tailS )
 // e.g. PROC Main()
 // e.g.  Message( FNStringGetRightStringLengthEqualS( "Knud van Eeden", "12345" ) ) // gives e.g. "Eeden"
 // e.g. END
 // e.g.
 // e.g. <F12> Main()
 //
 RETURN( FNStringGetRightStringS( s, FNStringGetLengthI( tailS ) ) )
 //
END

// library: math: check: get: logic: true: wrapper <description></description> <version control></version control> <version>1.0.0.0.1</version> (filenamemacro=checmalt.s) [<Program>] [<Research>] [kn, ri, su, 22-07-2001 15:43:12]
INTEGER PROC FNMathCheckGetLogicTrueB()
 // e.g. PROC Main()
 // e.g.  Message( FNMathCheckGetLogicTrueB() ) // gives TRUE
 // e.g. END
 // e.g.
 // e.g. <F12> Main()
 //
 RETURN( TRUE )
 //
END

// library: math: check: get: logic: false: wrapper <description></description> <version control></version control> <version>1.0.0.0.1</version> (filenamemacro=checmalf.s) [<Program>] [<Research>] [kn, ri, su, 22-07-2001 15:43:08]
INTEGER PROC FNMathCheckGetLogicFalseB()
 // e.g. PROC Main()
 // e.g.  Message( FNMathCheckGetLogicFalseB() ) // gives e.g. TRUE
 // e.g. END
 // e.g.
 // e.g. <F12> Main()
 //
 RETURN( FALSE )
 //
END

// library: string: get: word: token: last: return a given integer amount of characters from the right of a given string (=RIGHT$ in BASIC) <description></description> <version control></version control> <version>1.0.0.0.5</version> (filenamemacro=stririrs.s) [<Program>] [<Research>] [kn, ri, tu, 13-10-1998 20:05:49]
STRING PROC FNStringGetRightStringS( STRING s, INTEGER totalI )
 // e.g. PROC Main()
 // e.g.  STRING s[255] = FNStringGetInitializeNewStringS()
 // e.g.  STRING charactertotalS[255] = FNStringGetInitializeNewStringS()
 // e.g.  s = FNStringGetInputS( "string: word: token: get: right: string = ", "knud" )
 // e.g.  IF FNKeyCheckPressEscapeB( s ) RETURN() ENDIF
 // e.g.  charactertotalS = FNStringGetInputS( "string: word: token: get: right: character total = ", "2" )
 // e.g.  IF FNKeyCheckPressEscapeB( charactertotalS ) RETURN() ENDIF
 // e.g.  Message( FNStringGetRightStringS( s, FNStringGetToIntegerI( charactertotalS ) ) ) //  gives e.g. "kn"
 // e.g.  GetKey()
 // e.g.  Message( FNStringGetRightStringS( "knud", 1 ) ) // gives "d"
 // e.g.  GetKey()
 // e.g.  Message( FNStringGetRightStringS( "knud", 2 ) ) // gives "ud"
 // e.g.  GetKey()
 // e.g.  Message( FNStringGetRightStringS( "best", 3 ) ) // gives "est"
 // e.g. END
 // e.g.
 // e.g. <F12> Main()
 //
 INTEGER lengthI = FNStringGetLengthI( s )
 //
 IF FNMathCheckLogicNotB( ( ( 0 <= totalI ) AND ( totalI <= lengthI ) ) ) // if not between 0 and length( string ), return the whole given string
  //
  totalI = lengthI
  //
 ENDIF
 //
 RETURN( FNStringGetMidStringS( s, 1 + lengthI - totalI, lengthI ) )
 //
END

// library: string: line: length: what is the length <description></description> <version control></version control> <version>1.0.0.0.1</version> (filenamemacro=getstgle.s) [<Program>] [<Research>] [kn, ri, we, 25-11-1998 20:20:58]
INTEGER PROC FNStringGetLengthI( STRING s )
 // e.g. PROC Main()
 // e.g.  STRING s1[255] = FNStringGetInitializeNewStringS()
 // e.g.  s1 = FNStringGetInputS( "string: line: length: string = ", "this is a test" )
 // e.g.  IF FNKeyCheckPressEscapeB( s1 ) RETURN() ENDIF
 // e.g.  Message( FNStringGetLengthI( s1 ) ) // gives e.g. 14
 // e.g.  GetKey()
 // e.g.  Message( FNStringGetLengthI( "knud" ) ) // gives 4
 // e.g.  GetKey()
 // e.g.  Message( FNStringGetLengthI( "the" ) ) // gives 3
 // e.g. END
 // e.g.
 // e.g. <F12> Main()
 //
 RETURN( Length( s ) )
 //
END

// library: string: get: mid: string <description></description> <version control>string: get: word: token: middle: return a given integer amount of characters from the a given startposition</version control> <version>1.0.0.0.7</version> (=MID$ in BASIC) <version>1.0.0.0.7</version> (filenamemacro=getstmid.s) [<Program>] [<Research>] [kn, ri, tu, 13-10-1998 20:29:00]
STRING PROC FNStringGetMidStringS( STRING s, INTEGER beginI, INTEGER totalI )
 // e.g. PROC Main()
 // e.g.  STRING s[255] = FNStringGetInitializeNewStringS()
 // e.g.  STRING positionBeginS[255] = FNStringGetInitializeNewStringS()
 // e.g.  STRING characterTotalS[255] = FNStringGetInitializeNewStringS()
 // e.g.  s = FNStringGetInputS( "string: get: MIDSTRING: string = ", "testing" )
 // e.g.  IF FNKeyCheckPressEscapeB( s ) RETURN() ENDIF
 // e.g.  positionBeginS = FNStringGetInputS( "string: get: MIDSTRING: beginposition = ", "2" )
 // e.g.  IF FNKeyCheckPressEscapeB( positionBeginS ) RETURN() ENDIF
 // e.g.  characterTotalS = FNStringGetInputS( "string: get: MIDSTRING: character total = ", "3" )
 // e.g.  IF FNKeyCheckPressEscapeB( characterTotalS ) RETURN() ENDIF
 // e.g.  Message( FNStringGetMidStringS( s, FNStringGetToIntegerI( positionBeginS ), FNStringGetToIntegerI( characterTotalS ) ) )
 // e.g. END
 // e.g.
 // e.g. <F12> Main()
 //
 // Message( FNStringGetMidStringS( "knud", 2, 3 ) ) // gives "nud"
 //
 // Message( FNStringGetMidStringS( "knud", 3, 2 ) ) // gives "ud"
 //
 RETURN( SubStr( s, beginI, totalI ) )
 //
END
