
unit freeglut_std;
interface

{
  Automatically converted by H2Pas 1.0.0 from freeglut_std.h
  The following command line parameters were used:
    -p
    -T
    -d
    -c
    -e
    freeglut_std.h
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
{$IFDEF FPC}
{$PACKRECORDS C}
{$ENDIF}


{$ifndef  __FREEGLUT_STD_H__}
{$define __FREEGLUT_STD_H__}
{
 * freeglut_std.h
 *
 * The GLUT-compatible part of the freeglut library include file
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
 * Under windows, we have to differentiate between static and dynamic libraries
  }
{$ifdef _WIN32}
{ #pragma may not be supported by some compilers.
 * Discussion by FreeGLUT developers suggests that
 * Visual C++ specific code involving pragmas may
 * need to move to a separate header.  24th Dec 2003
  }
{ Define FREEGLUT_LIB_PRAGMAS to 1 to include library
 * pragmas or to 0 to exclude library pragmas.
 * The default behavior depends on the compiler/platform.
  }
{$ifndef FREEGLUT_LIB_PRAGMAS}
{$if ( defined(_MSC_VER) || defined(__WATCOMC__) ) && !defined(_WIN32_WCE)}

const
  FREEGLUT_LIB_PRAGMAS = 1;  
{$else}

const
  FREEGLUT_LIB_PRAGMAS = 0;  
{$endif}
{$endif}
{$ifndef WIN32_LEAN_AND_MEAN}

const
  WIN32_LEAN_AND_MEAN = 1;  
{$endif}
{$ifndef NOMINMAX}
{$define NOMINMAX}
{$endif}
{$include <windows.h>}
{ Drag in other Windows libraries as required by FreeGLUT  }
{$if FREEGLUT_LIB_PRAGMAS}
(** unsupported pragma#pragma comment (lib, "glu32.lib")    /* link OpenGL Utility lib     */*)
(** unsupported pragma#pragma comment (lib, "opengl32.lib") /* link Microsoft OpenGL lib   */*)
(** unsupported pragma#pragma comment (lib, "gdi32.lib")    /* link Windows GDI lib        */*)
(** unsupported pragma#pragma comment (lib, "winmm.lib")    /* link Windows MultiMedia lib */*)
(** unsupported pragma#pragma comment (lib, "user32.lib")   /* link Windows user lib       */*)
{$endif}
{$else}
{$endif}
{
 * The freeglut and GLUT API versions
  }

const
  FREEGLUT = 1;  
  GLUT_API_VERSION = 4;  
  GLUT_XLIB_IMPLEMENTATION = 13;  
{ Deprecated:
   cf. http://sourceforge.net/mailarchive/forum.php?thread_name=CABcAi1hw7cr4xtigckaGXB5X8wddLfMcbA_rZ3NAuwMrX_zmsw%40mail.gmail.com&forum_name=freeglut-developer  }
  FREEGLUT_VERSION_2_0 = 1;  
{
 * Always include OpenGL and GLU headers
  }
{ Note: FREEGLUT_GLES is only used to cleanly bootstrap headers
   inclusion here; use GLES constants directly
   (e.g. GL_ES_VERSION_2_0) for all other needs  }
{$ifdef FREEGLUT_GLES}
{$include <EGL/egl.h>}
{$include <GLES/gl.h>}
{$include <GLES2/gl2.h>}
(*** was #elif ****){$else __APPLE__}
{$include <OpenGL/gl.h>}
{$include <OpenGL/glu.h>}
{$else}
{$include <GL/gl.h>}
{$include <GL/glu.h>}
{$endif}
{
 * GLUT API macro definitions -- the special key codes:
  }

const
  GLUT_KEY_F1 = $0001;  
  GLUT_KEY_F2 = $0002;  
  GLUT_KEY_F3 = $0003;  
  GLUT_KEY_F4 = $0004;  
  GLUT_KEY_F5 = $0005;  
  GLUT_KEY_F6 = $0006;  
  GLUT_KEY_F7 = $0007;  
  GLUT_KEY_F8 = $0008;  
  GLUT_KEY_F9 = $0009;  
  GLUT_KEY_F10 = $000A;  
  GLUT_KEY_F11 = $000B;  
  GLUT_KEY_F12 = $000C;  
  GLUT_KEY_LEFT = $0064;  
  GLUT_KEY_UP = $0065;  
  GLUT_KEY_RIGHT = $0066;  
  GLUT_KEY_DOWN = $0067;  
  GLUT_KEY_PAGE_UP = $0068;  
  GLUT_KEY_PAGE_DOWN = $0069;  
  GLUT_KEY_HOME = $006A;  
  GLUT_KEY_END = $006B;  
  GLUT_KEY_INSERT = $006C;  
{
 * GLUT API macro definitions -- mouse state definitions
  }
  GLUT_LEFT_BUTTON = $0000;  
  GLUT_MIDDLE_BUTTON = $0001;  
  GLUT_RIGHT_BUTTON = $0002;  
  GLUT_DOWN = $0000;  
  GLUT_UP = $0001;  
  GLUT_LEFT = $0000;  
  GLUT_ENTERED = $0001;  
{
 * GLUT API macro definitions -- the display mode definitions
  }
  GLUT_RGB = $0000;  
  GLUT_RGBA = $0000;  
  GLUT_INDEX = $0001;  
  GLUT_SINGLE = $0000;  
  GLUT_DOUBLE = $0002;  
  GLUT_ACCUM = $0004;  
  GLUT_ALPHA = $0008;  
  GLUT_DEPTH = $0010;  
  GLUT_STENCIL = $0020;  
  GLUT_MULTISAMPLE = $0080;  
  GLUT_STEREO = $0100;  
  GLUT_LUMINANCE = $0200;  
{
 * GLUT API macro definitions -- windows and menu related definitions
  }
  GLUT_MENU_NOT_IN_USE = $0000;  
  GLUT_MENU_IN_USE = $0001;  
  GLUT_NOT_VISIBLE = $0000;  
  GLUT_VISIBLE = $0001;  
  GLUT_HIDDEN = $0000;  
  GLUT_FULLY_RETAINED = $0001;  
  GLUT_PARTIALLY_RETAINED = $0002;  
  GLUT_FULLY_COVERED = $0003;  
{
 * GLUT API macro definitions -- fonts definitions
 *
 * Steve Baker suggested to make it binary compatible with GLUT:
  }
{$if defined(_MSC_VER) || defined(__CYGWIN__) || defined(__MINGW32__) || defined(__WATCOMC__)}

{ was #define dname def_expr }
function GLUT_STROKE_ROMAN : pointer;  

{ was #define dname def_expr }
function GLUT_STROKE_MONO_ROMAN : pointer;  

{ was #define dname def_expr }
function GLUT_BITMAP_9_BY_15 : pointer;  

{ was #define dname def_expr }
function GLUT_BITMAP_8_BY_13 : pointer;  

{ was #define dname def_expr }
function GLUT_BITMAP_TIMES_ROMAN_10 : pointer;  

{ was #define dname def_expr }
function GLUT_BITMAP_TIMES_ROMAN_24 : pointer;  

{ was #define dname def_expr }
function GLUT_BITMAP_HELVETICA_10 : pointer;  

{ was #define dname def_expr }
function GLUT_BITMAP_HELVETICA_12 : pointer;  

{ was #define dname def_expr }
function GLUT_BITMAP_HELVETICA_18 : pointer;  

{$else}
{
     * I don't really know if it's a good idea... But here it goes:
      }
  var
    glutStrokeRoman : pointer;cvar;external;
    glutStrokeMonoRoman : pointer;cvar;external;
    glutBitmap9By15 : pointer;cvar;external;
    glutBitmap8By13 : pointer;cvar;external;
    glutBitmapTimesRoman10 : pointer;cvar;external;
    glutBitmapTimesRoman24 : pointer;cvar;external;
    glutBitmapHelvetica10 : pointer;cvar;external;
    glutBitmapHelvetica12 : pointer;cvar;external;
    glutBitmapHelvetica18 : pointer;cvar;external;
{
     * Those pointers will be used by following definitions:
      }

{ was #define dname def_expr }
function GLUT_STROKE_ROMAN : pointer;  

{ was #define dname def_expr }
function GLUT_STROKE_MONO_ROMAN : pointer;  

{ was #define dname def_expr }
function GLUT_BITMAP_9_BY_15 : pointer;  

{ was #define dname def_expr }
function GLUT_BITMAP_8_BY_13 : pointer;  

{ was #define dname def_expr }
function GLUT_BITMAP_TIMES_ROMAN_10 : pointer;  

{ was #define dname def_expr }
function GLUT_BITMAP_TIMES_ROMAN_24 : pointer;  

{ was #define dname def_expr }
function GLUT_BITMAP_HELVETICA_10 : pointer;  

{ was #define dname def_expr }
function GLUT_BITMAP_HELVETICA_12 : pointer;  

{ was #define dname def_expr }
function GLUT_BITMAP_HELVETICA_18 : pointer;  

{$endif}
{
 * GLUT API macro definitions -- the glutGet parameters
  }

const
  GLUT_WINDOW_X = $0064;  
  GLUT_WINDOW_Y = $0065;  
  GLUT_WINDOW_WIDTH = $0066;  
  GLUT_WINDOW_HEIGHT = $0067;  
  GLUT_WINDOW_BUFFER_SIZE = $0068;  
  GLUT_WINDOW_STENCIL_SIZE = $0069;  
  GLUT_WINDOW_DEPTH_SIZE = $006A;  
  GLUT_WINDOW_RED_SIZE = $006B;  
  GLUT_WINDOW_GREEN_SIZE = $006C;  
  GLUT_WINDOW_BLUE_SIZE = $006D;  
  GLUT_WINDOW_ALPHA_SIZE = $006E;  
  GLUT_WINDOW_ACCUM_RED_SIZE = $006F;  
  GLUT_WINDOW_ACCUM_GREEN_SIZE = $0070;  
  GLUT_WINDOW_ACCUM_BLUE_SIZE = $0071;  
  GLUT_WINDOW_ACCUM_ALPHA_SIZE = $0072;  
  GLUT_WINDOW_DOUBLEBUFFER = $0073;  
  GLUT_WINDOW_RGBA = $0074;  
  GLUT_WINDOW_PARENT = $0075;  
  GLUT_WINDOW_NUM_CHILDREN = $0076;  
  GLUT_WINDOW_COLORMAP_SIZE = $0077;  
  GLUT_WINDOW_NUM_SAMPLES = $0078;  
  GLUT_WINDOW_STEREO = $0079;  
  GLUT_WINDOW_CURSOR = $007A;  
  GLUT_SCREEN_WIDTH = $00C8;  
  GLUT_SCREEN_HEIGHT = $00C9;  
  GLUT_SCREEN_WIDTH_MM = $00CA;  
  GLUT_SCREEN_HEIGHT_MM = $00CB;  
  GLUT_MENU_NUM_ITEMS = $012C;  
  GLUT_DISPLAY_MODE_POSSIBLE = $0190;  
  GLUT_INIT_WINDOW_X = $01F4;  
  GLUT_INIT_WINDOW_Y = $01F5;  
  GLUT_INIT_WINDOW_WIDTH = $01F6;  
  GLUT_INIT_WINDOW_HEIGHT = $01F7;  
  GLUT_INIT_DISPLAY_MODE = $01F8;  
  GLUT_ELAPSED_TIME = $02BC;  
  GLUT_WINDOW_FORMAT_ID = $007B;  
{
 * GLUT API macro definitions -- the glutDeviceGet parameters
  }
  GLUT_HAS_KEYBOARD = $0258;  
  GLUT_HAS_MOUSE = $0259;  
  GLUT_HAS_SPACEBALL = $025A;  
  GLUT_HAS_DIAL_AND_BUTTON_BOX = $025B;  
  GLUT_HAS_TABLET = $025C;  
  GLUT_NUM_MOUSE_BUTTONS = $025D;  
  GLUT_NUM_SPACEBALL_BUTTONS = $025E;  
  GLUT_NUM_BUTTON_BOX_BUTTONS = $025F;  
  GLUT_NUM_DIALS = $0260;  
  GLUT_NUM_TABLET_BUTTONS = $0261;  
  GLUT_DEVICE_IGNORE_KEY_REPEAT = $0262;  
  GLUT_DEVICE_KEY_REPEAT = $0263;  
  GLUT_HAS_JOYSTICK = $0264;  
  GLUT_OWNS_JOYSTICK = $0265;  
  GLUT_JOYSTICK_BUTTONS = $0266;  
  GLUT_JOYSTICK_AXES = $0267;  
  GLUT_JOYSTICK_POLL_RATE = $0268;  
{
 * GLUT API macro definitions -- the glutLayerGet parameters
  }
  GLUT_OVERLAY_POSSIBLE = $0320;  
  GLUT_LAYER_IN_USE = $0321;  
  GLUT_HAS_OVERLAY = $0322;  
  GLUT_TRANSPARENT_INDEX = $0323;  
  GLUT_NORMAL_DAMAGED = $0324;  
  GLUT_OVERLAY_DAMAGED = $0325;  
{
 * GLUT API macro definitions -- the glutVideoResizeGet parameters
  }
  GLUT_VIDEO_RESIZE_POSSIBLE = $0384;  
  GLUT_VIDEO_RESIZE_IN_USE = $0385;  
  GLUT_VIDEO_RESIZE_X_DELTA = $0386;  
  GLUT_VIDEO_RESIZE_Y_DELTA = $0387;  
  GLUT_VIDEO_RESIZE_WIDTH_DELTA = $0388;  
  GLUT_VIDEO_RESIZE_HEIGHT_DELTA = $0389;  
  GLUT_VIDEO_RESIZE_X = $038A;  
  GLUT_VIDEO_RESIZE_Y = $038B;  
  GLUT_VIDEO_RESIZE_WIDTH = $038C;  
  GLUT_VIDEO_RESIZE_HEIGHT = $038D;  
{
 * GLUT API macro definitions -- the glutUseLayer parameters
  }
  GLUT_NORMAL = $0000;  
  GLUT_OVERLAY = $0001;  
{
 * GLUT API macro definitions -- the glutGetModifiers parameters
  }
  GLUT_ACTIVE_SHIFT = $0001;  
  GLUT_ACTIVE_CTRL = $0002;  
  GLUT_ACTIVE_ALT = $0004;  
{
 * GLUT API macro definitions -- the glutSetCursor parameters
  }
  GLUT_CURSOR_RIGHT_ARROW = $0000;  
  GLUT_CURSOR_LEFT_ARROW = $0001;  
  GLUT_CURSOR_INFO = $0002;  
  GLUT_CURSOR_DESTROY = $0003;  
  GLUT_CURSOR_HELP = $0004;  
  GLUT_CURSOR_CYCLE = $0005;  
  GLUT_CURSOR_SPRAY = $0006;  
  GLUT_CURSOR_WAIT = $0007;  
  GLUT_CURSOR_TEXT = $0008;  
  GLUT_CURSOR_CROSSHAIR = $0009;  
  GLUT_CURSOR_UP_DOWN = $000A;  
  GLUT_CURSOR_LEFT_RIGHT = $000B;  
  GLUT_CURSOR_TOP_SIDE = $000C;  
  GLUT_CURSOR_BOTTOM_SIDE = $000D;  
  GLUT_CURSOR_LEFT_SIDE = $000E;  
  GLUT_CURSOR_RIGHT_SIDE = $000F;  
  GLUT_CURSOR_TOP_LEFT_CORNER = $0010;  
  GLUT_CURSOR_TOP_RIGHT_CORNER = $0011;  
  GLUT_CURSOR_BOTTOM_RIGHT_CORNER = $0012;  
  GLUT_CURSOR_BOTTOM_LEFT_CORNER = $0013;  
  GLUT_CURSOR_INHERIT = $0064;  
  GLUT_CURSOR_NONE = $0065;  
  GLUT_CURSOR_FULL_CROSSHAIR = $0066;  
{
 * GLUT API macro definitions -- RGB color component specification definitions
  }
  GLUT_RED = $0000;  
  GLUT_GREEN = $0001;  
  GLUT_BLUE = $0002;  
{
 * GLUT API macro definitions -- additional keyboard and joystick definitions
  }
  GLUT_KEY_REPEAT_OFF = $0000;  
  GLUT_KEY_REPEAT_ON = $0001;  
  GLUT_KEY_REPEAT_DEFAULT = $0002;  
  GLUT_JOYSTICK_BUTTON_A = $0001;  
  GLUT_JOYSTICK_BUTTON_B = $0002;  
  GLUT_JOYSTICK_BUTTON_C = $0004;  
  GLUT_JOYSTICK_BUTTON_D = $0008;  
{
 * GLUT API macro definitions -- game mode definitions
  }
  GLUT_GAME_MODE_ACTIVE = $0000;  
  GLUT_GAME_MODE_POSSIBLE = $0001;  
  GLUT_GAME_MODE_WIDTH = $0002;  
  GLUT_GAME_MODE_HEIGHT = $0003;  
  GLUT_GAME_MODE_PIXEL_DEPTH = $0004;  
  GLUT_GAME_MODE_REFRESH_RATE = $0005;  
  GLUT_GAME_MODE_DISPLAY_CHANGED = $0006;  
{
 * Initialization functions, see fglut_init.c
  }

procedure glutInit(pargc:Plongint; argv:PPchar);cdecl;external;
procedure glutInitWindowPosition(x:longint; y:longint);cdecl;external;
procedure glutInitWindowSize(width:longint; height:longint);cdecl;external;
procedure glutInitDisplayMode(displayMode:dword);cdecl;external;
(* Const before type ignored *)
procedure glutInitDisplayString(displayMode:Pchar);cdecl;external;
{
 * Process loop function, see fg_main.c
  }
procedure glutMainLoop;cdecl;external;
{
 * Window management functions, see fg_window.c
  }
(* Const before type ignored *)
function glutCreateWindow(title:Pchar):longint;cdecl;external;
function glutCreateSubWindow(window:longint; x:longint; y:longint; width:longint; height:longint):longint;cdecl;external;
procedure glutDestroyWindow(window:longint);cdecl;external;
procedure glutSetWindow(window:longint);cdecl;external;
function glutGetWindow:longint;cdecl;external;
(* Const before type ignored *)
procedure glutSetWindowTitle(title:Pchar);cdecl;external;
(* Const before type ignored *)
procedure glutSetIconTitle(title:Pchar);cdecl;external;
procedure glutReshapeWindow(width:longint; height:longint);cdecl;external;
procedure glutPositionWindow(x:longint; y:longint);cdecl;external;
procedure glutShowWindow;cdecl;external;
procedure glutHideWindow;cdecl;external;
procedure glutIconifyWindow;cdecl;external;
procedure glutPushWindow;cdecl;external;
procedure glutPopWindow;cdecl;external;
procedure glutFullScreen;cdecl;external;
{
 * Display-related functions, see fg_display.c
  }
procedure glutPostWindowRedisplay(window:longint);cdecl;external;
procedure glutPostRedisplay;cdecl;external;
procedure glutSwapBuffers;cdecl;external;
{
 * Mouse cursor functions, see fg_cursor.c
  }
procedure glutWarpPointer(x:longint; y:longint);cdecl;external;
procedure glutSetCursor(cursor:longint);cdecl;external;
{
 * Overlay stuff, see fg_overlay.c
  }
procedure glutEstablishOverlay;cdecl;external;
procedure glutRemoveOverlay;cdecl;external;
procedure glutUseLayer(layer:TGLenum);cdecl;external;
procedure glutPostOverlayRedisplay;cdecl;external;
procedure glutPostWindowOverlayRedisplay(window:longint);cdecl;external;
procedure glutShowOverlay;cdecl;external;
procedure glutHideOverlay;cdecl;external;
{
 * Menu stuff, see fg_menu.c
  }
function glutCreateMenu(callback:procedure (menu:longint)):longint;cdecl;external;
procedure glutDestroyMenu(menu:longint);cdecl;external;
function glutGetMenu:longint;cdecl;external;
procedure glutSetMenu(menu:longint);cdecl;external;
(* Const before type ignored *)
procedure glutAddMenuEntry(_label:Pchar; value:longint);cdecl;external;
(* Const before type ignored *)
procedure glutAddSubMenu(_label:Pchar; subMenu:longint);cdecl;external;
(* Const before type ignored *)
procedure glutChangeToMenuEntry(item:longint; _label:Pchar; value:longint);cdecl;external;
(* Const before type ignored *)
procedure glutChangeToSubMenu(item:longint; _label:Pchar; value:longint);cdecl;external;
procedure glutRemoveMenuItem(item:longint);cdecl;external;
procedure glutAttachMenu(button:longint);cdecl;external;
procedure glutDetachMenu(button:longint);cdecl;external;
{
 * Global callback functions, see fg_callbacks.c
  }
procedure glutTimerFunc(time:dword; callback:procedure (para1:longint); value:longint);cdecl;external;
procedure glutIdleFunc(callback:procedure );cdecl;external;
{
 * Window-specific callback functions, see fg_callbacks.c
  }
procedure glutKeyboardFunc(callback:procedure (para1:byte; para2:longint; para3:longint));cdecl;external;
procedure glutSpecialFunc(callback:procedure (para1:longint; para2:longint; para3:longint));cdecl;external;
procedure glutReshapeFunc(callback:procedure (para1:longint; para2:longint));cdecl;external;
procedure glutVisibilityFunc(callback:procedure (para1:longint));cdecl;external;
procedure glutDisplayFunc(callback:procedure );cdecl;external;
procedure glutMouseFunc(callback:procedure (para1:longint; para2:longint; para3:longint; para4:longint));cdecl;external;
procedure glutMotionFunc(callback:procedure (para1:longint; para2:longint));cdecl;external;
procedure glutPassiveMotionFunc(callback:procedure (para1:longint; para2:longint));cdecl;external;
procedure glutEntryFunc(callback:procedure (para1:longint));cdecl;external;
procedure glutKeyboardUpFunc(callback:procedure (para1:byte; para2:longint; para3:longint));cdecl;external;
procedure glutSpecialUpFunc(callback:procedure (para1:longint; para2:longint; para3:longint));cdecl;external;
procedure glutJoystickFunc(callback:procedure (para1:dword; para2:longint; para3:longint; para4:longint); pollInterval:longint);cdecl;external;
procedure glutMenuStateFunc(callback:procedure (para1:longint));cdecl;external;
procedure glutMenuStatusFunc(callback:procedure (para1:longint; para2:longint; para3:longint));cdecl;external;
procedure glutOverlayDisplayFunc(callback:procedure );cdecl;external;
procedure glutWindowStatusFunc(callback:procedure (para1:longint));cdecl;external;
procedure glutSpaceballMotionFunc(callback:procedure (para1:longint; para2:longint; para3:longint));cdecl;external;
procedure glutSpaceballRotateFunc(callback:procedure (para1:longint; para2:longint; para3:longint));cdecl;external;
procedure glutSpaceballButtonFunc(callback:procedure (para1:longint; para2:longint));cdecl;external;
procedure glutButtonBoxFunc(callback:procedure (para1:longint; para2:longint));cdecl;external;
procedure glutDialsFunc(callback:procedure (para1:longint; para2:longint));cdecl;external;
procedure glutTabletMotionFunc(callback:procedure (para1:longint; para2:longint));cdecl;external;
procedure glutTabletButtonFunc(callback:procedure (para1:longint; para2:longint; para3:longint; para4:longint));cdecl;external;
{
 * State setting and retrieval functions, see fg_state.c
  }
function glutGet(query:TGLenum):longint;cdecl;external;
function glutDeviceGet(query:TGLenum):longint;cdecl;external;
function glutGetModifiers:longint;cdecl;external;
function glutLayerGet(query:TGLenum):longint;cdecl;external;
{
 * Font stuff, see fg_font.c
  }
procedure glutBitmapCharacter(font:pointer; character:longint);cdecl;external;
function glutBitmapWidth(font:pointer; character:longint):longint;cdecl;external;
procedure glutStrokeCharacter(font:pointer; character:longint);cdecl;external;
function glutStrokeWidth(font:pointer; character:longint):longint;cdecl;external;
function glutStrokeWidthf(font:pointer; character:longint):TGLfloat;cdecl;external;
{ GLUT 3.8  }
(* Const before type ignored *)
function glutBitmapLength(font:pointer; _string:Pbyte):longint;cdecl;external;
(* Const before type ignored *)
function glutStrokeLength(font:pointer; _string:Pbyte):longint;cdecl;external;
(* Const before type ignored *)
function glutStrokeLengthf(font:pointer; _string:Pbyte):TGLfloat;cdecl;external;
{ GLUT 3.8  }
{
 * Geometry functions, see fg_geometry.c
  }
procedure glutWireCube(size:Tdouble);cdecl;external;
procedure glutSolidCube(size:Tdouble);cdecl;external;
procedure glutWireSphere(radius:Tdouble; slices:TGLint; stacks:TGLint);cdecl;external;
procedure glutSolidSphere(radius:Tdouble; slices:TGLint; stacks:TGLint);cdecl;external;
procedure glutWireCone(base:Tdouble; height:Tdouble; slices:TGLint; stacks:TGLint);cdecl;external;
procedure glutSolidCone(base:Tdouble; height:Tdouble; slices:TGLint; stacks:TGLint);cdecl;external;
procedure glutWireTorus(innerRadius:Tdouble; outerRadius:Tdouble; sides:TGLint; rings:TGLint);cdecl;external;
procedure glutSolidTorus(innerRadius:Tdouble; outerRadius:Tdouble; sides:TGLint; rings:TGLint);cdecl;external;
procedure glutWireDodecahedron;cdecl;external;
procedure glutSolidDodecahedron;cdecl;external;
procedure glutWireOctahedron;cdecl;external;
procedure glutSolidOctahedron;cdecl;external;
procedure glutWireTetrahedron;cdecl;external;
procedure glutSolidTetrahedron;cdecl;external;
procedure glutWireIcosahedron;cdecl;external;
procedure glutSolidIcosahedron;cdecl;external;
{
 * Teapot rendering functions, found in fg_teapot.c
 * NB: front facing polygons have clockwise winding, not counter clockwise
  }
procedure glutWireTeapot(size:Tdouble);cdecl;external;
procedure glutSolidTeapot(size:Tdouble);cdecl;external;
{
 * Game mode functions, see fg_gamemode.c
  }
(* Const before type ignored *)
procedure glutGameModeString(_string:Pchar);cdecl;external;
function glutEnterGameMode:longint;cdecl;external;
procedure glutLeaveGameMode;cdecl;external;
function glutGameModeGet(query:TGLenum):longint;cdecl;external;
{
 * Video resize functions, see fg_videoresize.c
  }
function glutVideoResizeGet(query:TGLenum):longint;cdecl;external;
procedure glutSetupVideoResizing;cdecl;external;
procedure glutStopVideoResizing;cdecl;external;
procedure glutVideoResize(x:longint; y:longint; width:longint; height:longint);cdecl;external;
procedure glutVideoPan(x:longint; y:longint; width:longint; height:longint);cdecl;external;
{
 * Colormap functions, see fg_misc.c
  }
procedure glutSetColor(color:longint; red:TGLfloat; green:TGLfloat; blue:TGLfloat);cdecl;external;
function glutGetColor(color:longint; component:longint):TGLfloat;cdecl;external;
procedure glutCopyColormap(window:longint);cdecl;external;
{
 * Misc keyboard and joystick functions, see fg_misc.c
  }
procedure glutIgnoreKeyRepeat(ignore:longint);cdecl;external;
procedure glutSetKeyRepeat(repeatMode:longint);cdecl;external;
procedure glutForceJoystickFunc;cdecl;external;
{
 * Misc functions, see fg_misc.c
  }
(* Const before type ignored *)
function glutExtensionSupported(extension:Pchar):longint;cdecl;external;
procedure glutReportErrors;cdecl;external;
{ Comment from glut.h of classic GLUT:

   Win32 has an annoying issue where there are multiple C run-time
   libraries (CRTs).  If the executable is linked with a different CRT
   from the GLUT DLL, the GLUT DLL will not share the same CRT static
   data seen by the executable.  In particular, atexit callbacks registered
   in the executable will not be called if GLUT calls its (different)
   exit routine).  GLUT is typically built with the
   "/MD" option (the CRT with multithreading DLL support), but the Visual
   C++ linker default is "/ML" (the single threaded CRT).

   One workaround to this issue is requiring users to always link with
   the same CRT as GLUT is compiled with.  That requires users supply a
   non-standard option.  GLUT 3.7 has its own built-in workaround where
   the executable's "exit" function pointer is covertly passed to GLUT.
   GLUT then calls the executable's exit function pointer to ensure that
   any "atexit" calls registered by the application are called if GLUT
   needs to exit.

   Note that the __glut*WithExit routines should NEVER be called directly.
   To avoid the atexit workaround, #define GLUT_DISABLE_ATEXIT_HACK.  }
{ to get the prototype for exit()  }
{$include <stdlib.h>}
{$if defined(_WIN32) && !defined(GLUT_DISABLE_ATEXIT_HACK) && !defined(__WATCOMC__)}

procedure __glutInitWithExit(argcp:Plongint; argv:PPchar; exitfunc:procedure (para1:longint));cdecl;external;
(* Const before type ignored *)
function __glutCreateWindowWithExit(title:Pchar; exitfunc:procedure (para1:longint)):longint;cdecl;external;
function __glutCreateMenuWithExit(func:procedure (para1:longint); exitfunc:procedure (para1:longint)):longint;cdecl;external;
{$ifndef FREEGLUT_BUILDING_LIB}
{$if defined(__GNUC__)}

{ was #define dname def_expr }
function FGUNUSED : longint; { return type might be wrong }

{$else}
{$define FGUNUSED}
{$endif}
{

static void  FGUNUSED glutInit_ATEXIT_HACK(int *argcp, char **argv)  __glutInitWithExit(argcp, argv, exit); 
#define glutInit glutInit_ATEXIT_HACK
static int  FGUNUSED glutCreateWindow_ATEXIT_HACK(const char *title)  return __glutCreateWindowWithExit(title, exit); 
#define glutCreateWindow glutCreateWindow_ATEXIT_HACK
static int  FGUNUSED glutCreateMenu_ATEXIT_HACK(void (* func)(int))  return __glutCreateMenuWithExit(func, exit); 
#define glutCreateMenu glutCreateMenu_ATEXIT_HACK

 }
{$endif}
{$endif}
{** END OF FILE ** }
{$endif}
{ __FREEGLUT_STD_H__  }

implementation

{ was #define dname def_expr }
function GLUT_STROKE_ROMAN : pointer;
  begin
    GLUT_STROKE_ROMAN:=pointer($0000);
  end;

{ was #define dname def_expr }
function GLUT_STROKE_MONO_ROMAN : pointer;
  begin
    GLUT_STROKE_MONO_ROMAN:=pointer($0001);
  end;

{ was #define dname def_expr }
function GLUT_BITMAP_9_BY_15 : pointer;
  begin
    GLUT_BITMAP_9_BY_15:=pointer($0002);
  end;

{ was #define dname def_expr }
function GLUT_BITMAP_8_BY_13 : pointer;
  begin
    GLUT_BITMAP_8_BY_13:=pointer($0003);
  end;

{ was #define dname def_expr }
function GLUT_BITMAP_TIMES_ROMAN_10 : pointer;
  begin
    GLUT_BITMAP_TIMES_ROMAN_10:=pointer($0004);
  end;

{ was #define dname def_expr }
function GLUT_BITMAP_TIMES_ROMAN_24 : pointer;
  begin
    GLUT_BITMAP_TIMES_ROMAN_24:=pointer($0005);
  end;

{ was #define dname def_expr }
function GLUT_BITMAP_HELVETICA_10 : pointer;
  begin
    GLUT_BITMAP_HELVETICA_10:=pointer($0006);
  end;

{ was #define dname def_expr }
function GLUT_BITMAP_HELVETICA_12 : pointer;
  begin
    GLUT_BITMAP_HELVETICA_12:=pointer($0007);
  end;

{ was #define dname def_expr }
function GLUT_BITMAP_HELVETICA_18 : pointer;
  begin
    GLUT_BITMAP_HELVETICA_18:=pointer($0008);
  end;

{ was #define dname def_expr }
function GLUT_STROKE_ROMAN : pointer;
  begin
    GLUT_STROKE_ROMAN:=pointer(@(glutStrokeRoman));
  end;

{ was #define dname def_expr }
function GLUT_STROKE_MONO_ROMAN : pointer;
  begin
    GLUT_STROKE_MONO_ROMAN:=pointer(@(glutStrokeMonoRoman));
  end;

{ was #define dname def_expr }
function GLUT_BITMAP_9_BY_15 : pointer;
  begin
    GLUT_BITMAP_9_BY_15:=pointer(@(glutBitmap9By15));
  end;

{ was #define dname def_expr }
function GLUT_BITMAP_8_BY_13 : pointer;
  begin
    GLUT_BITMAP_8_BY_13:=pointer(@(glutBitmap8By13));
  end;

{ was #define dname def_expr }
function GLUT_BITMAP_TIMES_ROMAN_10 : pointer;
  begin
    GLUT_BITMAP_TIMES_ROMAN_10:=pointer(@(glutBitmapTimesRoman10));
  end;

{ was #define dname def_expr }
function GLUT_BITMAP_TIMES_ROMAN_24 : pointer;
  begin
    GLUT_BITMAP_TIMES_ROMAN_24:=pointer(@(glutBitmapTimesRoman24));
  end;

{ was #define dname def_expr }
function GLUT_BITMAP_HELVETICA_10 : pointer;
  begin
    GLUT_BITMAP_HELVETICA_10:=pointer(@(glutBitmapHelvetica10));
  end;

{ was #define dname def_expr }
function GLUT_BITMAP_HELVETICA_12 : pointer;
  begin
    GLUT_BITMAP_HELVETICA_12:=pointer(@(glutBitmapHelvetica12));
  end;

{ was #define dname def_expr }
function GLUT_BITMAP_HELVETICA_18 : pointer;
  begin
    GLUT_BITMAP_HELVETICA_18:=pointer(@(glutBitmapHelvetica18));
  end;

{ was #define dname def_expr }
function FGUNUSED : longint; { return type might be wrong }
  begin
    FGUNUSED:=__attribute__(unused);
  end;


end.
