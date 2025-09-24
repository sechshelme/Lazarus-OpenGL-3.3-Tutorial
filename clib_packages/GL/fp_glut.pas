unit fp_glut;

interface

uses
  fp_glew;

const
  {$ifdef linux}
  libglut = 'libglut';
  {$endif}

  {$ifdef windows}
  libglut = 'libglut.dll';
  {$endif}

  {$ifdef darwin}
  libglut = 'glut.dynlib';
  {$endif}


  {$IFDEF FPC}
  {$PACKRECORDS C}
  {$ENDIF}

type
  Tva_list = Pointer; // ????


  // === GL/freeglut_std.h

const
  FREEGLUT = 1;
  GLUT_API_VERSION = 4;
  GLUT_XLIB_IMPLEMENTATION = 13;
  FREEGLUT_VERSION_2_0 = 1;

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

  GLUT_LEFT_BUTTON = 0;
  GLUT_MIDDLE_BUTTON = 1;
  GLUT_RIGHT_BUTTON = 2;
  GLUT_DOWN = 0;
  GLUT_UP = 1;
  GLUT_LEFT = 0;
  GLUT_ENTERED = 1;

  GLUT_RGB = 0;
  GLUT_RGBA = 0;
  GLUT_INDEX = 1;
  GLUT_SINGLE = 0;
  GLUT_DOUBLE = 2;
  GLUT_ACCUM = 4;
  GLUT_ALPHA = 8;
  GLUT_DEPTH = 16;
  GLUT_STENCIL = 32;
  GLUT_MULTISAMPLE = 128;
  GLUT_STEREO = 256;
  GLUT_LUMINANCE = 512;

  GLUT_MENU_NOT_IN_USE = 0;
  GLUT_MENU_IN_USE = 1;
  GLUT_NOT_VISIBLE = 0;
  GLUT_VISIBLE = 1;
  GLUT_HIDDEN = 0;
  GLUT_FULLY_RETAINED = 1;
  GLUT_PARTIALLY_RETAINED = 2;
  GLUT_FULLY_COVERED = 3;

  GLUT_STROKE_ROMAN = Pointer(0);
  GLUT_STROKE_MONO_ROMAN = Pointer(1);
  GLUT_BITMAP_9_BY_15 = Pointer(2);
  GLUT_BITMAP_8_BY_13 = Pointer(3);
  GLUT_BITMAP_TIMES_ROMAN_10 = Pointer(4);
  GLUT_BITMAP_TIMES_ROMAN_24 = Pointer(5);
  GLUT_BITMAP_HELVETICA_10 = Pointer(6);
  GLUT_BITMAP_HELVETICA_12 = Pointer(7);
  GLUT_BITMAP_HELVETICA_18 = Pointer(8);

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
  GLUT_WINDOW_FORMAT_ID = $007B;

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

  GLUT_OVERLAY_POSSIBLE = $0320;
  GLUT_LAYER_IN_USE = $0321;
  GLUT_HAS_OVERLAY = $0322;
  GLUT_TRANSPARENT_INDEX = $0323;
  GLUT_NORMAL_DAMAGED = $0324;
  GLUT_OVERLAY_DAMAGED = $0325;

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

  GLUT_NORMAL = 0;
  GLUT_OVERLAY = 1;

  GLUT_ACTIVE_SHIFT = 1;
  GLUT_ACTIVE_CTRL = 2;
  GLUT_ACTIVE_ALT = 4;

  GLUT_CURSOR_RIGHT_ARROW = 0;
  GLUT_CURSOR_LEFT_ARROW = 1;
  GLUT_CURSOR_INFO = 2;
  GLUT_CURSOR_DESTROY = 3;
  GLUT_CURSOR_HELP = 4;
  GLUT_CURSOR_CYCLE = 5;
  GLUT_CURSOR_SPRAY = 6;
  GLUT_CURSOR_WAIT = 7;
  GLUT_CURSOR_TEXT = 8;
  GLUT_CURSOR_CROSSHAIR = 9;
  GLUT_CURSOR_UP_DOWN = 10;
  GLUT_CURSOR_LEFT_RIGHT = 11;
  GLUT_CURSOR_TOP_SIDE = 12;
  GLUT_CURSOR_BOTTOM_SIDE = 13;
  GLUT_CURSOR_LEFT_SIDE = 14;
  GLUT_CURSOR_RIGHT_SIDE = 15;
  GLUT_CURSOR_TOP_LEFT_CORNER = 16;
  GLUT_CURSOR_TOP_RIGHT_CORNER = 17;
  GLUT_CURSOR_BOTTOM_RIGHT_CORNER = 18;
  GLUT_CURSOR_BOTTOM_LEFT_CORNER = 19;
  GLUT_CURSOR_INHERIT = 100;
  GLUT_CURSOR_NONE = 101;
  GLUT_CURSOR_FULL_CROSSHAIR = 102;

  GLUT_RED = 0;
  GLUT_GREEN = 1;
  GLUT_BLUE = 2;

  GLUT_KEY_REPEAT_OFF = 0;
  GLUT_KEY_REPEAT_ON = 1;
  GLUT_KEY_REPEAT_DEFAULT = 2;

  GLUT_JOYSTICK_BUTTON_A = 1;
  GLUT_JOYSTICK_BUTTON_B = 2;
  GLUT_JOYSTICK_BUTTON_C = 4;
  GLUT_JOYSTICK_BUTTON_D = 8;

  GLUT_GAME_MODE_ACTIVE = 0;
  GLUT_GAME_MODE_POSSIBLE = 1;
  GLUT_GAME_MODE_WIDTH = 2;
  GLUT_GAME_MODE_HEIGHT = 3;
  GLUT_GAME_MODE_PIXEL_DEPTH = 4;
  GLUT_GAME_MODE_REFRESH_RATE = 5;
  GLUT_GAME_MODE_DISPLAY_CHANGED = 6;

type
  TglutMenuCallback = procedure(menu: integer); cdecl;
  TglutTimerFunc = procedure(value: integer); cdecl;
  TglutIdleFunc = procedure; cdecl;
  TglutKeyboardFunc = procedure(key: ansichar; x, y: integer); cdecl;
  TglutSpecialFunc = procedure(key: integer; x, y: integer); cdecl;
  TglutReshapeFunc = procedure(width, height: integer); cdecl;
  TglutVisibilityFunc = procedure(state: integer); cdecl;
  TglutDisplayFunc = procedure; cdecl;
  TglutMouseFunc = procedure(button, state, x, y: integer); cdecl;
  TglutMotionFunc = procedure(x, y: integer); cdecl;
  TglutPassiveMotionFunc = procedure(x, y: integer); cdecl;
  TglutEntryFunc = procedure(state: integer); cdecl;
  TglutKeyboardUpFunc = procedure(key: ansichar; x, y: integer); cdecl;
  TglutSpecialUpFunc = procedure(key: integer; x, y: integer); cdecl;
  TglutJoystickFunc = procedure(buttonMask: cardinal; x, y, z: integer); cdecl;
  TglutMenuStateFunc = procedure(state: integer); cdecl;
  TglutMenuStatusFunc = procedure(status, x, y: integer); cdecl;
  TglutOverlayDisplayFunc = procedure; cdecl;
  TglutWindowStatusFunc = procedure(state: integer); cdecl;
  TglutSpaceballMotionFunc = procedure(x, y, z: integer); cdecl;
  TglutSpaceballRotateFunc = procedure(x, y, z: integer); cdecl;
  TglutSpaceballButtonFunc = procedure(button, state: integer); cdecl;
  TglutButtonBoxFunc = procedure(button, state: integer); cdecl;
  TglutDialsFunc = procedure(dial, value: integer); cdecl;
  TglutTabletMotionFunc = procedure(x, y: integer); cdecl;
  TglutTabletButtonFunc = procedure(button, state, x, y: integer); cdecl;

// Initialization functions
procedure glutInit(pargc: PInteger; argv: PPAnsiChar); cdecl; external libglut;
procedure glutInitWindowPosition(x, y: integer); cdecl; external libglut;
procedure glutInitWindowSize(width, height: integer); cdecl; external libglut;
procedure glutInitDisplayMode(displayMode: cardinal); cdecl; external libglut;
procedure glutInitDisplayString(displayMode: pansichar); cdecl; external libglut;

// Process loop function
procedure glutMainLoop; cdecl; external libglut;

// Window management functions
function glutCreateWindow(title: pansichar): integer; cdecl; external libglut;
function glutCreateSubWindow(window, x, y, width, height: integer): integer; cdecl; external libglut;
procedure glutDestroyWindow(window: integer); cdecl; external libglut;
procedure glutSetWindow(window: integer); cdecl; external libglut;
function glutGetWindow: integer; cdecl; external libglut;
procedure glutSetWindowTitle(title: pansichar); cdecl; external libglut;
procedure glutSetIconTitle(title: pansichar); cdecl; external libglut;
procedure glutReshapeWindow(width, height: integer); cdecl; external libglut;
procedure glutPositionWindow(x, y: integer); cdecl; external libglut;
procedure glutShowWindow; cdecl; external libglut;
procedure glutHideWindow; cdecl; external libglut;
procedure glutIconifyWindow; cdecl; external libglut;
procedure glutPushWindow; cdecl; external libglut;
procedure glutPopWindow; cdecl; external libglut;
procedure glutFullScreen; cdecl; external libglut;

// Display-related functions
procedure glutPostWindowRedisplay(window: integer); cdecl; external libglut;
procedure glutPostRedisplay; cdecl; external libglut;
procedure glutSwapBuffers; cdecl; external libglut;

// Mouse cursor functions
procedure glutWarpPointer(x, y: integer); cdecl; external libglut;
procedure glutSetCursor(cursor: integer); cdecl; external libglut;

// Overlay stuff
procedure glutEstablishOverlay; cdecl; external libglut;
procedure glutRemoveOverlay; cdecl; external libglut;
procedure glutUseLayer(layer: TGLenum); cdecl; external libglut;
procedure glutPostOverlayRedisplay; cdecl; external libglut;
procedure glutPostWindowOverlayRedisplay(window: integer); cdecl; external libglut;
procedure glutShowOverlay; cdecl; external libglut;
procedure glutHideOverlay; cdecl; external libglut;

// Menu stuff
function glutCreateMenu(callback: TglutMenuCallback): integer; cdecl; external libglut;
procedure glutDestroyMenu(menu: integer); cdecl; external libglut;
function glutGetMenu: integer; cdecl; external libglut;
procedure glutSetMenu(menu: integer); cdecl; external libglut;
procedure glutAddMenuEntry(label_: pansichar; value: integer); cdecl; external libglut;
procedure glutAddSubMenu(label_: pansichar; subMenu: integer); cdecl; external libglut;
procedure glutChangeToMenuEntry(item: integer; label_: pansichar; value: integer); cdecl; external libglut;
procedure glutChangeToSubMenu(item: integer; label_: pansichar; value: integer); cdecl; external libglut;
procedure glutRemoveMenuItem(item: integer); cdecl; external libglut;
procedure glutAttachMenu(button: integer); cdecl; external libglut;
procedure glutDetachMenu(button: integer); cdecl; external libglut;

// Global callback functions
procedure glutTimerFunc(time: cardinal; callback: TglutTimerFunc; value: integer); cdecl; external libglut;
procedure glutIdleFunc(callback: TglutIdleFunc); cdecl; external libglut;

// Window-specific callback functions
procedure glutKeyboardFunc(callback: TglutKeyboardFunc); cdecl; external libglut;
procedure glutSpecialFunc(callback: TglutSpecialFunc); cdecl; external libglut;
procedure glutReshapeFunc(callback: TglutReshapeFunc); cdecl; external libglut;
procedure glutVisibilityFunc(callback: TglutVisibilityFunc); cdecl; external libglut;
procedure glutDisplayFunc(callback: TglutDisplayFunc); cdecl; external libglut;
procedure glutMouseFunc(callback: TglutMouseFunc); cdecl; external libglut;
procedure glutMotionFunc(callback: TglutMotionFunc); cdecl; external libglut;
procedure glutPassiveMotionFunc(callback: TglutPassiveMotionFunc); cdecl; external libglut;
procedure glutEntryFunc(callback: TglutEntryFunc); cdecl; external libglut;
procedure glutKeyboardUpFunc(callback: TglutKeyboardUpFunc); cdecl; external libglut;
procedure glutSpecialUpFunc(callback: TglutSpecialUpFunc); cdecl; external libglut;
procedure glutJoystickFunc(callback: TglutJoystickFunc; pollInterval: integer); cdecl; external libglut;
procedure glutMenuStateFunc(callback: TglutMenuStateFunc); cdecl; external libglut;
procedure glutMenuStatusFunc(callback: TglutMenuStatusFunc); cdecl; external libglut;
procedure glutOverlayDisplayFunc(callback: TglutOverlayDisplayFunc); cdecl; external libglut;
procedure glutWindowStatusFunc(callback: TglutWindowStatusFunc); cdecl; external libglut;
procedure glutSpaceballMotionFunc(callback: TglutSpaceballMotionFunc); cdecl; external libglut;
procedure glutSpaceballRotateFunc(callback: TglutSpaceballRotateFunc); cdecl; external libglut;
procedure glutSpaceballButtonFunc(callback: TglutSpaceballButtonFunc); cdecl; external libglut;
procedure glutButtonBoxFunc(callback: TglutButtonBoxFunc); cdecl; external libglut;
procedure glutDialsFunc(callback: TglutDialsFunc); cdecl; external libglut;
procedure glutTabletMotionFunc(callback: TglutTabletMotionFunc); cdecl; external libglut;
procedure glutTabletButtonFunc(callback: TglutTabletButtonFunc); cdecl; external libglut;

// State setting and retrieval functions
function glutGet(query: TGLenum): integer; cdecl; external libglut;
function glutDeviceGet(query: TGLenum): integer; cdecl; external libglut;
function glutGetModifiers: integer; cdecl; external libglut;
function glutLayerGet(query: TGLenum): integer; cdecl; external libglut;

// Font stuff
procedure glutBitmapCharacter(font: Pointer; character: integer); cdecl; external libglut;
function glutBitmapWidth(font: Pointer; character: integer): integer; cdecl; external libglut;
procedure glutStrokeCharacter(font: Pointer; character: integer); cdecl; external libglut;
function glutStrokeWidth(font: Pointer; character: integer): integer; cdecl; external libglut;
function glutStrokeWidthf(font: Pointer; character: integer): TGLfloat; cdecl; external libglut;
function glutBitmapLength(font: Pointer; str: pansichar): integer; cdecl; external libglut;
function glutStrokeLength(font: Pointer; str: pansichar): integer; cdecl; external libglut;
function glutStrokeLengthf(font: Pointer; str: pansichar): TGLfloat; cdecl; external libglut;

// Geometry functions
procedure glutWireCube(size: TGLdouble); cdecl; external libglut;
procedure glutSolidCube(size: TGLdouble); cdecl; external libglut;
procedure glutWireSphere(radius: TGLdouble; slices, stacks: TGLint); cdecl; external libglut;
procedure glutSolidSphere(radius: TGLdouble; slices, stacks: TGLint); cdecl; external libglut;
procedure glutWireCone(base, height: TGLdouble; slices, stacks: TGLint); cdecl; external libglut;
procedure glutSolidCone(base, height: TGLdouble; slices, stacks: TGLint); cdecl; external libglut;
procedure glutWireTorus(innerRadius, outerRadius: TGLdouble; sides, rings: TGLint); cdecl; external libglut;
procedure glutSolidTorus(innerRadius, outerRadius: TGLdouble; sides, rings: TGLint); cdecl; external libglut;
procedure glutWireDodecahedron; cdecl; external libglut;
procedure glutSolidDodecahedron; cdecl; external libglut;
procedure glutWireOctahedron; cdecl; external libglut;
procedure glutSolidOctahedron; cdecl; external libglut;
procedure glutWireTetrahedron; cdecl; external libglut;
procedure glutSolidTetrahedron; cdecl; external libglut;
procedure glutWireIcosahedron; cdecl; external libglut;
procedure glutSolidIcosahedron; cdecl; external libglut;

// Teapot rendering functions
procedure glutWireTeapot(size: TGLdouble); cdecl; external libglut;
procedure glutSolidTeapot(size: TGLdouble); cdecl; external libglut;

// Game mode functions
procedure glutGameModeString(str: pansichar); cdecl; external libglut;
function glutEnterGameMode: integer; cdecl; external libglut;
procedure glutLeaveGameMode; cdecl; external libglut;
function glutGameModeGet(query: TGLenum): integer; cdecl; external libglut;

// Video resize functions
function glutVideoResizeGet(query: TGLenum): integer; cdecl; external libglut;
procedure glutSetupVideoResizing; cdecl; external libglut;
procedure glutStopVideoResizing; cdecl; external libglut;
procedure glutVideoResize(x, y, width, height: integer); cdecl; external libglut;
procedure glutVideoPan(x, y, width, height: integer); cdecl; external libglut;

// Colormap functions
procedure glutSetColor(color: integer; red, green, blue: TGLfloat); cdecl; external libglut;
function glutGetColor(color, component: integer): TGLfloat; cdecl; external libglut;
procedure glutCopyColormap(window: integer); cdecl; external libglut;

// Misc keyboard and joystick functions
procedure glutIgnoreKeyRepeat(ignore: integer); cdecl; external libglut;
procedure glutSetKeyRepeat(repeatMode: integer); cdecl; external libglut;
procedure glutForceJoystickFunc; cdecl; external libglut;

// Misc functions
function glutExtensionSupported(extension: pansichar): integer; cdecl; external libglut;
procedure glutReportErrors; cdecl; external libglut;


// ==== GL/freeglut_ext.h

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

type
  TglutErrorFunc = procedure(fmt: pansichar; ap: Tva_list); cdecl;
  TglutWarningFunc = procedure(fmt: pansichar; ap: Tva_list); cdecl;

  TglutMouseWheelFunc = procedure(wheel, direction, x, y: integer); cdecl;
  TglutPositionFunc = procedure(x, y: integer); cdecl;
  TglutCloseFunc = procedure; cdecl;
  TglutMenuDestroyFunc = procedure; cdecl;

  TGLUTproc = procedure; cdecl;

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
procedure glutSetOption(option_flag: TGLenum; value: integer); cdecl; external libglut;
function glutGetModeValues(mode: TGLenum; var size: integer): PInteger; cdecl; external libglut;
function glutGetWindowData: Pointer; cdecl; external libglut;
procedure glutSetWindowData(data: Pointer); cdecl; external libglut;
function glutGetMenuData: Pointer; cdecl; external libglut;
procedure glutSetMenuData(data: Pointer); cdecl; external libglut;

// Font stuff
function glutBitmapHeight(font: Pointer): integer; cdecl; external libglut;
function glutStrokeHeight(font: Pointer): TGLfloat; cdecl; external libglut;
procedure glutBitmapString(font: Pointer; str: pansichar); cdecl; external libglut;
procedure glutStrokeString(font: Pointer; str: pansichar); cdecl; external libglut;

// Geometry functions
procedure glutWireRhombicDodecahedron; cdecl; external libglut;
procedure glutSolidRhombicDodecahedron; cdecl; external libglut;
procedure glutWireSierpinskiSponge(num_levels: integer; offset: PDouble; scale: TGLdouble); cdecl; external libglut;
procedure glutSolidSierpinskiSponge(num_levels: integer; offset: PDouble; scale: TGLdouble); cdecl; external libglut;
procedure glutWireCylinder(radius, height: TGLdouble; slices, stacks: TGLint); cdecl; external libglut;
procedure glutSolidCylinder(radius, height: TGLdouble; slices, stacks: TGLint); cdecl; external libglut;

// Teaset rendering functions
procedure glutWireTeacup(size: TGLdouble); cdecl; external libglut;
procedure glutSolidTeacup(size: TGLdouble); cdecl; external libglut;
procedure glutWireTeaspoon(size: TGLdouble); cdecl; external libglut;
procedure glutSolidTeaspoon(size: TGLdouble); cdecl; external libglut;

// Extension functions
function glutGetProcAddress(procName: pansichar): TGLUTproc; cdecl; external libglut;

// Multi-touch/multi-pointer extensions
procedure glutMultiEntryFunc(callback: TglutMultiEntryFunc); cdecl; external libglut;
procedure glutMultiButtonFunc(callback: TglutMultiButtonFunc); cdecl; external libglut;
procedure glutMultiMotionFunc(callback: TglutMultiMotionFunc); cdecl; external libglut;
procedure glutMultiPassiveFunc(callback: TglutMultiPassiveFunc); cdecl; external libglut;

// --- Veraltete Joystick-Funktionen ---
function glutJoystickGetNumAxes(ident: integer): integer; cdecl; external libglut; deprecated;
function glutJoystickGetNumButtons(ident: integer): integer; cdecl; external libglut; deprecated;
function glutJoystickNotWorking(ident: integer): integer; cdecl; external libglut; deprecated;
function glutJoystickGetDeadBand(ident, axis: integer): single; cdecl; external libglut; deprecated;
procedure glutJoystickSetDeadBand(ident, axis: integer; db: single); cdecl; external libglut; deprecated;
function glutJoystickGetSaturation(ident, axis: integer): single; cdecl; external libglut; deprecated;
procedure glutJoystickSetSaturation(ident, axis: integer; st: single); cdecl; external libglut; deprecated;
procedure glutJoystickSetMinRange(ident: integer; axes: PSingle); cdecl; external libglut; deprecated;
procedure glutJoystickSetMaxRange(ident: integer; axes: PSingle); cdecl; external libglut; deprecated;
procedure glutJoystickSetCenter(ident: integer; axes: PSingle); cdecl; external libglut; deprecated;
procedure glutJoystickGetMinRange(ident: integer; axes: PSingle); cdecl; external libglut; deprecated;
procedure glutJoystickGetMaxRange(ident: integer; axes: PSingle); cdecl; external libglut; deprecated;
procedure glutJoystickGetCenter(ident: integer; axes: PSingle); cdecl; external libglut; deprecated;

// Initialization functions
procedure glutInitContextVersion(majorVersion, minorVersion: integer); cdecl; external libglut;
procedure glutInitContextFlags(flags: integer); cdecl; external libglut;
procedure glutInitContextProfile(profile: integer); cdecl; external libglut;
procedure glutInitErrorFunc(callback: TglutErrorFunc); cdecl; external libglut;
procedure glutInitWarningFunc(callback: TglutWarningFunc); cdecl; external libglut;

// OpenGL >= 2.0 support
procedure glutSetVertexAttribCoord3(attrib: TGLint); cdecl; external libglut;
procedure glutSetVertexAttribNormal(attrib: TGLint); cdecl; external libglut;
procedure glutSetVertexAttribTexCoord2(attrib: TGLint); cdecl; external libglut;

// Mobile platforms lifecycle
procedure glutInitContextFunc(callback: TglutInitContextFunc); cdecl; external libglut;
procedure glutAppStatusFunc(callback: TglutAppStatusFunc); cdecl; external libglut;

const
  GLUT_APPSTATUS_PAUSE = $0001;
  GLUT_APPSTATUS_RESUME = $0002;

  GLUT_CAPTIONLESS = $0400;
  GLUT_BORDERLESS = $0800;
  GLUT_SRGB = $1000;


  // ==== GL/freeglut_ucall.h

type
  TglutMenuCallback2 = procedure(menu: integer; user: pointer); cdecl;
  TglutTimerCallback = procedure(value: integer; user: pointer); cdecl;
  TglutIdleCallback = procedure(user: pointer); cdecl;
  TglutKeyboardCallback = procedure(key: char; x, y: integer; user: pointer); cdecl;
  TglutSpecialCallback = procedure(key, x, y: integer; user: pointer); cdecl;
  TglutReshapeCallback = procedure(w, h: integer; user: pointer); cdecl;
  TglutVisibilityCallback = procedure(state: integer; user: pointer); cdecl;
  TglutDisplayCallback = procedure(user: pointer); cdecl;
  TglutMouseCallback = procedure(button, state, x, y: integer; user: pointer); cdecl;
  TglutMotionCallback = procedure(x, y: integer; user: pointer); cdecl;
  TglutPassiveMotionCallback = procedure(x, y: integer; user: pointer); cdecl;
  TglutEntryCallback = procedure(state: integer; user: pointer); cdecl;
  TglutKeyboardUpCallback = procedure(key: char; x, y: integer; user: pointer); cdecl;
  TglutSpecialUpCallback = procedure(key, x, y: integer; user: pointer); cdecl;
  TglutJoystickCallback = procedure(buttonMask: uint32; x, y, z: integer; user: pointer); cdecl;
  TglutMenuStatusCallback = procedure(status, x, y: integer; user: pointer); cdecl;
  TglutOverlayDisplayCallback = procedure(user: pointer); cdecl;
  TglutWindowStatusCallback = procedure(state: integer; user: pointer); cdecl;
  TglutSpaceballMotionCallback = procedure(x, y, z: integer; user: pointer); cdecl;
  TglutSpaceballRotateCallback = procedure(x, y, z: integer; user: pointer); cdecl;
  TglutSpaceballButtonCallback = procedure(button, state: integer; user: pointer); cdecl;
  TglutButtonBoxCallback = procedure(button, state: integer; user: pointer); cdecl;
  TglutDialsCallback = procedure(dial, value: integer; user: pointer); cdecl;
  TglutTabletMotionCallback = procedure(x, y: integer; user: pointer); cdecl;
  TglutTabletButtonCallback = procedure(button, state, x, y: integer; user: pointer); cdecl;
  TglutMouseWheelCallback = procedure(wheel, direction, x, y: integer; user: pointer); cdecl;
  TglutPositionCallback = procedure(x, y: integer; user: pointer); cdecl;
  TglutSimpleCallback = procedure(user: pointer); cdecl;
  TglutMultiEntryCallback = procedure(id, state: integer; user: pointer); cdecl;
  TglutMultiButtonCallback = procedure(id, button, state, x, y: integer; user: pointer); cdecl;
  TglutMultiMotionCallback = procedure(id, x, y: integer; user: pointer); cdecl;
  TglutMultiPassiveCallback = procedure(id, x, y: integer; user: pointer); cdecl;
  TglutInitErrorCallback = procedure(fmt: pchar; ap: Tva_list; user: pointer); cdecl;
  TglutInitWarningCallback = procedure(fmt: pchar; ap: Tva_list; user: pointer); cdecl;
  TglutAppStatusCallback = procedure(status: integer; user: pointer); cdecl;

function glutCreateMenuUcall(cb: TglutMenuCallback2; user: pointer): integer; cdecl; external libglut;

procedure glutTimerFuncUcall(time: uint32; cb: TglutTimerCallback; value: integer; user: pointer); cdecl; external libglut;
procedure glutIdleFuncUcall(cb: TglutIdleCallback; user: pointer); cdecl; external libglut;

procedure glutKeyboardFuncUcall(cb: TglutKeyboardCallback; user: pointer); cdecl; external libglut;
procedure glutSpecialFuncUcall(cb: TglutSpecialCallback; user: pointer); cdecl; external libglut;
procedure glutReshapeFuncUcall(cb: TglutReshapeCallback; user: pointer); cdecl; external libglut;
procedure glutDisplayFuncUcall(cb: TglutDisplayCallback; user: pointer); cdecl; external libglut;
procedure glutMouseFuncUcall(cb: TglutMouseCallback; user: pointer); cdecl; external libglut;
procedure glutMotionFuncUcall(cb: TglutMotionCallback; user: pointer); cdecl; external libglut;
procedure glutPassiveMotionFuncUcall(cb: TglutPassiveMotionCallback; user: pointer); cdecl; external libglut;
procedure glutEntryFuncUcall(cb: TglutEntryCallback; user: pointer); cdecl; external libglut;

procedure glutKeyboardUpFuncUcall(cb: TglutKeyboardUpCallback; user: pointer); cdecl; external libglut;
procedure glutSpecialUpFuncUcall(cb: TglutSpecialUpCallback; user: pointer); cdecl; external libglut;
procedure glutJoystickFuncUcall(cb: TglutJoystickCallback; pollInterval: integer; user: pointer); cdecl; external libglut;
procedure glutMenuStatusFuncUcall(cb: TglutMenuStatusCallback; user: pointer); cdecl; external libglut;
procedure glutOverlayDisplayFuncUcall(cb: TglutOverlayDisplayCallback; user: pointer); cdecl; external libglut;
procedure glutWindowStatusFuncUcall(cb: TglutWindowStatusCallback; user: pointer); cdecl; external libglut;

procedure glutSpaceballMotionFuncUcall(cb: TglutSpaceballMotionCallback; user: pointer); cdecl; external libglut;
procedure glutSpaceballRotateFuncUcall(cb: TglutSpaceballRotateCallback; user: pointer); cdecl; external libglut;
procedure glutSpaceballButtonFuncUcall(cb: TglutSpaceballButtonCallback; user: pointer); cdecl; external libglut;
procedure glutButtonBoxFuncUcall(cb: TglutButtonBoxCallback; user: pointer); cdecl; external libglut;
procedure glutDialsFuncUcall(cb: TglutDialsCallback; user: pointer); cdecl; external libglut;
procedure glutTabletMotionFuncUcall(cb: TglutTabletMotionCallback; user: pointer); cdecl; external libglut;
procedure glutTabletButtonFuncUcall(cb: TglutTabletButtonCallback; user: pointer); cdecl; external libglut;

procedure glutMouseWheelFuncUcall(cb: TglutMouseWheelCallback; user: pointer); cdecl; external libglut;
procedure glutPositionFuncUcall(cb: TglutPositionCallback; user: pointer); cdecl; external libglut;
procedure glutCloseFuncUcall(cb: TglutSimpleCallback; user: pointer); cdecl; external libglut;
procedure glutWMCloseFuncUcall(cb: TglutSimpleCallback; user: pointer); cdecl; external libglut;
procedure glutMenuDestroyFuncUcall(cb: TglutSimpleCallback; user: pointer); cdecl; external libglut;

procedure glutMultiEntryFuncUcall(cb: TglutMultiEntryCallback; user: pointer); cdecl; external libglut;
procedure glutMultiButtonFuncUcall(cb: TglutMultiButtonCallback; user: pointer); cdecl; external libglut;
procedure glutMultiMotionFuncUcall(cb: TglutMultiMotionCallback; user: pointer); cdecl; external libglut;
procedure glutMultiPassiveFuncUcall(cb: TglutMultiPassiveCallback; user: pointer); cdecl; external libglut;

procedure glutInitErrorFuncUcall(cb: TglutInitErrorCallback; user: pointer); cdecl; external libglut;
procedure glutInitWarningFuncUcall(cb: TglutInitWarningCallback; user: pointer); cdecl; external libglut;
procedure glutInitContextFuncUcall(cb: TglutSimpleCallback; user: pointer); cdecl; external libglut;
procedure glutAppStatusFuncUcall(cb: TglutAppStatusCallback; user: pointer); cdecl; external libglut;



implementation



end.
