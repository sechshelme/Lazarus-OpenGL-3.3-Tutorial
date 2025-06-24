unit fp_freeglut_std;

interface

uses
  gl;

const
  {$ifdef linux}
  libglut = 'libglut';
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


  // --- Constants ---

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


  // --- Function Declarations ---

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
procedure glutUseLayer(layer: GLenum); cdecl; external libglut;
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
function glutGet(query: GLenum): integer; cdecl; external libglut;
function glutDeviceGet(query: GLenum): integer; cdecl; external libglut;
function glutGetModifiers: integer; cdecl; external libglut;
function glutLayerGet(query: GLenum): integer; cdecl; external libglut;

// Font stuff
procedure glutBitmapCharacter(font: Pointer; character: integer); cdecl; external libglut;
function glutBitmapWidth(font: Pointer; character: integer): integer; cdecl; external libglut;
procedure glutStrokeCharacter(font: Pointer; character: integer); cdecl; external libglut;
function glutStrokeWidth(font: Pointer; character: integer): integer; cdecl; external libglut;
function glutStrokeWidthf(font: Pointer; character: integer): GLfloat; cdecl; external libglut;
function glutBitmapLength(font: Pointer; str: pansichar): integer; cdecl; external libglut;
function glutStrokeLength(font: Pointer; str: pansichar): integer; cdecl; external libglut;
function glutStrokeLengthf(font: Pointer; str: pansichar): GLfloat; cdecl; external libglut;

// Geometry functions
procedure glutWireCube(size: GLdouble); cdecl; external libglut;
procedure glutSolidCube(size: GLdouble); cdecl; external libglut;
procedure glutWireSphere(radius: GLdouble; slices, stacks: GLint); cdecl; external libglut;
procedure glutSolidSphere(radius: GLdouble; slices, stacks: GLint); cdecl; external libglut;
procedure glutWireCone(base, height: GLdouble; slices, stacks: GLint); cdecl; external libglut;
procedure glutSolidCone(base, height: GLdouble; slices, stacks: GLint); cdecl; external libglut;
procedure glutWireTorus(innerRadius, outerRadius: GLdouble; sides, rings: GLint); cdecl; external libglut;
procedure glutSolidTorus(innerRadius, outerRadius: GLdouble; sides, rings: GLint); cdecl; external libglut;
procedure glutWireDodecahedron; cdecl; external libglut;
procedure glutSolidDodecahedron; cdecl; external libglut;
procedure glutWireOctahedron; cdecl; external libglut;
procedure glutSolidOctahedron; cdecl; external libglut;
procedure glutWireTetrahedron; cdecl; external libglut;
procedure glutSolidTetrahedron; cdecl; external libglut;
procedure glutWireIcosahedron; cdecl; external libglut;
procedure glutSolidIcosahedron; cdecl; external libglut;

// Teapot rendering functions
procedure glutWireTeapot(size: GLdouble); cdecl; external libglut;
procedure glutSolidTeapot(size: GLdouble); cdecl; external libglut;

// Game mode functions
procedure glutGameModeString(str: pansichar); cdecl; external libglut;
function glutEnterGameMode: integer; cdecl; external libglut;
procedure glutLeaveGameMode; cdecl; external libglut;
function glutGameModeGet(query: GLenum): integer; cdecl; external libglut;

// Video resize functions
function glutVideoResizeGet(query: GLenum): integer; cdecl; external libglut;
procedure glutSetupVideoResizing; cdecl; external libglut;
procedure glutStopVideoResizing; cdecl; external libglut;
procedure glutVideoResize(x, y, width, height: integer); cdecl; external libglut;
procedure glutVideoPan(x, y, width, height: integer); cdecl; external libglut;

// Colormap functions
procedure glutSetColor(color: integer; red, green, blue: GLfloat); cdecl; external libglut;
function glutGetColor(color, component: integer): GLfloat; cdecl; external libglut;
procedure glutCopyColormap(window: integer); cdecl; external libglut;

// Misc keyboard and joystick functions
procedure glutIgnoreKeyRepeat(ignore: integer); cdecl; external libglut;
procedure glutSetKeyRepeat(repeatMode: integer); cdecl; external libglut;
procedure glutForceJoystickFunc; cdecl; external libglut;

// Misc functions
function glutExtensionSupported(extension: pansichar): integer; cdecl; external libglut;
procedure glutReportErrors; cdecl; external libglut;

implementation

end.
