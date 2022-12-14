/****************************************************************************
 MACRO:       AXENTS

 AUTHOR:      Luigi M Bianchi

 DATE:        04-09-94

 DESCRIPTION: These macros turn <` > <'> <"> <^> into dead keys: when pressed,
              if the following key is a vowel, the accented vowel is inserted,
              otherwise the accent is inserted followed by the non-vowel.
              Il the following key is Spacebar the is accent is inserted.

 PARAMETERS:  none

 RETURNS:     nothing

 GLOBAL VARS: none

***************************************************************************/

proc Grave()
    integer key
    string ch[1]
    loop
    key = GetKey()
    ch = Chr(key & 0xff)
        case key
            when <a>
                InsertText("?")
            when <e>
                InsertText("?")
            when <i>
                InsertText("?")
            when <o>
                InsertText("?")
            when <u>
                InsertText("?")
            when <Enter>
                InsertText("`")
                mCReturn()
            when <Spacebar>
                InsertText("`")
            otherwise
                InsertText("`" + ch)
        endcase
        break
    endloop
end

proc Acute()
    integer key
    string ch[1]
    loop
    key = GetKey()
    ch = Chr(key & 0xff)
        case key
            when <a>
                InsertText("?")
            when <e>
                InsertText("?")
            when <i>
                InsertText("?")
            when <o>
                InsertText("?")
            when <u>
                InsertText("?")
            when <Enter>
                InsertText("'")
                mCReturn()
            when <Spacebar>
                InsertText("'")
            otherwise
                InsertText("'" + ch)
        endcase
        break
    endloop
end

proc Umlaut()
    integer key
    string ch[1]
    loop
    key = GetKey()
    ch = Chr(key & 0xff)
        case key
            when <a>
                InsertText("?")
            when <e>
                InsertText("? ")
            when <i>
                InsertText("?")
            when <o>
                InsertText("?")
            when <u>
                InsertText("?")
            when <Enter>
                InsertText('"')
                mCReturn()
            when <Spacebar>
                InsertText('"')
            otherwise
                InsertText('"' + ch)
        endcase
        break
    endloop
end

proc Circumflex()
    integer key
    string ch[1]
    loop
    key = GetKey()
    ch = Chr(key & 0xff)
        case key
            when <a>
                InsertText("?")
            when <e>
                InsertText("? ")
            when <i>
                InsertText("?")
            when <o>
                InsertText("?")
            when <u>
                InsertText("?")
            when <Enter>
                InsertText('^')
                mCReturn()
            when <Spacebar>
                InsertText("^")
            otherwise
                InsertText("^" + ch)
        endcase
        break
    endloop
end

<`>                     Grave()
<'>                     Acute()
<Shift '>               Umlaut()
<Shift 6>               Circumflex()

