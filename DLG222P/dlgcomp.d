dialog  0               1  9  6 72 17 "Compare Files"
#include "dlgcomp.si"
#include "dialog.si"
ltext   0               1  4  2 11  3 "File &1"
edit    ID_EDT_FILE1    1  4  3 40  9 ""
open    0               1 40  3 43  4 ""
ltext   0               1  4  5 11  6 "File &2"
edit    ID_EDT_FILE2    1  4  6 40 12 ""
open    0               1 40  6 43  7 ""
group
defbtn  ID_OK           1 47  2 59  3 "&Compare"
button  ID_CANCEL       1 47  4 59  5 "Cancel"
button  ID_BTN_SEARCH   1 47  6 59  7 "&Search"
button  ID_HELP         1 47  8 59  9 "Help"
group
