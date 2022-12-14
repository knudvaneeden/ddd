/*
  Macro
  Author          Carlo.Hogeveen@xs4all.nl
  Version         v1.0   -   29 Dec 2019
  Compatibility   GUI version of TSE Pro v4.4 upwards

  This tool demoes and tests the TSE extension "Ampersand_as_menu_quick_key".


  INSTALLATION

  First install the above mentioned extension.
  Then copy this file to TSE's "mac" folder and compile it there, for instance
  by opening the file in TSE and applying the Macro Compile menu.


  USE

  Execute this macro, for instance either immediately after compiling it, or
  by typing or selecting its name in TSE's Macro Execute menu.

  You will see a new menu with an appropriately coloured ampersand quick-key
  and an appropriately coloured normal ampersand in the normal menu text.

  You can type an ampersand to execute the quick-key's menu option.
*/

menu my_menu()
  '&Find    - Find something'           , Warn('Found!')
  '&Do      - Do something'             , Warn('Done!')
  'Find& Do - Both find && do something', Warn('Found & done!')
end my_menu

proc Main()
  my_menu()
  PurgeMacro(SplitPath(CurrMacroFilename(), _NAME_))
end Main

