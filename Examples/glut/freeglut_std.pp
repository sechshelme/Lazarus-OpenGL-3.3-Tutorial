unit freeglut_std;

interface

// https://math.hws.edu/graphicsbook/source/glut/first-triangle.c

uses
oglGL;

{$IFDEF UNIX}
const
  glutLib='glut';
{$LinkLib 'glut'}
{$ENDIF}

{$IFDEF WINDOWS}
const
  glutLib='glut32.dll';
//  {$LinkLib 'glut'}
{$ENDIF}


{$IFDEF FPC}
{$PACKRECORDS C}
{$ENDIF}


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
 * glutLib API macro definitions -- mouse state definitions
  }
  GLUT_LEFT_BUTTON = $0000;  
  GLUT_MIDDLE_BUTTON = $0001;  
  GLUT_RIGHT_BUTTON = $0002;  
  GLUT_DOWN = $0000;  
  GLUT_UP = $0001;  
  GLUT_LEFT = $0000;  
  GLUT_ENTERED = $0001;  
{
 * glutLib API macro definitions -- the display mode definitions
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
 * glutLib API macro definitions -- windows and menu related definitions
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

{
     * I don't really know if it's a good idea... But here it goes:
      }
  var
    glutStrokeRoman : pointer;cvar;external glutLib;
    glutStrokeMonoRoman : pointer;cvar;external glutLib;
    glutBitmap9By15 : pointer;cvar;external glutLib;
    glutBitmap8By13 : pointer;cvar;external glutLib;
    glutBitmapTimesRoman10 : pointer;cvar;external glutLib;
    glutBitmapTimesRoman24 : pointer;cvar;external glutLib;
    glutBitmapHelvetica10 : pointer;cvar;external glutLib;
    glutBitmapHelvetica12 : pointer;cvar;external glutLib;
    glutBitmapHelvetica18 : pointer;cvar;external glutLib;
{
     * Those pointers will be used by following definitions:
      }

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
 * glutLib API macro definitions -- the glutDeviceGet parameters
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
 * glutLib API macro definitions -- the glutLayerGet parameters
  }
  GLUT_OVERLAY_POSSIBLE = $0320;  
  GLUT_LAYER_IN_USE = $0321;  
  GLUT_HAS_OVERLAY = $0322;  
  GLUT_TRANSPARENT_INDEX = $0323;  
  GLUT_NORMAL_DAMAGED = $0324;  
  GLUT_OVERLAY_DAMAGED = $0325;  
{
 * glutLib API macro definitions -- the glutVideoResizeGet parameters
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
 * glutLib API macro definitions -- the glutUseLayer parameters
  }
  GLUT_NORMAL = $0000;  
  GLUT_OVERLAY = $0001;  
{
 * glutLib API macro definitions -- the glutGetModifiers parameters
  }
  GLUT_ACTIVE_SHIFT = $0001;  
  GLUT_ACTIVE_CTRL = $0002;  
  GLUT_ACTIVE_ALT = $0004;  
{
 * glutLib API macro definitions -- the glutSetCursor parameters
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
 * glutLib API macro definitions -- RGB color component specification definitions
  }
  GLUT_RED = $0000;  
  GLUT_GREEN = $0001;  
  GLUT_BLUE = $0002;  
{
 * glutLib API macro definitions -- additional keyboard and joystick definitions
  }
  GLUT_KEY_REPEAT_OFF = $0000;  
  GLUT_KEY_REPEAT_ON = $0001;  
  GLUT_KEY_REPEAT_DEFAULT = $0002;  
  GLUT_JOYSTICK_BUTTON_A = $0001;  
  GLUT_JOYSTICK_BUTTON_B = $0002;  
  GLUT_JOYSTICK_BUTTON_C = $0004;  
  GLUT_JOYSTICK_BUTTON_D = $0008;  
{
 * glutLib API macro definitions -- game mode definitions
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

procedure glutInit(pargc:Plongint; argv:PPchar);cdecl;external glutLib;
procedure glutInitWindowPosition(x:longint; y:longint);cdecl;external glutLib;
procedure glutInitWindowSize(width:longint; height:longint);cdecl;external glutLib;
procedure glutInitDisplayMode(displayMode:dword);cdecl;external glutLib;
(* Const before type ignored *)
procedure glutInitDisplayString(displayMode:Pchar);cdecl;external glutLib;
{
 * Process loop function, see freeglut_main.c
  }
procedure glutMainLoop;cdecl;external glutLib;
{
 * Window management functions, see freeglut_window.c
  }
(* Const before type ignored *)
function glutCreateWindow(title:Pchar):longint;cdecl;external glutLib;
function glutCreateSubWindow(window:longint; x:longint; y:longint; width:longint; height:longint):longint;cdecl;external glutLib;
procedure glutDestroyWindow(window:longint);cdecl;external glutLib;
procedure glutSetWindow(window:longint);cdecl;external glutLib;
function glutGetWindow:longint;cdecl;external glutLib;
(* Const before type ignored *)
procedure glutSetWindowTitle(title:Pchar);cdecl;external glutLib;
(* Const before type ignored *)
procedure glutSetIconTitle(title:Pchar);cdecl;external glutLib;
procedure glutReshapeWindow(width:longint; height:longint);cdecl;external glutLib;
procedure glutPositionWindow(x:longint; y:longint);cdecl;external glutLib;
procedure glutShowWindow;cdecl;external glutLib;
procedure glutHideWindow;cdecl;external glutLib;
procedure glutIconifyWindow;cdecl;external glutLib;
procedure glutPushWindow;cdecl;external glutLib;
procedure glutPopWindow;cdecl;external glutLib;
procedure glutFullScreen;cdecl;external glutLib;
{
 * Display-connected functions, see freeglut_display.c
  }
procedure glutPostWindowRedisplay(window:longint);cdecl;external glutLib;
procedure glutPostRedisplay;cdecl;external glutLib;
procedure glutSwapBuffers;cdecl;external glutLib;
{
 * Mouse cursor functions, see freeglut_cursor.c
  }
procedure glutWarpPointer(x:longint; y:longint);cdecl;external glutLib;
procedure glutSetCursor(cursor:longint);cdecl;external glutLib;
{
 * Overlay stuff, see freeglut_overlay.c
  }
procedure glutEstablishOverlay;cdecl;external glutLib;
procedure glutRemoveOverlay;cdecl;external glutLib;
procedure glutUseLayer(layer:TGLenum);cdecl;external glutLib;
procedure glutPostOverlayRedisplay;cdecl;external glutLib;
procedure glutPostWindowOverlayRedisplay(window:longint);cdecl;external glutLib;
procedure glutShowOverlay;cdecl;external glutLib;
procedure glutHideOverlay;cdecl;external glutLib;
{
 * Menu stuff, see freeglut_menu.c
  }
  type glutCreateMenu_func=      procedure (menu:longint);
function glutCreateMenu(callback:glutCreateMenu_func):longint;cdecl;external glutLib;
procedure glutDestroyMenu(menu:longint);cdecl;external glutLib;
function glutGetMenu:longint;cdecl;external glutLib;
procedure glutSetMenu(menu:longint);cdecl;external glutLib;
(* Const before type ignored *)
procedure glutAddMenu(_label:Pchar; value:longint);cdecl;external glutLib;
(* Const before type ignored *)
procedure glutAddSubMenu(_label:Pchar; subMenu:longint);cdecl;external glutLib;
(* Const before type ignored *)
procedure glutChangeToMenu(item:longint; _label:Pchar; value:longint);cdecl;external glutLib;
(* Const before type ignored *)
procedure glutChangeToSubMenu(item:longint; _label:Pchar; value:longint);cdecl;external glutLib;
procedure glutRemoveMenuItem(item:longint);cdecl;external glutLib;
procedure glutAttachMenu(button:longint);cdecl;external glutLib;
procedure glutDetachMenu(button:longint);cdecl;external glutLib;
{
 * Global callback functions, see freeglut_callbacks.c
  }
  type glutTimerFunc_func=      procedure (menu:longint);
procedure glutTimerFunc(time:dword; callback:glutTimerFunc_func; value:longint);cdecl;external glutLib;
//
//procedure glutIdleFunc(callback:procedure );cdecl;external glut;
//{
// * Window-specific callback functions, see freeglut_callbacks.c
//  }

type TglutKeyboardFunc_func=        procedure (para1:byte; para2:longint; para3:longint);cdecl;
procedure glutKeyboardFunc(callback:TglutKeyboardFunc_func);cdecl;external glutLib;
//procedure glutSpecialFunc(callback:procedure (para1:longint; para2:longint; para3:longint));cdecl;external glut;
//procedure glutReshapeFunc(callback:procedure (para1:longint; para2:longint));cdecl;external glut;
//procedure glutVisibilityFunc(callback:procedure (para1:longint));cdecl;external glut;

type Tfunc0=procedure;cdecl;
procedure glutDisplayFunc(callback:Tfunc0 );cdecl;external glutLib;
//procedure glutMouseFunc(callback:procedure (para1:longint; para2:longint; para3:longint; para4:longint));cdecl;external glut;
//procedure glutMotionFunc(callback:procedure (para1:longint; para2:longint));cdecl;external glut;
//procedure glutPassiveMotionFunc(callback:procedure (para1:longint; para2:longint));cdecl;external glut;
//procedure glutFunc(callback:procedure (para1:longint));cdecl;external glut;
//procedure glutKeyboardUpFunc(callback:procedure (para1:byte; para2:longint; para3:longint));cdecl;external glut;
//procedure glutSpecialUpFunc(callback:procedure (para1:longint; para2:longint; para3:longint));cdecl;external glut;
//procedure glutJoystickFunc(callback:procedure (para1:dword; para2:longint; para3:longint; para4:longint); pollInterval:longint);cdecl;external glut;
//procedure glutMenuStateFunc(callback:procedure (para1:longint));cdecl;external glut;
//procedure glutMenuStatusFunc(callback:procedure (para1:longint; para2:longint; para3:longint));cdecl;external glut;
//procedure glutOverlayDisplayFunc(callback:procedure );cdecl;external glut;
//procedure glutWindowStatusFunc(callback:procedure (para1:longint));cdecl;external glut;
//procedure glutSpaceballMotionFunc(callback:procedure (para1:longint; para2:longint; para3:longint));cdecl;external glut;
//procedure glutSpaceballRotateFunc(callback:procedure (para1:longint; para2:longint; para3:longint));cdecl;external glut;
//procedure glutSpaceballButtonFunc(callback:procedure (para1:longint; para2:longint));cdecl;external glut;
//procedure glutButtonBoxFunc(callback:procedure (para1:longint; para2:longint));cdecl;external glut;
//procedure glutDialsFunc(callback:procedure (para1:longint; para2:longint));cdecl;external glut;
//procedure glutTabletMotionFunc(callback:procedure (para1:longint; para2:longint));cdecl;external glut;
//procedure glutTabletButtonFunc(callback:procedure (para1:longint; para2:longint; para3:longint; para4:longint));cdecl;external glut;
{
 * State setting and retrieval functions, see freeglut_state.c
  }
function glutGet(query:TGLenum):longint;cdecl;external glutLib;
function glutDeviceGet(query:TGLenum):longint;cdecl;external glutLib;
function glutGetModifiers:longint;cdecl;external glutLib;
function glutLayerGet(query:TGLenum):longint;cdecl;external glutLib;
{
 * Font stuff, see freeglut_font.c
  }
procedure glutBitmapCharacter(font:pointer; character:longint);cdecl;external glutLib;
function glutBitmapWidth(font:pointer; character:longint):longint;cdecl;external glutLib;
procedure glutStrokeCharacter(font:pointer; character:longint);cdecl;external glutLib;
function glutStrokeWidth(font:pointer; character:longint):longint;cdecl;external glutLib;
(* Const before type ignored *)
function glutBitmapLength(font:pointer; _string:Pbyte):longint;cdecl;external glutLib;
(* Const before type ignored *)
function glutStrokeLength(font:pointer; _string:Pbyte):longint;cdecl;external glutLib;
{
 * Geometry functions, see freeglut_geometry.c
  }
procedure glutWireCube(size:TGLdouble);cdecl;external glutLib;
procedure glutSolidCube(size:TGLdouble);cdecl;external glutLib;
procedure glutWireSphere(radius:TGLdouble; slices:TGLint; stacks:TGLint);cdecl;external glutLib;
procedure glutSolidSphere(radius:TGLdouble; slices:TGLint; stacks:TGLint);cdecl;external glutLib;
procedure glutWireCone(base:TGLdouble; height:TGLdouble; slices:TGLint; stacks:TGLint);cdecl;external glutLib;
procedure glutSolidCone(base:TGLdouble; height:TGLdouble; slices:TGLint; stacks:TGLint);cdecl;external glutLib;
procedure glutWireTorus(innerRadius:TGLdouble; outerRadius:TGLdouble; sides:TGLint; rings:TGLint);cdecl;external glutLib;
procedure glutSolidTorus(innerRadius:TGLdouble; outerRadius:TGLdouble; sides:TGLint; rings:TGLint);cdecl;external glutLib;
procedure glutWireDodecahedron;cdecl;external glutLib;
procedure glutSolidDodecahedron;cdecl;external glutLib;
procedure glutWireOctahedron;cdecl;external glutLib;
procedure glutSolidOctahedron;cdecl;external glutLib;
procedure glutWireTetrahedron;cdecl;external glutLib;
procedure glutSolidTetrahedron;cdecl;external glutLib;
procedure glutWireIcosahedron;cdecl;external glutLib;
procedure glutSolidIcosahedron;cdecl;external glutLib;
{
 * Teapot rendering functions, found in freeglut_teapot.c
 * NB: front facing polygons have clockwise winding, not counter clockwise
  }
procedure glutWireTeapot(size:TGLdouble);cdecl;external glutLib;
procedure glutSolidTeapot(size:TGLdouble);cdecl;external glutLib;
{
 * Game mode functions, see freeglut_gamemode.c
  }
(* Const before type ignored *)
procedure glutGameModeString(_string:Pchar);cdecl;external glutLib;
function glutEnterGameMode:longint;cdecl;external glutLib;
procedure glutLeaveGameMode;cdecl;external glutLib;
function glutGameModeGet(query:TGLenum):longint;cdecl;external glutLib;
{
 * Video resize functions, see freeglut_videoresize.c
  }
function glutVideoResizeGet(query:TGLenum):longint;cdecl;external glutLib;
procedure glutSetupVideoResizing;cdecl;external glutLib;
procedure glutStopVideoResizing;cdecl;external glutLib;
procedure glutVideoResize(x:longint; y:longint; width:longint; height:longint);cdecl;external glutLib;
procedure glutVideoPan(x:longint; y:longint; width:longint; height:longint);cdecl;external glutLib;
{
 * Colormap functions, see freeglut_misc.c
  }
procedure glutSetColor(color:longint; red:TGLfloat; green:TGLfloat; blue:TGLfloat);cdecl;external glutLib;
function glutGetColor(color:longint; component:longint):TGLfloat;cdecl;external glutLib;
procedure glutCopyColormap(window:longint);cdecl;external glutLib;
{
 * Misc keyboard and joystick functions, see freeglut_misc.c
  }
procedure glutIgnoreKeyRepeat(ignore:longint);cdecl;external glutLib;
procedure glutSetKeyRepeat(repeatMode:longint);cdecl;external glutLib;
procedure glutForceJoystickFunc;cdecl;external glutLib;
{
 * Misc functions, see freeglut_misc.c
  }
(* Const before type ignored *)
function glutExtensionSupported(extension:Pchar):longint;cdecl;external glutLib;
procedure glutReportErrors;cdecl;external glutLib;
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


end.
