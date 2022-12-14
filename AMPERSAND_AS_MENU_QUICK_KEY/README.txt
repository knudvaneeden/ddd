===

1. -To install

     1. -Take the file ampersand_as_menu_quick_key_knud.zip

     2. -And unzip it in any arbitrary directory

     3. -Then run the file zipinstallampersand_as_menu_quick_key.bat

     4. -That will create a new file ampersand_as_menu_quick_key_knud.zip
         in that directory

     5. -Unzip that latest file in a new arbitrary directory

     6. -Then run the file

          ampersand_as_menu_quick_key.mac

2. -The .ini file is the local file 'ampersand_as_menu_quick_key.ini'
    (thus not using tse.ini)

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
