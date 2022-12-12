/****************************************************************************\

    TFSFile1.S

    Communication and tree operations for file manager

    Version         v3.10/28.04.95
    Copyright       (c) 1994,95 by DiK

    History

    v3.10/28.04.95  extended version (file compare)

\****************************************************************************/

/****************************************************************************\
  ú External functions
\****************************************************************************/

binary ["tsefile.bin"]
    integer proc MkDir( string dir: cstrval )       : 0
    integer proc RmDir( string dir: cstrval )       : 4
    integer proc ShowFile( string file: cstrval )   : 25
    integer proc HideFile( string file: cstrval )   : 30
end

/****************************************************************************\
  ú Constants and variables
\****************************************************************************/

#include ["tsefile.src"]

/****************************************************************************\
  ú Constants
\****************************************************************************/

constant    EC_ERROR    = 1,            // error codes
            EC_BREAK    = 2,
            EC_STOP     = 99

constant    LM_FINDMENU = 1,            // list menus
            LM_ASOCMENU = 2,
            LM_LNCHMENU = 3

constant    FA_COPY     = 0x0001,       // file actions
            FA_MOVE     = 0x0002,
            FA_DEL      = 0x0004,
            FA_COMP     = 0x0008,
            FA_FIND     = 0x0010,
            FA_GREP     = 0x0020,
            FA_ALL      = 0x00FF,
            DA_MAKE     = 0x0100,       // directory actions
            DA_DEL      = 0x0200,
            DA_COMP     = 0x0400,
            DA_LIST     = 0x0800,
            DA_DOWN     = 0x4000,
            DA_STOP     = 0x8000,
            DA_TREE     = DA_MAKE | DA_DEL,
            TA_COUNT    = 0,                        // combined actions
            TA_COPY     = DA_MAKE | FA_COPY,
            TA_MOVE     = DA_MAKE | DA_DEL | FA_MOVE,
            TA_COMP     = DA_COMP | FA_COMP,
            TA_DEL      = DA_DEL | FA_DEL,
            TA_LIST     = DA_LIST,
            TA_FIND     = FA_FIND,
            TA_GREP     = FA_FIND | FA_GREP

constant    XF_WAIT     = 1,            // actions after program launch
            XF_CONT     = 2,            // CODE DEPENDS ON ORDER OF CONSTANTS
            XF_SILENT   = 3,
            XF_TEEOUT   = 4

/****************************************************************************\
  ú Constants strings
\****************************************************************************/

string  DescFile[]  = "descript.ion"
string  ConfFile[]  = "tsefile.cfg"
string  AppsFile[]  = "tsefile.app"
string  TreeFile[]  = "tsefile.tre"
string  TempFile[]  = "tsefile.$$$"

/****************************************************************************\
  ú Global variables
\****************************************************************************/

integer box_open                // message box open semaphore
integer stack, bfind            // buffer id's (file stack & found files)
integer btree, bapps            // dito (tree listing & associations)
integer btemp, bcomp            // dito (work space)
integer h_port                  // history id (printer output)
integer h_desc                  // dito (file descriptions)
integer h_grep                  // dito (grep expressions)
integer h_file                  // dito (file masks)
integer h_dirs                  // dito (directory names)
integer h_exec                  // dito (launching commands)
integer skip_this               // file compare semaphore (missing dirs)
integer dir_count               // directories found
integer file_count              // file found
integer file_total              // total size of found files
integer file_found              // file count during file search
integer exit_code               // global exit code
integer actions                 // work to be done while recursing tree
string  grep[40]                // grep expression
string  wild[40]                // wildcard for finding files
string  name[128]               // current directory or filename
string  path[160]               // target for copy/move operation
string  opts[64]                // option string in an association
string  xarc[32]                // extraction command in association
string  xtop[32]                // archive list filter (top of file)
string  xbot[32]                // dito (bottom of file)
string  xfnf[32]                // dito (filename extraction)

/****************************************************************************\
  ú Forward definitions
\****************************************************************************/

forward proc Recurse()
forward proc CallListMenu( integer num )

/****************************************************************************\
  ú Library calls

    þ Call              no argument call
    þ CallSrc           source only call
\****************************************************************************/

proc Call( string mac )
    ExecMacro("TF_"+mac)
    Set(Key,-1)
end

proc CallSrc( string mac, string src )
    SetGlobalStr(source,src)
    Call(mac)
end

/****************************************************************************\
  ú Input
                                                                              
    þ GetHist           comput history id from flags
    þ AskText           ask user for a text string
\****************************************************************************/

integer proc GetHist( integer flags )
    integer hist

    case flags & ~IB_NULL
        when IB_PORT    hist = h_port
        when IB_DESC    hist = h_desc
        when IB_GREP    hist = h_grep
        when IB_FILE    hist = h_file
        when IB_DIRS    hist = h_dirs
        when IB_EXEC    hist = h_exec
    endcase
    return (hist)
end

integer proc AskText( string prompt, var string text, integer flags )
    integer rc
    integer mba, mta, msa, bla

    Set(Cursor,ON)
    bla = Set(BlockAttr,CC_BLOCK)
    msa = Set(MsgAttr,CC_PROMPT)
    mta = Set(MenuTextAttr,CC_PROMPT)
    mba = Set(MenuBorderAttr,CC_PROMPT)

    PushPosition()
    BegLine()
    ScrollToRow(1)
    rc = Ask(prompt,text,GetHist(flags))
    PopPosition()

    text = Trim(text)
    if (flags & IB_NULL) == 0
        rc = rc and Length(text)
    endif

    Set(Cursor,OFF)
    Set(BlockAttr,bla)
    Set(MsgAttr,msa)
    Set(MenuTextAttr,mta)
    Set(MenuBorderAttr,mba)

    return (rc)
end

/****************************************************************************\
  ú Messages
                                                                              
    þ MsgBox            displays a message window
        ù GIN   actions     tree actions (determines title)                   
        ù GIO   box_open    count of open boxes                               
    þ DirMessage        displays the current directory name
        ù GIN   name        current dir
                dir_count   current stats
                file_count                                                    
                file_found
    þ FileMessage       displays the current file name
        ù GIN   name        current file
                dir_count   current stats
    þ CheckBreak        test, if user hit escape key

    PRECONDITION for MsgBox: Length(msg) <= 46
    The box_open semaphore is not perfect,
    at least it prevents PopWinClose, when no box is open
\****************************************************************************/

integer proc MsgBox( string msg, integer flags )
    integer rc = -1
    integer attr = CC_INFO
    string title[20] = "Current file"

    if flags & MB_OPEN
        case flags & 0xFF
            when MB_ERROR   title = "Error"     attr = CC_ERROR
            when MB_INPUT   title = "Input"     attr = CC_PROMPT
            when MB_LOAD    title = "Loading"   attr = CC_LOAD
            when MB_INFO    title = "Info"
            when MB_FILE    // NOP
            otherwise case actions
                when TA_COPY,TA_MOVE,TA_DEL,TA_COMP     // NOP
                otherwise                               title = "Scan"
            endcase
        endcase

        if PopWinOpen(16,8,65,16,1,title,attr)
            box_open = box_open + 1
        endif
    endif

    if box_open
        Set(Cursor,OFF)
        Set(Attr,attr)
        ClrScr()

        if Length(msg)
            VGotoXY((50-Length(msg))/2,4)
            PutStr(Msg)
        elseif (flags & MB_CLOSE) == 0
            VGotoXY(5,3)
            PutStr("directories:")
            VGotoXY(5,5)
            PutStr("file count:")
        endif
    endif

    if box_open and (flags & MB_PAUSE)
        rc = GetKey()
        case rc
            when <LeftBtn>      rc = <Enter>
            when <RightBtn>     rc = <Escape>
        endcase
        if flags & MB_YESNO
            case rc & 0xFF
                when Asc("y")   rc = <Enter>
                when Asc("n")   rc = <Escape>
            endcase
        endif
    endif

    if box_open and (flags & MB_CLOSE)
        PopWinClose()
        box_open = box_open - 1
    endif

    Set(Cursor,OFF)
    return (rc)
end

proc DirMessage()
    if box_open
        Set(Attr,CC_INFO)
        VGotoXY(18,3)
        Write(dir_count:6)
        VGotoXY(30,3)
        PutLine(name,12)
        VGotoXY(18,5)
        Write(file_count:6)
        if actions & TA_FIND
            VGotoXY(30,5)
            Write("found:",file_found:8)
        endif
    endif
end

proc FileMessage()
    if box_open
        Set(Attr,CC_INFO)
        VGotoXY(18,5)
        Write(file_count:6)
        VGotoXY(30,5)
        PutLine(name,12)
    endif
end

integer proc CheckBreak()
    if KeyPressed() and GetKey() == <Escape>
        if MsgBox("Cancel operation? (Y/N)",MB_INPBOX) == <Enter>
            return (TRUE)
        endif
    endif
    return (FALSE)
end

/****************************************************************************\
  ú Low level directory functions

    þ GetDir            get current directory
    þ ForAllDrives      execute operation for all drives
\****************************************************************************/

string proc GetDir()
    return (SplitPath(ExpandPath(""),_DRIVE_|_PATH_))
end

integer proc ForAllDrives()
    integer i, total
    string curr[80] = GetDir()
    string drvs[16] = GetGlobalStr(drives)

    i = 1
    total = 0
    while i <= Length(drvs)
        if ChDir(drvs[i]+":\")
            LogDrive(drvs[i])
            Message("Scanning drive: "+drvs[i])
            SetGlobalStr(source,".")
            Recurse()
            total = total + file_found
        endif
        i = i + 1
    endwhile
    ChDir(curr)
    LogDrive(curr[1])
    return (total)
end

/****************************************************************************\
  ú Low level file functions

    þ LoadDiskFile      loads a file into the current buffer
    þ CopyDiskFile      copies the specified file
    þ CompDiskFile      compare the specified file
\****************************************************************************/

integer proc LoadDiskFile( string name )
    integer rc

    PushKey(<Escape>)
    rc = InsertFile(name)
    if KeyPressed() GetKey() endif
    UnmarkBlock()
    return (rc)
end

integer proc CopyDiskFile( string oldname, string newname )
    integer id, rc = TRUE

    // prepare file copy

    id = GotoBufferId(btemp)
    BinaryMode(256)

    // copy file via tse buffer

    rc = InsertFile(oldname) and SaveAs(newname,_OVERWRITE_)

    // restore previous state of editor

    EmptyBuffer()
    BinaryMode(0)
    GotoBufferId(id)
    return (rc)
end

proc CompDiskFile( string this, string other )
    integer id, rc, lc, ls
    string line[128]
    string otherfile[128]

    // check, if second directory is missing

    if skip_this
        return ()
    endif

    // determine other filename and check for file

    id = GetBufferId()

    otherfile = other + SplitPath(this,_NAME_|_EXT_)
    if not FileExists(otherfile)
        rc = FC_MISS
        goto cleanup
    endif

    // load second file

    GotoBufferId(bcomp)
    BinaryMode(128)
    rc = InsertFile(otherfile)
    EndFile()
    lc = CurrLine()
    ls = CurrLineLen()
    BegFile()

    // load first file and check sizes

    GotoBufferId(btemp)
    BinaryMode(128)
    rc = rc and InsertFile(this)
    if not rc
        rc = FC_MISS
        goto cleanup
    endif
    EndFile()
    if lc <> CurrLine() or ls <> CurrLineLen()
        rc = FC_SIZE
        goto cleanup
    endif
    BegFile()

    // compare files 128 bytes at a time

    loop
        line = GetText(1,128)
        GotoBufferId(bcomp)
        if line <> GetText(1,128)
            break
        endif
        if not Down()
            rc = 0
            goto cleanup
        endif
        GotoBufferId(btemp)
        Down()
    endloop

    // compute position of mismatch

    lc = 1
    ls = Length(line)
    while lc <= ls and lc <= CurrLineLen() and line[lc] == Chr(CurrChar(lc))
        lc = lc + 1
    endwhile
    rc = 128 * (CurrLine()-1) + lc

    // make log of differences

cleanup:

    if rc <> 0
        case rc
            when FC_MISS    line = "missing"
            when FC_SIZE    line = "length"
            otherwise       line = Str(rc)
        endcase
        AddLine(Format(line:9,"":3,otherfile),bfind)
    endif

    // restore previous state of editor

    GotoBufferId(btemp)
    EmptyBuffer()
    BinaryMode(0)
    GotoBufferId(bcomp)
    EmptyBuffer()
    BinaryMode(0)
    GotoBufferId(id)
end

/****************************************************************************\
  ú Low level file description functions

    þ DelDescription    delete the description file
        ù GIN   name        current dir
    þ CopyDescription   copy the description file
        ù GIN   path        target dir
\****************************************************************************/

proc DelDescription()
    string old[128]

    old = GetDir() + name + "\" + DescFile
    if ShowFile(old)
        EraseDiskFile(old)
    endif
end

proc CopyDescription()
    string old[128]
    string new[128]

    new = path + DescFile
    old = GetDir() + DescFile
    if ShowFile(old)
        ShowFile(new)
        CopyDiskFile(old,new)
        HideFile(old)
        HideFile(new)
    endif
end

/****************************************************************************\
  ú File comparing functions
    þ CompKeys          additional keybindings
    þ CompHook          alter List for diff display
    þ ShowCompResult    display result of comparison
\****************************************************************************/

keydef CompKeys
    <F1>                Call("DiffListHelp")
    <CursorUp>          RollUp()
    <CursorDown>        RollDown()
end

proc CompHook()
    Enable(CompKeys)
    Set(CursorAttr,Query(MenuTextAttr))
    Unhook(CompHook)
    BreakHookChain()
end

proc ShowCompResult()
    integer id

    id = GotoBufferId(bfind)
    if NumLines() == 0
        MsgBox("All files are identical",MB_INFBOX)
    else
        BegFile()
        MarkColumn(1,12,NumLines(),92)
        Sort()
        UnmarkBlock()
        Hook(_LIST_STARTUP_,CompHook)
        List("Result of File Compare",80)
        EmptyBuffer()
    endif
    GotoBufferId(id)
end

/****************************************************************************\
  ú File browsing functions

    þ BrowseLeftBtn     augment left button
    þ FileCmpKey        additional keybindings
    þ FileExpKey        additional keybindings
    þ GrepKeys          additional keybindings
    þ BrowseKeys        additional keybindings
    þ BrowseHook        alter List for browsing
        ù GIN   actions     grep flag
    þ FileExpand        redisplay entire file
        ù GIN   path        filename
    þ FileCompress      compress file to grepped lines only
        ù GIN   grep        grep expression
    þ BrowseFile        show current file in browsing list
        ù GIN   path        filename

    name of browsed file is stored in global variable path
\****************************************************************************/

forward proc FileCompress()
forward proc FileExpand()

string  FileCmpMsg[] = "  {Enter}-Compress  {Escape}-Quit  "
string  FileExpMsg[] = "°  {Enter}-Expand  {Escape}-Quit  °"
string  FileExeMsg[] = "°°°°°°°°  {COMPRESSING}  °°°°°°°°"

proc BrowseLeftBtn( integer cmp )
    if MouseHotSpot() == _MOUSE_MARKING_
        GotoMouseCursor()
        TrackMouseCursor()
        if cmp
            FileCompress()
        else
            FileExpand()
        endif
    else
        ProcessHotSpot()
    endif
end

keydef FileCmpKey
    <Enter>             FileCompress()
    <LeftBtn>           BrowseLeftBtn(TRUE)
end

keydef FileExpKey
    <Enter>             FileExpand()
    <LeftBtn>           BrowseLeftBtn(FALSE)
end

keydef GrepKeys
    <F1>                Call("GrepHelp")
end

keydef BrowseKeys
    <F1>                Call("BrowseHelp")
    <CursorUp>          RollUp()
    <CursorDown>        RollDown()
end

proc BrowseHook()
    if actions & FA_GREP
        Enable(GrepKeys)
        Enable(FileCmpKey)
        WindowFooter(FileCmpMsg)
    else
        Set(CursorAttr,Query(MenuTextAttr))
        Enable(BrowseKeys)
    endif
    Unhook(BrowseHook)
    BreakHookChain()
end

proc FileExpand()
    integer line

    lFind("\[ *{[0-9]#}\]","cgx")               // get current line
    MarkFoundText(1)
    line = Val(GetMarkedText())

    EmptyBuffer()                               // reload file
    if LoadDiskFile(path)
        Enable(FileCmpKey)                      // switch context
        Disable(FileExpKey)
        WindowFooter(FileCmpMsg)
        GotoLine(line)                          // position highlight
        ScrollToRow(Query(ScreenRows) / 2)
    else
        MsgBox("Cannot load file",MB_ERRBOX)
        EndProcess()
    endif
end

proc FileCompress()
    integer line, curr
    string temp[80]

    Enable(FileExpKey)                          // switch context
    Disable(FileCmpKey)
    WindowFooter(FileExeMsg)

    curr = CurrLine()                           // compress file
    EndFile()
    repeat
        if lFind(grep,"cgix")                   // reformat line
            temp = Format("[",CurrLine():6,"]":-6,GetText(1,CurrLineLen()) )
            BegLine()
            DelToEol()
            InsertText(temp,_OVERWRITE_)
        else
            MarkLine()
            if lFind(grep,"bix")                // search next line
                Down()
                KillBlock()
            else
                BegFile()
                KillBlock()
                break
            endif
        endif
    until not Up()

    WindowFooter(FileExpMsg)

    repeat                                      // position highlight
        lFind("\[ *{[0-9]#}\]","cgx")
        MarkFoundText(1)
        line = Val(GetMarkedText())
        if line > curr
            break
        endif
    until not Down()
    UnmarkBlock()
    ScrollToRow(Query(ScreenRows) / 2)
end

proc BrowseFile( integer hex )
    integer id, wba, hla

    Set(ExpandTabs,ON)                              // tab expansion on

    id = GotoBufferId(btemp)                        // prepare
    if hex
        BinaryMode(16)
        DisplayMode(_DISPLAY_HEX_)
        hla = Set(HiLiteAttr,CC_INFO)
        wba = Set(CurrWinBorderAttr,CC_INFO)
    endif

    if LoadDiskFile(path)                           // load and display
        Hook(_LIST_STARTUP_,BrowseHook)
        lList(path,80,Query(ScreenRows),_ENABLE_SEARCH_|_ENABLE_HSCROLL_)
        EmptyBuffer()
    else
        MsgBox("Cannot load file",MB_ERRBOX)
    endif

    if hex                                          // clean up
        BinaryMode(0)
        DisplayMode(_DISPLAY_TEXT_)
        Set(CurrWinBorderAttr,wba)
        Set(HiLiteAttr,hla)
    endif
    GotoBufferId(id)

    Set(ExpandTabs,OFF)                             // tab expansion off
end

/****************************************************************************\
  ú File searching functions

    þ MakeWild          translate dos wildcards to regular expression
        ù GIO   wild        wild card
    þ TestWild          test current name against wildcard specification
        ù GIN   wild        wild card                                         
                name        current file name                                 
    þ FindLoad          load found file into editor
    þ FindCopy          copy file to current dir
        ù OUT   switch      reload filelist
    þ FindCopyAll       copy all file to current dir
    þ FindDelete        delete file
        ù OUT   switch      reload filelist                                   
    þ FindDelAll        delete all file
        ù OUT   switch      reload filelist
    þ FindChDir         go to directory which contains found file
        ù OUT   switch      change directory flag
                source      name of directory
    þ FindSave          save file list on disk
        ù OUT   switch      reload filelist
    þ FindLaunch        launch the current file
    þ FindKeys          additional keybindings
    þ FindHook          alter List for file display
    þ GrepFoundFiles    search found files by contents
        ù GIN   actions     grep flag
        ù GUSE  name        messages while grepping
                file_count
                file_found
                exit_code
    þ ShowFoundFiles    display found files in a scrolling list
        ù GUSE  path        filename for browsing
\****************************************************************************/

proc MakeWild()
    integer id

    id = GotoBufferId(btemp)
    AddLine(wild)
    lReplace("{[.^$+@#{}]}","\\\1","cgxn")      // escape special characters
    lReplace("*",".*","cgn")                    // replace dos wildcards
    lReplace("?",".","cgn")                     // with regular expression
    wild = "^" + GetText(1,CurrLineLen()) + "$"
    EmptyBuffer()
    GotoBufferId(id)
end

integer proc TestWild()
    integer rc, id

    id = GotoBufferId(btemp)
    AddLine(name)
    lReplace("^{[~\.]#}$","\1.","cgxn")         // add trailing dot
    rc = lFind(wild,"cgix")
    EmptyBuffer()
    GotoBufferId(id)
    return(rc)
end

proc FindLoad()
    integer id = GetBufferId()

    EditFile(GetText(1,CurrLineLen()))
    GotoBufferId(id)
end

proc FindCopy()
    string old[128]
    string new[128]

    old = GetText(1,CurrLineLen())
    new = GetDir() + SplitPath(old,_NAME_|_EXT_)
    if old <> new
        CopyDiskFile(old,new)
    endif
    SetGlobalInt(switch,FF_LIST)
end

proc FindCopyAll()
    if MsgBox("Copy all files?",MB_INPBOX) == <Enter>
        MsgBox("Copying files",MB_OPEN|MB_FILE)
        BegFile()
        repeat
            FindCopy()
        until CheckBreak() or not Down()
        MsgBox("",MB_CLOSE)
        EndProcess()
    endif
end

proc FindDelete()
    if MsgBox("Delete file?",MB_INPBOX) == <Enter>
        if EraseDiskFile(GetText(1,CurrLineLen()))
            if NumLines() > 1
                KillLine()
            else
                DelToEol()
            endif
            SetGlobalInt(switch,FF_LIST)
        endif
    endif
end

proc FindDelAll()
    if MsgBox("Delete all files?",MB_INPBOX) == <Enter>
        MsgBox("Deleting files",MB_OPEN|MB_FILE)
        BegFile()
        repeat
            EraseDiskFile(GetText(1,CurrLineLen()))
        until CheckBreak() or not Down()
        MsgBox("",MB_CLOSE)
        SetGlobalInt(switch,FF_LIST)
        EndProcess()
    endif
end

proc FindChDir()
    SetGlobalStr(source,SplitPath(GetText(1,CurrLineLen()),_DRIVE_|_PATH_))
    SetGlobalInt(switch,FF_CHDIR)
    EndProcess()
end

proc FindSave()
    string name[128] = "find.lst"

    if AskText("Enter name of list file:",name,IB_FILE)
        SaveAs(name)
        SetGlobalInt(switch,FF_LIST)
    endif
end

proc FindLaunch()
    SetGlobalStr(target,GetText(1,CurrLineLen()))
    CallSrc("ExecChain","X")
    EndProcess()
end

keydef FindKeys
    <F1>                Call("FindHelp")
    <Ctrl Enter>        FindLaunch()
    <F10>               CallListMenu(LM_FINDMENU)
end

proc FindHook()
    WindowFooter("  {Enter}-Browse  {Ctrl-Enter}-Launch  {Escape}-Quit  {F10}-Menu  ")
    Enable(FindKeys)
    Unhook(FindHook)
    BreakHookChain()
end

integer proc GrepFoundFiles()
    integer id, rc
    string fn[128]

    if (actions & FA_GREP) == 0
        return (NumLines())
    endif

    exit_code  = FALSE                          // prepare grep
    file_count = file_found
    file_found = 0
    name = "running grep"
    MsgBox("",MB_OPEN)

    EndFile()
    repeat
        fn = GetText(1,CurrLineLen())           // load file into btemp
        id = GotoBufferId(btemp)
        LoadDiskFile(fn)
        rc = lFind(grep,"gix")                  // search grep expression
        EmptyBuffer()
        GotoBufferId(id)

        if rc                                   // display search counts
            file_found = file_found + 1
        else
            KillLine()
        endif
        file_count = file_count - 1
        DirMessage()

        if CheckBreak()
            exit_code = EC_BREAK
        endif
    until not Up() or exit_code

    if exit_code == EC_STOP                     // clean up
        MsgBox("Operations not completed",MB_ERRBOX)
    endif
    MsgBox("",MB_CLOSE)
    return (NumLines())
end

proc ShowFoundFiles()
    integer id

    id = GotoBufferId(bfind)                    // search contents
    if NumLines() and GrepFoundFiles()

        MsgBox("Sorting files",MB_OPEN)         // sort findings...
        MarkLine(1,NumLines())
        Sort()
        BegFile()
        UnmarkBlock()
        MsgBox("",MB_CLOSE)

        loop                                    // and display them
            Hook(_LIST_STARTUP_,FindHook)
            if List("Result of file search",80)
                path = GetText(1,CurrLineLen())
                BrowseFile(FALSE)
            else
                break
            endif
        endloop

    else                                        // something went wrong
        MsgBox("No files found",MB_ERRBOX)
    endif

    EmptyBuffer()                       // clean up
    GotoBufferId(id)
end

/****************************************************************************\
  ú Tree functions

    þ InsertDir         add newly created directory to tree buffer
        ù SIN   drives
    þ RemoveDir         remove killed directory from tree buffer
    þ RenameDir         change the name of the root of a subtree
    þ SortTree          sort tree list
    þ TreeExpand        expand tree to a all configured drives
    þ TreeCompress      compress full tree to specified subset
    þ TreeKeys          additional keybindings
    þ TreeHook          window footer for tree displays
    þ DisplayTree       display a subdirectory tree
        ù OUT   switch      change directory flag
                source      name of directory
    þ RefreshTree       read directory trees of all drives
        ù SIN   drives
        ù OUT   switch      change directory flag
                source      name of directory
\****************************************************************************/

integer proc InsertDir( string dir )
    if Pos(dir[1],GetGlobalStr(drives))
        AddLine(dir,btree)
        return (TRUE)
    endif
    return (FALSE)
end

proc RemoveDir( string dir )
    integer id
    string xdir[96] = ExpandPath(dir)

    id = GotoBufferId(btemp)
    AddLine(xdir)
    lReplace("\","\\","cgn")
    xdir = "^" + GetText(1,CurrLineLen()) + "\\?$"
    EmptyBuffer()
    GotoBufferId(btree)
    if lFind(xdir,"gx")
        KillLine()
    endif
    GotoBufferId(id)
end

proc RenameDir( string old, string new )
    integer id

    id = GotoBufferId(btree)
    lReplace(old,new,"^gn")
    GotoBufferId(id)
end

proc SortTree()
    integer id

    MsgBox("Sorting tree",MB_OPEN)
    id = GotoBufferId(btree)
    MarkLine(1,NumLines())
    Sort()
    UnmarkBlock()
    GotoBufferId(id)
    MsgBox("",MB_CLOSE)
end

integer proc TreeExpand( integer restart )
    string dir[80]

    if restart                                  // get current dir
        EndProcess(-1)                          // re-display
        dir = GetText(1,CurrLineLen())
    else
        dir = GetDir()
    endif

    GotoBufferId(btree)                         // copy tree info
    MarkLine(1,NumLines())
    GotoBufferId(btemp)
    EmptyBuffer()
    CopyBlock()
    UnmarkBlock()

    lFind(dir,"^g")                             // go to current dir
    ScrollToRow(Query(ScreenRows) / 2)

    return (NumLines())
end

proc TreeCompress( string dir, string opt )
    string path[80]

    if Length(dir)                              // determine search string
        path = dir
    else
        path = GetText(1,CurrLineLen())
        if not AskText("Enter search string:",path,IB_FILE)
            return ()
        endif
    endif

    EndFile()                                   // compress tree
    repeat
        if not lFind(path,"cgi"+opt)
            MarkLine()
            if lFind(path,"bi"+opt)
                Down()
                KillBlock()
            else
                BegFile()
                KillBlock()
                break
            endif
        endif
    until not Up()

    if NumLines()
        EndProcess(-1)                              // re-display
    else
        MsgBox("No directories found",MB_ERRBOX)
        TreeExpand(FALSE)
    endif
end

keydef TreeKeys
    <F1>                Call("TreeHelp")
    <Alt E>             TreeExpand(TRUE)
    <Alt C>             TreeCompress("","")
end

proc TreeHook()
    WindowFooter("  {Enter}-Chdir  {Escape}-Cancel  {Alt-C}-Compress  {Alt-E}-Expand  ")
    Enable(TreeKeys)
    Unhook(TreeHook)
    BreakHookChain()
end

proc DisplayTree( string dir, string opt )
    integer id, rc

    id = GetBufferId()
    rc = TreeExpand(FALSE)                          // get tree info
    if Length(opt)                                  // pre-compress
        TreeCompress(dir,opt)
    endif
    if rc
        repeat                                      // display
            Hook(_LIST_STARTUP_,TreeHook)
            rc = List("Subdirectory tree",80)
        until rc >= 0
    else
        MsgBox("Tree not available",MB_ERRBOX)
    endif
    SetGlobalStr(source,GetText(1,CurrLineLen()))
    SetGlobalInt(switch,rc)
    EmptyBuffer()
    GotoBufferId(id)
end

proc RefreshTree()
    EmptyBuffer(btree)
    actions = TA_LIST
    ForAllDrives()
    SortTree()
    DisplayTree("","")
end

/****************************************************************************\
  ú Associtaion editing

    þ GetAssoc          retrieve association from setup file
    þ EditAssoc         alter an association
        ù GUSE  actions     wait flag
                name        extension
                path        application
                opts        option string
                x...        archive viewer strings
    þ InsertAssoc       make a new association
    þ DeleteAssoc       remove an association
    þ AssocListKeys     additional keybindings
    þ AssocListHook     alter association list
    þ DispAssocList     edit the list of associated files
\****************************************************************************/

proc GetAssoc()

    // split association string

    lFind("^\.{[~ ]#} #{[0-9]}{[~]#}?{[~]@}|$","cgx")
    MarkFoundText(1)
    name = GetMarkedText()
    MarkFoundText(2)
    actions = Asc(GetMarkedText()) - Asc("0")
    MarkFoundText(3)
    path = GetMarkedText()
    MarkFoundText(4)
    opts = GetMarkedText()

    // split archive viewer string

    if lFind("{[~]#}{[~]@}{[~]@}{[~]@}$","cgx")
        MarkFoundText(1)
        xarc = GetMarkedText()
        MarkFoundText(2)
        xtop = GetMarkedText()
        MarkFoundText(3)
        xbot = GetMarkedText()
        MarkFoundText(4)
        xfnf = GetMarkedText()
    else
        xarc = ""
        xtop = ""
        xbot = ""
        xfnf = ""
    endif
end

integer proc EditAssoc()
    integer rc

    // execute dialog

    GetAssoc()
    CallListMenu(LM_ASOCMENU)

    // concat association string

    rc = MenuKey() <> <Escape>
    if rc
        BegLine()
        KillToEol()
        path = Format(".",name:-7,Chr(Asc("0")+actions),path)
        if Length(opts)
            path = path + "" + opts
        endif
        if Length(xarc)
            InsertText(Format(path,"",xarc,"",xtop,"",xbot,"",xfnf))
        else
            InsertText(path)
        endif
    endif

    // sort list and return

    MarkColumn(1,1,NumLines(),4)
    Sort()
    UnmarkBlock()
    return (rc)
end

proc InsertAssoc()
    AddLine(".ext    1commandoptions")
    if not EditAssoc()
        if NumLines() == 1
            BegLine()
            KillToEol()
        else
            DelLine()
        endif
    endif
    EndProcess(-1)
end

proc DeleteAssoc()
    if MsgBox("Delete association?",MB_INPBOX) == <Enter>
        if NumLines() == 1
            BegLine()
            KillToEol()
        else
            KillLine()
        endif
        EndProcess(-1)
    endif
end

keydef AssocListKeys
    <F1>        Call("LaunchHelp")
    <Enter>     EditAssoc()
    <Ins>       InsertAssoc()
    <Del>       DeleteAssoc()
end

proc AssocListHook()
    WindowFooter("  {Enter}-Edit  {Ins}-New  {Del}-Remove  {Escape}-Close  ")
    Enable(AssocListKeys)
    Unhook(AssocListHook)
    BreakHookChain()
end

proc DispAssocList()
    integer id, rc

    id = GotoBufferId(bapps)
    repeat
        Hook(_LIST_STARTUP_,AssocListHook)
        rc = List("Associations",80)
    until rc >= 0
    GotoBufferId(id)
end

/****************************************************************************\
  ú Archive functions
 
    þ ArcGetFile        extract file from archive
        ù GIN   name        filename of archive
                xarc        extraction command
                xfnf        filename filter
                xmsg        message filter
    þ ArcViewFile       view an archived file
        ù GUSE  path        name of browsed file (BrowseFile)
    þ ArcExtractFile    extract marked files
    þ ArcExtractAll     extract all files
    þ ArcToggleMark     toggle tag marks
    þ ArcLeftBtn        toggle tag marks with mouse
    þ ArcListKeys       additional keybindings
    þ ArcListHook       alter List for archive display
    þ DispArchive       show the contents of an archive
        ù GIN   name        filename of archive
\****************************************************************************/

integer proc ArcGetFile( var string fname, integer flag )
    integer rc
    string fpath[128] = ""

    // determine filename

    Message(banner)
    if lFind(xfnf,"cgix")
        MarkFoundText()
        fpath = GetMarkedText()
        fname = Trim(SplitPath(fpath,_NAME_|_EXT_))
        UnmarkBlock()
    else
        fname = ""
    endif
    if Length(fname) == 0
        MsgBox("Filename is invalid",MB_ERRBOX)
        return (FALSE)
    endif

    // check for existing file

    if FileExists(fname)
        if flag
            MsgBox("Cannot browse! File exists!",MB_ERRBOX)
            return (FALSE)
        endif
        if MsgBox(fname+" exists! Extract anyway?",MB_INPBOX) == <Escape>
            return (FALSE)
        else
            EraseDiskFile(fname)
        endif
    endif

    // extract file

    fpath = xarc + " " + name + " " + fpath
    Dos(fpath,_DONT_PROMPT_)
    UpdateDisplay()

    // check result

    rc = FileExists(fname)
    if rc == 0
        MsgBox("Could not extract file "+fname,MB_ERRBOX)
    endif
    return (rc)
end

proc ArcViewFile()
    string oldpath[128]

    oldpath = path                      // store and set path
    if ArcGetFile(path,TRUE)
        BrowseFile(FALSE)
        EraseDiskFile(path)
    endif
    path = oldpath                      // restore path
end

proc ArcExtractFile()
    string fname[12] = ""

    lFind(Chr(TC_TAG),"g^")
    repeat
        ArcGetFile(fname,FALSE)
    until not lFind(Chr(TC_TAG),"^")
    CallSrc("ExecChain","L")
end

proc ArcExtractAll()
    Dos(xarc + " " + name,_DONT_PROMPT_)
    UpdateDisplay()
    CallSrc("ExecChain","L")
end

proc ArcToggleMark()
    BegLine()
    if CurrChar() <> TC_TAG
        InsertText(Chr(TC_TAG),_OVERWRITE_)
    else
        InsertText(Chr(TC_NOTAG),_OVERWRITE_)
    endif
end

proc ArcLeftBtn()
    if MouseHotSpot() == _MOUSE_MARKING_
        GotoMouseCursor()
        TrackMouseCursor()
        EndProcess(-1)
    else
        ProcessHotSpot()
    endif
end

keydef ArcListKeys
    <F1>            Call("ArcListHelp")
    <SpaceBar>      ArcToggleMark() Down()
    <Enter>         EndProcess(-1)
    <Alt E>         EndProcess(-2)
    <Alt A>         EndProcess(-3)
    <LeftBtn>       ArcLeftBtn()
end

proc ArcListHook()
    WindowFooter("  {Enter}-View  {Space}-TglMark  {Alt-E}-Ext  {Alt-A}-ExtAll  ")
    Enable(ArcListKeys)
    Unhook(ArcListHook)
    BreakHookChain()
end

proc DispArchive()
    integer id, rc

    // get archiver output

    id = GotoBufferId(bfind)
    LoadDiskFile(TempFile)
    EraseDiskFile(TempFile)

    // process archiver output

    MsgBox("Processing output",MB_OPEN|MB_INFO)
    if Length(xtop) and lFind(xtop,"gx")
        MarkLine()
        BegFile()
        KillBlock()
    endif
    if Length(xbot) and lFind(xbot,"gbx")
        MarkLine()
        EndFile()
        KillBlock()
    endif
    repeat
        ShiftText(2)
    until not Up()
    BegLine()
    MsgBox("",MB_CLOSE)

    // show result

    loop
        BegLine()
        Hook(_LIST_STARTUP_,ArcListHook)
        rc = lList("Contents of Archive",80,25,_ENABLE_SEARCH_|_ENABLE_HSCROLL_)
        case rc
            when -1     ArcViewFile()
            when -2     ArcExtractFile() break
            when -3     ArcExtractAll() break
            otherwise   break
        endcase
    endloop

    // cleanup

    EmptyBuffer()
    GotoBufferId(id)
end

/****************************************************************************\
  ú Launching files
 
    þ LaunchDlg         get parameters for launching
        ù GOUT  path        association string
        ù GUSE  actions     wait flag
                path        application
                opts        option string
    þ TeeListKeys       additional keybindings
    þ TeeListHook       alter tee'd output list
    þ DispTeeList       list of tee'd output
    þ LaunchFile        execute associated application
        ù IN    switch      force switch
                source      filename
        ù GUSE  actions     wait flag
                name        filename
                path        application
                opts        option string
                x...        archive viewer strings
\****************************************************************************/

integer proc LaunchDlg()
    actions = 4
    path = ""
    opts = ""
    PushKey(Asc("c"))
    CallListMenu(LM_LNCHMENU)
    return (MenuKey() <> <Escape>)
end

keydef TeeListKeys
    <F1>            Call("TeeOutHelp")
    <CursorUp>      RollUp()
    <CursorDown>    RollDown()
end

proc TeeListHook()
    Set(CursorAttr,Query(MenuTextAttr))
    Enable(TeeListKeys)
    Unhook(TeeListHook)
    BreakHookChain()
end

proc DispTeeList()
    integer id

    id = GotoBufferId(btemp)
    LoadDiskFile(TempFile)
    EraseDiskFile(TempFile)
    Hook(_LIST_STARTUP_,TeeListHook)
    lList("Command Output",80,25,_ENABLE_SEARCH_|_ENABLE_HSCROLL_)
    EmptyBuffer()
    GotoBufferId(id)
end

integer proc LaunchFile()
    integer id, rc
    string fn[128] = GetGlobalStr(source)

    // first search association...

    id = GotoBufferId(bapps)
    MarkColumn(1,1,NumLines(),5)
    rc = lFind(SplitPath(fn,_EXT_)+" ","^lg")
    if rc
        GetAssoc()
    endif
    UnmarkBlock()
    GotoBufferId(id)

    // ... then ask for command (to override search)

    if GetGlobalInt(switch)
        rc = LaunchDlg() and Length(path)
    endif

    // nothing found

    if not rc
        return (TRUE)
    endif

    // build command

    if Length(xarc)
        actions = XF_TEEOUT
    endif
    case actions
        when XF_WAIT      actions = _DEFAULT_
        when XF_CONT      actions = _DONT_PROMPT_
        when XF_SILENT    actions = _DONT_CLEAR_
        when XF_TEEOUT    actions = _TEE_OUTPUT_ | _DONT_PROMPT_
    endcase
    path = path + " " + fn
    if Length(opts)
        path = path + " " + opts
    endif
    if actions & _TEE_OUTPUT_
        path = path + ">" + TempFile
    endif

    // execute command

    Dos(path,actions)
    UpdateDisplay(_ALL_WINDOWS_REFRESH_)

    // show archiver output

    if Length(xarc)
        name = fn
        DispArchive()
    elseif (actions & _TEE_OUTPUT_) and FileExists(TempFile)
        DispTeeList()
    endif

    // return

    return (FALSE)
end

/****************************************************************************\
  ú List Menus

    þ SetWait           set waiting action
    þ WaitMenu          actions after command has been executed
    þ ArcMenu           dialog to setup archive viewer
    þ LaunchMenu        dialog to launch a file in an application
    þ AssocMenu         dialog to edit associations
        ù GIO   actions     wait flag
                name        extension
                path        application
                opts        option string
    þ FindListMenu      menu to choose file actions
    þ CallListMenu      alter menu for pick lists
\****************************************************************************/

proc SetWait()
    actions = MenuOption()
end

menu WaitMenu()
    history = actions
    command = SetWait()

    "&Pause",,          CloseBefore
    "&Continue",,       CloseBefore
    "&Silent",,         CloseBefore
    "&Tee Output",,     CloseBefore
end

menu ArcMenu()
    "&Extract Command  "
        [xarc:16],  AskText("Extract:",xarc,IB_EXEC),   DontClose
    "",,    Divide
    "Skip &Until"
        [xtop:16],  AskText("Filter:",xtop,IB_EXEC),    DontClose
    "Skip &From"
        [xbot:16],  AskText("Filter:",xbot,IB_EXEC),    DontClose
    "&Name Filter"
        [xfnf:16],  AskText("Filter:",xfnf,IB_EXEC),    DontClose
end

menu LaunchMenu()
    x = 2
    y = 2

    "&Command"      [path:16],  AskText("Command:",path,IB_EXEC),   DontClose
    "&Options"      [opts:16],  AskText("Options:",opts,IB_EXEC),   DontClose
    "",,    Divide
    "A&fter Call"   [MenuStr(WaitMenu,actions):12],     WaitMenu(), DontClose
    "",,    Divide
    "Accept and E&xecute"
end

menu AssocMenu()
    x = 2
    y = 2

    "&Extension"    [name:3],   AskText("Extension:",name,IB_EXEC), DontClose
    "",,    Divide
    "&Command  "    [path:16],  AskText("Command:",path,IB_EXEC),   DontClose
    "&Options"      [opts:16],  AskText("Options:",opts,IB_EXEC),   DontClose
    "&Archive                    ",                ArcMenu(),      DontClose
    "",,    Divide
    "A&fter Call"   [MenuStr(WaitMenu,actions):12],     WaitMenu(), DontClose
    "",,    Divide
    "Accept and C&lose"
end

menu FindListMenu()
    x = 2
    y = 2

    "&Load File",       FindLoad()
    "",,    Divide
    "&Copy",            FindCopy()
    "Copy &All",        FindCopyAll()
    "",,    Divide
    "&Delete",          FindDelete()
    "Dele&te All",      FindDelAll()
    "",,    Divide
    "C&hange Dir",      FindChDir()
    "",,    Divide
    "Sa&ve List",       FindSave()
end

proc CallListMenu( integer num )
    integer mta, mtla, msa, msla, mba

    if NumLines()
        mta  = Set(MenuTextAttr,CC_MENU1)
        mtla = Set(MenuTextLtrAttr,CC_HOTKEY1)
        msa  = Set(MenuSelectAttr,CC_SELECT1)
        msla = Set(MenuSelectLtrAttr,CC_SELKEY1)
        mba  = Set(MenuBorderAttr,CC_MENU1)
        case num
            when LM_FINDMENU    FindListMenu()
            when LM_ASOCMENU    AssocMenu()
            when LM_LNCHMENU    LaunchMenu()
        endcase
        Set(MenuTextAttr,mta)
        Set(MenuTextLtrAttr,mtla)
        Set(MenuSelectAttr,msa)
        Set(MenuSelectLtrAttr,msla)
        Set(MenuBorderAttr,mba)
    else
        Alarm()
    endif
end

/****************************************************************************\
  ú File management

    þ ManageFile        file management while recursing subtrees
        ù GIN   actions     control parameter
                name        filename
                path        target directory
        ù GIO   file_found  stats
        ù GOUT  exit_code   error code
\****************************************************************************/

proc ManageFile()
    string newname[128]

    // pop entry from stack

    KillLine()

    // gather filenames while searching files

    if actions & FA_FIND
        if TestWild()
            file_found = file_found + 1
            AddLine(ExpandPath(name),bfind)
        endif

    // carry out other file management actions

    elseif actions & FA_ALL
        FileMessage()
        newname = path + name

        if actions & FA_COMP
            CompDiskFile(name,path)
        elseif actions & FA_DEL
            if EraseDiskFile(name) == 0
                exit_code = EC_ERROR
                MsgBox("File "+name+" could not be deleted",MB_ERRBOX)
            endif
        elseif actions & FA_COPY
            if not CopyDiskFile(name,newname)
                exit_code = EC_ERROR
                MsgBox("File "+name+" could not be copied",MB_ERRBOX)
            endif
        elseif actions & FA_MOVE
            if not RenameDiskFile(name,newname)
                if CopyDiskFile(name,newname)
                    if not EraseDiskFile(name)
                        exit_code = EC_ERROR
                        MsgBox("File "+name+" could not be deleted",MB_ERRBOX)
                    endif
                else
                    exit_code = EC_ERROR
                    MsgBox("File "+name+" could not be copied",MB_ERRBOX)
                endif
            endif
        endif
    endif
end

/****************************************************************************\
  ú Directory management
                                                                              
    þ DirEntry          enter directory (setup)
        ù GIN   name        filename                                          
        ù GIO   actions     control parameter                                 
                path        target directory
        ù GOUT  exit_code   error code                                        
    þ DirExit           exit directory (cleanup)
        ù GIN   actions     control parameter
                name        filename
        ù GIO   path        target directory
        ù GOUT  exit_code   error code
\****************************************************************************/

proc DirEntry()

    // check "current dir only" flag

    if actions & DA_DOWN
        if actions & DA_STOP
            KillLine()
            return()
        else
            actions = actions | DA_STOP
        endif
    endif

    // go to directory and push contents onto stack

    ChDir(name)
    BuildPickBuffer("*.*")

    // build new directory tree or update target directory

    if actions & DA_LIST
        InsertDir(GetDir())
    elseif actions & DA_COMP
        path = path + name + "\"
        skip_this = (FileExists(path) & _DIRECTORY_) == 0
        if skip_this
            AddLine(Format("directory":9,"":3,path),bfind)
        endif
    elseif actions & DA_MAKE
        path = path + name
        if MkDir(path)
            path = path + "\"
            InsertDir(path)
            CopyDescription()
        else
            MsgBox("Cannot make directory "
                + SplitPath(path,_NAME_|_EXT_),MB_ERRBOX)
            exit_code = EC_STOP
        endif
    endif
end

proc DirExit()

    // go to parent and pop entry from stack

    KillLine()
    if name == "."
        return ()
    else
        ChDir("..")
    endif

    // remove directory and update target directory

    if actions & DA_DEL
        DelDescription()
        if RmDir(name)
            RemoveDir(name)
        else
            exit_code = EC_ERROR
            MsgBox("Directory "+name+" could not be removed",MB_ERRBOX)
        endif
    endif

    path = SplitPath(ExpandPath(path+".."),_DRIVE_|_PATH_)
end

/****************************************************************************\
  ú File counting

    þ Filename          compute filename and count entries and sizes
        ù GIO   dir_count   stats
                file_count
                file_total
        ù GOUT  name        filename
\****************************************************************************/

proc Filename( var integer isdir, var integer isnew )

    // accumulate file size (directories == 0)

    file_total = file_total
        + CurrChar(19) + (CurrChar(20) shl 8)
        + (CurrChar(21) shl 16) + (CurrChar(22) shl 24)

    // mark fields within filename column

    GotoColumn(14)
    InsertText("\",_OVERWRITE_)
    lFind("{[ \\]?}{[~ \\]#}[ ]@{[~ \\]@}[ ]@\\","cgx")

    // concat filename and extension

    MarkFoundText(2)
    name = GetMarkedText()
    MarkFoundText(3)
    if isBlockInCurrFile()
        name = name + "." + GetMarkedText()
    endif

    // check for directories and count directory entries

    MarkFoundText(1)
    isdir = isBlockInCurrFile()
    if isdir
        BegLine()
        isnew = CurrChar() == Asc("\")
        if isnew
            InsertText(" ",_OVERWRITE_)
            if name <> ".."
                dir_count = dir_count + 1
            endif
        endif
        if name == ":"                      // ":" denotes the root dir
            name = "\"
        endif
    else
        file_count = file_count + 1
    endif
end

/****************************************************************************\
  ú Driver Routine

    þ Recurse           recursively visit subdirectories
        ù IN    source      source root
                target      target root
        ù OUT   switch      exit code
        ù GIN   actions     control parameter
        ù GUSE  name        current file or directory name
                path        target directory
                dir_count   stats
                file_count
                file_found
                file_total
                exit_code   error code
\****************************************************************************/

proc Recurse()
    integer id, isdir = 0, isnew = 0
    string curr[80] = GetDir()

    // get source name and target path and test for recursive copy/move

    name = GetGlobalStr(source)
    if actions & DA_MAKE|DA_COMP
        path = SplitPath(GetGlobalStr(target),_DRIVE_|_PATH_)
        if Pos(curr+name+"\",path) == 1
            MsgBox("Operation is an infinte loop!",MB_ERRBOX)
            exit_code = EC_ERROR
            return()
        endif
    else
        path = ""
    endif

    // push first entry onto stack

    id = GotoBufferId(stack)
    InsertText("\")
    InsertText(SplitPath(name,_NAME_))
    GotoColumn(11)
    InsertText(SubStr(SplitPath(name,_EXT_),2,3))
    GotoColumn(19)
    InsertText("    ")                          // string is all NULs

    // init global variables and open message box

    exit_code  = FALSE
    dir_count  = 0
    file_count = 0
    file_total = 0
    file_found = 0
    MsgBox("",MB_OPEN)

    // iterate over directory names until stack is empty

    while NumLines() and exit_code < EC_BREAK

        EndFile()                               // get next filename
        Filename(isdir,isnew)

        if name == ".."                         // skip parent entries
            KillLine()
        else
            if isdir                            // is it a directory ?
                DirMessage()
                if isnew                        // already visited ?
                    DirEntry()
                else
                    DirExit()
                endif
            else                                // it's a file
                ManageFile()
            endif
        endif

        if CheckBreak()
            exit_code = EC_BREAK
        endif

    endwhile

    // close message box and handle interrupts

    MsgBox("",MB_CLOSE)
    EmptyBuffer()
    ChDir(curr)
    skip_this = FALSE
    if exit_code == EC_STOP
        MsgBox("Operations not completed",MB_ERRBOX)
    endif
    SetGlobalInt(switch,exit_code)

    // sort tree buffer

    if actions & DA_TREE
        SortTree()
    endif

    // go back to where we came from

    GotoBufferId(id)
end

/****************************************************************************\
  ú Public functions (process communication)

    þ TF_GetHist        return a history id
        ù IN    switch      flags
        ù OUT   switch      history id
\****************************************************************************/

public proc TF_GetHist()
    SetGlobalInt(switch,GetHist(GetGlobalInt(switch)))
end

/****************************************************************************\
  ú Public functions (input)

    þ TF_AskText        text input prompt
        ù IN    switch      history id
                source      default reply
                target      prompt string
        ù OUT   switch      return code of AskText
                source      user reply
\****************************************************************************/

public proc TF_AskText()
    integer flags = GetGlobalInt(switch)
    string reply[80] = GetGlobalStr(source)

    flags = AskText(GetGlobalStr(target),reply,flags)
    SetGlobalInt(switch,flags)
    SetGlobalStr(source,reply)
end

/****************************************************************************\
  ú Public functions (messages)
                                                                              
    þ TF_MsgBox         message popup window
        ù IN    switch      message flags
                source      message string                                    
        ù OUT   switch      return code of MsgBox
\****************************************************************************/

public proc TF_MsgBox()
    SetGlobalInt(switch,MsgBox(GetGlobalStr(source),GetGlobalInt(switch)))
end

/****************************************************************************\
  ú Public functions (file browsing)
                                                                              
    þ TF_BrowseFile     display a file in a read only scrolling list
        ù IN    switch      hex display
                source      filename                                          
        ù GUSE  action      disable grep compression
                path        filename
\****************************************************************************/

public proc TF_BrowseFile()
    actions = 0
    path = GetGlobalStr(source)
    BrowseFile(GetGlobalInt(switch) == BF_HEX)
end

/****************************************************************************\
  ú Public functions (file searching)

    þ TF_ExecFind       search files
        ù IN    switch      find options
        ù OUT   switch      necessary file listing
        ù USE   source      root for searching
        ù GUSE  action      find or grep and search depth
\****************************************************************************/

public proc TF_ExecFind()
    integer flags = GetGlobalInt(switch)

    // preset return code

    SetGlobalInt(switch,FF_CONT)

    // do a grep or a normal find ?

    if flags & FF_GREP
        if AskText("Enter text to match in files:",grep,IB_GREP)
            actions = TA_GREP
        else
            return ()
        endif
    else
        actions = TA_FIND
    endif

    // get wild card and determine search depths

    wild = ""
    if AskText("Enter mask for filenames to search:",wild,IB_FILE)
        MakeWild()
        if flags & (FF_DISK | FF_GLOB)
            SetGlobalStr(source,":")        // ":" denotes the root dir
        else
            SetGlobalStr(source,".")
            if flags & FF_CURR
                actions = actions | DA_DOWN
            endif
        endif
    else
        return ()
    endif

    // actually find and display files

    if flags & FF_GLOB
        file_found = ForAllDrives()
    else
        Recurse()
    endif
    ShowFoundFiles()
end

/****************************************************************************\
  ú Public functions (files)

    þ TF_CopyDiskFile   copies the specified file
        ù IN    source      source file name
                target      target file name
        ù OUT   switch      return code
    þ TF_CompDiskFile   compares the specified file
        ù IN    source      source file name
                target      target directory name
        ù OUT   switch      return code
    þ TF_ShowCompResult
\****************************************************************************/

public proc TF_CopyDiskFile()
    integer rc

    rc = CopyDiskFile(GetGlobalStr(source),GetGlobalStr(target))
    SetGlobalInt(switch,rc)
end

public proc TF_CompDiskFile()
    CompDiskFile(GetGlobalStr(source),GetGlobalStr(target))
end

public proc TF_ShowCompResult()
    ShowCompResult()
end

/****************************************************************************\
  ú Public functions (directories)

    þ TF_MakeDir        make a new directory
        ù IN    source      directory name
        ù OUT   switch      return code
    þ TF_RmDir          make a new directory
        ù IN    source      directory name
        ù OUT   switch      return code
    þ TF_RenDir         update tree list when renaming directories
        ù IN    source      old directory
                target      new directory
    þ TF_DelDir         delete a directory tree
        ù IN    source      directory name
        ù OUT   switch      exit code
        ù GUSE  actions     delete
    þ TF_CompDir        compare files in a directory tree
        ù IN    source      source directory name
                target      target directory name
        ù OUT   switch      exit code
        ù GUSE  actions     comp
    þ TF_MoveDir        move a directory tree
        ù IN    source      source directory name
                target      target directory name
        ù OUT   switch      exit code
        ù GUSE  actions     move
    þ TF_CopyDir        copy a directory tree
        ù IN    source      source directory name
                target      target directory name
        ù OUT   switch      exit code
        ù GUSE  actions     copy
\****************************************************************************/

public proc TF_MakeDir()
    integer rc
    string dir[80] = GetGlobalStr(source)

    rc = MkDir(dir)
    if rc
        if InsertDir(GetDir()+dir+"\")
            SortTree()
        endif
    else
        MsgBox("Directory could not be created",MB_ERRBOX)
    endif
    SetGlobalInt(switch,rc)
end

public proc TF_RmDir()
    integer rc
    string dir[80] = GetGlobalStr(source)

    rc = RmDir(dir)
    if rc
        RemoveDir(dir)
    else
        MsgBox("Directory could not be removed",MB_ERRBOX)
    endif
    SetGlobalInt(switch,rc)
end

public proc TF_RenDir()
    string old[80], new[80]

    old = ExpandPath(GetGlobalStr(source)) + "\"
    new = SplitPath(ExpandPath(GetGlobalStr(target)),_DRIVE_|_PATH_)
    RenameDir(old,new)
    SortTree()
end

public proc TF_DelDir()
    actions = TA_DEL
    Recurse()
end

public proc TF_CompDir()
    actions = TA_COMP
    Recurse()
end

public proc TF_MoveDir()
    actions = TA_MOVE
    Recurse()
end

public proc TF_CopyDir()
    actions = TA_COPY
    Recurse()
end

/****************************************************************************\
  ú Public functions (trees)                                                 :
                                                                             :
    þ TF_TreeCommand        display trees of all configured drives           :
        ù IN    switch          action flag                                  :
                source          search string (TC_CHDIR)                     :
        ù GIN   drives          (TC_REFRESH)                                 :
        ù OUT   switch          change directory flag                        :
                source          name of directory                            :
    þ TF_GetTreeStats       count items only                                 :
        ù USE   actions         count items only                             :
                source          directory name                               :
\****************************************************************************/

public proc TF_TreeCommand()
    integer flag = GetGlobalInt(switch)

    case flag
        when TC_TREE
            DisplayTree("","")
        when TC_SUB
            DisplayTree(GetDir(),"^")
        when TC_CHDIR
            DisplayTree("\\[~\\]*" + GetGlobalStr(source) + "[~\\]*\\$","x")
        when TC_NEW
            RefreshTree()
    endcase
end

public proc TF_GetTreeStats()
    SetGlobalStr(source,".")
    actions = TA_COUNT
    Recurse()

    if exit_code == 0 and PopWinOpen(21,8,60,15,1,"Subtree Info",CC_INFO)
        Set(Cursor,OFF)
        Set(Attr,CC_INFO)
        ClrScr()
        VGotoXY( 4,2) PutStr("Subdirectories")
        VGotoXY( 4,4) PutStr("Files")
        VGotoXY( 4,5) PutStr("Total File Size")
        VGotoXY(26,2) Write(dir_count:10)
        VGotoXY(26,4) Write(file_count:10)
        VGotoXY(26,5) Write(file_total:10)
        Set(Cursor,OFF)
        GetKey()
        PopWinClose()
    endif
end

/****************************************************************************\
  ú Public functions (file descriptions)

    þ TF_ReadDesc       read a description file
        ù IN    switch      buffer id
        ù SIN   describe
        ù OUT   switch      return code (line count)
    þ TF_WriteDesc      write a description file
        ù IN    switch      buffer id
        ù SIN   describe
\****************************************************************************/

public proc TF_ReadDesc()
    integer id
    string fn[128]

    fn = GetDir() + DescFile
    id = GotoBufferId(GetGlobalInt(switch))
    EmptyBuffer()
    if GetGlobalInt(describe) and ShowFile(fn)
        InsertFile(fn)
        UnmarkBlock()
        HideFile(fn)
    endif
    SetGlobalInt(switch,NumLines())
    FileChanged(FALSE)
    GotoBufferId(id)
end

public proc TF_WriteDesc()
    integer save = TRUE
    integer desc = GetGlobalInt(describe)
    integer prompt = GetGlobalInt(savedsc)
    integer id, rc
    string fn[128]
    string msg1[40] = "Description saving is off! Save anyway?"
    string msg2[32] = "Descriptions changed! Save now?"

    fn = GetDir() + DescFile
    id = GotoBufferId(GetGlobalInt(switch))
    if FileChanged()
        if not desc
            save = MsgBox(msg1,MB_INPBOX) == <Enter>
        elseif prompt
            save = MsgBox(msg2,MB_INPBOX) == <Enter>
        endif
        if save
            rc = ShowFile(fn)
            if NumLines()
                SaveAs(fn,_OVERWRITE_)
            elseif rc
                EraseDiskFile(fn)
            endif
            HideFile(fn)
        endif
    endif
    GotoBufferId(id)
end

/****************************************************************************\
  ú Printing commands
                                                                              
    þ TF_PrintDir       output current dir to printer or disk
        ù SIN   device                                                        
                prtini
\****************************************************************************/

public proc TF_PrintDir()
    integer id, rc
    integer fmPrintCopies, fmPrintLinesPerPage
    integer fmPrintFirstPage, fmPrintLastPage
    integer fmPrintTopMargin, fmPrintBotMargin
    integer fmPrintLeftMargin, fmPrintRightMargin
    integer fmPrintLineSpacing, fmPrintLineNumbers
    string  fmPrintHeader[4], fmPrintFooter[4]
    string  fmPrintDevice[48], fmPrintInit[60]
    string  port[48]
    string  dir[80]

    // ask for output port

    port = GetGlobalStr(device)
    if not AskText("Printer output port:",port,IB_PORT)
        return ()
    endif

    // copy listing to work buffer

    MarkColumn(1,1,NumLines(),76)
    id = GetBufferId()
    dir = GetDir()
    dir = SubStr(dir,1,Length(dir)-1)
    if not CreateBuffer(dir,_HIDDEN_)
        MsgBox("Cannot create temp buffer",MB_ERRBOX)
        UnmarkBlock()
        return ()
    endif
    CopyBlock()
    UnmarkBlock()
    lReplace("["+Chr(TC_DIR)+Chr(TC_NOTAG)+"]"," ","gxn")

    // setup printer

    fmPrintCopies       = Set(PrintCopies,1)
    fmPrintFirstPage    = Set(PrintFirstPage,0)
    fmPrintLastPage     = Set(PrintLastPage,0)
    fmPrintLinesPerPage = Set(PrintLinesPerPage,60)
    fmPrintTopMargin    = Set(PrintTopMargin,1)
    fmPrintBotMargin    = Set(PrintBotMargin,1)
    fmPrintLeftMargin   = Set(PrintLeftMargin,2)
    fmPrintRightMargin  = Set(PrintRightMargin,78)
    fmPrintLineSpacing  = Set(PrintLineSpacing,1)
    fmPrintLineNumbers  = Set(PrintLineNumbers,OFF)
    fmPrintHeader       = Set(PrintHeader,"FDTP")
    fmPrintFooter       = Set(PrintFooter,"")
    fmPrintDevice       = Set(PrintDevice,port)
    fmPrintInit         = Set(PrintInit,GetGlobalStr(prtini))

    // send output

    rc = PrintFile()

    // restore printer

    Set(PrintCopies,fmPrintCopies)
    Set(PrintFirstPage,fmPrintFirstPage)
    Set(PrintLastPage,fmPrintLastPage)
    Set(PrintLinesPerPage,fmPrintLinesPerPage)
    Set(PrintTopMargin,fmPrintTopMargin)
    Set(PrintBotMargin,fmPrintBotMargin)
    Set(PrintLeftMargin,fmPrintLeftMargin)
    Set(PrintRightMargin,fmPrintRightMargin)
    Set(PrintLineSpacing,fmPrintLineSpacing)
    Set(PrintLineNumbers,fmPrintLineNumbers)
    Set(PrintHeader,fmPrintHeader)
    Set(PrintFooter,fmPrintFooter)
    Set(PrintDevice,fmPrintDevice)
    Set(PrintInit,fmPrintInit)

    // clean up

    AbandonFile()
    GotoBufferId(id)
    SetGlobalInt(switch,rc)
end

/****************************************************************************\
  ú Launching files

    þ TF_AssocList      edit the list of associated file types
    þ TF_Launch         execute an associated application
        ù IN    switch      forced launch
                source      current filename
        ù OUT   switch
\****************************************************************************/

public proc TF_AssocList()
    DispAssocList()
end

public proc TF_Launch()
    SetGlobalInt(switch,LaunchFile())
end

/****************************************************************************\
  ú Configuration management

    þ ReadLine          get current line
    þ TF_ReadConfig     read configuration from file
    þ TF_SaveConfig     save configuration to a file
        ù IN    switch      forced save switch

    These functions use all configuration variables.
\****************************************************************************/

string proc ReadLine()
    string text[80]

    text = GetText(1,80)
    Down()
    return (text)
end

public proc TF_ReadConfig()
    integer id
    string cfg[128]

    id = GotoBufferId(btemp)
    cfg = SplitPath(CurrMacroFilename(),_DRIVE_|_PATH_)
    cfg = cfg + ConfFile

    if FileExists(cfg) and InsertFile(cfg)
        Set(CurrVideoMode,Val(ReadLine()))
        SetGlobalStr(lmask,ReadLine())
        SetGlobalStr(rmask,ReadLine())
        SetGlobalInt(sfield,Val(ReadLine()))
        SetGlobalInt(sorder,Val(ReadLine()))
        SetGlobalInt(quitmsg,Val(ReadLine()))
        SetGlobalInt(inisave,Val(ReadLine()))
        SetGlobalInt(describe,Val(ReadLine()))
        SetGlobalInt(savedsc,Val(ReadLine()))
        SetGlobalInt(confirm,Val(ReadLine()))
        SetGlobalInt(restore,Val(ReadLine()))
        SetGlobalInt(autosave,Val(ReadLine()))
        SetGlobalStr(device,ReadLine())
        SetGlobalStr(prtini,ReadLine())
    else
        Set(CurrVideoMode,_25_LINES_)
        SetGlobalStr(lmask,"*.*")
        SetGlobalStr(rmask,"*.*")
        SetGlobalInt(sfield,DS_NAME)
        SetGlobalInt(sorder,_DEFAULT_)
        SetGlobalInt(quitmsg,TRUE)
        SetGlobalInt(inisave,TRUE)
        SetGlobalInt(describe,TRUE)
        SetGlobalInt(savedsc,FALSE)
        SetGlobalInt(confirm,WARN_ALL)
        SetGlobalInt(restore,TRUE)
        SetGlobalInt(autosave,FALSE)
        SetGlobalStr(device,"lpt1")
        SetGlobalStr(prtini,"")
    endif

    EmptyBuffer()
    GotoBufferId(bapps)
    cfg = SplitPath(CurrMacroFilename(),_DRIVE_|_PATH_)
    cfg = cfg + AppsFile

    if FileExists(cfg)
        InsertFile(cfg)
        UnmarkBlock()
        FileChanged(FALSE)
    endif

    GotoBufferId(id)
end

public proc TF_SaveConfig()
    integer id, save
    string cfg[128]

    save = GetGlobalInt(switch) or GetGlobalInt(autosave)

    id = GotoBufferId(bapps)
    cfg = SplitPath(CurrMacroFilename(),_DRIVE_|_PATH_)
    cfg = cfg + AppsFile

    if FileChanged() and
    (save or MsgBox("Associations changed! Save now?",MB_INPBOX) == <Enter>)
        SaveAs(cfg,_OVERWRITE_)
    endif

    if save
        GotoBufferId(btemp)
        cfg = SplitPath(CurrMacroFilename(),_DRIVE_|_PATH_)
        cfg = cfg + ConfFile

        InsertLine(GetGlobalStr(prtini))
        InsertLine(GetGlobalStr(device))
        InsertLine(Str(GetGlobalInt(autosave)))
        InsertLine(Str(GetGlobalInt(restore)))
        InsertLine(Str(GetGlobalInt(confirm)))
        InsertLine(Str(GetGlobalInt(savedsc)))
        InsertLine(Str(GetGlobalInt(describe)))
        InsertLine(Str(GetGlobalInt(inisave)))
        InsertLine(Str(GetGlobalInt(quitmsg)))
        InsertLine(Str(GetGlobalInt(sorder)))
        InsertLine(Str(GetGlobalInt(sfield)))
        InsertLine(GetGlobalStr(rmask))
        InsertLine(GetGlobalStr(lmask))
        InsertLine(Str(Query(CurrVideoMode)))

        SaveAs(cfg,_OVERWRITE_)
        EmptyBuffer()
    endif

    GotoBufferId(id)
end

/****************************************************************************\
  ú Entry and exit code

    þ WhenLoaded
        ù IN    target      code for checking caller
        ù SOUT  drives      drives scanned for tree
        ù GOUT  ******      buffer id's
                ******      history id's
    þ WhenPurged
        ù SIN   drives      drives scanned for tree
        ù GIN   ******      buffer id's
                ******      history id's

    at exit all session global variables are cleared
\****************************************************************************/

proc WhenLoaded()
    integer id
    string tree[128]

    // check for caller

    if GetGlobalStr(target) <> target
        Alarm()
        MsgBox("TSEFile1 can only be executed by TSEFile",MB_ERRBOX)
        Set(Cursor,ON)
        PurgeMacro(CurrMacroFilename())
        return ()
    endif

    // allocate and check work space

    stack = CreateBuffer("",_HIDDEN_)
    btemp = CreateBuffer("",_HIDDEN_)
    bcomp = CreateBuffer("",_HIDDEN_)
    bapps = CreateBuffer("",_HIDDEN_)
    bfind = CreateBuffer("",_HIDDEN_)
    btree = CreateBuffer("",_HIDDEN_)

    if stack == 0 or btemp == 0 or bcomp == 0
    or bapps == 0 or bfind == 0 or btree == 0
        Alarm()
        MsgBox("Cannot create buffers",MB_ERRBOX)
        Set(Cursor,ON)
        PurgeMacro(CurrMacroFilename())
        return ()
    endif

    // get history lists

    h_port = GetFreeHistory()
    h_desc = GetFreeHistory()
    h_grep = GetFreeHistory()
    h_file = GetFreeHistory()
    h_dirs = GetFreeHistory()
    h_exec = GetFreeHistory()
    AddHistoryStr("",h_port)
    AddHistoryStr("",h_desc)
    AddHistoryStr("",h_grep)
    AddHistoryStr("*.*",h_file)
    AddHistoryStr("*.*",h_dirs)
    AddHistoryStr("",h_exec)


    // load previously saved tree information

    id = GotoBufferId(btree)
    tree = SplitPath(CurrMacroFilename(),_DRIVE_|_PATH_)
    tree = tree + TreeFile
    if FileExists(tree)
        InsertFile(tree)
        UnmarkBlock()
        SetGlobalStr(drives,GetText(1,CurrLineLen()))
        KillLine()
    else
        SetGlobalStr(drives,"c")
    endif
    FileChanged(FALSE)
    GotoBufferId(id)
end

proc WhenPurged()
    integer id
    string tree[128]

    // save tree information

    id = GotoBufferId(btree)
    if id and FileChanged()
        BegFile()
        InsertLine(GetGlobalStr(drives))
        tree = SplitPath(CurrMacroFilename(),_DRIVE_|_PATH_)
        tree = tree + TreeFile
        SaveAs(tree,_OVERWRITE_)
    endif
    GotoBufferId(id)

    // clear histories

    DelHistory(h_port)
    DelHistory(h_desc)
    DelHistory(h_grep)
    DelHistory(h_file)
    DelHistory(h_dirs)
    DelHistory(h_exec)

    // clear work space

    AbandonFile(stack)
    AbandonFile(btemp)
    AbandonFile(bcomp)
    AbandonFile(bfind)
    AbandonFile(bapps)
    AbandonFile(btree)
end

