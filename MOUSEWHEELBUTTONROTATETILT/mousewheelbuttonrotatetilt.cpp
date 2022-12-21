//
// How to detect Mouse Scroll Events in C/C++ | Easy Programming
// [ Internet: source: https://www.youtube.com/watch?v=Kp0fwR1lk8g ]
//
#pragma ones
//
#include <windows.h>
//
#include <ctime>
//
#include <iostream>
//
#include <conio.h>
//
using namespace std;
//
HHOOK mh;
//
int delta = 0;
//
LRESULT CALLBACK Mouse( int nCode, WPARAM wParam, LPARAM lParam ) {
 //
 if ( nCode < 0 ) {
  //
  return CallNextHookEx( mh, nCode, wParam, lParam );
  //
 }
 //
 MSLLHOOKSTRUCT* pMouseStruct = ( MSLLHOOKSTRUCT* ) lParam;
 //
 if ( pMouseStruct != NULL ) {
  //
  if ( wParam == WM_MOUSEWHEEL ) {
   //
   if ( HIWORD( pMouseStruct->mouseData ) == 120 ) {
    //
    delta = 1;
    //
   }
   else {
    //
    delta = -1;
    //
   }
  }
  //
  else if ( wParam == WM_MOUSEHWHEEL ) {
   //
   if ( HIWORD( pMouseStruct->mouseData ) == 120 ) {
    //
    delta = 2;
    //
   }
   else {
    //
    delta = -2;
    //
   }
  }
  else if ( wParam == WM_LBUTTONUP ) {
   //
   delta = 3;
   //
  }
  //
  else if ( wParam == WM_LBUTTONDOWN ) {
   //
   delta = 4;
   //
  }
  //
  else if ( wParam == WM_RBUTTONUP ) {
   //
   delta = 5;
   //
  }
  //
  else if ( wParam == WM_RBUTTONDOWN ) {
   //
   delta = 6;
   //
  }
  //
  else if ( wParam == WM_MBUTTONUP ) {
   //
   delta = 7;
   //
  }
  //
  else if ( wParam == WM_MBUTTONDOWN ) {
   //
   delta = 8;
   //
  }
  //
  else if ( wParam == WM_XBUTTONUP ) {
   //
   delta = 9;
   //
  }
  //
  else if ( wParam == WM_XBUTTONDOWN ) {
   //
   delta = 10;
   //
  }
  //
  else {
   //
   delta = 0;
   //
  }
 }
 //
 return CallNextHookEx( mh, nCode, wParam, lParam );
 //
}
//
int GetScrollDelta() {
 //
 delta = 0;
 //
 if ( ! ( mh = SetWindowsHookExA( WH_MOUSE_LL, Mouse, NULL, 0 ) ) ) {
  //
  delta = -404;
  //
 }
 //
 MSG message;
 //
 bool peek = true;
 //
 long tm = time( 0 );
 //
 while (peek) {
  //
  PeekMessage( &message, NULL, 0, 0, PM_REMOVE );
  //
  if ( !delta == 0 || tm < time( 0 ) ) {
   //
   peek = false;
   //
  }
 }
 //
 UnhookWindowsHookEx( mh );
 //
 return delta;
 //
}
//
int main() {
 //
 // while true
 //
 while ( 1 ) {
  //
  int d = GetScrollDelta();
  //
  if ( d == -1 ) {
   //
   cout << "ROTATE DOWN (WheelDown)" << endl;
   //
  }
  //
  else if ( d == 1 ) {
   //
   cout << "ROTATE UP (WheelUp)" << endl;
   //
  }
  //
  else if ( d == 2 ) {
   //
   cout << "TILT RIGHT (WheelRight)" << endl;
   //
  }
  //
  else if ( d == -2 ) {
   //
   cout << "TILT LEFT (WheelLeft)" << endl;
   //
  }
  //
  else if ( d == 3 ) {
   //
   cout << "BUTTON LEFT UP (LeftBtn up)" << endl;
   //
  }
  //
  else if ( d == 4 ) {
   //
   cout << "BUTTON LEFT DOWN (LeftBtn down)" << endl;
   //
  }
  //
  else if ( d == 5 ) {
   //
   cout << "BUTTON RIGHT UP (RightBtn up)" << endl;
   //
  }
  //
  else if ( d == 6 ) {
   //
   cout << "BUTTON RIGHT DOWN (RightBtn down)" << endl;
   //
  }
  //
  else if ( d == 7 ) {
   //
   cout << "BUTTON CENTER UP (CenterBtn up)" << endl;
   //
  }
  //
  else if ( d == 8 ) {
   //
   cout << "BUTTON CENTER DOWN (CenterBtn down)" << endl;
   //
  }
  //
  else if ( d == 9 ) {
   //
   cout << "XBUTTON1 OR XBUTTON2 UP (UpBtn or DownBtn up)" << endl;
   //
  }
  //
  else if ( d == 10 ) {
   //
   cout << "XBUTTON1 OR XBUTTON2 Down (UpBtn or DownBtn down)" << endl;
   //
  }
  //
  else {
   //
   cout << d << endl;
  }
 }
}
