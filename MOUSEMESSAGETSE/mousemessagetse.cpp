//
// https://learn.microsoft.com/en-us/windows/win32/learnwin32/writing-the-window-procedure [Writing the Window Procedure] [kn, ri, we, 21-12-2022 02:09:08]
//
#include <windows.h>
//
LRESULT CALLBACK WindowProc( HWND hwnd, UINT uMsg, WPARAM wParam, LPARAM lParam ) {
 switch ( uMsg ) {
  //
  case WM_SIZE: {
   //
   int width = LOWORD( lParam ); // Macro to get the low-order word.
   int height = HIWORD( lParam ); // Macro to get the high-order word.
   //
   // Respond to the message:
   //
  }
  break;
 }
}
//
void main() {
}
