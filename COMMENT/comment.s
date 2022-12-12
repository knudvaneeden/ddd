/*
 �������������������������������������������������������������������������������������������������ͻ
 �                                                                                                 �
 � COMMENT:     Commenting SAL-Macros                                                              �
 �                                                                                                 �
 � AUTHOR:      Peter Kraemer, pjr-kraemer@t-online.de                                             �
 �                                                                                                 �
 � DATE:        May 1997 to December 2001                                                          �
 �                                                                                                 �
 �                                                                                                 �
 � DISCLAIMER:                                                                                     �
 �                                                                                                 �
 � I will take no responsibility for damage or loss of SAL source code caused by using this macro. �
 �                                                                                                 �
 �                                                                                                 �
 � KEYS:                                                                                           �
 �                                                                                                 �
 � <F12>  Main Menu                                                                                �
 �                                                                                                 �
 �                                                                                                 �
 � OVERVIEW:                                                                                       �
 �                                                                                                 �
 � This macro was inspired by the procedure comments found in several macros by Ian Campbell.      �
 �                                                                                                 �
 � It allows to create and maintain framed comments with standard entries at the top of each       �
 � proc, menu, keydef or datadef in a SAL source code file. The following features are provided:   �
 �                                                                                                 �
 � * Procedure comments                                                                            �
 �   - Generation of standardized comments in front of each proc type structure in a SAL source.   �
 �   - Customizable appearance of comment frame.                                                   �
 �   - Customizable comment frame size and positioning of all subcomments.                         �
 �   - Comment editor to create and maintain subcomments.                                          �
 �   - Automatic generation and update of "Called by" list.                                        �
 �   - Automatic checks for procedures with parameters.                                            �
 �   - Automatic checks for procedures with return values.                                         �
 �   - Update may be automatic (silent) or interactive (query for empty items).                    �
 �                                                                                                 �
 � * Additional comments                                                                           �
 �   - Additional comment blocks not releated to a proc can be created anywhere between procs.     �
 �   - Management of additional comments similar to procedure comments.                            �
 �   - Arbitrary parts of the source file can be blocked and put into a comment frame.             �
 �   - Headline comments, i.e. headline text framed by two divider lines, can be created anywhere  �
 �     between procs.                                                                              �
 �                                                                                                 �
 � * Miscellaneous                                                                                 �
 �   - Empty lines can be managed. Default behaviour is to delete all empty lines inside and       �
 �     duplicate empty lines outside of proc type struktures.                                      �
 �   - The _ON_CHANGING_FILES_ hook is used to determine whether the current file is a SAL source  �
 �     file (extensions .s and .ui). If not, the menu key of the macro is not activated.           �
 �                                                                                                 �
 �                                                                                                 �
 � USAGE NOTES:                                                                                    �
 �                                                                                                 �
 � The following precautions should be taken when using this macro:                                �
 �                                                                                                 �
 � * The macro changes your SAL source file! Hence, KEEP A BACKUP COPY of the SAL source file.     �
 �                                                                                                 �
 � * The macro contains some logic to determine begin and end of proc type SAL structures.         �
 �   Before using the macro make sure your SAL code compiles without error. Otherwise results are  �
 �   unpredictable.                                                                                �
 �                                                                                                 �
 � * After commenting is finished recompile your SAL source to make sure no code was compromized   �
 �   by using the macro.                                                                           �
 �                                                                                                 �
 � * When first commenting a big source file the best way is to set the "Silent" switch to ON. The �
 �   macro will create the comment frames and all entries that can be generated autmatically       �
 �   without user interaction. If the "Silent" switch is set to OFF the macro will query for each  �
 �   entry with empty text.                                                                        �
 �                                                                                                 �
 � * When using "Update" the current frame type of an existing comment will not be changed even if �
 �   the configured frame type for new comments is different. To change the frame type of existing �
 �   comments use "Frame".                                                                         �
 �                                                                                                 �
 �                                                                                                 �
 � CUSTOMIZING:                                                                                    �
 �                                                                                                 �
 � * All default values are defined in the section "DEFAULTS" almost at the beginning of the macro �
 �   code. These values may be changed according to personal preferences.                          �
 �                                                                                                 �
 � * A special default is the value of _HEAD_MARK. I put a Chr(0) right behind the starting "//"   �
 �   string of headline comments because I modified the function list feature of the SemWare user  �
 �   interface to display such headlines. If you do not like this change the value of _HEAD_MARK   �
 �   to 32 to just create a blank after the "//" string.                                           �
 �                                                                                                 �
 �������������������������������������������������������������������������������������������������ͼ
*/

// �������������������������������������������������������������������������������������������������
// CONSTANTS
// �������������������������������������������������������������������������������������������������

constant _MSL    = MAXSTRINGLEN,
          //
         _DEF    =  0,
         _FND    =  1,
         _REP    =  2,
          //
         _CNULL  =  0,
         _COPEN  =  1,  // This order
         _CNAME  =  2,  // must reflect
         _CTEXT  =  3,  // the order
         _CALLS  =  4,  // of the
         _CARGS  =  5,  // subcomments
         _CRETS  =  6,  // in the
         _CNOTE  =  7,  // comment!
         _CVOID  =  8,  // CVOID must be
         _CFULL  = 10,  // CNOTE + 1
         _CLAST  = 11,  // CLAST must be
         _CLOSE  = 12,  // CFULL + 1.
          //
         _TFRST  =  1,
         _TNAME  =  2,
         _TMAIN  =  3,
         _TELSE  =  4,
         _TENDC  =  5,
         _TLAST  =  6,
          //
         _INPROC =  1,  // All must
         _INLINE =  2,  // be greater
         _INCOMM =  3,  // than zero
          //
         _COMOLD =  1,
         _COMNEW =  2,
          //
         _ISPROC =  1,
         _ISMENU =  2,
         _ISADEF =  3,
          //
         _DONOT  =  0,
         _DOASK  =  1,
         _DOAUTO =  2,
          //
         _MODCUR =  0,
         _MODDWN =  1,
         _MODALL =  2,
          //
         _YNTRUE =  1,  // Must be
         _YNYES  =  2,  // not equal
         _YNEXIT =  3,  // zero
          //
         _FRAME  =  1,
         _UPDATE =  2,
         _DELETE =  3

// �������������������������������������������������������������������������������������������������
// DEFAULTS
// �������������������������������������������������������������������������������������������������

constant _MENU_KEY  = <F12>,                    // Key to start this macro
         _LINE_INCL = FALSE,                    // Put /*..*/ on separate lines
         _LINE_TYP1 =   1,                      // Line type used for procedure frame
         _LINE_TYP2 =   4,                      // Line type used for additional comment frame
         _HEAD_MARK =   0,                      // ASCII code of marker char after // of headlines
         _TAB_FRST  =   2,                      // Column of left frame side
         _TAB_MAIN  =   4,                      // Start column of leading comment text
         _TAB_NAME  =   5,                      // Start column of procedure name in frame
         _TAB_ELSE  =  17,                      // Start column of other subcomments
         _TAB_ENDC  =  98,                      // Last column of comment texts
         _TAB_LAST  = 100,                      // Column of right frame side
         _DO_NEW    = _DOAUTO,                  // Insert new comments
         _DO_BOX    = _DOAUTO,                  // Reframe comments
         _DO_NAM    = _DOAUTO,                  // Update procedure name in frame
         _DO_TXT    = _DOAUTO,                  // Update empty leading comment texts
         _DO_CAL    = _DOAUTO,                  // Update list of procedure calls
         _DO_ARG    = _DOAUTO,                  // Update argument comments
         _DO_RET    = _DOAUTO,                  // Update return value comments
         _DO_ALL    = _DONOT,                   // Toggle all update switches
         _DO_MOD    = _MODCUR,                  // Update mode (current, all or following)
         _DO_STP    = TRUE                      // Turn off silent mode

string   STR_EXTENSIONS_[] = "|.s|.ui|",        // Extensions activating the main menu key
         STR_CALLED_BY_[]  = "Called by:   ",   // Subcomment title
         STR_ENTER_WITH_[] = "Enter with:  ",   // Subcomment title
         STR_RETURNS_[]    = "Returns:     ",   // Subcomment title
         STR_NOTES_[]      = "Notes:       ",   // Subcomment title
         STR_NOTHING_[]    = "Nothing.",        // Text for empty parameter list or no return value
         STR_EMPTY_[]      = "None"             // Null text raising notes deletion prompt

// �������������������������������������������������������������������������������������������������
// VARIABLES
// �������������������������������������������������������������������������������������������������

integer  LINE_INCL = _LINE_INCL,
         LINE_TYP1 = _LINE_TYP1,
         LINE_TYP2 = _LINE_TYP2,
         TAB_FRST  = _TAB_FRST,
         TAB_MAIN  = _TAB_MAIN,
         TAB_NAME  = _TAB_NAME,
         TAB_ELSE  = _TAB_ELSE,
         TAB_ENDC  = _TAB_ENDC,
         TAB_LAST  = _TAB_LAST,
         DO_NEW    = _DO_NEW,
         DO_BOX    = _DO_BOX,
         DO_NAM    = _DO_NAM,
         DO_TXT    = _DO_TXT,
         DO_CAL    = _DO_CAL,
         DO_ARG    = _DO_ARG,
         DO_RET    = _DO_RET,
         DO_ALL    = _DO_ALL,
         DO_STP    = _DO_STP,
         DO_MOD    = _DO_MOD,
         PROC_TYPE = FALSE,
         PROC_ARGS = FALSE,
         PROC_RETS = FALSE,
         POP_UP    = FALSE,
         POP_RM    = _TAB_LAST - _TAB_FRST - 2,
         POP_ENTRY = 0,
         POP_CID   = 0,
         POP_LINES = 0,
         POP_TOP   = 1,
         POP_OFF   = 0,
         VIEW_ID   = 0,
         VIEW_W    = 0,
         LAST_LINE = 0,
         CRSR_ATTR = 0,
         BLCK_ATTR = 0,
         HEAD_MODE = FALSE,
         IN_PROC   = FALSE,
         BLOCK_MEM = FALSE

string   STR_PROC_TYPE[]          = "{proc }|{menub?a?r? }|{[dDhHkK]...?def } @",
         STR_PROC_SPEC[_MSL]      = "",
         STR_PROC_ALLG[_MSL]      = "",
         STR_PROC_LAST[_MSL]      = "",
         STR_PROC_NAME[32]        = "",
         STR_STATUS_LINE[_MSL]    = "",
         STR_NOTHING[_MSL]        = "",
         STR_EMPTY[_MSL]          = "",
         STR_FND_CALLED_BY[_MSL]  = "",
         STR_FND_ENTER_WITH[_MSL] = "",
         STR_FND_RETURNS[_MSL]    = "",
         STR_FND_NOTES[_MSL]      = "",
         STR_REP_CALLED_BY[_MSL]  = "",
         STR_REP_ENTER_WITH[_MSL] = "",
         STR_REP_RETURNS[_MSL]    = "",
         STR_REP_NOTES[_MSL]      = ""

// �������������������������������������������������������������������������������������������������
// HELPER MACROS
// �������������������������������������������������������������������������������������������������

/*
 ��� YesNoMenu �����������������������������������������������������������������������������������Ŀ
 �                                                                                                 �
 � Alert box for Yes/No decisions.                                                                 �
 �                                                                                                 �
 � Called by:   IfYesNo().                                                                         �
 �                                                                                                 �
 ���������������������������������������������������������������������������������������������������
*/

menu YesNoMenu()
    "&Yes"
    "&No"
end

/*
 ��� FlushKeys �����������������������������������������������������������������������������������Ŀ
 �                                                                                                 �
 � Empties the key buffer.                                                                         �
 �                                                                                                 �
 � Called by:   IfYesNo(), YesNoExit(), MoveOut(), ShowCommentMenu(), WhenLoaded().                �
 �                                                                                                 �
 � Enter with:  Nothing.                                                                           �
 �                                                                                                 �
 � Returns:     Nothing.                                                                           �
 �                                                                                                 �
 ���������������������������������������������������������������������������������������������������
*/

proc FlushKeys()
    while KeyPressed()
        GetKey()
    endwhile
    Set(Key, 0)
end

/*
 ��� IfYesNo �������������������������������������������������������������������������������������Ŀ
 �                                                                                                 �
 � Alert box for Yes/No/Cancel decisions.                                                          �
 �                                                                                                 �
 � Called by:   StopAdvance(), FormatEmptyLines(), EraseEmptyNoteComment(), DeleteComment(),       �
 �              UpdateComment().                                                                   �
 �                                                                                                 �
 � Enter with:  Title of Yes/No/Cancel menu.                                                       �
 �                                                                                                 �
 � Returns:     TRUE if Yes was selected, FALSE otherwise.                                         �
 �                                                                                                 �
 ���������������������������������������������������������������������������������������������������
*/

integer proc IfYesNo(string title)
    Set(X1, Query(ScreenCols))
    Set(Y1, 1)
    FlushKeys()
    return(YesNoMenu(title) == 1)
end

/*
 ��� mMin ����������������������������������������������������������������������������������������Ŀ
 �                                                                                                 �
 � Determines the minimum of two integers if both integers are greater than zero. If one integer   �
 � is zero the other one is returned.                                                              �
 �                                                                                                 �
 � Called by:   CurrEnv(), GotoSubComment(), GotoNext(), FrameBlock(), GetTab().                   �
 �                                                                                                 �
 � Enter with:  The two integers to be compared.                                                   �
 �                                                                                                 �
 � Returns:     The minimal value.                                                                 �
 �                                                                                                 �
 ���������������������������������������������������������������������������������������������������
*/

integer proc mMin(integer m, integer n)
    if not (m and n)
        return(m + n)
    endif
    return(Min(m, n))
end

/*
 ��� WrapAllPara ���������������������������������������������������������������������������������Ŀ
 �                                                                                                 �
 � Formats all lines of the current buffer with WrapPara().                                        �
 �                                                                                                 �
 � Called by:   UpdateEditWindow(), ReframeComment().                                              �
 �                                                                                                 �
 � Enter with:  Right margin to be used by WrapPara().                                             �
 �                                                                                                 �
 � Returns:     Nothing.                                                                           �
 �                                                                                                 �
 ���������������������������������������������������������������������������������������������������
*/

proc WrapAllPara(integer maxl)
    integer rm = Set(RightMargin, maxl), ai = Set(AutoIndent, _STICKY_)
    BegFile()
    repeat
        if CurrLineLen() > maxl
            POP_OFF = 0
            WrapPara()
        endif
    until not Down()
    Set(RightMargin, rm)
    Set(AutoIndent, ai)
end

/*
 ��� SaveStatusLine ������������������������������������������������������������������������������Ŀ
 �                                                                                                 �
 � Reads character/attributes pairs from the statusline and puts the combined string into a        �
 � global string variable.                                                                         �
 �                                                                                                 �
 � Called by:   Incl(), SetTab().                                                                  �
 �                                                                                                 �
 � Enter with:  Nothing.                                                                           �
 �                                                                                                 �
 � Returns:     Nothing.                                                                           �
 �                                                                                                 �
 � Notes:       The string created by this procedure can be used to restore the statusline in      �
 �              cases where UpdateDisplay() does not work, e.g. when a manu is open.               �
 �                                                                                                 �
 ���������������������������������������������������������������������������������������������������
*/

proc SaveStatusLine()
    integer n
    string  s[_MSL] = "", a[_MSL] = ""
    STR_STATUS_LINE = ""
    GetStrAttrXY(-WhereXAbs(), -WhereYAbs(), s, a, Query(ScreenCols))
    for n = 1 to Length(s)
        STR_STATUS_LINE = STR_STATUS_LINE + s[n] + a[n]
    endfor
end

/*
 ��� mPutHelpLine ��������������������������������������������������������������������������������Ŀ
 �                                                                                                 �
 � Displays a formatted helpline at the bottom of the screen.                                      �
 �                                                                                                 �
 � Called by:   StopAdvance(), CompareBuffers(), ShowCommentMenu().                                �
 �                                                                                                 �
 � Enter with:  Help string to be displayed, flag indicating if string should be left or right     �
 �              justified.                                                                         �
 �                                                                                                 �
 � Returns:     Nothing.                                                                           �
 �                                                                                                 �
 ���������������������������������������������������������������������������������������������������
*/

proc mPutHelpLine(string lin, integer dir)
    if Query(ShowHelpLine)
        VGotoXYAbs(1, Query(ScreenRows) - Query(StatusLineRow) + 1)
        PutHelpLine(Format(lin : dir * (Query(ScreenCols) + 4)))
    endif
end

/*
 ��� GotoNextNonWhite ����������������������������������������������������������������������������Ŀ
 �                                                                                                 �
 � Moves the cursor to the next non white character on the current line.                           �
 �                                                                                                 �
 � Called by:   FrameBlock(), EraseEmptyNoteComment(), EditComment(), UpdateEntry(), UpdateProc(). �
 �                                                                                                 �
 � Enter with:  Nothing.                                                                           �
 �                                                                                                 �
 � Returns:     Nothing.                                                                           �
 �                                                                                                 �
 ���������������������������������������������������������������������������������������������������
*/

proc GotoNextNonWhite()
    while isWhite() and Right()
    endwhile
end

/*
 ��� Incl ����������������������������������������������������������������������������������������Ŀ
 �                                                                                                 �
 � Indicates whether the begin comment string should be on the same line as the top of the comment �
 � frame. If so Incl() checks if the left border of the frame is placed accordingly.               �
 �                                                                                                 �
 � Called by:   FrameBlock(), PositionMenu().                                                      �
 �                                                                                                 �
 � Enter with:  Flag indicating whether to toggle the behaviour of the begin comment string.       �
 �                                                                                                 �
 � Returns:     Flag indicating the position of the begin comment string.                          �
 �                                                                                                 �
 ���������������������������������������������������������������������������������������������������
*/

integer proc Incl(integer swap)
    integer ub = iif((LINE_TYP1 == 7 or LINE_TYP2 == 7) and Query(LineDrawChar) == Asc("*"), 2, 3)
    if swap
        LINE_INCL = not LINE_INCL
    endif
    if LINE_INCL and TAB_FRST < ub
        LINE_INCL = FALSE
        Alarm()
        SaveStatusLine()
        Message("Left Border must be at least"; ub)
        PushKey(GetKey())
        VGotoXYAbs(1, 1)
        PutNCharAttr(STR_STATUS_LINE, Query(ScreenCols))
    endif
    return(LINE_INCL)
end

/*
 ��� FrameTop ������������������������������������������������������������������������������������Ŀ
 �                                                                                                 �
 � Determines the current comment frame type according to the setting of the line draw type.       �
 �                                                                                                 �
 � Called by:   HeadlineComment(), UpdateFrame().                                                  �
 �                                                                                                 �
 � Enter with:  Flag defining the position of the returned character.                              �
 �                                                                                                 �
 � Returns:     A typical character of the top frame line of a comment:                            �
 �              type = 0  :  Top left edge char                                                    �
 �              type = 1  :  Middle frame char                                                     �
 �              type = 2  :  Top right edge char                                                   �
 �                                                                                                 �
 ���������������������������������������������������������������������������������������������������
*/

string proc FrameTop(integer proc_frm, integer frm_pos)
    string  top[21] = " " + Chr(Query(LineDrawChar))
    top = "����+" + top + "����-" + top + "����+" + top
    return(top[7 * frm_pos + iif(proc_frm, LINE_TYP1, LINE_TYP2)])
end

/*
 ��� IsFrameSide ���������������������������������������������������������������������������������Ŀ
 �                                                                                                 �
 � Determines if the current character is one of the characters used for drawing a frame side.     �
 �                                                                                                 �
 � Called by:   EraseEmptyNoteComment(), ReplaceComment(), MarkComment(), UpdateEntry(),           �
 �              UpdateProc().                                                                      �
 �                                                                                                 �
 � Enter with:  Nothing.                                                                           �
 �                                                                                                 �
 � Returns:     TRUE if the checked character is a frame side character, FALSE otherwise.          �
 �                                                                                                 �
 ���������������������������������������������������������������������������������������������������
*/

integer proc IsFrameSide()
    return(Pos(Chr(CurrChar()), "��|*" + Chr(Query(LineDrawChar))))
end

/*
 ��� isCursorInBlockMark �������������������������������������������������������������������������Ŀ
 �                                                                                                 �
 � Checks if the cursor is at a block marked position.                                             �
 �                                                                                                 �
 � Called by:   UpdateEditWindow().                                                                �
 �                                                                                                 �
 � Enter with:  Nothing.                                                                           �
 �                                                                                                 �
 � Returns:     TRUE if cursor is at a block marked position, FALSE otherwise.                     �
 �                                                                                                 �
 � Notes:       If the cursor is at the end of a character block it is inside the block but the    �
 �              position is NOT marked.                                                            �
 �                                                                                                 �
 ���������������������������������������������������������������������������������������������������
*/

integer proc isCursorInBlockMark()
    case isCursorInBlock()
        when _INCLUSIVE_, _LINE_, _COLUMN_
            return(TRUE)
        when _NONINCLUSIVE_
            PushPosition()
            if GotoBlockEnd()
                PopPosition()
                return(TRUE)
            else
                PopPosition()
                return(FALSE)
            endif
    endcase
    return(FALSE)
end

/*
 ��� Quoted ��������������������������������������������������������������������������������������Ŀ
 �                                                                                                 �
 � Checks whether the current position is framed by quote chars '"' or "'" or commented by "//".   �
 �                                                                                                 �
 � Called by:   FindCalls().                                                                       �
 �                                                                                                 �
 � Enter with:  Nothing.                                                                           �
 �                                                                                                 �
 � Returns:     TRUE if current position is quoted or commented, FALSE otherwise.                  �
 �                                                                                                 �
 ���������������������������������������������������������������������������������������������������
*/

integer proc Quoted()
    integer d = FALSE, s = FALSE, i = 1
    while i < CurrPos()
        if CurrChar(i) == Asc('"') and not s
            d = not d
        endif
        if CurrChar(i) == Asc("'") and not d
            s = not s
        endif
        if GetText(i, 2) == "//" and not (d or s)
            return(TRUE)
        endif
        i = i + 1
    endwhile
    return(d or s)
end

/*
 ��� GetString �����������������������������������������������������������������������������������Ŀ
 �                                                                                                 �
 � Returns a default, search or replacement string used as keyword in a block comment.             �
 �                                                                                                 �
 � Called by:   ColonTrim(), Show(), mRead().                                                      �
 �                                                                                                 �
 � Enter with:  Comment entry, type (i.e. default, search or replacement) of keyword.              �
 �                                                                                                 �
 � Returns:     Keyword string.                                                                    �
 �                                                                                                 �
 ���������������������������������������������������������������������������������������������������
*/

string proc GetString(integer type, integer entry)
    case type
        when _DEF
            case entry
                when _CNULL
                    return(STR_NOTHING_)
                when _CTEXT
                    return(STR_EMPTY_)
                when _CALLS
                    return(STR_CALLED_BY_)
                when _CARGS
                    return(STR_ENTER_WITH_)
                when _CRETS
                    return(STR_RETURNS_)
                when _CNOTE
                    return(STR_NOTES_)
            endcase
        when _FND
            case entry
                when _CNULL
                    return(STR_NOTHING)
                when _CTEXT
                    return(STR_EMPTY)
                when _CALLS
                    return(STR_FND_CALLED_BY)
                when _CARGS
                    return(STR_FND_ENTER_WITH)
                when _CRETS
                    return(STR_FND_RETURNS)
                when _CNOTE
                    return(STR_FND_NOTES)
            endcase
        when _REP
            case entry
                when _CALLS
                    return(STR_REP_CALLED_BY)
                when _CARGS
                    return(STR_REP_ENTER_WITH)
                when _CRETS
                    return(STR_REP_RETURNS)
                when _CNOTE
                    return(STR_REP_NOTES)
            endcase
    endcase
    return("")
end

/*
 ��� GetKeyText ����������������������������������������������������������������������������������Ŀ
 �                                                                                                 �
 � Extracts the key name of a key assignment from the current line.                                �
 �                                                                                                 �
 � Called by:   FindCalls().                                                                       �
 �                                                                                                 �
 � Enter with:  Nothing.                                                                           �
 �                                                                                                 �
 � Returns:     Name of a key.                                                                     �
 �                                                                                                 �
 ���������������������������������������������������������������������������������������������������
*/

string proc GetKeyText()
    if lFind("^ @{/\*}? @{{<.+>}#}", "cgx")
        return(GetFoundText(2))
    endif
    return("")
end

/*
 ��� YesNoExit �����������������������������������������������������������������������������������Ŀ
 �                                                                                                 �
 � Depending on several switches either a Yes/No/Cancel alert box is called or a decision is       �
 � calculated automatically.                                                                       �
 �                                                                                                 �
 � Called by:   NewComment(), UpdateFrame(), CompareBuffers(), UpdateEntry(), UpdateProc(),        �
 �              CommentProc().                                                                     �
 �                                                                                                 �
 � Enter with:  Title for alert box.                                                               �
 �                                                                                                 �
 � Returns:     TRUE if decision was Yes, FALSE otherwise.                                         �
 �                                                                                                 �
 ���������������������������������������������������������������������������������������������������
*/

integer proc YesNoExit(integer type, string title)
    integer ret = FALSE
    FlushKeys()
    case iif(DO_ALL and type > 0, DO_ALL, Abs(type))
        when _DOASK
            if Query(MsgLevel)
                UpdateDisplay()
                Set(X1, 80)
                Set(Y1,  1)
                case YesNo(title)
                    when 1
                        ret = _YNYES
                    when 3
                        ret = _YNEXIT
                endcase
            else
                ret = _YNTRUE   // Assuming TRUE when in scroll mode.
            endif
        when _DOAUTO
            ret = iif(Query(MsgLevel), _YNYES, _YNTRUE)
    endcase
    return(ret)
end

/*
 ��� StopAdvance ���������������������������������������������������������������������������������Ŀ
 �                                                                                                 �
 � When updating comments in scroll mode this subroutine displays a progress bar on the status     �
 � line and the name of the currently processed comment on the help line. Furthermore, it provides �
 � interupting the scroll mode.                                                                    �
 �                                                                                                 �
 � Called by:   MakePickList(), FormatEmptyLines(), UpdateComment().                               �
 �                                                                                                 �
 � Enter with:  Part of the message string on the help line.                                       �
 �                                                                                                 �
 � Returns:     TRUE while no interupt by the user is desired, FALSE otherwise.                    �
 �                                                                                                 �
 ���������������������������������������������������������������������������������������������������
*/

integer proc StopAdvance(string msg)
    integer sc = Query(ScreenCols), n = sc * CurrLine() / NumLines(), p = 100 * CurrLine() / NumLines()
    Message(Format(Format(p : 1 + sc / 2, "%") : -sc))
    VGotoXYAbs(0, 0)
    PutAttr(Color(Intense Black on Magenta), n)
    PutAttr(Color(Intense Black on Yellow), sc - n)
    VGotoXyAbs(WhereXAbs(), WhereYAbs())
    mPutHelpLine(Format(iif(Length(msg), msg + ": {" + STR_PROC_NAME + "()}", "") : 15 - sc,
                        "{<Escape>}-Interupt"), -1)
    while KeyPressed()
        if GetKey() == <Escape>
            return(IfYesNo("Interupt"))
        endif
    endwhile
    return(FALSE)
end

/*
 ��� EndEdit �������������������������������������������������������������������������������������Ŀ
 �                                                                                                 �
 � Ends editing of a comment and prepares for closing the according popwin.                        �
 �                                                                                                 �
 � Called by:   Bound to <Escape> in EndEditKey.                                                   �
 �                                                                                                 �
 � Enter with:  Nothing.                                                                           �
 �                                                                                                 �
 � Returns:     Nothing.                                                                           �
 �                                                                                                 �
 ���������������������������������������������������������������������������������������������������
*/

proc EndEdit()
    POP_LINES = 0
    EndProcess()
end

/*
 ��� EndProcessKeys ������������������������������������������������������������������������������Ŀ
 �                                                                                                 �
 � Must be enabled to end positioning mode.                                                        �
 �                                                                                                 �
 � Called by:   Used in HeadlineComment(), CommentBlock().                                         �
 �                                                                                                 �
 ���������������������������������������������������������������������������������������������������
*/

keydef EndProcessKeys
    <HelpLine>      "{<Enter>}-Accept  {<Escape>}-End"
    <Escape>        EndProcess()
    <Enter>         EndProcess(1)
end

/*
 ��� EndEditKey ����������������������������������������������������������������������������������Ŀ
 �                                                                                                 �
 � Used to close an edit panel.                                                                    �
 �                                                                                                 �
 � Called by:   Used in EditComment().                                                             �
 �                                                                                                 �
 ���������������������������������������������������������������������������������������������������
*/

keydef EndEditKey
    <Escape>        EndEdit()
end

/*
 ��� EscapeKey �����������������������������������������������������������������������������������Ŀ
 �                                                                                                 �
 � Used either to swap the main menu from left to right side and back or to refresh i.e. to        �
 � recaluculate the picklist.                                                                      �
 �                                                                                                 �
 � Called by:   Used in PickListStartup(), ShowCommentMenu().                                      �
 �                                                                                                 �
 ���������������������������������������������������������������������������������������������������
*/

keydef EscapeKey
    <_MENU_KEY>     Escape()
end

// �������������������������������������������������������������������������������������������������
// SEARCHING
// �������������������������������������������������������������������������������������������������

/*
 ��� FindLine ������������������������������������������������������������������������������������Ŀ
 �                                                                                                 �
 � Finds the begin or end of a given environment relative to the current position.                 �
 �                                                                                                 �
 � Called by:   FindLine(), CurrEnv(), FindProc(), GotoSubComment(), GotoComment(), GotoNext(),    �
 �              MakePickList(), MoveOut(), HeadlineComment(), DeleteComment().                     �
 �                                                                                                 �
 � Enter with:  Environment type and position to be searched:                                      �
 �                  -_INPROC           :  Begin of procedure                                       �
 �                   _INPROC           :  End of procedure                                         �
 �                  -_INCOMM           :  Begin of comment                                         �
 �                   _INCOMM           :  End of comment                                           �
 �                  -_INLINE, _INLINE  :  Begin of header comment                                  �
 �                                                                                                 �
 �              Direction of search relative to current position:                                  �
 �                  _LEFT_   :  Backward including current line                                    �
 �                  _RIGHT_  :  Forward  including current line                                    �
 �                  _UP_     :  Backward excluding current line                                    �
 �                  _DOWN_   :  Forward  excluding current line                                    �
 �                                                                                                 �
 � Returns:     Begin or end line number of found environment or current line number if nothing    �
 �              was found.                                                                         �
 �                                                                                                 �
 � Notes:       The current position is NOT changed.                                               �
 �                                                                                                 �
 ���������������������������������������������������������������������������������������������������
*/

integer proc FindLine(integer type, integer dir)
    integer ret = FALSE, flag = (dir == _UP_ or dir == _LEFT_)
    string  fnd[_MSL] = "", opt[5] = iif(flag, "bix", "ix")
    PushPosition()
    case type
        when -_INPROC
            fnd = STR_PROC_ALLG
        when _INPROC
            fnd = "^ @end |$"
        when -_INLINE, _INLINE
            if lFind("^ @//[ \x00][��*-]", "cgx")
                iif(flag, Down(), Up())
            endif
            fnd = "^ @//\x00[~��*-]"
        when -_INCOMM
            fnd = "^ @/\*"
        when _INCOMM
            fnd = "\*/ @$"
    endcase
    case dir
        when _UP_, _RIGHT_
            BegLine()
        when _LEFT_, _DOWN_
            EndLine()
    endcase
    if lFind(fnd, opt)
        case Abs(type)
            when _INPROC
                repeat
                until (GetText(PosFirstNonWhite(), 2) <> "//" and
                      FindLine(-_INCOMM, _LEFT_) <= FindLine(_INCOMM, _UP_))
                      or not lFind(fnd, opt + "+")
            when _INCOMM
                while lFind("/\*.#\*/", "cgx")
                    if not lFind(fnd, opt + "+")
                        PopPosition()
                        return(FALSE)
                    endif
                endwhile
        endcase
        ret = CurrLine()
    endif
    PopPosition()
    return(ret)
end

/*
 ��� CurrEnv �������������������������������������������������������������������������������������Ŀ
 �                                                                                                 �
 � Determines the type of the current environment i.e., whether the current position lies in a     �
 � procedure a comment or elsewhere.                                                               �
 �                                                                                                 �
 � Called by:   GotoLastProc(), GotoNext(), MoveOut(), FormatEmptyLines(), HeadlineComment(),      �
 �              FindCalls(), CommentProc(), DeleteComment(), UpdateComment().                      �
 �                                                                                                 �
 � Enter with:  Nothing.                                                                           �
 �                                                                                                 �
 � Returns:     Type of current environment:                                                       �
 �              _INPROC  :  When inside a procedure, menu, keydef, ...                             �
 �              _INCOMM  :  When inside a block comment.                                           �
 �              _INLINE  :  When on a header comment line.                                         �
 �              FALSE    :  Otherwise.                                                             �
 �                                                                                                 �
 ���������������������������������������������������������������������������������������������������
*/

integer proc CurrEnv()
    integer n
    if FindLine(-_INCOMM, _LEFT_) > FindLine(_INCOMM, _UP_)
        return(_INCOMM)
    elseif FindLine(-_INPROC, _LEFT_) > FindLine(_INPROC, _UP_)
        return(_INPROC)
    else
        n = mMin(FindLine(_INLINE, _RIGHT_), FindLine(_INLINE,  _LEFT_))
        if n and Abs(n - CurrLine()) < 2
            return(_INLINE)
        endif
    endif
    return(FALSE)
end

/*
 ��� FindProc ������������������������������������������������������������������������������������Ŀ
 �                                                                                                 �
 � Searches the beginning of a proc, menu, key-, help- or datadef. Makes sure that this position   �
 � is not inside a block comment.                                                                  �
 �                                                                                                 �
 � Called by:   QueryProc(), MakePickList(), FindCalls().                                          �
 �                                                                                                 �
 � Enter with:  Find option string.                                                                �
 �                                                                                                 �
 � Returns:     TRUE if something was found, FALSE otherwise.                                      �
 �                                                                                                 �
 ���������������������������������������������������������������������������������������������������
*/

integer proc FindProc(string opt)
    PushPosition()
    if lFind(STR_PROC_ALLG, opt + "ix")
        repeat
            if FindLine(-_INCOMM, _LEFT_) <= FindLine(_INCOMM, _LEFT_)
                KillPosition()
                lFind(STR_PROC_ALLG, "cgix")
                return(TRUE)
            endif
        until not lFind(STR_PROC_ALLG, iif(Pos("b", opt), "+bix", "+ix"))
    endif
    PopPosition()
    return(FALSE)
end

/*
 ��� GotoLastProc ��������������������������������������������������������������������������������Ŀ
 �                                                                                                 �
 � Returns to the first line of the currently evaluated proc, menu key-, help- or datadef. Ensures �
 � that the new location is not inside a block comment.                                            �
 �                                                                                                 �
 � Called by:   GotoComment(), PositionProc(), GotoNext(), NewComment(), ReframeComment().         �
 �                                                                                                 �
 � Enter with:  Nothing.                                                                           �
 �                                                                                                 �
 � Returns:     TRUE if position was found, FALSE otherwise.                                       �
 �                                                                                                 �
 � Notes:       This routine returns FALSE if the currently evaluated item is a comment.           �
 �                                                                                                 �
 ���������������������������������������������������������������������������������������������������
*/

integer proc GotoLastProc()
    if IN_PROC and lFind(STR_PROC_LAST, "^g")
        while CurrEnv() == _INCOMM and lFind(STR_PROC_LAST, "^+")
        endwhile
        return(TRUE)
    endif
    return(FALSE)
end

/*
 ��� ColonTrim �����������������������������������������������������������������������������������Ŀ
 �                                                                                                 �
 � Removes white space and if present a trailing colon from a string.                              �
 �                                                                                                 �
 � Called by:   Target().                                                                          �
 �                                                                                                 �
 � Enter with:  Comment entry, keyword type (find or replacement).                                 �
 �                                                                                                 �
 � Returns:     Trimmed string.                                                                    �
 �                                                                                                 �
 ���������������������������������������������������������������������������������������������������
*/

string proc ColonTrim(integer type, integer entry)
    string  t[_MSL] = Trim(GetString(type, entry))
    integer l = Length(t)
    return(iif(t[l] == ":", Trim(t[1 : l - 1]), t))
end

/*
 ��� Swap ����������������������������������������������������������������������������������������Ŀ
 �                                                                                                 �
 � Exchanges the contents of two string variables.                                                 �
 �                                                                                                 �
 � Called by:   Target().                                                                          �
 �                                                                                                 �
 � Enter with:  Two string variables.                                                              �
 �                                                                                                 �
 � Returns:     Nothing.                                                                           �
 �                                                                                                 �
 ���������������������������������������������������������������������������������������������������
*/

proc Swap(var string t1, var string t2)
    string s[_MSL] = t1
    t1 = t2
    t2 = s
end

/*
 ��� Target ��������������������������������������������������������������������������������������Ŀ
 �                                                                                                 �
 � Generates a special find string taylored to search for procedure comment entries.               �
 �                                                                                                 �
 � Called by:   GotoSubComment().                                                                  �
 �                                                                                                 �
 � Enter with:  Comment entry.                                                                     �
 �                                                                                                 �
 � Returns:     Find string.                                                                       �
 �                                                                                                 �
 ���������������������������������������������������������������������������������������������������
*/

string proc Target(integer entry)
    string  r[8]   = "��|*\x" + Format(Query(LineDrawChar) : 2 : "0" : 16),
            t1[_MSL], t2[_MSL], t3[_MSL], t[_MSL] = " \c."
    if entry <> _CTEXT
        t1 = ColonTrim(_DEF, entry)
        t2 = ColonTrim(_FND, entry)
        t3 = ColonTrim(_REP, entry)
        if t1 < t2
            Swap(t1, t2)
        endif
        if t1 < t3
            Swap(t1, t3)
        endif
        if t2 < t3
            Swap(t2, t3)
        endif
        t  = " @{" + t1 + "}|{" + t2 + "}|{" + t3 + "}{ @:}? \c"
    endif
    return("^ @[" + r + "]" + t)
end

/*
 ��� GotoSubComment ������������������������������������������������������������������������������Ŀ
 �                                                                                                 �
 � Moves to a specified comment entry.                                                             �
 �                                                                                                 �
 � Called by:   GotoSubComment(), GotoComment().                                                   �
 �                                                                                                 �
 � Enter with:  Comment entry, start line of corresponding proc.                                   �
 �                                                                                                 �
 � Returns:     TRUE if entry was found, FALSE otherwise.                                          �
 �                                                                                                 �
 ���������������������������������������������������������������������������������������������������
*/

integer proc GotoSubComment(integer entry, integer plin)
    integer flin, fcol, clin = CurrLine(), ret = FALSE
    string  ldc[4] = "\x" + Format(Query(LineDrawChar) : 2 : "0" : 16),
            usr[15] = "|{" + ldc + ldc + ldc + "}"
    PushPosition()
    BegLine()
    case entry
        when _COPEN
            ret = lFind("/*", "cg")
        when _CNAME, _CTEXT
            ret = lFind("{�Ŀ}|{�͸}|{�ķ}|{�ͻ}|{--\+}|{\*\*\*}" + usr + " @$", "x") and
                  CurrLine() < clin + 2 and (lFind("\c @[a-zA-Z]", "cgx") or GotoColumn(TAB_NAME))
            if ret and entry == _CTEXT
                Down(2)
                ret = lFind(Target(_CTEXT), "cgx")
            endif
        when _CALLS, _CARGS, _CRETS, _CNOTE
            GotoLine(plin)
            BegLine()
            ret = lFind(Target(entry), "bix")
            if ret
                while isWhite() and CurrCol() < TAB_ELSE and Right()
                endwhile
            endif
        when _CVOID
        when _CFULL
            if GotoSubComment(_CNAME, plin)
                Down()
                if not lFind("^ @[|��*" + ldc + "]\c", "cgx")
                    fcol = 0
                    flin = CurrLine()
                    if not GotoSubComment(_CLAST, plin)
                        GotoSubComment(_CLOSE, plin)
                        while PrevChar() and isWhite()
                        endwhile
                        Down()
                    endif
                    while Up() and CurrLine() >= flin
                        fcol = mMin(fcol, PosFirstNonWhite())
                    endwhile
                    GotoColumn(fcol)
                    GotoLine(flin)
                endif
                ret = TRUE
            endif
        when _CLAST
            lFind("*/", "")
            flin = FindLine(-_INCOMM, _LEFT_)
            ret  = lFind("^ @\c{���}|{���}|{���}|{���}|{\+--}|{\*\*\*}" + usr, "bx") and
                   CurrLine() > flin
        otherwise
            ret = lFind("*/", "")
    endcase
    if ret and clin <= CurrLine() and CurrLine() < plin
        KillPosition()
    else
        PopPosition()
        ret = FALSE
    endif
    return(ret)
end

/*
 ��� GotoComment ���������������������������������������������������������������������������������Ŀ
 �                                                                                                 �
 � Moves to a block comment or to a given procedure comment entry and positions comment on screen. �
 �                                                                                                 �
 � Called by:   PositionProc(), GotoNext(), MakePickList(), InsertNoteComment(),                   �
 �              EraseEmptyNoteComment(), ReplaceComment(), PutComment(), NewComment(),             �
 �              MarkComment(), UpdateEditWindow(), EditComment(), NoteComment(), ReframeComment(), �
 �              UpdateFrame(), CompareBuffers(), UpdateProc().                                     �
 �                                                                                                 �
 � Enter with:  Comment entry.                                                                     �
 �                                                                                                 �
 � Returns:     Line number of the last line of the specified subcomment.                          �
 �                                                                                                 �
 � Notes:       If this routine is called with a negative argument only the return value is        �
 �              generated but the position remains unchanged and the display is not updated.       �
 �                                                                                                 �
 ���������������������������������������������������������������������������������������������������
*/

integer proc GotoComment(integer entry)
    integer plin, clin = FALSE, ret = FALSE
    PushPosition()
    if GotoLastProc()
        clin = FindLine(-_INCOMM, _LEFT_)
        plin = CurrLine()
        if FindLine(_INPROC, _LEFT_) > FindLine(_INCOMM, _LEFT_)
           ScrollToRow(2)
           clin = FALSE
        endif
    elseif not IN_PROC and CurrEnv() == _INCOMM
        clin = FindLine(-_INCOMM, _LEFT_)
        plin = FindLine( _INCOMM, _RIGHT_) + 1
    endif
    if clin
        GotoLine(clin)
        if Trim(GetText(1, CurrLineLen())) <> "/*"
            clin = clin - 1
        endif
        PushPosition()
        if GotoSubComment(Abs(entry), plin)
            KillPosition()
            PushPosition()
            if GotoSubComment(Abs(entry) + 1, plin) or GotoSubComment(_CLAST, plin)
            or GotoSubComment(_CLOSE, plin)
                ret = CurrLine() - 1
            endif
            PopPosition()
            PushPosition()
            ret = Max(ret, CurrLine())
        endif
        PopPosition()
        if Query(MsgLevel) and ret and entry > 0
            if (ret - clin) < Query(WindowRows)
                ScrollToRow(CurrLine() - clin + 1)
            elseif (ret - clin) < Query(WindowRows)
                ScrollToRow(Query(WindowRows) - ret + CurrLine() - 1)
            else
                ScrollToRow(4)
            endif
            UpdateDisplay()
        endif
    endif
    if ret and entry > 0
        KillPosition()
    else
        PopPosition()
    endif
    return(ret)
end

/*
 ��� QueryProc �����������������������������������������������������������������������������������Ŀ
 �                                                                                                 �
 � Queries whether the current item is a proc, menu, key- help- or datadef and whether there are   �
 � any arguments and return values specified.                                                      �
 �                                                                                                 �
 � Called by:   GotoNext(), ShowPickList().                                                        �
 �                                                                                                 �
 � Enter with:  Nothing.                                                                           �
 �                                                                                                 �
 � Returns:     Nothing.                                                                           �
 �                                                                                                 �
 ���������������������������������������������������������������������������������������������������
*/

proc QueryProc()
    string  copt[5] = "cgiwx"
    PushPosition()
    BegLine()
    if FindProc("")
        PushBlock()
        MarkFoundText(8)
        STR_PROC_NAME = GetMarkedText()
        STR_PROC_LAST = GetText(1, CurrLineLen())
        IN_PROC       = TRUE
        GotoBlockEnd()
        PopBlock()
        PROC_ARGS = (Chr(CurrChar()) == "(" and lFind("[a-z_A-Z]", "+cx"))
        PROC_RETS = lFind("^ @{integer}|{string}", copt)
        if lFind("proc", "cgiw")
            PROC_TYPE = _ISPROC
        elseif lFind("{menubar}|{menu}", copt)
            PROC_TYPE = _ISMENU
        elseif lFind("{key}|{data}|{help}def", copt)
            PROC_TYPE = _ISADEF
        else
            PROC_TYPE = FALSE
        endif
    endif
    PopPosition()
end

/*
 ��� PositionProc ��������������������������������������������������������������������������������Ŀ
 �                                                                                                 �
 � Determines whether a proc, menu, key- help- or datadef already has a procedure comment and      �
 � positions screen accordingly.                                                                   �
 �                                                                                                 �
 � Called by:   GotoNext(), ShowPickList(), CommentProc(), KeywordDefaults().                      �
 �                                                                                                 �
 � Enter with:  Nothing.                                                                           �
 �                                                                                                 �
 � Returns:     COMOLD if a procedure comment already exists, COMNEW otherwise.                    �
 �                                                                                                 �
 ���������������������������������������������������������������������������������������������������
*/

integer proc PositionProc()
    if GotoLastProc()
        if GotoComment(-_CALLS)
            GotoComment(_CNAME)
            return(_COMOLD)
        else
            ScrollToRow(2)
            return(_COMNEW)
        endif
    endif
    return(FALSE)
end

/*
 ��� GotoNext ������������������������������������������������������������������������������������Ŀ
 �                                                                                                 �
 � Moves to the next item, where item means header comment, block comment or proc, menu, key-,     �
 � help- or datadef. For the last cases procedure comments are taken into account for positioning. �
 �                                                                                                 �
 � Called by:   GotoNext(), ShowPickList(), FormatEmptyLines(), HeadlineComment(), CommentBlock(), �
 �              ReframeComment(), CommentProc(), DeleteComment(), UpdateComment(), mRead(),        �
 �              CommentMenu(), ShowCommentMenu().                                                  �
 �                                                                                                 �
 � Enter with:  Direction of movement:                                                             �
 �              _UP_    :  Move upward.                                                            �
 �              _DOWN_  :  Move downward.                                                          �
 �              _NONE_  :  Position current item.                                                  �
 �                                                                                                 �
 � Returns:     Keyword specifying the current environment (cf. CurrEnv()), or FALSE if no further �
 �              procedure or comment was found.                                                    �
 �                                                                                                 �
 ���������������������������������������������������������������������������������������������������
*/

integer proc GotoNext(integer dir)
    integer plin, llin, clin, lin, cenv, ret = not dir
    PushPosition()
    if dir and GotoLastProc()
        if dir == _UP_ and GotoComment(-_CALLS)
            GotoLine(FindLine(-_INCOMM, _UP_))
        endif
    else
        cenv = CurrEnv()
        if cenv
            GotoLine(FindLine(-cenv, _LEFT_))
        endif
    endif
    cenv    = IN_PROC
    IN_PROC = FALSE
    if dir
        plin = FindLine(-_INPROC, dir)
        llin = FindLine( _INLINE, dir)
        clin = FindLine(-_INCOMM, dir)
        if dir == _UP_
            lin = Max(plin, Max(llin, clin))
        else
            lin = mMin(plin, mMin(llin, clin))
        endif
        if lin
            ret = GotoLine(lin)
        endif
    else
        plin = FindLine(-_INPROC, _RIGHT_)
    endif
    if ret
        ret = CurrEnv()
        case ret
            when _INPROC
                QueryProc()
                PositionProc()
            when _INLINE
                ScrollToRow(2)
            when _INCOMM
                clin = GotoComment(-_CNAME)
                if clin
                    if plin and dir <> _UP_
                        PushPosition()
                        GotoLine(plin)
                        QueryProc()
                        if GotoComment(-_CNAME) == clin
                            KillPosition()
                            PositionProc()
                            ret = _INPROC
                        else
                            PopPosition()
                            IN_PROC = FALSE
                            GotoComment(_CNAME)
                        endif
                    else
                        GotoComment(_CNAME)
                    endif
                else
                    ret = GotoNext(iif(dir, dir, _DOWN_))
                endif
            otherwise
                ret = (not dir and (GotoNext(_DOWN_) or GotoNext(_UP_)))
        endcase
    endif
    if ret
        KillPosition()
    else
        PopPosition()
        IN_PROC = cenv
        Message("No further item found")
    endif
    return(ret)
end

/*
 ��� MakePickList ��������������������������������������������������������������������������������Ŀ
 �                                                                                                 �
 � Generates a pick list containing proc names and block comment markers featuring fast movement   �
 � in a source file.                                                                               �
 �                                                                                                 �
 � Called by:   ShowPickList().                                                                    �
 �                                                                                                 �
 � Enter with:  Nothing.                                                                           �
 �                                                                                                 �
 � Returns:     The buffer id of the pick list buffer.                                             �
 �                                                                                                 �
 � Notes:       If the source file contains several consecutive block comments only one marker     �
 �              line will show up in the pick list.                                                �
 �                                                                                                 �
 ���������������������������������������������������������������������������������������������������
*/

integer proc MakePickList()
    integer ml = Set(MsgLevel, _NONE_), cenv = IN_PROC, head = 0, cid = GetBufferId()
    string  lin[_MSL], last[_MSL] = STR_PROC_LAST
    if not VIEW_ID and CreateTempBuffer()
        VIEW_ID = GetBufferId()
        VIEW_W  = 22
        GotoBufferId(cid)
        PushBlock()
        PushPosition()
        if FindProc("g")
            IN_PROC = TRUE
            repeat
                lFind("{" + STR_PROC_TYPE + "}\c", "cgix")
                lin = " " + GetFoundText(1) + GetWord()
                STR_PROC_LAST = GetText(1, CurrLineLen())
                PushPosition()
                if GotoComment(_CALLS)
                    lin = " *" + lin
                else
                    lin = "  " + lin
                endif
                PushPosition()
                if lFind("^ @//\x00[~��*-]", "bx") and head < CurrLine()
                    head = CurrLine()
                    AddLine("//", VIEW_ID)
                endif
                PopPosition()
                if FindLine(_INCOMM, _UP_) > FindLine(_INPROC, _UP_)
                    AddLine("/* .... */", VIEW_ID)
                endif
                PopPosition()
                if VIEW_W < Length(lin) + 1
                    VIEW_W = Length(lin) + 1
                endif
                AddLine(lin, VIEW_ID)
            until StopAdvance("") or not FindProc("+")
        endif
        PopPosition()
        PopBlock()
        STR_PROC_LAST = last
        IN_PROC       = cenv
        UpdateDisplay(_STATUSLINE_REFRESH_ | _REFRESH_THIS_ONLY_)
        GotoBufferId(VIEW_ID)
        lReplace("//", Format("// " : 1 - VIEW_W : "�"), "gn")
    endif
    Set(MsgLevel, ml)
    return(GotoBufferId(VIEW_ID))
end

/*
 ��� PickListStartup �����������������������������������������������������������������������������Ŀ
 �                                                                                                 �
 � Provides the refresh key and window footer for the pick list.                                   �
 �                                                                                                 �
 � Called by:   Hooked to _LIST_STARTUP_ in ShowPickList().                                        �
 �                                                                                                 �
 � Enter with:  Nothing.                                                                           �
 �                                                                                                 �
 � Returns:     Nothing.                                                                           �
 �                                                                                                 �
 ���������������������������������������������������������������������������������������������������
*/

proc PickListStartup()
    Enable(EscapeKey)
    WindowFooter(" {" + KeyName(_MENU_KEY) + "}-Update List ")
end

/*
 ��� ShowPickList ��������������������������������������������������������������������������������Ŀ
 �                                                                                                 �
 � Displays the pick list and positions the cursor according to selection.                         �
 �                                                                                                 �
 � Called by:   CommentMenu().                                                                     �
 �                                                                                                 �
 � Enter with:  Nothing.                                                                           �
 �                                                                                                 �
 � Returns:     Nothing.                                                                           �
 �                                                                                                 �
 ���������������������������������������������������������������������������������������������������
*/

proc ShowPickList()
    integer flag = 0, cid = GetBufferId()
    string  word[_MSL] = ""
    Hook(_LIST_STARTUP_, PickListStartup)
    repeat
        if MakePickList()
            Set(X1, Query(ScreenCols))
            lFind(STR_PROC_NAME, "gw")
            ScrollToRow(Query(WindowRows) / 2)
            if List("Pick List", VIEW_W)
                while GetText(1, 1) == "/" and Down()
                    flag = flag + 1
                endwhile
                lFind("[ *]#[~ *]# #\c", "cgx")
                word = GetWord()
            endif
        endif
        GotoBufferId(cid)
        if Query(Key) == <_MENU_KEY>
            AbandonFile(VIEW_ID)
            VIEW_ID = 0
        endif
    until Length(word) or Query(Key) == <Escape>
    UnHook(PickListStartup)
    if Length(word)
        if lFind(STR_PROC_SPEC + word, "gix")
            while CurrEnv() <> _INPROC and lFind(STR_PROC_SPEC + word, "+ix")
            endwhile
        endif
        QueryProc()
        PositionProc()
        while flag
            GotoNext(_UP_)
            flag = flag - 1
        endwhile
    endif
end

// �������������������������������������������������������������������������������������������������
// LINE AND BLOCK COMMENTS
// �������������������������������������������������������������������������������������������������

/*
 ��� MoveOut �������������������������������������������������������������������������������������Ŀ
 �                                                                                                 �
 � Moves the cursor to the top or end of any proc or comment environment.                          �
 �                                                                                                 �
 � Called by:   HeadlineComment(), CommentBlock().                                                 �
 �                                                                                                 �
 � Enter with:  Nothing.                                                                           �
 �                                                                                                 �
 � Returns:     Nothing.                                                                           �
 �                                                                                                 �
 ���������������������������������������������������������������������������������������������������
*/

proc MoveOut()
    integer clin, dwn = (CurrLine() > LAST_LINE), cenv = CurrEnv()
    if cenv == _INLINE
        if HEAD_MODE
            clin = FindLine(_INLINE, _RIGHT_)
            if clin == LAST_LINE and Query(Key) <> <Enter>
                while CurrEnv() == _INLINE and iif(dwn, Down(), Up())
                endwhile
            else
                GotoLine(clin)
            endif
        else
            Up()
        endif
    elseif cenv
        if dwn
            GotoLine(FindLine(cenv, _RIGHT_))
            Down()
        else
            GotoLine(FindLine(-cenv, _LEFT_))
        endif
        if Up() and PosFirstNonWhite()
            Down()
        endif
    endif
    LAST_LINE = CurrLine()
    ScrollToRow(Query(WindowRows) / 2)
    FlushKeys()
end

/*
 ��� GobbleEmptyLines ����������������������������������������������������������������������������Ŀ
 �                                                                                                 �
 � Deletes all empty lines before, at and after the current position and reinserts a given number  �
 � of empty lines.                                                                                 �
 �                                                                                                 �
 � Called by:   FormatEmptyLines(), HeadlineComment(), FrameBlock(), NewComment(),                 �
 �              DeleteComment().                                                                   �
 �                                                                                                 �
 � Enter with:  Number of empty lines to be inserted.                                              �
 �                                                                                                 �
 � Returns:     Nothing.                                                                           �
 �                                                                                                 �
 ���������������������������������������������������������������������������������������������������
*/

proc GobbleEmptyLines(integer n)
    while not PosFirstNonWhite() and KillLine()
    endwhile
    PushPosition()
    while Up() and not PosFirstNonWhite() and KillLine()
    endwhile
    PopPosition()
    if n
        if CurrLine() == NumLines()
            AddLine()
        else
            InsertLine()
        endif
        DupLine(n - 1)
    endif
end

/*
 ��� FormatEmptyLines ����������������������������������������������������������������������������Ŀ
 �                                                                                                 �
 � Erases all empty lines within procs, menues, key-, help- and datadefs.                          �
 �                                                                                                 �
 � Called by:   CommentMenu().                                                                     �
 �                                                                                                 �
 � Enter with:  Nothing.                                                                           �
 �                                                                                                 �
 � Returns:     Nothing.                                                                           �
 �                                                                                                 �
 ���������������������������������������������������������������������������������������������������
*/

proc FormatEmptyLines()
    if IfYesNo("Erase empty lines")
        PushPosition()
        if lFind("^$", "gx")
            repeat
                case CurrEnv()
                    when _INPROC
                        GobbleEmptyLines(0)
                    when _INCOMM
                    otherwise
                        GobbleEmptyLines(iif(CurrLine() == 1 or CurrLine() == NumLines(), 0, 1))
                endcase
            until not lFind("^$", "+x") or StopAdvance("")
        endif
        PopPosition()
        GotoNext(_NONE_)
        UpdateDisplay()
    endif
end

/*
 ��� HeadlineComment �����������������������������������������������������������������������������Ŀ
 �                                                                                                 �
 � Provides a user inteface to generate and edit headline comments.                                �
 �                                                                                                 �
 � Called by:   CommentMenu().                                                                     �
 �                                                                                                 �
 � Enter with:  Nothing.                                                                           �
 �                                                                                                 �
 � Returns:     Nothing.                                                                           �
 �                                                                                                 �
 ���������������������������������������������������������������������������������������������������
*/

proc HeadlineComment()
    string  text[_MSL] = "", line[_MSL] = Format("//" + Chr(_HEAD_MARK) : -TAB_LAST : FrameTop(0, 1))
    Set(CursorAttr, Query(HiLiteAttr))
    UpdateDisplay(_CLINE_REFRESH_)
    HEAD_MODE = TRUE
    LAST_LINE = 0
    MoveOut()
    Hook(_AFTER_COMMAND_, MoveOut)
    if Enable(EndProcessKeys) and Process()
        if CurrEnv() == _INLINE
            GotoLine(FindLine(_INLINE, _RIGHT_))
            text = GetText(4, 255)
        else
            GobbleEmptyLines(2)
            InsertLine(line)
            AddLine(line)
            InsertLine("//" + Chr(_HEAD_MARK))
        endif
        GotoColumn(4)
        Set(CursorAttr, Query(TextAttr))
        UpdateDisplay(_CLINE_REFRESH_)
        GotoXY(WhereX(), WhereY())
        lRead(text, TAB_LAST - 3)
        if Length(Trim(text))
            DelToEol()
            InsertText(text)
        else
            Up()
            KillLine(3)
            GobbleEmptyLines(1)
        endif
    endif
    Disable(EndProcessKeys)
    UnHook(MoveOut)
    GotoNext(_NONE_)
end

/*
 ��� FrameBlock ����������������������������������������������������������������������������������Ŀ
 �                                                                                                 �
 � Formats, commentarizes and frames an existing block using the current framing parameters.       �
 �                                                                                                 �
 � Called by:   CommentBlock(), NewComment(), ReframeComment().                                    �
 �                                                                                                 �
 � Enter with:  Nothing.                                                                           �
 �                                                                                                 �
 � Returns:     Nothing.                                                                           �
 �                                                                                                 �
 ���������������������������������������������������������������������������������������������������
*/

proc FrameBlock()
    integer type, edge = 0, renl = Set(ReturnEqNextLine, OFF),
            ins = Set(Insert, ON), ai = Set(AutoIndent, _STICKY_),
            ldt = Set(LineDrawType, iif(IN_PROC, LINE_TYP1, LINE_TYP2))
    string  ws[32] = Set(WordSet, ChrSet("~ \x09"))
    GotoBlockBegin()
    repeat
        edge = mMin(edge, PosFirstNonWhite())
    until not (Down() and IsCursorInBlock())
    edge = TAB_MAIN - edge
    GotoBlockBegin()
    repeat
        ShiftText(edge)
        If PosLastNonWhite() > TAB_ENDC
            GotoColumn(TAB_ENDC)
            if not BegWord()
                GotoNextNonWhite()
            endif
            if CurrPos() <> PosFirstNonWhite()
                CReturn()
            endif
        endif
    until not (Down() and IsCursorInBlock())
    if IsCursorInBlock()
        AddLine()
    else
        InsertLine()
    endif
    type = Incl(0)
    if type
        edge = iif(Query(LineDrawType) == 7 and
                   Query(LineDrawChar) == Asc("*"), 0, 1)
        GotoColumn(TAB_LAST + edge)
        InsertText("*/")
    else
        AddLine("*/")
    endif
    if Down()
        GobbleEmptyLines(1)
    endif
    GotoBlockBegin()
    InsertLine()
    if type
        GotoColumn(TAB_FRST - edge - 1)
        InsertText("/*")
    else
        InsertLine("/*")
    endif
    if CurrLine() > 1
        GobbleEmptyLines(1)
        Down()
    endif
    if not type
        Down()
    endif
    GotoColumn(TAB_FRST)
    while CurrCol() < TAB_LAST
        LineDraw(_RIGHT_)
    endwhile
    repeat
        LineDraw(_DOWN_)
    until not IsCursorInBlock()
    while CurrCol() > TAB_FRST
        LineDraw(_LEFT_)
    endwhile
    repeat
        LineDraw(_UP_)
    until not IsCursorInBlock()
    LineDraw(_RIGHT_)
    UnMarkBlock()
    Set(ReturnEqNextLine, renl)
    Set(Insert, ins)
    Set(AutoIndent, ai)
    Set(LineDrawType, ldt)
    Set(WordSet, ws)
end

/*
 ��� CommentBlock ��������������������������������������������������������������������������������Ŀ
 �                                                                                                 �
 � Creates an empty comment frame or provides a user interface to define a line block which        �
 � afterwards is commentarized and framed.                                                         �
 �                                                                                                 �
 � Called by:   CommentMenu().                                                                     �
 �                                                                                                 �
 � Enter with:  Flag indicating which of the two working modes should be used.                     �
 �                                                                                                 �
 � Returns:     Nothing.                                                                           �
 �                                                                                                 �
 ���������������������������������������������������������������������������������������������������
*/

proc CommentBlock(integer nomark)
    if nomark
        HEAD_MODE = FALSE
        LAST_LINE = CurrLine()
        MoveOut()
        InsertLine()
        MarkLine(CurrLine(), CurrLine())
        FrameBlock()
    elseif Enable(EndProcessKeys)
        Message("Mark line block")
        if Process()
            if IsBlockInCurrFile() == _LINE_
                FrameBlock()
            else
                Message("No line block found")
            endif
        endif
        Disable(EndProcessKeys)
    endif
    GotoNext(_NONE_)
end

// �������������������������������������������������������������������������������������������������
// CREATE AND EDIT COMMENTS
// �������������������������������������������������������������������������������������������������

/*
 ��� InsertNoteComment ���������������������������������������������������������������������������Ŀ
 �                                                                                                 �
 � Creates a note comment entry in a procedure comment.                                            �
 �                                                                                                 �
 � Called by:   ReplaceComment(), NoteComment().                                                   �
 �                                                                                                 �
 � Enter with:  Nothing.                                                                           �
 �                                                                                                 �
 � Returns:     Nothing.                                                                           �
 �                                                                                                 �
 � Notes:       By default procedure comments are generated without note entry.                    �
 �                                                                                                 �
 ���������������������������������������������������������������������������������������������������
*/

proc InsertNoteComment()
    if not GotoComment(-_CNOTE) and GotoComment(_CLAST)
        Up()
        DupLine(2)
        Up()
        GotoColumn(TAB_MAIN)
        InsertText(STR_REP_NOTES, _OVERWRITE_)
    endif
end

/*
 ��� EraseEmptyNoteComment �����������������������������������������������������������������������Ŀ
 �                                                                                                 �
 � Deletes an empty note comment entry in the current procedure comment.                           �
 �                                                                                                 �
 � Called by:   NoteComment(), ReframeComment(), UpdateProc().                                     �
 �                                                                                                 �
 � Enter with:  Nothing.                                                                           �
 �                                                                                                 �
 � Returns:     Nothing.                                                                           �
 �                                                                                                 �
 ���������������������������������������������������������������������������������������������������
*/

proc EraseEmptyNoteComment()
    if GotoComment(_CNOTE)
        GotoNextNonWhite()
        if (IsFrameSide() or Lower(GetWord()) == Lower(STR_EMPTY))
        and (not Query(MsgLevel) or IfYesNo("Erase note comment"))
            KillLine(GotoComment(-_CNOTE) - CurrLine() + 1)
        endif
    endif
end

/*
 ��� ReplaceComment ������������������������������������������������������������������������������Ŀ
 �                                                                                                 �
 � Replaces a comment entry by a given string.                                                     �
 �                                                                                                 �
 � Called by:   PutComment(), NewComment(), EditComment(), ReframeComment(), UpdateEntry(),        �
 �              UpdateProc().                                                                      �
 �                                                                                                 �
 � Enter with:  Comment entry, replacement string.                                                 �
 �                                                                                                 �
 � Returns:     TRUE if successfull, FALSE otherwise.                                              �
 �                                                                                                 �
 ���������������������������������������������������������������������������������������������������
*/

integer proc ReplaceComment(integer entry, string text)
    integer cpos
    if entry == _CNOTE and not GotoComment(_CNOTE)
        InsertNoteComment()
    endif
    if GotoComment(entry)
        cpos = CurrPos()
        if entry == _CNAME
            InsertText(Format(" " + Trim(text) + " " :
            cpos - PosLastNonWhite() : GetText(cpos - 1, 1)), _OVERWRITE_)
        else
            InsertText(Format(text : cpos - PosLastNonWhite()), _OVERWRITE_)
            if IsFrameSide()
                if Up()
                    GotoPos(PosLastNonWhite())
                    Down()
                    while isWhite() and DelChar()
                    endwhile
                endif
            else
                DelChar()
            endif
            Down()
            cpos = GotoComment(-entry)
            if entry <> _CFULL
                cpos = cpos - 1
            endif
            while cpos >= CurrLine()
                KillLine()
                cpos = cpos - 1
            endwhile
        endif
        return(GotoComment(entry))
    endif
    return(FALSE)
end

/*
 ��� PutComment ����������������������������������������������������������������������������������Ŀ
 �                                                                                                 �
 � Replaces a comment entry with the contents of a buffer.                                         �
 �                                                                                                 �
 � Called by:   NewComment(), UpdateEditWindow(), EditComment(), ReframeComment(),                 �
 �              CompareBuffers(), UpdateProc().                                                    �
 �                                                                                                 �
 � Enter with:  Comment entry, replacement buffer id, flag indicating whether to keep or discard   �
 �              the replacement buffer                                                             �
 �                                                                                                 �
 � Returns:     Nothing.                                                                           �
 �                                                                                                 �
 ���������������������������������������������������������������������������������������������������
*/

proc PutComment(integer entry, integer tid, integer keep)
    integer n = 0, ml = Set(MsgLevel, _NONE_), cid = GetBufferId()
    PushPosition()
    if GotoBufferId(tid)
        PushBlock()
        if entry <> _CFULL and not POP_UP
            EndFile()
            while not PosLastNonWhite() and PrevChar()
                JoinLine()
            endwhile
            BegFile()
            while not PosLastNonWhite() and CurrLine() < NumLines()
                KillLine()
            endwhile
        endif
        BegFile()
        MarkColumn()
        repeat
            n = Max(n, CurrLineLen())
        until not Down()
        GotoPos(n)
        MarkColumn()
        n = NumLines() - 1
        GotoBufferId(cid)
        if ReplaceComment(entry, "#")
            if n > 0
                DupLine()
                GotoPos(PosFirstNonWhite() + 1)
                InsertText(Format("" : PosLastNonWhite() - CurrPos()), _OVERWRITE_)
                DupLine(n - 1)
            endif
            if GotoComment(entry)
                CopyBlock(_OVERWRITE_)
            endif
        endif
        PopBlock()
    endif
    if not keep
        AbandonFile(tid)
    endif
    PopPosition()
    Set(MsgLevel, ml)
end

/*
 ��� FindCalls �����������������������������������������������������������������������������������Ŀ
 �                                                                                                 �
 � Generates a formatted list of all procedures and menues which call the current proc, menu,      �
 � key-, help- or datadef.                                                                         �
 �                                                                                                 �
 � Called by:   NewComment(), CompareBuffers(), UpdateProc().                                      �
 �                                                                                                 �
 � Enter with:  Width of formatted proc list.                                                      �
 �                                                                                                 �
 � Returns:     Buffer id of proc list.                                                            �
 �                                                                                                 �
 ���������������������������������������������������������������������������������������������������
*/

integer proc FindCalls(integer width)
    integer rm = Set(RightMargin, width), ai = Set(AutoIndent, _STICKY_), keys = FALSE, flg = FALSE,
            cid = GetBufferId(), tid = CreateTempBuffer()
    string  txt[32] = "", pgm[32] = "", cur[_MSL] = "{^}|{[~A-Z_a-z]}\c" + STR_PROC_NAME + "[( ,)]"
    GotoBufferId(cid)
    PushPosition()
    PushBlock()
    BegFile()
    while lFind(cur, "+ix")
        if lFind(STR_PROC_TYPE, "cgix")
            BegLine()
            FindProc("")
            EndLine()
            if not lFind(cur, "+ix")
                break
            endif
        endif
        if not Quoted()
            case CurrEnv()
                when FALSE
                    txt = GetKeyText()
                    EndLine()
                    GotoBufferId(tid)
                    PushPosition()
                    EndFile()
                    if not keys
                        keys = AddLine("bound to")
                    endif
                    AddLine(txt + ",")
                    lReplace(" ", Chr(255), "cgn")
                    PopPosition()
                    GotoBufferId(cid)
                when _INPROC
                    txt = ""
                    flg = FALSE
                    PushPosition()
                    if lFind("{^}|{[~cC]}hook(\c", "cgix")
                        txt = GetWord()
                        flg = lFind("{^}|{[~A-Za-z0-9_]}unhook(\c", "cgix")
                    else
                        txt = GetKeyText()
                    endif
                    EndLine()
                    FindProc("b")
                    pgm = GetFoundText(8)
                    if Lower(Trim(GetFoundText(7))) == "keydef"
                        AddLine("bound to " + txt + " in " + pgm + ",", tid)
                    elseif flg
                        AddLine("unhooked in " + pgm + "(),", tid)
                    elseif Length(txt)
                        AddLine("hooked to " + txt + " in " + pgm + "(),", tid)
                    else
                        AddLine(pgm + "(),", tid)
                    endif
                    PopPosition()
                    lFind("^ @{end }|{end @$}", "ix")
            endcase
        endif
    endwhile
    GotoBufferId(tid)
    BegFile()
    txt = GetWord()
    if txt == ""
        InsertText("TSE.")
    elseif txt in "bound", "hooked", "unhooked"
        Upper()
    elseif PROC_TYPE == _ISADEF
        InsertLine("Used in ", tid)
    endif
    WrapPara()
    lReplace(Chr(255), " ", "gn")
    EndFile()
    EndLine()
    BackSpace()
    InsertText(".")
    GotoBufferId(cid)
    PopBlock()
    PopPosition()
    Set(RightMargin, rm)
    Set(AutoIndent, ai)
    return(tid)
end

/*
 ��� NewComment ����������������������������������������������������������������������������������Ŀ
 �                                                                                                 �
 � Creates a new procedure comment header.                                                         �
 �                                                                                                 �
 � Called by:   EditComment(), NoteComment(), ReframeComment(), CommentProc().                     �
 �                                                                                                 �
 � Enter with:  Flag indicating whether to run in quiet mode or not.                               �
 �                                                                                                 �
 � Returns:     YNTRUE, YNEXIT or FALSE according to user interaction.                             �
 �                                                                                                 �
 ���������������������������������������������������������������������������������������������������
*/

integer proc NewComment(integer quiet)
    integer ml = Query(MsgLevel)
    case YesNoExit(iif(quiet, -_DOAUTO, DO_NEW), "Insert comment")
        when _YNTRUE, _YNYES
            if GotoLastProc()
                Set(MsgLevel, _NONE_)
                PushBlock()
                UnmarkBlock()
                GobbleEmptyLines(0)
                if Up() and not (Upper(GetText(PosFirstNonWhite(), 4)) == "DLL ")
                    Down()
                endif
                GobbleEmptyLines(1)
                MarkLine()
                AddLine()
                AddLine()
                AddLine(STR_REP_CALLED_BY)
                AddLine()
                if PROC_TYPE == _ISPROC
                    AddLine(STR_REP_ENTER_WITH)
                    AddLine()
                    AddLine(STR_REP_RETURNS)
                    AddLine()
                endif
                MarkLine()
                AddLine()
                FrameBlock()
                ReplaceComment(_CNAME, STR_PROC_NAME)
                PutComment(_CALLS, FindCalls(TAB_ENDC - TAB_ELSE + 1), FALSE)
                if PROC_TYPE == _ISPROC
                    if not PROC_ARGS
                        ReplaceComment(_CARGS, STR_NOTHING)
                    endif
                    if not PROC_RETS
                        ReplaceComment(_CRETS, STR_NOTHING)
                    endif
                endif
                PopBlock()
                Set(MsgLevel, ml)
                GotoComment(_CNAME)
                return(_YNTRUE)
            endif
        when _YNEXIT
            return(_YNEXIT)
    endcase
    return(FALSE)
end

/*
 ��� MarkComment ���������������������������������������������������������������������������������Ŀ
 �                                                                                                 �
 � Marks a given comment entry.                                                                    �
 �                                                                                                 �
 � Called by:   GetComment(), UpdateEditWindow().                                                  �
 �                                                                                                 �
 � Enter with:  Comment entry.                                                                     �
 �                                                                                                 �
 � Returns:     TRUE if the marking operation was successfull, FALSE otherwise.                    �
 �                                                                                                 �
 ���������������������������������������������������������������������������������������������������
*/

integer proc MarkComment(integer entry)
    integer fram, elin, epos = 0, ml = Set(MsgLevel, _NONE_)
    PushPosition()
    if GotoComment(_CNAME)
        fram = CurrLineLen()
        epos = fram - iif(entry == _CFULL, 1, 2)
        elin = GotoComment(-entry)
        if GotoComment(entry)
            UnMarkBlock()
            MarkColumn()
            repeat
                GotoPos(PosLastNonWhite())
                if IsFrameSide()
                    if CurrPos() < fram
                        InsertText(Format("" : fram - CurrPos()))
                    endif
                    if entry == _CFULL
                        GotoPos(epos)
                    else
                        while Left() and isWhite()
                        endwhile
                    endif
                else
                    fram = Max(fram, CurrPos() + 1)
                endif
                epos = Max(epos, CurrPos())
            until CurrLine() == elin or not Down()
            if entry <> _CFULL and CurrPos() == PosFirstNonWhite()
                Up()
            endif
            GotoPos(epos)
            MarkColumn()
        endif
    endif
    PopPosition()
    Set(MsgLevel, ml)
    return(IsBlockInCurrFile())
end

/*
 ��� GetComment ����������������������������������������������������������������������������������Ŀ
 �                                                                                                 �
 � Retrieves contents of a given comment entry into a temorary buffer.                             �
 �                                                                                                 �
 � Called by:   UpdateEditWindow(), EditComment(), ReframeComment(), CompareBuffers().             �
 �                                                                                                 �
 � Enter with:  Comment entry.                                                                     �
 �                                                                                                 �
 � Returns:     Buffer id containing retrieved comment.                                            �
 �                                                                                                 �
 ���������������������������������������������������������������������������������������������������
*/

integer proc GetComment(integer entry)
    integer tid = 0
    if POP_UP
        POP_UP = FALSE
        PopWinClose()
    endif
    POP_ENTRY = entry
    POP_CID   = GetBufferId()
    PushBlock()
    if MarkComment(entry) and CreateTempBuffer()
        BufferType(_HIDDEN_)
        tid = GetBufferId()
        CopyBlock()
        POP_LINES = NumLines()
        POP_OFF   = 0
        GotoBufferId(POP_CID)
    endif
    PopBlock()
    return(tid)
end

/*
 ��� UpdateEditWindow ����������������������������������������������������������������������������Ŀ
 �                                                                                                 �
 � Updates the video window used in edit mode after each command.                                  �
 �                                                                                                 �
 � Called by:   Hooked to _AFTER_COMMAND_ in EditComment().                                        �
 �                                                                                                 �
 � Enter with:  Nothing.                                                                           �
 �                                                                                                 �
 � Returns:     Nothing.                                                                           �
 �                                                                                                 �
 ���������������������������������������������������������������������������������������������������
*/

proc UpdateEditWindow()
    integer col, lin, pww, pwh, pwx = 1, pwy = 1, tid = GetBufferId()
    PushPosition()
    WrapAllPara(POP_RM)
    PopPosition()
    if CurrCol() > POP_RM and CurrChar() == _BEYOND_EOL_
        Left()
        if Query(Key) == <SpaceBar>
            CReturn()
        endif
    endif
    col = CurrCol()
    lin = CurrLine()
    if POP_UP and POP_LINES <> NumLines()
        Set(ShowHelpLine, ON)
        GotoBufferId(POP_CID)
        PutComment(POP_ENTRY, tid, FALSE)
        tid = GetComment(POP_ENTRY)
        GotoComment(POP_ENTRY)
    endif
    Set(ShowHelpLine, OFF)
    if not POP_UP
        if GotoBufferId(POP_CID) and MarkComment(POP_ENTRY)
            PushPosition()
            GotoBlockBegin()
            pwh    = Query(BlockEndLine) - Query(BlockBegLine) + 3
            pww    = Query(BlockEndCol)  - Query(BlockBegCol)  + 3
            POP_RM = pww - 2
            if POP_ENTRY == _CFULL
                POP_RM = POP_RM - 1
            endif
            pwx = Query(WindowX1) + CurrCol() - CurrXoffset() - 2
            pwy = Query(WindowY1) + CurrRow() - 2
            if pwx + pww > Query(WindowX1) + Query(WindowCols) - 1
                pww = Query(WindowX1) + Query(WindowCols) - pwx
            endif
            if pwy + pwh > Query(WindowY1) + Query(WindowRows) - 1
                pwh = Query(WindowY1) + Query(WindowRows) - pwy
            endif
            UnMarkBlock()
            PopPosition()
        endif
        GotoBufferId(tid)
        POP_UP = PopWinOpen(pwx, pwy, pwx + pww - 1, pwy + pwh - 1, 1, "", Query(MenuTextAttr))
    endif
    if col <= POP_OFF
        POP_OFF = col - 1
        FileChanged(TRUE)
    elseif col > POP_OFF + Query(PopWinCols) + (col > POP_RM)
        POP_OFF = col - Query(PopWinCols)
        FileChanged(TRUE)
    endif
    if lin < POP_TOP
        POP_TOP = lin
        FileChanged(TRUE)
    elseif lin > POP_TOP + Query(PopWinRows) - 1
        POP_TOP = lin - Query(PopWinRows) + 1
        FileChanged(TRUE)
    endif
    if Query(Marking)
        FileChanged(TRUE)
    endif
    if BLOCK_MEM <> isBlockInCurrFile()
        BLOCK_MEM = isBlockInCurrFile()
        FileChanged(TRUE)
    endif
    PushBlock()
    Set(Marking, OFF)
    if FileChanged(FALSE)
        BufferVideo()
        GotoLine(POP_TOP)
        GotoXOffset(POP_OFF)
        ClrScr()
        repeat
            GotoXY(1, CurrLine() - POP_TOP + 1)
            Write(GetText(POP_OFF + 1, CurrLineLen()))
            for pww = 1 to POP_RM
                GotoColumn(pww + POP_OFF)
                if isCursorInBlockMark()
                    GotoXY(pww, CurrLine() - POP_TOP + 1)
                    PutAttr(BLCK_ATTR, 1)
                endif
            endfor
        until WhereY() == Query(PopWinRows) or not Down()
        UnBufferVideo()
    endif
    GotoColumn(col)
    GotoLine(lin)
    PopBlock()
    GotoXY(CurrCol() - POP_OFF, CurrLine() - POP_TOP + 1)
end

/*
 ��� EditComment ���������������������������������������������������������������������������������Ŀ
 �                                                                                                 �
 � Provides an user interface for editing the contents of a given comment entry.                   �
 �                                                                                                 �
 � Called by:   NoteComment(), UpdateEntry(), UpdateProc(), CommentMenu().                         �
 �                                                                                                 �
 � Enter with:  Comment entry.                                                                     �
 �                                                                                                 �
 � Returns:     Nothing.                                                                           �
 �                                                                                                 �
 ���������������������������������������������������������������������������������������������������
*/

proc EditComment(integer entry)
    integer csp = Set(ChangeShellPrompt, OFF)
    string  title[_MSL]
    Set(CursorAttr, CRSR_ATTR)
    UpdateDisplay(_CLINE_REFRESH_)
    if entry <> _CNAME and not IN_PROC
        entry = _CFULL
    endif
    if (GotoComment(entry) or NewComment(FALSE) == _YNTRUE)
        if entry == _CNAME
            GotoNextNonWhite()
            title = GetWord()
            UpdateDisplay()
            GotoXY(WhereX(), WhereY())
            lRead(title, TAB_ENDC - TAB_NAME - 1)
            ReplaceComment(_CNAME, title)
        elseif GotoBufferId(GetComment(entry))
            POP_TOP = 1
            Enable(EndEditKey)
            Hook(_AFTER_COMMAND_, UpdateEditWindow)
            UpdateEditWindow()
            UpdateEditWindow()
            Process()
            if POP_UP
                POP_UP = FALSE
                PopWinClose()
            endif
            UnHook(UpdateEditWindow)
            Disable(EndEditKey)
            GotoBufferId(POP_CID)
            PutComment(entry, GetComment(entry), FALSE)
            GotoComment(_CNAME)
        endif
    endif
    Set(ChangeShellPrompt, csp)
    Set(ShowHelpLine, ON)
end

/*
 ��� NoteComment ���������������������������������������������������������������������������������Ŀ
 �                                                                                                 �
 � Provides the edit mode for note comments. As note comments are not allways present additional   �
 � checks and cases have to be taken into account.                                                 �
 �                                                                                                 �
 � Called by:   CommentMenu().                                                                     �
 �                                                                                                 �
 � Enter with:  Nothing.                                                                           �
 �                                                                                                 �
 � Returns:     Nothing.                                                                           �
 �                                                                                                 �
 ���������������������������������������������������������������������������������������������������
*/

proc NoteComment()
    if IN_PROC
        if GotoComment(_CNAME) or NewComment(FALSE) == _YNTRUE
            InsertNoteComment()
            EditComment(_CNOTE)
            EraseEmptyNoteComment()
            GotoComment(_CNAME)
        endif
    else
        EditComment(_CFULL)
    endif
end

// �������������������������������������������������������������������������������������������������
// UPDATE COMMENTS
// �������������������������������������������������������������������������������������������������

/*
 ��� ReframeComment ������������������������������������������������������������������������������Ŀ
 �                                                                                                 �
 � Reframes the current comment using the actual set of frame parameters.                          �
 �                                                                                                 �
 � Called by:   UpdateFrame(), CommentProc(), UpdateComment().                                     �
 �                                                                                                 �
 � Enter with:  Direction of advance after having commented current item.                          �
 �                                                                                                 �
 � Returns:     Keyword specifying the current environment (cf. CurrEnv()) or FALSE if user        �
 �              requested an interupt.                                                             �
 �                                                                                                 �
 ���������������������������������������������������������������������������������������������������
*/

integer proc ReframeComment(integer dir)
    integer tid, bid, lin, ml = Set(MsgLevel, _NONE_), entry = _CTEXT, cid = GetBufferId()
    string  name[_MSL] = ""
    if GotoComment(_CNAME)
        name = Trim(GetText(CurrPos(), 255))
        name = name[1 : Pos(GetText(CurrPos() - 1, 1), name) - 1]
    endif
    if GotoComment(_COPEN)
        PushBlock()
        UnMarkBlock()
        MarkLine()
        GotoComment(_CLOSE)
        MarkLine()
        if CreateTempBuffer()
            tid = GetBufferId()
            MoveBlock()
            UnMarkBlock()
            if IN_PROC
                EndFile()
                GotoBufferId(cid)
                GotoLastProc()
                AddLine(GetText(1, CurrLineLen()), tid)
                NewComment(TRUE)
                repeat
                    GotoBufferId(tid)
                    bid = GetComment(entry)
                    if GotoBufferId(bid)
                        WrapAllPara(TAB_ENDC - iif(entry == _CTEXT, TAB_MAIN, TAB_ELSE) + 1)
                        if entry <> _CALLS
                            lFind("[~ ]", "gx")
                            Upper()
                        endif
                        GotoBufferId(cid)
                        PutComment(entry, bid, FALSE)
                    endif
                    entry = entry + 1
                until entry > _CNOTE
            else
                bid = GetComment(_CFULL)
                if GotoBufferId(bid)
                    BegFile()
                    if PosFirstNonWhite()
                        InsertLine()
                    endif
                    repeat
                        if not (isWhite() or CurrChar() < 0)
                            BegFile()
                            repeat
                                BegLine()
                                InsertText(" ", _INSERT_)
                            until not Down()
                            break
                        endif
                    until not Down()
                    if PosFirstNonWhite()
                        AddLine()
                    endif
                    WrapAllPara(TAB_ENDC - TAB_MAIN + 2)
                endif
                GotoBufferId(cid)
                InsertLine()
                MarkLine()
                MarkLine()
                FrameBlock()
                PutComment(_CFULL, bid, FALSE)
            endif
            if not LINE_INCL and GotoBufferId(tid)
                lin = GotoComment(_CLAST)
                if lin > CurrLine()
                    MarkLine(CurrLine() + 1, lin)
                    GotoBufferId(cid)
                    GotoComment(_CLOSE)
                    MoveBlock()
                    UnMarkBlock()
                endif
            endif
            GotoBufferId(cid)
            AbandonFile(tid)
        endif
        GotoBufferId(cid)
        PopBlock()
        EraseEmptyNoteComment()
        if Length(name)
            ReplaceComment(_CNAME, name)
        endif
    endif
    Set(MsgLevel, ml)
    return(GotoNext(dir))
end

/*
 ��� UpdateFrame ���������������������������������������������������������������������������������Ŀ
 �                                                                                                 �
 � Updates the frame of a procedure comment if necessary. Calls for user input if respective flags �
 � are set.                                                                                        �
 �                                                                                                 �
 � Called by:   UpdateProc().                                                                      �
 �                                                                                                 �
 � Enter with:  Maximal width of "Called by" subcomment, start column and maximal length of        �
 �              keyword strings.                                                                   �
 �                                                                                                 �
 � Returns:     YNEXIT if the user interupts updating, FALSE otherwise.                            �
 �                                                                                                 �
 ���������������������������������������������������������������������������������������������������
*/

integer proc UpdateFrame(var integer width, var integer col, var integer len)
    integer frm = FALSE, ml = Set(MsgLevel, _NONE_)
    if GotoComment(_CNAME) and (GetText(TAB_FRST, 1) <> FrameTop(1, 0)
    or GetText(TAB_LAST, 1) <> FrameTop(1, 2) or CurrCol() <> TAB_NAME)
        frm = TRUE
    endif
    if GotoComment(_CTEXT)
        col = CurrCol()
        if col <> TAB_MAIN
            frm = TRUE
        endif
    endif
    if GotoComment(_CALLS)
        width = PosLastNonWhite() - CurrCol() - 1
        len   = CurrCol() - col
        if CurrCol() <> TAB_ELSE or width <> TAB_ENDC - TAB_ELSE + 1
            frm = TRUE
        endif
    endif
    if PROC_TYPE == _ISPROC and not (GotoComment(_CARGS) and GotoComment(_CRETS))
        frm = TRUE
    endif
    Set(MsgLevel, ml)
    if frm
        GotoComment(_CNAME)
        case YesNoExit(DO_BOX, "Update frame")
            when _YNTRUE, _YNYES
                width = TAB_ENDC - TAB_ELSE + 1
                len   = TAB_ELSE - TAB_MAIN + 1
                col   = TAB_MAIN
                ReframeComment(_NONE_)
            when _YNEXIT
                return(_YNEXIT)
        endcase
    endif
    return(FALSE)
end

/*
 ��� CompareBuffers ������������������������������������������������������������������������������Ŀ
 �                                                                                                 �
 � Compares the contents of two buffers in order to find out whether the "Called by" subcomment    �
 � must be updated.                                                                                �
 �                                                                                                 �
 � Called by:   UpdateProc().                                                                      �
 �                                                                                                 �
 � Enter with:  Width of formatted proc list.                                                      �
 �                                                                                                 �
 � Returns:     YNEXIT if the user interupts updating, FALSE otherwise.                            �
 �                                                                                                 �
 ���������������������������������������������������������������������������������������������������
*/

integer proc CompareBuffers(integer width)
    integer n, ret = FALSE, update = FALSE, cid = GetBufferId(), tid = GetComment(_CALLS),
            fid = FindCalls(width)
    string  lin[_MSL] = ""
    if GotoBufferId(tid)
        n = NumLines()
        BegFile()
    else
        update = TRUE
    endif
    if GotoBufferId(fid) and n == NumLines()
        BegFile()
    else
        update = TRUE
    endif
    if not update
        repeat
            GotoBufferId(tid)
            lin = RTrim(GetText(1, CurrLineLen()))
            Down()
            GotoBufferId(fid)
            if lin <> RTrim(GetText(1, CurrLineLen()))
                update = TRUE
                break
            endif
        until not Down()
    endif
    GotoBufferId(cid)
    if update
        ret = YesNoExit(DO_CAL, "Update calls")
        if ret == _YNTRUE or ret == _YNYES
            repeat
                if Query(Key) == <Escape>
                    PushKey(<Escape>)
                    break
                endif
                if update
                    PutComment(_CALLS, fid, TRUE)
                    GotoComment(_CALLS)
                    if ret == _YNTRUE
                        break
                    endif
                    Message("Updated comment")
                else
                    PutComment(_CALLS, tid, TRUE)
                    GotoComment(_CALLS)
                    Message("Original comment")
                endif
                update = not update
                mPutHelpLine("{<Tab>}-Toggle  {<Enter>}-Keep", -1)
            until GetKey() == <Enter>
            ret = FALSE
        endif
    endif
    AbandonFile(tid)
    AbandonFile(fid)
    GotoBufferId(cid)
    return(ret)
end

/*
 ��� UpdateKeyword �������������������������������������������������������������������������������Ŀ
 �                                                                                                 �
 � Updates subcomment keyword in a procedure comment.                                              �
 �                                                                                                 �
 � Called by:   UpdateProc().                                                                      �
 �                                                                                                 �
 � Enter with:  Start column, maximal length and replacement keyword.                              �
 �                                                                                                 �
 � Returns:     Nothing.                                                                           �
 �                                                                                                 �
 ���������������������������������������������������������������������������������������������������
*/

proc UpdateKeyword(integer col, integer len, string keyword)
    integer ccol = CurrCol()
    GotoColumn(col)
    UpdateDisplay()
    if Length(RTrim(keyword) + " ") <= len
        InsertText(keyword[1 : len], _OVERWRITE_)
    elseif Query(MsgLevel)
        Alarm()
        Warn("Keyword to long")
    endif
    GotoColumn(ccol)
end

/*
 ��� UpdateEntry ���������������������������������������������������������������������������������Ŀ
 �                                                                                                 �
 � Updates the "Enter with" or "Returns" subcomment of a procedure comment.                        �
 �                                                                                                 �
 � Called by:   UpdateProc().                                                                      �
 �                                                                                                 �
 � Enter with:  Three flags associated to the "Enter with" or "Returns" case.                      �
 �                                                                                                 �
 � Returns:     YNEXIT if the user interupts updating, FALSE otherwise.                            �
 �                                                                                                 �
 ���������������������������������������������������������������������������������������������������
*/

integer proc UpdateEntry(integer type, integer doit, integer entry)
    integer col, flag = FALSE
    string  ref[_MSL] = STR_NOTHING[1 : Length(STR_NOTHING) - 1]
    if Lower(GetText(CurrPos(), Length(ref))) == Lower(ref)
        flag = TRUE
    else
        PushPosition()
        GotoNextNonWhite()
        flag = IsFrameSide()
        PopPosition()
    endif
    if type
        if flag
            case YesNoExit(doit, "Insert comment")
                when _YNTRUE
                    ReplaceComment(entry, "")
                when _YNYES
                    EditComment(entry)
                when _YNEXIT
                    return(_YNEXIT)
            endcase
        endif
    else
        if flag
            InsertText(ref, _OVERWRITE_)
            col = CurrCol()
            GotoNextNonWhite()
            if IsFrameSide() or CurrCol() == col
                GotoColumn(col)
                InsertText(".", _OVERWRITE_)
            endif
        else
            case YesNoExit(doit, "Create null message")
                when _YNTRUE, _YNYES
                    ReplaceComment(entry, STR_NOTHING)
                when _YNEXIT
                    return(_YNEXIT)
            endcase
        endif
    endif
    return(FALSE)
end

/*
 ��� UpdateProc ����������������������������������������������������������������������������������Ŀ
 �                                                                                                 �
 � Updates all subcomments of a procedure comment. Calls for user input if respective flags are    �
 � set.                                                                                            �
 �                                                                                                 �
 � Called by:   CommentProc().                                                                     �
 �                                                                                                 �
 � Enter with:  Nothing.                                                                           �
 �                                                                                                 �
 � Returns:     YNTRUE or YNEXIT according to user interaction.                                    �
 �                                                                                                 �
 ���������������������������������������������������������������������������������������������������
*/

integer proc UpdateProc()
    integer width, col, len
    if UpdateFrame(width, col, len)
        return(_YNEXIT)
    endif
    if GotoComment(_CNAME)
        GotoNextNonWhite()
        if GetWord() <> STR_PROC_NAME
            case YesNoExit(DO_NAM, "Update name")
                when _YNTRUE, _YNYES
                    ReplaceComment(_CNAME, STR_PROC_NAME)
                when _YNEXIT
                    return(_YNEXIT)
            endcase
        endif
    endif
    if GotoComment(_CTEXT)
        GotoNextNonWhite()
        if IsFrameSide()
            case YesNoExit(DO_TXT, "Edit text")
                when _YNYES, _YNYES
                    EditComment(_CTEXT)
                when _YNEXIT
                    return(_YNEXIT)
            endcase
        endif
    endif
    if GotoComment(_CALLS)
        UpdateKeyword(col, len, STR_REP_CALLED_BY)
        if Query(MsgLevel)
            if CompareBuffers(width)
                return(_YNEXIT)
            endif
        elseif DO_CAL
            PutComment(_CALLS, FindCalls(width), FALSE)
        endif
    endif
    if PROC_TYPE == _ISPROC
        if GotoComment(_CARGS)
            UpdateKeyword(col, len, STR_REP_ENTER_WITH)
            if UpdateEntry(PROC_ARGS, DO_ARG, _CARGS)
                return(_YNEXIT)
            endif
        endif
        if GotoComment(_CRETS)
            UpdateKeyword(col, len, STR_REP_RETURNS)
            if UpdateEntry(PROC_RETS, DO_RET, _CRETS)
                return(_YNEXIT)
            endif
        endif
    endif
    EraseEmptyNoteComment()
    if GotoComment(_CNOTE)
        UpdateKeyword(col, len, STR_REP_NOTES)
    endif
    GotoComment(_CNAME)
    return(_YNTRUE)
end

/*
 ��� CommentProc ���������������������������������������������������������������������������������Ŀ
 �                                                                                                 �
 � Queries the current item and either updates, reframes or newly generates a block comment.       �
 �                                                                                                 �
 � Called by:   UpdateComment().                                                                   �
 �                                                                                                 �
 � Enter with:  Direction of advance after having commented current item.                          �
 �                                                                                                 �
 � Returns:     Keyword specifying the current environment (cf. CurrEnv()) or FALSE if user        �
 �              requested an interupt.                                                             �
 �                                                                                                 �
 ���������������������������������������������������������������������������������������������������
*/

integer proc CommentProc(integer dir)
    integer ret = _YNTRUE
    Set(CursorAttr, iif(IN_PROC or dir, Query(MsgAttr), Query(HiLiteAttr)))
    if IN_PROC
        case PositionProc()
            when FALSE
                return(FALSE)
            when _COMOLD
                ret = UpdateProc()
            when _COMNEW
                ret = NewComment(FALSE)
        endcase
    elseif CurrEnv() == _INCOMM
        ret = YesNoExit(DO_BOX, "Update frame")
        if ret == _YNTRUE or ret == _YNYES
            ReframeComment(_NONE_)
        endif
    endif
    if MenuKey() == <Escape>
        PushKey(<_MENU_KEY>)
    endif
    if ret == _YNEXIT
        GotoNext(_NONE_)
        ret = FALSE
    else
        ret = GotoNext(dir)
    endif
    return(ret)
end

/*
 ��� DeleteComment �������������������������������������������������������������������������������Ŀ
 �                                                                                                 �
 � Erases the current comment.                                                                     �
 �                                                                                                 �
 � Called by:   UpdateComment().                                                                   �
 �                                                                                                 �
 � Enter with:  Flag indicating whether to run in quiet mode or not.                               �
 �                                                                                                 �
 � Returns:     Keyword specifying the current environment (cf. CurrEnv()), or FALSE if no further �
 �              procedure or comment was found.                                                    �
 �                                                                                                 �
 ���������������������������������������������������������������������������������������������������
*/

integer proc DeleteComment(integer quiet)
    PushBlock()
    UnMarkBlock()
    case CurrEnv()
        when _INLINE
            MarkLine(CurrLine() - 1, CurrLine() + 1)
        when _INCOMM
            MarkLine(FindLine(-_INCOMM, _LEFT_), FindLine(_INCOMM, _RIGHT_))
    endcase
    if isBlockMarked()
        if not quiet
            UpdateDisplay()
        endif
        if quiet or IfYesNo("Delete marked comment")
            DelBlock()
            GobbleEmptyLines(1)
        endif
    endif
    UnMarkBlock()
    PopBlock()
    return(GotoNext(_DOWN_))
end

/*
 ��� UpdateComment �������������������������������������������������������������������������������Ŀ
 �                                                                                                 �
 � According to several global settings either all, all following or the current item is reframed, �
 � updated or commented.                                                                           �
 �                                                                                                 �
 � Called by:   CommentMenu().                                                                     �
 �                                                                                                 �
 � Enter with:  Flag indicating whether to reframe or to update the whole comment.                 �
 �                                                                                                 �
 � Returns:     Nothing.                                                                           �
 �                                                                                                 �
 ���������������������������������������������������������������������������������������������������
*/

proc UpdateComment(integer flag)
    integer slu = Set(StatusLineUpdating, OFF)
    string  fnd[_MSL] = "^//{[ \x00]}{[��*-]#}$", lin[_MSL] = ""
    if DO_MOD == _MODCUR
        case flag
            when _FRAME
                if Abs(CurrEnv()) == _INLINE
                    if lFind(fnd, "xb")
                        lReplace(fnd, Format("//" + GetFoundText(1) : -TAB_LAST : GetFoundText(2)), "xn1")
                        lFind(fnd, "x+")
                        lReplace(fnd, Format("//" + GetFoundText(1) : -TAB_LAST : GetFoundText(2)), "xn1")
                    endif
                    GotoNext(_NONE_)
                else
                    ReframeComment(_NONE_)
                endif
            when _UPDATE
                CommentProc(_NONE_)
            when _DELETE
                DeleteComment(FALSE)
        endcase
    else
        GotoNext(_NONE_)
        lin = GetText(1, CurrLineLen())
        Set(MsgLevel, DO_STP)
        if DO_MOD == _MODALL
            BegFile()
            GotoNext(_NONE_)
        endif
        case flag
            when _FRAME
                PushPosition()
                if lFind(fnd, "xg")
                    repeat
                        lReplace(fnd, Format("//" + GetFoundText(1) : -TAB_LAST : GetFoundText(2)), "xn1")
                    until not lFind(fnd, "x+")
                endif
                PopPosition()
                while ReframeComment(_DOWN_) and not StopAdvance("Reframe")
                endwhile
            when _UPDATE
                while CommentProc(_DOWN_) and not StopAdvance("Comment")
                endwhile
            when _DELETE
                if IfYesNo("Delete all comments")
                    while DeleteComment(TRUE) and not StopAdvance("Delete Comment")
                    endwhile
                else
                    PrevPosition()
                endif
        endcase
        Set(MsgLevel, _ALL_MESSAGES_)
        lFind(lin, "g^$")
        GotoNext(_NONE_)
    endif
    Set(StatusLineUpdating, slu)
end

// �������������������������������������������������������������������������������������������������
// CONFIGURATION
// �������������������������������������������������������������������������������������������������

/*
 ��� LineType ������������������������������������������������������������������������������������Ŀ
 �                                                                                                 �
 � Generates a key string showing the currently selected frame type for either procedure or        �
 � additional comments.                                                                            �
 �                                                                                                 �
 � Called by:   CommentMenu().                                                                     �
 �                                                                                                 �
 � Enter with:  Flag indicating type of comment.                                                   �
 �                                                                                                 �
 � Returns:     Key string.                                                                        �
 �                                                                                                 �
 ���������������������������������������������������������������������������������������������������
*/

string proc LineType(integer proc_frm)
    string  ret[21] = Chr(Query(LineDrawChar))
    ret  = "�Ŀ�͸�ķ�ͻ+-+   " + ret + ret + ret
    return(ret[3 * iif(proc_frm, LINE_TYP1, LINE_TYP2) - 2 : 3])
end

/*
 ��� mLineTypeMenu �������������������������������������������������������������������������������Ŀ
 �                                                                                                 �
 � Modified line type menu. While the editor variable LineDrawType remains unchanged the selection �
 � is stored in one of two global variables.                                                       �
 �                                                                                                 �
 � Called by:   CommentMenu().                                                                     �
 �                                                                                                 �
 � Enter with:  Flag indicating type of comment.                                                   �
 �                                                                                                 �
 � Returns:     Nothing.                                                                           �
 �                                                                                                 �
 ���������������������������������������������������������������������������������������������������
*/

proc mLineTypeMenu(integer proc_frm)
    if proc_frm
        LINE_TYP1 = Set(LineDrawType, LINE_TYP1)
        LineTypeMenu()
        if Query(LineDrawType) == 6
            Set(LineDrawType, _LINE_TYP1)
        endif
        LINE_TYP1 = Set(LineDrawType, LINE_TYP1)
    else
        LINE_TYP2 = Set(LineDrawType, LINE_TYP2)
        LineTypeMenu()
        if Query(LineDrawType) == 6
            Set(LineDrawType, _LINE_TYP2)
        endif
        LINE_TYP2 = Set(LineDrawType, LINE_TYP2)
    endif
end

/*
 ��� Show ����������������������������������������������������������������������������������������Ŀ
 �                                                                                                 �
 � Generates a formatted string indicating a subcomment keyword                                    �
 �                                                                                                 �
 � Called by:   mRead(), KeywordMenu().                                                            �
 �                                                                                                 �
 � Enter with:  Keyword type (find or replacement), comment entry.                                 �
 �                                                                                                 �
 � Returns:     Formatted keyword.                                                                 �
 �                                                                                                 �
 ���������������������������������������������������������������������������������������������������
*/

string proc Show(integer type, integer entry)
    string  text[_MSL] = GetString(type, Abs(entry))
    if Abs(entry) <> _CTEXT
        text = text[1 : Length(Trim(text)) - 1]
    endif
    return(iif(entry > 0, text, Format(text : -10)))
end

/*
 ��� mRead ���������������������������������������������������������������������������������������Ŀ
 �                                                                                                 �
 � Allows the user to change a subcomment keyword.                                                 �
 �                                                                                                 �
 � Called by:   KeywordMenu().                                                                     �
 �                                                                                                 �
 � Enter with:  Keyword type (find or replacement), comment entry.                                 �
 �                                                                                                 �
 � Returns:     Nothing.                                                                           �
 �                                                                                                 �
 ���������������������������������������������������������������������������������������������������
*/

proc mRead(integer type, integer entry)
    integer len = TAB_ELSE - TAB_MAIN
    string  text[_MSL] = Show(type, entry)
    if type == _REP
        lRead(text, len - 2)
    else
        Read(text)
    endif
    if Length(Trim(text))
        if entry == _CNULL
            text = text + "."
        elseif entry <> _CTEXT
            text = Format(text + ":" : -len)
        endif
    else
        text = GetString(_DEF, entry)
    endif
    if type == _FND
        case entry
            when _CNULL
                STR_NOTHING = text
            when _CTEXT
                STR_EMPTY = text
            when _CALLS
                STR_FND_CALLED_BY = text
            when _CARGS
                STR_FND_ENTER_WITH = text
            when _CRETS
                STR_FND_RETURNS = text
            when _CNOTE
                STR_FND_NOTES = text
        endcase
    elseif type == _REP
        case entry
            when _CALLS
                STR_REP_CALLED_BY = text
            when _CARGS
                STR_REP_ENTER_WITH = text
            when _CRETS
                STR_REP_RETURNS = text
            when _CNOTE
                STR_REP_NOTES = text
        endcase
    endif
    GotoNext(_NONE_)
end

/*
 ��� KeywordDefaults �����������������������������������������������������������������������������Ŀ
 �                                                                                                 �
 � Restores the default subcomment keywords.                                                       �
 �                                                                                                 �
 � Called by:   KeywordMenu(), WhenLoaded().                                                       �
 �                                                                                                 �
 � Enter with:  Keyword type (find or replacement).                                                �
 �                                                                                                 �
 � Returns:     Nothing.                                                                           �
 �                                                                                                 �
 ���������������������������������������������������������������������������������������������������
*/

proc KeywordDefaults(integer type)
    if type == _FND
        STR_FND_CALLED_BY  = STR_CALLED_BY_
        STR_FND_ENTER_WITH = STR_ENTER_WITH_
        STR_FND_RETURNS    = STR_RETURNS_
        STR_FND_NOTES      = STR_NOTES_
    elseif type == _REP
        STR_REP_CALLED_BY  = STR_CALLED_BY_
        STR_REP_ENTER_WITH = STR_ENTER_WITH_
        STR_REP_RETURNS    = STR_RETURNS_
        STR_REP_NOTES      = STR_NOTES_
    endif
    PositionProc()
    PushKey(<Enter>)
end

/*
 ��� SetTab ��������������������������������������������������������������������������������������Ŀ
 �                                                                                                 �
 � Allows the user to change a position parameter used in a comment frame. A check for allowed     �
 � values is performed.                                                                            �
 �                                                                                                 �
 � Called by:   GetTab().                                                                          �
 �                                                                                                 �
 � Enter with:  Lower and upper bound defining the range of allowed values for the parameter to be �
 �              changed, parameter to be changed.                                                  �
 �                                                                                                 �
 � Returns:     Nothing.                                                                           �
 �                                                                                                 �
 ���������������������������������������������������������������������������������������������������
*/

proc SetTab(integer lb, integer ub, var integer tab)
    integer n, flag = FALSE
    string  s[3] = Str(tab)
    SaveStatusLine()
    while lReadNumeric(s, 3)
        n = Val(s)
        if lb < n and n < ub
            tab = n
            break
        else
            s = Str(tab)
            flag = TRUE
            Alarm()
            Message(lb, " < Input < ", ub)
        endif
    endwhile
    if flag
        VGotoXYAbs(1, 1)
        PutNCharAttr(STR_STATUS_LINE, Query(ScreenCols))
    endif
end

/*
 ��� GetTab ��������������������������������������������������������������������������������������Ŀ
 �                                                                                                 �
 � Allows the user to change the position parameters in a comment frame.                           �
 �                                                                                                 �
 � Called by:   PositionMenu().                                                                    �
 �                                                                                                 �
 � Enter with:  Parameter to be changed.                                                           �
 �                                                                                                 �
 � Returns:     Nothing.                                                                           �
 �                                                                                                 �
 ���������������������������������������������������������������������������������������������������
*/

proc GetTab(integer tab)
    integer m
    case tab
        when _TFRST
            SetTab(0, mMin(TAB_MAIN, TAB_NAME) - 1, TAB_FRST)
        when _TLAST
            SetTab(Max(TAB_ENDC + 1, TAB_NAME + 12), maxint, TAB_LAST)
        when _TNAME
            SetTab(TAB_FRST + 1, TAB_ENDC - 12, TAB_NAME)
        when _TMAIN
            SetTab(TAB_FRST + 1, TAB_ENDC, TAB_MAIN)
        when _TELSE
            m = Max(Length(STR_REP_ENTER_WITH), Length(STR_REP_CALLED_BY))
            m = Max(Length(STR_REP_RETURNS)   , m)
            m = Max(Length(STR_REP_NOTES)     , m)
            SetTab(TAB_MAIN + m - 1, TAB_ENDC, TAB_ELSE)
        when _TENDC
            SetTab(TAB_ELSE + 1, TAB_LAST - 1, TAB_ENDC)
    endcase
end

/*
 ��� TabPositionDefaults �������������������������������������������������������������������������Ŀ
 �                                                                                                 �
 � Restores the default frame position parameters.                                                 �
 �                                                                                                 �
 � Called by:   PositionMenu(), WhenLoaded().                                                      �
 �                                                                                                 �
 � Enter with:  Nothing.                                                                           �
 �                                                                                                 �
 � Returns:     Nothing.                                                                           �
 �                                                                                                 �
 ���������������������������������������������������������������������������������������������������
*/

proc TabPositionDefaults()
    LINE_INCL = _LINE_INCL
    TAB_FRST  = _TAB_FRST
    TAB_MAIN  = _TAB_MAIN
    TAB_NAME  = _TAB_NAME
    TAB_ELSE  = _TAB_ELSE
    TAB_ENDC  = _TAB_ENDC
    TAB_LAST  = _TAB_LAST
    PushKey(<Enter>)
end

/*
 ��� OnOff ���������������������������������������������������������������������������������������Ŀ
 �                                                                                                 �
 � Returns a string indicating the logical value of a variable.                                    �
 �                                                                                                 �
 � Called by:   PositionMenu(), CommentMenu().                                                     �
 �                                                                                                 �
 � Enter with:  Variable value.                                                                    �
 �                                                                                                 �
 � Returns:     "On" if variable is TRUE, "Off" otherwise.                                         �
 �                                                                                                 �
 ���������������������������������������������������������������������������������������������������
*/

string proc OnOff(integer n)
    return(iif(n, "On", "Off"))
end

/*
 ��� mToggle �������������������������������������������������������������������������������������Ŀ
 �                                                                                                 �
 � Circularly switches a variable between the values DOASK, DOAUTO and DONOT.                      �
 �                                                                                                 �
 � Called by:   ToggleAll(), QueryMenu().                                                          �
 �                                                                                                 �
 � Enter with:  Name of the variable to be switched.                                               �
 �                                                                                                 �
 � Returns:     Nothing.                                                                           �
 �                                                                                                 �
 ���������������������������������������������������������������������������������������������������
*/

proc mToggle(var integer n)
    case n
        when _DOASK
            n = _DONOT
        when _DOAUTO
            n = _DOASK
        otherwise
            n = _DOAUTO
    endcase
end

/*
 ��� ToggleAll �����������������������������������������������������������������������������������Ŀ
 �                                                                                                 �
 � Switches the DO_ALL variable and redisplays the last menu.                                      �
 �                                                                                                 �
 � Called by:   QueryMenu().                                                                       �
 �                                                                                                 �
 � Enter with:  Nothing.                                                                           �
 �                                                                                                 �
 � Returns:     Nothing.                                                                           �
 �                                                                                                 �
 ���������������������������������������������������������������������������������������������������
*/

proc ToggleAll()
    mToggle(DO_ALL)
    PushKey(<Enter>)
end

/*
 ��� ToggleSilent ��������������������������������������������������������������������������������Ŀ
 �                                                                                                 �
 � Toggles a variable bethween TRUE and FALSE.                                                     �
 �                                                                                                 �
 � Called by:   CommentMenu().                                                                     �
 �                                                                                                 �
 � Enter with:  Nothing.                                                                           �
 �                                                                                                 �
 � Returns:     Nothing.                                                                           �
 �                                                                                                 �
 ���������������������������������������������������������������������������������������������������
*/

proc ToggleSilent()
    DO_STP = not DO_STP
end

/*
 ��� ToggleMode ����������������������������������������������������������������������������������Ŀ
 �                                                                                                 �
 � Circularly switches a variable between the values DOASK, DOAUTO and DONOT.                      �
 �                                                                                                 �
 � Called by:   CommentMenu().                                                                     �
 �                                                                                                 �
 � Enter with:  Nothing.                                                                           �
 �                                                                                                 �
 � Returns:     Nothing.                                                                           �
 �                                                                                                 �
 ���������������������������������������������������������������������������������������������������
*/

proc ToggleMode()
    case DO_MOD
        when _MODDWN
            DO_MOD = _MODCUR
        when _MODALL
            DO_MOD = _MODDWN
        otherwise
            DO_MOD = _MODALL
    endcase
end

/*
 ��� WorkMode ������������������������������������������������������������������������������������Ŀ
 �                                                                                                 �
 � Returns a status string indicating the current value of the variable DO_MOD.                    �
 �                                                                                                 �
 � Called by:   CommentMenu().                                                                     �
 �                                                                                                 �
 � Enter with:  Nothing.                                                                           �
 �                                                                                                 �
 � Returns:     "Dwn"  :  If DO_MOD = _MODDWN                                                      �
 �              "All"  :  If DO_MOD = _MODALL                                                      �
 �              "Cur"  :  If DO_MOD = _MODCUR.                                                     �
 �                                                                                                 �
 ���������������������������������������������������������������������������������������������������
*/

string proc WorkMode()
    case DO_MOD
        when _MODDWN
            return("Dwn")
        when _MODALL
            return("All")
    endcase
    return("Cur")
end

/*
 ��� Mode ����������������������������������������������������������������������������������������Ŀ
 �                                                                                                 �
 � Returns a status string indicating the current value of a variable.                             �
 �                                                                                                 �
 � Called by:   QueryMenu().                                                                       �
 �                                                                                                 �
 � Enter with:  Variable to be checked.                                                            �
 �                                                                                                 �
 � Returns:     "Ask"   :  If variable = _DOASK                                                    �
 �              "Auto"  :  If variable = _DOAUTO                                                   �
 �              "Off"   :  If variable = _DONOT.                                                   �
 �                                                                                                 �
 ���������������������������������������������������������������������������������������������������
*/

string proc Mode(integer n)
    case iif(DO_ALL, DO_ALL, n)
        when _DOASK
            return("Ask")
        when _DOAUTO
            return("Auto")
    endcase
    return("Off")
end

/*
 ��� UpdateModeDefaults ��������������������������������������������������������������������������Ŀ
 �                                                                                                 �
 � Restores the default values for the update mode.                                                �
 �                                                                                                 �
 � Called by:   QueryMenu(), WhenLoaded().                                                         �
 �                                                                                                 �
 � Enter with:  Nothing.                                                                           �
 �                                                                                                 �
 � Returns:     Nothing.                                                                           �
 �                                                                                                 �
 ���������������������������������������������������������������������������������������������������
*/

proc UpdateModeDefaults()
    DO_STP = _DO_STP
    DO_ALL = _DO_ALL
    DO_NEW = _DO_NEW
    DO_BOX = _DO_BOX
    DO_NAM = _DO_NAM
    DO_TXT = _DO_TXT
    DO_CAL = _DO_CAL
    DO_ARG = _DO_ARG
    DO_RET = _DO_RET
    PushKey(<Enter>)
end

// �������������������������������������������������������������������������������������������������
// MENUS
// �������������������������������������������������������������������������������������������������

/*
 ��� PositionMenu ��������������������������������������������������������������������������������Ŀ
 �                                                                                                 �
 � Provides an user interface for changing frame position parameters.                              �
 �                                                                                                 �
 � Called by:   CommentMenu().                                                                     �
 �                                                                                                 �
 ���������������������������������������������������������������������������������������������������
*/

menu PositionMenu()
    history
    "&Include /*...*/"       [OnOff(Incl(0)) : 3] , Incl(1)               , _MF_DONT_CLOSE_   , "Include /*...*/ on first and last comment line"
    ""                                            ,                       , _MF_DIVIDE_
    "&Left Border"           [TAB_FRST : 3]       , GetTab(_TFRST)        , _MF_DONT_CLOSE_   , "Column number of left frame border line"
    "&Right Border"          [TAB_LAST : 3]       , GetTab(_TLAST)        , _MF_DONT_CLOSE_   , "Column number of right frame border line"
    "&Procedure Name"        [TAB_NAME : 3]       , GetTab(_TNAME)        , _MF_DONT_CLOSE_   , "Start column of comment title"
    "&Main Comment Start"    [TAB_MAIN : 3]       , GetTab(_TMAIN)        , _MF_DONT_CLOSE_   , "Start column of main comment text"
    "&Other Comments Start " [TAB_ELSE : 3]       , GetTab(_TELSE)        , _MF_DONT_CLOSE_   , "Start column of other text items in comment"
    "&Comment End"           [TAB_ENDC : 3]       , GetTab(_TENDC)        , _MF_DONT_CLOSE_   , "End column of all comment texts"
    ""                                            ,                       , _MF_DIVIDE_
    "&Defaults"                                   , TabPositionDefaults() , _MF_CLOSE_BEFORE_ , "Set above values to default settings"
end

/*
 ��� KeywordMenu ���������������������������������������������������������������������������������Ŀ
 �                                                                                                 �
 � Provides an user interface for changing subcomment keywords.                                    �
 �                                                                                                 �
 � Called by:   CommentMenu().                                                                     �
 �                                                                                                 �
 ���������������������������������������������������������������������������������������������������
*/

menu KeywordMenu()
    title = "Find Keywords"
    history
    "&Calls"           [Show(_FND, -_CALLS) : 10] , mRead(_FND, _CALLS)   , _MF_DONT_CLOSE_   , '"Called by:" type header text (to be found in currend SAL source)'
    "&Arguments"       [Show(_FND, -_CARGS) : 10] , mRead(_FND, _CARGS)   , _MF_DONT_CLOSE_   , '"Enter with:" type header text (to be found in currend SAL source)'
    "&Returns"         [Show(_FND, -_CRETS) : 10] , mRead(_FND, _CRETS)   , _MF_DONT_CLOSE_   , '"Returns:" type header text (to be found in currend SAL source)'
    "&Notes"           [Show(_FND, -_CNOTE) : 10] , mRead(_FND, _CNOTE)   , _MF_DONT_CLOSE_   , '"Notes:" type header text (to be found in currend SAL source)'
    "&Defaults"                                   , KeywordDefaults(_FND) , _MF_CLOSE_BEFORE_ , "Set above values to default settings"
    "Replace Keywords"                            ,                       , _MF_DIVIDE_
    "Ca&lls"           [Show(_REP, -_CALLS) : 10] , mRead(_REP, _CALLS)   , _MF_DONT_CLOSE_   , '"Called by:" type header text (to be used in new and updated comments)'
    "Ar&guments"       [Show(_REP, -_CARGS) : 10] , mRead(_REP, _CARGS)   , _MF_DONT_CLOSE_   , '"Enter with:" type header text (to be used in new and updated comments) '
    "Re&turns"         [Show(_REP, -_CRETS) : 10] , mRead(_REP, _CRETS)   , _MF_DONT_CLOSE_   , '"Returns:" type header text (to be used in new and updated comments) '
    "Not&es"           [Show(_REP, -_CNOTE) : 10] , mRead(_REP, _CNOTE)   , _MF_DONT_CLOSE_   , '"Notes:" type header text (to be used in new and updated comments) '
    "De&faults"                                   , KeywordDefaults(_REP) , _MF_CLOSE_BEFORE_ , "Set above values to default settings"
    ""                                            ,                       , _MF_DIVIDE_
    "E&mpty Text"      [Show(_FND, -_CTEXT) : 10] , mRead(_FND, _CTEXT)   , _MF_DONT_CLOSE_   , 'If "Notes:" type comment equals this string the note comment will be removed'
    "N&ull  Text"      [Show(_FND, -_CNULL) : 10] , mRead(_FND, _CNULL)   , _MF_DONT_CLOSE_   , "Text to be inserted if procedure has no arguments or no return value"
end

/*
 ��� QueryMenu �����������������������������������������������������������������������������������Ŀ
 �                                                                                                 �
 � Provides an user interface to customize the events when to ask for user                         �
 � input.                                                                                          �
 �                                                                                                 �
 � Called by:   CommentMenu().                                                                     �
 �                                                                                                 �
 ���������������������������������������������������������������������������������������������������
*/

menu QueryMenu()
    history
    "&New Comments" [Mode(DO_NEW) : 4] , mToggle(DO_NEW)      , _MF_DONT_CLOSE_   , "AUTO: Handle automatically, ASK: Confirm creation or change, OFF: Ignore item"
    "&Frame Type"   [Mode(DO_BOX) : 4] , mToggle(DO_BOX)      , _MF_DONT_CLOSE_   , "AUTO: Handle automatically, ASK: Confirm creation or change, OFF: Ignore item"
    "&Proc Names"   [Mode(DO_NAM) : 4] , mToggle(DO_NAM)      , _MF_DONT_CLOSE_   , "AUTO: Handle automatically, ASK: Confirm creation or change, OFF: Ignore item"
    "&Texts"        [Mode(DO_TXT) : 4] , mToggle(DO_TXT)      , _MF_DONT_CLOSE_   , "AUTO: Handle automatically, ASK: Confirm creation or change, OFF: Ignore item"
    "&Calls"        [Mode(DO_CAL) : 4] , mToggle(DO_CAL)      , _MF_DONT_CLOSE_   , "AUTO: Handle automatically, ASK: Confirm creation or change, OFF: Ignore item"
    "&Arguments"    [Mode(DO_ARG) : 4] , mToggle(DO_ARG)      , _MF_DONT_CLOSE_   , "AUTO: Handle automatically, ASK: Confirm creation or change, OFF: Ignore item"
    "&Returns"      [Mode(DO_RET) : 4] , mToggle(DO_RET)      , _MF_DONT_CLOSE_   , "AUTO: Handle automatically, ASK: Confirm creation or change, OFF: Ignore item"
    ""                                 ,                      , _MF_DIVIDE_
    "&Switch All"   [Mode(DO_ALL) : 4] , ToggleAll()          , _MF_CLOSE_BEFORE_ , "Toggle above switches either simultaneously (AUTO, ASK) or individually (OFF)"
    "&Defaults"                        , UpdateModeDefaults() , _MF_CLOSE_BEFORE_ , "Set above switches to default settings"
end

/*
 ��� CommentMenu ���������������������������������������������������������������������������������Ŀ
 �                                                                                                 �
 � Main menu providing access to all functions of the comment macro.                               �
 �                                                                                                 �
 � Called by:   ShowCommentMenu().                                                                 �
 �                                                                                                 �
 ���������������������������������������������������������������������������������������������������
*/

menu CommentMenu()
    title   = "Config"
    history = 9
    Y       = 1
    "&Positions  "                         , PositionMenu()         , _MF_DONT_CLOSE_ , "Define comment borders and item positions"
    "&Keywords   "                         , KeywordMenu()          , _MF_DONT_CLOSE_ , "Define comment item keywords"
    "&Query      "                         , QueryMenu()            , _MF_DONT_CLOSE_ , "Define which items to query about"
    "&1-Style"      [LineType(1) : 3]       , mLineTypeMenu(1)       , _MF_DONT_CLOSE_ , "Define line style of procedure comments"
    "&2-Style"      [LineType(0) : 3]       , mLineTypeMenu(0)       , _MF_DONT_CLOSE_ , "Define line style of additional comments"
    "&Silent"       [OnOff(not DO_STP) : 3] , ToggleSilent()         , _MF_DONT_CLOSE_ , "Ask for missing items or not"
    "&Mode"         [WorkMode() : 3]        , ToggleMode()           ,                 , "Work on current procedure, whole file or all procedures below current position"
    "Comment"                               ,                        , _MF_DIVIDE_
    "&Update"       [WorkMode() : 3]        , UpdateComment(_UPDATE) ,                 , "Create or update procedure comment(s): Frame and items"
    "&Frame"        [WorkMode() : 3]        , UpdateComment(_FRAME)  ,                 , "Create or update procedure comment(s): Frame only"
    "&Delete"       [WorkMode() : 3]        , UpdateComment(_DELETE) ,                 , "Delete procedure comment(s)"
    "&Insert"                               , CommentBlock(TRUE)     ,                 , "Insert addidtional comment"
    "&Block"                                , CommentBlock(FALSE)    ,                 , "Define block and comment blocked text"
    "&Headline"                             , HeadlineComment()      ,                 , "Create a headline comment: One text line and two divieder lines"
    "&White Space"                          , FormatEmptyLines()     ,                 , "Remove empty lines inside and duplicate empty lines outside procedures"
    "Edit"                                  ,                        , _MF_DIVIDE_
    "&All"                                  , EditComment(_CFULL)    ,                 , "Edit all text within comment frame"
    "&Title"                                , EditComment(_CNAME)    ,                 , "Edit the comment title"
    "&Leading Text"                         , EditComment(_CTEXT)    ,                 , "Edit the main comment text"
    "&Called by"                            , EditComment(_CALLS)    ,                 , 'Edit the "Called by:" text'
    "&Enter with"                           , EditComment(_CARGS)    ,                 , 'Edit the "Enter with:" text'
    "&Returns"                              , EditComment(_CRETS)    ,                 , 'Edit the "Returns:" text'
    "&Notes"                                , NoteComment()          ,                 , "Create or edit a special note text"
    "Move"                                  ,                        , _MF_DIVIDE_
    "&+ Forward"                            , GotoNext(_DOWN_)       ,                 , "Move one procedure down"
    "&- Backward"                           , GotoNext(_UP_)         ,                 , "Move one procedure up"
    "&# Pick List"                          , ShowPickList()         ,                 , "Display a procedure picklist and move to the selected procedure"
end

/*
 ��� ShowCommentMenu �����������������������������������������������������������������������������Ŀ
 �                                                                                                 �
 � Initialization and calling of the main menu.                                                    �
 �                                                                                                 �
 � Called by:   Bound to <_MENU_KEY> in CommentMenuKey.                                            �
 �                                                                                                 �
 � Enter with:  Nothing.                                                                           �
 �                                                                                                 �
 � Returns:     Nothing.                                                                           �
 �                                                                                                 �
 ���������������������������������������������������������������������������������������������������
*/

proc ShowCommentMenu()
    integer cvm = Query(CurrVideoMode), sat = Set(StatusLineAtTop, ON), sl = Set(ShowStatusLine, ON),
            sh = Set(ShowHelpLine, ON), level = Set(MsgLevel, _ALL_MESSAGES_), dir = -1
    string  ws[32] = Set(WordSet, ChrSet("0-9A-Z_a-z"))
    Set(Break, ON)
    PushBlock()
    UnmarkBlock()
    if cvm in _25_LINES_, _28_LINES_
        Set(CurrVideoMode, _50_LINES_)
    endif
    CRSR_ATTR = Query(CursorAttr)
    GotoNext(_NONE_)
    UpdateDisplay(_STATUSLINE_REFRESH_)
    Enable(EscapeKey)
    repeat
        FlushKeys()
        Set(CursorAttr, iif(IN_PROC, Query(MsgAttr), Query(HiLiteAttr)))
        UpdateDisplay(_CLINE_REFRESH_)
        mPutHelpLine("{<Escape>}-End  {" + KeyName(_MENU_KEY) + "}-Swap", dir)
        Set(X1, iif(dir < 0, Query(ScreenCols), 1))
        CommentMenu()
        if Query(Key) == <_MENU_KEY>
            dir = -dir
        endif
    until MenuKey() == <Escape>
    Disable(EscapeKey)
    if Query(CurrVideoMode) <> cvm
        Set(CurrVideoMode, cvm)
    endif
    Set(CursorAttr, CRSR_ATTR)
    Set(StatusLineAtTop, sat)
    Set(ShowStatusLine, sl)
    Set(ShowHelpLine, sh)
    Set(MsgLevel, level)
    Set(WordSet, ws)
    PopBlock()
    UpdateDisplay(_CLINE_REFRESH_)
end

/*
 ��� CommentMenuKey ������������������������������������������������������������������������������Ŀ
 �                                                                                                 �
 � Assigns execution of the COMMENT macro to a key.                                                �
 �                                                                                                 �
 � Called by:   Used in OnChangingFiles().                                                         �
 �                                                                                                 �
 ���������������������������������������������������������������������������������������������������
*/

keydef CommentMenuKey
    <_MENU_KEY>     ShowCommentMenu()
end

// �������������������������������������������������������������������������������������������������
// TSE-CALLED MACROS
// �������������������������������������������������������������������������������������������������

/*
 ��� OnChangingFiles �����������������������������������������������������������������������������Ŀ
 �                                                                                                 �
 � Enables the menu key if the current extension is ".s" or ".ui" and otherwise disables that key. �
 �                                                                                                 �
 � Called by:   WhenLoaded().                                                                      �
 �                                                                                                 �
 � Enter with:  Nothing.                                                                           �
 �                                                                                                 �
 � Returns:     Nothing.                                                                           �
 �                                                                                                 �
 ���������������������������������������������������������������������������������������������������
*/

proc OnChangingFiles()
    Disable(CommentMenuKey)
    if Pos("|" + CurrExt() + "|", STR_EXTENSIONS_)
        Enable(CommentMenuKey)
    endif
end

/*
 ��� WhenLoaded ����������������������������������������������������������������������������������Ŀ
 �                                                                                                 �
 � One time initialization when comment macro is loaded.                                           �
 �                                                                                                 �
 � Called by:   TSE.                                                                               �
 �                                                                                                 �
 � Enter with:  Nothing.                                                                           �
 �                                                                                                 �
 � Returns:     Nothing.                                                                           �
 �                                                                                                 �
 ���������������������������������������������������������������������������������������������������
*/

proc WhenLoaded()
    STR_PROC_SPEC = "^ @{public #}?{{integer}|{string} #}?" + STR_PROC_TYPE
    STR_PROC_ALLG = STR_PROC_SPEC + "{[0-9A-Z_a-z.\\]#}"
    STR_NOTHING   = STR_NOTHING_
    STR_EMPTY     = STR_EMPTY_
    LINE_TYP1     = _LINE_TYP1
    LINE_TYP2     = _LINE_TYP2
    LINE_INCL     = _LINE_INCL
    BLCK_ATTR     = Query(BlockAttr)
    KeywordDefaults(_FND)
    KeywordDefaults(_REP)
    TabPositionDefaults()
    UpdateModeDefaults()
    FlushKeys()
    OnChangingFiles()
    Hook(_ON_CHANGING_FILES_, OnChangingFiles)
end

/*
 ��� WhenPurged ����������������������������������������������������������������������������������Ŀ
 �                                                                                                 �
 � Discards the pick list buffer when comment macro is purged.                                     �
 �                                                                                                 �
 � Called by:   TSE.                                                                               �
 �                                                                                                 �
 � Enter with:  Nothing.                                                                           �
 �                                                                                                 �
 � Returns:     Nothing.                                                                           �
 �                                                                                                 �
 ���������������������������������������������������������������������������������������������������
*/

proc WhenPurged()
    AbandonFile(VIEW_ID)
end
