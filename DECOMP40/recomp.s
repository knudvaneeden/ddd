/****************************************************************************\

    ReComp.S

    Compiles key listings to binary TSE keyboard macros.

    Overview:

    ReComp reads a key list, e.g. which has been created by DeComp,
    and generates a binary keyboard macro file.

    Keys:   (none)

    Usage notes:

    When called the macro examines the extension of the current file.
    If it is ".k" the current file is compiled. Otherwise the user
    will be asked to enter the name of a decompiled keyboard macro.
    The name of the binary macro file will be the same as the input
    file name with the extension replaced by ".kbd".

    Command Line Format:

    ReComp [-load]

    where:

        -load       automatically load compile macros


    Version         v4.00/05.06.01
    Copyright       (c) 1993-2001 by DiK, portions (c) SemWare

    History

    v4.00/05.06.01  added command line options
                    fixed .k file bug
    v3.40/23.07.99  adaption to TSE32 v3.0
    v3.31/15.12.97  bug fix (">" key issue)
    v3.30/10.07.97  adaption to TSE32 v2.8
    v3.20/22.10.96  adaption to TSE32
    v3.11/12.03.96  included open file dialog
    v3.10/16.10.95  adaption to v2.5 of TSE
    v3.00/08.03.95  corrected file format issues
    v2.01/13.12.94  adaption to German TSE
    v2.00/21.11.94  adaption to v2.0 of TSE
    v1.10/26.01.94  included new fileprompt
    v1.00/30.12.93  primary release

    Acknowledgment

    I have to thank Sammy Mitchell of SemWare Co. for pointing out
    some important details of the macro file format, which have not
    been handled correctly in early versions of these programs.

    Thanks to Chris Antos for suggestions and finding some bugs.

\****************************************************************************/

/****************************************************************************\
    Global constants and variables (version dependent)
\****************************************************************************/

#ifndef WIN32

string magic_header[] = '??Bobbi %"??r;?  E ?E?J?E    E'
                                        // magic header of macro file
string key_reg_expr[] = "^ *<%?{[~ %]+}{>}|{ #{[~ ]+}>}"
                                        // reg. expr. to scan key codes
string key_table[]  = "keytable.dat"    // name of file containing key table

constant KEY_WIDTH   = 32               // field width of key code table

integer keyfile                         // key code translation table
integer hexfile                         // temp, validating hex numbers

#else

string magic_header[] = '??Bobbip%????d  $    E  r,?i  ??i ?J??i   ,?i'
                                        // magic header of macro file
string key_reg_expr[] = "^ *<%?{[~%>]+}>"
                                        // reg. expr. to scan key codes

#endif

/****************************************************************************\
    Global variables and constants
\****************************************************************************/

constant NAME_WIDTH  = 64               // size of name string
constant LINE_SIZE   = 64               // file format for kbd-file

constant MAX_COUNT   = 20               // maximum number of macros per file
                                        // (does not include scrap macro)
constant DIM_KEYS    = 2*MAX_COUNT + 2  // dimension of hotkey list

integer inpfile                         // input file (k)
integer outfile                         // output file (kbd)

integer current                         // flag, compiling current file
integer scrap                           // flag, scrap macro encountered

integer curr_mac                        // current macro
integer curr_line                       // current output line
integer curr_size                       // size of current line
integer total_size                      // total size of current macro

string outname[120]                     // name of output file
string curr_macro[NAME_WIDTH]           // name of current macro

/****************************************************************************\
    Shared code
\****************************************************************************/

#include "DeComp.SI"

/****************************************************************************\
    Compatibility
\****************************************************************************/

#ifndef WIN32

string proc QuotePath(string s)
    return(s)
end

#endif

/****************************************************************************\
    Error handler
\****************************************************************************/

constant  EN_KEY = 1,
          EN_OUT = 2,
          EN_NUL = 3,
          EN_SCP = 4,
          EN_CNT = 5,
          EN_INV = 6,
          EN_FMT = 7,
          EN_INT = 255

integer proc Error( integer ErrNo, integer Flag )
    string tmp1[26] = " file could not be created"

    Flag = not Flag
    if Flag
        Alarm()
        case ErrNo
            when EN_KEY
                Warn("Temporary"+tmp1)
            when EN_OUT
                Warn("Output"+tmp1)
            when EN_NUL
                Warn("Macro is empty")
            when EN_SCP
                Warn("Scrap macro defined more than once")
            when EN_CNT
                Warn("Too many macros")
            when EN_INV
                Warn("Invalid key code")
            when EN_FMT
                Warn("Invalid macro format")
            when EN_INT
                Warn("Terminated by user")
        endcase
    endif
    return (Flag)
end

/****************************************************************************\
    Poke word into current line
\****************************************************************************/

proc PokeCurrLine(integer offset, integer word)
    string line[255]
    integer pntr

    line = GetText(1,CurrLineLen())
    pntr = Addr(line) + 2
    PokeWord(pntr+offset,word)
    BegLine()
    KillToEol()
    InsertText(line)
end

/****************************************************************************\
    Translate key codes (compare for showkey.s)
\****************************************************************************/

#ifndef WIN32

integer proc TranslateKey()
    integer add                 // add-in for double shifted keys
    integer dis                 // offset to key code within code table
    integer num                 // numerical key code (function result)
    string alt[NAME_WIDTH]      // shift combination of key
    string key[NAME_WIDTH]      // key name

    // scan key and extract various fields

    if Error(EN_FMT, lFind(key_reg_expr,"cx") )
        return (0)
    endif
    MarkFoundText(1)
    alt = GetMarkedText()
    MarkFoundText(4)
    key = GetMarkedText()
    UnmarkBlock()
    BegLine()

    // swap names, if necessary (non-shifted keys)

    if Length(key) == 0
        key = alt
        alt = ""
    endif

    // translate shift code to offset into code table

    GotoBufferId(keyfile)
    add = 0
    case Lower(alt)
        when "shift"        dis = 1
        when "ctrl"         dis = 5
        when "alt"          dis = 9
        when "shiftshift"   dis = 1   add = 0xFD
        when "ctrlshift"    dis = 5   add = 0xFC
        when "altshift"     dis = 9   add = 0xFB
        when "ctrlalt"      dis = 9   add = 0xFA
        when ""             dis = 13
        otherwise           Error(EN_INV,FALSE) return(0)
    endcase

    // extract numerical key code or translate to hex number

    MarkColumn(1,17,NumLines(),17+KEY_WIDTH)
    if lFind(key,"lgi^$")
        key = GetText(dis,4)
        num = Val(key,16)
        if add
            num = (num & 0xFF00) + add
        endif
    else
        GotoBufferId(hexfile)
        InsertText(key)
        if Error(EN_INV, lFind("^[0-9A-F]+$","cgix") )
            return (0)
        endif
        num = Val(key,16)
        if Error(EN_INV, 0 <= num <= 65535 )
            return (0)
        endif
        EmptyBuffer()
    endif
    UnmarkBlock()
    GotoBufferId(inpfile)

    // return key code

    return (num)
end

#else

integer proc TranslateKey()
    integer code

    if not lFind(key_reg_expr,"cx")
        if Error(EN_FMT, lFind("^ *<{>}>" ,"cx") )
            return (0)
        endif
    endif
    MarkFoundText(1)

    code = KeyCode(GetMarkedText())
    if Error(EN_INV,code)
        return (0)
    endif

    return (code)
end

#endif

/****************************************************************************\
    Prepare header of kbd file

    Format of macro file header
    ? XX bytes header           "magic" header
    ? 42 bytes hotkeys          array of keycodes (word) or null
    ? 42 bytes line pointers    array of line numbers (word) or null
    ? 2 bytes macro count       total number of macros
    ? 2 total line count        total number of lines

    XX = 42 for version 2.5 / 50 for version 2.6
\****************************************************************************/

proc PrepareHeader()
    string keyline[DIM_KEYS] = ""

    // fill header string

    while Length(keyline) < DIM_KEYS
        keyline = keyline + Chr(0)
    endwhile

    // insert header into binary file

    GotoBufferId(outfile)
    AddLine(magic_header)
    AddLine(keyline)
    AddLine(keyline)
    AddLine(keyline[1..4])
end

/****************************************************************************\
    Compile hotkey
\****************************************************************************/

integer proc CompileHotKey()
    integer code                // compiled key code
    integer offset              // insertion position for hotkey

    // compile the key

    code = TranslateKey()
    if code == 0
        return (TRUE)
    endif

    // find macro name

    lFind("<.*>","cgx")
    MarkFoundText()
    curr_macro = GetMarkedText()
    UnmarkBlock()
    Message("Recompiling ",curr_macro)

    // fix up and test counts

    if code == <Enter> or code == <GreyEnter>
        if Error(EN_SCP, not scrap)
            return(TRUE)
        endif
        scrap = TRUE
        offset = 2 * MAX_COUNT
    else
        if Error(EN_CNT, curr_mac < MAX_COUNT)
            return(TRUE)
        endif
        offset = 2 * curr_mac
        curr_mac = curr_mac + 1
    endif

    // go to output file

    GotoBufferId(outfile)

    // insert hotkey and line pointer

    GotoLine(2)
    PokeCurrLine(offset,code)
    GotoLine(3)
    PokeCurrLine(offset,curr_line)

    // insert header of first macro line

    EndFile()
    AddLine("XXXX")

    // go back and indicate success

    GotoBufferId(inpfile)
    return (FALSE)
end

/****************************************************************************\
    Fixup line (insert key count and continuation flag)
\****************************************************************************/

integer proc FixUpLine( integer cont_flag )

    // check size of macro

    if Error(EN_NUL, curr_size > 2  )
        return (TRUE)
    endif

    // go to output

    GotoBufferId(outfile)

    // insert current line size and continuation flag

    lFind("XXXX","^b")
    PokeCurrLine(0,curr_size)
    PokeCurrLine(2,cont_flag)

    EndFile()
    if cont_flag
        AddLine("XXXX")
    endif

    // fix up counts

    curr_size = 2
    curr_line = curr_line + 1

    // go back and indicate success

    GotoBufferId(inpfile)
    return (FALSE)
end

/****************************************************************************\
    Fixup file (insert macro and line counts)
\****************************************************************************/

proc FixUpFile()

    // go to output file

    GotoBufferId(outfile)

    // insert macro count and fix up and insert line count

    GotoLine(4)
    PokeCurrLine(0,curr_mac)
    PokeCurrLine(2,curr_line-1)

    // go back

    GotoBufferId(inpfile)
end

/****************************************************************************\
    Compile key stroke
\****************************************************************************/

integer proc CompileLine()
    integer code                // compiled key code

    // compile the key

    code = TranslateKey()
    if code == 0
        return (TRUE)
    endif

    // check for line overflow and fix up line

    if curr_size == MaxLineLen
        if FixUpLine(0xFFFF)
            return (TRUE)
        endif
    endif

    // increment counts and display progress report

    curr_size = curr_size + 2
    total_size = total_size + 1
    if (total_size & 0x0F) == 0
        Message("Recompiling ",curr_macro,
            ", keys ",total_size, ", press <Escape> to interrupt")
    endif

    // append code to output file

    GotoBufferId(outfile)
    EndLine()
    InsertText(Chr(LoByte(code)))
    InsertText(Chr(HiByte(code)))

    if CurrLineLen() >= LINE_SIZE       // line break in output file
        AddLine()
    endif
    GotoBufferId(inpfile)

    // indicate success

    return (FALSE)
end

/****************************************************************************\
    Recompile driver routine

    Format of keyboard macro
    ? 2 bytes     size of macro (N)
    ? 2 bytes     continuation indicator (0xFFFF or 0x0000)
    ? N-2 bytes   array of keycodes (words)

    Empty lines in the output file can safely be ignored, because
    the output file is in binary format. The global indices used
    are all 1-based except for 'curr_mac', which is 0-based. This
    simplifies offset computing.
\****************************************************************************/

integer proc CompileMacros()
    integer notfirst = FALSE        // flag, not compiling first macro

    // goto to input

    GotoBufferId(inpfile)
    BegFile()

    // compile file one line at a time

    repeat
        case CurrChar(1)
            when Asc(";"), _AT_EOL_             // empty line or comment
                // NOP
            when Asc("<")                       // hotkey
                total_size = 0
                if notfirst
                    if FixUpLine(0)             // fix up previous macro
                        return (FALSE)
                    endif
                else
                    notfirst = TRUE             // setup for first macro
                    curr_line = 1
                    curr_size = 2
                endif
                if CompileHotKey()              // compile hotkey
                    return (FALSE)
                endif
            when Asc(" ")                       // keycode
                if Error(EN_FMT, notfirst) or CompileLine()
                    return (FALSE)
                endif
            otherwise                           // everything else is an error
                Error(EN_FMT,FALSE)
                return (FALSE)
        endcase
                                                // check for user interrupt
        if KeyPressed() and GetKey() == <Escape>
            Error(EN_INT,FALSE)
            return (FALSE)
        endif
    until not Down()

    // fix up last macro and global counts

    if FixUpLine(0)
        return (FALSE)
    endif
    FixUpFile()

    // indicate success

    BegFile()
    return (TRUE)
end

/****************************************************************************\
    Setup
\****************************************************************************/

integer proc Init()
    integer hist
    integer rc, msg
    string inpname[255]

#ifndef WIN32
    integer bid = GetBufferId()

    // load translation table

    inpname = SplitPath(CurrMacroFilename(),_DRIVE_|_PATH_) + key_table
    hexfile = CreateTempBuffer()
    keyfile = CreateTempBuffer()
    if Error(EN_KEY, hexfile and keyfile and InsertFile(inpname,_DONT_PROMPT_))
        return (FALSE)
    endif

    // remove comments from translation table

    while lFind("{^$}|{^//}","gx")
        KillLine()
    endwhile

    GotoBufferId(bid)
#endif

    // determine filenames

    current = CurrExt() == ".k"
    if current
        inpname = CurrFileName()
    else
        hist = GetFreeHistory("ReComp:files")
        msg = Set(MsgLevel,_NONE_)
        rc = LoadMacro("Dialog") and LoadMacro("DlgOpen")
        Set(MsgLevel,msg)
        if rc
            if ExecMacro("DlgOpen -x -t -r") and Val(Query(MacroCmdLine)) == 2
                inpname = GetHistoryStr(hist,1)
            else
                return (FALSE)
            endif
        else
            if not AskFilename("File to recompile:",inpname,_MUST_EXIST_,hist)
                return (FALSE)
            endif
        endif
    endif
    outname = SplitPath(inpname,_DRIVE_|_PATH_|_NAME_) + ".kbd"

    // load input file and create output file

    inpfile = EditFile(QuotePath(inpname))
    outfile = CreateBuffer(outname)
    if Error(EN_OUT, inpfile and outfile)
        return (FALSE)
    endif
    BinaryMode(LINE_SIZE)

    return (TRUE)
end

/****************************************************************************\
    Main program
\****************************************************************************/

proc main()
    integer load

#ifdef WIN32
    MakeMagicHeader(magic_header)
#endif

    load = Query(MacroCmdLine) == "-load"

    if Init()
        PrepareHeader()
        if CompileMacros()
            GotoBufferId(outfile)
            SaveAs(outname,_OVERWRITE_)
            if load or YesNo("load macro") == 1
                LoadKeyMacro(outname)
            endif
        else
            current = TRUE
            GotoBufferId(inpfile)
            ScrollToRow(Query(ScreenRows) / 2)
            MarkLine()
            MarkLine()
        endif
    endif
    if not current
        AbandonFile(inpfile)
    endif
    AbandonFile(outfile)

#ifndef WIN32
    AbandonFile(keyfile)
    AbandonFile(hexfile)
#endif

    UpdateDisplay()
    PurgeMacro(CurrMacroFileName())
end

