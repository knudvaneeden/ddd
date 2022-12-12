/*
  Macro          Execute
  Author         Carlo Hogeveen
  Website        eCarlo.nl/tse
  Compatability  TSE Pro 2.5e upwards, all TSE variants
  Version        v2   10 Oct 2022

  This tool can interactively run a TSE command or a whole line of TSE commands
  without you having to program a macro for it.


  INSTALLATION

  Just copy this file to TSE's "mac" directory, and compile it there, for
  example by opening it there in TSE and applying the MAcro Compile menu.


  USAGE

  This "Execute" macro can be executed
  - From the Potpourri menu: It prompts for TSE commands to execute.
  - From the Macro Execute menu, optionally followed by TSE commands
    to execute. Without TSE commands it prompts for them.

  Syntax when executed from TSE's Macro Execute menu:
    execute [TSE macro statement] ...

  Syntax when Execute has been executed without parameters:
    [TSE macro statement] ...

  When executed without parameters and when started from the Potpourri menu,
  you are prompted for a (sequence of) TSE command(s).

  This prompt has its own Execute history, and does not need (room for)
  the "execute " command, letting us view a longer part of long commands.

  TSE macro statements:
    Technically: whatever TSE would allow as the body of a Main() proc.
    You may enter a sequence of such statements, and they may be nested.
    You are limited to either the macro command line length, which was 128
    up to TSE 4.41.08 and is 255 from that version onwards, or to the macro's
    prompt length, which is 255 for all TSE versions.

  If the (sequnce of) TSE-statement(s) is not compilable,
  then the compilation's error message is returned:
  - For TSE 2.5 and TSE 2.8 as a one line warning.
  - For TSE 3 upwards as a window with the command, a pointer to the error's
    position, and the error message.


  EXAMPLES

  Macro Execute menu examples:
    execute
    execute Warn('Hello World!')
    execute Warn("Hello World!")

  Prompt examples for after executing macro "Execute" without parameters:
    Warn('Hello World!')
    Warn("Hello World!")
    message('Hi') if (GetTime() mod 2) Warn('Odd') else Warn('Even') endif
    integer i for i=10 downto 0 Message(i;"...") Delay(18) endfor

  Executing "Execute" from another macro examples:
    ExecMacro("execute Warn('Hello World!')")
    ExecMacro('execute Warn("Hello World!")')


  HISTORY

  25-10-2006, v1.00
    Initial release.

  25-10-2006, v1.01
    Improved compile error reporting.
    Documented common user errors.

  26-10-2006, v1.02
    Improved compile error reporting and the documentation a bit.


  10 Oct 2022   v2
    Breaking change:
      Removed the Dos command line capability. I never used it, and it added a
      lot of complexity, not just internally to the program, but also to the
      user-facing documentation, so I decided to simplify all around and remove
      it.
    Fixed:
      Now also works if TSELOADDIR is set and the original load directory is
      not writable, perhaps because it is on an a write-protected network
      drive.
    New:
      Added a prompt with its own history list.
        This prompt is shown when Execute is started without parameters.
      For compilation errors a fancy error window was added for TSE v3 upwards.
      Rewrote the source code and documentation.

*/





// Start of compatibility restrictions and mitigations


// The following determines the editor version at compile-time.
#ifdef EDITOR_VERSION
  // From TSE 3.0 upwards the built-in constant EDITOR_VERSION exists.
#else
  #ifdef WIN32
    // From TSE 2.6 upwards the built-in constant WIN32 exists.
    #define EDITOR_VERSION 2800h

    // TSE < 2.5e and TSE 2.6 are not supported by this macro.
    // TSE 2.5e (the Dos version of TSE) has existed so long, that almost
    // every Dos user has upgraded to it, so supporting older versions is
    // no longer worth the effort. Due to a bug in TSE 2.5c (and presumably
    // lower versions, which is one of the reasons for not supporting them)
    // the line below is syntax-checked despite the lack of WIN32 in those
    // versions, and generates a desired compiler error for TSE <= 2.5c.
    //
    // TSE 2.6 was a buggy intermediate 32-bits version from which anyone
    // could freely upgrade to TSE 2.8. The parameter constant _MFSKIP_
    // exists since TSE 2.8, so the line below will also generate a
    // desired compiler error for TSE 2.6.
    #define UNSUPPORTED_TSE_VERSION _MFSKIP_
  #else
    // Since other TSE versions were excluded, this is assumed to be TSE 2.5e.
    #define EDITOR_VERSION 2500h
  #endif
#endif


#if EDITOR_VERSION == 2500h
  #define MAXSTRINGLEN 255
#endif


#ifdef LINUX
  string SLASH [1] = '/'
#else
  string SLASH [1] = '\'
#endif


#if EDITOR_VERSION >= 3000h
#else
  // Trims outer spaces completely and inner consecutive spaces to one space.
  string proc multi_trim(string multi_spaced_text)
    string result [MAXSTRINGLEN] = Trim(multi_spaced_text)
    while Pos('  ', result)
      result = SubStr(result, 1, Pos('  ', result) - 1)
             + SubStr(result, Pos('  ', result) + 1, MAXSTRINGLEN)
    endwhile
    return(result)
  end multi_trim
#endif


proc buffer_video()
  #if EDITOR_VERSION > 2500h
    BufferVideo()
  #endif
end buffer_video


proc unbuffer_video()
  #if EDITOR_VERSION > 2500h
    UnBufferVideo()
  #else
    UpdateDisplay()
  #endif
end unbuffer_video


integer proc edit_this_file(string filename, integer edit_flags)
  #if EDITOR_VERSION >= 4200h
    return(EditThisFile(filename, edit_flags))
  #else
    return(EditFile(filename, edit_flags))
  #endif
end edit_this_file


integer proc key_pressed()
  // Compensate for a bug that was fixed in TSE v4.40.81.
  // The next TSE version we can test for is v4.41.44,
  // which finally introduced INTERNAL_VERSION.
  #ifdef INTERNAL_VERSION
    return(KeyPressed())
  #else
    return(KeyPressed() or KeyPressed())
  #endif
end key_pressed


integer proc save_as(string filename, integer option)
  #if EDITOR_VERSION >= 3000h
    return(SaveAs(filename, option))
  #else
    // In TSE < v3 FileChanged() erroneously remains the same after a
    // successful SaveAs().
    integer result = SaveAs(filename, option)
    if result
      FileChanged(FALSE)
    endif
    return(result)
  #endif
end save_as


// End of compatibility restrictions and mitigations





// Global constants and semi-constants

string MACRO_NAME     [MAXSTRINGLEN] = ''
string TMP_DIR        [MAXSTRINGLEN] = ''
string TMP_MACRO_MAC  [MAXSTRINGLEN] = ''
string TMP_MACRO_NAME [MAXSTRINGLEN] = ''
string TMP_MACRO_S    [MAXSTRINGLEN] = ''


string proc get_tmp_dir()
  string result [MAXSTRINGLEN] = ''
  result = GetEnvStr('TMP')
  if not (FileExists(result) & _DIRECTORY_)
    result = GetEnvStr('TEMP')
    if not (FileExists(result) & _DIRECTORY_)
      #ifdef LINUX
        result = '/tmp'
        if not (FileExists(result) & _DIRECTORY_)
          result = ''
        endif
      #else
        result = ''
      #endif
    endif
  endif
  return(result)
end get_tmp_dir


proc WhenLoaded()
  MACRO_NAME     = SplitPath(CurrMacroFilename(), _NAME_)
  TMP_DIR        = get_tmp_dir()
  TMP_MACRO_NAME = MACRO_NAME                       + '_'
  TMP_MACRO_S    = TMP_DIR + SLASH + TMP_MACRO_NAME + '.s'
  TMP_MACRO_MAC  = TMP_DIR + SLASH + TMP_MACRO_NAME + '.mac'

  if TMP_DIR == ''
    Warn('No tmp dir.')
    PurgeMacro(MACRO_NAME)
  endif
end WhenLoaded


integer proc get_cmd(var string cmd)
  cmd = Trim(Query(MacroCmdLine))
  if cmd == ''
    if Ask(Format('Enter a (sequence of) TSE macro command(s) to execute:'),
           cmd,
           GetFreeHistory(MACRO_NAME + ':cmd'))
      cmd = Trim(cmd)
    endif
  endif
  return(cmd <> '')
end get_cmd


integer proc create_tmp_macro(string cmd, var integer tmp_macro_id)
  string  erroneous_action [4] = ''
  integer org_id               = GetBufferId()

  buffer_video()
  tmp_macro_id = edit_this_file(TMP_MACRO_S, _DONT_PROMPT_)

  if tmp_macro_id
    EmptyBuffer()
    InsertText(cmd)
    BegLine()
    InsertText('proc Main() ', _INSERT_)
    EndLine()
    InsertText(' end'        , _INSERT_)
    if save_as(CurrFilename(), _DONT_PROMPT_|_OVERWRITE_)
      GotoBufferId(org_id)
    else
      erroneous_action = 'save'
      GotoBufferId(org_id)
      AbandonFile(tmp_macro_id)
      tmp_macro_id = 0
    endif
  else
    erroneous_action = 'open'
  endif

  unbuffer_video()

  if erroneous_action <> ''
    Warn('Could not ', erroneous_action, ' tmp file "' + TMP_MACRO_S + '".')
  endif

  return(tmp_macro_id)
end create_tmp_macro


integer proc compile_tmp_macro(string cmd, integer tmp_macro_id)
  integer compilation_ok = FALSE
  integer org_id         = GetBufferId()

  #if EDITOR_VERSION >= 3000h
    integer errors_id             = 0
    integer error_pos             = 0
  #else
    string  dont_need_cmd     [1] = cmd
    string  error1 [MAXSTRINGLEN] = ''
    string  error2 [MAXSTRINGLEN] = ''

    dont_need_cmd = dont_need_cmd  // Pacify the compiler.
  #endif

  while key_pressed() // Discard human interference. Sigh, humans.
    GetKey()
  endwhile

  buffer_video()
  GotoBufferId(tmp_macro_id)

  // Start of pushed keys part: When debugging you cannot step through here.
  PushKey(<Enter>)
  PushKey(<c>)
  //   Macro must be both current and a parameter to get the response windows we
  //   want for a successful and not successful compilation in all TSE versions.
  ExecMacro('compile ' + CurrFilename())
  if  key_pressed()
  and GetKey() == <Enter>
    compilation_ok = TRUE
  endif
  // End of pushed keys part: Debug breakpoint could be put hereafter.

  if compilation_ok
    GotoBufferId(org_id)
    UpdateDisplay()
    unbuffer_video()
  else
    NextWindow()
    #if EDITOR_VERSION >= 3000h
      // Show fancy error window.
      PushBlock()
      MarkLine(1,NumLines())
      Copy()
      errors_id = CreateTempBuffer()
      Paste()
      if lFind('^Error #[0-9]# #([0-9]#,\c[0-9]#)', 'gx')
        MarkWord()
        error_pos = Val(GetMarkedText())
        // Subtract 12 for "proc Main() ".
        if error_pos > 12
          error_pos = error_pos - 12
          KillBlock()
          InsertText(Str(error_pos), _INSERT_)
        endif
      endif
      PopBlock()
      BegFile()
      InsertLine()
      InsertLine(cmd)
      if error_pos
        // Necessary empty devider line, which avoids MsgBoxBuff()
        // unpredictably messing with the position of "^".
        AddLine()
        AddLine(Format('^': error_pos))
      endif
      GotoBufferId(org_id)
      OneWindow()
      UpdateDisplay()
      unbuffer_video()
      MsgBoxBuff(MACRO_NAME + ' errors', _OK_, errors_id)
      AbandonFile(errors_id)
    #else
      // Show the on-line source, the error window, and our own basic warning.
      error1 = GetText(1,CurrLineLen())
      if Down()
        error2 = GetText(1,CurrLineLen())
      endif
      unbuffer_video()
      // multi_trim() also compresses spaces to show more of the error message.
      Warn(MACRO_NAME, ':'; multi_trim(error1); multi_trim(error2))
      GotoBufferId(org_id)
      OneWindow()
      UpdateDisplay()
    #endif
  endif

  EraseDiskFile(TMP_MACRO_S)

  return(compilation_ok)
end compile_tmp_macro


proc Main()
  string  cmd [MAXSTRINGLEN] = ''
  integer tmp_macro_id       = 0

  if TMP_DIR <> ''
    if get_cmd(cmd)
      if create_tmp_macro(cmd, tmp_macro_id)
        if compile_tmp_macro(cmd, tmp_macro_id)
          ExecMacro(TMP_MACRO_MAC)
          PurgeMacro(TMP_MACRO_MAC)
          EraseDiskFile(TMP_MACRO_MAC)
        endif
        AbandonFile(tmp_macro_id)
      endif
    endif
  endif

  PurgeMacro(MACRO_NAME)
end Main

