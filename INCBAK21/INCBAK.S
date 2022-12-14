//***************************************************************************
//
// This macro creates an incrementing backup file name on file saves instead
// of the standard .BAK so that you can have multiple backup copies.
// If you have a file called TEST.PAS, when you save the file it will make
// a backup called TEST.PA0.  The next will be TEST.PA1 up to TEST.999.
//
// ASSUMPTIONS: This procedure is hooked to the _ON_FILE_SAVE_ in the
//              WhenLoaded() procedure as follows:
//
// 浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様?
// ? proc WhenLoaded()                                             ?
// ?   integer cid = GetBufferId()                                 ?
// ?                                                               ?
// ?   pick_buffer = CreateTempBuffer()                            ?
// ?   GotoBufferId(cid)                                           ?
// ?                                                               ?
// ?   compress_hist = GetFreeHistory()                            ?
// ?   compress_options_history = GetFreeHistory()                 ?
// ?   AddHistoryStr(Query(FindOptions), compress_options_history) ?
// ?                                                               ?
// ?   named_clip_hist = GetFreeHistory()                          ?
// ?                                                               ?
// ?   Hook(_ON_CHANGING_FILES_, OnChangingFiles)                  ?
// ?   Hook(_ON_FIRST_EDIT_, OnFirstEdit)                          ?
// ?                                                               ?
// ?   Hook(_ON_FILE_SAVE_, mIncBak)   //Adds Incrementing Backups ?
// ? end                                                           ?
// 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様?
//
// In TSE.CFG, under the System/File Options, you must set MakeBackups
// equal to Off as follows.
//
// 浜様様様様様様様様様様様様様様?
// ?// System/File Options       ?
// ?                             ?
// ?MakeBackups             = Off?
// 藩様様様様様様様様様様様様様様?
//
// If you wish, you can add something to the "Options" menu to indicate the
// incremental backup status.  Here is how I have that menu in my TSE.UI file:
//
// 浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様?
// ?Menu OptionsMenu()                                                                     ?
// ?    history                                                                            ?
// ?                                                                                       ?
// ?    "&AutoIndent"           [MenuStr(AutoIndentMenu,query(AutoIndent)+1) : 6],         ?
// ?                            AutoIndentMenu()            ,   DontClose                  ?
// ?    "&WordWrap"             [OnOffStr(query(WordWrap))   : 3],                         ?
// ?                            Toggle(WordWrap)            ,   DontClose                  ?
// ?    "&Right Margin"         [query(RightMargin) : 5],                                  ?
// ?                            set(RightMargin, ReadNum(Query(RightMargin))),   DontClose ?
// ?    "&Left Margin"          [query(LeftMargin) : 5],                                   ?
// ?                            set(LeftMargin, ReadNum(Query(LeftMargin))),   DontClose   ?
// ?    ""                          ,                   ,   Divide                         ?
// ?    "Tab Ty&pe"             [MenuStr(TabTypeMenu,query(TabType)+1) : 8],               ?
// ?                            TabTypeMenu()               ,   DontClose                  ?
// ?    "&Tab Width"            [query(TabWidth) : 5],                                     ?
// ?                            set(TabWidth, ReadNum(Query(TabWidth))),   DontClose       ?
// ?    ""                          ,                   ,   Divide                         ?
// ?    "&Backups"              [OnOffStr(Query(MakeBackups)) : 3],                        ?
// ?                            Toggle(MakeBackups)         ,   DontClose                  ?
// ?    "&Inc Backups"          [OnOffStr(DoIncBak) : 3],               //Add for Inc Back ?
// ?                            mToggle(DoIncBak),   DontClose          //Add for Inc Back ?
// ?    ""                          ,                   ,   Divide                         ?
// ?    "&Full Configuration  ",          ExecMacro("iconfig"),DontClose                  ?
// ?    "&Save Current Settings  ",       mSaveSettings()                                 ?
// ?end                                                                                    ?
// 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様?
//
// The last thing to do is to include this file, "INCBAK.S" into your TSE.UI
// or where ever you put your custom macros so that it is burned into TSE.
//
// Your files will now be saved with incrementing file extensions.
//
// You can toggle making the incremental backups via the menu as seen above,
// or assign mToggle(DoIncBak) to a key.
//
//***************************************************************************
//
// PARAMETERS:  None
//
// RETURNS:     TRUE or FALSE
//
// GLOBAL VARS: DoIncBak - indicates whether incrementing backup should be made
//
// LOCAL VARS:  fn  - local string to hold file path and name
//              ext - local string to hold file extension
//              c   - local integer to create incrementing backup name
//
// CREATED:         15-APR-93  v1.0 Tom Kellen
//
// MODIFICATIONS:   28-SEP-94  TAK  v2.0    Updated to use internal functions in
//                                          TSE v2.0
//
//                  11-OCT-94  TAK  v2.1    Optimized and simplified code.
//                                          It now makes backup versions to
//                                          .999 and will give a warning if
//                                          it is unable to make a backup
//                                          file.
//
//***************************************************************************



//** This is a Global Variable indicating whether backups should be made **//
integer DoIncBak = true


//** This is a generic procedure to toggle the DoIncBak Global Variable **//
proc mToggle (var integer x)
    x = not x
end


/**************************************************************************
  This macro is called when saving a file instead of Save() to create
  self incrementing backup file names.
 **************************************************************************/

integer proc mIncBak()
    string fn[80] = SplitPath(CurrFileName(), _DRIVE_ | _NAME_)
    string ext[4] = SplitPath(CurrFileName(), _EXT_)
    integer c

    if not DoIncBak         // If this isn't set, don't make a backup
        return (false)
    endif

    if ext == ''            // If the file name doesn't have an extension,
        ext = '.'           // then add a dot to the ext variable.
    endif
    ext = substr(format(ext:-4:"0"), 1, 3)  // Pad the extension with 0's

    c = 0

    repeat
        case c
            when 10                        // Shorten the ext variable by 1 to
                ext = substr (ext, 1, 2)   // handle double digit versions.
            when 100                       // Shorten the ext variable by 1 to
                ext = substr (ext, 1, 1)   // handle triple digit versions.
        endcase
        if not FileExists (fn + ext + Str (c))
            RenameDiskFile (CurrFileName(), fn + ext + Str (c))
            return (true)
        else
            c = c + 1
        endif
    until c > 999

    alarm()
    warn('Unable to create backup file ' + fn + ext + Str (c))

    return (false)
end mIncBak
