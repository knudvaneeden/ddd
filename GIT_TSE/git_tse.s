FORWARD INTEGER PROC FNFileSaveFileVersionControlGitSimplestCaseB( STRING s1 )
FORWARD INTEGER PROC FNFileSaveFileVersionControlGitSimplestProgramB( STRING s1 )
FORWARD INTEGER PROC FNMacroCheckExecB( STRING s1 )
FORWARD INTEGER PROC FNMacroCheckLoadB( STRING s1 )
FORWARD INTEGER PROC FNMathCheckLogicNotB( INTEGER i1 )
FORWARD INTEGER PROC FNMathGetNumberInputYesNoCancelPositionDefaultI( STRING s1 )
FORWARD INTEGER PROC FNProgramRunGitTseOutputB( STRING s1, STRING s2, INTEGER i1 )
FORWARD INTEGER PROC FNStringCheckEmptyB( STRING s1 )
FORWARD INTEGER PROC FNStringCheckEqualB( STRING s1, STRING s2 )
FORWARD INTEGER PROC FNStringGetLengthI( STRING s1 )
FORWARD INTEGER PROC FNWindowSetCenterPopupOnB()
FORWARD PROC Main()
FORWARD PROC PROCMacroExec( STRING s1 )
FORWARD PROC PROCMacroRunKeep( STRING s1 )
FORWARD PROC PROCProgramRunGitTsePause()
FORWARD PROC PROCProgramRunPopupWindowPositionTse()
FORWARD PROC PROCWarn( STRING s1 )
FORWARD PROC PROCWarnCons3( STRING s1, STRING s2, STRING s3 )
FORWARD STRING PROC FNStringGetAsciiToCharacterS( INTEGER i1 )
FORWARD STRING PROC FNStringGetCarS( STRING s1 )
FORWARD STRING PROC FNStringGetCdrS( STRING s1 )
FORWARD STRING PROC FNStringGetCharacterSymbolCentralS( INTEGER i1 )
FORWARD STRING PROC FNStringGetCharacterSymbolSpaceS()
FORWARD STRING PROC FNStringGetConcatSeparatorS( STRING s1, STRING s2, STRING s3 )
FORWARD STRING PROC FNStringGetCons3S( STRING s1, STRING s2, STRING s3 )
FORWARD STRING PROC FNStringGetConsS( STRING s1, STRING s2 )
FORWARD STRING PROC FNStringGetDeleteWordFrontS( STRING s1, STRING s2 )
FORWARD STRING PROC FNStringGetDirectoryRepositoryGitDefaultS()
FORWARD STRING PROC FNStringGetEmptyS()
FORWARD STRING PROC FNStringGetSpaceRemoveBeginS( STRING s1 )


// --- MAIN --- //

//
STRING iniFileNameGS[255] = ".\git_tse.ini"
//
PROC Main()
 //
 STRING listS[255] = ""
 STRING s[255] = ""
 //
 // declare possibly enough strings for Git programs
 //
 STRING s1[255] = ""
 STRING s2[255] = ""
 STRING s3[255] = ""
 STRING s4[255] = ""
 STRING s5[255] = ""
 STRING s6[255] = ""
 STRING s7[255] = ""
 STRING s8[255] = ""
 STRING s9[255] = ""
 STRING s10[255] = ""
 STRING s11[255] = ""
 STRING s12[255] = ""
 STRING s13[255] = ""
 STRING s14[255] = ""
 STRING s15[255] = ""
 STRING s16[255] = ""
 STRING s17[255] = ""
 STRING s18[255] = ""
 STRING s19[255] = ""
 STRING s20[255] = ""
 //
 INTEGER B = FALSE
 //
 INTEGER bufferI = 0
 //
 // CHANGE: ONCE: BEGIN
 //
 // B = FNFileSaveFileVersionControlGitSimplestInitializeB()
 PROCMacroRunKeep( "savefisi" )
 //
 // SetGlobalStr( "iniFileNameS", ".\git_tse.ini" ) // change this to .ini file in the current local directory
 SetGlobalStr( "iniFileNameS", QuotePath( Format( AddTrailingSlash( LoadDir() ), "tse.ini" ) ) ) // change this
 //
 // SetGlobalStr( "sectionS", "git_tse" ) // change this
 SetGlobalStr( "sectionS", "git_tse_knud" ) // change this
 //
 // CHANGE: ONCE: END
 //
 // ===
 //
 REPEAT
  //
  // Git programs
  //
  s1 = "push all files from current local repository directory to a remote directory"
  SetGlobalStr( s1, "s020 s017 s029 s041" )
  //
  s2 = "add + commit current filename in your current repository directory"
  SetGlobalStr( s2, "s010" )
  //
  s3 = "Add + Commit a filename not to be loaded into TSE to your current local repository directory"
  SetGlobalStr( s3, "s110" )
  //
  s4 = "read your current repository directory"
  SetGlobalStr( s4, "s050" )
  //
  s5 = "pull all files from a remote directory to current local repository directory"
  SetGlobalStr( s5, "s020 s028 s041" )
  //
  s6 = "clone remote directory to a new local directory"
  SetGlobalStr( s6, "s099 s024" )
  //
  s7 = "change to your default local repository directory"
  SetGlobalStr( s7, "s101" )
  //
  s8 = "Change to another local repository directory"
  SetGlobalStr( s8, "s020" )
  //
  s9 = "change to default local repository directory + add + commit current filename"
  SetGlobalStr( s9, "s101 s010" )
  //
  s10 = "Delete your currently loaded file in TSE from your local repository directory"
  SetGlobalStr( s10, "s037" )
  //
  s11 = "Delete your currently loaded file in TSE from your remote repository directory (from git + also disk)"
  SetGlobalStr( s11, "s104" )
  //
  s12 = "Delete your currently loaded file in TSE from your remote repository directory (from git only)"
  SetGlobalStr( s12, "s105" )
  //
  s13 = "Delete a filename not to be loaded into TSE from your current local repository directory"
  SetGlobalStr( s13, "s111" )
  //
  s14 = "Delete a filename not to be loaded into TSE from your remote repository directory"
  SetGlobalStr( s14, "s112" )
  //
  s15 = "Add + Commit all files in the root directory and all subdirectories of the current repository directory (add . / commit .)"
  SetGlobalStr( s15, "s017" )
  //
  s16 = "initialize first git"
  SetGlobalStr( s16, "s011 s012 s013 s014" )
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
  AddLine( s2 )
  AddLine( s3 )
  AddLine( s4 )
  AddLine( s5 )
  AddLine( s6 )
  AddLine( s7 )
  AddLine( s8 )
  AddLine( s9 )
  AddLine( s10 )
  AddLine( s11 )
  AddLine( s12 )
  AddLine( s13 )
  AddLine( s14 )
  AddLine( s15 )
  AddLine( s16 )
  //
  AddLine( "quit" )
  //
  GotoLine( 1 )
  PROCProgramRunPopupWindowPositionTse()
  IF List( "Choose an option", 130 )
   listS = Trim( GetText( 1, 255 ) )
  ELSE
   AbandonFile( bufferI )
   RETURN()
  ENDIF
  AbandonFile( bufferI )
  PopBlock()
  PopPosition()
  //
  PROCProgramRunPopupWindowPositionTse()
 IF ( NOT ( Ask( "file: save: file: version: control: git: simplest: program: inS = ", listS, _EDIT_HISTORY_ ) ) AND ( Length( listS ) > 0 ) ) RETURN() ENDIF
  //
  Message( FNFileSaveFileVersionControlGitSimplestProgramB( listS ) ) // gives e.g. TRUE
  //
 UNTIL ( EquiStr( Lower( s1 ), "quit" ) )
 //
END

// --- LIBRARY --- //

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

// library: program: run: git: tse: window <description></description> <version control></version control> <version>1.0.0.0.11</version> <version control></version control> (filenamemacro=runprtwi.s) [<Program>] [<Research>] [kn, ri, mo, 21-11-2022 12:31:19]
PROC PROCProgramRunPopupWindowPositionTse()
 // e.g. //
 // e.g. STRING iniFileNameGS[255] = ".\git_tse.ini"
 // e.g. //
 // e.g. PROC Main()
 // e.g.  PROCProgramRunPopupWindowPositionTse()
 // e.g. END
 // e.g.
 // e.g. <F12> Main()
 //
 // ===
 //
 // Use case =
 //
 // ===
 //
 // ===
 //
 // Method =
 //
 // ===
 //
 // ===
 //
 // Example:
 //
 // Input:
 //
 /*
--- cut here: begin --------------------------------------------------
--- cut here: end ----------------------------------------------------
 */
 //
 // Output:
 //
 /*
--- cut here: begin --------------------------------------------------
--- cut here: end ----------------------------------------------------
 */
 //
 // ===
 //
 // e.g. // QuickHelp( HELPDEFPROCProgramRunGitTseWindow )
 // e.g. HELPDEF HELPDEFPROCProgramRunGitTseWindow
 // e.g.  title = "PROCProgramRunPopupWindowPositionTse() help" // The help's caption
 // e.g.  x = 100 // Location
 // e.g.  y = 3 // Location
 // e.g.  //
 // e.g.  // The actual help text
 // e.g.  //
 // e.g.  "Usage:"
 // e.g.  "//"
 // e.g.  "1. Run this TSE macro"
 // e.g.  "2. Then press <CtrlAlt F1> to show this help."
 // e.g.  "3. Press <Shift Escape> to quit."
 // e.g.  "//"
 // e.g.  ""
 // e.g.  "Key: Definitions:"
 // e.g.  ""
 // e.g.  "<> = do something"
 // e.g. END
 //
 INTEGER B = FALSE
 //
 STRING caseS[255] = ""
 //
 STRING sectionS[255] = GetGlobalStr( "sectionS" )
 //
 IF EquiStr( Trim( sectionS ), "" )
  //
  Warn( 'Please first set your SetGlobalStr( "sectionS" ) in file git_tse.s' )
  //
 ELSE
  //
  caseS = sectionS
  //
  CASE caseS
   //
   WHEN "git_tse"
    //
    B = FNWindowSetCenterPopupOnB()
    //
   WHEN "git_tse_knud"
    //
    ExecMacro( "setwiyde" ) // operation: set: window: warn/yesno: position: x: y: default // new
    //
   OTHERWISE
    //
    Warn( "PROCProgramRunPopupWindowPositionTse(", " ", "case", " ", ":", " ", caseS, ": not known" )
    //
    RETURN()
    //
  ENDCASE
 //
 ENDIF
 //
END

// library: file: save: file: version: control: git: simplest: program <description></description> <version control></version control> <version>1.0.0.0.81</version> <version control></version control> (filenamemacro=git_tse.s) [<Program>] [<Research>] [kn, ri, th, 24-11-2022 00:19:45]
INTEGER PROC FNFileSaveFileVersionControlGitSimplestProgramB( STRING inS )
 // e.g. //
 // e.g. STRING iniFileNameGS[255] = ".\git_tse.ini"
 // e.g. //
 // e.g. PROC Main()
 // e.g.  //
 // e.g.  STRING listS[255] = ""
 // e.g.  STRING s[255] = ""
 // e.g.  //
 // e.g.  // declare possibly enough strings for Git programs
 // e.g.  //
 // e.g.  STRING s1[255] = ""
 // e.g.  STRING s2[255] = ""
 // e.g.  STRING s3[255] = ""
 // e.g.  STRING s4[255] = ""
 // e.g.  STRING s5[255] = ""
 // e.g.  STRING s6[255] = ""
 // e.g.  STRING s7[255] = ""
 // e.g.  STRING s8[255] = ""
 // e.g.  STRING s9[255] = ""
 // e.g.  STRING s10[255] = ""
 // e.g.  STRING s11[255] = ""
 // e.g.  STRING s12[255] = ""
 // e.g.  STRING s13[255] = ""
 // e.g.  STRING s14[255] = ""
 // e.g.  STRING s15[255] = ""
 // e.g.  STRING s16[255] = ""
 // e.g.  STRING s17[255] = ""
 // e.g.  STRING s18[255] = ""
 // e.g.  STRING s19[255] = ""
 // e.g.  STRING s20[255] = ""
 // e.g.  //
 // e.g.  INTEGER B = FALSE
 // e.g.  //
 // e.g.  INTEGER bufferI = 0
 // e.g.  //
 // e.g.  // CHANGE: ONCE: BEGIN
 // e.g.  //
 // e.g.  // B = FNFileSaveFileVersionControlGitSimplestInitializeB()
 // e.g.  PROCMacroRunKeep( "savefisi" )
 // e.g.  //
 // e.g.  // SetGlobalStr( "iniFileNameS", ".\git_tse.ini" ) // change this to .ini file in the current local directory
 // e.g.  SetGlobalStr( "iniFileNameS", QuotePath( Format( AddTrailingSlash( LoadDir() ), "tse.ini" ) ) ) // change this
 // e.g.  //
 // e.g.  // SetGlobalStr( "sectionS", "git_tse" ) // change this
 // e.g.  SetGlobalStr( "sectionS", "git_tse_knud" ) // change this
 // e.g.  //
 // e.g.  // CHANGE: ONCE: END
 // e.g.  //
 // e.g.  // ===
 // e.g.  //
 // e.g.  REPEAT
 // e.g.   //
 // e.g.   // Git programs
 // e.g.   //
 // e.g.   s1 = "push all files from current local repository directory to a remote directory"
 // e.g.   SetGlobalStr( s1, "s020 s017 s029 s041" )
 // e.g.   //
 // e.g.   s2 = "add + commit current filename in your current repository directory"
 // e.g.   SetGlobalStr( s2, "s010" )
 // e.g.   //
 // e.g.   s3 = "Add + Commit a filename not to be loaded into TSE to your current local repository directory"
 // e.g.   SetGlobalStr( s3, "s110" )
 // e.g.   //
 // e.g.   s4 = "read your current repository directory"
 // e.g.   SetGlobalStr( s4, "s050" )
 // e.g.   //
 // e.g.   s5 = "pull all files from a remote directory to current local repository directory"
 // e.g.   SetGlobalStr( s5, "s020 s028 s041" )
 // e.g.   //
 // e.g.   s6 = "clone remote directory to a new local directory"
 // e.g.   SetGlobalStr( s6, "s099 s024" )
 // e.g.   //
 // e.g.   s7 = "change to your default local repository directory"
 // e.g.   SetGlobalStr( s7, "s101" )
 // e.g.   //
 // e.g.   s8 = "Change to another local repository directory"
 // e.g.   SetGlobalStr( s8, "s020" )
 // e.g.   //
 // e.g.   s9 = "change to default local repository directory + add + commit current filename"
 // e.g.   SetGlobalStr( s9, "s101 s010" )
 // e.g.   //
 // e.g.   s10 = "Delete your currently loaded file in TSE from your local repository directory"
 // e.g.   SetGlobalStr( s10, "s037" )
 // e.g.   //
 // e.g.   s11 = "Delete your currently loaded file in TSE from your remote repository directory (from git + also disk)"
 // e.g.   SetGlobalStr( s11, "s104" )
 // e.g.   //
 // e.g.   s12 = "Delete your currently loaded file in TSE from your remote repository directory (from git only)"
 // e.g.   SetGlobalStr( s12, "s105" )
 // e.g.   //
 // e.g.   s13 = "Delete a filename not to be loaded into TSE from your current local repository directory"
 // e.g.   SetGlobalStr( s13, "s111" )
 // e.g.   //
 // e.g.   s14 = "Delete a filename not to be loaded into TSE from your remote repository directory"
 // e.g.   SetGlobalStr( s14, "s112" )
 // e.g.   //
 // e.g.   s15 = "Add + Commit all files in the root directory and all subdirectories of the current repository directory (add . / commit .)"
 // e.g.   SetGlobalStr( s15, "s017" )
 // e.g.   //
 // e.g.   s16 = "initialize first git"
 // e.g.   SetGlobalStr( s16, "s011 s012 s013 s014" )
 // e.g.   //
 // e.g.   PushPosition()
 // e.g.   bufferI = CreateTempBuffer()
 // e.g.   PopPosition()
 // e.g.   //
 // e.g.   PushPosition()
 // e.g.   PushBlock()
 // e.g.   GotoBufferId( bufferI )
 // e.g.   //
 // e.g.   AddLine( s1 )
 // e.g.   AddLine( s2 )
 // e.g.   AddLine( s3 )
 // e.g.   AddLine( s4 )
 // e.g.   AddLine( s5 )
 // e.g.   AddLine( s6 )
 // e.g.   AddLine( s7 )
 // e.g.   AddLine( s8 )
 // e.g.   AddLine( s9 )
 // e.g.   AddLine( s10 )
 // e.g.   AddLine( s11 )
 // e.g.   AddLine( s12 )
 // e.g.   AddLine( s13 )
 // e.g.   AddLine( s14 )
 // e.g.   AddLine( s15 )
 // e.g.   AddLine( s16 )
 // e.g.   //
 // e.g.   AddLine( "quit" )
 // e.g.   //
 // e.g.   GotoLine( 1 )
 // e.g.   PROCProgramRunPopupWindowPositionTse()
 // e.g.   IF List( "Choose an option", 130 )
 // e.g.    listS = Trim( GetText( 1, 255 ) )
 // e.g.   ELSE
 // e.g.    AbandonFile( bufferI )
 // e.g.    RETURN()
 // e.g.   ENDIF
 // e.g.   AbandonFile( bufferI )
 // e.g.   PopBlock()
 // e.g.   PopPosition()
 // e.g.   //
 // e.g.   PROCProgramRunPopupWindowPositionTse()
 // e.g.  IF ( NOT ( Ask( "file: save: file: version: control: git: simplest: program: inS = ", listS, _EDIT_HISTORY_ ) ) AND ( Length( listS ) > 0 ) ) RETURN() ENDIF
 // e.g.   //
 // e.g.   Message( FNFileSaveFileVersionControlGitSimplestProgramB( listS ) ) // gives e.g. TRUE
 // e.g.   //
 // e.g.  UNTIL ( EquiStr( Lower( s1 ), "quit" ) )
 // e.g.  //
 // e.g. END
 //
 // ===
 //
 // Use case =
 //
 // ===
 //
 // ===
 //
 // Method =
 //
 // ===
 //
 // ===
 //
 // Example:
 //
 // Input:
 //
 /*
--- cut here: begin --------------------------------------------------
--- cut here: end ----------------------------------------------------
 */
 //
 // Output:
 //
 /*
--- cut here: begin --------------------------------------------------
--- cut here: end ----------------------------------------------------
 */
 //
 // ===
 //
 // e.g. // QuickHelp( HELPDEFFNFileSaveFileVersionControlGitSimplestProgramB )
 // e.g. HELPDEF HELPDEFFNFileSaveFileVersionControlGitSimplestProgramB
 // e.g.  title = "FNFileSaveFileVersionControlGitSimplestProgramB( s1 ) help" // The help's caption
 // e.g.  x = 100 // Location
 // e.g.  y = 3 // Location
 // e.g.  //
 // e.g.  // The actual help text
 // e.g.  //
 // e.g.  "Usage:"
 // e.g.  "//"
 // e.g.  "1. Run this TSE macro"
 // e.g.  "2. Then press <CtrlAlt F1> to show this help."
 // e.g.  "3. Press <Shift Escape> to quit."
 // e.g.  "//"
 // e.g.  ""
 // e.g.  "Key: Definitions:"
 // e.g.  ""
 // e.g.  "<> = do something"
 // e.g. END
 //
 INTEGER B = FALSE
 //
 STRING lineS[255] = GetGlobalStr( inS )
 //
 STRING s[255] = GetGlobalStr( inS )
 STRING carS[255] = ""
 //
 REPEAT
  //
  carS = FNStringGetCarS( s )
  //
  IF EquiStr( carS[ 1 ], "s" )
   //
   lineS = GetGlobalStr( carS )
   //
   PROCProgramRunPopupWindowPositionTse()
   Warn( lineS )
   //
   B = FNFileSaveFileVersionControlGitSimplestCaseB( lineS )
   //
  ENDIF
  //
  s = FNStringGetCdrS( s )
  //
  PROCProgramRunGitTsePause()
  //
 UNTIL EquiStr( Trim( s ), "" )
 //
 B = TRUE
 //
 RETURN( B )
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

// library: window: set: center: popup: on <description></description> <version control></version control> <version>1.0.0.0.3</version> <version control></version control> (filenamemacro=setwipon.s) [<Program>] [<Research>] [kn, ri, su, 06-11-2022 03:41:11]
INTEGER PROC FNWindowSetCenterPopupOnB()
 // e.g. PROC Main()
 // e.g.  Message( "Center popups", ":", " ", FNWindowSetCenterPopupOnB() ) // gives e.g. TRUE
 // e.g. END
 // e.g.
 // e.g. <F12> Main()
 //
 // ===
 //
 // Use case =
 //
 // ===
 //
 // ===
 //
 // Method =
 //
 // ===
 //
 // ===
 //
 // Example:
 //
 // Input:
 //
 /*
--- cut here: begin --------------------------------------------------
--- cut here: end ----------------------------------------------------
 */
 //
 // Output:
 //
 /*
--- cut here: begin --------------------------------------------------
--- cut here: end ----------------------------------------------------
 */
 //
 // ===
 //
 // e.g. // QuickHelp( HELPDEFFNWindowSetCenterPopupOnB )
 // e.g. HELPDEF HELPDEFFNWindowSetCenterPopupOnB
 // e.g.  title = "FNWindowSetCenterPopupOnB() help" // The help's caption
 // e.g.  x = 100 // Location
 // e.g.  y = 3 // Location
 // e.g.  //
 // e.g.  // The actual help text
 // e.g.  //
 // e.g.  "Usage:"
 // e.g.  "//"
 // e.g.  "1. Run this TSE macro"
 // e.g.  "2. Then press <CtrlAlt F1> to show this help."
 // e.g.  "3. Press <Shift Escape> to quit."
 // e.g.  "//"
 // e.g.  ""
 // e.g.  "Key: Definitions:"
 // e.g.  ""
 // e.g.  "<> = do something"
 // e.g. END
 //
 Set( SpecialEffects, 14 ) // center popups on
 //
 RETURN( Query( SpecialEffects ) )
 //
END

// library: file: save: file: version: control: git: simplest: case <description></description> <version control></version control> <version>1.0.0.0.371</version> <version control></version control> (filenamemacro=savefisp.s) [<Program>] [<Research>] [kn, ri, su, 13-11-2022 23:45:27]
INTEGER PROC FNFileSaveFileVersionControlGitSimplestCaseB( STRING caseS )
 // e.g. //
 // e.g. #DEFINE ELIST_INCLUDED FALSE
 // e.g. #include [ "eList.s" ]
 // e.g. //
 // e.g. STRING iniFileNameGS[255] = ".\git_tse.ini"
 // e.g. //
 // e.g. PROC Main()
 // e.g.  //
 // e.g.  STRING s1[255] = "" // change this
 // e.g.  //
 // e.g.  INTEGER bufferI = 0
 // e.g.  //
 // e.g.  INTEGER quitB = FALSE
 // e.g.  //
 // e.g.  INTEGER B = FALSE
 // e.g.  //
 // e.g.  // SetGlobalStr( "iniFileNameS", ".\git_tse.ini" ) // change this to .ini file in the current local directory
 // e.g.  SetGlobalStr( "iniFileNameS", QuotePath( Format( AddTrailingSlash( LoadDir() ), "tse.ini" ) ) ) // change this
 // e.g.  //
 // e.g.  // SetGlobalStr( "sectionS", "git_tse" ) // change this
 // e.g.  SetGlobalStr( "sectionS", "git_tse_knud" ) // change this
 // e.g.  //
 // e.g.  REPEAT
 // e.g.   //
 // e.g.   PushPosition()
 // e.g.   bufferI = CreateTempBuffer()
 // e.g.   PopPosition()
 // e.g.   //
 // e.g.   PushPosition()
 // e.g.   PushBlock()
 // e.g.   GotoBufferId( bufferI )
 // e.g.   //
 // e.g.   // B = FNFileSaveFileVersionControlGitSimplestInitializeB()
 // e.g.   PROCMacroRunKeep( "savefisi" )
 // e.g.   //
 // e.g.   AddLine( GetGlobalStr( "s010" ) ) AddLine( "--------------------------------------------------------------------------" )
 // e.g.   AddLine( GetGlobalStr( "s011" ) ) AddLine( "--------------------------------------------------------------------------" )
 // e.g.   AddLine( GetGlobalStr( "s012" ) ) AddLine( "--------------------------------------------------------------------------" )
 // e.g.   AddLine( GetGlobalStr( "s013" ) ) AddLine( "--------------------------------------------------------------------------" )
 // e.g.   AddLine( GetGlobalStr( "s014" ) ) AddLine( "--------------------------------------------------------------------------" )
 // e.g.   AddLine( GetGlobalStr( "s015" ) ) AddLine( "--------------------------------------------------------------------------" )
 // e.g.   AddLine( GetGlobalStr( "s016" ) ) AddLine( "--------------------------------------------------------------------------" )
 // e.g.   AddLine( GetGlobalStr( "s106" ) ) AddLine( "--------------------------------------------------------------------------" )
 // e.g.   AddLine( GetGlobalStr( "s108" ) ) AddLine( "--------------------------------------------------------------------------" )
 // e.g.   AddLine( GetGlobalStr( "s017" ) ) //
 // e.g.   AddLine( GetGlobalStr( "s110" ) ) AddLine( "--------------------------------------------------------------------------" )
 // e.g.   AddLine( GetGlobalStr( "s018" ) ) //
 // e.g.   AddLine( GetGlobalStr( "s019" ) ) AddLine( "--------------------------------------------------------------------------" )
 // e.g.   AddLine( GetGlobalStr( "s020" ) ) //
 // e.g.   AddLine( GetGlobalStr( "s101" ) ) AddLine( "--------------------------------------------------------------------------" )
 // e.g.   AddLine( GetGlobalStr( "s021" ) ) AddLine( "--------------------------------------------------------------------------" )
 // e.g.   AddLine( GetGlobalStr( "s022" ) ) AddLine( "--------------------------------------------------------------------------" )
 // e.g.   AddLine( GetGlobalStr( "s098" ) ) AddLine( "--------------------------------------------------------------------------" )
 // e.g.   AddLine( GetGlobalStr( "s107" ) ) //
 // e.g.   AddLine( GetGlobalStr( "s109" ) ) AddLine( "--------------------------------------------------------------------------" )
 // e.g.   AddLine( GetGlobalStr( "s094" ) ) AddLine( "--------------------------------------------------------------------------" )
 // e.g.   AddLine( GetGlobalStr( "s023" ) ) AddLine( "--------------------------------------------------------------------------" )
 // e.g.   AddLine( GetGlobalStr( "s024" ) ) //
 // e.g.   AddLine( GetGlobalStr( "s025" ) ) AddLine( "--------------------------------------------------------------------------" )
 // e.g.   AddLine( GetGlobalStr( "s026" ) ) AddLine( "--------------------------------------------------------------------------" )
 // e.g.   AddLine( GetGlobalStr( "s027" ) ) //
 // e.g.   AddLine( GetGlobalStr( "s028" ) ) //
 // e.g.   AddLine( GetGlobalStr( "s029" ) ) //
 // e.g.   AddLine( GetGlobalStr( "s030" ) ) //
 // e.g.   AddLine( GetGlobalStr( "s031" ) ) //
 // e.g.   AddLine( GetGlobalStr( "s032" ) ) //
 // e.g.   AddLine( GetGlobalStr( "s033" ) ) //
 // e.g.   AddLine( GetGlobalStr( "s034" ) ) AddLine( "--------------------------------------------------------------------------" )
 // e.g.   AddLine( GetGlobalStr( "s095" ) ) //
 // e.g.   AddLine( GetGlobalStr( "s096" ) ) AddLine( "--------------------------------------------------------------------------" )
 // e.g.   AddLine( GetGlobalStr( "s035" ) ) AddLine( "--------------------------------------------------------------------------" )
 // e.g.   AddLine( GetGlobalStr( "s099" ) ) AddLine( "--------------------------------------------------------------------------" )
 // e.g.   AddLine( GetGlobalStr( "s036" ) ) AddLine( "--------------------------------------------------------------------------" )
 // e.g.   AddLine( GetGlobalStr( "s037" ) ) //
 // e.g.   AddLine( GetGlobalStr( "s111" ) ) //
 // e.g.   AddLine( GetGlobalStr( "s112" ) ) AddLine( "--------------------------------------------------------------------------" )
 // e.g.   AddLine( GetGlobalStr( "s113" ) ) AddLine( "--------------------------------------------------------------------------" )
 // e.g.   AddLine( GetGlobalStr( "s104" ) ) //
 // e.g.   AddLine( GetGlobalStr( "s105" ) ) AddLine( "--------------------------------------------------------------------------" )
 // e.g.   AddLine( GetGlobalStr( "s038" ) ) //
 // e.g.   AddLine( GetGlobalStr( "s103" ) ) //
 // e.g.   AddLine( GetGlobalStr( "s039" ) ) AddLine( "--------------------------------------------------------------------------" )
 // e.g.   AddLine( GetGlobalStr( "s040" ) ) AddLine( "--------------------------------------------------------------------------" )
 // e.g.   AddLine( GetGlobalStr( "s041" ) ) //
 // e.g.   AddLine( GetGlobalStr( "s042" ) ) AddLine( "--------------------------------------------------------------------------" )
 // e.g.   AddLine( GetGlobalStr( "s043" ) ) AddLine( "--------------------------------------------------------------------------" )
 // e.g.   AddLine( GetGlobalStr( "s044" ) ) AddLine( "--------------------------------------------------------------------------" )
 // e.g.   AddLine( GetGlobalStr( "s045" ) ) AddLine( "--------------------------------------------------------------------------" )
 // e.g.   AddLine( GetGlobalStr( "s046" ) ) AddLine( "--------------------------------------------------------------------------" )
 // e.g.   AddLine( GetGlobalStr( "s047" ) ) AddLine( "--------------------------------------------------------------------------" )
 // e.g.   AddLine( GetGlobalStr( "s048" ) ) //
 // e.g.   AddLine( GetGlobalStr( "s049" ) ) AddLine( "--------------------------------------------------------------------------" )
 // e.g.   AddLine( GetGlobalStr( "s102" ) ) AddLine( "--------------------------------------------------------------------------" )
 // e.g.   AddLine( GetGlobalStr( "s050" ) ) //
 // e.g.   AddLine( GetGlobalStr( "s100" ) ) AddLine( "--------------------------------------------------------------------------" )
 // e.g.   AddLine( GetGlobalStr( "s097" ) ) AddLine( "--------------------------------------------------------------------------" )
 // e.g.   AddLine( GetGlobalStr( "s051" ) ) AddLine( "--------------------------------------------------------------------------" )
 // e.g.   AddLine( GetGlobalStr( "s052" ) ) //
 // e.g.   AddLine( GetGlobalStr( "s053" ) ) AddLine( "--------------------------------------------------------------------------" )
 // e.g.   AddLine( GetGlobalStr( "s054" ) ) //
 // e.g.   AddLine( GetGlobalStr( "s092" ) ) AddLine( "--------------------------------------------------------------------------" )
 // e.g.   AddLine( GetGlobalStr( "s055" ) ) AddLine( "--------------------------------------------------------------------------" )
 // e.g.   AddLine( GetGlobalStr( "s056" ) ) AddLine( "--------------------------------------------------------------------------" )
 // e.g.   AddLine( GetGlobalStr( "s057" ) ) //
 // e.g.   AddLine( GetGlobalStr( "s058" ) ) //
 // e.g.   AddLine( GetGlobalStr( "s059" ) ) //
 // e.g.   AddLine( GetGlobalStr( "s060" ) ) //
 // e.g.   AddLine( GetGlobalStr( "s061" ) ) //
 // e.g.   AddLine( GetGlobalStr( "s062" ) ) //
 // e.g.   AddLine( GetGlobalStr( "s063" ) ) //
 // e.g.   AddLine( GetGlobalStr( "s064" ) ) //
 // e.g.   AddLine( GetGlobalStr( "s065" ) ) AddLine( "--------------------------------------------------------------------------" )
 // e.g.   AddLine( GetGlobalStr( "s066" ) ) //
 // e.g.   AddLine( GetGlobalStr( "s067" ) ) AddLine( "--------------------------------------------------------------------------" )
 // e.g.   AddLine( GetGlobalStr( "s068" ) ) AddLine( "--------------------------------------------------------------------------" )
 // e.g.   AddLine( GetGlobalStr( "s069" ) ) AddLine( "--------------------------------------------------------------------------" )
 // e.g.   AddLine( GetGlobalStr( "s070" ) ) AddLine( "--------------------------------------------------------------------------" )
 // e.g.   AddLine( GetGlobalStr( "s071" ) ) AddLine( "--------------------------------------------------------------------------" )
 // e.g.   AddLine( GetGlobalStr( "s072" ) ) AddLine( "--------------------------------------------------------------------------" )
 // e.g.   AddLine( GetGlobalStr( "s073" ) ) AddLine( "--------------------------------------------------------------------------" )
 // e.g.   AddLine( GetGlobalStr( "s074" ) ) AddLine( "--------------------------------------------------------------------------" )
 // e.g.   AddLine( GetGlobalStr( "s075" ) ) AddLine( "--------------------------------------------------------------------------" )
 // e.g.   AddLine( GetGlobalStr( "s093" ) ) AddLine( "--------------------------------------------------------------------------" )
 // e.g.   AddLine( GetGlobalStr( "s076" ) ) AddLine( "--------------------------------------------------------------------------" )
 // e.g.   AddLine( GetGlobalStr( "s077" ) ) AddLine( "--------------------------------------------------------------------------" )
 // e.g.   AddLine( GetGlobalStr( "s078" ) ) //
 // e.g.   AddLine( GetGlobalStr( "s079" ) ) //
 // e.g.   AddLine( GetGlobalStr( "s080" ) ) //
 // e.g.   AddLine( GetGlobalStr( "s081" ) ) //
 // e.g.   AddLine( GetGlobalStr( "s082" ) ) //
 // e.g.   AddLine( GetGlobalStr( "s083" ) ) //
 // e.g.   AddLine( GetGlobalStr( "s084" ) ) AddLine( "--------------------------------------------------------------------------" )
 // e.g.   AddLine( GetGlobalStr( "s085" ) ) AddLine( "--------------------------------------------------------------------------" )
 // e.g.   AddLine( GetGlobalStr( "s086" ) ) //
 // e.g.   AddLine( GetGlobalStr( "s087" ) ) AddLine( "--------------------------------------------------------------------------" )
 // e.g.   AddLine( GetGlobalStr( "s088" ) ) //
 // e.g.   AddLine( GetGlobalStr( "s089" ) ) //
 // e.g.   AddLine( GetGlobalStr( "s090" ) ) //
 // e.g.   AddLine( GetGlobalStr( "s091" ) ) //
 // e.g.   AddLine( "--------------------------------------------------------------------------" )
 // e.g.   //
 // e.g.   GotoLine( 1 )
 // e.g.   PROCProgramRunPopupWindowPositionTse()
 // e.g.   IF EquiStr( GetProfileStr( GetGlobalStr( "sectionS" ), "gitShrinkListS", "", GetGlobalStr( "iniFileNameS" ) ), "false" )
 // e.g.    IF List( "Choose an option", 140 )
 // e.g.     s1 = Trim( GetText( 1, 255 ) )
 // e.g.    ELSE
 // e.g.     AbandonFile( bufferI )
 // e.g.     PopBlock()
 // e.g.     PopPosition()
 // e.g.     RETURN()
 // e.g.    ENDIF
 // e.g.   ELSE
 // e.g.    IF eList( "Choose an option" )
 // e.g.     s1 = Trim( GetText( 1, 255 ) )
 // e.g.    ELSE
 // e.g.     AbandonFile( bufferI )
 // e.g.     PopBlock()
 // e.g.     PopPosition()
 // e.g.     RETURN()
 // e.g.    ENDIF
 // e.g.   ENDIF
 // e.g.   //
 // e.g.   AbandonFile( bufferI )
 // e.g.   PopBlock()
 // e.g.   PopPosition()
 // e.g.   //
 // e.g.   quitB = EquiStr( Trim( Lower( s1 ) ), "quit" )
 // e.g.   //
 // e.g.   IF NOT quitB
 // e.g.    Message( FNFileSaveFileVersionControlGitSimplestCaseB( s1 ) ) // gives e.g. TRUE
 // e.g.   ENDIF
 // e.g.   //
 // e.g.  UNTIL ( quitB )
 // e.g.  //
 // e.g. END
 // e.g.
 // e.g. <F12> Main()
 //
 // ===
 //
 // Use case =
 //
 // ===
 //
 // ===
 //
 // Method =
 //
 // ===
 //
 // ===
 //
 // Example:
 //
 // Input:
 //
 /*
--- cut here: begin --------------------------------------------------
--- cut here: end ----------------------------------------------------
 */
 //
 // Output:
 //
 /*
--- cut here: begin --------------------------------------------------
--- cut here: end ----------------------------------------------------
 */
 //
 // ===
 //
 // e.g. // QuickHelp( HELPDEFFNFileSaveFileVersionControlGitSimplestCaseB )
 // e.g. HELPDEF HELPDEFFNFileSaveFileVersionControlGitSimplestCaseB
 // e.g.  title = "FNFileSaveFileVersionControlGitSimplestCaseB() help" // The help's caption
 // e.g.  x = 100 // Location
 // e.g.  y = 3 // Location
 // e.g.  //
 // e.g.  // The actual help text
 // e.g.  //
 // e.g.  "Usage:"
 // e.g.  "//"
 // e.g.  "1. Run this TSE macro"
 // e.g.  "2. Then press <CtrlAlt F1> to show this help."
 // e.g.  "3. Press <Shift Escape> to quit."
 // e.g.  "//"
 // e.g.  ""
 // e.g.  "Key: Definitions:"
 // e.g.  ""
 // e.g.  "<> = do something"
 // e.g. END
 //
 // ===
 //
 // Todo: Add a command line interpreter and create a programming language then create git programs. Add Remove LogFile ...
 //
 // Todo: There exist also git aliases which allow create multi-command git commands
 //
 // Todo: c, c^1, c^2, c^3, c^4, ...
 // Todo: c, c^, c^^, c^^^, c^^^^, ...
 //
 // Todo: c, c~1, c~2, c~3, c~4, ...
 // Todo: c, c~, c~~, c~~~, c~~~~, ...
 //
 // Todo: Get older versions HEAD~1, HEAD~2, HEAD~3, HEAD~4, ...
 //
 // Todo: View difference between 2 versions using BeyondCompare (see Subversion implementation). HEAD, HEAD~1, HEAD~2, HEAD~3, HEAD~4, ...
 //
 // Todo: Also log non-Dos() commands in the log file => create common procedure / function for the log file
 //
 // Todo: Read the programs from an external .csv file
 //
 // e.g.  initialize first git, s011 s012 s013 s014
 // e.g.  clone remote directory to a new local directory, s099 s024
 // e.g.  push from current local repository directory to a remote directory, s020 s029
 // e.g.  pull from a remote directory to current local repository directory, s020 s028
 //
 // Todo: Read the programs from tse.ini
 //
 // Todo: E.g. compile savefisp.s (single commands) and git_tse.s (composite commands) separately and pass the commands via the command line from program 1 to program 2 and back
 //
 // Todo: Instead of passing a string to Dos(), create a batch .bat file then run Dos() on it
 //
 // Todo: Create a Camtasia video for each of the projects [kn, ri, sa, 03-12-2022 05:09:43]
 //
 // ===
 //
 // The most commonly used git commands are:
 //
 //    add        Add file contents to the index
 //    bisect     Find by binary search the change that introduced a bug
 //    branch     List, create, or delete branches
 //    checkout   Checkout a branch or paths to the working tree
 //    clone      Clone a repository into a new directory
 //    commit     Record changes to the repository
 //    diff       Show changes between commits, commit and working tree, etc
 //    fetch      Download objects and refs from another repository
 //    grep       Print lines matching a pattern
 //    init       Create an empty git repository or reinitialize an existing one
 //    log        Show commit logs
 //    merge      Join two or more development histories together
 //    mv         Move or rename a file, a directory, or a symlink
 //    pull       Fetch from and merge with another repository or a local branch
 //    push       Update remote refs along with associated objects
 //    rebase     Forward-port local commits to the updated upstream head
 //    reset      Reset current HEAD to the specified state
 //    rm         Remove files from the working tree and from the index
 //    show       Show various types of objects
 //    status     Show the working tree status
 //    tag        Create, list, delete or verify a tag object signed with GPG
 //
 // ===
 //
 // CHANGE: ONCE: BEGIN
 //
 // STRING iniFileNameS[255] = ".\git_tse.ini" // change to local .ini file in the same directory
 STRING iniFileNameS[255] = GetGlobalStr( "iniFileNameS" ) // this is the ini file containing your parameters. Change this to an ini file of your choice. The default is tse.ini
 //
 STRING sectionS[255] = GetGlobalStr( "sectionS" ) // This is the section name that should be used in e.g. tse.ini. If you change it you must also change or add it additionally in the file e.g. tse.ini.
 //
 // CHANGE: ONCE: BEGIN
 //
 STRING executableCommandLineS[255] = GetProfileStr( sectionS, "executableCommandLineS", "", iniFileNameS ) // this is your command line executable (e.g. Microsoft cmd.exe, JPSoft TakeCommand tcc, PowerShell, ...). (E.g. cmd.exe)
 //
 STRING directoryExecutableS[255] = GetProfileStr( sectionS, "directoryExecutableS", "", iniFileNameS ) // this is the DIRECTORY in which the executable 'git.exe' is to be found
 //
 STRING githubNameBranchS[255] = GetProfileStr( sectionS, "githubNameBranchS", "", iniFileNameS ) // this is the main branch in GitHub (e.g. TRUNK, e.g. master, e.g. main, ...)
 STRING gitlabNameBranchS[255] = GetProfileStr( sectionS, "gitlabNameBranchS", "", iniFileNameS ) // this is the main branch in GitLab
 //
 STRING messageS[255] = GetProfileStr( sectionS, "messageS", "", iniFileNameS ) // your message template to edit and add after '-m' or '-message'
 //
 STRING directoryRepositoryInS[255] = GetProfileStr( sectionS, "directoryRepositoryInS", "", iniFileNameS ) // this is your current repository directory
 //
 STRING userNameS[255] = GetProfileStr( sectionS, "userNameS", ""  ) // this is your name as to be shown in changes in Git
 STRING userEmailS[255] = GetProfileStr( sectionS, "userEmailS", "", iniFileNameS ) // this is your e.g. email as to be shown in changes in Git
 //
 // fill in your e.g. GitHub user name or password. I store it in my.ini file, you might store it in e.g. tse.ini, or optionally (not recommended) store it hardcoded in this file
 STRING githubUserNameS[255] = GetProfileStr( sectionS, "githubUserNameS", "", iniFileNameS ) // this is your GitHub user name
 STRING githubPasswordS[255] = GetProfileStr( sectionS, "githubPasswordS", "", iniFileNameS ) // this is your GitHub password
 STRING githubRemoteDirectoryUrlS[255] = GetProfileStr( sectionS, "githubRemoteDirectoryUrlS", "", iniFileNameS ) // this is your GitHub remote directory
 //
 // fill in your e.g. GitLab user name or password. I store it in my.ini file, you might store it in e.g. tse.ini, or optionally (not recommended) store it hardcoded in this file
 STRING gitlabUserNameS[255] = GetProfileStr( sectionS, "gitlabUserNameS", "", iniFileNameS ) // this is your GitLab user name
 STRING gitlabPasswordS[255] = GetProfileStr( sectionS, "gitlabPasswordS", "", iniFileNameS ) // this is your GitLab password
 STRING gitlabRemoteDirectoryUrlS[255] = GetProfileStr( sectionS, "gitlabRemoteDirectoryUrlS", "", iniFileNameS ) // this is your GitLab remote directory
 //
 STRING gitsmartgitDownloadUrlS[255] = GetProfileStr( sectionS, "gitsmartgitDownloadUrlS", "", iniFileNameS ) // this is the URL where to download SmartGit Git
 //
 STRING gitcygwinDownloadUrlS[255] = GetProfileStr( sectionS, "gitcygwinDownloadUrlS", "", iniFileNameS ) // this is the URL where to download Cygwin Git
 //
 STRING gitscmDownloadUrlS[255] = GetProfileStr( sectionS, "gitscmDownloadUrlS", "", iniFileNameS ) // this is the URL where to download Git-SCM
 //
 STRING gittortoiseDownloadUrlS[255] = GetProfileStr( sectionS, "gittortoiseDownloadUrlS", "", iniFileNameS ) // this is the URL where to download TortoiseGit
 //
 STRING githubRemoteDirectoryCreateUrlS[255] = GetProfileStr( sectionS, "githubRemoteDirectoryCreateUrlS", "", iniFileNameS ) // this is URL to create a new repository on GitHub
 STRING gitlabRemoteDirectoryCreateUrlS[255] = GetProfileStr( sectionS, "gitlabRemoteDirectoryCreateUrlS", "", iniFileNameS ) // this is URL to create a new repository on GitHub
 //
 STRING bookVersionControlWithGitOReillyUrlS[255] = GetProfileStr( sectionS, "bookVersionControlWithGitOReillyUrlS", "", iniFileNameS ) // this is the URL where to read the 'Version Control with Git' O'Reilly book
 //
 STRING gitLogFileS[255] = GetProfileStr( sectionS, "gitLogFileS", "", iniFileNameS ) // this is a log file name containing the Dos() commands given in this program
 //
 STRING cloneRemoteWebSiteExampleS[255] = GetProfileStr( sectionS, "cloneRemoteWebSiteExampleS", "", iniFileNameS ) // this is an example web site to try cloning from
 //
 // CHANGE: ONCE: END
 //
 STRING executableS[255] = GetProfileStr( sectionS, "executableGitS", "", iniFileNameS )
 //
 INTEGER B = FALSE
 //
 INTEGER changeFileB = FALSE
 //
 STRING directoryRepositoryS[255] = QuotePath( directoryRepositoryInS )
 //
 STRING driveLetterS[255] = SplitPath( directoryRepositoryS, _DRIVE_ )
 //
 STRING executableGitkS[255] = Format( QuotePath( AddTrailingSlash( directoryExecutableS ) ), "gitk.exe" )
 //
 STRING executableGitGuiS[255] = Format( QuotePath( AddTrailingSlash( directoryExecutableS ) ), "git-gui.exe" )
 //
 STRING executableSmartgitGuiS[255] = GetProfileStr( sectionS, "executableSmartgitGuiS", "", iniFileNameS )
 //
 STRING fileNameCurrentS[255] = Quotepath( CurrFilename() ) // full path current filename
 //
 STRING fileNameExtensionS[255] = SplitPath( fileNameCurrentS, _NAME_ | _EXT_ ) // filename.extension of current filename
 //
 STRING fileNameOtherS[255] = "" // full path external filename not to be loaded into TSE
 //
 STRING fileNameExtensionOtherS[255] = "" // external filename.extension not to be loaded into TSE
 //
 STRING directoryDeleteOtherS[255] = "" // external directory to remove
 //
 STRING directoryRepositoryOtherS[255] = ""
 //
 STRING gitRemoteDirectoryUrlS[255] = ""
 //
 STRING gitBranchRemoteDirectoryUrlS[255] = ""
 //
 STRING fileNameOldS[255] = ""
 STRING fileNameNewS[255] = ""
 //
 STRING s[255] = ""
 //
 STRING s1[255] = ""
 //
 STRING s2[255] = ""
 //
 STRING s3[255] = ""
 //
 INTEGER bufferI = 0
 //
 INTEGER quitB = FALSE
 //
 // ===
 //
 PushPosition()
 PushBlock()
 //
 s = Query( MacroCmdLine )
 s = Trim( s )
 IF EquiStr( s, "" )
  s3 = Trim( caseS ) // do something
 ELSE
  s3 = s
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s077" )
  //
  s = ""
  //
  s = bookVersionControlWithGitOReillyUrlS
  //
  StartPgm( s )
  //
  B = FNProgramRunGitTseOutputB( s, "s077", FALSE )
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s039" )
  //
  s = ""
  //
  s = gitTortoiseDownloadUrlS
  //
  StartPgm( s )
  //
  B = FNProgramRunGitTseOutputB( s, "s039", FALSE )
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s038" )
  //
  s = ""
  //
  s = gitCygwinDownloadUrlS
  //
  StartPgm( s )
  //
  B = FNProgramRunGitTseOutputB( s, "s038", FALSE )
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s103" )
  //
  s = ""
  //
  s = gitSmartgitDownloadUrlS
  //
  StartPgm( s )
  //
  B = FNProgramRunGitTseOutputB( s, "s103", FALSE )
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s097" )
  //
  s = ""
  //
  PushPosition()
  PushBlock()
  //
  s = Format( "EditFile", "(", " ", directoryRepositoryS, " ", ")", " ", ")" )
  //
  EditFile( Format( directoryRepositoryS ) )
  //
  UpDateDisplay() // IF WaitForKeyPressed( 0 ) ENDIF // Activate if using a loop
  //
  B = FNProgramRunGitTseOutputB( s, "s097", FALSE )
  //
  // do not replace this, there should always be waited here
  //
  PROCProgramRunPopupWindowPositionTse()
  Warn( "<Press any key to continue>" )
  //
  PopBlock()
  PopPosition()
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s017" )
  //
  s = ""
  //
  IF NOT FileExists( directoryRepositoryS )
   //
   PROCProgramRunPopupWindowPositionTse()
   Warn( "Run the initialize step first to create a Git repository" )
   //
  ELSE
   //
   PROCProgramRunPopupWindowPositionTse()
   IF ( ( Ask( "message = ", messageS, _EDIT_HISTORY_ ) ) AND ( Length( messageS ) > 0 ) )
    //
    s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
    //
    s = Format( s, " ", "&", " " )
    s = Format( s, executableS, " ", "add", " ", "." )
    //
    s = Format( s, " ", "&", " " )
    s = Format( s, executableS, " ", "commit", " ", "-m", " ", '"', messageS, '"' )
    //
    s = Format( s, " ", "&", " " )
    s = Format( s, "pause" )
    //
    B = FNProgramRunGitTseOutputB( s, "s017", TRUE )
    //
   ENDIF
   //
  ENDIF
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s047" )
  //
  s = ""
  //
  IF NOT FileExists( directoryRepositoryS )
   //
   PROCProgramRunPopupWindowPositionTse()
   Warn( "Run the initialize step first to create a Git repository" )
   //
  ELSE
   //
   s1 = " "
   //
   PROCProgramRunPopupWindowPositionTse()
   IF ( ( Ask( "git command(s) to execute = ", s1, _EDIT_HISTORY_ ) ) AND ( Length( s1 ) > 0 ) )
    //
    s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
    //
    s = Format( s, " ", "&", " " )
    s = Format( s, executableS, " ", s1 )
    //
    s = Format( s, " ", "&", " " )
    s = Format( s, "pause" )
    //
    B = FNProgramRunGitTseOutputB( s, "s047", TRUE )
    //
   ENDIF
   //
  ENDIF
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s094" )
  //
  s = ""
  //
  PROCProgramRunPopupWindowPositionTse()
  IF ( ( Ask( "local repository where you cloned to to change to = ", s1, _EDIT_HISTORY_ ) ) AND ( Length( s1 ) > 0 ) )
   //
   PROCProgramRunPopupWindowPositionTse()
   IF ( FNMathGetNumberInputYesNoCancelPositionDefaultI( Format( directoryRepositoryOtherS, ":", " ", "Do you want to change to this other Git repository directory?" ) ) == 1 )
    //
    s1 = ""
    //
    PushPosition()
    bufferI = CreateTempBuffer()
    PopPosition()
    //
    PushPosition()
    PushBlock()
    //
    GotoBufferId( bufferI )
    //
    AddLine( GetProfileStr( sectionS, "githubRemoteDirectoryUrlS", "" ) )
    AddLine( GetProfileStr( sectionS, "gitlabRemoteDirectoryUrlS", "" ) )
    //
    GotoLine( 1 )
    PROCProgramRunPopupWindowPositionTse()
    IF List( "Choose an option", 80 )
     s1 = Trim( GetText( 1, 255 ) )
    ELSE
     quitB = TRUE
    ENDIF
    AbandonFile( bufferI )
    PopBlock()
    PopPosition()
    //
    PROCProgramRunPopupWindowPositionTse()
    IF ( ( Ask( "remote repository directory = ", githubRemoteDirectoryUrlS, _EDIT_HISTORY_ ) ) AND ( Length( githubRemoteDirectoryUrlS ) > 0 ) )
     //
     s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
     //
     s = Format( s, " ", "&", " " )
     s = Format( s, executableS, " ", "ls-remote" )
     //
     s = Format( s, " ", "&", " " )
     s = Format( s, "pause" )
     //
     B = FNProgramRunGitTseOutputB( s, "s094", TRUE )
     //
    ENDIF
   //
   ENDIF
   //
  ENDIF
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s027" )
  //
  s = ""
  //
  IF NOT FileExists( directoryRepositoryS )
   //
   PROCProgramRunPopupWindowPositionTse()
   Warn( "Run the initialize step first to create a Git repository" )
   //
  ELSE
   //
   s1 = ""
   //
   PushPosition()
   bufferI = CreateTempBuffer()
   PopPosition()
   //
   PushPosition()
   PushBlock()
   GotoBufferId( bufferI )
   //
   AddLine( GetProfileStr( sectionS, "githubRemoteDirectoryUrlS", "" ) )
   AddLine( GetProfileStr( sectionS, "gitlabRemoteDirectoryUrlS", "" ) )
   //
   GotoLine( 1 )
   PROCProgramRunPopupWindowPositionTse()
   IF List( "Choose an option", 80 )
    s1 = Trim( GetText( 1, 255 ) )
   ELSE
    quitB = TRUE
   ENDIF
   AbandonFile( bufferI )
   PopBlock()
   PopPosition()
   //
   PROCProgramRunPopupWindowPositionTse()
   IF ( ( Ask( "remote repository directory = ", githubRemoteDirectoryUrlS, _EDIT_HISTORY_ ) ) AND ( Length( githubRemoteDirectoryUrlS ) > 0 ) )
    //
    s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
    //
    s = Format( s, " ", "&", " " )
    s = Format( s, executableS, " ", "fetch", " ", githubRemoteDirectoryUrlS )
    //
    s = Format( s, " ", "&", " " )
    s = Format( s, "pause" )
    //
    B = FNProgramRunGitTseOutputB( s, "s027", TRUE )
    //
   ENDIF
   //
  ENDIF
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s028" )
  //
  s = ""
  //
  IF NOT FileExists( directoryRepositoryS )
   //
   PROCProgramRunPopupWindowPositionTse()
   Warn( "Run the initialize step first to create a Git repository" )
   //
  ELSE
   //
   s1 = ""
   //
   PushPosition()
   bufferI = CreateTempBuffer()
   PopPosition()
   //
   PushPosition()
   PushBlock()
   GotoBufferId( bufferI )
   //
   AddLine( GetProfileStr( sectionS, "githubRemoteDirectoryUrlS", "" ) )
   AddLine( GetProfileStr( sectionS, "gitlabRemoteDirectoryUrlS", "" ) )
   //
   GotoLine( 1 )
   PROCProgramRunPopupWindowPositionTse()
   IF List( "Choose an option", 80 )
    s1 = Trim( GetText( 1, 255 ) )
   ELSE
    quitB = TRUE
   ENDIF
   AbandonFile( bufferI )
   PopBlock()
   PopPosition()
   //
   PROCProgramRunPopupWindowPositionTse()
   IF ( ( Ask( "remote repository directory = ", githubRemoteDirectoryUrlS, _EDIT_HISTORY_ ) ) AND ( Length( githubRemoteDirectoryUrlS ) > 0 ) )
    //
    s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
    //
    s = Format( s, " ", "&", " " )
    s = Format( s, executableS, " ", "pull", " ", githubRemoteDirectoryUrlS ) // pull = fetch + merge
    //
    s = Format( s, " ", "&", " " )
    s = Format( s, "pause" )
    //
    B = FNProgramRunGitTseOutputB( s, "s028", TRUE )
    //
   ENDIF
   //
  ENDIF
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s029" )
  //
  s = ""
  //
  IF NOT FileExists( directoryRepositoryS )
   //
   PROCProgramRunPopupWindowPositionTse()
   Warn( "Run the initialize step first to create a Git repository" )
   //
  ELSE
   //
   s1 = ""
   //
   PushPosition()
   bufferI = CreateTempBuffer()
   PopPosition()
   //
   PushPosition()
   PushBlock()
   GotoBufferId( bufferI )
   //
   AddLine( GetProfileStr( sectionS, "githubRemoteDirectoryUrlS", "" ) )
   AddLine( GetProfileStr( sectionS, "gitlabRemoteDirectoryUrlS", "" ) )
   //
   GotoLine( 1 )
   PROCProgramRunPopupWindowPositionTse()
   IF List( "Choose an option", 80 )
    s1 = Trim( GetText( 1, 255 ) )
   ELSE
    quitB = TRUE
   ENDIF
   AbandonFile( bufferI )
   PopBlock()
   PopPosition()
   //
   PROCProgramRunPopupWindowPositionTse()
   IF ( ( Ask( "remote repository directory = ", githubRemoteDirectoryUrlS, _EDIT_HISTORY_ ) ) AND ( Length( githubRemoteDirectoryUrlS ) > 0 ) )
    //
    s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
    //
    s = Format( s, " ", "&", " " )
    s = Format( s, executableS, " ", "push", " ", githubRemoteDirectoryUrlS )
    //
    s = Format( s, " ", "&", " " )
    s = Format( s, "pause" )
    //
    B = FNProgramRunGitTseOutputB( s, "s029", TRUE )
    //
   ENDIF
   //
  ENDIF
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s072" )
  //
  s = ""
  //
  s = Format( executableS, " ", "help", " ", "--al" )
  //
  s = Format( s, " ", "&", " " )
  s = Format( s, "pause" )
  //
  B = FNProgramRunGitTseOutputB( s, "s072", TRUE )
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s073" )
  //
  s = ""
  //
  s = Format( executableS )
  //
  s = Format( s, " ", "&", " " )
  s = Format( s, "pause" )
  //
  B = FNProgramRunGitTseOutputB( s, "s073", TRUE )
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s070" )
  //
  s = ""
  //
  s = Format( executableS, " ", "help", " ", "-a" )
  //
  s = Format( s, " ", "&", " " )
  s = Format( s, "pause" )
  //
  B = FNProgramRunGitTseOutputB( s, "s070", TRUE )
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s071" )
  //
  s = ""
  //
  s = Format( executableS, " ", "help", " ", "-g" )
  //
  s = Format( s, " ", "&", " " )
  s = Format( s, "pause" )
  //
  B = FNProgramRunGitTseOutputB( s, "s071", TRUE )
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s074" )
  //
  s = ""
  //
  s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
  //
  s = Format( s, " ", "&", " " )
  s = Format( s, "tree", " ", ".git" )
  //
  s = Format( s, " ", "&", " " )
  s = Format( s, "pause" )
  //
  B = FNProgramRunGitTseOutputB( s, "s074", TRUE )
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s049" )
  //
  s = ""
  //
  s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
  //
  s = Format( s, " ", "&", " " )
  s = Format( s, executableGitGuiS )
  //
  s = Format( s, " ", "&", " " )
  s = Format( s, "pause" )
  //
  B = FNProgramRunGitTseOutputB( s, "s049", TRUE )
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s048" )
  //
  s = ""
  //
  s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
  //
  s = Format( s, " ", "&", " " )
  s = Format( s, executableGitkS )
  //
  s = Format( s, " ", "&", " " )
  s = Format( s, "pause" )
  //
  B = FNProgramRunGitTseOutputB( s, "s048", TRUE )
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s102" )
  //
  s = ""
  //
  s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
  //
  s = Format( s, " ", "&", " " )
  s = Format( s, executableSmartgitGuiS )
  //
  s = Format( s, " ", "&", " " )
  s = Format( s, "pause" )
  //
  B = FNProgramRunGitTseOutputB( s, "s102", TRUE )
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s030" )
  //
  s = ""
  //
  s = Format( executableS, " ", "remote" )
  //
  s = Format( s, " ", "&", " " )
  s = Format( s, "pause" )
  //
  B = FNProgramRunGitTseOutputB( s, "s030", TRUE )
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s031" )
  //
  s = ""
  //
  s = Format( executableS, " ", "remote", " ", "-v" )
  //
  s = Format( s, " ", "&", " " )
  s = Format( s, "pause" )
  //
  B = FNProgramRunGitTseOutputB( s, "s031", TRUE )
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s050" )
  //
  s = ""
  //
  s = directoryRepositoryS
  //
  PROCProgramRunPopupWindowPositionTse()
  Warn( s )
  //
  B = FNProgramRunGitTseOutputB( s, "s050", FALSE )
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 IF s3 == GetGlobalStr( "s100" )
  //
  s = ""
  //
  s = FNStringGetDirectoryRepositoryGitDefaultS()
  //
  PROCProgramRunPopupWindowPositionTse()
  Warn( s )
  //
  B = FNProgramRunGitTseOutputB( s, "s100", FALSE )
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s046" )
  //
  s = ""
  //
  s = executableCommandLineS
  //
  StartPgm( s )
  //
  B = FNProgramRunGitTseOutputB( s, "s046", FALSE )
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s086" )
  //
  s = ""
  //
  s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
  //
  s = Format( s, " ", "&", " " )
  s = Format( s, executableS, " ", "stash", " ", "push" )
  //
  s = Format( s, " ", "&", " " )
  s = Format( s, "pause" )
  //
  B = FNProgramRunGitTseOutputB( s, "s086", TRUE )
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s087" )
  //
  s = ""
  //
  s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
  //
  s = Format( s, " ", "&", " " )
  s = Format( s, executableS, " ", "stash", " ", "pop" )
  //
  s = Format( s, " ", "&", " " )
  s = Format( s, "pause" )
  //
  B = FNProgramRunGitTseOutputB( s, "s087", TRUE )
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s088" )
  //
  s = ""
  //
  s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
  //
  s = Format( s, " ", "&", " " )
  s = Format( s, executableS, " ", "bisect", " ", "start" )
  //
  s = Format( s, " ", "&", " " )
  s = Format( s, "pause" )
  //
  B = FNProgramRunGitTseOutputB( s, "s088", TRUE )
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s089" )
  //
  s = ""
  //
  s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
  //
  s = Format( s, " ", "&", " " )
  s = Format( s, executableS, " ", "bisect", " ", "bad" )
  //
  s = Format( s, " ", "&", " " )
  s = Format( s, "pause" )
  //
  B = FNProgramRunGitTseOutputB( s, "s089", TRUE )
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s090" )
  //
  s = ""
  //
  s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
  //
  s = Format( s, " ", "&", " " )
  s = Format( s, executableS, " ", "bisect", " ", "good" )
  //
  s = Format( s, " ", "&", " " )
  s = Format( s, "pause" )
  //
  B = FNProgramRunGitTseOutputB( s, "s090", TRUE )
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s091" )
  //
  s = ""
  //
  s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
  //
  s = Format( s, " ", "&", " " )
  s = Format( s, executableS, " ", "bisect", " ", "reset" )
  //
  s = Format( s, " ", "&", " " )
  s = Format( s, "pause" )
  //
  B = FNProgramRunGitTseOutputB( s, "s091", TRUE )
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s044" )
  //
  s1 = " "
  //
  PROCProgramRunPopupWindowPositionTse()
  IF ( ( Ask( "other branch name to merge = ", s1, _EDIT_HISTORY_ ) ) AND ( Length( s1 ) > 0 ) )
   //
   s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
   //
   s = Format( s, " ", "&", " " )
   s = Format( s, executableS, " ", "merge", " ", s1 )
   //
   s = Format( s, " ", "&", " " )
   s = Format( s, "pause" )
   //
   B = FNProgramRunGitTseOutputB( s, "s044", TRUE )
   //
  ENDIF
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s036" )
  //
  s1 = " "
  //
  PROCProgramRunPopupWindowPositionTse()
  IF ( ( Ask( "branch name to delete = ", s1, _EDIT_HISTORY_ ) ) AND ( Length( s1 ) > 0 ) )
   //
   s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
   //
   s = Format( s, " ", "&", " " )
   s = Format( s, executableS, " ", "branch", " ", "-d", " ", s1 )
   //
   s = Format( s, " ", "&", " " )
   s = Format( s, "pause" )
   //
   B = FNProgramRunGitTseOutputB( s, "s036", TRUE )
   //
  ENDIF
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s035" )
  //
  s1 = " "
  //
  PROCProgramRunPopupWindowPositionTse()
  IF ( ( Ask( "new branch name to create = ", s1, _EDIT_HISTORY_ ) ) AND ( Length( s1 ) > 0 ) )
   //
   s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
   //
   s = Format( s, " ", "&", " " )
   s = Format( s, executableS, " ", "branch", " ", s1 )
   //
   s = Format( s, " ", "&", " " )
   s = Format( s, "pause" )
   //
   B = FNProgramRunGitTseOutputB( s, "s035", TRUE )
   //
  ENDIF
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s051" )
  //
  s = ""
  //
  s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
  //
  s = Format( s, " ", "&", " " )
  s = Format( s, executableS, " ", "branch", " ", "--show-current" )
  //
  s = Format( s, " ", "&", " " )
  s = Format( s, "pause" )
  //
  B = FNProgramRunGitTseOutputB( s, "s051", TRUE )
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s052" )
  //
  s = ""
  //
  s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
  //
  s = Format( s, " ", "&", " " )
  s = Format( s, executableS, " ", "branch" )
  //
  s = Format( s, " ", "&", " " )
  s = Format( s, "pause" )
  //
  B = FNProgramRunGitTseOutputB( s, "s052", TRUE )
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s053" )
  //
  s = ""
  //
  s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
  //
  s = Format( s, " ", "&", " " )
  s = Format( s, executableS, " ", "show-branch", " ", "-a" )
  //
  s = Format( s, " ", "&", " " )
  s = Format( s, "pause" )
  //
  B = FNProgramRunGitTseOutputB( s, "s053", TRUE )
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s021" )
  //
  s1 = " "
  //
  PROCProgramRunPopupWindowPositionTse()
  IF ( ( Ask( "change to branch name = ", s1, _EDIT_HISTORY_ ) ) AND ( Length( s1 ) > 0 ) )
   //
   s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
   //
   s = Format( s, " ", "&", " " )
   s = Format( s, executableS, " ", "checkout", " ", s1 )
   //
   s = Format( s, " ", "&", " " )
   s = Format( s, "pause" )
   //
   B = FNProgramRunGitTseOutputB( s, "s021", TRUE )
   //
  ENDIF
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s076" )
  //
  s = ""
  //
  s = Format( executableS, " ", "--version" )
  //
  s = Format( s, " ", "&", " " )
  s = Format( s, "pause" )
  //
  B = FNProgramRunGitTseOutputB( s, "s076", TRUE )
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s043" )
  //
  s = ""
  //
  PushPosition()
  PushBlock()
  //
  s = QuotePath( directoryRepositoryS )
  //
  PROCProgramRunPopupWindowPositionTse()
  IF ( ( Ask( "local directory to load from = ", s, _EDIT_HISTORY_ ) ) AND ( Length( s ) > 0 ) )
   //
   s = QuotePath( s )
   //
   IF FileExists( s )
    //
    EditFile( Format( "-a -s", " ", s ) )
    //
   ELSE
    //
    PROCProgramRunPopupWindowPositionTse()
    Warn( s, ":", " ", "does not exist. Choose an existing directory. Please check." )
    //
   ENDIF
   //
   B = FNProgramRunGitTseOutputB( s, "s043", FALSE )
   //
   PopBlock()
   PopPosition()
   //
   UpDateDisplay() // IF WaitForKeyPressed( 0 ) ENDIF // Activate if using a loop
   //
  ENDIF
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s045" )
  //
  s = ""
  //
  PROCProgramRunPopupWindowPositionTse()
  IF ( ( Ask( "old filename = ", filenameOldS, _EDIT_HISTORY_ ) ) AND ( Length( filenameOldS ) > 0 ) )
   //
   PROCProgramRunPopupWindowPositionTse()
   IF ( ( Ask( "new filename = ", filenameNewS, _EDIT_HISTORY_ ) ) AND ( Length( filenameNewS ) > 0 ) )
    //
    s = Format( executableS, " ", "mv", " ", fileNameOldS, " ", fileNameNewS )
    //
    s = Format( s, " ", "&", " " )
    s = Format( s, executableS, " ", "commit", " ", "-m", " ", '"', messageS, '"' )
    //
    s = Format( s, " ", "&", " " )
    s = Format( s, "pause" )
    //
    B = FNProgramRunGitTseOutputB( s, "s045", TRUE )
    //
   ENDIF
   //
  ENDIF
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s011" )
  //
  s = ""
  //
  s = gitScmDownloadUrlS
  //
  StartPgm( s )
  //
  B = FNProgramRunGitTseOutputB( s, "s011", FALSE )
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s012" )
  //
  s = ""
  //
  PROCProgramRunPopupWindowPositionTse()
  IF ( ( Ask( "your local repository directory to initialize = ", directoryRepositoryS, _EDIT_HISTORY_ ) ) AND ( Length( directoryRepositoryS ) > 0 ) )
   //
   // check if repository directory exists, if not existing then warn and create it
   //
   IF NOT FileExists( directoryRepositoryS )
    //
    PROCProgramRunPopupWindowPositionTse()
    IF ( FNMathGetNumberInputYesNoCancelPositionDefaultI( Format( directoryRepositoryS, ":", " ", "This Git repository directory does not exist. Create it now?" ) ) == 1 )
     //
     MkDir( directoryRepositoryS )
     //
    ENDIF
    //
   ENDIF
   //
   // initialize that repository directory (it will create a hidden .git directory inside the root of that directory)
   //
   s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS, " ", "&", " ", executableS, " ", "init", " ", "-b", " ", githubNameBranchS, " ", directoryRepositoryS )
   //
   s = Format( s, " ", "&", " " )
   s = Format( s, "pause" )
   //
   B = FNProgramRunGitTseOutputB( s, "s012", TRUE )
   //
  ENDIF
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 IF s3 == GetGlobalStr( "s099" )
  //
  s = " "
  //
  PROCProgramRunPopupWindowPositionTse()
  IF ( ( Ask( "clean non-git directory to create = ", s, _EDIT_HISTORY_ ) ) AND ( Length( s ) > 0 ) )
   //
   IF NOT FileExists( s )
    //
    PROCProgramRunPopupWindowPositionTse()
    IF ( FNMathGetNumberInputYesNoCancelPositionDefaultI( Format( s, ":", " ", "This normal non-git directory does not exist. Create it now?" ) ) == 1 )
     //
     MkDir( s )
     //
    ENDIF
    //
   ENDIF
   //
   B = FNProgramRunGitTseOutputB( s, "s099", FALSE )
   //
  ENDIF
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s013" )
  //
  s = ""
  //
  PROCProgramRunPopupWindowPositionTse()
  IF ( ( Ask( "user name = ", userNameS, _EDIT_HISTORY_ ) ) AND ( Length( userNameS ) > 0 ) )
   //
   s = Format( executableS, " ", "config", " ", "--global", " ", "user.name", " ", '"', userNameS, '"' )
   //
   s = Format( s, " ", "&", " " )
   s = Format( s, "pause" )
   //
   B = FNProgramRunGitTseOutputB( s, "s013", TRUE )
   //
  ENDIF
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s014" )
  //
  s = ""
  //
  PROCProgramRunPopupWindowPositionTse()
  IF ( ( Ask( "user email = ", userEmailS, _EDIT_HISTORY_ ) ) AND ( Length( userEmailS ) > 0 ) )
   //
   s = Format( executableS, " ", "config", " ", "--global", " ", "user.email", " ", '"', userEmailS, '"' )
   //
   s = Format( s, " ", "&", " " )
   s = Format( s, "pause" )
   //
   B = FNProgramRunGitTseOutputB( s, "s014", TRUE )
   //
  ENDIF
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s010" )
  //
  s = ""
  //
  IF NOT FileExists( directoryRepositoryS )
   //
   PROCProgramRunPopupWindowPositionTse()
   Warn( "Run the initialize step first to create a Git repository" )
   //
  ELSE
   //
   PROCProgramRunPopupWindowPositionTse()
   IF ( ( Ask( "message = ", messageS, _EDIT_HISTORY_ ) ) AND ( Length( messageS ) > 0 ) )
    //
    s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
    //
    s = Format( s, " ", "&", " " )
    s = Format( s, "copy", " ", fileNameCurrentS )
    //
    s = Format( s, " ", "&", " " )
    s = Format( s, executableS, " ", "add", " ", fileNameExtensionS )
    //
    s = Format( s, " ", "&", " " )
    s = Format( s, executableS, " ", "commit", " ", "-m", " ", '"', messageS, '"', " ", fileNameExtensionS )
    //
    s = Format( s, " ", "&", " " )
    s = Format( s, "pause" )
    //
    B = FNProgramRunGitTseOutputB( s, "s010", TRUE )
   ENDIF
   //
  ENDIF
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s106" )
  //
  s = ""
  //
  IF NOT FileExists( directoryRepositoryS )
   //
   PROCProgramRunPopupWindowPositionTse()
   Warn( "Run the initialize step first to create a Git repository" )
   //
  ELSE
   //
   PROCProgramRunPopupWindowPositionTse()
   IF ( ( Ask( "message = ", messageS, _EDIT_HISTORY_ ) ) AND ( Length( messageS ) > 0 ) )
    //
    s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
    //
    s = Format( s, " ", "&", " " )
    s = Format( s, "copy", " ", fileNameCurrentS )
    //
    s = Format( s, " ", "&", " " )
    s = Format( s, executableS, " ", "add", " ", fileNameExtensionS )
    //
    s = Format( s, " ", "&", " " )
    s = Format( s, "pause" )
    //
    B = FNProgramRunGitTseOutputB( s, "s106", TRUE )
    //
   ENDIF
   //
  ENDIF
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s108" )
  //
  s = ""
  //
  IF NOT FileExists( directoryRepositoryS )
   //
   PROCProgramRunPopupWindowPositionTse()
   Warn( "Run the initialize step first to create a Git repository" )
   //
  ELSE
   //
   PROCProgramRunPopupWindowPositionTse()
   IF ( ( Ask( "fileName not to be loaded into TSE = ", fileNameOtherS, _EDIT_HISTORY_ ) ) AND ( Length( fileNameOtherS ) > 0 ) )
   //
    PROCProgramRunPopupWindowPositionTse()
    IF ( ( Ask( "message = ", messageS, _EDIT_HISTORY_ ) ) AND ( Length( messageS ) > 0 ) )
     //
     s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
     //
     s = Format( s, " ", "&", " " )
     s = Format( s, "copy", " ", QuotePath( fileNameOtherS ) )
     //
     fileNameExtensionOtherS = SplitPath( fileNameOtherS, _NAME_ | _EXT_ )
     //
     s = Format( s, " ", "&", " " )
     s = Format( s, executableS, " ", "add", " ", fileNameExtensionOtherS )
     //
     s = Format( s, " ", "&", " " )
     s = Format( s, "pause" )
     //
     B = FNProgramRunGitTseOutputB( s, "s108", TRUE )
     //
    ENDIF
    //
   ENDIF
   //
  ENDIF
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s107" )
  //
  s = ""
  //
  IF NOT FileExists( directoryRepositoryS )
   //
   PROCProgramRunPopupWindowPositionTse()
   Warn( "Run the initialize step first to create a Git repository" )
   //
  ELSE
   //
   PROCProgramRunPopupWindowPositionTse()
   IF ( ( Ask( "message = ", messageS, _EDIT_HISTORY_ ) ) AND ( Length( messageS ) > 0 ) )
    //
    s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
    //
    s = Format( s, " ", "&", " " )
    s = Format( s, "copy", " ", fileNameCurrentS )
    //
    s = Format( s, " ", "&", " " )
    s = Format( s, executableS, " ", "commit", " ", "-m", " ", '"', messageS, '"', " ", fileNameExtensionS )
    //
    s = Format( s, " ", "&", " " )
    s = Format( s, "pause" )
    //
    B = FNProgramRunGitTseOutputB( s, "s107", TRUE )
    //
   ENDIF
   //
  ENDIF
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s109" )
  //
  s = ""
  //
  IF NOT FileExists( directoryRepositoryS )
   //
   PROCProgramRunPopupWindowPositionTse()
   Warn( "Run the initialize step first to create a Git repository" )
   //
  ELSE
   //
   PROCProgramRunPopupWindowPositionTse()
   IF ( ( Ask( "fileName not to be loaded into TSE = ", fileNameOtherS, _EDIT_HISTORY_ ) ) AND ( Length( fileNameOtherS ) > 0 ) )
   //
    PROCProgramRunPopupWindowPositionTse()
    IF ( ( Ask( "message = ", messageS, _EDIT_HISTORY_ ) ) AND ( Length( messageS ) > 0 ) )
     //
     s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
     //
     s = Format( s, " ", "&", " " )
     s = Format( s, "copy", " ", QuotePath( fileNameOtherS ) )
     //
     fileNameExtensionOtherS = SplitPath( fileNameOtherS, _NAME_ | _EXT_ )
     //
     s = Format( s, " ", "&", " " )
     s = Format( s, executableS, " ", "commit", " ", "-m", " ", '"', messageS, '"', " ", fileNameExtensionOtherS )
     //
     s = Format( s, " ", "&", " " )
     s = Format( s, "pause" )
     //
     B = FNProgramRunGitTseOutputB( s, "s109", TRUE )
     //
    ENDIF
    //
   ENDIF
   //
  ENDIF
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s110" )
  //
  s = ""
  //
  IF NOT FileExists( directoryRepositoryS )
   //
   PROCProgramRunPopupWindowPositionTse()
   Warn( "Run the initialize step first to create a Git repository" )
   //
  ELSE
   //
   PROCProgramRunPopupWindowPositionTse()
   IF ( ( Ask( "fileName not to be loaded into TSE = ", fileNameOtherS, _EDIT_HISTORY_ ) ) AND ( Length( fileNameOtherS ) > 0 ) )
   //
    PROCProgramRunPopupWindowPositionTse()
    IF ( ( Ask( "message = ", messageS, _EDIT_HISTORY_ ) ) AND ( Length( messageS ) > 0 ) )
     //
     s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
     //
     s = Format( s, " ", "&", " " )
     s = Format( s, "copy", " ", QuotePath( fileNameOtherS ) )
     //
     fileNameExtensionOtherS = SplitPath( fileNameOtherS, _NAME_ | _EXT_ )
     //
     s = Format( s, " ", "&", " " )
     s = Format( s, executableS, " ", "add", " ", fileNameExtensionOtherS )
     //
     s = Format( s, " ", "&", " " )
     s = Format( s, "pause" )
     //
     s = Format( s, " ", "&", " " )
     s = Format( s, executableS, " ", "commit", " ", "-m", " ", '"', messageS, '"', " ", fileNameExtensionOtherS )
     //
     s = Format( s, " ", "&", " " )
     s = Format( s, "pause" )
     //
     B = FNProgramRunGitTseOutputB( s, "s110", TRUE )
     //
    ENDIF
    //
   ENDIF
   //
  ENDIF
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s111" )
  //
  s = ""
  //
  IF NOT FileExists( directoryRepositoryS )
   //
   PROCProgramRunPopupWindowPositionTse()
   Warn( "Run the initialize step first to create a Git repository" )
   //
  ELSE
   //
   PROCProgramRunPopupWindowPositionTse()
   IF ( ( Ask( "fileName not to be loaded into TSE = ", fileNameOtherS, _EDIT_HISTORY_ ) ) AND ( Length( fileNameOtherS ) > 0 ) )
   //
    PROCProgramRunPopupWindowPositionTse()
    IF ( ( Ask( "message = ", messageS, _EDIT_HISTORY_ ) ) AND ( Length( messageS ) > 0 ) )
     //
     s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
     //
     s = Format( s, " ", "&", " " )
     s = Format( s, "copy", " ", QuotePath( fileNameOtherS ) )
     //
     fileNameExtensionOtherS = SplitPath( fileNameOtherS, _NAME_ | _EXT_ )
     //
     s = Format( s, " ", "&", " " )
     s = Format( s, executableS, " ", "rm", " ", fileNameExtensionOtherS )
     //
     s = Format( s, " ", "&", " " )
     s = Format( s, "pause" )
     //
     s = Format( s, " ", "&", " " )
     s = Format( s, executableS, " ", "commit", " ", "-m", " ", '"', messageS, '"', " ", fileNameExtensionOtherS )
     //
     s = Format( s, " ", "&", " " )
     s = Format( s, "pause" )
     //
     B = FNProgramRunGitTseOutputB( s, "s111", TRUE )
     //
    ENDIF
    //
   ENDIF
   //
  ENDIF
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 IF s3 == GetGlobalStr( "s112" )
  //
  s = ""
  //
  IF NOT FileExists( directoryRepositoryS )
   //
   PROCProgramRunPopupWindowPositionTse()
   Warn( "Run the initialize step first to create a Git repository" )
   //
  ELSE
   //
   PROCProgramRunPopupWindowPositionTse()
   IF ( ( Ask( "fileName not to be loaded into TSE = ", fileNameOtherS, _EDIT_HISTORY_ ) ) AND ( Length( fileNameOtherS ) > 0 ) )
   //
    PROCProgramRunPopupWindowPositionTse()
    IF ( ( Ask( "message = ", messageS, _EDIT_HISTORY_ ) ) AND ( Length( messageS ) > 0 ) )
     //
     s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
     //
     s = Format( s, " ", "&", " " )
     s = Format( s, "copy", " ", QuotePath( fileNameOtherS ) )
     //
     fileNameExtensionOtherS = SplitPath( fileNameOtherS, _NAME_ | _EXT_ )
     //
     s = Format( s, " ", "&", " " )
     s = Format( s, executableS, " ", "rm", " ", "-r", " ", fileNameExtensionOtherS )
     //
     s = Format( s, " ", "&", " " )
     s = Format( s, "pause" )
     //
     s = Format( s, " ", "&", " " )
     s = Format( s, executableS, " ", "commit", " ", "-m", " ", '"', messageS, '"', " ", fileNameExtensionOtherS )
     //
     s = Format( s, " ", "&", " " )
     s = Format( s, "pause" )
     //
     B = FNProgramRunGitTseOutputB( s, "s112", TRUE )
     //
    ENDIF
    //
   ENDIF
   //
  ENDIF
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 IF s3 == GetGlobalStr( "s113" )
  //
  s = directoryDeleteOtherS
  //
  IF NOT FileExists( directoryDeleteOtherS )
   //
   PROCProgramRunPopupWindowPositionTse()
   Warn( "Run the initialize step first to create a Git repository" )
   //
  ELSE
   //
   PROCProgramRunPopupWindowPositionTse()
   IF ( ( Ask( "Directory to delete not to be loaded into TSE = ", directoryDeleteOtherS, _EDIT_HISTORY_ ) ) AND ( Length( directoryDeleteOtherS ) > 0 ) )
   //
    PROCProgramRunPopupWindowPositionTse()
    IF ( ( Ask( "message = ", messageS, _EDIT_HISTORY_ ) ) AND ( Length( messageS ) > 0 ) )
     //
     s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
     //
     s = Format( s, " ", "&", " " )
     s = Format( s, executableS, " ", "rm", " ", "-r", " ", directoryDeleteOtherS )
     //
     s = Format( s, " ", "&", " " )
     s = Format( s, "pause" )
     //
     s = Format( s, " ", "&", " " )
     s = Format( s, executableS, " ", "commit", " ", "-m", " ", '"', messageS, '"', " ", directoryDeleteOtherS )
     //
     s = Format( s, " ", "&", " " )
     s = Format( s, "pause" )
     //
     B = FNProgramRunGitTseOutputB( s, "s113", TRUE )
     //
    ENDIF
    //
   ENDIF
   //
  ENDIF
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s018" )
  //
  s = ""
  //
  s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
  //
  s = Format( s, " ", "&", " " )
  s = Format( s, executableS, " ", "push", " ", "--set-upstream", " ", githubRemoteDirectoryUrlS, " ", githubNameBranchS )
  //
  s = Format( s, " ", "&", " " )
  s = Format( s, "pause" )
  //
  B = FNProgramRunGitTseOutputB( s, "s018", TRUE )
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s019" )
  //
  s = ""
  //
  PROCProgramRunPopupWindowPositionTse()
  IF ( ( Ask( "remote repository directory = ", gitlabRemoteDirectoryUrlS, _EDIT_HISTORY_ ) ) AND ( Length( gitlabRemoteDirectoryUrlS ) > 0 ) )
   //
   PROCProgramRunPopupWindowPositionTse()
   IF ( ( Ask( "branch remote repository directory (TRUNK|main|master) = ", gitlabNameBranchS, _EDIT_HISTORY_ ) ) AND ( Length( gitlabNameBranchS ) > 0 ) )
    //
    s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
    //
    s = Format( s, " ", "&", " " )
    s = Format( s, executableS, " ", "push", " ", "--set-upstream", " ", gitlabRemoteDirectoryUrlS, " ", gitlabNameBranchS )
    //
    s = Format( s, " ", "&", " " )
    s = Format( s, "pause" )
    //
    B = FNProgramRunGitTseOutputB( s, "s019", TRUE )
    //
   ENDIF
   //
  ENDIF
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s024" )
  //
  s = ""
  //
  directoryRepositoryOtherS = " "
  //
  PROCProgramRunPopupWindowPositionTse()
  IF ( ( Ask( "other local repository directory  = ", directoryRepositoryOtherS, _EDIT_HISTORY_ ) ) AND ( Length( directoryRepositoryS ) > 0 ) )
   //
   IF NOT FileExists( directoryRepositoryOtherS )
    //
    PROCProgramRunPopupWindowPositionTse()
    IF ( FNMathGetNumberInputYesNoCancelPositionDefaultI( Format( directoryRepositoryOtherS, ":", " ", "This other Git repository directory does not exist. Create it now?" ) ) == 1 )
     //
     directoryRepositoryOtherS = QuotePath( directoryRepositoryOtherS )
     //
     MkDir( directoryRepositoryOtherS )
      //
    ENDIF
    //
   ENDIF
   //
   s1 = ""
   //
   PushPosition()
   bufferI = CreateTempBuffer()
   PopPosition()
   //
   PushPosition()
   PushBlock()
   GotoBufferId( bufferI )
   //
   AddLine( GetProfileStr( sectionS, "githubRemoteDirectoryUrlS", "" ) )
   AddLine( GetProfileStr( sectionS, "gitlabRemoteDirectoryUrlS", "" ) )
   //
   GotoLine( 1 )
   PROCProgramRunPopupWindowPositionTse()
   IF List( "Choose an option", 80 )
    s1 = Trim( GetText( 1, 255 ) )
   ELSE
    quitB = TRUE
   ENDIF
   AbandonFile( bufferI )
   PopBlock()
   PopPosition()
   //
   gitRemoteDirectoryUrlS = Quotepath( s1 )
   //
   PROCProgramRunPopupWindowPositionTse()
   IF ( ( Ask( "remote repository directory = ", gitRemoteDirectoryUrlS, _EDIT_HISTORY_ ) ) AND ( Length( gitRemoteDirectoryUrlS ) > 0 ) )
    //
    s1 = ""
    //
    PushPosition()
    bufferI = CreateTempBuffer()
    PopPosition()
    //
    PushPosition()
    PushBlock()
    GotoBufferId( bufferI )
    //
    AddLine( GetProfileStr( sectionS, "githubNameBranchS", "" ) )
    AddLine( GetProfileStr( sectionS, "gitlabNameBranchS", "" ) )
    AddLine( "main" )
    AddLine( "master" )
    AddLine( "TRUNK" )
    AddLine( "" )
    //
    GotoLine( 1 )
    PROCProgramRunPopupWindowPositionTse()
    IF List( "Choose an option", 80 )
     s1 = Trim( GetText( 1, 255 ) )
    ELSE
     quitB = TRUE
    ENDIF
    AbandonFile( bufferI )
    PopBlock()
    PopPosition()
    //
    IF NOT quitB
     //
     gitBranchRemoteDirectoryUrlS = Quotepath( s1 )
     //
     PROCProgramRunPopupWindowPositionTse()
     IF ( ( Ask( "remote repository directory = ", gitBranchRemoteDirectoryUrlS, _EDIT_HISTORY_ ) ) AND ( Length( gitBranchRemoteDirectoryUrlS ) > 0 ) )
      //
      IF EquiStr( Trim( gitBranchRemoteDirectoryUrlS ), "" )
       //
       s = Format( executableS, " ", "clone", " ", gitRemoteDirectoryUrlS, " ", gitBranchRemoteDirectoryUrlS, " ", directoryRepositoryOtherS )
       //
      ELSE
       s = Format( executableS, " ", "clone", " ", gitRemoteDirectoryUrlS, " ", "--branch", " ", gitBranchRemoteDirectoryUrlS, " ", directoryRepositoryOtherS )
       //
      ENDIF
      //
      s = Format( s, " ", "&", " " )
      s = Format( s, "pause" )
      //
      B = FNProgramRunGitTseOutputB( s, "s024", TRUE )
      //
     ENDIF
     //
    ENDIF
    //
   ENDIF
   //
  ENDIF
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s025" )
  //
  s = ""
  //
  PROCProgramRunPopupWindowPositionTse()
  Warn( "Do not use this example. When stopping it using <CTRL C> it will crash TSE. Additionally is it a very large directory, maybe 5 to 10 gigabytes" ) Halt
  //
  directoryRepositoryOtherS = " "
  //
  PROCProgramRunPopupWindowPositionTse()
  IF ( ( Ask( "other local repository directory (must be empty) = ", directoryRepositoryOtherS, _EDIT_HISTORY_ ) ) AND ( Length( directoryRepositoryS ) > 0 ) )
   //
   IF FileExists( directoryRepositoryOtherS )
    //
    PROCProgramRunPopupWindowPositionTse()
    Warn( "Make sure an empty directory should be created. It must not be an existing directory. Please check." )
    //
   ELSE
    //
    PROCProgramRunPopupWindowPositionTse()
    IF ( FNMathGetNumberInputYesNoCancelPositionDefaultI( Format( directoryRepositoryOtherS, ":", " ", "This other Git repository directory does not exist. Create it now?" ) ) == 1 )
     //
     directoryRepositoryOtherS = QuotePath( directoryRepositoryOtherS )
     //
     MkDir( directoryRepositoryOtherS )
     //
    ENDIF
    //
    s = Format( executableS, " ", "clone", " ", cloneRemoteWebSiteExampleS, " ", "", " ", directoryRepositoryOtherS ) // debug further
    //
    s = Format( s, " ", "&", " " )
    s = Format( s, "pause" )
    //
    B = FNProgramRunGitTseOutputB( s, "s025", TRUE )
    //
   ENDIF
   //
  ENDIF
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s023" )
  //
  s = ""
  //
  directoryRepositoryOtherS = " "
  //
  PROCProgramRunPopupWindowPositionTse()
  IF ( ( Ask( "local repository to copy current local repository to = ", directoryRepositoryOtherS, _EDIT_HISTORY_ ) ) AND ( Length( directoryRepositoryS ) > 0 ) )
   //
   IF NOT FileExists( directoryRepositoryOtherS )
    //
    PROCProgramRunPopupWindowPositionTse()
    IF ( FNMathGetNumberInputYesNoCancelPositionDefaultI( Format( directoryRepositoryOtherS, ":", " ", "This other Git repository directory does not exist. Create it now?" ) ) == 1 )
     //
     directoryRepositoryOtherS = QuotePath( directoryRepositoryOtherS )
     //
     MkDir( directoryRepositoryOtherS )
     //
    ENDIF
    //
   ENDIF
   //
   s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
   s = Format( s, " ", "&", " " )
   s = Format( s, executableS, " ", "clone", " ", directoryRepositoryS, " ", directoryRepositoryOtherS )
   s = Format( s, " ", "&", " " )
   s = Format( s, "pause" )
   B = FNProgramRunGitTseOutputB( s, "s023", TRUE )
   //
  ENDIF
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s037" )
  //
  s = ""
  //
  IF NOT FileExists( directoryRepositoryS )
   //
   PROCProgramRunPopupWindowPositionTse()
   Warn( "Run the initialize step first to create a Git repository" )
   //
  ELSE
   //
   PROCProgramRunPopupWindowPositionTse()
   IF ( FNMathGetNumberInputYesNoCancelPositionDefaultI( Format( fileNameExtensionS, ":", " ", "Are you sure that you want to delete and remove this file from the repository?" ) ) == 1 )
    //
    PROCProgramRunPopupWindowPositionTse()
    IF ( ( Ask( "message = ", messageS, _EDIT_HISTORY_ ) ) AND ( Length( messageS ) > 0 ) )
     //
     s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
     //
     s = Format( s, " ", "&", " " )
     s = Format( s, executableS, " ", "rm", " ", fileNameExtensionS )
     //
     s = Format( s, " ", "&", " " )
     s = Format( s, executableS, " ", "commit", " ", "-m", " ", '"', messageS, '"', " ", fileNameExtensionS )
     //
     s = Format( s, " ", "&", " " )
     s = Format( s, "pause" )
     //
     B = FNProgramRunGitTseOutputB( s, "s037", TRUE )
     //
    ENDIF
    //
   ENDIF
   //
  ENDIF
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s104" )
  //
  s = ""
  //
  IF NOT FileExists( directoryRepositoryS )
   //
   PROCProgramRunPopupWindowPositionTse()
   Warn( "Run the initialize step first to create a Git repository" )
   //
  ELSE
   //
   PROCProgramRunPopupWindowPositionTse()
   IF ( FNMathGetNumberInputYesNoCancelPositionDefaultI( Format( fileNameExtensionS, ":", " ", "Are you sure that you want to delete and remove this file from the repository?" ) ) == 1 )
    //
    PROCProgramRunPopupWindowPositionTse()
    IF ( ( Ask( "message = ", messageS, _EDIT_HISTORY_ ) ) AND ( Length( messageS ) > 0 ) )
     //
     s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
     //
     s = Format( s, " ", "&", " " )
     s = Format( s, executableS, " ", "rm", " ", "-r", " ", fileNameExtensionS )
     //
     s = Format( s, " ", "&", " " )
     s = Format( s, executableS, " ", "commit", " ", "-m", " ", '"', messageS, '"', " ", fileNameExtensionS )
     //
     s = Format( s, " ", "&", " " )
     s = Format( s, "pause" )
     //
     B = FNProgramRunGitTseOutputB( s, "s104", TRUE )
     //
    ENDIF
    //
   ENDIF
   //
  ENDIF
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s105" )
  //
  s = ""
  //
  IF NOT FileExists( directoryRepositoryS )
   //
   PROCProgramRunPopupWindowPositionTse()
   Warn( "Run the initialize step first to create a Git repository" )
   //
  ELSE
   //
   PROCProgramRunPopupWindowPositionTse()
   IF ( FNMathGetNumberInputYesNoCancelPositionDefaultI( Format( fileNameExtensionS, ":", " ", "Are you sure that you want to delete and remove this file from the repository?" ) ) == 1 )
    //
    PROCProgramRunPopupWindowPositionTse()
    IF ( ( Ask( "message = ", messageS, _EDIT_HISTORY_ ) ) AND ( Length( messageS ) > 0 ) )
     //
     s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
     //
     s = Format( s, " ", "&", " " )
     s = Format( s, executableS, " ", "rm", " ", "-r", " ", "--cached", " ",fileNameExtensionS )
     //
     s = Format( s, " ", "&", " " )
     s = Format( s, executableS, " ", "commit", " ", "-m", " ", '"', messageS, '"', " ", fileNameExtensionS )
     //
     s = Format( s, " ", "&", " " )
     s = Format( s, "pause" )
     //
     B = FNProgramRunGitTseOutputB( s, "s105", TRUE )
     //
    ENDIF
    //
   ENDIF
   //
  ENDIF
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s056" )
  //
  s = ""
  //
  IF NOT FileExists( directoryRepositoryS )
   //
   PROCProgramRunPopupWindowPositionTse()
   Warn( "Run the initialize step first to create a Git repository" )
   //
  ELSE
   //
   s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
   //
   s = Format( s, " ", "&", " " )
   s = Format( s, executableS, " ", "blame", " ", fileNameExtensionS )
   //
   s = Format( s, " ", "&", " " )
   s = Format( s, "pause" )
   //
   B = FNProgramRunGitTseOutputB( s, "s056", TRUE )
   //
  ENDIF
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s020" )
  //
  s = ""
  //
  // s = directoryRepositoryOtherS
  s = directoryRepositoryS
  //
  // necessary to give the string at least one space initialization value
  //
  IF EquiStr( Trim( s ), "" )
   s = " "
  ENDIF
  //
  PROCProgramRunPopupWindowPositionTse()
  IF ( ( Ask( "local repository to change to = ", s, _EDIT_HISTORY_ ) ) AND ( Length( s ) > 0 ) )
   //
   PROCProgramRunPopupWindowPositionTse()
   IF ( FNMathGetNumberInputYesNoCancelPositionDefaultI( Format( s, ":", " ", "Do you want to change to this other Git repository directory?" ) ) == 1 )
    //
    IF NOT FileExists( s )
     //
     PROCProgramRunPopupWindowPositionTse()
     IF ( FNMathGetNumberInputYesNoCancelPositionDefaultI( Format( s, ":", " ", "This other Git repository directory does not exist. Create it now?" ) ) == 1 )
      //
      s = QuotePath( s )
      //
      MkDir( s )
      //
     ENDIF
     //
    ENDIF
    //
    s = QuotePath( s )
    //
    WriteProfileStr( sectionS, "directoryRepositoryInS", s, iniFileNameS ) // this is now changed to your current repository directory
    //
    directoryRepositoryS = s
    //
    B = FNProgramRunGitTseOutputB( s, "s020", FALSE )
    //
   ENDIF
   //
  ENDIF
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s101" )
  //
  s = ""
  //
  s = FNStringGetDirectoryRepositoryGitDefaultS()
  //
  // necessary to give the string at least one space initialization value
  //
  IF EquiStr( Trim( s ), "" )
   s = " "
  ENDIF
  //
  PROCProgramRunPopupWindowPositionTse()
  IF ( ( Ask( "default local repository to change to = ", s, _EDIT_HISTORY_ ) ) AND ( Length( s ) > 0 ) )
   //
   PROCProgramRunPopupWindowPositionTse()
   IF ( FNMathGetNumberInputYesNoCancelPositionDefaultI( Format( s, ":", " ", "Do you want to change to this other default Git repository directory?" ) ) == 1 )
    //
    IF NOT FileExists( s )
     //
     PROCProgramRunPopupWindowPositionTse()
     IF ( FNMathGetNumberInputYesNoCancelPositionDefaultI( Format( s, ":", " ", "This other default Git repository directory does not exist. Create it now?" ) ) == 1 )
      //
      s = QuotePath( s )
      //
      MkDir( s )
      //
     ENDIF
     //
    ENDIF
    //
    s = QuotePath( s )
    //
    // WriteProfileStr( sectionS, "directoryRepositoryDefaultS", s, iniFileNameS ) // this is now changed to your current repository directory
    WriteProfileStr( sectionS, "directoryRepositoryInS", s, iniFileNameS ) // this is now changed to your current repository directory
    //
    B = FNProgramRunGitTseOutputB( s, "s101", FALSE )
    //
    directoryRepositoryS = s
    //
   ENDIF
   //
  ENDIF
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s085" )
  //
  s = ""
  //
  IF NOT FileExists( directoryRepositoryS )
   //
   PROCProgramRunPopupWindowPositionTse()
   Warn( "Run the initialize step first to create a Git repository" )
   //
  ELSE
   //
   s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
   //
   s = Format( s, " ", "&", " " )
   s = Format( s, executableS, " ", "reset", " ", "HEAD", " ", fileNameExtensionS )
   //
   s = Format( s, " ", "&", " " )
   s = Format( s, "pause" )
   //
   B = FNProgramRunGitTseOutputB( s, "s085", TRUE )
   //
  ENDIF
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s078" )
  //
  s = ""
  //
  IF NOT FileExists( directoryRepositoryS )
   //
   PROCProgramRunPopupWindowPositionTse()
   Warn( "Run the initialize step first to create a Git repository" )
   //
  ELSE
   //
   PROCProgramRunPopupWindowPositionTse()
   IF ( FNMathGetNumberInputYesNoCancelPositionDefaultI( "Are you really sure you want to overwrite and replace the current version with an older version?" ) == 1 )
    //
    s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
    //
    s = Format( s, " ", "&", " " )
    s = Format( s, executableS, " ", "checkout", " ", "HEAD~6", " ", "--", " ", fileNameExtensionS )
    //
    s = Format( s, " ", "&", " " )
    s = Format( s, "pause" )
    B = FNProgramRunGitTseOutputB( s, "s078", TRUE )
    //
   ENDIF
   //
  ENDIF
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s079" )
  //
  s = ""
  //
  IF NOT FileExists( directoryRepositoryS )
   //
   PROCProgramRunPopupWindowPositionTse()
   Warn( "Run the initialize step first to create a Git repository" )
   //
  ELSE
   //
   PROCProgramRunPopupWindowPositionTse()
   IF ( FNMathGetNumberInputYesNoCancelPositionDefaultI( "Are you really sure you want to overwrite and replace the current version with an older version?" ) == 1 )
    //
    s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
    //
    s = Format( s, " ", "&", " " )
    s = Format( s, executableS, " ", "checkout", " ", "HEAD~2", " ", "--", " ", fileNameExtensionS )
    //
    s = Format( s, " ", "&", " " )
    s = Format( s, "pause" )
    //
    B = FNProgramRunGitTseOutputB( s, "s079", TRUE )
    //
   ENDIF
   //
  ENDIF
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s080" )
  //
  s = ""
  //
  IF NOT FileExists( directoryRepositoryS )
   //
   PROCProgramRunPopupWindowPositionTse()
   Warn( "Run the initialize step first to create a Git repository" )
   //
  ELSE
   //
   PROCProgramRunPopupWindowPositionTse()
   IF ( FNMathGetNumberInputYesNoCancelPositionDefaultI( "Are you really sure you want to overwrite and replace the current version with an older version?" ) == 1 )
    //
    s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
    //
    s = Format( s, " ", "&", " " )
    s = Format( s, executableS, " ", "checkout", " ", "HEAD~3", " ", "--", " ", fileNameExtensionS )
    //
    s = Format( s, " ", "&", " " )
    s = Format( s, "pause" )
    //
    B = FNProgramRunGitTseOutputB( s, "s080", TRUE )
    //
   ENDIF
   //
  ENDIF
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s081" )
  //
  s = ""
  //
  IF NOT FileExists( directoryRepositoryS )
   //
   PROCProgramRunPopupWindowPositionTse()
   Warn( "Run the initialize step first to create a Git repository" )
   //
  ELSE
   //
   PROCProgramRunPopupWindowPositionTse()
   IF ( FNMathGetNumberInputYesNoCancelPositionDefaultI( "Are you really sure you want to overwrite and replace the current version with an older version?" ) == 1 )
    //
    s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
    //
    s = Format( s, " ", "&", " " )
    s = Format( s, executableS, " ", "checkout", " ", "HEAD~4", " ", "--", " ", fileNameExtensionS )
    //
    s = Format( s, " ", "&", " " )
    s = Format( s, "pause" )
    //
    B = FNProgramRunGitTseOutputB( s, "s081", TRUE )
    //
   ENDIF
   //
  ENDIF
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s082" )
  //
  s = ""
  //
  IF NOT FileExists( directoryRepositoryS )
   //
   PROCProgramRunPopupWindowPositionTse()
   Warn( "Run the initialize step first to create a Git repository" )
   //
  ELSE
   //
   PROCProgramRunPopupWindowPositionTse()
   IF ( FNMathGetNumberInputYesNoCancelPositionDefaultI( "Are you really sure you want to overwrite and replace the current version with an older version?" ) == 1 )
    //
    s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
    //
    s = Format( s, " ", "&", " " )
    s = Format( s, executableS, " ", "checkout", " ", "HEAD~5", " ", "--", " ", fileNameExtensionS )
    //
    s = Format( s, " ", "&", " " )
    s = Format( s, "pause" )
    //
    B = FNProgramRunGitTseOutputB( s, "s082", TRUE )
    //
   ENDIF
   //
  ENDIF
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s083" )
  //
  s = ""
  //
  IF NOT FileExists( directoryRepositoryS )
   //
   PROCProgramRunPopupWindowPositionTse()
   Warn( "Run the initialize step first to create a Git repository" )
   //
  ELSE
   //
   PROCProgramRunPopupWindowPositionTse()
   IF ( FNMathGetNumberInputYesNoCancelPositionDefaultI( "Are you really sure you want to overwrite and replace the current version with an older version?" ) == 1 )
    //
    s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
    //
    s = Format( s, " ", "&", " " )
    s = Format( s, executableS, " ", "checkout", " ", "HEAD~6", " ", "--", " ", fileNameExtensionS )
    //
    s = Format( s, " ", "&", " " )
    s = Format( s, "pause" )
    //
    B = FNProgramRunGitTseOutputB( s, "s083", TRUE )
    //
   ENDIF
   //
  ENDIF
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s084" )
  //
  s = ""
  //
  IF NOT FileExists( directoryRepositoryS )
   //
   PROCProgramRunPopupWindowPositionTse()
   Warn( "Run the initialize step first to create a Git repository" )
   //
  ELSE
   //
   PROCProgramRunPopupWindowPositionTse()
   IF ( FNMathGetNumberInputYesNoCancelPositionDefaultI( "Are you really sure you want to overwrite and replace the current version with an older version?" ) == 1 )
    //
    s1 = "7"
    //
    PROCProgramRunPopupWindowPositionTse()
    IF ( ( Ask( "N = ", s1, _EDIT_HISTORY_ ) ) AND ( Length( s1 ) > 0 ) )
     //
     s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
     //
     s = Format( s, " ", "&", " " )
     s = Format( s, executableS, " ", "checkout", " ", "HEAD~", s1, " ", "--", " ", fileNameExtensionS )
     //
     s = Format( s, " ", "&", " " )
     s = Format( s, "pause" )
     //
     B = FNProgramRunGitTseOutputB( s, "s084", TRUE )
    ENDIF
    //
   ENDIF
   //
  ENDIF
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s058" )
  //
  s = ""
  //
  IF NOT FileExists( directoryRepositoryS )
   //
   PROCProgramRunPopupWindowPositionTse()
   Warn( "Run the initialize step first to create a Git repository" )
   //
  ELSE
   //
   s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
   //
   s = Format( s, " ", "&", " " )
   s = Format( s, executableS, " ", "diff", " ", "HEAD~1", " ", fileNameExtensionS )
   //
   s = Format( s, " ", "&", " " )
   s = Format( s, "pause" )
   //
   B = FNProgramRunGitTseOutputB( s, "s058", TRUE )
   //
  ENDIF
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s059" )
  //
  s = ""
  //
  IF NOT FileExists( directoryRepositoryS )
   //
   PROCProgramRunPopupWindowPositionTse()
   Warn( "Run the initialize step first to create a Git repository" )
   //
  ELSE
   //
   s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
   //
   s = Format( s, " ", "&", " " )
   s = Format( s, executableS, " ", "diff", " ", "HEAD~2", " ", fileNameExtensionS )
   //
   s = Format( s, " ", "&", " " )
   s = Format( s, "pause" )
   //
   B = FNProgramRunGitTseOutputB( s, "s059", TRUE )
   //
  ENDIF
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s060" )
  //
  s = ""
  //
  IF NOT FileExists( directoryRepositoryS )
   //
   PROCProgramRunPopupWindowPositionTse()
   Warn( "Run the initialize step first to create a Git repository" )
   //
  ELSE
   //
   s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
   //
   s = Format( s, " ", "&", " " )
   s = Format( s, executableS, " ", "diff", " ", "HEAD~3", " ", fileNameExtensionS )
   //
   s = Format( s, " ", "&", " " )
   s = Format( s, "pause" )
   //
   B = FNProgramRunGitTseOutputB( s, "s060", TRUE )
   //
  ENDIF
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s061" )
  //
  s = ""
  //
  IF NOT FileExists( directoryRepositoryS )
   //
   PROCProgramRunPopupWindowPositionTse()
   Warn( "Run the initialize step first to create a Git repository" )
   //
  ELSE
   //
   s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
   //
   s = Format( s, " ", "&", " " )
   s = Format( s, executableS, " ", "diff", " ", "HEAD~4", " ", fileNameExtensionS )
   //
   s = Format( s, " ", "&", " " )
   s = Format( s, "pause" )
   //
   B = FNProgramRunGitTseOutputB( s, "s061", TRUE )
   //
  ENDIF
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s062" )
  //
  s = ""
  //
  IF NOT FileExists( directoryRepositoryS )
   //
   PROCProgramRunPopupWindowPositionTse()
   Warn( "Run the initialize step first to create a Git repository" )
   //
  ELSE
   //
   s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
   //
   s = Format( s, " ", "&", " " )
   s = Format( s, executableS, " ", "diff", " ", "HEAD~5", " ", fileNameExtensionS )
   //
   s = Format( s, " ", "&", " " )
   s = Format( s, "pause" )
   //
   B = FNProgramRunGitTseOutputB( s, "s062", TRUE )
   //
  ENDIF
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s063" )
  //
  s = ""
  //
  IF NOT FileExists( directoryRepositoryS )
   //
   PROCProgramRunPopupWindowPositionTse()
   Warn( "Run the initialize step first to create a Git repository" )
   //
  ELSE
   //
   s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
   //
   s = Format( s, " ", "&", " " )
   s = Format( s, executableS, " ", "diff", " ", "HEAD~6", " ", fileNameExtensionS )
   //
   s = Format( s, " ", "&", " " )
   s = Format( s, "pause" )
   //
   B = FNProgramRunGitTseOutputB( s, "s063", TRUE )
   //
  ENDIF
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s064" )
  //
  s = ""
  //
  IF NOT FileExists( directoryRepositoryS )
   //
   PROCProgramRunPopupWindowPositionTse()
   Warn( "Run the initialize step first to create a Git repository" )
   //
  ELSE
   //
   s1 = "7"
   //
   PROCProgramRunPopupWindowPositionTse()
   IF ( ( Ask( "N = ", s1, _EDIT_HISTORY_ ) ) AND ( Length( s1 ) > 0 ) )
    //
    s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
    //
    s = Format( s, " ", "&", " " )
    s = Format( s, executableS, " ", "diff", " ", "HEAD~", s1, " ", fileNameExtensionS )
    //
    s = Format( s, " ", "&", " " )
    s = Format( s, "pause" )
    //
    B = FNProgramRunGitTseOutputB( s, "s064", TRUE )
    //
   ENDIF
   //
  ENDIF
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s065" )
  //
  s = ""
  //
  IF NOT FileExists( directoryRepositoryS )
   //
   PROCProgramRunPopupWindowPositionTse()
   Warn( "Run the initialize step first to create a Git repository" )
   //
  ELSE
   //
   s1 = "2"
   //
   s2 = "3"
   //
   PROCProgramRunPopupWindowPositionTse()
   IF ( ( Ask( "M = ", s1, _EDIT_HISTORY_ ) ) AND ( Length( s1 ) > 0 ) )
    //
    PROCProgramRunPopupWindowPositionTse()
    IF ( ( Ask( "N = ", s2, _EDIT_HISTORY_ ) ) AND ( Length( s2 ) > 0 ) )
     //
     s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
     //
     s = Format( s, " ", "&", " " )
     s = Format( s, executableS, " ", "diff", " ", "HEAD~", s1, " ", "HEAD~", s2, " ", fileNameExtensionS )
     //
     s = Format( s, " ", "&", " " )
     s = Format( s, "pause" )
     //
     B = FNProgramRunGitTseOutputB( s, "s065", TRUE )
     //
    ENDIF
    //
   ENDIF
   //
  ENDIF
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s057" )
  //
  s = ""
  //
  IF NOT FileExists( directoryRepositoryS )
   //
   PROCProgramRunPopupWindowPositionTse()
   Warn( "Run the initialize step first to create a Git repository" )
   //
  ELSE
   //
   s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
   //
   s = Format( s, " ", "&", " " )
   s = Format( s, executableS, " ", "diff", " ", fileNameExtensionS )
   //
   s = Format( s, " ", "&", " " )
   s = Format( s, "pause" )
   //
   B = FNProgramRunGitTseOutputB( s, "s057", TRUE )
   //
  ENDIF
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s067" )
  //
  s = ""
  //
  IF NOT FileExists( directoryRepositoryS )
   //
   PROCProgramRunPopupWindowPositionTse()
   Warn( "Run the initialize step first to create a Git repository" )
   //
  ELSE
   //
   s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
   //
   s = Format( s, " ", "&", " " )
   s = Format( s, executableS, " ", "log", " ", "--oneline" )
   //
   s = Format( s, " ", "&", " " )
   s = Format( s, "pause" )
   //
   B = FNProgramRunGitTseOutputB( s, "s067", TRUE )
   //
  ENDIF
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s066" )
  //
  s = ""
  //
  IF NOT FileExists( directoryRepositoryS )
   //
   PROCProgramRunPopupWindowPositionTse()
   Warn( "Run the initialize step first to create a Git repository" )
   //
  ELSE
   //
   s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
   //
   s = Format( s, " ", "&", " " )
   s = Format( s, executableS, " ", "log" )
   //
   s = Format( s, " ", "&", " " )
   s = Format( s, "pause" )
   //
   B = FNProgramRunGitTseOutputB( s, "s066", TRUE )
   //
  ENDIF
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s068" )
  //
  s = ""
  //
  IF NOT FileExists( directoryRepositoryS )
   //
   PROCProgramRunPopupWindowPositionTse()
   Warn( "Run the initialize step first to create a Git repository" )
   //
  ELSE
   //
   s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
   //
   s = Format( s, " ", "&", " " )
   s = Format( s, executableS, " ", "show" )
   //
   s = Format( s, " ", "&", " " )
   s = Format( s, "pause" )
   //
   B = FNProgramRunGitTseOutputB( s, "s068", TRUE )
   //
  ENDIF
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s069" )
  //
  s = ""
  //
  IF NOT FileExists( directoryRepositoryS )
   //
   PROCProgramRunPopupWindowPositionTse()
   Warn( "Run the initialize step first to create a Git repository" )
   //
  ELSE
   //
   s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
   //
   s = Format( s, " ", "&", " " )
   s = Format( s, executableS, " ", "status" )
   //
   s = Format( s, " ", "&", " " )
   s = Format( s, "pause" )
   //
   B = FNProgramRunGitTseOutputB( s, "s069", TRUE )
   //
  ENDIF
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s041" )
  //
  s = ""
  //
  s = githubRemoteDirectoryUrlS
  //
  StartPgm( s )
  //
  B = FNProgramRunGitTseOutputB( s, "s041", FALSE )
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s042" )
  //
  s = ""
  //
  s = gitlabRemoteDirectoryUrlS
  //
  StartPgm( s )
  //
  B = FNProgramRunGitTseOutputB( s, "s042", FALSE )
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 //
 IF s3 == GetGlobalStr( "s095" )
  //
  s = ""
  //
  s = GetProfileStr( sectionS, "githubRemoteDirectoryCreateUrlS", "", iniFileNameS )
  //
  StartPgm( s )
  //
  B = FNProgramRunGitTseOutputB( s, "s095", FALSE )
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s096" )
  //
  s = ""
  //
  s = GetProfileStr( sectionS, "gitlabRemoteDirectoryCreateUrlS", "", iniFileNameS )
  //
  StartPgm( s )
  //
  B = FNProgramRunGitTseOutputB( s, "s096", FALSE )
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s022" )
  //
  s = ""
  //
  s = Format( "changeFileB", " ", "=", " ", "TRUE" )
  //
  PROCProgramRunPopupWindowPositionTse()
  IF ( EditFile() )
   //
   UpDateDisplay() // IF WaitForKeyPressed( 0 ) ENDIF // Activate if using a loop
   //
   changeFileB = TRUE
   //
   KillPosition()
   //
  ENDIF
  //
  B = FNProgramRunGitTseOutputB( s, "s022", FALSE )
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s015" )
  //
  s = ""
  //
  s = Format( "EditFile", "(", " ", iniFileNameS, " ", ")" )
  //
  PushPosition()
  PushBlock()
  //
  IF EditFile( iniFileNameS )
   //
   QuitFile()
   //
  ENDIF
  //
  EditFile( iniFileNameS )
  //
  IF LFind( sectionS, "" )
   //
   ScrollToTop()
   //
  ELSE
   //
   PROCProgramRunPopupWindowPositionTse()
   Warn( "no expected session", ":", " ", "[", sectionS, "]", " ", "found in", iniFileNameS, ". Please add it + add the parameters" )
   //
  ENDIF
  //
  UpDateDisplay() // IF WaitForKeyPressed( 0 ) ENDIF // Activate if using a loop
  //
  B = FNProgramRunGitTseOutputB( s, "s015", FALSE )
  //
  PROCProgramRunGitTsePause()
  //
  PopBlock()
  PopPosition()
  //
  UpDateDisplay() // IF WaitForKeyPressed( 0 ) ENDIF // Activate if using a loop
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s040" )
  //
  s = ""
  //
  s = Format( "EditFile", "(", " ", directoryRepositoryS, " ", ")" )
  //
  PushPosition()
  PushBlock()
  //
  EditFile( directoryRepositoryS )
  //
  B = FNProgramRunGitTseOutputB( s, "s040", FALSE )
  //
  PROCProgramRunGitTsePause()
  //
  PopBlock()
  PopPosition()
  //
  UpDateDisplay() // IF WaitForKeyPressed( 0 ) ENDIF // Activate if using a loop
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s055" )
  //
  s = ""
  //
  PushPosition()
  PushBlock()
  //
  s = QuotePath( Format( AddTrailingSlash( directoryRepositoryS ), ".gitignore" ) )
  //
  IF EditFile( s )
   //
   QuitFile()
   EditFile( s )
   //
  ELSE
   //
   PROCProgramRunPopupWindowPositionTse()
   IF ( FNMathGetNumberInputYesNoCancelPositionDefaultI( Format( "File", ":", " ", s, " ", "not found. Do you want to create it?" ) ) == 1 )
    //
    EditFile( s )
    //
    SaveFile()
    //
   ENDIF
   //
  ENDIF
  //
  UpDateDisplay() // IF WaitForKeyPressed( 0 ) ENDIF // Activate if using a loop
  //
  B = FNProgramRunGitTseOutputB( s, "s055", FALSE )
  //
  // do not replace this, there should always be waited here
  //
  PROCProgramRunPopupWindowPositionTse()
  Warn( "<Press any key to continue>" )
  //
  PopBlock()
  PopPosition()
  //
  UpDateDisplay() // IF WaitForKeyPressed( 0 ) ENDIF // Activate if using a loop
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s054" )
  //
  s = ""
  //
  PushPosition()
  PushBlock()
  //
  s = QuotePath( Format( AddTrailingSlash( directoryRepositoryS ), ".git\config" ) )
  //
  IF EditFile( s )
   //
   QuitFile()
   EditFile( s )
   //
   B = FNProgramRunGitTseOutputB( s, "s054", FALSE )
   //
  ELSE
   //
   PROCProgramRunPopupWindowPositionTse()
   Warn( "File", ":", " ", s, " ", "not found. Please check." )
   //
   B = FNProgramRunGitTseOutputB( Format( "File", ":", " ", s, " ", "not found." ), "s054", FALSE )
   //
  ENDIF
  //
  UpDateDisplay() // IF WaitForKeyPressed( 0 ) ENDIF // Activate if using a loop
  //
  // do not replace this, there should always be waited here
  //
  PROCProgramRunPopupWindowPositionTse()
  Warn( "<Press any key to continue>" )
  //
  PopBlock()
  PopPosition()
  //
  UpDateDisplay() // IF WaitForKeyPressed( 0 ) ENDIF // Activate if using a loop
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s092" )
  //
  s = ""
  //
  PushPosition()
  PushBlock()
  //
  s = QuotePath( Format( "c:\", AddTrailingSlash( GetEnvStr( "HOMEPATH" ) ), ".gitconfig" ) )
  //
  IF EditFile( s )
   //
   QuitFile()
   EditFile( s )
   //
   B = FNProgramRunGitTseOutputB( s, "s092", FALSE )
   //
  ELSE
   //
   PROCProgramRunPopupWindowPositionTse()
   Warn( "File", ":", " ", s, " ", "not found. Please check." )
   //
   B = FNProgramRunGitTseOutputB( Format( "File", ":", " ", s, " ", "not found." ), "s092", FALSE )
   //
  ENDIF
  //
  UpDateDisplay() // IF WaitForKeyPressed( 0 ) ENDIF // Activate if using a loop
  //
  // do not replace this, there should always be waited here
  //
  PROCProgramRunPopupWindowPositionTse()
  Warn( "<Press any key to continue>" )
  //
  PopBlock()
  PopPosition()
  //
  UpDateDisplay() // IF WaitForKeyPressed( 0 ) ENDIF // Activate if using a loop
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s075" )
  //
  s = ""
  //
  PushPosition()
  PushBlock()
  //
  s = gitLogFileS
  //
  IF EditFile( s )
   //
   QuitFile()
   EditFile( s )
   EndFile() // new [kn, ri, mo, 21-11-2022 04:24:47]
   BegLine() // new [kn, ri, mo, 21-11-2022 12:13:49]
   //
  ELSE
   //
   PROCProgramRunPopupWindowPositionTse()
   Warn( "File", ":", " ", s, " ", "not found. Please check." )
   //
  ENDIF
  //
  UpDateDisplay() // IF WaitForKeyPressed( 0 ) ENDIF // Activate if using a loop
  //
  B = FNProgramRunGitTseOutputB( s, "s075", FALSE )
  //
  // do not replace this, there should always be waited here
  //
  PROCProgramRunPopupWindowPositionTse()
  Warn( "<Press any key to continue>" )
  //
  PopBlock()
  PopPosition()
  //
  UpDateDisplay() // IF WaitForKeyPressed( 0 ) ENDIF // Activate if using a loop
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s093" )
  //
  s = ""
  //
  PushPosition()
  PushBlock()
  //
  s = Format( AddTrailingSlash( GetProfileStr( sectionS, "directoryExecutableS", "", iniFileNameS ) ), "git.exe" )
  //
  PROCProgramRunPopupWindowPositionTse()
  Warn( s )
  //
  B = FNProgramRunGitTseOutputB( s, "s093", FALSE )
  //
  PopBlock()
  PopPosition()
  //
  UpDateDisplay() // IF WaitForKeyPressed( 0 ) ENDIF // Activate if using a loop
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s026" )
  //
  s = ""
  //
  IF NOT FileExists( directoryRepositoryS )
   //
   PROCProgramRunPopupWindowPositionTse()
   Warn( "Run the initialize step first to create a Git repository" )
   //
  ELSE
   //
   s1 = " "
   //
   s2 = " "
   //
   PROCProgramRunPopupWindowPositionTse()
   IF ( ( Ask( "From directory = ", s1, _EDIT_HISTORY_ ) ) AND ( Length( s1 ) > 0 ) )
    //
    PROCProgramRunPopupWindowPositionTse()
    IF ( ( Ask( "To directory = ", s2, _EDIT_HISTORY_ ) ) AND ( Length( s2 ) > 0 ) )
     //
     // s = Format( "copy", " ", "/s", " ", "/h", " ", s1, " ", s2 ) // only works in JPSoft TakeCommand or JPSoft tcc.exe
     s = Format( "xcopy", " ", "/s", " ", "/h", " ", s1, " ", s2 )
     //
     s = Format( s, " ", "&", " " )
     s = Format( s, "pause" )
     //
     B = FNProgramRunGitTseOutputB( s, "s026", TRUE )
     //
    ENDIF
    //
   ENDIF
   //
  ENDIF
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s034" )
  //
  s = ""
  //
  IF NOT FileExists( directoryRepositoryS )
   //
   PROCProgramRunPopupWindowPositionTse()
   Warn( "Run the initialize step first to create a Git repository" )
   //
  ELSE
   //
   s1 = " "
   //
   s2 = " "
   //
   PROCProgramRunPopupWindowPositionTse()
   IF ( ( Ask( "old alias name = ", s1, _EDIT_HISTORY_ ) ) AND ( Length( s1 ) > 0 ) )
    //
    PROCProgramRunPopupWindowPositionTse()
    IF ( ( Ask( "new alias name = ", s2, _EDIT_HISTORY_ ) ) AND ( Length( s2 ) > 0 ) )
     //
     s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
     //
     s = Format( s, " ", "&", " " )
     s = Format( s, executableS, " ", "remote", " ", "rename", " ", s1, " ", s2 )
     //
     s = Format( s, " ", "&", " " )
     s = Format( s, "pause" )
     //
     B = FNProgramRunGitTseOutputB( s, "s034", TRUE )
     //
    ENDIF
    //
   ENDIF
   //
  ENDIF
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s032" )
  //
  s = ""
  //
  IF NOT FileExists( directoryRepositoryS )
   //
   PROCProgramRunPopupWindowPositionTse()
   Warn( "Run the initialize step first to create a Git repository" )
   //
  ELSE
   //
   s1 = " "
   //
   s2 = githubRemoteDirectoryUrlS
   //
   PROCProgramRunPopupWindowPositionTse()
   IF ( ( Ask( "alias name = ", s1, _EDIT_HISTORY_ ) ) AND ( Length( s1 ) > 0 ) )
    //
    PROCProgramRunPopupWindowPositionTse()
    IF ( ( Ask( "url = ", s2, _EDIT_HISTORY_ ) ) AND ( Length( s2 ) > 0 ) )
     //
     s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
     //
     s = Format( s, " ", "&", " " )
     s = Format( s, executableS, " ", "remote", " ", "add", " ", s1, " ", s2 )
     //
     s = Format( s, " ", "&", " " )
     s = Format( s, "pause" )
     //
     B = FNProgramRunGitTseOutputB( s, "s032", TRUE )
     //
    ENDIF
   //
   ENDIF
   //
  ENDIF
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s033" )
  //
  s = ""
  //
  IF NOT FileExists( directoryRepositoryS )
   //
   PROCProgramRunPopupWindowPositionTse()
   Warn( "Run the initialize step first to create a Git repository" )
   //
  ELSE
   //
   s1 = " "
   //
   PROCProgramRunPopupWindowPositionTse()
   IF ( ( Ask( "alias name = ", s1, _EDIT_HISTORY_ ) ) AND ( Length( s1 ) > 0 ) )
    //
    s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
    //
    s = Format( s, " ", "&", " " )
    s = Format( s, executableS, " ", "remote", " ", "rm", " ", s1 )
    //
    s = Format( s, " ", "&", " " )
    s = Format( s, "pause" )
    //
    B = FNProgramRunGitTseOutputB( s, "s033", TRUE )
    //
   ENDIF
   //
  ENDIF
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s098" )
  //
  s = ""
  //
  IF NOT FileExists( directoryRepositoryS )
   //
   PROCProgramRunPopupWindowPositionTse()
   Warn( "Run the initialize step first to create a Git repository" )
   //
  ELSE
   //
   s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
   //
   s = Format( s, " ", "&", " " )
   s = Format( s, executableS, " ", "clean", " ", "-n" )
   //
   s = Format( s, " ", "&", " " )
   s = Format( s, "pause" )
   //
   B = FNProgramRunGitTseOutputB( s, "s098", TRUE )
   //
  ENDIF
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 // OTHERWISE
 //  //
 //  PROCProgramRunPopupWindowPositionTse()
 //  Warn( "FNFileSaveFileVersionControlGitCaseB(", " ", "case", " ", ":", " ", caseS, ": not known" )
 //  //
 //  B = FALSE
 //
 PopBlock()
 IF NOT changeFileB
  PopPosition()
 ENDIF
 //
 RETURN( B )
 //
END

// library: string: get: word: token: get: rest: FNCdr(): Get a string, without the first word (words delimited by a space " " (=space delimited list)). E.g. Message( FNStringGetCarS( "Knud is the best" ) ) gives "Knud" // <description></description> <version control></version control> <version>1.0.0.0.3</version> (filenamemacro=getstgcd.s) [<Program>] [<Research>] [kn, ni, su, 02-08-1998 15:54:17]
STRING PROC FNStringGetCdrS( STRING s )
 // e.g. PROC Main()
 // e.g.  STRING s1[255] = FNStringGetInitializeNewStringS()
 // e.g.  s1 = FNStringGetInputS( "string: get: word: token: get: rest: s = ", "this is a test" )
 // e.g.  IF FNKeyCheckPressEscapeB( s1 ) RETURN() ENDIF
 // e.g.  Message( FNStringGetCdrS( s1 ) ) // gives e.g. "is a test"
 // e.g. END
 // e.g.
 // e.g. <F12> Main()
 //
 RETURN( FNStringGetSpaceRemoveBeginS( FNStringGetDeleteWordFrontS( FNStringGetSpaceRemoveBeginS( s ), FNStringGetCarS( s ) ) ) ) // Remove trailing spaces, determine the First word. Delete the first word (=FNCarS), and finally remove the trailing spaces from the result
 //
END

// library: program: run: git: tse: pause <description></description> <version control></version control> <version>1.0.0.0.5</version> <version control></version control> (filenamemacro=runprtpa.s) [<Program>] [<Research>] [kn, ri, sa, 26-11-2022 21:26:59]
PROC PROCProgramRunGitTsePause()
 // e.g. //
 // e.g. STRING iniFileNameGS[255] = ".\git_tse.ini"
 // e.g. //
 // e.g. PROC Main()
 // e.g.  PROCProgramRunGitTsePause()
 // e.g. END
 // e.g.
 // e.g. <F12> Main()
 //
 // ===
 //
 // Use case =
 //
 // ===
 //
 // ===
 //
 // Method =
 //
 // ===
 //
 // ===
 //
 // Example:
 //
 // Input:
 //
 /*
--- cut here: begin --------------------------------------------------
--- cut here: end ----------------------------------------------------
 */
 //
 // Output:
 //
 /*
--- cut here: begin --------------------------------------------------
--- cut here: end ----------------------------------------------------
 */
 //
 // ===
 //
 // e.g. // QuickHelp( HELPDEFPROCProgramRunGitTsePause )
 // e.g. HELPDEF HELPDEFPROCProgramRunGitTsePause
 // e.g.  title = "PROCProgramRunGitTsePause() help" // The help's caption
 // e.g.  x = 100 // Location
 // e.g.  y = 3 // Location
 // e.g.  //
 // e.g.  // The actual help text
 // e.g.  //
 // e.g.  "Usage:"
 // e.g.  "//"
 // e.g.  "1. Run this TSE macro"
 // e.g.  "2. Then press <CtrlAlt F1> to show this help."
 // e.g.  "3. Press <Shift Escape> to quit."
 // e.g.  "//"
 // e.g.  ""
 // e.g.  "Key: Definitions:"
 // e.g.  ""
 // e.g.  "<> = do something"
 // e.g. END
 //
 INTEGER B = FALSE
 //
 STRING caseS[255] = ""
 //
 STRING iniFileNameS[255] = GetGlobalStr( "iniFileNameS" )
 //
 STRING sectionS[255] = GetGlobalStr( "sectionS" )
 //
 STRING pauseS[255] = GetProfileStr( sectionS, "pauseS", "", iniFilenameS  )
 //
 IF EquiStr( Trim( sectionS ), "" )
  //
  Warn( 'Please first set your SetGlobalStr( "sectionS" ) in file git_tse.s' )
  //
  RETURN()
  //
 ENDIF
 //
 caseS = sectionS
 //
 CASE caseS
  //
  WHEN "git_tse"
   //
   IF EquiStr( pauseS, "true" )
    //
    PROCProgramRunPopupWindowPositionTse()
    Warn( "<Press 'Q' to quit>" )
    //
   ENDIF
   //
  WHEN "git_tse_knud"
   //
   IF EquiStr( pauseS, "true" )
    //
    PROCProgramRunPopupWindowPositionTse()
    Warn( "<Press 'Q' to quit>" )
    //
   ENDIF
   //
  OTHERWISE
   //
   Warn( "PROCProgramRunGitTsePause(", " ", "case", " ", ":", " ", caseS, ": not known" )
   //
   RETURN()
   //
 ENDCASE
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

// library: program: run: dos: git <description></description> <version control></version control> <version>1.0.0.0.35</version> <version control></version control> (filenamemacro=runprdgi.s) [<Program>] [<Research>] [kn, ri, sa, 19-11-2022 13:41:15]
INTEGER PROC FNProgramRunGitTseOutputB( STRING s, STRING caseS, INTEGER dosB )
 // e.g. //
 // e.g. STRING iniFileNameGS[255] = ".\git_tse.ini"
 // e.g. //
 // e.g. PROC Main()
 // e.g.  //
 // e.g.  SetGlobalStr( "iniFileNameS", QuotePath( Format( AddTrailingSlash( LoadDir() ), "tse.ini" ) ) )
 // e.g.  //
 // e.g.  // SetGlobalStr( "sectionS", "git_tse" )
 // e.g.  SetGlobalStr( "sectionS", "git_tse_knud" )
 // e.g.  //
 // e.g.  Message( FNProgramRunGitTseOutputB( "dir a*.s", "dir", TRUE ) ) // gives e.g. TRUE
 // e.g. END
 // e.g.
 // e.g. <F12> Main()
 //
 // ===
 //
 // Use case =
 //
 // ===
 //
 // ===
 //
 // Method =
 //
 // ===
 //
 // ===
 //
 // Example:
 //
 // Input:
 //
 /*
--- cut here: begin --------------------------------------------------
--- cut here: end ----------------------------------------------------
 */
 //
 // Output:
 //
 /*
--- cut here: begin --------------------------------------------------
--- cut here: end ----------------------------------------------------
 */
 //
 // ===
 //
 // e.g. // QuickHelp( HELPDEFFNProgramRunDosGitB )
 // e.g. HELPDEF HELPDEFFNProgramRunDosGitB
 // e.g.  title = "FNProgramRunGitTseOutputB( s1 ) help" // The help's caption
 // e.g.  x = 100 // Location
 // e.g.  y = 3 // Location
 // e.g.  //
 // e.g.  // The actual help text
 // e.g.  //
 // e.g.  "Usage:"
 // e.g.  "//"
 // e.g.  "1. Run this TSE macro"
 // e.g.  "2. Then press <CtrlAlt F1> to show this help."
 // e.g.  "3. Press <Shift Escape> to quit."
 // e.g.  "//"
 // e.g.  ""
 // e.g.  "Key: Definitions:"
 // e.g.  ""
 // e.g.  "<> = do something"
 // e.g. END
 //
 INTEGER B = FALSE
 //
 STRING iniFileNameS[255] = GetGlobalStr( "iniFileNameS" )
 //
 STRING sectionS[255] = GetGlobalStr( "sectionS" )
 //
 STRING fileNameS[255] = GetProfileStr( sectionS, "gitLogFileS", "", iniFileNameS )
 //
 STRING executableCommandLineS[255] = GetProfileStr( sectionS, "executableCommandLineS", "", iniFileNameS )
 //
 INTEGER flagI = _RETURN_CODE_ // causes the return code of cmd to be trapped, so that it can be returned via the DosIOResult() command.
 //
 // Warn( s ) // debug
 Message( s )
 //
 IF ( dosB )
  //
  // making the command processor (e.g. Microsoft cmd.exe, JPSoft tcc.exe, Microsoft PowerShell, ...) variable for testing purposes
  //
  // Dos( s ) // old [kn, ri, mo, 21-11-2022 03:56:09]
  // LDos( executableCommandLineS, s, _DONT_WAIT_ )// old [kn, ri, mo, 21-11-2022 11:23:18]
  LDos( executableCommandLineS, Format( " ", "/c", " ", s ), flagI )
  //
 ENDIF
 //
 PushPosition()
 PushBlock()
 //
 // create a comma separated value (=CSV) log file
 //
 EditFile( fileNameS )
 EndFile()
 Set( TimeFormat, 3 ) // 24 hour format and zero in front in time format
 AddLine( Format( "[", GetDateStr(), " ", GetTimeStr(), "]", ",", " ", s ) )
 EndLine()
 InsertText( "," )
 Right()
 InsertText( iniFileNameS )
 EndLine()
 InsertText( "," )
 Right()
 InsertText( sectionS )
 EndLine()
 InsertText( "," )
 Right()
 InsertText( executableCommandLineS )
 EndLine()
 InsertText( "," )
 Right()
 InsertText( GetGlobalStr( caseS ) )
 //
 IF ( SaveAs( fileNameS, _OVERWRITE_ ) )
  EditFile( fileNameS )
  AbandonFile()
 ENDIF
 //
 PopBlock() // debug
 PopPosition() // debug
 //
 B = TRUE
 //
 RETURN( B )
 //
END

// library: math: get: number: input: yes: no: cancel: position: default <description></description> <version>1.0.0.0.3</version> <version control></version control> (filenamemacro=getmapde.s) [<Program>] [<Research>] [kn, am, mo, 04-07-2011 14:23:57]
INTEGER PROC FNMathGetNumberInputYesNoCancelPositionDefaultI( STRING infoS )
 // e.g. PROC Main()
 // e.g.  Message( FNMathGetNumberInputYesNoCancelPositionDefaultI( "Please press Yes/No/Cancel" ) ) // gives e.g. 1 if Yes has been choosen
 // e.g. END
 // e.g.
 // e.g. <F12> Main()
 //
 PROCMacroRunKeep( "setwiyde" ) // operation: set: window: warn/yesno: position: x: y: default
 //
 RETURN( YesNo( infoS ) )
 //
END

// library: string: get: directory: repository: git: default <description></description> <version control></version control> <version>1.0.0.0.8</version> <version control></version control> (filenamemacro=getstrdj.s) [<Program>] [<Research>] [kn, ri, th, 24-11-2022 22:34:38]
STRING PROC FNStringGetDirectoryRepositoryGitDefaultS()
 // e.g. //
 // e.g. STRING iniFileNameGS[255] = ".\git_tse.ini"
 // e.g. //
 // e.g. PROC Main()
 // e.g.  //
 // e.g.  // SetGlobalStr( "iniFileNameS", ".\git_tse.ini" ) // change this to .ini file in the current local directory
 // e.g.  SetGlobalStr( "iniFileNameS", QuotePath( Format( AddTrailingSlash( LoadDir() ), "tse.ini" ) ) ) // change this
 // e.g.  //
 // e.g.  // SetGlobalStr( "sectionS", "git_tse" ) // change this
 // e.g.  SetGlobalStr( "sectionS", "git_tse_knud" ) // change this
 // e.g.  //
 // e.g.  Message( FNStringGetDirectoryRepositoryGitDefaultS() ) // gives e.g. "C:\TEMP\RG01"
 // e.g. END
 // e.g.
 // e.g. <F12> Main()
 //
 // ===
 //
 // Use case =
 //
 // ===
 //
 // ===
 //
 // Method =
 //
 // ===
 //
 // ===
 //
 // Example:
 //
 // Input:
 //
 /*
--- cut here: begin --------------------------------------------------
--- cut here: end ----------------------------------------------------
 */
 //
 // Output:
 //
 /*
--- cut here: begin --------------------------------------------------
--- cut here: end ----------------------------------------------------
 */
 //
 // ===
 //
 // e.g. // QuickHelp( HELPDEFFNStringGetDirectoryRepositoryDefaultS )
 // e.g. HELPDEF HELPDEFFNStringGetDirectoryRepositoryDefaultS
 // e.g.  title = "FNStringGetDirectoryRepositoryDefaultS() help" // The help's caption
 // e.g.  x = 100 // Location
 // e.g.  y = 3 // Location
 // e.g.  //
 // e.g.  // The actual help text
 // e.g.  //
 // e.g.  "Usage:"
 // e.g.  "//"
 // e.g.  "1. Run this TSE macro"
 // e.g.  "2. Then press <CtrlAlt F1> to show this help."
 // e.g.  "3. Press <Shift Escape> to quit."
 // e.g.  "//"
 // e.g.  ""
 // e.g.  "Key: Definitions:"
 // e.g.  ""
 // e.g.  "<> = do something"
 // e.g. END
 //
 STRING iniFileNameS[255] = GetGlobalStr( "iniFileNameS" )
 //
 STRING sectionS[255] = GetGlobalStr( "sectionS" )
 //
 STRING s[255] = ""
 //
 s = GetProfileStr( sectionS, "directoryRepositoryDefaultS", "", iniFileNameS )
 //
 RETURN( s )
 //
END

// library: string: space: remove: begin <description></description> <version control></version control> <version>1.0.0.0.1</version> (filenamemacro=remostsb.s) [<Program>] [<Research>] [kn, ri, th, 15-02-2001 06:06:51]
STRING PROC FNStringGetSpaceRemoveBeginS( STRING s )
 // e.g. PROC Main()
 // e.g.  STRING s[255] = FNStringGetInitializeNewStringS()
 // e.g.  s = FNStringGetInputS( "string: space: remove: begin: string = ", "   test    " )
 // e.g.  IF FNKeyCheckPressEscapeB( s ) RETURN() ENDIF
 // e.g.  Message( "'", FNStringGetSpaceRemoveBeginS( s ), "'" ) // gives e.g. "test    "
 // e.g. END
 // e.g.
 // e.g. <F12> Main()
 //
 RETURN( LTrim( s ) )
 //
END

// library: string: get: delete: word: front <description>string: word: token: delete: first: delete 1 occurrence of a given other string in front of a given string. E.g. StringWordDeleteFront( "00001234567", "0" ) gives "0001234567". Possible application: deleting the '0' in front of a phonenumber (e.g. when dialing internationally).</description> <version>1.0.0.0.2</version> <version control></version control> (filenamemacro=getstwfs.s) [<Program>] [<Research>] [kn, ni, su, 02-08-1998 16:30:45]
STRING PROC FNStringGetDeleteWordFrontS( STRING s, STRING deleteS )
 // e.g. PROC Main()
 // e.g.  Warn( FNStringGetDeleteWordFrontS( "this is", "this" ) ) // gives " is"
 // e.g.  Warn( FNStringGetDeleteWordFrontS( "the girl", "the" ) ) // gives " girl"
 // e.g. END
 // e.g.
 // e.g. <F12> Main()
 //
 INTEGER lengthdeleteI = FNStringGetLengthI( deleteS )
 //
 RETURN( SubStr( s, lengthdeleteI + 1, FNStringGetLengthI( s ) - lengthdeleteI ) )
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
