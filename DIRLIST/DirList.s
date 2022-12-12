/*
  Macro           DirList
  Author          Carlo Hogeveen
  Version         v3.1   -   8 Jan 2020
  Compatibility   TSE Pro v4.0 upwards

  With direcories as input this tool creates a new file inside TSE,
  containing a list of all files in those directories and their
  subdirectories.

  For example, "C:\ D:\" would be valid input if your system has those drives.

  There are four known cases in which a folder or file is not listed or wrongly
  listed. They are explained in more detail further on.
  Here is a short overview:
  - If the full name of a parent folder has a too deep path, then the child
    folders and files will not be listed.
  - If the name of a folder or file contains ANSI-incompatible characters,
    then Windows converts such characters to their closest ANSI equivalent,
    and shows TSE the converted but therefore wrong name.
  - If the full name of a parent folder contains ANSI-incompatible characters,
    then the child folders and files will not be listed.
  - On 64-bit systems Windows hides some system folders and files from 32-bit
    programs like TSE, for example "C:\Windows\System32\drivers\etc\hosts".

  This tool mitigates these flaws by marking such folders and files or their
  parent folders as "inaccessible".


  TOO DEEP PATHS

  Because TSE's string limit is 255 characters and because TSE uses the old
  Windows ANSI APIs which are likewise string limited, TSE can list the
  contents of a folder if its full path has no more than 255 characters.
  The first consequence is, that such a folder itself is inaccessible to TSE,
  and that all its contents are invisible to TSE.
  The second consequence is, that TSE can still "see" the name of a child
  folder or file with a full name of more than 255 characters if the full name
  of their parent folder is less than 255 characters, but that TSE can not
  access such child folders and files.


  ANSI-INCOMPATIBLE CHARACTERS IN NAME

  Windows folder and file names are stored in UTF-16LE, and thus support
  all Unicode characters, which number over 137.000 as of Unicode 12.1.
  TSE only supports ANSI (a.k.a. "Windows-1252") which has 218 characters.
  TSE uses the old Windows ANSI APIs to access Windows folders and files.
  This has the benefit that if a Unicode character has an ANSI equivalent,
  then the Windows API converts the character back and forth.
  For instance, the Unicode character "latin small letter e with acute" exists
  in ANSI too, and the Windows API makes TSE think it reads and write the ANSI
  character for folder and file names.
  For Unicode characters without an ANSI equivalent the Windows API converts
  the Unicode character one-way to a close ANSI alternative for TSE to see.
  For instance, in folder and file names TSE sees the Greek letter alpha and
  other close "foreign" (to ANSI) characters as an "a".
  But having seen that, TSE can not open such a folder or file because its
  actual name does not contain an "a", and the low-level Windows API does not
  know, remember, or want to guess which foreign character that "a" came from.
  So, for Windows folder and file names that contain a Unicode character that
  has no ANSI equivalent DirList will show a close alternative character and
  mark the folder or file in the list as "inaccessible".


  INVISIBLE 64-BIT FOLDERS AND FILES

  This problem only exists on 64-bit systems.
  For backwards compatibility both 32-bit and 64-bit programs can and
  should access "C:\Windows\System32" to get to Windows programs and files
  that perform Windows tasks.
  But typically those programs and files differ for 32-bit and 64-bit.
  Windows solves this as follows:
  - It maintains two folders:
    "C:\Windows\System32" for 64-bit programs and
    "C:\Windows\SysWOW64" for 32-bit programs.
  - Whenever a 32-bit program (like TSE) thinks it accesses the folder
    "C:\Windows\System32" Windows invisibly substitutes it with the
    folder "C:\Windows\SysWOW64".
  Presumably because Windows itself is 64-bit, folders and files that
  should only be relevant to Windows are only maintained in
  "C:\Windows\System32", but there they are invisible for 32-bit programs
  like TSE.
  DirList runs from TSE, so it is 32-bit too. It does not even see any 64-bit
  folders and files, so it can not even report them as "inaccessible".

  Example:
  TSE can not open "C:\" and browse to the file
  "C:\Windows\System32\drivers\etc\hosts", because TSE is a 32-bit program and
  the "etc" folder does not exist in the "C:\Windows\SysWOW64\drivers" folder.
  It only exists in the real "C:\Windows\System32\drivers" folder, which TSE
  can not see.
  If the full filename is supplied, then Windows gets smart and falls back to
  the real folder and lets TSE open but not write the file.
  If TSE is run as administrator AND the full filename is supplied,
  then TSE can open and write the file.


  HISTORY
    v1 - 23 Dec 1999
      Initial release.
    v2 - 8 Jul 2004
      Starting from commandline didn't work correctly anyway, so deleted that.
      Now also accepts quoted dirs in parameter.
      Added parameter "all" for all files in all directories.
      <Escape> now interrupts the running macro.
      Added windmill to still show progress during long path processing.
      Added file-date, -time and -size.
      Known bug: Shown file size is erroneous above 2 GB.
    v3 - 24 Aug 2019
      Modernized the source code format to my newer standards.
      Now does not abort on but reports the top folders and files that TSE
      cannot access:
        With too deep paths ( > 255 characters).
        With ANSI-incompatible names.
      As "top" implies, the contents of inaccessible folders remains unlisted.
    v3.0.1 - 13 Oct 2019
      Corrected a textual imperfection in the final result message.
      Documented why folders and files with deep or Unicode path/names are
      inaccessible.
      Documented why 64-bit files in "C:\Windows\System32" are not listed.
    v3.0.2 - 3 Dec 2019
      Tweaked the documentation.
    v3.1 - 8 Jan 2020
      Show file sizes with grouped digits.
      Show the correct file size for files larger than 2,147,483,647 bytes
      for TSE versions from v4.40.95 upwards.
*/



#define DIGIT_GROUPING_CHARACTER Asc(',')





// Compatibility restrictions and mitigations

/*
  When compiled with a TSE version below TSE 4.0 the compiler reports
  a syntax error and hilights the first applicable line below.

  There is a beta Linux version of TSE that is not bug-free and in which some
  significant features do not work, but all its Linux versions are above
  TSE 4.0, and they all are 32-bits which is what WIN32 actually signifies.
*/

#ifdef WIN32
#else
   16-bit versions of TSE are not supported. You need at least TSE 4.0.
#endif

#ifdef EDITOR_VERSION
#else
   Editor Version is older than TSE 3.0. You need at least TSE 4.0.
#endif

#if EDITOR_VERSION < 4000h
   Editor Version is older than TSE 4.0. You need at least TSE 4.0.
#endif

#if EDITOR_VERSION < 4500h

  // A few intermediate TSE versions after v4.40 and before v4.40.95
  // are not supportable and will raise a compiler error on FFSizeStr().

  string proc FFSizeStr()
    return(Str(FFSize()))
  end FFSizeStr

  #define FILE_SIZE_COLUMN_WIDTH 15
#else
  #define FILE_SIZE_COLUMN_WIDTH 18
#endif

// End of compatibility restrictions and mitigations





integer inaccessible_files     = 0
integer inaccessible_folders   = 0
integer progress               = 0
string  digit_grouping_chr [1] = Chr(DIGIT_GROUPING_CHARACTER)
string  windmill           [4] = '/-\|'

string proc formatted_FFSizeStr()
  integer i                               = 0
  string  result [FILE_SIZE_COLUMN_WIDTH] = ''
  result = FFSizeStr()
  for i = Length(result) - 3 downto 1 by 3
    if result[i] <> ''
      result = result[1     :            i] +
               digit_grouping_chr           +
               result[i + 1 : MAXSTRINGLEN]
    endif
  endfor
  return(result)
end formatted_FFSizeStr

integer proc DirList(string dirname)
  integer handle        = -1
  integer ok            = TRUE
  string  separator [1] = '\'
  if not (Lower(SubStr(dirname, 1, 1)) in 'c', 'd')
    Delay(1)
  endif
  if dirname[Length(dirname)] == '\'
    separator = ''
  endif
  if progress >= 4
    progress = 1
  else
    progress = progress + 1
  endif
  if  KeyPressed()
  and GetKey() == <Escape>
    ok = FALSE
  endif
  if  ok
    Message(windmill[progress], ' ', dirname, ' ... ')
    handle = FindFirstFile(dirname + separator + '*', -1)
    if handle <> -1
      repeat
        if (FFAttribute() & _DIRECTORY_)
          if not (FFName() in  '.',
                               '..')
            // "> MAXSTRINGLEN - 2" means "inaccessible to DirList".
            if  Length(dirname + separator + FFName()) <= MAXSTRINGLEN - 2
            and FileExists(dirname + separator + FFName())
              DirList(dirname + separator + FFName())
            else
              inaccessible_folders = inaccessible_folders + 1
              AddLine('')
              EndLine()
              InsertText(Format(FFDateStr():                     11,
                                FFTimeStr():                      9,
                                ''         :FILE_SIZE_COLUMN_WIDTH), _INSERT_)
              InsertText(' '      , _INSERT_)
              InsertText(dirname  , _INSERT_)
              InsertText(separator, _INSERT_)
              InsertText(FFName() , _INSERT_)
              InsertText(separator, _INSERT_)
              InsertText(' <inaccessible folder>', _INSERT_)
            endif
          endif
        else
          AddLine('')
          EndLine()
          InsertText(Format(FFDateStr()          :                     11,
                            FFTimeStr()          :                      9,
                            formatted_FFSizeStr():FILE_SIZE_COLUMN_WIDTH),
                                _INSERT_)
          InsertText(' '      , _INSERT_)
          InsertText(dirname  , _INSERT_)
          InsertText(separator, _INSERT_)
          InsertText(FFName() , _INSERT_)
          if not FileExists(dirname + separator + FFName())
            inaccessible_files = inaccessible_files + 1
            InsertText(' <inaccessible file>', _INSERT_)
          endif
        endif
      until not ok
        or not FindNextFile(handle, -1)
      FindFileClose(handle)
    endif
  endif
  return(ok)
end DirList

integer proc set_specialeffects_with_center_popups_on()
  integer old_SpecialEffects = Query(SpecialEffects)
  #if EDITOR_VERSION >= 4400h
    // The flag _CENTER_POPUPS_ exists as of TSE v4.40 .
    old_SpecialEffects = Set(SpecialEffects,
                             Query(SpecialEffects) & _CENTER_POPUPS_)
  #endif
  return(old_SpecialEffects)
end set_specialeffects_with_center_popups_on

proc Main()
  string  dirnames [MAXSTRINGLEN] = Query(MacroCmdLine)
  integer ok                      = TRUE
  integer old_dateformat          = Set(DateFormat, 6) // Sortable dateformat.
  integer old_timeformat          = Query(TimeFormat)
  integer old_CenterFinds         = 0
  integer old_SpecialEffects      = 0
  integer counter                 = 0
  if (old_timeformat in 2, 4)
    old_timeformat = Set(TimeFormat, old_timeformat - 1) // Sortable timeformat.
  endif
  if GetToken(dirnames, ' ', 1) == ''
    if Ask('For which directories do you want a list of all filenames:',
           dirnames,
           GetFreeHistory(SplitPath(CurrMacroFilename(), _NAME_) + ':dirnames'))
    else
      ok = FALSE
    endif
  endif
  if  ok
  and Lower(Trim(dirnames)) == 'all'
    dirnames = ''
    for counter = Asc('a') to Asc('z')
      if FileExists(Chr(counter) + ':\')
        if dirnames == ''
          dirnames = Chr(counter) + ':'
        else
          dirnames = dirnames + ' ' + Chr(counter) + ':'
        endif
      endif
    endfor
  endif
  if  ok
  and NumFileTokens(dirnames) > 0
    repeat
      counter = counter + 1
    until not GetBufferId('DirList.' + Str(counter))
    if CreateBuffer('DirList.' + Str(counter))
      SetUndoOff()
      for counter = 1 to NumFileTokens(dirnames)
        ok = DirList(GetFileToken(dirnames, counter))
        if not ok
          break
        endif
      endfor
      SetUndoOn()
    else
      Warn('DirList could not create buffer: ', 'DirList.' + Str(counter))
    endif
  endif
  if ok
    BegFile()
    if inaccessible_folders
    or inaccessible_files
      old_CenterFinds    = Set(CenterFinds, OFF)
      old_SpecialEffects = set_SpecialEffects_with_center_popups_on()
      lFind('<inaccessible {file}|{folder}>', 'bgx')
      EndLine()
      MarkFoundText()
      UpdateDisplay(_ALL_WINDOWS_REFRESH_)
      Warn('Ready: Marked ', inaccessible_folders, ' folders and ',
           inaccessible_files, ' files as "inaccessible" to TSE.')
      Set(CenterFinds   , old_CenterFinds)
      Set(SpecialEffects, old_SpecialEffects)
      BegFile()
    else
      Warn('Ready.')
    endif
  else
    UpdateDisplay(_ALL_WINDOWS_REFRESH_)
    Warn('DirList aborted.')
  endif
  Set(DateFormat, old_dateformat)
  Set(TimeFormat, old_timeformat)
  PurgeMacro(SplitPath(CurrMacroFilename(), _NAME_))
end

