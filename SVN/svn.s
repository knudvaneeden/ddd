// Revision: 14970
//
// ===
//
// Macro     Svn.s
// Author    Carlo.Hogeveen@xs4all.nl
// Date      25 May 2012
// Version   See the history and the help_text.
//
// ===
//
// Purpose:
//   The fastest possible Subversion browser.
//
// Why:
//   Tortoisesvn is beyond too slow for directories with many files.
//
// Trade-off:
//   A selected file's Subversion-properties are initially not shown.
//
// Installation:
//   The "svn" macro is "just" a shell around the "svn" commandline tool,
//   which is [a part of] the actual Subversion tool.
//   Therefore the commandline-tool "svn" must be installed and in the PATH
//   environment variable, either in general or from where TSE is started.
//
//   Either download the latest version of TortoiseSVN (1.7.7 as I write,
//   which also includes and installs "SVN") from
//   http://tortoisesvn.net/downloads.html ,
//
//   or download one of the binary packages for "svn" for Windows at the
//   bottom of the page of
//   http://subversion.apache.org/packages.html .
//
//   As for the macro, just put it in TSE's "mac" directory,
//   and compile and execute it.
//
// Features:
//   Browsing the HEAD of a Subversion repository's directories and files,
//   view their info, properties, and history, and read or edit [the historic
//   version of] a file (without saving to the repository).
//
// NOT a feature (yet):
//   Subversion security: the repository must either be publicly accessible,
//   or the username and password must already be locally stored
//   by (Tortoise)SVN itself.
//
// Wishlist:
// MUST
// - Being asked for a username and password when required by the repository.
// SHOULD
// - Closing a selected historic object should return to the history-list.
// - Being able to browse historic repository directories.
// - In the history-list you should not be able to select the separation lines.
// - Putting the @<revision> before the file-extension to enable
//   syntax-hiliting.
// COULD
// - Being able to compare two versions.
// WOULD
// - Make the macro also compileable to a .exe.
//
// History:
// 0.9   25 May 2012
//   - Initial version.
// 0.9.1  3 Jun 2012
//   - If started from the command-line with "-eSvn" and no file was opened
//     for editing, then TSE is closed with the macro.
// 0.9.2  25 Feb 2013
//     - Changed the helptext and a warning to English.
//
#DEFINE LANGUAGE _DEFAULT_
//
DATADEF help_text
 'This is fast Subversion browser, specifically intended for browsing'
 'those really large large directories, for which TortoiseSVN would take'
 'minutes instead of seconds.'
 ''
 'The top of the screen shows which object is currently selected.'
 'A @ followed by a revisionnumber indicates you look'
 'at that historic version (revision) of the object.'
 'Is there no @, then you look at the latest version.'
 ''
 'The bottom of the screen continuously shows possible actions.'
 'A file is opened for read first, and for editing separately.'
 'Editing leaves the browser, and does not mean you can Save the file'
 '(directly) but "only" that you get all the editing options of TSE.'
 '"Props" stands for "Properties": an object' + "'s Subversion-properties."
 ''
 'In a list and when reading a file you can type a string of'
 'characters to quickly go to their first occurrence.'
 'For instance, type "props" now.'
 ''
 'Browse keys: Arrow(Up/Down), PageUp, PageDown, Home, End.'
END help_text
//
#DEFINE STATE_ERROR     0
#DEFINE STATE_OK        1
#DEFINE STATE_STOPPED   3
//
STRING curr_list[ MAXSTRINGLEN ] = ''
STRING file_revision[ MAXSTRINGLEN ] = ''
STRING list_header[ MAXSTRINGLEN ] = ''
STRING log_file[ MAXSTRINGLEN ] = ''
INTEGER log_id = 0
STRING list_footer[ MAXSTRINGLEN ] = ''
STRING macro_name[ MAXSTRINGLEN ] = ''
STRING next_list[ MAXSTRINGLEN ] = 'browse'
INTEGER org_id = 0
STRING selected_file[ MAXSTRINGLEN ] = ''
STRING selected_property[ MAXSTRINGLEN ] = ''
//
// STRING versionControlExecutableS[ MAXSTRINGLEN ] = "c:\program files\tortoisesvn\bin\svn.exe" // change this // [kn, ri, fr, 19-08-2022 12:22:17]
STRING versionControlExecutableS[ MAXSTRINGLEN ] = "g:\cygwin\bin\svn.exe" // change this // [kn, ri, fr, 19-08-2022 12:22:17]
//
KEYDEF extra_list_keys
 <f1> next_list = 'help' PushKey(<Enter>)
 <f5> next_list = 'log'  PushKey(<Enter>)
 <f8> next_list = 'info' PushKey(<Enter>)
 <f9> next_list = 'proplist' PushKey(<Enter>)
END
//
INTEGER PROC get_dos( STRING cmd )
 INTEGER result = FALSE
 EraseDiskFile( log_file )
 IF Dos( cmd + ' > ' + QuotePath( log_file ) + ' 2>&1', _START_HIDDEN_ )
  GotoBufferId( log_id )
  EmptyBuffer()
  IF FileExists( log_file )
   InsertFile( log_file, _DONT_PROMPT_ )
   UnMarkBlock()
   EndFile()
   WHILE ( ( CurrLine() > 1 ) AND ( CurrLineLen() == 0 ) )
    KillLine()
    Up()
   ENDWHILE
   BegFile()
   EraseDiskFile( log_file )
   result = TRUE
  ENDIF
 ENDIF
 RETURN( result )
END get_dos
//
PROC show_dos_error( STRING text )
 STRING warning[ MAXSTRINGLEN ] = text
 BegFile()
 REPEAT
  warning = warning + Chr( 13 ) + RTrim( GetText( 1, MAXSTRINGLEN ) )
 UNTIL NOT Down()
 Warn( warning )
END show_dos_error
//
INTEGER PROC set_log_file()
 INTEGER org_id = GetBufferId()
 INTEGER result = STATE_ERROR
 STRING tmp_dir[ MAXSTRINGLEN ] = ''
 IF GetEnvStr( 'tmp' ) <> ''
  tmp_dir = GetEnvStr( 'tmp' )
  ELSEIF GetEnvStr( 'temp' ) <> ''
  tmp_dir = GetEnvStr( 'temp' )
  ELSE
  tmp_dir = 'c:'
 ENDIF
 IF tmp_dir[Length( tmp_dir )] <> '\'
  tmp_dir = tmp_dir + '\'
 ENDIF
 IF ( FileExists( tmp_dir ) & _DIRECTORY_ )
  log_file = tmp_dir + 'TseSvn.log'
  log_id   = EditFile( log_file, _DONT_PROMPT_ )
  IF log_id
   EmptyBuffer()
   InsertText( 'Hello world!' )
   IF SaveAs( CurrFilename(), _DONT_PROMPT_|_OVERWRITE_ )
    result = STATE_OK
    ELSE
    AbandonFile( log_id )
   ENDIF
   GotoBufferId( org_id )
  ENDIF
 ENDIF
 IF result <> STATE_OK
  Warn( 'Error: cannot create a temporary file: ', log_file )
 ENDIF
 RETURN( result )
END set_log_file
//
INTEGER PROC ask_repository( VAR STRING repository, VAR STRING dir, VAR STRING selected )
 INTEGER state = STATE_OK
 STRING request[ MAXSTRINGLEN ] = '/cygdrive/c/TEMP/W1' // added [kn, ri, sa, 13-08-2022 16:00:23]
 // IF  Ask( 'Subversion repository, directory OR selected:',
 IF Ask( 'Subversion working directory OR selected:', request, GetFreeHistory( macro_name + ':request' ) )
  request = Trim( request )
  WHILE SubStr( request, Length( request ), 1 ) == '/'
   request = SubStr( request, 1, Length( request ) - 1 )
  ENDWHILE
  IF request == ''
   state = STATE_STOPPED
   ELSE
   IF get_dos( QuotePath( versionControlExecutableS ) + ' ' + 'info ' + QuotePath( request ) )
    IF LFind( '^Repository Root: ', 'gx' )
     repository = Trim( GetText( 18, MAXSTRINGLEN ) )
     IF LFind( '^URL: ', 'gx' )
      dir = Trim( GetText( 6 + Length( repository ), MAXSTRINGLEN ) )
      IF LFind( '^Node Kind: {directory}|{selected}', 'gx' )
       IF LFind( '^Node Kind: selected', 'cgx' )
        selected = GetToken( dir, '/\', NumTokens( dir, '/\' ) )
        dir  = SubStr( dir, 1, Length( dir ) - Length( selected ) - 1 )
        ELSE
        selected = ''
       ENDIF
       ELSE
       state = STATE_ERROR
       show_dos_error( 'Error: no line starting with "Node Kind: file|directory".' )
      ENDIF
     ENDIF
     ELSE
     state = STATE_ERROR
     show_dos_error( 'Error: no line starting with "Repository Root: ".' )
    ENDIF
    ELSE
    state = STATE_ERROR
   ENDIF
  ENDIF
  ELSE
  state = STATE_STOPPED
 ENDIF
 RETURN( state )
END ask_repository
//
PROC list_startup()
 UnHook( list_startup )
 CASE next_list
  WHEN 'browse'
  Enable( extra_list_keys )
 ENDCASE
 ListFooter( list_footer )
END list_startup
//
PROC list_cleanup()
 Disable( extra_list_keys )
END list_cleanup
//
INTEGER PROC browse_repository( string repository, VAR STRING dir )
 INTEGER old_msglevel = 0
 INTEGER state = STATE_OK
 list_header = repository + IIF( dir == '', '', '/' + dir ) + IIF( selected_file == '', '', '/' + selected_file ) + IIF( file_revision == '', '', '@' + file_revision )
 list_footer = '{Enter}-Back {Escape}-Back'
 curr_list   = next_list
 CASE next_list
  WHEN 'browse'
  list_header = repository + IIF( dir == '', '', '/' + dir )
  list_footer = '{F1}-Help {F5}-Hist {F8}-Info {F9}-Props {Enter}-Read {Esc}-Quit'
  get_dos( QuotePath( versionControlExecutableS ) + ' ' + 'list ' + QuotePath( repository + '/' + dir ) )
  IF LFind( '^svn: ', 'gx' )
   state = STATE_ERROR
   show_dos_error( 'Error:' )
   ELSE
   MarkLine( 1, NumLines() )
   old_msglevel = Set( MsgLevel, _WARNINGS_ONLY_ )
   ExecMacro( 'sort -i' )
   Set( MsgLevel, old_msglevel )
   UnMarkBlock()
   // Temporarily add a line, because searching 'somthing$' with 'bgx'
   // fails ( erroneously! ) WHEN the file contains a single line.
   EndFile()
   AddLine( '' )
   WHILE LFind( '/$', 'bgx' )
    MarkColumn( CurrLine(), 1, CurrLine(), CurrCol() - 1 )
    Copy()
    KillLine()
    BegFile()
    InsertLine( '/' )
    EndLine()
    Paste()
    UnMarkBlock()
   ENDWHILE
   EndFile()
   KillLine()
   BegFile()
   IF dir == ''
    InsertLine( '/.' )
    ELSE
    InsertLine( '/..' )
   ENDIF
  ENDIF
  LFind( selected_file, 'g' )
  WHEN 'cat'
  list_footer = '{Enter}-Edit {Escape}-Back'
  get_dos( QuotePath( versionControlExecutableS ) + ' ' + 'cat ' + IIF( file_revision == '', '', '-r' + file_revision + ' ' ) + QuotePath( repository + '/' + dir + '/' + selected_file ) )
  IF LFind( '^svn: ', 'gx' )
   state = STATE_ERROR
   show_dos_error( 'Error:' )
  ENDIF
  WHEN 'edit'
  get_dos( QuotePath( versionControlExecutableS ) + ' ' + 'cat ' + IIF( file_revision == '', '', '-r' + file_revision + ' ' ) + QuotePath( repository + '/' + dir + '/' + selected_file ) )
  IF LFind( '^svn: ', 'gx' )
   state = STATE_ERROR
   show_dos_error( 'Error:' )
   ELSE
   MarkLine( 1, NumLines() )
   Copy()
   org_id = NewFile()
   Paste()
   UnMarkBlock()
   ChangeCurrFilename( list_header, _DONT_EXPAND_ )
   state = STATE_STOPPED
  ENDIF
  WHEN 'help'
  EmptyBuffer()
  InsertData( help_text )
  BegFile()
  WHEN 'info'
  get_dos( QuotePath( versionControlExecutableS ) + ' ' + 'info ' + QuotePath( repository + '/' + dir + '/' + selected_file ) )
  IF LFind( '^svn: ', 'gx' )
   state = STATE_ERROR
   show_dos_error( 'Error:' )
  ENDIF
  WHEN 'log'
  list_footer = '{Enter}-Read {Esc}-Back'
  get_dos( QuotePath( versionControlExecutableS ) + ' ' + 'log ' + QuotePath( repository + '/' + dir + '/' + selected_file ) )
  IF LFind( '^svn: ', 'gx' )
   state = STATE_ERROR
   show_dos_error( 'Error:' )
   ELSE
   WHILE LFind( '^$', 'gx' )
    KillLine()
   ENDWHILE
  ENDIF
  WHEN 'proplist'
  get_dos( QuotePath( versionControlExecutableS ) + ' ' + 'proplist -v ' + QuotePath( repository + '/' + dir + '/' + selected_file ) )
  IF LFind( '^svn: ', 'gx' )
   state = STATE_ERROR
   show_dos_error( 'Error:' )
   ELSE
   LFind( selected_property, 'g' )
  ENDIF
  OTHERWISE
  Warn( 'Error: unknown action ( 1 ).' )
  state = STATE_ERROR
 ENDCASE
 IF state == STATE_OK
  Hook( _LIST_STARTUP_, list_startup )
  Hook( _LIST_CLEANUP_, list_cleanup )
  IF List( list_header, Max( Max( Length( list_header ), Length( list_footer ) ), LongestLineInBuffer() ) )
   UnHook( list_cleanup )
   CASE curr_list
    WHEN 'browse'
    selected_file = GetText( 1, CurrLineLen() )
    IF next_list == 'browse'
     IF selected_file == '/..'
      selected_file = '/' + SplitPath( dir, _NAME_|_EXT_ )
      dir  = SplitPath( dir, _PATH_ )
      IF SubStr( dir, Length( dir ), 1 ) == '/'
       dir = SubStr( dir, 1, Length( dir ) - 1 )
      ENDIF
      ELSEIF selected_file == '/.'
      dir = dir
      ELSEIF SubStr( selected_file, 1, 1 ) == '/'
      IF dir == ''
       dir = SubStr( selected_file, 2, MAXSTRINGLEN )
       ELSE
       dir = dir + selected_file
      ENDIF
      ELSE
      next_list     = 'cat'
      file_revision = ''
     ENDIF
     ELSE
     IF selected_file == '/..'
      next_list = 'browse'
     ENDIF
    ENDIF
    WHEN 'cat'
    next_list = 'edit'
    WHEN 'help'
    next_list = 'browse'
    WHEN 'info'
    next_list = 'browse'
    WHEN 'log'
    IF LFind( '^-#$', 'cgx' )
     next_list = 'log'
     ELSE
     IF NOT LFind( '^r[0-9]# \| ', 'cgx' )
      Up()
      IF NOT LFind( '^r[0-9]# \| ', 'cgx' )
       Down()
      ENDIF
     ENDIF
     IF LFind( '^r[0-9]# \| ', 'cgx' )
      LFind( '[0-9]#', 'cgx' )
      file_revision = GetFoundText()
      next_list     = 'cat'
      ELSE
      next_list     = 'log'
     ENDIF
    ENDIF
    WHEN 'proplist'
    next_list = 'browse'
    OTHERWISE
    Warn( 'Error: unknown action ( 2 ).' )
    state = STATE_ERROR
   ENDCASE
   ELSE
   CASE curr_list
    WHEN 'browse'
    state = STATE_STOPPED
    WHEN 'cat'
    next_list = 'browse'
    WHEN 'help'
    next_list = 'browse'
    WHEN 'info'
    next_list = 'browse'
    WHEN 'log'
    next_list = 'browse'
    WHEN 'proplist'
    next_list = 'browse'
    OTHERWISE
    Warn( 'Error: unknown action ( 3 ).' )
    state = STATE_ERROR
   ENDCASE
  ENDIF
 ENDIF
 RETURN( state )
END browse_repository
//
PROC WhenLoaded()
 macro_name = SplitPath( CurrMacroFilename(), _NAME_ )
END WhenLoaded
//
PROC Main()
 STRING  dir[ MAXSTRINGLEN ] = ''
 STRING  repository[ MAXSTRINGLEN ] = ''
 INTEGER state = STATE_OK
 org_id = GetBufferId()
 state = set_log_file()
 WHILE state == STATE_OK
  state = ask_repository( repository, dir, selected_file )
  WHILE state == STATE_OK
   state = browse_repository( repository, dir )
  ENDWHILE
 ENDWHILE
 GotoBufferId( org_id )
 AbandonFile( log_id )
 PurgeMacro( macro_name )
 IF ( ( Lower( Trim( Query( DosCmdLine ) ) ) IN '-esvn', '-e svn' ) AND ( NumFiles() == 1 ) AND ( Pos( 'unnamed', Lower( CurrFilename() ) ) > 0 ) )
  AbandonEditor()
 ENDIF
END Main
