/****************************************************************************\

    DeComp.S

    Decompiles binary TSE keyboard macros.

    Overview:

    DeComp reads a binary keyboard macro file and creates a list of
    the embedded macros and their respective key sequences. The
    produced list can be edited and re-compiled with ReComp.

    Keys:   (none)

    Usage notes:

    When called the macro asks for the filename of the keyboard macro
    to decompile. The output filename is the same as the input filename
    with the extension replaced by ".k". If the decompile was success-
    full, the decompiled macro is saved on disk and is displayed as the
    current file.

    Command Line Format:

    DeComp [filename]

    where:

        filename    name of keyboard macro to be decompiled


    Version         v4.00/05.06.01
    Copyright       (c) 1993-2001 by DiK, portions (c) SemWare

    History

    v4.00/05.06.01  added command line options
    v3.40/23.07.99  adaption to TSE32 v3.0
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

string key_table[]  = "keytable.dat"    // name of file containing key table
string magic_header[] = "??Bobbi %"    // magic header of macro file

constant HOTKEYS_OFS = 42               // first hotkey
constant POINTER_OFS = 84               // first line pointer
constant COUNT_OFS   = 126              // macro count
constant LINES_OFS   = 128              // line count
constant MACRO_OFS   = 130              // first macro

integer keyfile                         // key code translation table

#else

string magic_header[] = "??Bobbip%"    // magic header of macro file

constant HOTKEYS_OFS = 50               // first hotkey
constant POINTER_OFS = 92               // first line pointer
constant COUNT_OFS   = 134              // macro count
constant LINES_OFS   = 136              // line count
constant MACRO_OFS   = 138              // first macro

#endif

/****************************************************************************\
    Global constants and variables
\****************************************************************************/

constant MAX_COUNT   = 20               // maximum number of macros per file
                                        // (does not include scrap macro)

constant KEY_WIDTH   = 32               // field width of key code table
constant NAME_WIDTH  = 64               // size of name string
constant LINE_SIZE   = 64               // file format for kbd-file

integer inpfile                         // input file (kbd)
integer outfile                         // output file (k)

string outname[255]                     // name of output file
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
    Test magic header
\****************************************************************************/

integer proc TestMagicHeader()
    string magic[64]
    string header[64]

#ifdef WIN32
    integer len = Length(magic_header)

    magic = magic_header[1..7] + "XX" + magic_header[10..len]
    header = GetText(1,7) + "XX" + GetText(10,len-9)

#else

    magic = magic_header
    header = GetText(1,Length(magic_header))

#endif

    return( magic == header )
end

/****************************************************************************\
    Error handler
\****************************************************************************/

constant  EN_KEY = 1,
          EN_OUT = 2,
          EN_FMT = 9,
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
            when EN_FMT
                Warn("Invalid macro file format")
            when EN_INT
                Warn("Terminated by user")
        endcase
    endif
    return (Flag)
end

/****************************************************************************\
    Translate keycodes (compare for showkey.s)
\****************************************************************************/

#ifndef WIN32

integer proc FindCode( integer key, integer width, integer col )
    string hex_name[4]

    hex_name = format(key:width:'0':16)
    if lFind(hex_name,"g")
        repeat
            if col == 0
                if (CurrPos() - 1) mod 4 == 0
                    return (TRUE)
                endif
            else
                if CurrPos() == col
                    return (TRUE)
                endif
            endif
        until not lRepeatFind()
    endif
    return (FALSE)
end

string proc FindKey( integer key )
    integer n
    string key_name[NAME_WIDTH]
    string cols[4] = Chr(9) + Chr(9) + Chr(5) + Chr(1)

    GotoBufferId(keyfile)
    if FindCode(key,4,0)
        key_name = SubStr(
            "Shift Ctrl  Alt ",
            ((CurrPos() - 1)/4) * 6 + 1, 6 - CurrPos() /4)
        key_name = key_name + GetText(17,KEY_WIDTH)
        return (key_name)
    else
        n = (key & 0xFF) - 0xFA
        if 0 <= n and n <= 3
            if FindCode(key shr 8, 2, Asc(cols[n+1]))
                key_name = SubStr(
                    "CtrlAlt    AltShift   CtrlShift  ShiftShift ",
                    n * 11 + 1, n + 8)
                key_name = key_name + GetText(17,KEY_WIDTH)
                return (key_name)
            endif
        endif
    endif
    return (Str(key,16))
end

#else

string proc FindKey( integer key )
    integer n
    string key_name[NAME_WIDTH]

    key_name = KeyName(key)
    for n = Length(key_name) downto 1
    	if Asc(key_name[n]) < 32
    		key_name = "<"+Str(key,16)+">"
    		break
    	endif
    endfor
    return (key_name)
end

#endif

/****************************************************************************\
    determine word at specified offset of binary macro file
\****************************************************************************/

integer proc GetBinary( integer offset )
    integer l, c                // line and col numbers of word in file

    GotoBufferId(inpfile)
    l = offset / LINE_SIZE + 1
    c = offset mod LINE_SIZE + 1
    GotoLine(l)
    if l > NumLines() or c >= CurrLineLen()
        return (-1)
    endif

    return (CurrChar(c) + (CurrChar(c+1) shl 8))
end

/****************************************************************************\
    Decompile macro file header

    Format of macro file header
    ? XX bytes header           "magic" header
    ? 42 bytes hotkeys          array of keycodes (word) or null
    ? 42 bytes line pointers    array of line numbers (word) or null
    ? 2 bytes macro count       total number of macros
    ? 2 total line count        total number of lines

    XX = 42 for version 2.5 / 50 for version 2.6
\****************************************************************************/

integer proc DecompHeader( integer macro )
    integer hotkey                      // macro hotkey
    integer start                       // line pointer

    // determine and check hotkey and line pointer

    hotkey = GetBinary( HOTKEYS_OFS + 2*macro )
    start  = GetBinary( POINTER_OFS + 2*macro )
    if hotkey <= 0 or start <= 0
        return (hotkey)
    endif

    // translate hotkey

    curr_macro = "<" + FindKey(hotkey) + ">"
//    if macro == MAX_COUNT
//        curr_macro = InsStr("%",curr_macro,2)
//    endif
    AddLine("",outfile)
    AddLine(curr_macro,outfile)
    Message("Decompiling ",curr_macro)

    // return line pointer

    return (start)
end

/****************************************************************************\
    Decompile macro blocks

    Format of keyboard macro
    ? 2 bytes     size of macro (N)
    ? 2 bytes     continuation indicator (0xFFFF or 0x0000)
    ? N-2 bytes   array of keycodes (words)
\****************************************************************************/

integer proc DecompMacro( integer start )
    integer key_count = 0               // count of translated keys
    integer lines  = 0                  // lines occupied by current macro
    integer curr   = 1                  // current line
    integer offset = MACRO_OFS          // position within macro file
    integer size                        // size of current line
    integer cont                        // continuation indicator
    integer code                        // key code
    string name[NAME_WIDTH] = ""        // key name

    // search starting position of current macro

    loop
        size = GetBinary(offset)                // get line header
        cont = GetBinary(offset+2)
        if size < 4 or MaxLineLen < size or cont <> 0x0000 and cont <> 0xFFFF
            return (0)
        endif

        if curr >= start                        // line found ?
            break
        endif

        offset = offset + size + 2              // offset of next line
        curr = curr + 1                         // increment line count
    endloop

    // decompile current macro

    loop
        lines  = lines  + 1                     // increment line count
        size   = size   - 4                     // skip macro header
        offset = offset + 4

        while size >= 0
            code = GetBinary(offset)            // get and translate key
            if code < 0
                return (0)
            endif
            name = FindKey(code)
            AddLine("    <"+name+">",outfile)

            key_count = key_count + 1           // display progress report
            if (key_count & 0x0F) == 0
                Message("Decompiling ",curr_macro,
                    ", keys ",key_count, ", press <Escape> to interrupt")
            endif

            size   = size   - 2                 // next key code
            offset = offset + 2
                                                // check for user interrupt
            if KeyPressed() and GetKey() == <Escape>
                return (-1)
            endif
        endwhile

        if cont == 0x0000                       // last line of macro ?
            GotoBufferId(outfile)
            GotoColumn(40)
            InsertText("DO NOT EDIT OR DELETE THIS LINE")
            BegLine()
            GotoBufferId(inpfile)
            break
        endif

        size = GetBinary(offset)                // get next line header
        cont = GetBinary(offset+2)
        if size < 4 or MaxLineLen < size or cont <> 0x0000 and cont <> 0xFFFF
            return (0)
        endif
    endloop

    // return line count of current macro

    return (lines)
end

/****************************************************************************\
    Decompile driver routine

    The indices used by Decompile() are all 1-based except for 'macro',
    which is 0-based. This simplifies computing offsets.
\****************************************************************************/

integer proc Decompile()
    integer macro = 0           // current macro index
    integer count = 0           // count of macros found
    integer total = 0           // lines occupied by all macros
    integer lines               // lines occupied by current macro
    integer start               // pointer to first line of current macro
    integer num_macs            // total count of macros stored in file
    integer num_lines           // total count of lines used to store macors

    // test macro file header

    GotoBufferId(inpfile)
    if Error(EN_FMT, TestMagicHeader())
        return (FALSE)
    endif

    // get and check macro and line counts

    num_macs = GetBinary(COUNT_OFS)
    num_lines = GetBinary(LINES_OFS)
    if Error(EN_FMT, num_macs >= 0 and num_lines >= num_macs)
        return (FALSE)
    endif

    // decompile macro file (loop is executed MAC_COUNT+1 times)

    while macro <= MAX_COUNT

        start = DecompHeader(macro)             // get hotkey and pointer
        if Error(EN_FMT, 0 <= start and start <= num_lines)
            return (FALSE)
        endif

        if start > 0                            // slot used ?
            count = count + 1                   // increment macro count
            if Error(EN_FMT, count <= num_macs or macro == MAX_COUNT)
                return (FALSE)
            endif

            lines = DecompMacro(start)          // decompile macro
            if Error(EN_INT, lines >= 0)        // user interrupt
                return (FALSE)
            endif
            if Error(EN_FMT, lines >= 1)        // invalid format
                return (FALSE)
            endif

            total = total + lines               // increment line count
            if Error(EN_FMT, total <= num_lines)
                return (FALSE)
            endif
        endif

        macro = macro + 1                       // increment index
    endwhile

    // indicate success

    AddLine("",outfile)
    return (TRUE)
end

/****************************************************************************\
    Setup
\****************************************************************************/

integer proc Init()
    integer rc, msg
    string inpname[255]

#ifndef WIN32
    integer bid = GetBufferId()

    // load translation table

    inpname = SplitPath(CurrMacroFilename(),_DRIVE_|_PATH_) + key_table
    keyfile = CreateTempBuffer()
    if Error(EN_KEY, keyfile and InsertFile(inpname,_DONT_PROMPT_))
        return (FALSE)
    endif
    UnmarkBlock()

    // remove comments from translation table

    while lFind("{^$}|{^//}","gx")
        KillLine()
    endwhile

    GotoBufferId(bid)
#endif

    // determine file names

    inpname = Query(MacroCmdLine)
    if inpname == "" or not FileExists(inpname)
        msg = Set(MsgLevel,_NONE_)
        rc = LoadMacro("Dialog") and LoadMacro("DlgOpen")
        Set(MsgLevel,msg)
        if rc
            if not (ExecMacro("DlgOpen -x -t -d") and Val(Query(MacroCmdLine)) == 2)
                return (FALSE)
            endif
            inpname = GetHistoryStr(_KEYMACRO_HISTORY_,1)
        else
            if not AskFilename("File to decompile:", inpname, _MUST_EXIST_, _KEYMACRO_HISTORY_)
                return (FALSE)
            endif
        endif
    endif
    outname = SplitPath(inpname,_DRIVE_|_PATH_|_NAME_) + ".k"

    // load input file and create output file

    inpfile = EditFile(Format("-b", LINE_SIZE, " ", QuotePath(inpname)))
    outfile = EditFile(QuotePath(outname))
    if Error(EN_OUT, inpfile and outfile)
        return (FALSE)
    endif
    EmptyBuffer()

    // indicate success

    return (TRUE)
end

/****************************************************************************\
    Main program
\****************************************************************************/

proc main()

#ifdef WIN32
    MakeMagicHeader(magic_header)
#endif

    if Init() and Decompile()
        GotoBufferId(outfile)
        SaveFile()
        BegFile()
    else
        AbandonFile(outfile)
    endif
    AbandonFile(inpfile)

#ifndef WIN32
    AbandonFile(keyfile)
#endif

    UpdateDisplay()
    PurgeMacro(CurrMacroFileName())
end

