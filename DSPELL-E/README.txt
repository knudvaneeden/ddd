1. -To install

     1. -Take the file dspell-e_knud.zip

     2. -And unzip it in any arbitrary directory

     3. -edit and save the file dspell-e.inc and change the path to where you installed this project (e.g. location of dspell.s)
         and where the file 'dspell2.mac' is located.
         (otherwise you will see the error 'Cannot load macro')

           E.g.

            f:\bbc\taal\dspell-e\dspell2.mac

     4. -Then run the file zipinstalldspell-e.bat

     5. -That will create a new file dspell-e_knud.zip
         in that directory

     6. -Unzip that latest file in a new arbitrary directory

     7. -Then run the file

          dspell.mac

2. -The .ini file is the local file 'dspell-e.ini'
    (thus not using tse.ini)

===

                      DSPELL Modifications by Chris Antos


        What's New:
		� Converted to work with both TSE 2.5 (DOS) and 2.6 (Win32).
		� Statusline indicator "S" when autospell is on.
		� <CtrlShift A> temporarily overrides the AutoSpell on/off
          setting. (The statusline indicator is bright white on green
          when AutoSpell is forced on in this manner).
		� Tests on timing:  iterating thru file is 15%; checking words
		  against SEMWARE.LEX is 55%; checking words against custom
          dictionaries depends on the size of the dictionaries;
          FLAG.LEX, USER.LEX, and ignoring words is 11%; building the
          word list is 16%. All figures are approximate, based on
          spellchecking DSPELL.S. Therefore, 15+55+16% is absolutely
          necessary, which is 86%.  Not much room for speeding it up.
		� NOTE:  custom dictionary code may run slowly with large
		  dictionaries.
		� added help file, but is still very much under construction.


            You must bind DSpell to some key in your .UI file.  Or you
        can add it to the Potpourri menu or whatever.  I like to use
        <F7> ExecMacro("dspell").

            I've tried to make DSpell pretty self-explanatory.  If it
        isn't... well, sorry.

            The AutoSpell feature is one I'm particularly fond of.
        DSpell will automatically check words as you type them!  If it
        doesn't recognize a word, it will flash the word and beep.  The
        automatic spell checking happens whenever you type <Spacebar> or
        <Enter> at the end of a word.  I've implemented this feature
        using a Hook, so it doesn't even matter if you've bound
        <Spacebar> or <Enter> to some command -- AutoSpell will still
        work.  If you dislike the AutoSpell feature, you can turn it off
        by using the Options menu (start DSpell, then hit <O>).  Or if
        the beeping and flashing is annoying, you can turn one or both
        off (also via the Options menu).

        NOTE: AutoSpell may get confused by Template.Mac; if so, go to
              the Options menu and turn off <Tab> key checking.


        Command Line Parameters:
        � -o = Options menu
        � -m = Spellcheck menu (File, Rest of file, [Block], Word)
        � -f = Check whole file
        � -r = Check rest of file
        � -b = Check block (error message if one does not exist)
        � -w = Check word under cursor
        � <none> = if the command line is empty, DSpell will either
          check the whole file, or if the cursor is inside a block
          DSpell will only check the block. (This behavior can be
          changed by modifying the code in "proc Spell" in dspell.s)


        Comments?

            I hope you find my enhancements useful.  If not, throw it
        away <grin>.  If you find bugs, have constructive criticism, or
        ideas for new enhancements, email me at chrisant@microsoft.com.

        Enjoy!
        Chris Antos
        chrisant@microsoft.com




        History of Changes:

        11/05/96, (DSPELL-E.ZIP) ��������������������������������������
		� Converted to work with both TSE 2.5 (DOS) and 2.6 (Win32).
		� Statusline indicator "S" when autospell is on.
		� <CtrlShift A> temporarily overrides the AutoSpell on/off
          setting. (The statusline indicator is bright white on green
          when AutoSpell is forced on in this manner).
		� Tests on timing:  iterating thru file is 15%; checking words
		  against SEMWARE.LEX is 55%; checking words against custom
          dictionaries depends on the size of the dictionaries;
          FLAG.LEX, USER.LEX, and ignoring words is 11%; building the
          word list is 16%. All figures are approximate, based on
          spellchecking DSPELL.S. Therefore, 15+55+16% is absolutely
          necessary, which is 86%.  Not much room for speeding it up.
		� NOTE:  custom dictionary code may run slowly with large
		  dictionaries.
		� added help file, but is still very much under construction.


        03/01/96, (DSPELL-D.ZIP) ��������������������������������������
        � Fixed bug where returning to DSpell after editing the document
          could say "<word> not found.".  Now we remove words from the
          wordlist until we find a word we recognize.  If all words are
          corrected, DSpell automatically quits (and says "Finished.")
        � Reorganized the code for different "flavors":  File, Rest of
          File, Block, Word.  This fixed a couple bugs if you had a
          block marked in the file but selected some flavor other than
          Block.
        � Added FLAG.LEX to add words that should be flagged as
          misspelled (overrides SEMWARE.LEX and USER.LEX).  The FLAG.LEX
          word list can be edited via the Options menu.
        � Added support for custom dictionaries.  Use the Options menu
          to edit the list of custom dictionaries.  The words in the
          dictionaries can also be edited from here.
        � AutoSpell used to check as soon as you hit the key, but now it
          waits until after the command (eg, inserting the key you
          typed) has finished.  This helps prevent a problem with
          Template.Mac where AutoSpell could get confused and try to
          check the abbreviation (before it was expanded).  Now it waits
          until the template is expanded.  However, this can cause
          AutoSpell to sometimes accidentally check a word twice if you
          type <Space> and then <Tab>.  Since this is not something that
          happens often, I don't think it will be a problem.  Or,
          alternatively, you can turn off <Tab> key AutoSpelling (use
          the Options menu).
        � The WordList is now a _HIDDEN_ buffer.  You can switch back
          and forth between the document and wordlist by using the mouse
          or by using <Alt [> and <Alt ]> (goto previous/next window).
          Or you can use the old method of hitting <F7> or <Tab>.  To
          get back to the wordlist, just switch to the wordlist window
          (via mouse or keyboard).  (Or, just run the DSPELL macro with
          no parameters; for most people, you can just hit your DSPELL
          hotkey).
        � Enhanced mouse support.
        � Various other small bug fixes.


        12/09/95, (DSPELL-C.ZIP) ��������������������������������������
        � Split into two macro files.
        � Fixed bug where adding word didn't go to the next word.
        � Updates # of misspellings when changing word.
        � Using -w on the command line causes DSpell to check only the
          current word.
        � Fixed bug where helpline shows up blank if you normally have
          it turned off.
        � Added optional startup menu (File, Rest of file, Block, Word
          or just File, Rest of file, Word if no block is marked).
        � Settings are kept in TSEPRO.INI in the Main TSE directory.
          Settings that are saved include AutoSpell on/off, Beep Word,
          Flash Word, Ignore Non Alpha Words, etc.  The old #defines
          have been removed.
        � Added <O> = Options menu.  Or use ExecMacro("dspell -o").
        � Now via the Options menu, you can change the list of filename
          extensions that AutoSpell ignores.
        � When checking the current word (via the startup menu or
          ExecMacro("dspell -w")), DSpell presents a menu just like
          SemWare's SpellChk macro.  It lists the first 10 closest
          matches, plus Ignore, Edit, Add, and Cancel.  This saves
          keystrokes when checking the current word.
        � Fixed bug where DSpell sometimes forgot to restore the
          WordSet.
        � Workaround for Change All bug where it only changes first
          occurrence.  Seems to be a TSE bug in lReplace.


        11/17/95, (DSPELL-B.ZIP) ��������������������������������������
        � AutoSpell handles hyphenated words.
        � Hyphenated word correction works.
        � Disables AutoSpell in files with certain extensions
          (Programming language files like .s, .h, .cpp, etc)
        � Turns on ShowHelpLine while in DSPELL, restores setting when
          done.
        � More optimization to shrink macro (ran out of space again).
        � Fixed problem where HelpLine didn't work if DSPELL was bound
          to a shifted key.
        � Fixed AutoSpell problem when multiple macros bind to <Enter>
          or <Spacebar>.  Was checking the word multiple times.


        11/14/95, (DSPELL-A.ZIP) ��������������������������������������
        � Added foreign letter support (umlauts, accents, etc) for
          ignoring non-alphabetic words.
        � Fixed so DocumentWindow has focus (WordListWindow used to have
          focus even though DocumentWindow was painted as having the
          focus;  _IDLE_ macros that caused repaints would redraw the
          WordListWindow as having the focus).
        � Fixed word list buffer so it is never marked as changed, so
          autosave macros will not try to save it.
        � Auto spell checking while typing!  (When <Spacebar>, <Enter>,
          or <GreyEnter> is hit) (Can be disabled by #define AUTO_SPELL
          0)
        � Began work on checking hyphenated words:  currently checks the
          full word and ignores correctly spelled words, but does not
          intelligently correct them yet. (Can be disabled by #define
          HANDLE_HYPHENATED_WORDS 0)
        � Optimized tons of stuff b/c ran out of macro space!


        11/09/95, (DSPELL-X.ZIP) ��������������������������������������
        � Added helplines
        � Added "change only this occurrence" feature (Ctrl-Enter)
        � Verifies spelling of new word when correcting word (Can be
          disabled by #define VERIFY_NEW_WORD 0)
        � Handles words like _beleive_ and *beleive*
        � Handles words like ''beleive'', 'beleive', 'beleive
        � Fixed minor bugs
        � Changed user interface:
            � A = Add word to USER.LEX
            � C or Enter = Change all
            � Shift-C or Ctrl-Enter = Change only this occurrence
            � I or Del = Ignore
            � F7 = Edit document/resume spell check
        � Supports USER.LEX and adding words to USER.LEX
        � Supports PERSONAL.LEX (but not adding words)
        � Returns back to where you were before starting DSpell (Can be
          disabled by #define RETURN_TO_ORIGIN 0)
        � Ignores non-alphabetic words (Can be disabled by #define
          IGNORE_NON_ALPHA_WORDS 0)
        � Shows number of occurrences of each misspelled word
