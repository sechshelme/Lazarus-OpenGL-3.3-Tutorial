unit fp_freeglut_std;

interface

uses
  gl;

const
  {$ifdef linux}
  libglut='libglut';
  {$endif}

  {$ifdef windows}
  libglfw = 'glut.dll';
  {$endif}

  {$ifdef darwin}
  libglfw = 'glut.dynlib';
  {$endif}


{$IFDEF FPC}
{$PACKRECORDS C}
{$ENDIF}


const
  FREEGLUT = 1;  
  GLUT_API_VERSION = 4;  
  GLUT_XLIB_IMPLEMENTATION = 13;  
  FREEGLUT_VERSION_2_0 = 1;

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

  GLUT_LEFT_BUTTON = $0000;
  GLUT_MIDDLE_BUTTON = $0001;  
  GLUT_RIGHT_BUTTON = $0002;  
  GLUT_DOWN = $0000;  
  GLUT_UP = $0001;  
  GLUT_LEFT = $0000;  
  GLUT_ENTERED = $0001;  

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

  GLUT_MENU_NOT_IN_USE = $0000;
  GLUT_MENU_IN_USE = $0001;  
  GLUT_NOT_VISIBLE = $0000;  
  GLUT_VISIBLE = $0001;  
  GLUT_HIDDEN = $0000;  
  GLUT_FULLY_RETAINED = $0001;  
  GLUT_PARTIALLY_RETAINED = $0002;  
  GLUT_FULLY_COVERED = $0003;  
{$ifdef windows}

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
  var
    glutStrokeRoman : pointer;cvar;external libglut;
    glutStrokeMonoRoman : pointer;cvar;external libglut;
    glutBitmap9By15 : pointer;cvar;external libglut;
    glutBitmap8By13 : pointer;cvar;external libglut;
    glutBitmapTimesRoman10 : pointer;cvar;external libglut;
    glutBitmapTimesRoman24 : pointer;cvar;external libglut;
    glutBitmapHelvetica10 : pointer;cvar;external libglut;
    glutBitmapHelvetica12 : pointer;cvar;external libglut;
    glutBitmapHelvetica18 : pointer;cvar;external libglut;
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

procedure glutInit(pargc:Plongint; argv:PPchar);cdecl;external libglut;
procedure glutInitWindowPosition(x:longint; y:longint);cdecl;external libglut;
procedure glutInitWindowSize(width:longint; height:longint);cdecl;external libglut;
procedure glutInitDisplayMode(displayMode:dword);cdecl;external libglut;
procedure glutInitDisplayString(displayMode:Pchar);cdecl;external libglut;
{
 * Process loop function, see fg_main.c
  }
procedure glutMainLoop;cdecl;external libglut;
{
 * Window management functions, see fg_window.c
  }
function glutCreateWindow(title:Pchar):longint;cdecl;external libglut;
function glutCreateSubWindow(window:longint; x:longint; y:longint; width:longint; height:longint):longint;cdecl;external libglut;
procedure glutDestroyWindow(window:longint);cdecl;external libglut;
procedure glutSetWindow(window:longint);cdecl;external libglut;
function glutGetWindow:longint;cdecl;external libglut;
procedure glutSetWindowTitle(title:Pchar);cdecl;external libglut;
procedure glutSetIconTitle(title:Pchar);cdecl;external libglut;
procedure glutReshapeWindow(width:longint; height:longint);cdecl;external libglut;
procedure glutPositionWindow(x:longint; y:longint);cdecl;external libglut;
procedure glutShowWindow;cdecl;external libglut;
procedure glutHideWindow;cdecl;external libglut;
procedure glutIconifyWindow;cdecl;external libglut;
procedure glutPushWindow;cdecl;external libglut;
procedure glutPopWindow;cdecl;external libglut;
procedure glutFullScreen;cdecl;external libglut;
{
 * Display-related functions, see fg_display.c
  }
procedure glutPostWindowRedisplay(window:longint);cdecl;external libglut;
procedure glutPostRedisplay;cdecl;external libglut;
procedure glutSwapBuffers;cdecl;external libglut;
{
 * Mouse cursor functions, see fg_cursor.c
  }
procedure glutWarpPointer(x:longint; y:longint);cdecl;external libglut;
procedure glutSetCursor(cursor:longint);cdecl;external libglut;
{
 * Overlay stuff, see fg_overlay.c
  }
procedure glutEstablishOverlay;cdecl;external libglut;
procedure glutRemoveOverlay;cdecl;external libglut;
procedure glutUseLayer(layer:TGLenum);cdecl;external libglut;
procedure glutPostOverlayRedisplay;cdecl;external libglut;
procedure glutPostWindowOverlayRedisplay(window:longint);cdecl;external libglut;
procedure glutShowOverlay;cdecl;external libglut;
procedure glutHideOverlay;cdecl;external libglut;
{
 * Menu stuff, see fg_menu.c
  }
function glutCreateMenu(callback:procedure (menu:longint)):longint;cdecl;external libglut;
procedure glutDestroyMenu(menu:longint);cdecl;external libglut;
function glutGetMenu:longint;cdecl;external libglut;
procedure glutSetMenu(menu:longint);cdecl;external libglut;
procedure glutAddMenuEntry(_label:Pchar; value:longint);cdecl;external libglut;
procedure glutAddSubMenu(_label:Pchar; subMenu:longint);cdecl;external libglut;
procedure glutChangeToMenuEntry(item:longint; _label:Pchar; value:longint);cdecl;external libglut;
procedure glutChangeToSubMenu(item:longint; _label:Pchar; value:longint);cdecl;external libglut;
procedure glutRemoveMenuItem(item:longint);cdecl;external libglut;
procedure glutAttachMenu(button:longint);cdecl;external libglut;
procedure glutDetachMenu(button:longint);cdecl;external libglut;
{
 * Global callback functions, see fg_callbacks.c
  }
procedure glutTimerFunc(time:dword; callback:procedure (para1:longint); value:longint);cdecl;external libglut;
procedure glutIdleFunc(callback:procedure );cdecl;external libglut;
{
 * Window-specific callback functions, see fg_callbacks.c
  }
procedure glutKeyboardFunc(callback:procedure (para1:byte; para2:longint; para3:longint));cdecl;external libglut;
procedure glutSpecialFunc(callback:procedure (para1:longint; para2:longint; para3:longint));cdecl;external libglut;
procedure glutReshapeFunc(callback:procedure (para1:longint; para2:longint));cdecl;external libglut;
procedure glutVisibilityFunc(callback:procedure (para1:longint));cdecl;external libglut;
procedure glutDisplayFunc(callback:procedure );cdecl;external libglut;
procedure glutMouseFunc(callback:procedure (para1:longint; para2:longint; para3:longint; para4:longint));cdecl;external libglut;
procedure glutMotionFunc(callback:procedure (para1:longint; para2:longint));cdecl;external libglut;
procedure glutPassiveMotionFunc(callback:procedure (para1:longint; para2:longint));cdecl;external libglut;
procedure glutEntryFunc(callback:procedure (para1:longint));cdecl;external libglut;
procedure glutKeyboardUpFunc(callback:procedure (para1:byte; para2:longint; para3:longint));cdecl;external libglut;
procedure glutSpecialUpFunc(callback:procedure (para1:longint; para2:longint; para3:longint));cdecl;external libglut;
procedure glutJoystickFunc(callback:procedure (para1:dword; para2:longint; para3:longint; para4:longint); pollInterval:longint);cdecl;external libglut;
procedure glutMenuStateFunc(callback:procedure (para1:longint));cdecl;external libglut;
procedure glutMenuStatusFunc(callback:procedure (para1:longint; para2:longint; para3:longint));cdecl;external libglut;
procedure glutOverlayDisplayFunc(callback:procedure );cdecl;external libglut;
procedure glutWindowStatusFunc(callback:procedure (para1:longint));cdecl;external libglut;
procedure glutSpaceballMotionFunc(callback:procedure (para1:longint; para2:longint; para3:longint));cdecl;external libglut;
procedure glutSpaceballRotateFunc(callback:procedure (para1:longint; para2:longint; para3:longint));cdecl;external libglut;
procedure glutSpaceballButtonFunc(callback:procedure (para1:longint; para2:longint));cdecl;external libglut;
procedure glutButtonBoxFunc(callback:procedure (para1:longint; para2:longint));cdecl;external libglut;
procedure glutDialsFunc(callback:procedure (para1:longint; para2:longint));cdecl;external libglut;
procedure glutTabletMotionFunc(callback:procedure (para1:longint; para2:longint));cdecl;external libglut;
procedure glutTabletButtonFunc(callback:procedure (para1:longint; para2:longint; para3:longint; para4:longint));cdecl;external libglut;
{
 * State setting and retrieval functions, see fg_state.c
  }
function glutGet(query:TGLenum):longint;cdecl;external libglut;
function glutDeviceGet(query:TGLenum):longint;cdecl;external libglut;
function glutGetModifiers:longint;cdecl;external libglut;
function glutLayerGet(query:TGLenum):longint;cdecl;external libglut;
{
 * Font stuff, see fg_font.c
  }
procedure glutBitmapCharacter(font:pointer; character:longint);cdecl;external libglut;
function glutBitmapWidth(font:pointer; character:longint):longint;cdecl;external libglut;
procedure glutStrokeCharacter(font:pointer; character:longint);cdecl;external libglut;
function glutStrokeWidth(font:pointer; character:longint):longint;cdecl;external libglut;
function glutStrokeWidthf(font:pointer; character:longint):TGLfloat;cdecl;external libglut;
{ GLUT 3.8  }
function glutBitmapLength(font:pointer; _string:Pbyte):longint;cdecl;external libglut;
function glutStrokeLength(font:pointer; _string:Pbyte):longint;cdecl;external libglut;
function glutStrokeLengthf(font:pointer; _string:Pbyte):TGLfloat;cdecl;external libglut;
{ GLUT 3.8  }
{
 * Geometry functions, see fg_geometry.c
  }
procedure glutWireCube(size:Tdouble);cdecl;external libglut;
procedure glutSolidCube(size:Tdouble);cdecl;external libglut;
procedure glutWireSphere(radius:Tdouble; slices:TGLint; stacks:TGLint);cdecl;external libglut;
procedure glutSolidSphere(radius:Tdouble; slices:TGLint; stacks:TGLint);cdecl;external libglut;
procedure glutWireCone(base:Tdouble; height:Tdouble; slices:TGLint; stacks:TGLint);cdecl;external libglut;
procedure glutSolidCone(base:Tdouble; height:Tdouble; slices:TGLint; stacks:TGLint);cdecl;external libglut;
procedure glutWireTorus(innerRadius:Tdouble; outerRadius:Tdouble; sides:TGLint; rings:TGLint);cdecl;external libglut;
procedure glutSolidTorus(innerRadius:Tdouble; outerRadius:Tdouble; sides:TGLint; rings:TGLint);cdecl;external libglut;
procedure glutWireDodecahedron;cdecl;external libglut;
procedure glutSolidDodecahedron;cdecl;external libglut;
procedure glutWireOctahedron;cdecl;external libglut;
procedure glutSolidOctahedron;cdecl;external libglut;
procedure glutWireTetrahedron;cdecl;external libglut;
procedure glutSolidTetrahedron;cdecl;external libglut;
procedure glutWireIcosahedron;cdecl;external libglut;
procedure glutSolidIcosahedron;cdecl;external libglut;
{
 * Teapot rendering functions, found in fg_teapot.c
 * NB: front facing polygons have clockwise winding, not counter clockwise
  }
procedure glutWireTeapot(size:Tdouble);cdecl;external libglut;
procedure glutSolidTeapot(size:Tdouble);cdecl;external libglut;
{
 * Game mode functions, see fg_gamemode.c
  }
procedure glutGameModeString(_string:Pchar);cdecl;external libglut;
function glutEnterGameMode:longint;cdecl;external libglut;
procedure glutLeaveGameMode;cdecl;external libglut;
function glutGameModeGet(query:TGLenum):longint;cdecl;external libglut;
{
 * Video resize functions, see fg_videoresize.c
  }
function glutVideoResizeGet(query:TGLenum):longint;cdecl;external libglut;
procedure glutSetupVideoResizing;cdecl;external libglut;
procedure glutStopVideoResizing;cdecl;external libglut;
procedure glutVideoResize(x:longint; y:longint; width:longint; height:longint);cdecl;external libglut;
procedure glutVideoPan(x:longint; y:longint; width:longint; height:longint);cdecl;external libglut;
{
 * Colormap functions, see fg_misc.c
  }
procedure glutSetColor(color:longint; red:TGLfloat; green:TGLfloat; blue:TGLfloat);cdecl;external libglut;
function glutGetColor(color:longint; component:longint):TGLfloat;cdecl;external libglut;
procedure glutCopyColormap(window:longint);cdecl;external libglut;
{
 * Misc keyboard and joystick functions, see fg_misc.c
  }
procedure glutIgnoreKeyRepeat(ignore:longint);cdecl;external libglut;
procedure glutSetKeyRepeat(repeatMode:longint);cdecl;external libglut;
procedure glutForceJoystickFunc;cdecl;external libglut;
{
 * Misc functions, see fg_misc.c
  }
function glutExtensionSupported(extension:Pchar):longint;cdecl;external libglut;
procedure glutReportErrors;cdecl;external libglut;
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

procedure __glutInitWithExit(argcp:Plongint; argv:PPchar; exitfunc:procedure (para1:longint));cdecl;external libglut;
function __glutCreateWindowWithExit(title:Pchar; exitfunc:procedure (para1:longint)):longint;cdecl;external libglut;
function __glutCreateMenuWithExit(func:procedure (para1:longint); exitfunc:procedure (para1:longint)):longint;cdecl;external libglut;
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

// === Konventiert am: 22-6-25 19:46:37 ===


implementation

{$ifdef windows}

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

  {$else}

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
{$endif}


{ was #define dname def_expr }
function FGUNUSED : longint; { return type might be wrong }
  begin
    FGUNUSED:=__attribute__(unused);
  end;


end.
