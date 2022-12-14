/* 旼컴컴컴컴컴컴컴컴컴컴컴컴컴커
 旼? TSE Structured Text Viewer 읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴?
 ?                                                                          ?
 ? SOFTWARE:    TextView.s                                                  ?
 ? VERSION:     1.00                                                        ?
 ? DATE:        07/11/95 08:22 am                                           ?
 ? REV. DATE:   09/16/95 01:58 am                                           ?
 ? AUTHOR:      Mike Chambers                                               ?
 ? TYPE:        External Macro                                              ?
 ?                                                                          ?
 쳐컴컴컴컴컴컴컴컴컴컴컴컴컴? Revision History 컴컴컴컴컴컴컴컴컴컴컴컴컴컴?
 ?                                                                          ?
 ? REV. HIST:   0.31 Genericized from IntrView.S (0.30)                     ?
 ?              0.32 Fixed config variable problem in list_width            ?
 ?              0.33 Various cosmetic changes                               ?
 ?              0.34 Fixed false hit when keyword in title                  ?
 ?              0.35 Fixed logic for negative deltatotitle                  ?
 ?              0.36 Display Topic Name in StatusLine                       ?
 ?              0.37 Sort resources based on description                    ?
 ?              0.38 Re-work topic framing logic                            ?
 ?              0.40 Return to prior topic list added                       ?
 ?              0.41 Tuning, improved buffer clean-up                       ?
 ?              0.42 Fixed clean-up on keyword not found condition          ?
 ?              0.43 Code restructuring for readability                     ?
 ?              0.44 Added return to last topic in mSearchView(OldSearch)   ?
 ?              0.45 Added ResourceStatus & CloseResource                   ?
 ?              0.46 Fixed memory leak due to ViewFindsId bug               ?
 ?                   Fixed null temp_fn  problem in OpenResource            ?
 ?                   Added 'All topics' searching                           ?
 ?              0.47 Added LoadWild for resource specification              ?
 ?                   Added InsertFiles()                                    ?
 ?                   Trim statusline topic string                           ?
 ?                   Added pushblock & popblock in InsertFiles()            ?
 ?                   Validated with 2.39b                                   ?
 ?                   Trim Title in list                                     ?
 ?              1.00 Released for TSE Pro 2.5                               ?
 ?                                                                          ?
 쳐컴컴컴컴컴컴컴컴컴컴컴컴? Installation & Usage 컴컴컴컴컴컴컴컴컴컴컴컴컴?
 ?                                                                          ?
 ? TextView is a full-text search and retrieval tool for text files which   ?
 ? contain a repeated discernible structure.  The tool takes advantage of   ?
 ? TSE large file and virtual memory capability to allow rapid access to    ?
 ? a user definable set of text resources.  Examples of common text         ?
 ? resources include: Ralf Brown's DOS Interrupt List; Tom Klein's          ?
 ? TSE Tip files; various *.DOC files;  BBS 'Allfiles' listings, etc.       ?
 ?                                                                          ?
 ? USAGE:  Invoke TextView using  <Ctrl Ins>.  Upon first execution,        ?
 ? TextView will prompt you to select the  resource you wish to search.     ?
 ? Highlight the desired resource using the cursor keys and press enter.    ?
 ? You will then be prompted to supply a search expression and search       ?
 ? options.  TextView will produce a list of Titled topics containing       ?
 ? the search expression.  Use the cursor keys to select a topic and        ?
 ? press enter.  The topic text will be displayed in a work buffer which    ?
 ? may be edited freely.  Press escape to return to the topic list and      ?
 ? escape from their to return to your original buffer.  The text of the    ?
 ? last topic will be stored on your clipboard for easy pasting into your   ?
 ? current edit session.                                                    ?
 ?                                                                          ?
 ? The default word will be the word at the cursor location; however,       ?
 ? TextView maintains a keyword search history which you may choose from.   ?
 ?                                                                          ?
 ? To see all list of all topics in a resource, press the space bar to      ?
 ? answer 'blank' or null to the Search Expression prompt.                  ?
 ?                                                                          ?
 ? You can return to the last topic list by pressing <Shift Ins>            ?
 ?                                                                          ?
 ? Configure TextView using <CtrlAlt Ins>.  Select a resource to Edit,      ?
 ? Copy or Delete using the cursor keys. Alt-C will copy the current        ?
 ? resource definition to a new entry. <Del> will delete the highlighted    ?
 ? entry. Alt-E will allow modification of the highlighted entry.  The      ?
 ? config variables are:                                                    ?
 ?                                                                          ?
 ? Tag          A 8 character mnemonic for the resource                     ?
 ? FileName     A full path file name (with navigation/completion aids)     ?
 ? Description  A description of the resource                               ?
 ? Separator    An expression to identify the separation between topics     ?
 ? DeltaTitle   Number of lines from the separator to the title line        ?
 ? DeltaBottom  Number of lines from the separator to the last line of the  ?
 ?              previous topic                                              ?
 ?                                                                          ?
 ? If the filename is left blank, you will be prompted to supply a file     ?
 ? name each time a search is started for that resource.  This is useful    ?
 ? for circumstances where different files of the same format need to       ?
 ? be searched.                                                             ?
 ?                                                                          ?
 ? Wildcards (* and ?) can be used in the filename specification.  This     ?
 ? is useful when the resource is composed of a series of related files     ?
 ? with the same structure (for example, Ralf Brown's Interrupt List,       ?
 ? Tom Klein's TSE_TIP files, etc.  To create a resource definition         ?
 ? containing a wildcard, enter the pathname (or navigate to it). Enter     ?
 ? the appropriate wildcard spec to the end of the path.  TSE will prompt   ?
 ? you to select from the list of files matching the wild card -- this      ?
 ? gives you an opportunity to verify that the wildcard produces the        ?
 ? intended result.  Press escape to return to the prompt box, keeping the  ?
 ? specified wildcard specification.                                        ?
 ?                                                                          ?
 ? Configuration data is stored in a file (currMacroFileName()+'.dat').     ?
 ? This defaults to TextView.Dat.                                           ?
 ?                                                                          ?
 ? By default, this file  is stored in the same path as the .mac file.      ?
 ? However, the file may be kept anywhere on the TsePath.                   ?
 ?                                                                          ?
 쳐컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴? Notes 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴캑
 ?                                                                          ?
 ? TextView is based on IntrView (which is now obsolete) and on code        ?
 ? borrowed from SemWare's TSE macros mCompressView (2.0) and Compile.s.    ?
 ? The author relinquishes all interest in this work to SemWare, with       ?
 ? thanks to Sammy Mitchell (for giving us TSE), Steve Watkins (for the     ?
 ? fancy compile macro & the life-saving macro debugger), and George DeBruin?
 ? (for valor above and beyond the call of tech support).                   ?
 ?                                                                          ?
 ? Portions of this work are derived from copyrighted material and are      ?
 ? used in accordance with the copyright holder provisions outlined below:  ?
 ?                                                                          ?
 쳐컴컴컴컴컴컴컴컴컴컴컴컴컴 Copyright Notice 컴컴컴컴컴컴컴컴컴컴컴컴컴컴캑
 ?                                                                          ?
 ? Copyright 1992-1994 SemWare Corporation.  All Rights Reserved Worldwide. ?
 ?                                                                          ?
 ? Use, modification, and distribution of this SAL macro is encouraged by   ?
 ? SemWare provided that this statement, including the above copyright      ?
 ? notice, is not removed; and provided that no fee or other remuneration   ?
 ? is received for distribution.  You may add your own copyright notice     ?
 ? to cover new matter you add to the macro, but SemWare Corporation will   ?
 ? neither support nor assume legal responsibility for any material added   ?
 ? or any changes made to the macro.                                        ?
 ?                                                                          ?
 읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
*/

constant NewSearch      = 0
constant OldSearch      = 1
constant ADD_RECORD     =   1,
         COPY_RECORD    =   2,
         DELETE_RECORD  =   3

string Search_buffer_name[] = "[<Search>]"
string Topic_buffer_name[]= "[<Topic>]"
string Search_message[] = " {Enter} - View Topic    {Escape} - Cancel    "
integer Search_hist, width
integer Search_id, Text_id, vid, Topic_id, original_id
string expression[100], options[12]

string data_fn[]    = "textview.dat"

integer  data_id, work_id

string full_data_fn[80]
integer new_file

// data for Resource records
string EyeCatcher[] = "TextView Resource config file"
string  tag[9]
string  descr[64]
string  Separator[64]
string  TextFileName[64]
string  sDeltaToTitle[3]
string  sDeltaToTop[3]
integer DeltaToBottom
integer DeltaToTitle

constant LIST_WIDTH = sizeof(descr) + sizeof(tag) + 2

integer Resource_start, Resource_end
integer num_Resources
integer exec_Resource_done

proc SetXY()
    Set(x1,WhereXAbs())
    Set(y1,WhereYAbs())
end


integer proc _InsertFile(string fn)
    integer level, success
    level = Set(MsgLevel, _NONE_)
    success = InsertFile(fn)
    Set(MsgLevel, level)
    return (success)
end


proc ReadLn(var string s)
    s = GetText(1,CurrLineLen())
    Down()
end


proc ReadRecord()
    integer id
    string s[10]=''
    id = GotoBufferId(data_id)

    Resource_start = CurrLine()


    readln(tag)
    readln(TextFileName)
    readln(descr)
    readln(Separator)
    readln(sDeltaToTitle)
    readln(sDeltaToTop)
    DeltaToTitle = val(sDeltaToTitle)
    DeltaToBottom = val(sDeltaToTop)
    readln(s)

    tag = substr(tag,2,sizeof(tag))

    Resource_end = CurrLine()
    GotoLine(Resource_start)

    GotoBufferId(id)
end


proc WriteLn(string s)
    // only write if line changed so FileChanged() is accurate

    if GetText(1,CurrLineLen()) <> s
        BegLine()
        KillToEol()
        InsertText(s)
    endif
    if not Down()
        AddLine()
    endif
    BegLine()
end


proc SaveResourceData()
    integer id, level, eoltype

    level = Set(MsgLevel, _NONE_)

    eoltype = Set(EOLType, 2)
    id = GotoBufferId(data_id)
    if FileChanged()
        if new_file
            SetXY()
            if YesNo("Create setup file: '"+full_data_fn+"'") == 1
                BegFile()
                InsertLine(EyeCatcher)
                if SaveAs(full_data_fn, _OVERWRITE_)
                    new_file = FALSE
                endif
            endif
        else
            SaveAs(full_data_fn, _OVERWRITE_)
        endif
    endif
    Set(EOLType, eoltype)

    Set(MsgLevel, level)
    GotoBufferId(id)
end


proc WriteRecord()
    integer id

    id = GotoBufferId(data_id)

    WriteLn(''+tag)
    WriteLn(TextFileName)
    Writeln(descr)
    WriteLn(Separator)
    WriteLn(sDeltaToTitle)
    WriteLn(sDeltaToTop)
    WriteLn('')

    GotoBufferId(id)
end


proc GenerateResourceList()
    integer line, level

    EmptyBuffer(work_id)

    GotoBufferId(data_id)
    PushPosition()

    num_Resources = 0

    if not lFind('','^g')
        Addline("        No Structured Text Resources configured", work_id)
    else
        repeat
            line = CurrLine()
            ReadRecord()
            AddLine(format(iif(GetBufferId(tag),'',' '),tag:-10,descr:-sizeof(descr),line:4), work_id)
            num_Resources = num_Resources + 1
        until not lRepeatFind()
    endif

    PopPosition()

    GotoBufferId(work_id)
    MarkColumn(1,11,NumLines(),70)
    level = Set(MsgLevel, _NONE_)
    Sort(_IGNORE_CASE_)
    Set(MsgLevel, level)
    MarkColumn(1,1,NumLines(),LIST_WIDTH)
end

integer proc InsertFiles (string filename)

    string  path[128] = '',  dta[80] = '',   s[80]

            path = splitpath(filename, _drive_ | _path_)
            SetDTA(dta)
            if FindFirst(filename)
                repeat
                    s = DecodeDTA(dta)
                    EndFile()
                    creturn()
                    pushBlock()
                    if not insertfile(path+s[2:13])
                       popblock()
                       return(false)
                    endif
                    popblock()
                    SetDTA(dta)
                until not FindNext()
            else
                return(false)
            endif
            return(true)
end


integer proc OpenResource(string tag)
    string  temp_fn[128]=''

    // if no filename specified in resource config, prompt user for it
       if TextFileName == ''
           askfilename(format('Enter (',tag,') filename:'),Temp_fn,
                         (_full_path_ | _must_exist_) )
           if trim(temp_fn) == '' return(false)  endif
       else
           temp_fn = TextFileName
       endif

    // If text buffer exists, use it;  if not, create and insert the
    // TextFileName into it.
       Text_id = CreateBuffer(Tag,_hidden_)
       if Text_id == 0
           Text_id = GetBufferId(Tag)
       endif
       if Text_id == 0 or not GotoBufferId(Text_id)
           return (false)
       endif
       if NumLines() < 2
          if not InsertFiles(temp_fn)
               Warn(' Text File (',TextFileName,')',' not found')
          endif
       endif
       BegFile()
       width = Length(Str(NumLines()))
       return(true)
end


proc CloseResource(string tagname)
    if GetBufferId(trim(tagname))
       abandonfile(GetBufferId(trim(tagname)))
    endif
end


menu ResourceSetupMenu()
    Title = 'Configure Text Resource'

    "&Tag          " [format(tag:-8):-8]           ,
                    Read(tag)      , DontClose     ,
                    "A brief designator for the reference resource"
    "&File Name    " [format(TextFileName:-60):-60]  ,
                    AskFileName('',TextFileName, _full_path_ | _must_exist_), DontClose,
                    "Full path name of the file containing the reference resource"
    "&Description  " [format(descr:-60):-60]       ,
                    Read(Descr)      , DontClose,
                    "Description of the reference resource"
    "&Separator    " [format(Separator:-60):-60]   ,
                    Read(Separator)      , DontClose,
                    "Regular Expression Pattern separating topics in the resource"
    "DeltaToT&itle " [format(sDeltaToTitle:-3):-3] ,
                    ReadNumeric(sDeltaToTitle)      , DontClose,
                    "Number of lines from the separator to a topic title"
    "DeltaTo&Bottom" [format(sDeltaToTop:-3):-3]   ,
                    ReadNumeric(sDeltaToTop)      , DontClose,
                    "Number of lines from the separator to end of previous topic"
end


proc ReadRecordFromList(integer flag)
    integer n = Val(GetText(LIST_WIDTH + 1,8))

    GotoBufferId(data_id)
    GotoLine(iif(flag == ADD_RECORD, NumLines(), n))
    ReadRecord()
end


proc EditResourceCommon(integer flag)
    integer id

    id = GetBufferId()

    ReadRecordFromList(flag)

    SetXY()
    if flag == DELETE_RECORD
        if YesNo("Delete "+descr+"?") == 1
            PushBlock()
            MarkLine(Resource_start, Resource_end)
            KillBlock()
            PopBlock()
        endif
    else
        ResourceSetupMenu()
        if length(tag)
            if flag == COPY_RECORD
                GotoLine(NumLines())
            endif
            WriteRecord()
        endif
    endif

    SaveResourceData()

    GotoBufferId(id)

    EndProcess()
end


proc EditResource()
    EditResourceCommon(0)
end


proc AddResource()
    EditResourceCommon(ADD_RECORD)
end


proc DelResource()
    if num_Resources
        EditResourceCommon(DELETE_RECORD)
    endif
end


proc CopyResource()
    EditResourceCommon(COPY_RECORD)
end


KeyDef ExecResourceKeys
    <Enter>     exec_Resource_done = 1        EndProcess(TRUE)
    <Escape>    exec_Resource_done = -1       EndProcess(TRUE)
    <Ins>       AddResource()
    <GreyIns>   AddResource()
    <Del>       DelResource()
    <GreyDel>   DelResource()
    <Alt E>     EditResource()
    <Alt C>     CopyResource()
    <End>       CloseResource(gettext(2,sizeof(tag))) GenerateResourceList()
end


proc ExecResourceHook()
    if Enable(ExecResourceKeys)
        WindowFooter("{Ins}-Add {Del}-Delete {End}-Close {Alt C}-Copy {Alt E}-Edit")
    endif
end


integer proc SelectResource()
    integer id, exec = FALSE
    string keyword[48] = tag

    id = GotoBufferId(data_id)

    PushBlock()

    exec_Resource_done = 0
    repeat
        GenerateResourceList()
        BegFile()
        lFind(keyword,"")
        Hook(_LIST_STARTUP_,ExecResourceHook)
        Set(Y1, 3)
        lList("Select Resource", LIST_WIDTH, Query(ScreenRows), _ENABLE_SEARCH_ | _BLOCK_SEARCH_)
        UnHook(ExecResourceHook)
        keyword = descr
    until exec_Resource_done
    if exec_Resource_done == 1
        ReadRecordFromList(0)
        exec = TRUE
    endif

    PopBlock()

    GotoBufferId(id)
    return (exec)
end


integer proc SetupResourceFiles()
    integer id

    full_data_fn = SplitPath(CurrMacroFileName(), _DRIVE_ | _PATH_) + data_fn
    if not FileExists(full_data_fn)
        full_data_fn = SearchPath(data_fn, Query(TSEPath), "mac")
    endif
    if full_data_fn == ""
        new_file = TRUE
        full_data_fn = data_fn
    endif

    id = GetBufferId()

    work_id  = CreateTempBuffer()
    data_id  = CreateTempBuffer()

    if data_id and not new_file
        PushBlock()
        _InsertFile(full_data_fn)
        PopBlock()
        BegFile()
    endif
    EndFile()
    if CurrLineLen()
        AddLine()   // make sure there's at least 1 blank line at end
    endif

    FileChanged(FALSE)
    GotoBufferId(id)
    return (data_id)
end


proc WhenLoaded()
    integer save_id = GetBufferId()

    if not SetupResourceFiles()
        PurgeMacro(CurrMacroFileName())
    endif

    Search_hist = GetFreeHistory ("Search")

    // If Topic buffer exists, use it;  if not, create it
       Topic_id = CreateBuffer(Topic_buffer_name,_hidden_)
       if Topic_id == 0
           Topic_id = GetBufferId(Topic_buffer_name)
       endif

    // If our result buffer is there, use it; if not, create it.
       Search_id = CreateBuffer(Search_buffer_name,_hidden_)
       if Search_id == 0
           Search_id = GetBufferId(Search_buffer_name)
       endif

       gotobufferid(save_id)

end


proc WhenPurged()
    integer save_id

    if work_id
        save_id = gotoBufferid(Work_id)
        BegFile()
        repeat
                CloseResource(GetText(1,sizeof(tag)))
        until not Down()
        AbandonFile(work_id)
        AbandonFile(data_id)
        AbandonFile(topic_id)
        AbandonFile(search_id)
        AbandonFile(vid)
        GotoBufferId(save_id)
    endif
end


integer proc mDown(integer x)
    return(iif(x > 0, Down(x), Up(abs(x))))
end


integer proc ListIt(string title, integer width)
    width = width + 4
    if width > Query(ScreenCols)
        width = Query(ScreenCols)
    endif
    return (List(title, width))
end


proc SearchHook()
        WindowFooter(Search_message)
end


keydef BrowseKeys
   <escape>    Endprocess(0)
   <helpline>  '   {Ctrl L} Next Find    {CtrlShift L} Previous Find    {Escape} Return to Topics'
end


integer proc BuildSearchBuffer()
    string  LastLineText[144]=''
    integer Last_Find_Line,   n

    // Various startup processing
       if Tag == ''
           SelectResource()
       endif
       set(break, _on_)

    // Default to a word search for Word At Cursor
       expression = GetWord(1)
       options = 'iw'

       if not ask(Format ("Word or expression to search ",tag," for:"), expression,
           Search_hist)
           return (false)
       endif
       if trim(expression) == ''
           expression = Separator
           options = 'x'
       else
           ask("Search options [IWX] (Ignore-case Words reg-eXp):", options)
       endif

    // Open the selected resource file
       if not OpenResource(tag) return(false) endif

    // Empty the Search buffer
       GotoBufferId(Search_id)
       EmptyBuffer()

    // Search for the expression using lfind v
       GotoBufferId(Text_id)
       BegFile()
       pushkey(<escape>)
       if not lFind(expression, options + 'gv')
           GetKey()
           GotoBufferId(original_id)
           Alarm()
           warn(expression, " not found.")
           return(false)
       endif

    // Use the ViewFinds buffer to create a topic list
           vid = query(viewfindsid)
           GotoBufferId(vid)
           BegFile()
           Down()
           LastLineText = GetText(1,144)
           n = pos(':',LastLineText) - 1
           repeat
               last_find_line = val(GetText(1,n))
               GotoBufferid(Text_Id)
               GotoLine(Last_Find_Line)
               if not lfind(Separator,'cx') lfind(Separator,'bx') endif
               mDown(DeltaToTitle)
               if LastLineText <> GetText(1,144)
                  LastLineText = GetText(1,144)
                  if not AddLine(format(trim(LastLineText):-144,currline():width),
                                 Search_id)
                      break
                  endif
                  Message(format(Last_Find_Line:width, ':',LastLineText))
               endif
               GotoBufferId(vid)
           until not down() or (KeyPressed() and GetKey() == <escape>)
           GotoBufferId(Search_id)
           BegFile()
           abandonfile(vid)
           return(true)
end


proc DisplaySearchBuffer()
    string topic[80]
    integer  list_result,  goto_line_no = 0

     // Display the result buffer and let user navigate the
     // the results.
        GotoBufferId(Search_id)
        ScrollToRow(10)
        repeat
              Hook(_LIST_STARTUP_, SearchHook)
              list_result = ListIt(format('TextView {',tag,'}: ',expression),
                                   70 + width)
              UnHook(SearchHook)
              goto_line_no = 0
              if list_result
               // First, locate the topic line in the text resource
                  goto_line_no = val(GetText(145, width))  // assign goto_line_no
                  GotoBufferId(Text_id)
                  GotoLine(goto_line_no)
                  topic=(GetText(1,80))
               // Next, locate the user-defined top-of-message
                  mDown(-DeltaToTitle + DeltaToBottom + 1)
                  MarkLine()
               // Skip the embedded separator if user wants it included
                  if CurrLine() <= (goto_line_no - DeltaToTitle)
                        lfind(Separator,'fx')
                  endif
               // Find the user-defined bottom-of-message
                  Down()
                  if not lFind(Separator,'fx') EndFile() endif
                  mdown(DeltaToBottom)
                  MarkLine()
                  Copy()
                  GotoBufferId(Topic_id)
               // Use topic name as buffer name for continuous topic display
                  ChangeCurrFileName(trim(topic))
                  Paste()
                  UnMarkBlock()
                  FileChanged(False)
                  Find(expression,options)
                  Enable (BrowseKeys)
                  Process()
                  Disable (BrowseKeys)
               // Reset the buffer name to prevent buffer memory fragmentation
                  ChangeCurrFileName(Topic_buffer_name)
                  EmptyBuffer()
                  UpdateDisplay(_all_windows_refresh_)
                  GotoBufferId(Search_Id)
              endif
        until list_result == 0
    gotobufferid(Text_id)
    Filechanged(false)
    if TextFileName == '' Abandonfile(Text_id) endif
    return()
end


proc mSearchView(integer SearchType)
    original_id = GetBufferId()
    case SearchType
        when OldSearch
                if Tag == '' or Text_id == 0 or Search_id == 0
                        return()
                endif
                DisplaySearchBuffer()
        when NewSearch
                if BuildSearchBuffer()
                        DisplaySearchBuffer()
                endif
    endcase
    gotobufferid(original_id)
    UpdateDisplay(_all_windows_refresh_)
end


<Ctrl Ins>        mSearchView(NewSearch)
<CtrlAlt GreyIns> SelectResource()
<Shift Ins>       mSearchView(OldSearch)

