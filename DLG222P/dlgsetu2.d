dialog  0               1  1  1 80 24 "Dialog Color Editor"
#include "dlgsetu2.si"
#include "dialog.si"
frame   0               1  3  2 23 14 "Control &Types"
list    ID_LST_CONTROL  1  4  3 21 13 "","List of configurable control types"
vscroll 0               1 21  3 22 13 ""
frame   0               1  3 15 23 22 "Control &Colors"
list    ID_LST_CLRTYPE  1  4 16 21 21 "","List of colors used by current control type"
vscroll 0               1 21 16 22 21 ""
frame   ID_FRM_COLORS   1 25  2 59 22 "Color &Panel"
control ID_CTL_COLORS   1 26  3 58 21 "","Available screen colors. Use cursor keys or mouse to select."
ltext   0               1 62 15 69 16 "Attr"
rtext   ID_TXT_HEX      1 69 15 71 16 "0"
rtext   ID_TXT_DEC      1 73 15 76 16 "0"
frame   0               1 61 17 77 22 "Example"
control ID_CTL_EXAMPLE  0 62 18 76 21 ""
group
defbtn  ID_OK           1 62  3 76  4 "O&k","Accept changes and close dialog"
button  ID_CANCEL       1 62  5 76  6 "Cancel","Abort changes"
button  ID_BTN_APPLY    1 62  7 76  8 "&Apply","Send changes to dialog library. Update display."
button  ID_HELP         1 62  9 76 10 "Help","Help screen"
group
