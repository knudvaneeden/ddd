//
// ===
//
// How to simulate Scroll Wheel in C/C++ | Mouse Scroll Simulation | Easy Programming
// https://www.youtube.com/watch?v=6pC8L_AhmS0
//
// ===
//
// mouse_event function (winuser.h)
// https://learn.microsoft.com/en-us/windows/win32/api/winuser/nf-winuser-mouse_event
//
// ===
//
#include <iostream>
//
#include <conio.h>
//
#include <windows.h>
//
using namespace std;
//
#define MOUSEEVENTF_HWHEEL 0x01000
//
int main() {
 //
 while ( 1 )
  //
  // rotate mouse wheel up
  // mouse_event( MOUSEEVENTF_WHEEL, 0, 0, 1 * 120, 0 );
  //
  // ===
  //
  // rotate mouse wheel down
  // mouse_event( MOUSEEVENTF_WHEEL, 0, 0, -1 * 120, 0 );
  //
  // ===
  //
  // tilt mouse wheel left
  mouse_event( MOUSEEVENTF_HWHEEL, 0, 0, 1 * 120, 0 );
  //
  // ===
  //
  // tilt mouse wheel right
  // mouse_event( ( MOUSEEVENTF_HWHEEL, 0, 0, -1 * 120, 0 );
  //
 }
