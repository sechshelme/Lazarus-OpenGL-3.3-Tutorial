unit fp_freeglut_ext;

interface

uses
  gl,
  fp_freeglut_std;

  {$IFDEF FPC}
  {$PACKRECORDS C}
  {$ENDIF}


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
  GLUT_KEY_SUPER_L = $0076;
  GLUT_KEY_SUPER_R = $0077;

  GLUT_ACTIVE_SUPER = $0008;

  GLUT_ACTION_EXIT = 0;
  GLUT_ACTION_GLUTMAINLOOP_RETURNS = 1;
  GLUT_ACTION_CONTINUE_EXECUTION = 2;

  GLUT_CREATE_NEW_CONTEXT = 0;
  GLUT_USE_CURRENT_CONTEXT = 1;

  GLUT_FORCE_INDIRECT_CONTEXT = 0;
  GLUT_ALLOW_DIRECT_CONTEXT = 1;
  GLUT_TRY_DIRECT_CONTEXT = 2;
  GLUT_FORCE_DIRECT_CONTEXT = 3;

  GLUT_INIT_STATE = $007C;
  GLUT_ACTION_ON_WINDOW_CLOSE = $01F9;
  GLUT_WINDOW_BORDER_WIDTH = $01FA;
  GLUT_WINDOW_BORDER_HEIGHT = $01FB;
  GLUT_WINDOW_HEADER_HEIGHT = $01FB;
  GLUT_VERSION = $01FC;
  GLUT_RENDERING_CONTEXT = $01FD;
  GLUT_DIRECT_RENDERING = $01FE;
  GLUT_FULL_SCREEN = $01FF;
  GLUT_SKIP_STALE_MOTION_EVENTS = $0204;
  GLUT_GEOMETRY_VISUALIZE_NORMALS = $0205;
  GLUT_STROKE_FONT_DRAW_JOIN_DOTS = $0206;
  GLUT_ALLOW_NEGATIVE_WINDOW_POSITION = $0207;
  GLUT_WINDOW_SRGB = $007D;

  GLUT_AUX = $1000;
  GLUT_AUX1 = $1000;
  GLUT_AUX2 = $2000;
  GLUT_AUX3 = $4000;
  GLUT_AUX4 = $8000;

  GLUT_INIT_MAJOR_VERSION = $0200;
  GLUT_INIT_MINOR_VERSION = $0201;
  GLUT_INIT_FLAGS = $0202;
  GLUT_INIT_PROFILE = $0203;

  GLUT_DEBUG = $0001;
  GLUT_FORWARD_COMPATIBLE = $0002;

  GLUT_CORE_PROFILE = $0001;
  GLUT_COMPATIBILITY_PROFILE = $0002;

  GLUT_SPACEBALL_BUTTON_A = $0001;
  GLUT_SPACEBALL_BUTTON_B = $0002;
  GLUT_SPACEBALL_BUTTON_C = $0004;
  GLUT_SPACEBALL_BUTTON_D = $0008;
  GLUT_SPACEBALL_BUTTON_E = $0010;

  GLUT_HAS_MULTI = 1;

  GLUT_APPSTATUS_PAUSE = $0001;
  GLUT_APPSTATUS_RESUME = $0002;

  GLUT_CAPTIONLESS = $0400;
  GLUT_BORDERLESS = $0800;
  GLUT_SRGB = $1000;


type
  va_list = Pointer; // ????

  TglutErrorFunc = procedure(fmt: pansichar; ap: va_list); cdecl;
  TglutWarningFunc = procedure(fmt: pansichar; ap: va_list); cdecl;

  TglutMouseWheelFunc = procedure(wheel, direction, x, y: integer); cdecl;
  TglutPositionFunc = procedure(x, y: integer); cdecl;
  TglutCloseFunc = procedure; cdecl;
  TglutMenuDestroyFunc = procedure; cdecl;

  TGLUTproc = procedure;

  TglutMultiEntryFunc = procedure(winID, state: integer); cdecl;
  TglutMultiButtonFunc = procedure(winID, x, y, button, state: integer); cdecl;
  TglutMultiMotionFunc = procedure(winID, x, y: integer); cdecl;
  TglutMultiPassiveFunc = procedure(winID, x, y: integer); cdecl;

  TglutInitContextFunc = procedure; cdecl;
  TglutAppStatusFunc = procedure(status: integer); cdecl;


  // --- Funktionsdeklarationen der Erweiterungen ---

// Process loop functions
procedure glutMainLoopEvent; cdecl; external libglut;
procedure glutLeaveMainLoop; cdecl; external libglut;
procedure glutExit; cdecl; external libglut;

// Window management functions
procedure glutFullScreenToggle; cdecl; external libglut;
procedure glutLeaveFullScreen; cdecl; external libglut;

// Menu functions
procedure glutSetMenuFont(menuID: integer; font: Pointer); cdecl; external libglut;

// Window-specific callback functions
procedure glutMouseWheelFunc(callback: TglutMouseWheelFunc); cdecl; external libglut;
procedure glutPositionFunc(callback: TglutPositionFunc); cdecl; external libglut;
procedure glutCloseFunc(callback: TglutCloseFunc); cdecl; external libglut;
procedure glutWMCloseFunc(callback: TglutCloseFunc); cdecl; external libglut;
procedure glutMenuDestroyFunc(callback: TglutMenuDestroyFunc); cdecl; external libglut;

// State setting and retrieval functions
procedure glutSetOption(option_flag: GLenum; value: integer); cdecl; external libglut;
function glutGetModeValues(mode: GLenum; var size: integer): PInteger; cdecl; external libglut;
function glutGetWindowData: Pointer; cdecl; external libglut;
procedure glutSetWindowData(data: Pointer); cdecl; external libglut;
function glutGetMenuData: Pointer; cdecl; external libglut;
procedure glutSetMenuData(data: Pointer); cdecl; external libglut;

// Font stuff
function glutBitmapHeight(font: Pointer): integer; cdecl; external libglut;
function glutStrokeHeight(font: Pointer): GLfloat; cdecl; external libglut;
procedure glutBitmapString(font: Pointer; str: pansichar); cdecl; external libglut;
procedure glutStrokeString(font: Pointer; str: pansichar); cdecl; external libglut;

// Geometry functions
procedure glutWireRhombicDodecahedron; cdecl; external libglut;
procedure glutSolidRhombicDodecahedron; cdecl; external libglut;
procedure glutWireSierpinskiSponge(num_levels: integer; offset: PDouble; scale: GLdouble); cdecl; external libglut;
procedure glutSolidSierpinskiSponge(num_levels: integer; offset: PDouble; scale: GLdouble); cdecl; external libglut;
procedure glutWireCylinder(radius, height: GLdouble; slices, stacks: GLint); cdecl; external libglut;
procedure glutSolidCylinder(radius, height: GLdouble; slices, stacks: GLint); cdecl; external libglut;

// Teaset rendering functions
procedure glutWireTeacup(size: GLdouble); cdecl; external libglut;
procedure glutSolidTeacup(size: GLdouble); cdecl; external libglut;
procedure glutWireTeaspoon(size: GLdouble); cdecl; external libglut;
procedure glutSolidTeaspoon(size: GLdouble); cdecl; external libglut;

// Extension functions
function glutGetProcAddress(procName: pansichar): TGLUTproc; cdecl; external libglut;

// Multi-touch/multi-pointer extensions
procedure glutMultiEntryFunc(callback: TglutMultiEntryFunc); cdecl; external libglut;
procedure glutMultiButtonFunc(callback: TglutMultiButtonFunc); cdecl; external libglut;
procedure glutMultiMotionFunc(callback: TglutMultiMotionFunc); cdecl; external libglut;
procedure glutMultiPassiveFunc(callback: TglutMultiPassiveFunc); cdecl; external libglut;

// Initialization functions
procedure glutInitContextVersion(majorVersion, minorVersion: integer); cdecl; external libglut;
procedure glutInitContextFlags(flags: integer); cdecl; external libglut;
procedure glutInitContextProfile(profile: integer); cdecl; external libglut;
procedure glutInitErrorFunc(callback: TglutErrorFunc); cdecl; external libglut;
procedure glutInitWarningFunc(callback: TglutWarningFunc); cdecl; external libglut;

// OpenGL >= 2.0 support
procedure glutSetVertexAttribCoord3(attrib: GLint); cdecl; external libglut;
procedure glutSetVertexAttribNormal(attrib: GLint); cdecl; external libglut;
procedure glutSetVertexAttribTexCoord2(attrib: GLint); cdecl; external libglut;

// Mobile platforms lifecycle
procedure glutInitContextFunc(callback: TglutInitContextFunc); cdecl; external libglut;
procedure glutAppStatusFunc(callback: TglutAppStatusFunc); cdecl; external libglut;


// --- Veraltete Joystick-Funktionen ---
// HINWEIS: Die Header-Datei deklariert diese als veraltet und ohne die
// Standard-Aufrufkonvention (FGAPIENTRY). Wir verwenden hier 'cdecl' zur
// Sicherheit, da dies der C-Standard ist.

function glutJoystickGetNumAxes(ident: integer): integer; cdecl; external libglut;
function glutJoystickGetNumButtons(ident: integer): integer; cdecl; external libglut;
function glutJoystickNotWorking(ident: integer): integer; cdecl; external libglut;
function glutJoystickGetDeadBand(ident, axis: integer): single; cdecl; external libglut;
procedure glutJoystickSetDeadBand(ident, axis: integer; db: single); cdecl; external libglut;
function glutJoystickGetSaturation(ident, axis: integer): single; cdecl; external libglut;
procedure glutJoystickSetSaturation(ident, axis: integer; st: single); cdecl; external libglut;
procedure glutJoystickSetMinRange(ident: integer; axes: PSingle); cdecl; external libglut;
procedure glutJoystickSetMaxRange(ident: integer; axes: PSingle); cdecl; external libglut;
procedure glutJoystickSetCenter(ident: integer; axes: PSingle); cdecl; external libglut;
procedure glutJoystickGetMinRange(ident: integer; axes: PSingle); cdecl; external libglut;
procedure glutJoystickGetMaxRange(ident: integer; axes: PSingle); cdecl; external libglut;
procedure glutJoystickGetCenter(ident: integer; axes: PSingle); cdecl; external libglut;


implementation

// Der 'implementation'-Teil ist leer, da alle Funktionen extern sind.

end.
