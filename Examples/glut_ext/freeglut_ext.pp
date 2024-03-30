
unit freeglut_ext;
interface

{
  Automatically converted by H2Pas 1.0.0 from freeglut_ext.h
  The following command line parameters were used:
    -p
    -T
    -d
    -c
    -e
    freeglut_ext.h
}

{ Pointers to basic pascal types, inserted by h2pas conversion program.}
Type
  PLongint  = ^Longint;
  PSmallInt = ^SmallInt;
  PByte     = ^Byte;
  PWord     = ^Word;
  PDWord    = ^DWord;
  PDouble   = ^Double;

Type
Pbyte  = ^byte;
Pchar  = ^char;
Plongint  = ^longint;
Psingle  = ^single;
{$IFDEF FPC}
{$PACKRECORDS C}
{$ENDIF}


{$ifndef  __FREEGLUT_EXT_H__}
{$define __FREEGLUT_EXT_H__}
{
 * freeglut_ext.h
 *
 * The non-GLUT-compatible extensions to the freeglut library include file
 *
 * Copyright (c) 1999-2000 Pawel W. Olszta. All Rights Reserved.
 * Written by Pawel W. Olszta, <olszta@sourceforge.net>
 * Creation date: Thu Dec 2 1999
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included
 * in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
 * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
 * PAWEL W. OLSZTA BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
 * IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
  }
{
 * Additional GLUT Key definitions for the Special key function
  }

const
  GLUT_KEY_NUM_LOCK = $006D;  
  GLUT_KEY_BEGIN = $006E;  
  GLUT_KEY_DELETE = $006F;  
  GLUT_KEY_SHIFT_L = $0070;  
  GLUT_KEY_SHIFT_R = $0071;  
  GLUT_KEY_CTRL_L = $0072;  
  GLUT_KEY_CTRL_R = $0073;  
  GLUT_KEY_ALT_L = $0074;  
  GLUT_KEY_ALT_R = $0075;  
{
 * GLUT API Extension macro definitions -- behaviour when the user clicks on an "x" to close a window
  }
  GLUT_ACTION_EXIT = 0;  
  GLUT_ACTION_GLUTMAINLOOP_RETURNS = 1;  
  GLUT_ACTION_CONTINUE_EXECUTION = 2;  
{
 * Create a new rendering context when the user opens a new window?
  }
  GLUT_CREATE_NEW_CONTEXT = 0;  
  GLUT_USE_CURRENT_CONTEXT = 1;  
{
 * Direct/Indirect rendering context options (has meaning only in Unix/X11)
  }
  GLUT_FORCE_INDIRECT_CONTEXT = 0;  
  GLUT_ALLOW_DIRECT_CONTEXT = 1;  
  GLUT_TRY_DIRECT_CONTEXT = 2;  
  GLUT_FORCE_DIRECT_CONTEXT = 3;  
{
 * GLUT API Extension macro definitions -- the glutGet parameters
  }
  GLUT_INIT_STATE = $007C;  
  GLUT_ACTION_ON_WINDOW_CLOSE = $01F9;  
  GLUT_WINDOW_BORDER_WIDTH = $01FA;  
  GLUT_WINDOW_BORDER_HEIGHT = $01FB;  
{ Docs say it should always have been GLUT_WINDOW_BORDER_HEIGHT, keep this for backward compatibility  }
  GLUT_WINDOW_HEADER_HEIGHT = $01FB;  
  GLUT_VERSION = $01FC;  
  GLUT_RENDERING_CONTEXT = $01FD;  
  GLUT_DIRECT_RENDERING = $01FE;  
  GLUT_FULL_SCREEN = $01FF;  
  GLUT_SKIP_STALE_MOTION_EVENTS = $0204;  
{
 * New tokens for glutInitDisplayMode.
 * Only one GLUT_AUXn bit may be used at a time.
 * Value 0x0400 is defined in OpenGLUT.
  }
  GLUT_AUX = $1000;  
  GLUT_AUX1 = $1000;  
  GLUT_AUX2 = $2000;  
  GLUT_AUX3 = $4000;  
  GLUT_AUX4 = $8000;  
{
 * Context-related flags, see freeglut_state.c
  }
  GLUT_INIT_MAJOR_VERSION = $0200;  
  GLUT_INIT_MINOR_VERSION = $0201;  
  GLUT_INIT_FLAGS = $0202;  
  GLUT_INIT_PROFILE = $0203;  
{
 * Flags for glutInitContextFlags, see freeglut_init.c
  }
  GLUT_DEBUG = $0001;  
  GLUT_FORWARD_COMPATIBLE = $0002;  
{
 * Flags for glutInitContextProfile, see freeglut_init.c
  }
  GLUT_CORE_PROFILE = $0001;  
  GLUT_COMPATIBILITY_PROFILE = $0002;  
{
 * Process loop function, see freeglut_main.c
  }

procedure glutMainLoopEvent;cdecl;external;
procedure glutLeaveMainLoop;cdecl;external;
procedure glutExit;cdecl;external;
{
 * Window management functions, see freeglut_window.c
  }
procedure glutFullScreenToggle;cdecl;external;
procedure glutLeaveFullScreen;cdecl;external;
{
 * Window-specific callback functions, see freeglut_callbacks.c
  }
procedure glutMouseWheelFunc(callback:procedure (para1:longint; para2:longint; para3:longint; para4:longint));cdecl;external;
procedure glutCloseFunc(callback:procedure );cdecl;external;
procedure glutWMCloseFunc(callback:procedure );cdecl;external;
{ A. Donev: Also a destruction callback for menus  }
procedure glutMenuDestroyFunc(callback:procedure );cdecl;external;
{
 * State setting and retrieval functions, see freeglut_state.c
  }
procedure glutSetOption(option_flag:TGLenum; value:longint);cdecl;external;
function glutGetModeValues(mode:TGLenum; size:Plongint):Plongint;cdecl;external;
{ A.Donev: User-data manipulation  }
function glutGetWindowData:pointer;cdecl;external;
procedure glutSetWindowData(data:pointer);cdecl;external;
function glutGetMenuData:pointer;cdecl;external;
procedure glutSetMenuData(data:pointer);cdecl;external;
{
 * Font stuff, see freeglut_font.c
  }
function glutBitmapHeight(font:pointer):longint;cdecl;external;
function glutStrokeHeight(font:pointer):TGLfloat;cdecl;external;
(* Const before type ignored *)
procedure glutBitmapString(font:pointer; _string:Pbyte);cdecl;external;
(* Const before type ignored *)
procedure glutStrokeString(font:pointer; _string:Pbyte);cdecl;external;
{
 * Geometry functions, see freeglut_geometry.c
  }
procedure glutWireRhombicDodecahedron;cdecl;external;
procedure glutSolidRhombicDodecahedron;cdecl;external;
procedure glutWireSierpinskiSponge(num_levels:longint; offset:array[0..2] of TGLdouble; scale:TGLdouble);cdecl;external;
procedure glutSolidSierpinskiSponge(num_levels:longint; offset:array[0..2] of TGLdouble; scale:TGLdouble);cdecl;external;
procedure glutWireCylinder(radius:TGLdouble; height:TGLdouble; slices:TGLint; stacks:TGLint);cdecl;external;
procedure glutSolidCylinder(radius:TGLdouble; height:TGLdouble; slices:TGLint; stacks:TGLint);cdecl;external;
{
 * Extension functions, see freeglut_ext.c
  }
type

  TGLUTproc = procedure ;cdecl;
(* Const before type ignored *)

function glutGetProcAddress(procName:Pchar):TGLUTproc;cdecl;external;
{
 * Multi-touch/multi-pointer extensions
  }
const
  GLUT_HAS_MULTI = 1;  

procedure glutMultiFunc(callback:procedure (para1:longint; para2:longint));cdecl;external;
procedure glutMultiButtonFunc(callback:procedure (para1:longint; para2:longint; para3:longint; para4:longint; para5:longint));cdecl;external;
procedure glutMultiMotionFunc(callback:procedure (para1:longint; para2:longint; para3:longint));cdecl;external;
procedure glutMultiPassiveFunc(callback:procedure (para1:longint; para2:longint; para3:longint));cdecl;external;
{
 * Joystick functions, see freeglut_joystick.c
  }
{ USE OF THESE FUNCTIONS IS DEPRECATED !!!!!  }
{ If you have a serious need for these functions in your application, please either
 * contact the "freeglut" developer community at freeglut-developer@lists.sourceforge.net,
 * switch to the OpenGLUT library, or else port your joystick functionality over to PLIB's
 * "js" library.
  }
function glutJoystickGetNumAxes(ident:longint):longint;cdecl;external;
function glutJoystickGetNumButtons(ident:longint):longint;cdecl;external;
function glutJoystickNotWorking(ident:longint):longint;cdecl;external;
function glutJoystickGetDeadBand(ident:longint; axis:longint):single;cdecl;external;
procedure glutJoystickSetDeadBand(ident:longint; axis:longint; db:single);cdecl;external;
function glutJoystickGetSaturation(ident:longint; axis:longint):single;cdecl;external;
procedure glutJoystickSetSaturation(ident:longint; axis:longint; st:single);cdecl;external;
procedure glutJoystickSetMinRange(ident:longint; axes:Psingle);cdecl;external;
procedure glutJoystickSetMaxRange(ident:longint; axes:Psingle);cdecl;external;
procedure glutJoystickSetCenter(ident:longint; axes:Psingle);cdecl;external;
procedure glutJoystickGetMinRange(ident:longint; axes:Psingle);cdecl;external;
procedure glutJoystickGetMaxRange(ident:longint; axes:Psingle);cdecl;external;
procedure glutJoystickGetCenter(ident:longint; axes:Psingle);cdecl;external;
{
 * Initialization functions, see freeglut_init.c
  }
procedure glutInitContextVersion(majorVersion:longint; minorVersion:longint);cdecl;external;
procedure glutInitContextFlags(flags:longint);cdecl;external;
procedure glutInitContextProfile(profile:longint);cdecl;external;
{ to get the typedef for va_list  }
{$include <stdarg.h>}
(* Const before type ignored *)

procedure glutInitErrorFunc(vError:procedure (fmt:Pchar; ap:Tva_list));cdecl;external;
(* Const before type ignored *)
procedure glutInitWarningFunc(vWarning:procedure (fmt:Pchar; ap:Tva_list));cdecl;external;
{
 * GLUT API macro definitions -- the display mode definitions
  }
const
  GLUT_CAPTIONLESS = $0400;  
  GLUT_BORDERLESS = $0800;  
  GLUT_SRGB = $1000;  
{** END OF FILE ** }
{$endif}
{ __FREEGLUT_EXT_H__  }

implementation


end.
