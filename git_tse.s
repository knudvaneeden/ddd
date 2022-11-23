FORWARD INTEGER PROC FNFileSaveFileVersionControlGitSimplestCaseB( STRING s1 )
FORWARD INTEGER PROC FNMacroCheckExecB( STRING s1 )
FORWARD INTEGER PROC FNMacroCheckLoadB( STRING s1 )
FORWARD INTEGER PROC FNMathCheckLogicNotB( INTEGER i1 )
FORWARD INTEGER PROC FNMathGetNumberInputYesNoCancelPositionDefaultI( STRING s1 )
FORWARD INTEGER PROC FNProgramRunGitTseOutputB( STRING s1, STRING s2, INTEGER i1 )
FORWARD INTEGER PROC FNStringCheckEmptyB( STRING s1 )
FORWARD INTEGER PROC FNStringCheckEqualB( STRING s1, STRING s2 )
FORWARD INTEGER PROC FNWindowSetCenterPopupOnB()
FORWARD PROC Main()
FORWARD PROC PROCMacroExec( STRING s1 )
FORWARD PROC PROCMacroRunKeep( STRING s1 )
FORWARD PROC PROCProgramRunGitTseWindow()
FORWARD PROC PROCWarn( STRING s1 )
FORWARD PROC PROCWarnCons3( STRING s1, STRING s2, STRING s3 )
FORWARD STRING PROC FNStringGetAsciiToCharacterS( INTEGER i1 )
FORWARD STRING PROC FNStringGetCarS( STRING s1 )
FORWARD STRING PROC FNStringGetCharacterSymbolCentralS( INTEGER i1 )
FORWARD STRING PROC FNStringGetCharacterSymbolSpaceS()
FORWARD STRING PROC FNStringGetConcatSeparatorS( STRING s1, STRING s2, STRING s3 )
FORWARD STRING PROC FNStringGetCons3S( STRING s1, STRING s2, STRING s3 )
FORWARD STRING PROC FNStringGetConsS( STRING s1, STRING s2 )
FORWARD STRING PROC FNStringGetEmptyS()


// --- MAIN --- //

PROC Main()
 //
 STRING s1[255] = "" // change this
 //
 INTEGER bufferI = 0
 //
 INTEGER quitB = FALSE
 //
 SetGlobalStr( "iniFileNameS", QuotePath( Format( AddTrailingSlash( LoadDir() ), "tse.ini" ) ) )
 //
 // SetGlobalStr( "sectionS", "git_tse" )
 SetGlobalStr( "sectionS", "git_tse_knud" )
 //
 REPEAT
  //
  PushPosition()
  bufferI = CreateTempBuffer()
  PopPosition()
  //
  PushPosition()
  PushBlock()
  GotoBufferId( bufferI )
  //
  SetGlobalStr( "s010", "5. Add + Commit your currently loaded file in TSE (into your local repository)" )
  SetGlobalStr( "s011", "1. Download once and install: Git-SCM" )
  SetGlobalStr( "s012", "2. Initialize once your repository directory" )
  SetGlobalStr( "s013", "3. Set once your name" )
  SetGlobalStr( "s014", "4. Set once your email" )
  SetGlobalStr( "s015", "Settings" )
  SetGlobalStr( "s016", "Quit" )
  SetGlobalStr( "s017", "Optionally: Add + Commit all files in the root directory and all subdirectories of the current repository directory (add . / commit .)" )
  SetGlobalStr( "s018", "Optionally: Add + Commit your currently loaded file in TSE into your remote repository: GitHub (push)" )
  SetGlobalStr( "s019", "Optionally: Add + Commit your currently loaded file in TSE into your remote repository: GitLab (push)" )
  SetGlobalStr( "s020", "Optionally: Change to another local repository directory" )
  SetGlobalStr( "s021", "Optionally: Change to another branch in the current local repository directory (checkout)" )
  SetGlobalStr( "s022", "Optionally: Change: Load another filename into TSE" )
  SetGlobalStr( "s094", "Optionally: Check for any updates / any changes in the remote repository directory (ls-remote)" )
  SetGlobalStr( "s023", "Optionally: Copy the current local repository directory completely to another local repository directory (clone)" )
  SetGlobalStr( "s024", "Optionally: Copy a remote Internet repository directory branch completely to a local repository directory (clone)" )
  SetGlobalStr( "s025", "Optionally: Copy a remote Internet repository directory branch completely to a local repository directory: Example (clone)" )
  SetGlobalStr( "s026", "Optionally: Copy all files from a directory and its subdirectories to another directory (copy *.* /s)" )
  SetGlobalStr( "s027", "Optionally: Collaborate: 1. Fetch from a remote repository directory to the current local repository directory" )
  SetGlobalStr( "s028", "Optionally: Collaborate: 2. Pull from a remote repository directory to the current local repository directory" )
  SetGlobalStr( "s029", "Optionally: Collaborate: 3. Push to a remote repository directory from the current local repository directory" )
  SetGlobalStr( "s030", "Optionally: Collaborate: 4. Remote" )
  SetGlobalStr( "s031", "Optionally: Collaborate: 4. Remote -v" )
  SetGlobalStr( "s032", "Optionally: Collaborate: 4. Remote add <name> <url>" )
  SetGlobalStr( "s033", "Optionally: Collaborate: 4. Remote rm <name>" )
  SetGlobalStr( "s034", "Optionally: Collaborate: 4. Remote rename <old name> <new name>" )
  SetGlobalStr( "s095", "Optionally: Create a new remote repository on GitHub" )
  SetGlobalStr( "s096", "Optionally: Create a new remote repository on GitLab" )
  SetGlobalStr( "s035", "Optionally: Create a new branch in the current local repository directory" )
  SetGlobalStr( "s036", "Optionally: Delete another branch from your current local repository directory" )
  SetGlobalStr( "s037", "Optionally: Delete your currently loaded file in TSE from your local repository directory" )
  SetGlobalStr( "s038", "Optionally: Download once and install: Git-Cygwin" )
  SetGlobalStr( "s039", "Optionally: Download once and install: Git-Tortoise" )
  SetGlobalStr( "s040", "Optionally: Get all filenames in your current local repository directory" )
  SetGlobalStr( "s041", "Optionally: Goto your Git server web page on the Internet: GitHub" )
  SetGlobalStr( "s042", "Optionally: Goto your Git server web page on the Internet: GitLab" )
  SetGlobalStr( "s043", "Optionally: Load a whole git directory into TSE" )
  SetGlobalStr( "s044", "Optionally: Merge your current branch with another branch in your current local repository directory" )
  SetGlobalStr( "s045", "Optionally: Rename a filename in the current local repository directory" )
  SetGlobalStr( "s046", "Optionally: Run the command line" )
  SetGlobalStr( "s047", "Optionally: Run git commands in the current repository directory" )
  SetGlobalStr( "s048", "Optionally: Run graphical Gitk program on the current local repository directory (git-scm only)" )
  SetGlobalStr( "s049", "Optionally: Run graphical Git-GUI program on the current local repository directory (git-scm only)" )
  SetGlobalStr( "s050", "Optionally: Read your current local repository directory" )
  SetGlobalStr( "s097", "Optionally: Read all files in your current local repository directory" )
  SetGlobalStr( "s051", "Optionally: Read your current branch name in your current local repository directory" )
  SetGlobalStr( "s052", "Optionally: Read all the branch names in the current local repository directory: Branch" )
  SetGlobalStr( "s053", "Optionally: Read all the branch names in the current local repository directory: Show-Branch" )
  SetGlobalStr( "s054", "Optionally: Read the git config file for the current local repository directory" )
  SetGlobalStr( "s092", "Optionally: Read the global git config file for the currently logged in user" )
  SetGlobalStr( "s055", "Optionally: Read the git .gitignore file for the current local repository directory" )
  SetGlobalStr( "s056", "Optionally: Read the history: Who changed what when (blame)" )
  SetGlobalStr( "s057", "Optionally: Read the history: Diff (see also 'Show')" )
  SetGlobalStr( "s058", "Optionally: Read the history: Diff: last with previous one back" )
  SetGlobalStr( "s059", "Optionally: Read the history: Diff: last with previous two back" )
  SetGlobalStr( "s060", "Optionally: Read the history: Diff: last with previous three back" )
  SetGlobalStr( "s061", "Optionally: Read the history: Diff: last with previous four back" )
  SetGlobalStr( "s062", "Optionally: Read the history: Diff: last with previous five back" )
  SetGlobalStr( "s063", "Optionally: Read the history: Diff: last with previous six back" )
  SetGlobalStr( "s064", "Optionally: Read the history: Diff: last with previous N back" )
  SetGlobalStr( "s065", "Optionally: Read the history: Diff: previous M with previous N back" )
  SetGlobalStr( "s066", "Optionally: Read the history: Log" )
  SetGlobalStr( "s067", "Optionally: Read the history: Log --oneline" )
  SetGlobalStr( "s068", "Optionally: Read the history: Show" )
  SetGlobalStr( "s069", "Optionally: Read the history: Status" )
  SetGlobalStr( "s070", "Optionally: Read Help: Git command help: subcommands" )
  SetGlobalStr( "s071", "Optionally: Read Help: Git command help: concept guides" )
  SetGlobalStr( "s072", "Optionally: Read Help: Git command all" )
  SetGlobalStr( "s073", "Optionally: Read Help: Git command help" )
  SetGlobalStr( "s074", "Optionally: Read Help: Git view tree .git" )
  SetGlobalStr( "s075", "Optionally: Read the log file" )
  SetGlobalStr( "s093", "Optionally: Read the Git command line executable" )
  SetGlobalStr( "s076", "Optionally: Read the Git version" )
  SetGlobalStr( "s077", "Optionally: Read book 'Version Control with Git' (O'Reilly)" )
  SetGlobalStr( "s078", "Optionally: Replace your current file in the current local repository directory with version 1 version before" )
  SetGlobalStr( "s079", "Optionally: Replace your current file in the current local repository directory with version 2 versions before" )
  SetGlobalStr( "s080", "Optionally: Replace your current file in the current local repository directory with version 3 versions before" )
  SetGlobalStr( "s081", "Optionally: Replace your current file in the current local repository directory with version 4 versions before" )
  SetGlobalStr( "s082", "Optionally: Replace your current file in the current local repository directory with version 5 versions before" )
  SetGlobalStr( "s083", "Optionally: Replace your current file in the current local repository directory with version 6 versions before" )
  SetGlobalStr( "s084", "Optionally: Replace your current file in the current local repository directory with version N versions before" )
  SetGlobalStr( "s085", "Optionally: Reset HEAD of your current file in the local repository directory" )
  SetGlobalStr( "s086", "Optionally: 1. Save your current state of your local repository directory: Stash: Push" )
  SetGlobalStr( "s087", "Optionally: 2. Restore your current state of your local repository directory: Stash: Pop" )
  SetGlobalStr( "s088", "Optionally: 1. Set version state: Indicate that this version in this local repository directory is bad or good: start (bisect)" )
  SetGlobalStr( "s089", "Optionally: 2. Set version state: Indicate that this version in this local repository directory is bad (bisect)" )
  SetGlobalStr( "s090", "Optionally: 2. Set version state: Indicate that this version in this local repository directory is good (bisect)" )
  SetGlobalStr( "s091", "Optionally: 3. Set version state: Indicate that this version in this local repository directory is bad or good: reset (bisect)" )
  //
  AddLine( GetGlobalStr( "s010" ) ) AddLine( "--------------------------------------------------------------------------" )
  AddLine( GetGlobalStr( "s011" ) ) AddLine( "--------------------------------------------------------------------------" )
  AddLine( GetGlobalStr( "s012" ) ) AddLine( "--------------------------------------------------------------------------" )
  AddLine( GetGlobalStr( "s013" ) ) AddLine( "--------------------------------------------------------------------------" )
  AddLine( GetGlobalStr( "s014" ) ) AddLine( "--------------------------------------------------------------------------" )
  AddLine( GetGlobalStr( "s015" ) ) AddLine( "--------------------------------------------------------------------------" )
  AddLine( GetGlobalStr( "s016" ) ) AddLine( "--------------------------------------------------------------------------" )
  AddLine( GetGlobalStr( "s017" ) ) AddLine( "--------------------------------------------------------------------------" )
  AddLine( GetGlobalStr( "s018" ) ) //
  AddLine( GetGlobalStr( "s019" ) ) AddLine( "--------------------------------------------------------------------------" )
  AddLine( GetGlobalStr( "s020" ) ) AddLine( "--------------------------------------------------------------------------" )
  AddLine( GetGlobalStr( "s021" ) ) AddLine( "--------------------------------------------------------------------------" )
  AddLine( GetGlobalStr( "s022" ) ) AddLine( "--------------------------------------------------------------------------" )
  AddLine( GetGlobalStr( "s094" ) ) AddLine( "--------------------------------------------------------------------------" )
  AddLine( GetGlobalStr( "s023" ) ) AddLine( "--------------------------------------------------------------------------" )
  AddLine( GetGlobalStr( "s024" ) ) //
  AddLine( GetGlobalStr( "s025" ) ) AddLine( "--------------------------------------------------------------------------" )
  AddLine( GetGlobalStr( "s026" ) ) AddLine( "--------------------------------------------------------------------------" )
  AddLine( GetGlobalStr( "s027" ) ) //
  AddLine( GetGlobalStr( "s028" ) ) //
  AddLine( GetGlobalStr( "s029" ) ) //
  AddLine( GetGlobalStr( "s030" ) ) //
  AddLine( GetGlobalStr( "s031" ) ) //
  AddLine( GetGlobalStr( "s032" ) ) //
  AddLine( GetGlobalStr( "s033" ) ) //
  AddLine( GetGlobalStr( "s034" ) ) AddLine( "--------------------------------------------------------------------------" )
  AddLine( GetGlobalStr( "s095" ) ) //
  AddLine( GetGlobalStr( "s096" ) ) AddLine( "--------------------------------------------------------------------------" )
  AddLine( GetGlobalStr( "s035" ) ) AddLine( "--------------------------------------------------------------------------" )
  AddLine( GetGlobalStr( "s036" ) ) AddLine( "--------------------------------------------------------------------------" )
  AddLine( GetGlobalStr( "s037" ) ) AddLine( "--------------------------------------------------------------------------" )
  AddLine( GetGlobalStr( "s038" ) ) //
  AddLine( GetGlobalStr( "s039" ) ) AddLine( "--------------------------------------------------------------------------" )
  AddLine( GetGlobalStr( "s040" ) ) AddLine( "--------------------------------------------------------------------------" )
  AddLine( GetGlobalStr( "s041" ) ) //
  AddLine( GetGlobalStr( "s042" ) ) AddLine( "--------------------------------------------------------------------------" )
  AddLine( GetGlobalStr( "s043" ) ) AddLine( "--------------------------------------------------------------------------" )
  AddLine( GetGlobalStr( "s044" ) ) AddLine( "--------------------------------------------------------------------------" )
  AddLine( GetGlobalStr( "s045" ) ) AddLine( "--------------------------------------------------------------------------" )
  AddLine( GetGlobalStr( "s046" ) ) AddLine( "--------------------------------------------------------------------------" )
  AddLine( GetGlobalStr( "s047" ) ) AddLine( "--------------------------------------------------------------------------" )
  AddLine( GetGlobalStr( "s048" ) ) //
  AddLine( GetGlobalStr( "s049" ) ) AddLine( "--------------------------------------------------------------------------" )
  AddLine( GetGlobalStr( "s050" ) ) AddLine( "--------------------------------------------------------------------------" )
  AddLine( GetGlobalStr( "s097" ) ) AddLine( "--------------------------------------------------------------------------" )
  AddLine( GetGlobalStr( "s051" ) ) AddLine( "--------------------------------------------------------------------------" )
  AddLine( GetGlobalStr( "s052" ) ) //
  AddLine( GetGlobalStr( "s053" ) ) AddLine( "--------------------------------------------------------------------------" )
  AddLine( GetGlobalStr( "s054" ) ) //
  AddLine( GetGlobalStr( "s092" ) ) AddLine( "--------------------------------------------------------------------------" )
  AddLine( GetGlobalStr( "s055" ) ) AddLine( "--------------------------------------------------------------------------" )
  AddLine( GetGlobalStr( "s056" ) ) AddLine( "--------------------------------------------------------------------------" )
  AddLine( GetGlobalStr( "s057" ) ) //
  AddLine( GetGlobalStr( "s058" ) ) //
  AddLine( GetGlobalStr( "s059" ) ) //
  AddLine( GetGlobalStr( "s060" ) ) //
  AddLine( GetGlobalStr( "s061" ) ) //
  AddLine( GetGlobalStr( "s062" ) ) //
  AddLine( GetGlobalStr( "s063" ) ) //
  AddLine( GetGlobalStr( "s064" ) ) //
  AddLine( GetGlobalStr( "s065" ) ) AddLine( "--------------------------------------------------------------------------" )
  AddLine( GetGlobalStr( "s066" ) ) //
  AddLine( GetGlobalStr( "s067" ) ) AddLine( "--------------------------------------------------------------------------" )
  AddLine( GetGlobalStr( "s068" ) ) AddLine( "--------------------------------------------------------------------------" )
  AddLine( GetGlobalStr( "s069" ) ) AddLine( "--------------------------------------------------------------------------" )
  AddLine( GetGlobalStr( "s070" ) ) AddLine( "--------------------------------------------------------------------------" )
  AddLine( GetGlobalStr( "s071" ) ) AddLine( "--------------------------------------------------------------------------" )
  AddLine( GetGlobalStr( "s072" ) ) AddLine( "--------------------------------------------------------------------------" )
  AddLine( GetGlobalStr( "s073" ) ) AddLine( "--------------------------------------------------------------------------" )
  AddLine( GetGlobalStr( "s074" ) ) AddLine( "--------------------------------------------------------------------------" )
  AddLine( GetGlobalStr( "s075" ) ) AddLine( "--------------------------------------------------------------------------" )
  AddLine( GetGlobalStr( "s093" ) ) AddLine( "--------------------------------------------------------------------------" )
  AddLine( GetGlobalStr( "s076" ) ) AddLine( "--------------------------------------------------------------------------" )
  AddLine( GetGlobalStr( "s077" ) ) AddLine( "--------------------------------------------------------------------------" )
  AddLine( GetGlobalStr( "s078" ) ) //
  AddLine( GetGlobalStr( "s079" ) ) //
  AddLine( GetGlobalStr( "s080" ) ) //
  AddLine( GetGlobalStr( "s081" ) ) //
  AddLine( GetGlobalStr( "s082" ) ) //
  AddLine( GetGlobalStr( "s083" ) ) //
  AddLine( GetGlobalStr( "s084" ) ) AddLine( "--------------------------------------------------------------------------" )
  AddLine( GetGlobalStr( "s085" ) ) AddLine( "--------------------------------------------------------------------------" )
  AddLine( GetGlobalStr( "s086" ) ) //
  AddLine( GetGlobalStr( "s087" ) ) AddLine( "--------------------------------------------------------------------------" )
  AddLine( GetGlobalStr( "s088" ) ) //
  AddLine( GetGlobalStr( "s089" ) ) //
  AddLine( GetGlobalStr( "s090" ) ) //
  AddLine( GetGlobalStr( "s091" ) ) //
  AddLine( "--------------------------------------------------------------------------" )
  //
  GotoLine( 1 )
  PROCProgramRunGitTseWindow()
  IF List( "Choose an option", 130 )
   s1 = Trim( GetText( 1, 255 ) )
  ELSE
   AbandonFile( bufferI )
   PopBlock()
   PopPosition()
   RETURN()
  ENDIF
  AbandonFile( bufferI )
  PopBlock()
  PopPosition()
  //
  quitB = EquiStr( Trim( Lower( s1 ) ), "quit" )
  //
  IF NOT quitB
   Message( FNFileSaveFileVersionControlGitSimplestCaseB( s1 ) ) // gives e.g. TRUE
  ENDIF
  //
 UNTIL ( quitB )
 //
END

<F12> Main()

// --- LIBRARY --- //

// library: program: run: git: tse: window <description></description> <version control></version control> <version>1.0.0.0.4</version> <version control></version control> (filenamemacro=runprtwi.s) [<Program>] [<Research>] [kn, ri, mo, 21-11-2022 12:31:19]
PROC PROCProgramRunGitTseWindow()
 // e.g. PROC Main()
 // e.g.  PROCProgramRunGitTseWindow()
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
 // e.g.  title = "PROCProgramRunGitTseWindow() help" // The help's caption
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
 STRING sectionS[255] = GetGlobalStr( "sectionS" )
 //
 IF EquiStr( Trim( sectionS ), "" )
  //
  Warn( 'Please first set your SetGlobalStr( "sectionS" ) in file git_tse.s' )
  //
 ELSE
  //
  IF sectionS == "git_tse_knud"
   //
   ExecMacro( "setwiyde" ) // operation: set: window: warn/yesno: position: x: y: default // new
   //
  ELSE
   //
   B = FNWindowSetCenterPopupOnB()
   //
  ENDIF
  //
 ENDIF
 //
END

// library: file: save: file: version: control: git: simplest: case <description></description> <version control></version control> <version>1.0.0.0.305</version> <version control></version control> (filenamemacro=git_tse.s) [<Program>] [<Research>] [kn, ri, su, 13-11-2022 23:45:27]
INTEGER PROC FNFileSaveFileVersionControlGitSimplestCaseB( STRING caseS )
 // e.g. PROC Main()
 // e.g.  //
 // e.g.  STRING s1[255] = "" // change this
 // e.g.  //
 // e.g.  INTEGER bufferI = 0
 // e.g.  //
 // e.g.  INTEGER quitB = FALSE
 // e.g.  //
 // e.g.  SetGlobalStr( "iniFileNameS", QuotePath( Format( AddTrailingSlash( LoadDir() ), "tse.ini" ) ) )
 // e.g.  //
 // e.g.  // SetGlobalStr( "sectionS", "git_tse" )
 // e.g.  SetGlobalStr( "sectionS", "git_tse_knud" )
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
 // e.g.   SetGlobalStr( "s010", "5. Add + Commit your currently loaded file in TSE (into your local repository)" )
 // e.g.   SetGlobalStr( "s011", "1. Download once and install: Git-SCM" )
 // e.g.   SetGlobalStr( "s012", "2. Initialize once your repository directory" )
 // e.g.   SetGlobalStr( "s013", "3. Set once your name" )
 // e.g.   SetGlobalStr( "s014", "4. Set once your email" )
 // e.g.   SetGlobalStr( "s015", "Settings" )
 // e.g.   SetGlobalStr( "s016", "Quit" )
 // e.g.   SetGlobalStr( "s017", "Optionally: Add + Commit all files in the root directory and all subdirectories of the current repository directory (add . / commit .)" )
 // e.g.   SetGlobalStr( "s018", "Optionally: Add + Commit your currently loaded file in TSE into your remote repository: GitHub (push)" )
 // e.g.   SetGlobalStr( "s019", "Optionally: Add + Commit your currently loaded file in TSE into your remote repository: GitLab (push)" )
 // e.g.   SetGlobalStr( "s020", "Optionally: Change to another local repository directory" )
 // e.g.   SetGlobalStr( "s021", "Optionally: Change to another branch in the current local repository directory (checkout)" )
 // e.g.   SetGlobalStr( "s022", "Optionally: Change: Load another filename into TSE" )
 // e.g.   SetGlobalStr( "s094", "Optionally: Check for any updates / any changes in the remote repository directory (ls-remote)" )
 // e.g.   SetGlobalStr( "s023", "Optionally: Copy the current local repository directory completely to another local repository directory (clone)" )
 // e.g.   SetGlobalStr( "s024", "Optionally: Copy a remote Internet repository directory branch completely to a local repository directory (clone)" )
 // e.g.   SetGlobalStr( "s025", "Optionally: Copy a remote Internet repository directory branch completely to a local repository directory: Example (clone)" )
 // e.g.   SetGlobalStr( "s026", "Optionally: Copy all files from a directory and its subdirectories to another directory (copy *.* /s)" )
 // e.g.   SetGlobalStr( "s027", "Optionally: Collaborate: 1. Fetch from a remote repository directory to the current local repository directory" )
 // e.g.   SetGlobalStr( "s028", "Optionally: Collaborate: 2. Pull from a remote repository directory to the current local repository directory" )
 // e.g.   SetGlobalStr( "s029", "Optionally: Collaborate: 3. Push to a remote repository directory from the current local repository directory" )
 // e.g.   SetGlobalStr( "s030", "Optionally: Collaborate: 4. Remote" )
 // e.g.   SetGlobalStr( "s031", "Optionally: Collaborate: 4. Remote -v" )
 // e.g.   SetGlobalStr( "s032", "Optionally: Collaborate: 4. Remote add <name> <url>" )
 // e.g.   SetGlobalStr( "s033", "Optionally: Collaborate: 4. Remote rm <name>" )
 // e.g.   SetGlobalStr( "s034", "Optionally: Collaborate: 4. Remote rename <old name> <new name>" )
 // e.g.   SetGlobalStr( "s095", "Optionally: Create a new remote repository on GitHub" )
 // e.g.   SetGlobalStr( "s096", "Optionally: Create a new remote repository on GitLab" )
 // e.g.   SetGlobalStr( "s035", "Optionally: Create a new branch in the current local repository directory" )
 // e.g.   SetGlobalStr( "s036", "Optionally: Delete another branch from your current local repository directory" )
 // e.g.   SetGlobalStr( "s037", "Optionally: Delete your currently loaded file in TSE from your local repository directory" )
 // e.g.   SetGlobalStr( "s038", "Optionally: Download once and install: Git-Cygwin" )
 // e.g.   SetGlobalStr( "s039", "Optionally: Download once and install: Git-Tortoise" )
 // e.g.   SetGlobalStr( "s040", "Optionally: Get all filenames in your current local repository directory" )
 // e.g.   SetGlobalStr( "s041", "Optionally: Goto your Git server web page on the Internet: GitHub" )
 // e.g.   SetGlobalStr( "s042", "Optionally: Goto your Git server web page on the Internet: GitLab" )
 // e.g.   SetGlobalStr( "s043", "Optionally: Load a whole git directory into TSE" )
 // e.g.   SetGlobalStr( "s044", "Optionally: Merge your current branch with another branch in your current local repository directory" )
 // e.g.   SetGlobalStr( "s045", "Optionally: Rename a filename in the current local repository directory" )
 // e.g.   SetGlobalStr( "s046", "Optionally: Run the command line" )
 // e.g.   SetGlobalStr( "s047", "Optionally: Run git commands in the current repository directory" )
 // e.g.   SetGlobalStr( "s048", "Optionally: Run graphical Gitk program on the current local repository directory (git-scm only)" )
 // e.g.   SetGlobalStr( "s049", "Optionally: Run graphical Git-GUI program on the current local repository directory (git-scm only)" )
 // e.g.   SetGlobalStr( "s050", "Optionally: Read your current local repository directory" )
 // e.g.   SetGlobalStr( "s097", "Optionally: Read all files in your current local repository directory" )
 // e.g.   SetGlobalStr( "s051", "Optionally: Read your current branch name in your current local repository directory" )
 // e.g.   SetGlobalStr( "s052", "Optionally: Read all the branch names in the current local repository directory: Branch" )
 // e.g.   SetGlobalStr( "s053", "Optionally: Read all the branch names in the current local repository directory: Show-Branch" )
 // e.g.   SetGlobalStr( "s054", "Optionally: Read the git config file for the current local repository directory" )
 // e.g.   SetGlobalStr( "s092", "Optionally: Read the global git config file for the currently logged in user" )
 // e.g.   SetGlobalStr( "s055", "Optionally: Read the git .gitignore file for the current local repository directory" )
 // e.g.   SetGlobalStr( "s056", "Optionally: Read the history: Who changed what when (blame)" )
 // e.g.   SetGlobalStr( "s057", "Optionally: Read the history: Diff (see also 'Show')" )
 // e.g.   SetGlobalStr( "s058", "Optionally: Read the history: Diff: last with previous one back" )
 // e.g.   SetGlobalStr( "s059", "Optionally: Read the history: Diff: last with previous two back" )
 // e.g.   SetGlobalStr( "s060", "Optionally: Read the history: Diff: last with previous three back" )
 // e.g.   SetGlobalStr( "s061", "Optionally: Read the history: Diff: last with previous four back" )
 // e.g.   SetGlobalStr( "s062", "Optionally: Read the history: Diff: last with previous five back" )
 // e.g.   SetGlobalStr( "s063", "Optionally: Read the history: Diff: last with previous six back" )
 // e.g.   SetGlobalStr( "s064", "Optionally: Read the history: Diff: last with previous N back" )
 // e.g.   SetGlobalStr( "s065", "Optionally: Read the history: Diff: previous M with previous N back" )
 // e.g.   SetGlobalStr( "s066", "Optionally: Read the history: Log" )
 // e.g.   SetGlobalStr( "s067", "Optionally: Read the history: Log --oneline" )
 // e.g.   SetGlobalStr( "s068", "Optionally: Read the history: Show" )
 // e.g.   SetGlobalStr( "s069", "Optionally: Read the history: Status" )
 // e.g.   SetGlobalStr( "s070", "Optionally: Read Help: Git command help: subcommands" )
 // e.g.   SetGlobalStr( "s071", "Optionally: Read Help: Git command help: concept guides" )
 // e.g.   SetGlobalStr( "s072", "Optionally: Read Help: Git command all" )
 // e.g.   SetGlobalStr( "s073", "Optionally: Read Help: Git command help" )
 // e.g.   SetGlobalStr( "s074", "Optionally: Read Help: Git view tree .git" )
 // e.g.   SetGlobalStr( "s075", "Optionally: Read the log file" )
 // e.g.   SetGlobalStr( "s093", "Optionally: Read the Git command line executable" )
 // e.g.   SetGlobalStr( "s076", "Optionally: Read the Git version" )
 // e.g.   SetGlobalStr( "s077", "Optionally: Read book 'Version Control with Git' (O'Reilly)" )
 // e.g.   SetGlobalStr( "s078", "Optionally: Replace your current file in the current local repository directory with version 1 version before" )
 // e.g.   SetGlobalStr( "s079", "Optionally: Replace your current file in the current local repository directory with version 2 versions before" )
 // e.g.   SetGlobalStr( "s080", "Optionally: Replace your current file in the current local repository directory with version 3 versions before" )
 // e.g.   SetGlobalStr( "s081", "Optionally: Replace your current file in the current local repository directory with version 4 versions before" )
 // e.g.   SetGlobalStr( "s082", "Optionally: Replace your current file in the current local repository directory with version 5 versions before" )
 // e.g.   SetGlobalStr( "s083", "Optionally: Replace your current file in the current local repository directory with version 6 versions before" )
 // e.g.   SetGlobalStr( "s084", "Optionally: Replace your current file in the current local repository directory with version N versions before" )
 // e.g.   SetGlobalStr( "s085", "Optionally: Reset HEAD of your current file in the local repository directory" )
 // e.g.   SetGlobalStr( "s086", "Optionally: 1. Save your current state of your local repository directory: Stash: Push" )
 // e.g.   SetGlobalStr( "s087", "Optionally: 2. Restore your current state of your local repository directory: Stash: Pop" )
 // e.g.   SetGlobalStr( "s088", "Optionally: 1. Set version state: Indicate that this version in this local repository directory is bad or good: start (bisect)" )
 // e.g.   SetGlobalStr( "s089", "Optionally: 2. Set version state: Indicate that this version in this local repository directory is bad (bisect)" )
 // e.g.   SetGlobalStr( "s090", "Optionally: 2. Set version state: Indicate that this version in this local repository directory is good (bisect)" )
 // e.g.   SetGlobalStr( "s091", "Optionally: 3. Set version state: Indicate that this version in this local repository directory is bad or good: reset (bisect)" )
 // e.g.   //
 // e.g.   AddLine( GetGlobalStr( "s010" ) ) AddLine( "--------------------------------------------------------------------------" )
 // e.g.   AddLine( GetGlobalStr( "s011" ) ) AddLine( "--------------------------------------------------------------------------" )
 // e.g.   AddLine( GetGlobalStr( "s012" ) ) AddLine( "--------------------------------------------------------------------------" )
 // e.g.   AddLine( GetGlobalStr( "s013" ) ) AddLine( "--------------------------------------------------------------------------" )
 // e.g.   AddLine( GetGlobalStr( "s014" ) ) AddLine( "--------------------------------------------------------------------------" )
 // e.g.   AddLine( GetGlobalStr( "s015" ) ) AddLine( "--------------------------------------------------------------------------" )
 // e.g.   AddLine( GetGlobalStr( "s016" ) ) AddLine( "--------------------------------------------------------------------------" )
 // e.g.   AddLine( GetGlobalStr( "s017" ) ) AddLine( "--------------------------------------------------------------------------" )
 // e.g.   AddLine( GetGlobalStr( "s018" ) ) //
 // e.g.   AddLine( GetGlobalStr( "s019" ) ) AddLine( "--------------------------------------------------------------------------" )
 // e.g.   AddLine( GetGlobalStr( "s020" ) ) AddLine( "--------------------------------------------------------------------------" )
 // e.g.   AddLine( GetGlobalStr( "s021" ) ) AddLine( "--------------------------------------------------------------------------" )
 // e.g.   AddLine( GetGlobalStr( "s022" ) ) AddLine( "--------------------------------------------------------------------------" )
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
 // e.g.   AddLine( GetGlobalStr( "s036" ) ) AddLine( "--------------------------------------------------------------------------" )
 // e.g.   AddLine( GetGlobalStr( "s037" ) ) AddLine( "--------------------------------------------------------------------------" )
 // e.g.   AddLine( GetGlobalStr( "s038" ) ) //
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
 // e.g.   AddLine( GetGlobalStr( "s050" ) ) AddLine( "--------------------------------------------------------------------------" )
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
 // e.g.   PROCProgramRunGitTseWindow()
 // e.g.   IF List( "Choose an option", 130 )
 // e.g.    s1 = Trim( GetText( 1, 255 ) )
 // e.g.   ELSE
 // e.g.    AbandonFile( bufferI )
 // e.g.    PopBlock()
 // e.g.    PopPosition()
 // e.g.    RETURN()
 // e.g.   ENDIF
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
 // CHANGE: ONCE: BEGIN
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
 // ===
 //
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
 INTEGER B = FALSE
 //
 INTEGER changeFileB = FALSE
 //
 STRING directoryRepositoryS[255] = QuotePath( directoryRepositoryInS )
 //
 STRING driveLetterS[255] = SplitPath( directoryRepositoryS, _DRIVE_ )
 //
 STRING executableS[255] = Format( QuotePath( AddTrailingSlash( directoryExecutableS ) ), "git.exe" )
 //
 STRING executableGitkS[255] = Format( QuotePath( AddTrailingSlash( directoryExecutableS ) ), "gitk.exe" )
 //
 STRING executableGitGuiS[255] = Format( QuotePath( AddTrailingSlash( directoryExecutableS ) ), "git-gui.exe" )
 //
 STRING fileNameCurrentS[255] = Quotepath( CurrFilename() )
 //
 STRING fileNameExtensionS[255] = SplitPath( fileNameCurrentS, _NAME_ | _EXT_ )
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
 PushPosition()
 PushBlock()
 //
 s3 = Trim( caseS )
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s077" )
  //
  StartPgm( bookVersionControlWithGitOReillyUrlS )
  //
  B = FNProgramRunGitTseOutputB( s, "s077", FALSE )
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s039" )
  //
  StartPgm( gitTortoiseDownloadUrlS )
  //
  B = FNProgramRunGitTseOutputB( s, "s039", FALSE )
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s038" )
  //
  StartPgm( gitCygwinDownloadUrlS )
  //
  B = FNProgramRunGitTseOutputB( s, "s038", FALSE )
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s097" )
  //
  PushPosition()
  PushBlock()
  //
  EditFile( Format( "-a -s", " ", directoryRepositoryS ) )
  //
  B = FNProgramRunGitTseOutputB( s, "s097", FALSE )
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
  IF NOT FileExists( directoryRepositoryS )
   PROCProgramRunGitTseWindow()
   Warn( "Run the initialize step first to create a Git repository" )
  ELSE
   //
   PROCProgramRunGitTseWindow()
   Warn( "<Press 'Q' to quit>" )
   //
   PROCProgramRunGitTseWindow()
   Warn( "'unknown revision or path not in the working tree' means that the current file or directory is not under version control." )
   //
   PROCProgramRunGitTseWindow()
   IF ( ( Ask( "message = ", messageS, _EDIT_HISTORY_ ) ) AND ( Length( messageS ) > 0 ) )
    //
    s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
    s = Format( s, " ", "&", " " )
    s = Format( s, executableS, " ", "add", " ", "." )
    s = Format( s, " ", "&", " " )
    s = Format( s, executableS, " ", "commit", " ", "-m", " ", '"', messageS, '"' )
    s = Format( s, " ", "&", " " )
    s = Format( s, "pause" )
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
  IF NOT FileExists( directoryRepositoryS )
   PROCProgramRunGitTseWindow()
   Warn( "Run the initialize step first to create a Git repository" )
  ELSE
   //
   PROCProgramRunGitTseWindow()
   Warn( "<Press 'Q' to quit>" )
   //
   PROCProgramRunGitTseWindow()
   Warn( "'unknown revision or path not in the working tree' means that the current file or directory is not under version control." )
   //
   s1 = " "
   PROCProgramRunGitTseWindow()
   IF ( ( Ask( "git command(s) to execute = ", s1, _EDIT_HISTORY_ ) ) AND ( Length( s1 ) > 0 ) )
    s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
    s = Format( s, " ", "&", " " )
    s = Format( s, executableS, " ", s1 )
    s = Format( s, " ", "&", " " )
    s = Format( s, "pause" )
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
  PROCProgramRunGitTseWindow()
  Warn( "<Press 'Q' to quit>" )
  //
  PROCProgramRunGitTseWindow()
  IF ( ( Ask( "local repository where you cloned to to change to = ", s1, _EDIT_HISTORY_ ) ) AND ( Length( s1 ) > 0 ) )
   //
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
    GotoBufferId( bufferI )
    //
    AddLine( GetProfileStr( sectionS, "githubRemoteDirectoryUrlS", "" ) )
    AddLine( GetProfileStr( sectionS, "gitlabRemoteDirectoryUrlS", "" ) )
    //
    GotoLine( 1 )
    PROCProgramRunGitTseWindow()
    IF List( "Choose an option", 80 )
     s1 = Trim( GetText( 1, 255 ) )
    ELSE
     quitB = TRUE
    ENDIF
    AbandonFile( bufferI )
    PopBlock()
    PopPosition()
    //
    PROCProgramRunGitTseWindow()
    IF ( ( Ask( "remote repository directory = ", githubRemoteDirectoryUrlS, _EDIT_HISTORY_ ) ) AND ( Length( githubRemoteDirectoryUrlS ) > 0 ) )
     //
     s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
     s = Format( s, " ", "&", " " )
     s = Format( s, executableS, " ", "ls-remote" )
     s = Format( s, " ", "&", " " )
     s = Format( s, "pause" )
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
  IF NOT FileExists( directoryRepositoryS )
   PROCProgramRunGitTseWindow()
   Warn( "Run the initialize step first to create a Git repository" )
  ELSE
   //
   PROCProgramRunGitTseWindow()
   Warn( "<Press 'Q' to quit>" )
   //
   PROCProgramRunGitTseWindow()
   Warn( "'unknown revision or path not in the working tree' means that the current file or directory is not under version control." )
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
   PROCProgramRunGitTseWindow()
   IF List( "Choose an option", 80 )
    s1 = Trim( GetText( 1, 255 ) )
   ELSE
    quitB = TRUE
   ENDIF
   AbandonFile( bufferI )
   PopBlock()
   PopPosition()
   //
   PROCProgramRunGitTseWindow()
   IF ( ( Ask( "remote repository directory = ", githubRemoteDirectoryUrlS, _EDIT_HISTORY_ ) ) AND ( Length( githubRemoteDirectoryUrlS ) > 0 ) )
    //
    s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
    s = Format( s, " ", "&", " " )
    s = Format( s, executableS, " ", "fetch", " ", githubRemoteDirectoryUrlS )
    s = Format( s, " ", "&", " " )
    s = Format( s, "pause" )
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
  IF NOT FileExists( directoryRepositoryS )
   PROCProgramRunGitTseWindow()
   Warn( "Run the initialize step first to create a Git repository" )
  ELSE
   //
   PROCProgramRunGitTseWindow()
   Warn( "<Press 'Q' to quit>" )
   //
   PROCProgramRunGitTseWindow()
   Warn( "'unknown revision or path not in the working tree' means that the current file or directory is not under version control." )
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
   PROCProgramRunGitTseWindow()
   IF List( "Choose an option", 80 )
    s1 = Trim( GetText( 1, 255 ) )
   ELSE
    quitB = TRUE
   ENDIF
   AbandonFile( bufferI )
   PopBlock()
   PopPosition()
   //
   PROCProgramRunGitTseWindow()
   IF ( ( Ask( "remote repository directory = ", githubRemoteDirectoryUrlS, _EDIT_HISTORY_ ) ) AND ( Length( githubRemoteDirectoryUrlS ) > 0 ) )
    s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
    s = Format( s, " ", "&", " " )
    s = Format( s, executableS, " ", "pull", " ", githubRemoteDirectoryUrlS ) // pull = fetch + merge
    s = Format( s, " ", "&", " " )
    s = Format( s, "pause" )
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
  IF NOT FileExists( directoryRepositoryS )
   PROCProgramRunGitTseWindow()
   Warn( "Run the initialize step first to create a Git repository" )
  ELSE
   //
   PROCProgramRunGitTseWindow()
   Warn( "<Press 'Q' to quit>" )
   //
   PROCProgramRunGitTseWindow()
   Warn( "'unknown revision or path not in the working tree' means that the current file or directory is not under version control." )
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
   PROCProgramRunGitTseWindow()
   IF List( "Choose an option", 80 )
    s1 = Trim( GetText( 1, 255 ) )
   ELSE
    quitB = TRUE
   ENDIF
   AbandonFile( bufferI )
   PopBlock()
   PopPosition()
   //
   PROCProgramRunGitTseWindow()
   IF ( ( Ask( "remote repository directory = ", githubRemoteDirectoryUrlS, _EDIT_HISTORY_ ) ) AND ( Length( githubRemoteDirectoryUrlS ) > 0 ) )
    s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
    s = Format( s, " ", "&", " " )
    s = Format( s, executableS, " ", "push", " ", githubRemoteDirectoryUrlS )
    s = Format( s, " ", "&", " " )
    s = Format( s, "pause" )
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
  s = Format( s, executableS, " ", "help", " ", "--al" )
  s = Format( s, " ", "&", " " )
  s = Format( s, "pause" )
  B = FNProgramRunGitTseOutputB( s, "s072", TRUE )
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s073" )
  //
  s = Format( s, executableS )
  s = Format( s, " ", "&", " " )
  s = Format( s, "pause" )
  B = FNProgramRunGitTseOutputB( s, "s073", TRUE )
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s070" )
  //
  s = Format( s, executableS, " ", "help", " ", "-a" )
  s = Format( s, " ", "&", " " )
  s = Format( s, "pause" )
  B = FNProgramRunGitTseOutputB( s, "s070", TRUE )
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s071" )
  //
  s = Format( s, executableS, " ", "help", " ", "-g" )
  s = Format( s, " ", "&", " " )
  s = Format( s, "pause" )
  B = FNProgramRunGitTseOutputB( s, "s071", TRUE )
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s074" )
  //
  s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
  s = Format( s, " ", "&", " " )
  s = Format( s, "tree", " ", ".git" )
  s = Format( s, " ", "&", " " )
  s = Format( s, "pause" )
  B = FNProgramRunGitTseOutputB( s, "s074", TRUE )
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s049" )
  //
  s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
  s = Format( s, " ", "&", " " )
  s = Format( s, executableGitGuiS )
  s = Format( s, " ", "&", " " )
  s = Format( s, "pause" )
  B = FNProgramRunGitTseOutputB( s, "s049", TRUE )
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s048" )
  //
  s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
  s = Format( s, " ", "&", " " )
  s = Format( s, executableGitkS )
  s = Format( s, " ", "&", " " )
  s = Format( s, "pause" )
  B = FNProgramRunGitTseOutputB( s, "s048", TRUE )
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s030" )
  //
  s = Format( s, executableS, " ", "remote" )
  s = Format( s, " ", "&", " " )
  s = Format( s, "pause" )
  B = FNProgramRunGitTseOutputB( s, "s030", TRUE )
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s031" )
  //
  s = Format( s, executableS, " ", "remote", " ", "-v" )
  s = Format( s, " ", "&", " " )
  s = Format( s, "pause" )
  B = FNProgramRunGitTseOutputB( s, "s031", TRUE )
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s050" )
  //
  PROCProgramRunGitTseWindow()
  Warn( directoryRepositoryS )
  //
  B = FNProgramRunGitTseOutputB( s, "s050", FALSE )
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s046" )
  //
  StartPgm( executableCommandLineS )
  //
  B = FNProgramRunGitTseOutputB( s, "s046", FALSE )
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s086" )
  //
  s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
  s = Format( s, " ", "&", " " )
  s = Format( s, executableS, " ", "stash", " ", "push" )
  s = Format( s, " ", "&", " " )
  s = Format( s, "pause" )
  B = FNProgramRunGitTseOutputB( s, "s086", TRUE )
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s087" )
  //
  s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
  s = Format( s, " ", "&", " " )
  s = Format( s, executableS, " ", "stash", " ", "pop" )
  s = Format( s, " ", "&", " " )
  s = Format( s, "pause" )
  B = FNProgramRunGitTseOutputB( s, "s087", TRUE )
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s088" )
  //
  s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
  s = Format( s, " ", "&", " " )
  s = Format( s, executableS, " ", "bisect", " ", "start" )
  s = Format( s, " ", "&", " " )
  s = Format( s, "pause" )
  B = FNProgramRunGitTseOutputB( s, "s088", TRUE )
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s089" )
  //
  s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
  s = Format( s, " ", "&", " " )
  s = Format( s, executableS, " ", "bisect", " ", "bad" )
  s = Format( s, " ", "&", " " )
  s = Format( s, "pause" )
  B = FNProgramRunGitTseOutputB( s, "s089", TRUE )
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s090" )
  //
  s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
  s = Format( s, " ", "&", " " )
  s = Format( s, executableS, " ", "bisect", " ", "good" )
  s = Format( s, " ", "&", " " )
  s = Format( s, "pause" )
  B = FNProgramRunGitTseOutputB( s, "s090", TRUE )
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s091" )
  s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
  s = Format( s, " ", "&", " " )
  s = Format( s, executableS, " ", "bisect", " ", "reset" )
  s = Format( s, " ", "&", " " )
  s = Format( s, "pause" )
  B = FNProgramRunGitTseOutputB( s, "s091", TRUE )
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s044" )
  //
  s1 = " "
  PROCProgramRunGitTseWindow()
  IF ( ( Ask( "other branch name to merge = ", s1, _EDIT_HISTORY_ ) ) AND ( Length( s1 ) > 0 ) )
   //
   s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
   s = Format( s, " ", "&", " " )
   s = Format( s, executableS, " ", "merge", " ", s1 )
   s = Format( s, " ", "&", " " )
   s = Format( s, "pause" )
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
  PROCProgramRunGitTseWindow()
  IF ( ( Ask( "branch name to delete = ", s1, _EDIT_HISTORY_ ) ) AND ( Length( s1 ) > 0 ) )
   //
   s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
   s = Format( s, " ", "&", " " )
   s = Format( s, executableS, " ", "branch", " ", "-d", " ", s1 )
   s = Format( s, " ", "&", " " )
   s = Format( s, "pause" )
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
  PROCProgramRunGitTseWindow()
  IF ( ( Ask( "new branch name to create = ", s1, _EDIT_HISTORY_ ) ) AND ( Length( s1 ) > 0 ) )
   //
   s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
   s = Format( s, " ", "&", " " )
   s = Format( s, executableS, " ", "branch", " ", s1 )
   s = Format( s, " ", "&", " " )
   s = Format( s, "pause" )
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
  s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
  s = Format( s, " ", "&", " " )
  s = Format( s, executableS, " ", "branch", " ", "--show-current" )
  s = Format( s, " ", "&", " " )
  s = Format( s, "pause" )
  B = FNProgramRunGitTseOutputB( s, "s051", TRUE )
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s052" )
  //
  s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
  s = Format( s, " ", "&", " " )
  s = Format( s, executableS, " ", "branch" )
  s = Format( s, " ", "&", " " )
  s = Format( s, "pause" )
  B = FNProgramRunGitTseOutputB( s, "s052", TRUE )
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s053" )
  //
  s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
  s = Format( s, " ", "&", " " )
  s = Format( s, executableS, " ", "show-branch", " ", "-a" )
  s = Format( s, " ", "&", " " )
  s = Format( s, "pause" )
  B = FNProgramRunGitTseOutputB( s, "s053", TRUE )
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s021" )
  //
  s1 = " "
  PROCProgramRunGitTseWindow()
  IF ( ( Ask( "change to branch name = ", s1, _EDIT_HISTORY_ ) ) AND ( Length( s1 ) > 0 ) )
   //
   s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
   s = Format( s, " ", "&", " " )
   s = Format( s, executableS, " ", "checkout", " ", s1 )
   s = Format( s, " ", "&", " " )
   s = Format( s, "pause" )
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
  s = Format( s, executableS, " ", "--version" )
  s = Format( s, " ", "&", " " )
  s = Format( s, "pause" )
  B = FNProgramRunGitTseOutputB( s, "s076", TRUE )
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s043" )
  //
  PushPosition()
  PushBlock()
  //
  s = QuotePath( directoryRepositoryS )
  PROCProgramRunGitTseWindow()
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
    PROCProgramRunGitTseWindow()
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
  PROCProgramRunGitTseWindow()
  IF ( ( Ask( "old filename = ", filenameOldS, _EDIT_HISTORY_ ) ) AND ( Length( filenameOldS ) > 0 ) )
   PROCProgramRunGitTseWindow()
   IF ( ( Ask( "new filename = ", filenameNewS, _EDIT_HISTORY_ ) ) AND ( Length( filenameNewS ) > 0 ) )
    s = Format( s, executableS, " ", "mv", " ", fileNameOldS, " ", fileNameNewS )
    s = Format( s, " ", "&", " " )
    s = Format( s, executableS, " ", "commit", " ", "-m", " ", '"', messageS, '"' )
    s = Format( s, " ", "&", " " )
    s = Format( s, "pause" )
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
  StartPgm( gitScmDownloadUrlS )
  //
  B = FNProgramRunGitTseOutputB( s, "s011", FALSE )
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s012" )
  //
  PROCProgramRunGitTseWindow()
  IF ( ( Ask( "your local repository directory to initialize = ", directoryRepositoryS, _EDIT_HISTORY_ ) ) AND ( Length( directoryRepositoryS ) > 0 ) )
   //
   // check if repository directory exists, if not existing then warn and create it
   //
   IF NOT FileExists( directoryRepositoryS )
    //
    PROCProgramRunGitTseWindow()
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
   B = FNProgramRunGitTseOutputB( s, "s012", TRUE )
   //
  ENDIF
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s013" )
  //
  PROCProgramRunGitTseWindow()
  IF ( ( Ask( "user name = ", userNameS, _EDIT_HISTORY_ ) ) AND ( Length( userNameS ) > 0 ) )
   //
   s = Format( executableS, " ", "config", " ", "--global", " ", "user.name", " ", '"', userNameS, '"' )
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
  PROCProgramRunGitTseWindow()
  IF ( ( Ask( "user email = ", userEmailS, _EDIT_HISTORY_ ) ) AND ( Length( userEmailS ) > 0 ) )
   //
   s = Format( executableS, " ", "config", " ", "--global", " ", "user.email", " ", '"', userEmailS, '"' )
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
  IF NOT FileExists( directoryRepositoryS )
   PROCProgramRunGitTseWindow()
   Warn( "Run the initialize step first to create a Git repository" )
   //
  ELSE
   //
   PROCProgramRunGitTseWindow()
   IF ( ( Ask( "message = ", messageS, _EDIT_HISTORY_ ) ) AND ( Length( messageS ) > 0 ) )
    //
    s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
    s = Format( s, " ", "&", " " )
    //
    // IF NOT FileExists( fileNameCurrentS )
     s = Format( s, "copy", " ", fileNameCurrentS )
     s = Format( s, " ", "&", " " )
    // ENDIF
    //
    s = Format( s, executableS, " ", "add", " ", fileNameExtensionS )
    s = Format( s, " ", "&", " " )
    s = Format( s, executableS, " ", "commit", " ", "-m", " ", '"', messageS, '"', " ", fileNameExtensionS )
    // Dos( Format( s, " ", "2>&1" ), _START_HIDDEN_ )
    // Dos( Format( s, " ", "2>&1" ), _DONT_PROMPT_ )
    s = Format( s, " ", "&", " " )
    s = Format( s, "pause" )
    B = FNProgramRunGitTseOutputB( s, "s010", TRUE )
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
  s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
  // s = Format( s, " ", "&", " " )
  // s = Format( s, "keystack", " ", '"', githubUserNameS, '"', " ", "enter", " ", '"', githubPasswordS, '"', " ", "enter" )
  s = Format( s, " ", "&", " " )
  s = Format( s, executableS, " ", "push", " ", "--set-upstream", " ", githubRemoteDirectoryUrlS, " ", githubNameBranchS )
  s = Format( s, " ", "&", " " )
  s = Format( s, "pause" )
  B = FNProgramRunGitTseOutputB( s, "s018", TRUE )
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s019" )
  //
  PROCProgramRunGitTseWindow()
  IF ( ( Ask( "remote repository directory = ", gitlabRemoteDirectoryUrlS, _EDIT_HISTORY_ ) ) AND ( Length( gitlabRemoteDirectoryUrlS ) > 0 ) )
   //
   PROCProgramRunGitTseWindow()
   IF ( ( Ask( "branch remote repository directory (TRUNK|main|master) = ", gitlabNameBranchS, _EDIT_HISTORY_ ) ) AND ( Length( gitlabNameBranchS ) > 0 ) )
    //
    s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
    // s = Format( s, " ", "&", " " )
    // s = Format( s, "keystack", " ", '"', githubUserNameS, '"', " ", "enter", " ", '"', githubPasswordS, '"', " ", "enter" )
    s = Format( s, " ", "&", " " )
    s = Format( s, executableS, " ", "push", " ", "--set-upstream", " ", gitlabRemoteDirectoryUrlS, " ", gitlabNameBranchS )
    s = Format( s, " ", "&", " " )
    s = Format( s, "pause" )
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
  directoryRepositoryOtherS = " "
  //
  PROCProgramRunGitTseWindow()
  IF ( ( Ask( "other local repository directory  = ", directoryRepositoryOtherS, _EDIT_HISTORY_ ) ) AND ( Length( directoryRepositoryS ) > 0 ) )
   //
   IF NOT FileExists( directoryRepositoryOtherS )
    //
    PROCProgramRunGitTseWindow()
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
   PROCProgramRunGitTseWindow()
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
   PROCProgramRunGitTseWindow()
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
    PROCProgramRunGitTseWindow()
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
     PROCProgramRunGitTseWindow()
     IF ( ( Ask( "remote repository directory = ", gitBranchRemoteDirectoryUrlS, _EDIT_HISTORY_ ) ) AND ( Length( gitBranchRemoteDirectoryUrlS ) > 0 ) )
      //
      IF EquiStr( Trim( gitBranchRemoteDirectoryUrlS ), "" )
       //
       s = Format( s, executableS, " ", "clone", " ", gitRemoteDirectoryUrlS, " ", gitBranchRemoteDirectoryUrlS, " ", directoryRepositoryOtherS )
       //
      ELSE
       s = Format( s, executableS, " ", "clone", " ", gitRemoteDirectoryUrlS, " ", "--branch", " ", gitBranchRemoteDirectoryUrlS, " ", directoryRepositoryOtherS )
       //
      ENDIF
      //
      s = Format( s, " ", "&", " " )
      s = Format( s, "pause" )
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
  Warn( "Do not use this example. When stopping it using <CTRL C> it will crash TSE. Additionally is it a very large directory, maybe 5 to 10 gigabytes" ) Halt
  //
  directoryRepositoryOtherS = " "
  //
  PROCProgramRunGitTseWindow()
  IF ( ( Ask( "other local repository directory (must be empty) = ", directoryRepositoryOtherS, _EDIT_HISTORY_ ) ) AND ( Length( directoryRepositoryS ) > 0 ) )
   //
   IF FileExists( directoryRepositoryOtherS )
    //
    PROCProgramRunGitTseWindow()
    Warn( "Make sure an empty directory should be created. It must not be an existing directory. Please check." )
    //
   ELSE
    //
    PROCProgramRunGitTseWindow()
    IF ( FNMathGetNumberInputYesNoCancelPositionDefaultI( Format( directoryRepositoryOtherS, ":", " ", "This other Git repository directory does not exist. Create it now?" ) ) == 1 )
     //
     directoryRepositoryOtherS = QuotePath( directoryRepositoryOtherS )
     //
     MkDir( directoryRepositoryOtherS )
     //
    ENDIF
    //
    s = Format( s, executableS, " ", "clone", " ", cloneRemoteWebSiteExampleS, " ", "", " ", directoryRepositoryOtherS ) // debug further
    s = Format( s, " ", "&", " " )
    s = Format( s, "pause" )
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
  directoryRepositoryOtherS = " "
  PROCProgramRunGitTseWindow()
  IF ( ( Ask( "local repository to copy current local repository to = ", directoryRepositoryOtherS, _EDIT_HISTORY_ ) ) AND ( Length( directoryRepositoryS ) > 0 ) )
   //
   IF NOT FileExists( directoryRepositoryOtherS )
    //
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
   // s = Format( s, " ", "&", " " )
   // s = Format( s, "keystack", " ", '"', githubUserNameS, '"', " ", "enter", " ", '"', githubPasswordS, '"', " ", "enter" )
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
  IF NOT FileExists( directoryRepositoryS )
   PROCProgramRunGitTseWindow()
   Warn( "Run the initialize step first to create a Git repository" )
   //
  ELSE
   //
   IF ( FNMathGetNumberInputYesNoCancelPositionDefaultI( Format( fileNameExtensionS, ":", " ", "Are you sure that you want to delete and remove this file from the repository?" ) ) == 1 )
    //
    PROCProgramRunGitTseWindow()
    IF ( ( Ask( "message = ", messageS, _EDIT_HISTORY_ ) ) AND ( Length( messageS ) > 0 ) )
     //
     s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
     // s = Format( s, " ", "&", " " )
     // s = Format( s, "keystack", " ", '"', githubUserNameS, '"', " ", "enter", " ", '"', githubPasswordS, '"', " ", "enter" )
     s = Format( s, " ", "&", " " )
     s = Format( s, executableS, " ", "rm", " ", fileNameExtensionS )
     s = Format( s, " ", "&", " " )
     s = Format( s, executableS, " ", "commit", " ", "-m", " ", '"', messageS, '"', " ", fileNameExtensionS )
     s = Format( s, " ", "&", " " )
     s = Format( s, "pause" )
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
 IF s3 == GetGlobalStr( "s056" )
  //
  IF NOT FileExists( directoryRepositoryS )
   PROCProgramRunGitTseWindow()
   Warn( "Run the initialize step first to create a Git repository" )
  ELSE
   //
   PROCProgramRunGitTseWindow()
   Warn( "<Press 'Q' to quit>" )
   //
   PROCProgramRunGitTseWindow()
   Warn( "'unknown revision or path not in the working tree' means that the current file or directory is not under version control." )
   //
   s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
   s = Format( s, " ", "&", " " )
   s = Format( s, executableS, " ", "blame", " ", fileNameExtensionS )
   s = Format( s, " ", "&", " " )
   s = Format( s, "pause" )
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
  PROCProgramRunGitTseWindow()
  IF ( ( Ask( "local repository to change to = ", directoryRepositoryOtherS, _EDIT_HISTORY_ ) ) AND ( Length( directoryRepositoryOtherS ) > 0 ) )
   //
   IF ( FNMathGetNumberInputYesNoCancelPositionDefaultI( Format( directoryRepositoryOtherS, ":", " ", "Do you want to change to this other Git repository directory?" ) ) == 1 )
    //
    IF NOT FileExists( directoryRepositoryOtherS )
     //
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
    directoryRepositoryOtherS = QuotePath( directoryRepositoryOtherS )
    //
    WriteProfileStr( sectionS, "directoryRepositoryInS", directoryRepositoryOtherS, iniFileNameS ) // this is now changed to your current repository directory
    //
    directoryRepositoryS = directoryRepositoryOtherS
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
 IF s3 == GetGlobalStr( "s085" )
  //
  IF NOT FileExists( directoryRepositoryS )
   PROCProgramRunGitTseWindow()
   Warn( "Run the initialize step first to create a Git repository" )
  ELSE
   //
   PROCProgramRunGitTseWindow()
   Warn( "<Press 'Q' to quit>" )
   //
   PROCProgramRunGitTseWindow()
   Warn( "'unknown revision or path not in the working tree' means that the current file or directory is not under version control." )
   //
   s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
   s = Format( s, " ", "&", " " )
   s = Format( s, executableS, " ", "reset", " ", "HEAD", " ", fileNameExtensionS )
   s = Format( s, " ", "&", " " )
   s = Format( s, "pause" )
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
  IF NOT FileExists( directoryRepositoryS )
   PROCProgramRunGitTseWindow()
   Warn( "Run the initialize step first to create a Git repository" )
  ELSE
   //
   PROCProgramRunGitTseWindow()
   Warn( "<Press 'Q' to quit>" )
   //
   IF ( FNMathGetNumberInputYesNoCancelPositionDefaultI( "Are you really sure you want to overwrite and replace the current version with an older version?" ) == 1 )
    //
    PROCProgramRunGitTseWindow()
    Warn( "'unknown revision or path not in the working tree' means that the current file or directory is not under version control." )
    //
    s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
    s = Format( s, " ", "&", " " )
    s = Format( s, executableS, " ", "checkout", " ", "HEAD~6", " ", "--", " ", fileNameExtensionS )
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
  IF NOT FileExists( directoryRepositoryS )
   PROCProgramRunGitTseWindow()
   Warn( "Run the initialize step first to create a Git repository" )
  ELSE
   //
   PROCProgramRunGitTseWindow()
   Warn( "<Press 'Q' to quit>" )
   //
   IF ( FNMathGetNumberInputYesNoCancelPositionDefaultI( "Are you really sure you want to overwrite and replace the current version with an older version?" ) == 1 )
    //
    PROCProgramRunGitTseWindow()
    Warn( "'unknown revision or path not in the working tree' means that the current file or directory is not under version control." )
    //
    s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
    s = Format( s, " ", "&", " " )
    s = Format( s, executableS, " ", "checkout", " ", "HEAD~2", " ", "--", " ", fileNameExtensionS )
    s = Format( s, " ", "&", " " )
    s = Format( s, "pause" )
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
  IF NOT FileExists( directoryRepositoryS )
   PROCProgramRunGitTseWindow()
   Warn( "Run the initialize step first to create a Git repository" )
  ELSE
   //
   PROCProgramRunGitTseWindow()
   Warn( "<Press 'Q' to quit>" )
   //
   IF ( FNMathGetNumberInputYesNoCancelPositionDefaultI( "Are you really sure you want to overwrite and replace the current version with an older version?" ) == 1 )
    //
    PROCProgramRunGitTseWindow()
    Warn( "'unknown revision or path not in the working tree' means that the current file or directory is not under version control." )
    //
    s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
    s = Format( s, " ", "&", " " )
    s = Format( s, executableS, " ", "checkout", " ", "HEAD~3", " ", "--", " ", fileNameExtensionS )
    s = Format( s, " ", "&", " " )
    s = Format( s, "pause" )
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
  IF NOT FileExists( directoryRepositoryS )
   PROCProgramRunGitTseWindow()
   Warn( "Run the initialize step first to create a Git repository" )
  ELSE
   //
   PROCProgramRunGitTseWindow()
   Warn( "<Press 'Q' to quit>" )
   //
   IF ( FNMathGetNumberInputYesNoCancelPositionDefaultI( "Are you really sure you want to overwrite and replace the current version with an older version?" ) == 1 )
    //
    PROCProgramRunGitTseWindow()
    Warn( "'unknown revision or path not in the working tree' means that the current file or directory is not under version control." )
    //
    s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
    s = Format( s, " ", "&", " " )
    s = Format( s, executableS, " ", "checkout", " ", "HEAD~4", " ", "--", " ", fileNameExtensionS )
    s = Format( s, " ", "&", " " )
    s = Format( s, "pause" )
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
  IF NOT FileExists( directoryRepositoryS )
   PROCProgramRunGitTseWindow()
   Warn( "Run the initialize step first to create a Git repository" )
  ELSE
   //
   PROCProgramRunGitTseWindow()
   Warn( "<Press 'Q' to quit>" )
   //
   IF ( FNMathGetNumberInputYesNoCancelPositionDefaultI( "Are you really sure you want to overwrite and replace the current version with an older version?" ) == 1 )
    //
    PROCProgramRunGitTseWindow()
    Warn( "'unknown revision or path not in the working tree' means that the current file or directory is not under version control." )
    //
    s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
    s = Format( s, " ", "&", " " )
    s = Format( s, executableS, " ", "checkout", " ", "HEAD~5", " ", "--", " ", fileNameExtensionS )
    s = Format( s, " ", "&", " " )
    s = Format( s, "pause" )
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
  IF NOT FileExists( directoryRepositoryS )
   PROCProgramRunGitTseWindow()
   Warn( "Run the initialize step first to create a Git repository" )
  ELSE
   //
   PROCProgramRunGitTseWindow()
   Warn( "<Press 'Q' to quit>" )
   //
   IF ( FNMathGetNumberInputYesNoCancelPositionDefaultI( "Are you really sure you want to overwrite and replace the current version with an older version?" ) == 1 )
    //
    PROCProgramRunGitTseWindow()
    Warn( "'unknown revision or path not in the working tree' means that the current file or directory is not under version control." )
    //
    s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
    s = Format( s, " ", "&", " " )
    s = Format( s, executableS, " ", "checkout", " ", "HEAD~6", " ", "--", " ", fileNameExtensionS )
    s = Format( s, " ", "&", " " )
    s = Format( s, "pause" )
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
  IF NOT FileExists( directoryRepositoryS )
   PROCProgramRunGitTseWindow()
   Warn( "Run the initialize step first to create a Git repository" )
  ELSE
   //
   PROCProgramRunGitTseWindow()
   Warn( "<Press 'Q' to quit>" )
   //
   PROCProgramRunGitTseWindow()
   Warn( "'unknown revision or path not in the working tree' means that the current file or directory is not under version control." )
   //
   IF ( FNMathGetNumberInputYesNoCancelPositionDefaultI( "Are you really sure you want to overwrite and replace the current version with an older version?" ) == 1 )
    //
    s1 = "7"
    PROCProgramRunGitTseWindow()
    IF ( ( Ask( "N = ", s1, _EDIT_HISTORY_ ) ) AND ( Length( s1 ) > 0 ) )
     s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
     s = Format( s, " ", "&", " " )
     s = Format( s, executableS, " ", "checkout", " ", "HEAD~", s1, " ", "--", " ", fileNameExtensionS )
     s = Format( s, " ", "&", " " )
     s = Format( s, "pause" )
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
  IF NOT FileExists( directoryRepositoryS )
   PROCProgramRunGitTseWindow()
   Warn( "Run the initialize step first to create a Git repository" )
  ELSE
   //
   PROCProgramRunGitTseWindow()
   Warn( "<Press 'Q' to quit>" )
   //
   PROCProgramRunGitTseWindow()
   Warn( "'unknown revision or path not in the working tree' means that the current file or directory is not under version control." )
   //
   s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
   s = Format( s, " ", "&", " " )
   s = Format( s, executableS, " ", "diff", " ", "HEAD~1", " ", fileNameExtensionS )
   s = Format( s, " ", "&", " " )
   s = Format( s, "pause" )
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
  IF NOT FileExists( directoryRepositoryS )
   PROCProgramRunGitTseWindow()
   Warn( "Run the initialize step first to create a Git repository" )
  ELSE
   //
   PROCProgramRunGitTseWindow()
   Warn( "<Press 'Q' to quit>" )
   //
   PROCProgramRunGitTseWindow()
   Warn( "'unknown revision or path not in the working tree' means that the current file or directory is not under version control." )
   //
   s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
   s = Format( s, " ", "&", " " )
   s = Format( s, executableS, " ", "diff", " ", "HEAD~2", " ", fileNameExtensionS )
   s = Format( s, " ", "&", " " )
   s = Format( s, "pause" )
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
  IF NOT FileExists( directoryRepositoryS )
   PROCProgramRunGitTseWindow()
   Warn( "Run the initialize step first to create a Git repository" )
  ELSE
   //
   PROCProgramRunGitTseWindow()
   Warn( "<Press 'Q' to quit>" )
   //
   PROCProgramRunGitTseWindow()
   Warn( "'unknown revision or path not in the working tree' means that the current file or directory is not under version control." )
   //
   s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
   s = Format( s, " ", "&", " " )
   s = Format( s, executableS, " ", "diff", " ", "HEAD~3", " ", fileNameExtensionS )
   s = Format( s, " ", "&", " " )
   s = Format( s, "pause" )
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
  IF NOT FileExists( directoryRepositoryS )
   PROCProgramRunGitTseWindow()
   Warn( "Run the initialize step first to create a Git repository" )
  ELSE
   //
   PROCProgramRunGitTseWindow()
   Warn( "<Press 'Q' to quit>" )
   //
   PROCProgramRunGitTseWindow()
   Warn( "'unknown revision or path not in the working tree' means that the current file or directory is not under version control." )
   //
   s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
   s = Format( s, " ", "&", " " )
   s = Format( s, executableS, " ", "diff", " ", "HEAD~4", " ", fileNameExtensionS )
   s = Format( s, " ", "&", " " )
   s = Format( s, "pause" )
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
  IF NOT FileExists( directoryRepositoryS )
   PROCProgramRunGitTseWindow()
   Warn( "Run the initialize step first to create a Git repository" )
  ELSE
   //
   PROCProgramRunGitTseWindow()
   Warn( "<Press 'Q' to quit>" )
   //
   PROCProgramRunGitTseWindow()
   Warn( "'unknown revision or path not in the working tree' means that the current file or directory is not under version control." )
   //
   s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
   s = Format( s, " ", "&", " " )
   s = Format( s, executableS, " ", "diff", " ", "HEAD~5", " ", fileNameExtensionS )
   s = Format( s, " ", "&", " " )
   s = Format( s, "pause" )
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
  IF NOT FileExists( directoryRepositoryS )
   PROCProgramRunGitTseWindow()
   Warn( "Run the initialize step first to create a Git repository" )
  ELSE
   //
   PROCProgramRunGitTseWindow()
   Warn( "<Press 'Q' to quit>" )
   //
   PROCProgramRunGitTseWindow()
   Warn( "'unknown revision or path not in the working tree' means that the current file or directory is not under version control." )
   //
   s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
   s = Format( s, " ", "&", " " )
   s = Format( s, executableS, " ", "diff", " ", "HEAD~6", " ", fileNameExtensionS )
   s = Format( s, " ", "&", " " )
   s = Format( s, "pause" )
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
  IF NOT FileExists( directoryRepositoryS )
   PROCProgramRunGitTseWindow()
   Warn( "Run the initialize step first to create a Git repository" )
  ELSE
   //
   PROCProgramRunGitTseWindow()
   Warn( "<Press 'Q' to quit>" )
   //
   PROCProgramRunGitTseWindow()
   Warn( "'unknown revision or path not in the working tree' means that the current file or directory is not under version control." )
   //
   s1 = "7"
   PROCProgramRunGitTseWindow()
   IF ( ( Ask( "N = ", s1, _EDIT_HISTORY_ ) ) AND ( Length( s1 ) > 0 ) )
    s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
    s = Format( s, " ", "&", " " )
    s = Format( s, executableS, " ", "diff", " ", "HEAD~", s1, " ", fileNameExtensionS )
    s = Format( s, " ", "&", " " )
    s = Format( s, "pause" )
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
  IF NOT FileExists( directoryRepositoryS )
   PROCProgramRunGitTseWindow()
   Warn( "Run the initialize step first to create a Git repository" )
  ELSE
   //
   PROCProgramRunGitTseWindow()
   Warn( "<Press 'Q' to quit>" )
   //
   PROCProgramRunGitTseWindow()
   Warn( "'unknown revision or path not in the working tree' means that the current file or directory is not under version control." )
   //
   s1 = "2"
   s2 = "3"
   PROCProgramRunGitTseWindow()
   IF ( ( Ask( "M = ", s1, _EDIT_HISTORY_ ) ) AND ( Length( s1 ) > 0 ) )
    //
    PROCProgramRunGitTseWindow()
    IF ( ( Ask( "N = ", s2, _EDIT_HISTORY_ ) ) AND ( Length( s2 ) > 0 ) )
     //
     s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
     s = Format( s, " ", "&", " " )
     s = Format( s, executableS, " ", "diff", " ", "HEAD~", s1, " ", "HEAD~", s2, " ", fileNameExtensionS )
     s = Format( s, " ", "&", " " )
     s = Format( s, "pause" )
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
  IF NOT FileExists( directoryRepositoryS )
   PROCProgramRunGitTseWindow()
   Warn( "Run the initialize step first to create a Git repository" )
  ELSE
   //
   PROCProgramRunGitTseWindow()
   Warn( "<Press 'Q' to quit>" )
   //
   PROCProgramRunGitTseWindow()
   Warn( "'unknown revision or path not in the working tree' means that the current file or directory is not under version control." )
   //
   s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
   s = Format( s, " ", "&", " " )
   s = Format( s, executableS, " ", "diff", " ", fileNameExtensionS )
   s = Format( s, " ", "&", " " )
   s = Format( s, "pause" )
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
  IF NOT FileExists( directoryRepositoryS )
   PROCProgramRunGitTseWindow()
   Warn( "Run the initialize step first to create a Git repository" )
  ELSE
   //
   PROCProgramRunGitTseWindow()
   Warn( "<Press 'Q' to quit>" )
   //
   s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
   s = Format( s, " ", "&", " " )
   s = Format( s, executableS, " ", "log", " ", "--oneline" )
   s = Format( s, " ", "&", " " )
   s = Format( s, "pause" )
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
  IF NOT FileExists( directoryRepositoryS )
   PROCProgramRunGitTseWindow()
   Warn( "Run the initialize step first to create a Git repository" )
  ELSE
   //
   PROCProgramRunGitTseWindow()
   Warn( "<Press 'Q' to quit>" )
   //
   s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
   s = Format( s, " ", "&", " " )
   s = Format( s, executableS, " ", "log" )
   s = Format( s, " ", "&", " " )
   s = Format( s, "pause" )
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
  IF NOT FileExists( directoryRepositoryS )
   PROCMacroRunKeep( "ssetwiyde" ) // operation: set: window: warn/yesno: position: x: y: default // new
   Warn( "Run the initialize step first to create a Git repository" )
  ELSE
   //
   PROCProgramRunGitTseWindow()
   Warn( "<Press 'Q' to quit>" )
   //
   s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
   s = Format( s, " ", "&", " " )
   s = Format( s, executableS, " ", "show" )
   s = Format( s, " ", "&", " " )
   s = Format( s, "pause" )
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
  IF NOT FileExists( directoryRepositoryS )
   PROCProgramRunGitTseWindow()
   Warn( "Run the initialize step first to create a Git repository" )
  ELSE
   //
   PROCProgramRunGitTseWindow()
   Warn( "<Press 'Q' to quit>" )
   //
   s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
   s = Format( s, " ", "&", " " )
   s = Format( s, executableS, " ", "status" )
   s = Format( s, " ", "&", " " )
   s = Format( s, "pause" )
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
  StartPgm( githubRemoteDirectoryUrlS )
  //
  B = FNProgramRunGitTseOutputB( s, "s041", FALSE )
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s042" )
  //
  StartPgm( gitlabRemoteDirectoryUrlS )
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
  s1 = GetProfileStr( sectionS, "githubRemoteDirectoryCreateUrlS", "", iniFileNameS )
  //
  StartPgm( s1 )
  //
  B = FNProgramRunGitTseOutputB( s, "s095", FALSE )
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s096" )
  //
  s1 = GetProfileStr( sectionS, "gitlabRemoteDirectoryCreateUrlS", "", iniFileNameS )
  //
  StartPgm( s1 )
  //
  B = FNProgramRunGitTseOutputB( s, "s096", FALSE )
  //
 ENDIF
 //
 // ------------------------------------------------------------------------------
 //
 IF s3 == GetGlobalStr( "s022" )
  //
  PROCProgramRunGitTseWindow()
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
  PushPosition()
  PushBlock()
  IF EditFile( iniFileNameS )
   QuitFile()
  ENDIF
  EditFile( iniFileNameS )
  IF LFind( sectionS, "" )
   ScrollToTop()
  ELSE
   PROCProgramRunGitTseWindow()
   Warn( "no expected session", ":", " ", "[", sectionS, "]", " ", "found in", iniFileNameS, ". Please add it + add the parameters" )
  ENDIF
  //
  UpDateDisplay() // IF WaitForKeyPressed( 0 ) ENDIF // Activate if using a loop
  //
  B = FNProgramRunGitTseOutputB( s, "s015", FALSE )
  //
  PROCProgramRunGitTseWindow()
  Warn( "<Press any key to continue>" )
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
  PushPosition()
  PushBlock()
  EditFile( directoryRepositoryS )
  //
  B = FNProgramRunGitTseOutputB( s, "s040", FALSE )
  //
  PROCProgramRunGitTseWindow()
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
 IF s3 == GetGlobalStr( "s055" )
  //
  PushPosition()
  PushBlock()
  s = QuotePath( Format( AddTrailingSlash( directoryRepositoryS ), ".gitignore" ) )
  IF EditFile( s )
   QuitFile()
   EditFile( s )
  ELSE
   //
   PROCProgramRunGitTseWindow()
   //
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
  PROCProgramRunGitTseWindow()
  Warn( "<Press any key to continue>" )
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
  PushPosition()
  PushBlock()
  s = QuotePath( Format( AddTrailingSlash( directoryRepositoryS ), ".git\config" ) )
  IF EditFile( s )
   QuitFile()
   EditFile( s )
   B = FNProgramRunGitTseOutputB( s, "s054", FALSE )
  ELSE
   PROCProgramRunGitTseWindow()
   Warn( "File", ":", " ", s, " ", "not found. Please check." )
   B = FNProgramRunGitTseOutputB( Format( "File", ":", " ", s, " ", "not found." ), "s054", FALSE )
  ENDIF
  UpDateDisplay() // IF WaitForKeyPressed( 0 ) ENDIF // Activate if using a loop
  //
  PROCProgramRunGitTseWindow()
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
  PushPosition()
  PushBlock()
  s = QuotePath( Format( "c:\", AddTrailingSlash( GetEnvStr( "HOMEPATH" ) ), ".gitconfig" ) )
  IF EditFile( s )
   QuitFile()
   EditFile( s )
   B = FNProgramRunGitTseOutputB( s, "s092", FALSE )
  ELSE
   PROCProgramRunGitTseWindow()
   Warn( "File", ":", " ", s, " ", "not found. Please check." )
   B = FNProgramRunGitTseOutputB( Format( "File", ":", " ", s, " ", "not found." ), "s092", FALSE )
  ENDIF
  UpDateDisplay() // IF WaitForKeyPressed( 0 ) ENDIF // Activate if using a loop
  //
  PROCProgramRunGitTseWindow()
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
  PushPosition()
  PushBlock()
  s = gitLogFileS
  IF EditFile( s )
   QuitFile()
   EditFile( s )
   EndFile() // new [kn, ri, mo, 21-11-2022 04:24:47]
   BegLine() // new [kn, ri, mo, 21-11-2022 12:13:49]
  ELSE
   PROCProgramRunGitTseWindow()
   Warn( "File", ":", " ", s, " ", "not found. Please check." )
  ENDIF
  UpDateDisplay() // IF WaitForKeyPressed( 0 ) ENDIF // Activate if using a loop
  //
  B = FNProgramRunGitTseOutputB( s, "s075", FALSE )
  //
  PROCProgramRunGitTseWindow()
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
  PushPosition()
  PushBlock()
  //
  s = Format( AddTrailingSlash( GetProfileStr( sectionS, "directoryExecutableS", "", iniFileNameS ) ), "git.exe" )
  //
  PROCProgramRunGitTseWindow()
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
  IF NOT FileExists( directoryRepositoryS )
   PROCProgramRunGitTseWindow()
   Warn( "Run the initialize step first to create a Git repository" )
  ELSE
   //
   PROCProgramRunGitTseWindow()
   Warn( "<Press 'Q' to quit>" )
   //
   PROCProgramRunGitTseWindow()
   Warn( "'unknown revision or path not in the working tree' means that the current file or directory is not under version control." )
   //
   s1 = " "
   s2 = " "
   PROCProgramRunGitTseWindow()
   IF ( ( Ask( "From directory = ", s1, _EDIT_HISTORY_ ) ) AND ( Length( s1 ) > 0 ) )
    //
    PROCProgramRunGitTseWindow()
    IF ( ( Ask( "To directory = ", s2, _EDIT_HISTORY_ ) ) AND ( Length( s2 ) > 0 ) )
     //
     // s = Format( "copy", " ", "/s", " ", s1, " ", s2 )
     s = Format( "xcopy", " ", "/s", " ", s1, " ", s2 )
     s = Format( s, " ", "&", " " )
     s = Format( s, "pause" )
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
  IF NOT FileExists( directoryRepositoryS )
   PROCProgramRunGitTseWindow()
   Warn( "Run the initialize step first to create a Git repository" )
  ELSE
   //
   PROCProgramRunGitTseWindow()
   Warn( "<Press 'Q' to quit>" )
   //
   PROCProgramRunGitTseWindow()
   Warn( "'unknown revision or path not in the working tree' means that the current file or directory is not under version control." )
   //
   s1 = " "
   s2 = " "
   PROCProgramRunGitTseWindow()
   IF ( ( Ask( "old alias name = ", s1, _EDIT_HISTORY_ ) ) AND ( Length( s1 ) > 0 ) )
    //
    PROCProgramRunGitTseWindow()
    IF ( ( Ask( "new alias name = ", s2, _EDIT_HISTORY_ ) ) AND ( Length( s2 ) > 0 ) )
     //
     s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
     s = Format( s, " ", "&", " " )
     s = Format( s, executableS, " ", "remote", " ", "rename", " ", s1, " ", s2 )
     s = Format( s, " ", "&", " " )
     s = Format( s, "pause" )
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
  IF NOT FileExists( directoryRepositoryS )
   PROCProgramRunGitTseWindow()
   Warn( "Run the initialize step first to create a Git repository" )
  ELSE
   //
   PROCProgramRunGitTseWindow()
   Warn( "<Press 'Q' to quit>" )
   //
   PROCProgramRunGitTseWindow()
   Warn( "'unknown revision or path not in the working tree' means that the current file or directory is not under version control." )
   //
   s1 = " "
   s2 = githubRemoteDirectoryUrlS
   PROCProgramRunGitTseWindow()
   IF ( ( Ask( "alias name = ", s1, _EDIT_HISTORY_ ) ) AND ( Length( s1 ) > 0 ) )
    //
    PROCProgramRunGitTseWindow()
    IF ( ( Ask( "url = ", s2, _EDIT_HISTORY_ ) ) AND ( Length( s2 ) > 0 ) )
     //
     s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
     s = Format( s, " ", "&", " " )
     s = Format( s, executableS, " ", "remote", " ", "add", " ", s1, " ", s2 )
     s = Format( s, " ", "&", " " )
     s = Format( s, "pause" )
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
  IF NOT FileExists( directoryRepositoryS )
   PROCProgramRunGitTseWindow()
   Warn( "Run the initialize step first to create a Git repository" )
  ELSE
   //
   PROCProgramRunGitTseWindow()
   Warn( "<Press 'Q' to quit>" )
   //
   PROCProgramRunGitTseWindow()
   Warn( "'unknown revision or path not in the working tree' means that the current file or directory is not under version control." )
   //
   s1 = " "
   PROCProgramRunGitTseWindow()
   IF ( ( Ask( "alias name = ", s1, _EDIT_HISTORY_ ) ) AND ( Length( s1 ) > 0 ) )
    //
    s = Format( driveLetterS, " ", "&", " ", "cd", " ", directoryRepositoryS )
    s = Format( s, " ", "&", " " )
    s = Format( s, executableS, " ", "remote", " ", "rm", " ", s1 )
    s = Format( s, " ", "&", " " )
    s = Format( s, "pause" )
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
 // OTHERWISE
 //  //
 //  PROCProgramRunGitTseWindow()
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

// library: program: run: dos: git <description></description> <version control></version control> <version>1.0.0.0.28</version> <version control></version control> (filenamemacro=runprdgi.s) [<Program>] [<Research>] [kn, ri, sa, 19-11-2022 13:41:15]
INTEGER PROC FNProgramRunGitTseOutputB( STRING s, STRING caseS, INTEGER dosB )
 // e.g. PROC Main()
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
