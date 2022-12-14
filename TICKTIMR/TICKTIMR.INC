                                                                                /*
   旼컴컴컴컴컴컴컴컴컴컴?
 旼? TSE TICKTIMR MACROS 읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
 ?                                                                          ?
 ? SOFTWARE:    TickTimr                                                    ?
 ? VERSION:     0.10                                                        ?
 ? DATE:        September 2, 1994                                           ?
 ? REV. DATE:   September 2, 1994                                           ?
 ? AUTHOR:      Mike Chambers                                               ?
 ? TYPE:        Include                                                     ?
 ?                                                                          ?
 쳐컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴캑
 ?                                                                          ?
 ? FUNCTION:    Provide fast, simple binary timing functions                ?
 ?                                                                          ?
 ?              These macros use the system tick timer to provide           ?
 ?              timing functions without converting DOS Hr, Min, Sec        ?
 ?              values.  Since the system clock is updated on the           ?
 ?              same frequency as the system timer, it is a relatively      ?
 ?              precise means of measuring the time between two events      ?
 ?                                                                          ?
 ?                                                                          ?
 ?              integer proc TickCounter(var integer Midnight)              ?
 ?                           Returns value of system tick counter           ?
 ?                           (the number of Ticks since midnight)           ?
 ?                           and the number of midnights which have         ?
 ?                           passed since the counter was last queried      ?
 ?                                                                          ?
 ?              integer proc TickDelta(integer StartCount)                  ?
 ?                           Returns the difference in ticks between        ?
 ?                           now and a previous tick timestamp 'StartCount' ?
 ?                           Accounts for interval which cross midnight     ?
 ?                           up to a resolution of 555 days.                ?
 ?                                                                          ?
 ?              integer proc TicksToSeconds(integer ticks)                  ?
 ?                           Returns number of seconds equivalent to        ?
 ?                           'ticks'. The function is limited to            ?
 ?                           tick values less than 2,147,483 ticks          ?
 ?                           (which is: 117,951 seconds  or                 ?
 ?                                        1,965 minutes  or                 ?
 ?                                           32 hours       )               ?
 ?                                                                          ?
 ?              integer proc TickstoMs(integer ticks)                       ?
 ?                           Returns number of milliseconds represented     ?
 ?                           by 'ticks'.  The function is limited to        ?
 ?                           tick values less than 39,098 ticks             ?
 ?                           (which is: 2,147 seconds  or                   ?
 ?                                         35 minutes       )               ?
 ?                                                                          ?
 ?              integer proc TimeDosCmd(string cmd)                         ?
 ?                           Returns number of ticks taken to execute       ?
 ?                           the Dos command 'cmd'.                         ?
 ?                                                                          ?
 ?              integer proc TimeTseMacro(string macro)                     ?
 ?                           Returns number of ticks taken to execute       ?
 ?                           the TSE macro 'macro'.  The macro must         ?
 ?                           be public.                                     ?
 ?                                                                          ?
 ?                      proc ReportTimes(integer ticks)                     ?
 ?                           Displays times as ticks, seconds, and          ?
 ?                           milliseconds in status line warning            ?
 ?                           area                                           ?
 ?                                                                          ?
 ?                                                                          ?
 ?                                                                          ?
 ?  LIMITATIONS:  The approach has been to stick within integer limitations ?
 ?                and as a result, there are 31 bit limitations involved in ?
 ?                the conversion calculations that force trade offs between ?
 ?                range and precision.  (See the macro descriptions above   ?
 ?                for specific limits.)  TicksToMs is slanted toward        ?
 ?                resolution, whereas TicksToSeconds is slanted toward      ?
 ?                higher range.                                             ?
 ?                                                                          ?
 ?                The Main() and ReportTimes procedures are primarily for   ?
 ?                demonstration of the timing functions.                    ?
 ?                                                                          ?
 ?                                                                          ?
 ?  These macros are in 'test mode'.  While I know of no problems, use      ?
 ?  them at your own risk.  And in the words of Mikhail Gorbachev:          ?
 ?                      "Trust -- but verify."                              ?
 읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸    */

constant TicksPerDay     =  0x1800B0

#include "intr.inc"

integer proc TickCounter(var integer Midnight)
        _AX = 0
        intr(_FLAGS, 0x1A)
        MidNight = (_AX & 0x0000FFFF)
        return((_CX shl 16) | _DX)
end

integer proc TickDelta(integer StartCount)
        integer EndCount, MidNight, Delta
        EndCount=TickCounter(Midnight)
        if MidNight > 0
                Delta = ((MidNight*TicksPerDay) - StartCount + EndCount)
           else
                Delta = (EndCount - StartCount)
        endif
        return(Delta)
end


integer proc TicksToSeconds(integer ticks)
        return((Ticks * 1000) / 18206)
end


integer proc TickstoMs(integer ticks)
        return((Ticks*54925) / 1000)
end


integer proc TimeDosCmd(string cmd)
        integer Startticks, Midnight
        StartTicks = TickCounter(Midnight)
        Dos(Cmd,_DONT_PROMPT_)
        return(TickDelta(StartTicks))
end

integer proc TimeTseMacro(string macro)
        integer Startticks, Midnight
           StartTicks = TickCounter(Midnight)
        if not ExecMacro(macro)
           warn(macro,' not was not found')
        endif
        return(TickDelta(StartTicks))
end

proc ReportTimes(integer ticks)
    warn(ticks, ' ticks')
    warn(TicksToSeconds(ticks),' seconds')
    warn(TicksToMs(ticks), ' milliseconds')
end


