
unit freeglut_ucall;
interface

{
  Automatically converted by H2Pas 1.0.0 from freeglut_ucall.h
  The following command line parameters were used:
    -p
    -T
    -d
    -c
    -e
    freeglut_ucall.h
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
Pchar  = ^char;
{$IFDEF FPC}
{$PACKRECORDS C}
{$ENDIF}


{$ifndef  __FREEGLUT_UCALL_H__}
{$define __FREEGLUT_UCALL_H__}
{
 * freeglut_ucall.h
 *
 * Callbacks with user data arguments.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
 * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
 * PAWEL W. OLSZTA BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
 * IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
  }
{
 * Menu stuff, see fg_menu.c
  }

function glutCreateMenuUcall(callback:procedure (menu:longint; user_data:pointer); user_data:pointer):longint;cdecl;external;
{
 * Global callback functions, see fg_callbacks.c
  }
procedure glutTimerFuncUcall(time:dword; callback:procedure (para1:longint; para2:pointer); value:longint; user_data:pointer);cdecl;external;
procedure glutIdleFuncUcall(callback:procedure (para1:pointer); user_data:pointer);cdecl;external;
{
 * Window-specific callback functions, see fg_callbacks.c
  }
procedure glutKeyboardFuncUcall(callback:procedure (para1:byte; para2:longint; para3:longint; para4:pointer); user_data:pointer);cdecl;external;
procedure glutSpecialFuncUcall(callback:procedure (para1:longint; para2:longint; para3:longint; para4:pointer); user_data:pointer);cdecl;external;
procedure glutReshapeFuncUcall(callback:procedure (para1:longint; para2:longint; para3:pointer); user_data:pointer);cdecl;external;
procedure glutVisibilityFuncUcall(callback:procedure (para1:longint; para2:pointer); user_data:pointer);cdecl;external;
procedure glutDisplayFuncUcall(callback:procedure (para1:pointer); user_data:pointer);cdecl;external;
procedure glutMouseFuncUcall(callback:procedure (para1:longint; para2:longint; para3:longint; para4:longint; para5:pointer); user_data:pointer);cdecl;external;
procedure glutMotionFuncUcall(callback:procedure (para1:longint; para2:longint; para3:pointer); user_data:pointer);cdecl;external;
procedure glutPassiveMotionFuncUcall(callback:procedure (para1:longint; para2:longint; para3:pointer); user_data:pointer);cdecl;external;
procedure glutEntryFuncUcall(callback:procedure (para1:longint; para2:pointer); user_data:pointer);cdecl;external;
procedure glutKeyboardUpFuncUcall(callback:procedure (para1:byte; para2:longint; para3:longint; para4:pointer); user_data:pointer);cdecl;external;
procedure glutSpecialUpFuncUcall(callback:procedure (para1:longint; para2:longint; para3:longint; para4:pointer); user_data:pointer);cdecl;external;
procedure glutJoystickFuncUcall(callback:procedure (para1:dword; para2:longint; para3:longint; para4:longint; para5:pointer); pollInterval:longint; user_data:pointer);cdecl;external;
procedure glutMenuStatusFuncUcall(callback:procedure (para1:longint; para2:longint; para3:longint; para4:pointer); user_data:pointer);cdecl;external;
procedure glutOverlayDisplayFuncUcall(callback:procedure (para1:pointer); user_data:pointer);cdecl;external;
procedure glutWindowStatusFuncUcall(callback:procedure (para1:longint; para2:pointer); user_data:pointer);cdecl;external;
procedure glutSpaceballMotionFuncUcall(callback:procedure (para1:longint; para2:longint; para3:longint; para4:pointer); user_data:pointer);cdecl;external;
procedure glutSpaceballRotateFuncUcall(callback:procedure (para1:longint; para2:longint; para3:longint; para4:pointer); user_data:pointer);cdecl;external;
procedure glutSpaceballButtonFuncUcall(callback:procedure (para1:longint; para2:longint; para3:pointer); user_data:pointer);cdecl;external;
procedure glutButtonBoxFuncUcall(callback:procedure (para1:longint; para2:longint; para3:pointer); user_data:pointer);cdecl;external;
procedure glutDialsFuncUcall(callback:procedure (para1:longint; para2:longint; para3:pointer); user_data:pointer);cdecl;external;
procedure glutTabletMotionFuncUcall(callback:procedure (para1:longint; para2:longint; para3:pointer); user_data:pointer);cdecl;external;
procedure glutTabletButtonFuncUcall(callback:procedure (para1:longint; para2:longint; para3:longint; para4:longint; para5:pointer); user_data:pointer);cdecl;external;
procedure glutMouseWheelFuncUcall(callback:procedure (para1:longint; para2:longint; para3:longint; para4:longint; para5:pointer); user_data:pointer);cdecl;external;
procedure glutPositionFuncUcall(callback:procedure (para1:longint; para2:longint; para3:pointer); user_data:pointer);cdecl;external;
procedure glutCloseFuncUcall(callback:procedure (para1:pointer); user_data:pointer);cdecl;external;
procedure glutWMCloseFuncUcall(callback:procedure (para1:pointer); user_data:pointer);cdecl;external;
procedure glutMenuDestroyFuncUcall(callback:procedure (para1:pointer); user_data:pointer);cdecl;external;
{
 * Multi-touch/multi-pointer extensions
  }
procedure glutMultiEntryFuncUcall(callback:procedure (para1:longint; para2:longint; para3:pointer); user_data:pointer);cdecl;external;
procedure glutMultiButtonFuncUcall(callback:procedure (para1:longint; para2:longint; para3:longint; para4:longint; para5:longint; 
                        para6:pointer); user_data:pointer);cdecl;external;
procedure glutMultiMotionFuncUcall(callback:procedure (para1:longint; para2:longint; para3:longint; para4:pointer); user_data:pointer);cdecl;external;
procedure glutMultiPassiveFuncUcall(callback:procedure (para1:longint; para2:longint; para3:longint; para4:pointer); user_data:pointer);cdecl;external;
{
 * Initialization functions, see fg_init.c
  }
{$include <stdarg.h>}
(* Const before type ignored *)

procedure glutInitErrorFuncUcall(callback:procedure (fmt:Pchar; ap:Tva_list; user_data:pointer); user_data:pointer);cdecl;external;
(* Const before type ignored *)
procedure glutInitWarningFuncUcall(callback:procedure (fmt:Pchar; ap:Tva_list; user_data:pointer); user_data:pointer);cdecl;external;
{ Mobile platforms lifecycle  }
procedure glutInitContextFuncUcall(callback:procedure (para1:pointer); user_data:pointer);cdecl;external;
procedure glutAppStatusFuncUcall(callback:procedure (para1:longint; para2:pointer); user_data:pointer);cdecl;external;
{
 * Continued "hack" from GLUT applied to Ucall functions.
 * For more info, see bottom of freeglut_std.h
  }
{ to get the prototype for exit()  }
{$include <stdlib.h>}
{$if defined(_WIN32) && !defined(GLUT_DISABLE_ATEXIT_HACK) && !defined(__WATCOMC__)}

function __glutCreateMenuUcallWithExit(func:procedure (para1:longint; para2:pointer); exitfunc:procedure (para1:longint); user_data:pointer):longint;cdecl;external;
{$ifndef FREEGLUT_BUILDING_LIB}
{$if defined(__GNUC__)}

{ was #define dname def_expr }
function FGUNUSED : longint; { return type might be wrong }

{$else}
{$define FGUNUSED}
{$endif}
{
static int  FGUNUSED glutCreateMenuUcall_ATEXIT_HACK(void(*func)(int, void*), void* user_data)  return __glutCreateMenuUcallWithExit(func, exit, user_data); 
 }

const
  glutCreateMenuUcall = glutCreateMenuUcall_ATEXIT_HACK;  
{$endif}
{$endif}
{** END OF FILE ** }
{$endif}
{ __FREEGLUT_UCALL_H__  }

implementation

{ was #define dname def_expr }
function FGUNUSED : longint; { return type might be wrong }
  begin
    FGUNUSED:=__attribute__(unused);
  end;


end.
