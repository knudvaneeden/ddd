/* 旼컴컴컴컴컴컴컴컴컴컴컴커
 旼? TSE Screen Capture     읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴?
 쳐컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
 ? SOFTWARE:    PrtSc
 ? VERSION:     1.00.00
 ? DATE:        06/12/95 08:50 am
 ? REV. DATE:   09/16/95 01:50 am
 ? AUTHOR:      Mike Chambers
 ? TYPE:        External Macro
 ?
 쳐컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
 ? Revision History                                                         ?
 ?              0.10 Initial functionality                                  ?
 ?              1.00 Released for TSE Pro 2.5                               ?
 쳐컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴캑
 ?                                                                          ?
 ? FUNCTION:    Captures the current TSE screen to an edit buffer.          ?
 ?                                                                          ?
 ?              PrtSc is a utility macro which allows you to capture        ?
 ?              the exact contents of the entire TSE screen to a buffer.    ?
 ?              It will capture everything in the viewable screen area      ?
 ?              including statusline, message, help lines, menus, and       ?
 ?              prompt boxes.                                               ?
 ?                                                                          ?
 ?              PrtSc uses quite a few TSEPRO 2.5 beta features             ?
 ?              (including _NonEdit_Idle_, PeekWord, PeekByte).             ?
 ?                                                                          ?
 ? USAGE:       Execute the macro (via Potpourri, menu, etc).  Navigate     ?
 ?              TSE to the condition you wish to capture.  Press the        ?
 ?              "trigger", <Ctrl PrtSc>.  This will create a sequentially   ?
 ?              numbered buffer, 1.SCR.  This file will not be written      ?
 ?              to disk unless you save it.                                 ?
 읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
*/

integer ScrCols, ScrRows
integer BufCtr = 0
integer BufId

proc PrtScreenToBuffer()
    integer r, c
    string l[255]
    register regs
    integer VSegAddr

    regs.ax = 0xf00
    intr(0x10, regs)
    VSegAddr = iif((LoByte(regs.ax) & 0x7f) == 7, 0xb000, 0xb800)

    PushPosition()
    HideMouse()             // ???
    Set(Cursor, OFF)

    ScrCols = Query(ScreenCols)
    ScrRows = Query(ScreenRows)

    BufCtr = BufCtr + 1
    BufId  = CreateBuffer(str(BufCtr)+'.scr')

    for r = 0 to ScrRows - 1
        l = ''
        for c = 0 to ScrCols - 1
            l = l + chr(PeekByte(ptr(VsegAddr,(r * ScrCols * 2 + c*2))))
        endfor
        addline(l, BufId)
    endfor

    PushKey(<escape>)             // Clear the <Ctrl PrtSc> so we don't loop
    c = GetKey()                  // endlessly copying the screen

    UpdateDisplay(_ALL_WINDOWS_REFRESH_ | _HELPLINE_REFRESH_)
    Set(Cursor, ON)
    ShowMouse()
    PopPosition()
end

proc PrtScreenHook()
                if Query(Key) == <Ctrl PrtSc>
                        PrtScreenToBuffer()
                endif
end

proc WhenLoaded()
        Hook(_nonedit_idle_, PrtScreenHook)
        Message('Press <Ctrl PrtSc> to copy the screen to an edit buffer.')
end

proc WhenPurged()
        Unhook(PrtScreenHook)
end

<Ctrl PrtSc> PrtScreenToBuffer()
