 PROC Main()
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
  */
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
  */
  INTEGER downB = TRUE
  //
  STRING s1[255] = ""
  STRING s2[255] = ""
  //
  INTEGER I1 = 0
  INTEGER I2 = 0
  //
  INTEGER B = FALSE
  //
  IF ( NOT ( IsBlockInCurrFile() ) ) Warn( "Please mark a block" ) RETURN() ENDIF // return from the current procedure if no block is marked
  //
  Set( BREAK, ON )
  //
  PushPosition()
  PushBlock()
  //
  GotoBlockEnd()
  AddLine( "Q" )
  //
  GotoBlockBegin()
  //
  WHILE ( ( IsCursorInBlock() ) AND ( downB ) )
   //
   // skip empty lines
   //
   IF NOT LFind( "^$", "cgx" )
    //
    GotoColumn( 3 ) // go past the first ':' after the drive letter
    IF LFind( ":", "c" ) // search for the first filename
     I1 = CurrCol()
     s1 = GetText( 1, I1 - 1 )
    ENDIF
    //
    PushPosition()
    PushBlock()
    //
    Down()
    GotoColumn( 3 ) // go past the first ':' after the drive letter
    IF LFind( ":", "c" ) // search for the filename below the current line
     I2 = CurrCol()
     s2 = GetText( 1, I2 - 1 )
    ENDIF
    Up()
    //
    Warn( s1; s2 ) // debug
    UpDateDisplay() // IF WaitForKeyPressed( 0 ) ENDIF // Activate if using a loop // debug
    //
    IF EquiStr( s1, s2 ) AND ( B == FALSE )
     B = TRUE
     InsertLine( Format( "File:", " ", s1 ) )
     Down()
    ENDIF
    //
    IF ( NOT EquiStr( s1, s2 ) ) AND ( B == TRUE )
     B = FALSE
    ENDIF
    //
    PushBlock()
    PushPosition()
    GotoColumn( 1 )
    MarkStream()
    GotoColumn( I1 )
    MarkStream()
    Cut()
    // BegLine()
    // IF LFind( "[0-9]#\c", "cx" )
    //  InsertText( ":", _INSERT_ )
    // ENDIF
    // Right()
    // WHILE CurrChar() == Asc( " " )
    // DelChar()
    // ENDWHILE
    PopBlock()
    PopPosition()
    //
    PopBlock()
    PopPosition()
    //
   ENDIF
   //
   downB = Down()
   //
  ENDWHILE
  //
  IF LFind( "^Q$", "gx" )
   DelLine()
  ENDIF
  //
  PopPosition()
  PopBlock()
  //
 END
