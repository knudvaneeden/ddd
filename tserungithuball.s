FORWARD INTEGER PROC FNProgramRunTseGithubAllB()
FORWARD PROC Main()
FORWARD STRING PROC FNStringGetCarS( STRING s1 )


// --- MAIN --- //

#DEFINE ELIST_INCLUDED FALSE
#include [ "eList.s" ]
//
PROC Main()
 Message( FNProgramRunTseGithubAllB() ) // gives e.g. TRUE
END

<F12> Main()

// --- LIBRARY --- //

// library: program: run: tse: github: all <description></description> <version control></version control> <version>1.0.0.0.18</version> <version control></version control> (filenamemacro=tserungithuball.s) [<Program>] [<Research>] [kn, ri, mo, 12-12-2022 21:00:22]
INTEGER PROC FNProgramRunTseGithubAllB()
 // e.g. #DEFINE ELIST_INCLUDED FALSE
 // e.g. #include [ "eList.s" ]
 // e.g. //
 // e.g. PROC Main()
 // e.g.  Message( FNProgramRunTseGithubAllB() ) // gives e.g. TRUE
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
 // e.g. // QuickHelp( HELPDEFFNProgramRunTseGithubAllB )
 // e.g. HELPDEF HELPDEFFNProgramRunTseGithubAllB
 // e.g.  title = "FNProgramRunTseGithubAllB() help" // The help's caption
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
 STRING s1[255] = ""
 //
 INTEGER bufferI = 0
 //
 STRING fileNameS[255] = "c:\temp\dddloggithub.log" // change this
 //
 REPEAT
  //
  PushPosition()
  bufferI = CreateTempBuffer()
  PopPosition()
  //
  PushPosition()
  PushBlock()
  //
  IF GotoBufferId( bufferI )
   PushBlock()
   PushPosition()
   ExecMacro( "tserungithuballline" )
   AddLine( "quit" )
   PurgeMacro( "tserungithuballline" )
   PopBlock()
   PopPosition()
  ENDIF
  //
  GotoLine( 1 )
  IF eList( "Choose an option" )
   s1 = Trim( GetText( 1, 255 ) )
  ELSE
   AbandonFile( bufferI )
   PopBlock()
   PopPosition()
   RETURN( FALSE )
  ENDIF
  AbandonFile( bufferI )
  PopBlock()
  PopPosition()
  //
  // do something with s1
  //
  PushPosition()
  PushBlock()
  EditFile( fileNameS )
  EndFile()
  Set( TimeFormat, 3 ) // 24 hour format and zero in front in time format
  AddLine( Format( "[", GetDateStr(), " ", GetTimeStr(), "]", ",", " ", s1 ) )
  EndLine()
  SaveAs( fileNameS, _OVERWRITE_ )
  PopBlock()
  PopPosition()
  //
  s1 = FNStringGetCarS( s1 )
  //
  PushBlock()
  PushPosition()
  ExecMacro( s1 )
  UpDateDisplay() // IF WaitForKeyPressed( 0 ) ENDIF // Activate if using a loop
  PopBlock()
  PopPosition()
  //
 UNTIL EquiStr( s1, "quit" )
 //
 B = TRUE
 //
 RETURN( B )
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
