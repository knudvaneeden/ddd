/*
  Macro           Ampersand_as_menu_quick_key
  Author          Carlo.Hogeveen@xs4all.nl
  Version         v1.0   -   29 Dec 2019
  Compatibility   GUI version of TSE Pro v4.4 upwards

  This TSE extension allows you to use the ampersand ("&") as a menu quick-key.

  TSE itself has no syntax for making an ampersand a menu quick-key.
  It allows you to declare a quick-key by putting an ampersand before a
  character, but "&&" means the ordinary non-quick-key ampersand character
  so the ampersand can also be used in ordinary menu text.
  This extension enables us to declare a menu option with an ampersand before
  the " " (NULL) character, which will be shown as the single ampersand
  character and which will react to the ampersand key.
  For more details see further on.


  INSTALLATION

  Copy this file to TSE's "mac" folder, compile it there, add the macro's name
  to TSE's Macro AutoLoad List, and restart TSE.


  MORE DETAILS

  After this extension has been installed, it can be demoed and tested by
  compiling and executing the accompanying "Ampersand_as_menu_quick_key_Test"
  macro.

  The term "quick-key" is what Semware uses in TSE's Help system.

  One way to insert a " " (NULL) character in a text is to open TSE's
  "Util -> ASCII Chart" menu, go up to the NULL character, and press Enter.

  Here are some ways to view a NULL character in a text:
  - The best way is to install the ControlChars extension from my website.
    It makes TSE show any NULL characters as inversely coloured "@" characters.
    The big plus is that you do not need to position the cursor on the charcter
    for it to work: NULL characters are immediately visible in edited text.
  - Install the Unicode extension from my website, and execute it to configure
    its "Show character descriptions for" setting to value "All".
    This will continuously show the Unicode description for the character under
    the cursor as a status. For the NULL character it will show "NULL".
  - Start the ShowCurr extension from TSE's Potpourri menu.
    It continuously shows the code of the character under the cursor in
    hexadecimal and decimal. For the NULL character it shows "00h,0".

  About the "& " (Ampersand + NULL) character combination in a TSE menu.
  In a menu TSE itself displays this as the single NULL character, which looks
  like a space and which is invisibly but checkable coloured as a quick-key.
  Because it is invisible, it has no existing functionality in a TSE menu and
  is extremely unlikely to occur anywhere else.
  The latter is important because TSE's macro language, and therefore this
  extension, have no fool-proof way to distinguish an opened menu from a list,
  prompt or pop-up window.
  This extension with a tiny delay overwrites the coloured NULL character with
  a coloured ampersand, and while in the same menu(?) window it will supplement
  a pressed ampersand key with a "pressed" NULL key.
  And there TSE takes over again: It ignores the unknown ampersand quick-key
  and executes the declared NULL quick-key.
*/

#if EDITOR_VERSION > 4400h
  #define STATE_TWOKEY            _STATE_TWOKEY_
  #define STATE_WARN              _STATE_WARN_
  #define STATE_EDITOR_PAUSED     _STATE_EDITOR_PAUSED_
  #define STATE_POPWINDOW         _STATE_POPWINDOW_
  #define STATE_PROCESS_IN_WINDOW _STATE_PROCESS_IN_WINDOW_
  #define STATE_MENU              _STATE_MENU_
  #define STATE_PROMPTED          _STATE_PROMPTED_
#else
  #define STATE_TWOKEY            0x0200
  #define STATE_WARN              0x0400
  #define STATE_EDITOR_PAUSED     0x0800 x
  #define STATE_POPWINDOW         0x1000 x
  #define STATE_PROCESS_IN_WINDOW 0x2000
  #define STATE_MENU              0x4000 x
  #define STATE_PROMPTED          0x3000
#endif



integer last_ampersand_pop_win_cols  = 0
integer last_ampersand_pop_win_rows  = 0
integer last_ampersand_quick_key_col = 0
integer last_ampersand_quick_key_row = 0
integer last_ampersand_window_x1     = 0
integer last_ampersand_window_y1     = 0
integer menu_needs_checking          = FALSE

proc nonedit_idle()
  string  a              [MAXSTRINGLEN] = ''
  integer col                           = 0
  string  menu_ltr_attr_char        [1] = ''
  string  menu_select_ltr_attr_char [1] = ''
  string  menu_text_ltr_attr_char   [1] = ''
  integer old_Transparency              = 0
  integer pop_win_cols                  = 0
  integer pop_win_rows                  = 0
  integer row                           = 0
  string  s              [MAXSTRINGLEN] = ''
  integer window_updated                = FALSE

  if menu_needs_checking
    pop_win_cols              = Query(PopWinCols)
    pop_win_rows              = Query(PopWinRows)
    menu_text_ltr_attr_char   = Chr(Query(MenuTextLtrAttr))
    menu_select_ltr_attr_char = Chr(Query(MenuSelectLtrAttr))
    for row = 1 to pop_win_rows
      if GetStrAttrXY(1, row, s, a, pop_win_cols)
        col = Pos(menu_text_ltr_attr_char, a)
        if col
          menu_ltr_attr_char = menu_text_ltr_attr_char
        else
          col = Pos(menu_select_ltr_attr_char, a)
          if col
            menu_ltr_attr_char = menu_select_ltr_attr_char
          endif
        endif
        if  col
        and s[col] == Chr(0)
          PutStrAttrXY(col, row, '&', menu_ltr_attr_char)
          window_updated = TRUE
          last_ampersand_quick_key_row = row
          last_ampersand_quick_key_col = col
          // Remember this menu by its window properties.
          last_ampersand_pop_win_cols  = pop_win_cols
          last_ampersand_pop_win_rows  = pop_win_rows
          last_ampersand_window_x1     = Query(WindowX1)
          last_ampersand_window_y1     = Query(WindowY1)
        endif
      endif
    endfor
    if window_updated
      // The following seemingly useless statements perform a very dirty trick.
      // They implement the only known way to visually and without side effects
      // update a screen that was updated by an _IDLE_ or _NONEDIT_IDLE_ event.
      // It uses the Transparency setting, which requires TSE Pro v4.4 upwards.
      old_Transparency = Set(Transparency, 0)
      Set(Transparency, 80)
      Set(Transparency, old_Transparency)
      UpdateDisplay()
    endif
    menu_needs_checking = FALSE
  endif
end nonedit_idle

proc after_getkey()
  string a [1] = ''
  string s [1] = ''
  menu_needs_checking = TRUE
  // Did we previously find an ampersand quick-key?
  if last_ampersand_pop_win_cols
  or last_ampersand_pop_win_rows
  or last_ampersand_window_x1
  or last_ampersand_window_y1
    // Are we still in same TSE window?
    if  Query(PopWinCols) == last_ampersand_pop_win_cols
    and Query(PopWinRows) == last_ampersand_pop_win_rows
    and Query(WindowX1)   == last_ampersand_window_x1
    and Query(WindowY1)   == last_ampersand_window_y1
      if Query(Key) == <&>
        // Are we in the expected non-edit state?
        if QueryEditState() == STATE_EDITOR_PAUSED | STATE_POPWINDOW | STATE_MENU
          // Is there an ampersand at the previously determined position?
          if GetStrAttrXY(last_ampersand_quick_key_col,
                          last_ampersand_quick_key_row,
                          s, a, 1)
            if  s == '&'
            and (a in Chr(Query(MenuTextLtrAttr  )),
                      Chr(Query(MenuSelectLtrAttr)))
              // Then we add the real key to the ignored ampersand key.
              PushKey(< >)
            endif
          endif
        endif
      endif
    else
      last_ampersand_pop_win_cols = 0
      last_ampersand_pop_win_rows = 0
      last_ampersand_window_x1    = 0
      last_ampersand_window_y1    = 0
    endif
  endif
end after_getkey

proc WhenLoaded()
  if isGUI()
    Hook(_AFTER_GETKEY_, after_getkey)
    Hook(_NONEDIT_IDLE_, nonedit_idle)
  else
    Alarm()
    Warn('ERROR: Ampersand_as_menu_quick_key only works for the GUI version of TSE.')
    PurgeMacro(SplitPath(CurrMacroFilename(), _NAME_))
  endif
end WhenLoaded

