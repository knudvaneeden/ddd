/************************************************************************
  Macro:   $?M??? (TSE Edition)

  Author:  Luca SALViNi  (2:332/407.96@Fidonet.org)

  Date:    08/19/93   v1.0

  Description:

  Delirio estivo

  Usage:

  <Crl S> <S>      Toggle symbol mode

  Installation:

  Add Symbol.s into directory tse\ui\

  Add in tse.s the line:

  #include ["symbol.s"]
 ************************************************************************/

integer symbolize   = 0

keydef symbol
       <a>     Inserttext('?')
       <b>     Inserttext('?')
       <c>     Inserttext('?')
       <d>     Inserttext('?')
       <e>     Inserttext('?')
       <f>     Inserttext('?')
       <g>     Inserttext('?')
       <h>     Inserttext('?')
       <i>     Inserttext('?')
       <j>     Inserttext('?')
       <k>     Inserttext('K')
       <l>     Inserttext('?')
       <m>     Inserttext('M')
       <n>     Inserttext('?')
       <o>     Inserttext('?')
       <p>     Inserttext('?')
       <q>     Inserttext('?')
       <r>     Inserttext('?')
       <s>     Inserttext('$')
       <t>     Inserttext('?')
       <u>     Inserttext('?')
       <v>     Inserttext('?')
       <w>     Inserttext('W')
       <x>     Inserttext('*')
       <y>     Inserttext('?')
       <z>     Inserttext('%')

       <Shift a>     Inserttext('?')
       <Shift b>     Inserttext('?')
       <Shift c>     Inserttext('?')
       <Shift d>     Inserttext('?')
       <Shift e>     Inserttext('?')
       <Shift f>     Inserttext('?')
       <Shift g>     Inserttext('?')
       <Shift h>     Inserttext('?')
       <Shift i>     Inserttext('?')
       <Shift j>     Inserttext('?')
       <Shift k>     Inserttext('K')
       <Shift l>     Inserttext('?')
       <Shift m>     Inserttext('M')
       <Shift n>     Inserttext('?')
       <Shift o>     Inserttext('?')
       <Shift p>     Inserttext('?')
       <Shift q>     Inserttext('?')
       <Shift r>     Inserttext('?')
       <Shift s>     Inserttext('$')
       <Shift t>     Inserttext('?')
       <Shift u>     Inserttext('?')
       <Shift v>     Inserttext('?')
       <Shift w>     Inserttext('W')
       <Shift x>     Inserttext('*')
       <Shift y>     Inserttext('?')
       <Shift z>     Inserttext('%')
end

proc Sym()
    symbolize = not symbolize
    if symbolize
        Enable(symbol)
    else
        Disable(symbol)
    endif
end

<Ctrl S> <S>  Sym()
