/**********************************************************************
procedure==>  vmReNumber () 1.21  <==by Volker Multhopp  05/14/93
    An easy way to repeatedly renumber a text or block.


    returns: nothing
    notes: see below

    Bound to <Ctrl grey*> at end of source.



Ultra-short instructions:

        Call vmReNumber() wherever you want automatic renumbering.


Some definitions:

    NSTRING:  A renumberable "number" string of all digits, ie 0-9; all caps,
        ie A-Z; or all lower case, ie a-z; or the null string "".  The nstring
        is terminated with a period and preceded by a bullet.

        The nstring may contain a leading tilde, ie "~", to prevent nstring
        incrementing.

        The nstring may contain a leading caret, ie "^", to reset the nstring
        to a particular value.

        Note: unless there's a leading caret ONLY THE FIRST NSTRING in a
        sequence has any value meaning to the procedure-- the rest are just
        placeholders!

    BULLET:  A special character used to mark the start of a nstring.  The
        default bullet is "", chr(16), which can be reset by the user to
        define distinct sequences.  The bullet should be a character not
        otherwise used in the text.  The bullets can later be removed from
        the final text for printing and distribution.


DESCRIPTION OF OPERATION:

    1.  The procedure asks if the user would like to:

        a:  Renumber immediately.

        b:  Insert a number.  If so a bullet and a period are inserted into
        the text at the current location.

        c:  Change the bullet.  If so, the bullet is changed according to the
        user's wish.

    2.  The procedure then goes to the beginning of the text, or marked
    block, and proceeds all the way to the end of the text or block.  The
    pre-call position is later restored.

    3.  The procedure finds the first bullet-nstring-period sequence.  If that
    nstring is empty, then it is made "1".  This nstring determines the value
    of all the following ones.  This nstring should not be preceded by a
    tilde.

    4.  The procedure finds the next bullet-nstring-period sequence.

        a.  If the new nstring begins with a caret, go back to step 3.

        b.  If the new ntsring begins with a tilde, it is discarded and
        replaced with a tilde and the previous nstring.

        c.  Otherwise the new nstring is discarded.  The previous nstring is
        incremented by one and inserted to its place.  Numbers are incremented
        in the standard fashion.  Alphas are similarly incremented, ie:
        A,B,C,...,Y,Z,AA,AB,...,GZY,GZZ,HAA,... etc.

    5.  Step 4. is repeated until finished.



AN EXAMPLE.  I'll demonstrate with a short, but complicated example.

    Let's say you want to make a list of the animals you've owned, and you
    like this format:

        A. horses
            A.1. arabians
            A.2. quarter horses
        B. goats
        C. dogs
            C.1. shepherds          [Fig. 1.]
            C.2. hounds
            C.3. pointers
        D. aquarium fish

    Now suppose you want to add "cats" after "goats".  You'll have a lot of
    changes to make (Pretend the list is much longer.).  But you could have
    entered it as:

        A. horses
            ~.1. arabians
            ~.. quarter horses
        . goats
        . dogs
            ~.^1. shepherds        [Fig. 2.]
            ~.. hounds
            ~.. pointers
        . aquarium fish

    Well, that looks pretty abstract and ugly.  As you entered it, you could
    have put in the BCD23's, etc, to get the format clearer and make it more
    text-like.  Or you could have left out the 1's, because '1' is the default
    sequence start.  Anyway, the '' bullets mark one series, which uses caps
    and begins with 'A', because of the 'A' by horses.  The series is kept
    from incrementing at the horse and dog sub-types by the tildes.

    The '' bullets (chr(19)) actually represent two distinct sequences,
    because the bullet is re-initialized by the caret at shepherds.

    Anyway, if you call vmReNumber() (You need to call it twice actually,
    since you have two different bullets), you'll get:

        A. horses
            ~A.1. arabians
            ~A.2. quarter horses
        B. goats
        C. dogs
            ~C.^1. shepherds       [Fig. 3.]
            ~C.2. hounds
            ~C.3. pointers
        D. aquarium fish

    Now that looks more like it.  Still, it's ugly with the funny characters,
    and the shepherds aren't even aligned.  But whenever you're ready to
    print, you can pull out the bullets, tildes, and carets.  The shepherds
    will then be aligned and the text will look like Fig. 1.

    Anyway, you can now insert a ". cats" line (or "C. cats" or
    "anything.cats") beneath the goats line, and again call vmReNumber() by
    hitting the assigned key, or calling ExecMacro().  You'll get:

        A. horses
            ~A.1. arabians
            ~A.2. quarter horses
        B. goats
        C. cats
        D. dogs
            ~D.^1. shepherds       [Fig. 4.]
            ~D.2. hounds
            ~D.3. pointers
        E. aquarium fish

    instantly.  Of course, with just ten lines, it's not so impressive, but
    if you had dozens or hundreds of numbers spread over many pages, the labor
    savings would be considerable.



USING VMRENUMBER()'S INSERT NUMBER OPTION:
        The procedure will insert a bullet-period at the current location if
        you select option 'I'.  It will then renumber the text ( or block).
        However, if this is the first bullet, the procedure will put in the
        default '1'.  If you want an alphabetical sequence, or different
        starting value, just back up, delete the '1', and put in what you
        want.  You'll also have to put in any tildes or carets 'by hand'.


SETTING THE STARTING VALUE OF A SEQUENCE:
        Only the first nstring is unchanged after a renumbering.  You could
        start a series with "245", "aay", or whatever.


SPECIFYING DIFFERENT BULLETS:
        If you use option 'C'-- Change bullet, you have to give the procedure
        a non-standard ascii character to use as the new bullet. I find the
        easiest way to enter abnormal characters is with the standard DOS
        alt-keypad technique.  Hold down <Alt> and tap <1> and <6> on the
        number keypad, then release the <Alt>, you'll get chr(16). The numlock
        state doesn't matter.  However, this may not work if you've redefined
        those keys.   

        When you first change to a new bullet, the procedure will attempt to
        renumber.  It probably won't find any valid sequences, and will tell
        you so.  Just ignore the 'warning'.


DON'T FORGET:   BULLET-NSTRING-PERIOD.
                    Renumbering only affects the current bullet.  Other
                        bullets are ignored.
                    Tilde "~" says, "Don't increment here; use the previous
                        value."
                    Caret "^" says, "We're restarting this bullet sequence.
                        The new starting value follows immediately."
                    You reset the whole sequence by resetting the first value.

**********************************************************************/

string vmReNumberBullet[1] = ''  // delocalized variable for re-use.

proc vmReNumber ()
    // I like to bind macro procedures to keys-- see end.
    // If you prefer to use the execmacro technique, you could rename this
    // Main(), and call with the filename, or declare vmReNumber public.

    constant
    maxlen = 9      // if you need more than a billion numbers . . .

    integer
    n = 1,      // value of nstring when numerical
    alpha = 0,    // type of nstring: 0=num, 1=caps, 2=lower
    i = 0,
    k = 0,
    errflag = 0,
    initflag = 0

    string
    nstring[maxlen] = '',
    bullet[1] = vmReNumberBullet,
    c[1] = '',
    min[1] = '0',
    max[1] = '9',
    errstr[35] = ''

    // Give user his options.
    ask(' Renumber; Insert number; or Change bullet "'
        + bullet +'" [ric]?', c)

    lower(c)
    if length(c) == 0
        return()    // user escaped or returned -- do nothing.
    elseif c =='c' or c == 'b'
        // Let user reset the bullet
        c = ''
        Ask ('Set bullet from "' + bullet + '" to . . . ',c)
        if length(c)
            if c >= ' ' and c <= '~'  // "typewriter ascii"
                // protect the user from much more harm than good
                errstr = 'Sorry, unsafe character selected.'
                goto error
            endif
            bullet = c
            vmReNumberBullet = bullet  // save for posterity
        else
            return()  // user escaped
        endif
    elseif c == 'i'
        inserttext( bullet + '.', _insert_ )
    elseif c <> 'r'
        errstr = 'Unsupported key.'
        goto error
    endif

    // Renumber!

    pushposition()  // we're coming back
    pushblock()   // saves for user if there's a block in another file.

    Set(marking,off)
    if isBlockinCurrFile()
        GotoBlockBegin()
    else  // mark the whole file.
        endFile()
        Markstream()
        begFile()
        MarkStream()
        Set(marking,off)
    endif
    // now we're 'block local'

    // find first bullet-nstring-period.

    if not lfind(bullet + "\^?~?[0-9A-Za-z]*\." , "glx")
        errstr = 'Proper bullet "' + bullet + '" seq. not found.'
        popblock()
        popposition()
        goto error
    endif

    initialize:  // the 1st nstring
    // reset defaults.
    initflag = 0
    i = 0
    alpha = 0
    min = '0'
    max = '9'
    nstring = ''

    // cursor is now on the 1st bullet, or a caret.
    // skip over bullet, tilde, caret
    c = chr(currchar())
    while c == bullet or c == '~' or c == '^'
        right()
        c = chr(currchar())
    endwhile

    if c == '.'     // null starting nstring?
        // drop '1' in there, and pretend we didn't
        inserttext('1',_insert_)
        left()
        c = chr(currchar())
    endif

    // check what type of nstring we may have.
    if c >= min and c <= max
        // ok, use defaults.
    elseif c >= 'A' and c <= 'Z'
        min = 'A'
        max = 'Z'
        alpha = 1
    elseif c >= 'a' and c <= 'z'
        min = 'a'
        max = 'z'
        alpha = 2
    endif

    // make sure it's ok, and build our nstring.
    // gather the string one char at a time and check it.
    while  c <> '.'
        nstring = nstring + c
        i = i + 1
        if i > maxlen or not ((c >= min and c <= max))
            errflag = 1
        endif
        right()
        c = chr(currchar())
    endwhile

    if errflag
        // something's wrong with the user's init nstring.
        updatedisplay() // put him on the error.
        killposition()
        popblock()
        errstr = 'Initial string error.'
        goto error
    endif

    if not alpha
        n = val (nstring) // initialize numerical sequence.
    endif

    // Main loop, our strategy here is to look ahead with a find,
    // peek if there's a tilde.  If yes, just replace the found nstring
    // with ours.  If not, increase our nstring and then replace.
    // But if there's a caret, reinitialize.

    while lfind (bullet + '\^?~?[0-9A-Za-z]*\.' , 'lx' )
        right()
        if currchar() == asc('~')
            // just wait!
        elseif currchar() == asc('^')
            initflag = 1
            break
        else  // no tilde or caret; increase our nstring
            if not alpha  // it's a number sequence
                n = n + 1
                nstring = str (n)
            else  // an alpha string
                // increment  string
                n = length (nstring)
                i = n
                while 1     // increase the ith character
                    if substr( nstring, i, 1) == max    // Is the ith a Z?
                        // change it to A, and increase the preceder.
                        if i == 1   // first string char?
                            nstring = min + min + substr(nstring, 2, n-1 )
                            // in fact, all the chars will be A's.
                            break
                        else
                            nstring = substr( nstring, 1, i-1 ) + min
                                + substr( nstring, i + 1 , n-i )
                            // this is the only looper!
                            i = i - 1
                        endif
                    else        // 96.15% of the time just. . .
                        nstring = substr ( nstring, 1, i -1 )
                            + chr( asc(substr(nstring, i, 1) ) +1 )
                            + substr( nstring, i + 1 , n-i )
                        break
                    endif
                endwhile  // until finished incrementing string.
            endif
            left()  // get a running start.
        endif
        lreplace ('[0-9A-Za-z]*\.', nstring +  '\.', 'lx1' )
        // which bypasses any tildes.
    endwhile    // loop for each find.

    if initflag
        goto initialize
    endif

    //done
    popblock()
    popposition()
    return()

    error:
    warn( errstr + '  ')
    return()

end  // of vmReNumber ().

// test
<ctrl grey*>   vmReNumber ()

/**********************************************************************

    Revision history:
        1.0  Fully operational version.  5/14/93.
        1.1  Added insert number option.  Modified doc.  Uploaded to CIS. 5/16.
        1.2  Minor maintenance.  Added a Set(Marking,Off) into main stream.
            Added this revision history.  Added an i=0 in initialize:.

**********************************************************************/
