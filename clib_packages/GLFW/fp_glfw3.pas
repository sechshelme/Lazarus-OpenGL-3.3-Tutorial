unit fp_glfw3;

interface

uses
  ctypes;

const
  {$ifdef linux}
  libglfw = 'libglfw';
  {$endif}

  {$ifdef windows}
  libglfw = 'glfw3.dll';
  {$endif}

  {$ifdef darwin}
  libglfw = 'libglfw.dynlib';
  {$endif}

type
  TVkInstance = Pointer;
  TVkPhysicalDevice = Pointer;
  PVkAllocationCallbacks = Pointer;
  PVkSurfaceKHR = Pointer;
  TVkResult = Pointer;

  {$IFDEF FPC}
  {$PACKRECORDS C}
  {$ENDIF}


{************************************************************************
 * GLFW API tokens
 ************************************************************************ }

const
  GLFW_VERSION_MAJOR = 3;
  GLFW_VERSION_MINOR = 3;
  GLFW_VERSION_REVISION = 10;

  GLFW_TRUE = 1;
  GLFW_FALSE = 0;

  GLFW_RELEASE = 0;
  GLFW_PRESS = 1;
  GLFW_REPEAT = 2;

  GLFW_HAT_CENTERED = 0;
  GLFW_HAT_UP = 1;
  GLFW_HAT_RIGHT = 2;
  GLFW_HAT_DOWN = 4;
  GLFW_HAT_LEFT = 8;
  GLFW_HAT_RIGHT_UP = GLFW_HAT_RIGHT or GLFW_HAT_UP;
  GLFW_HAT_RIGHT_DOWN = GLFW_HAT_RIGHT or GLFW_HAT_DOWN;
  GLFW_HAT_LEFT_UP = GLFW_HAT_LEFT or GLFW_HAT_UP;
  GLFW_HAT_LEFT_DOWN = GLFW_HAT_LEFT or GLFW_HAT_DOWN;

  GLFW_KEY_UNKNOWN = -(1);
  GLFW_KEY_SPACE = 32;
  GLFW_KEY_APOSTROPHE = 39;
  GLFW_KEY_COMMA = 44;
  GLFW_KEY_MINUS = 45;
  GLFW_KEY_PERIOD = 46;
  GLFW_KEY_SLASH = 47;
  GLFW_KEY_0 = 48;
  GLFW_KEY_1 = 49;
  GLFW_KEY_2 = 50;
  GLFW_KEY_3 = 51;
  GLFW_KEY_4 = 52;
  GLFW_KEY_5 = 53;
  GLFW_KEY_6 = 54;
  GLFW_KEY_7 = 55;
  GLFW_KEY_8 = 56;
  GLFW_KEY_9 = 57;
  GLFW_KEY_SEMICOLON = 59;
  GLFW_KEY_EQUAL = 61;
  GLFW_KEY_A = 65;
  GLFW_KEY_B = 66;
  GLFW_KEY_C = 67;
  GLFW_KEY_D = 68;
  GLFW_KEY_E = 69;
  GLFW_KEY_F = 70;
  GLFW_KEY_G = 71;
  GLFW_KEY_H = 72;
  GLFW_KEY_I = 73;
  GLFW_KEY_J = 74;
  GLFW_KEY_K = 75;
  GLFW_KEY_L = 76;
  GLFW_KEY_M = 77;
  GLFW_KEY_N = 78;
  GLFW_KEY_O = 79;
  GLFW_KEY_P = 80;
  GLFW_KEY_Q = 81;
  GLFW_KEY_R = 82;
  GLFW_KEY_S = 83;
  GLFW_KEY_T = 84;
  GLFW_KEY_U = 85;
  GLFW_KEY_V = 86;
  GLFW_KEY_W = 87;
  GLFW_KEY_X = 88;
  GLFW_KEY_Y = 89;
  GLFW_KEY_Z = 90;
  GLFW_KEY_LEFT_BRACKET = 91;
  GLFW_KEY_BACKSLASH = 92;
  GLFW_KEY_RIGHT_BRACKET = 93;
  GLFW_KEY_GRAVE_ACCENT = 96;
  GLFW_KEY_WORLD_1 = 161;
  GLFW_KEY_WORLD_2 = 162;
  GLFW_KEY_ESCAPE = 256;
  GLFW_KEY_ENTER = 257;
  GLFW_KEY_TAB = 258;
  GLFW_KEY_BACKSPACE = 259;
  GLFW_KEY_INSERT = 260;
  GLFW_KEY_DELETE = 261;
  GLFW_KEY_RIGHT = 262;
  GLFW_KEY_LEFT = 263;
  GLFW_KEY_DOWN = 264;
  GLFW_KEY_UP = 265;
  GLFW_KEY_PAGE_UP = 266;
  GLFW_KEY_PAGE_DOWN = 267;
  GLFW_KEY_HOME = 268;
  GLFW_KEY_END = 269;
  GLFW_KEY_CAPS_LOCK = 280;
  GLFW_KEY_SCROLL_LOCK = 281;
  GLFW_KEY_NUM_LOCK = 282;
  GLFW_KEY_PRINT_SCREEN = 283;
  GLFW_KEY_PAUSE = 284;
  GLFW_KEY_F1 = 290;
  GLFW_KEY_F2 = 291;
  GLFW_KEY_F3 = 292;
  GLFW_KEY_F4 = 293;
  GLFW_KEY_F5 = 294;
  GLFW_KEY_F6 = 295;
  GLFW_KEY_F7 = 296;
  GLFW_KEY_F8 = 297;
  GLFW_KEY_F9 = 298;
  GLFW_KEY_F10 = 299;
  GLFW_KEY_F11 = 300;
  GLFW_KEY_F12 = 301;
  GLFW_KEY_F13 = 302;
  GLFW_KEY_F14 = 303;
  GLFW_KEY_F15 = 304;
  GLFW_KEY_F16 = 305;
  GLFW_KEY_F17 = 306;
  GLFW_KEY_F18 = 307;
  GLFW_KEY_F19 = 308;
  GLFW_KEY_F20 = 309;
  GLFW_KEY_F21 = 310;
  GLFW_KEY_F22 = 311;
  GLFW_KEY_F23 = 312;
  GLFW_KEY_F24 = 313;
  GLFW_KEY_F25 = 314;
  GLFW_KEY_KP_0 = 320;
  GLFW_KEY_KP_1 = 321;
  GLFW_KEY_KP_2 = 322;
  GLFW_KEY_KP_3 = 323;
  GLFW_KEY_KP_4 = 324;
  GLFW_KEY_KP_5 = 325;
  GLFW_KEY_KP_6 = 326;
  GLFW_KEY_KP_7 = 327;
  GLFW_KEY_KP_8 = 328;
  GLFW_KEY_KP_9 = 329;
  GLFW_KEY_KP_DECIMAL = 330;
  GLFW_KEY_KP_DIVIDE = 331;
  GLFW_KEY_KP_MULTIPLY = 332;
  GLFW_KEY_KP_SUBTRACT = 333;
  GLFW_KEY_KP_ADD = 334;
  GLFW_KEY_KP_ENTER = 335;
  GLFW_KEY_KP_EQUAL = 336;
  GLFW_KEY_LEFT_SHIFT = 340;
  GLFW_KEY_LEFT_CONTROL = 341;
  GLFW_KEY_LEFT_ALT = 342;
  GLFW_KEY_LEFT_SUPER = 343;
  GLFW_KEY_RIGHT_SHIFT = 344;
  GLFW_KEY_RIGHT_CONTROL = 345;
  GLFW_KEY_RIGHT_ALT = 346;
  GLFW_KEY_RIGHT_SUPER = 347;
  GLFW_KEY_MENU = 348;
  GLFW_KEY_LAST = GLFW_KEY_MENU;

  GLFW_MOD_SHIFT = $0001;
  GLFW_MOD_CONTROL = $0002;
  GLFW_MOD_ALT = $0004;
  GLFW_MOD_SUPER = $0008;
  GLFW_MOD_CAPS_LOCK = $0010;
  GLFW_MOD_NUM_LOCK = $0020;

  GLFW_MOUSE_BUTTON_1 = 0;
  GLFW_MOUSE_BUTTON_2 = 1;
  GLFW_MOUSE_BUTTON_3 = 2;
  GLFW_MOUSE_BUTTON_4 = 3;
  GLFW_MOUSE_BUTTON_5 = 4;
  GLFW_MOUSE_BUTTON_6 = 5;
  GLFW_MOUSE_BUTTON_7 = 6;
  GLFW_MOUSE_BUTTON_8 = 7;
  GLFW_MOUSE_BUTTON_LAST = GLFW_MOUSE_BUTTON_8;
  GLFW_MOUSE_BUTTON_LEFT = GLFW_MOUSE_BUTTON_1;
  GLFW_MOUSE_BUTTON_RIGHT = GLFW_MOUSE_BUTTON_2;
  GLFW_MOUSE_BUTTON_MIDDLE = GLFW_MOUSE_BUTTON_3;

  GLFW_JOYSTICK_1 = 0;
  GLFW_JOYSTICK_2 = 1;
  GLFW_JOYSTICK_3 = 2;
  GLFW_JOYSTICK_4 = 3;
  GLFW_JOYSTICK_5 = 4;
  GLFW_JOYSTICK_6 = 5;
  GLFW_JOYSTICK_7 = 6;
  GLFW_JOYSTICK_8 = 7;
  GLFW_JOYSTICK_9 = 8;
  GLFW_JOYSTICK_10 = 9;
  GLFW_JOYSTICK_11 = 10;
  GLFW_JOYSTICK_12 = 11;
  GLFW_JOYSTICK_13 = 12;
  GLFW_JOYSTICK_14 = 13;
  GLFW_JOYSTICK_15 = 14;
  GLFW_JOYSTICK_16 = 15;
  GLFW_JOYSTICK_LAST = GLFW_JOYSTICK_16;

  GLFW_GAMEPAD_BUTTON_A = 0;
  GLFW_GAMEPAD_BUTTON_B = 1;
  GLFW_GAMEPAD_BUTTON_X = 2;
  GLFW_GAMEPAD_BUTTON_Y = 3;
  GLFW_GAMEPAD_BUTTON_LEFT_BUMPER = 4;
  GLFW_GAMEPAD_BUTTON_RIGHT_BUMPER = 5;
  GLFW_GAMEPAD_BUTTON_BACK = 6;
  GLFW_GAMEPAD_BUTTON_START = 7;
  GLFW_GAMEPAD_BUTTON_GUIDE = 8;
  GLFW_GAMEPAD_BUTTON_LEFT_THUMB = 9;
  GLFW_GAMEPAD_BUTTON_RIGHT_THUMB = 10;
  GLFW_GAMEPAD_BUTTON_DPAD_UP = 11;
  GLFW_GAMEPAD_BUTTON_DPAD_RIGHT = 12;
  GLFW_GAMEPAD_BUTTON_DPAD_DOWN = 13;
  GLFW_GAMEPAD_BUTTON_DPAD_LEFT = 14;
  GLFW_GAMEPAD_BUTTON_LAST = GLFW_GAMEPAD_BUTTON_DPAD_LEFT;
  GLFW_GAMEPAD_BUTTON_CROSS = GLFW_GAMEPAD_BUTTON_A;
  GLFW_GAMEPAD_BUTTON_CIRCLE = GLFW_GAMEPAD_BUTTON_B;
  GLFW_GAMEPAD_BUTTON_SQUARE = GLFW_GAMEPAD_BUTTON_X;
  GLFW_GAMEPAD_BUTTON_TRIANGLE = GLFW_GAMEPAD_BUTTON_Y;

  GLFW_GAMEPAD_AXIS_LEFT_X = 0;
  GLFW_GAMEPAD_AXIS_LEFT_Y = 1;
  GLFW_GAMEPAD_AXIS_RIGHT_X = 2;
  GLFW_GAMEPAD_AXIS_RIGHT_Y = 3;
  GLFW_GAMEPAD_AXIS_LEFT_TRIGGER = 4;
  GLFW_GAMEPAD_AXIS_RIGHT_TRIGGER = 5;
  GLFW_GAMEPAD_AXIS_LAST = GLFW_GAMEPAD_AXIS_RIGHT_TRIGGER;

  GLFW_NO_ERROR = 0;
  GLFW_NOT_INITIALIZED = $00010001;
  GLFW_NO_CURRENT_CONTEXT = $00010002;
  GLFW_INVALID_ENUM = $00010003;
  GLFW_INVALID_VALUE = $00010004;
  GLFW_OUT_OF_MEMORY = $00010005;
  GLFW_API_UNAVAILABLE = $00010006;
  GLFW_VERSION_UNAVAILABLE = $00010007;
  GLFW_PLATFORM_ERROR = $00010008;
  GLFW_FORMAT_UNAVAILABLE = $00010009;
  GLFW_NO_WINDOW_CONTEXT = $0001000A;
  GLFW_FOCUSED = $00020001;
  GLFW_ICONIFIED = $00020002;
  GLFW_RESIZABLE = $00020003;
  GLFW_VISIBLE = $00020004;
  GLFW_DECORATED = $00020005;
  GLFW_AUTO_ICONIFY = $00020006;
  GLFW_FLOATING = $00020007;
  GLFW_MAXIMIZED = $00020008;
  GLFW_CENTER_CURSOR = $00020009;
  GLFW_TRANSPARENT_FRAMEBUFFER = $0002000A;
  GLFW_HOVERED = $0002000B;
  GLFW_FOCUS_ON_SHOW = $0002000C;
  GLFW_RED_BITS = $00021001;
  GLFW_GREEN_BITS = $00021002;
  GLFW_BLUE_BITS = $00021003;
  GLFW_ALPHA_BITS = $00021004;
  GLFW_DEPTH_BITS = $00021005;
  GLFW_STENCIL_BITS = $00021006;
  GLFW_ACCUM_RED_BITS = $00021007;
  GLFW_ACCUM_GREEN_BITS = $00021008;
  GLFW_ACCUM_BLUE_BITS = $00021009;
  GLFW_ACCUM_ALPHA_BITS = $0002100A;
  GLFW_AUX_BUFFERS = $0002100B;
  GLFW_STEREO = $0002100C;
  GLFW_SAMPLES = $0002100D;
  GLFW_SRGB_CAPABLE = $0002100E;
  GLFW_REFRESH_RATE = $0002100F;
  GLFW_DOUBLEBUFFER = $00021010;
  GLFW_CLIENT_API = $00022001;
  GLFW_CONTEXT_VERSION_MAJOR = $00022002;
  GLFW_CONTEXT_VERSION_MINOR = $00022003;
  GLFW_CONTEXT_REVISION = $00022004;
  GLFW_CONTEXT_ROBUSTNESS = $00022005;
  GLFW_OPENGL_FORWARD_COMPAT = $00022006;
  GLFW_OPENGL_DEBUG_CONTEXT = $00022007;
  GLFW_OPENGL_PROFILE = $00022008;
  GLFW_CONTEXT_RELEASE_BEHAVIOR = $00022009;
  GLFW_CONTEXT_NO_ERROR = $0002200A;
  GLFW_CONTEXT_CREATION_API = $0002200B;
  GLFW_SCALE_TO_MONITOR = $0002200C;
  GLFW_COCOA_RETINA_FRAMEBUFFER = $00023001;
  GLFW_COCOA_FRAME_NAME = $00023002;
  GLFW_COCOA_GRAPHICS_SWITCHING = $00023003;
  GLFW_X11_CLASS_NAME = $00024001;
  GLFW_X11_INSTANCE_NAME = $00024002;
  GLFW_NO_API = 0;
  GLFW_OPENGL_API = $00030001;
  GLFW_OPENGL_ES_API = $00030002;
  GLFW_NO_ROBUSTNESS = 0;
  GLFW_NO_RESET_NOTIFICATION = $00031001;
  GLFW_LOSE_CONTEXT_ON_RESET = $00031002;
  GLFW_OPENGL_ANY_PROFILE = 0;
  GLFW_OPENGL_CORE_PROFILE = $00032001;
  GLFW_OPENGL_COMPAT_PROFILE = $00032002;
  GLFW_CURSOR = $00033001;
  GLFW_STICKY_KEYS = $00033002;
  GLFW_STICKY_MOUSE_BUTTONS = $00033003;
  GLFW_LOCK_KEY_MODS = $00033004;
  GLFW_RAW_MOUSE_MOTION = $00033005;
  GLFW_CURSOR_NORMAL = $00034001;
  GLFW_CURSOR_HIDDEN = $00034002;
  GLFW_CURSOR_DISABLED = $00034003;
  GLFW_ANY_RELEASE_BEHAVIOR = 0;
  GLFW_RELEASE_BEHAVIOR_FLUSH = $00035001;
  GLFW_RELEASE_BEHAVIOR_NONE = $00035002;
  GLFW_NATIVE_CONTEXT_API = $00036001;
  GLFW_EGL_CONTEXT_API = $00036002;
  GLFW_OSMESA_CONTEXT_API = $00036003;
  GLFW_WAYLAND_PREFER_LIBDECOR = $00038001;
  GLFW_WAYLAND_DISABLE_LIBDECOR = $00038002;
  GLFW_ARROW_CURSOR = $00036001;
  GLFW_IBEAM_CURSOR = $00036002;
  GLFW_CROSSHAIR_CURSOR = $00036003;
  GLFW_HAND_CURSOR = $00036004;
  GLFW_HRESIZE_CURSOR = $00036005;
  GLFW_VRESIZE_CURSOR = $00036006;
  GLFW_CONNECTED = $00040001;
  GLFW_DISCONNECTED = $00040002;
  GLFW_JOYSTICK_HAT_BUTTONS = $00050001;
  GLFW_COCOA_CHDIR_RESOURCES = $00051001;
  GLFW_COCOA_MENUBAR = $00051002;
  GLFW_WAYLAND_LIBDECOR = $00053001;
  GLFW_DONT_CARE = -(1);

{************************************************************************
 * GLFW API types
 ************************************************************************ }

type
  TGLFWwindow = record
  end;
  PGLFWwindow = ^TGLFWwindow;

  TGLFWcursor = record
  end;
  PGLFWcursor = ^TGLFWcursor;

  TGLFWmonitor = record
  end;
  PGLFWmonitor = ^TGLFWmonitor;
  PPGLFWmonitor = ^PGLFWmonitor;

  TGLFWglproc = procedure(para1: pointer); cdecl;
  TGLFWvkproc = procedure(para1: pointer); cdecl;
  TGLFWerrorfun = procedure(error_code: longint; description: pchar); cdecl;
  TGLFWwindowposfun = procedure(window: PGLFWwindow; xpos: longint; ypos: longint); cdecl;
  TGLFWwindowsizefun = procedure(window: PGLFWwindow; width: longint; height: longint); cdecl;
  TGLFWwindowclosefun = procedure(window: PGLFWwindow); cdecl;
  TGLFWwindowrefreshfun = procedure(window: PGLFWwindow); cdecl;
  TGLFWwindowfocusfun = procedure(window: PGLFWwindow; focused: longint); cdecl;
  TGLFWwindowiconifyfun = procedure(window: PGLFWwindow; iconified: longint); cdecl;
  TGLFWwindowmaximizefun = procedure(window: PGLFWwindow; maximized: longint); cdecl;
  TGLFWframebuffersizefun = procedure(window: PGLFWwindow; width: longint; height: longint); cdecl;
  TGLFWwindowcontentscalefun = procedure(window: PGLFWwindow; xscale: single; yscale: single); cdecl;
  TGLFWmousebuttonfun = procedure(window: PGLFWwindow; button: longint; action: longint; mods: longint); cdecl;
  TGLFWcursorposfun = procedure(window: PGLFWwindow; xpos: double; ypos: double); cdecl;
  TGLFWcursorenterfun = procedure(window: PGLFWwindow; entered: longint); cdecl;
  TGLFWscrollfun = procedure(window: PGLFWwindow; xoffset: double; yoffset: double); cdecl;
  TGLFWkeyfun = procedure(window: PGLFWwindow; key: longint; scancode: longint; action: longint; mods: longint); cdecl;
  TGLFWcharfun = procedure(window: PGLFWwindow; codepoint: dword); cdecl;
  TGLFWcharmodsfun = procedure(window: PGLFWwindow; codepoint: dword; mods: longint); cdecl;
  TGLFWdropfun = procedure(window: PGLFWwindow; path_count: longint; paths: PPchar); cdecl;
  TGLFWmonitorfun = procedure(monitor: PGLFWmonitor; event: longint); cdecl;
  TGLFWjoystickfun = procedure(jid: longint; event: longint); cdecl;

  TGLFWvidmode = record
    width: longint;
    height: longint;
    redBits: longint;
    greenBits: longint;
    blueBits: longint;
    refreshRate: longint;
  end;
  PGLFWvidmode = ^TGLFWvidmode;

  TGLFWgammaramp = record
    red: Pword;
    green: Pword;
    blue: Pword;
    size: dword;
  end;
  PGLFWgammaramp = ^TGLFWgammaramp;

  TGLFWimage = record
    width: longint;
    height: longint;
    pixels: pbyte;
  end;
  PGLFWimage = ^TGLFWimage;

  TGLFWgamepadstate = record
    buttons: array[0..14] of byte;
    axes: array[0..5] of single;
  end;
  PGLFWgamepadstate = ^TGLFWgamepadstate;

{************************************************************************
 * GLFW API functions
 ************************************************************************ }

function glfwInit: longint; cdecl; external libglfw;
procedure glfwTerminate; cdecl; external libglfw;
procedure glfwInitHint(hint: longint; value: longint); cdecl; external libglfw;
procedure glfwGetVersion(major: Plongint; minor: Plongint; rev: Plongint); cdecl; external libglfw;
function glfwGetVersionString: pchar; cdecl; external libglfw;
function glfwGetError(description: PPchar): longint; cdecl; external libglfw;
function glfwSetErrorCallback(callback: TGLFWerrorfun): TGLFWerrorfun; cdecl; external libglfw;
function glfwGetMonitors(count: Plongint): PPGLFWmonitor; cdecl; external libglfw;
function glfwGetPrimaryMonitor: PGLFWmonitor; cdecl; external libglfw;
procedure glfwGetMonitorPos(monitor: PGLFWmonitor; xpos: Plongint; ypos: Plongint); cdecl; external libglfw;
procedure glfwGetMonitorWorkarea(monitor: PGLFWmonitor; xpos: Plongint; ypos: Plongint; width: Plongint; height: Plongint); cdecl; external libglfw;
procedure glfwGetMonitorPhysicalSize(monitor: PGLFWmonitor; widthMM: Plongint; heightMM: Plongint); cdecl; external libglfw;
procedure glfwGetMonitorContentScale(monitor: PGLFWmonitor; xscale: Psingle; yscale: Psingle); cdecl; external libglfw;
function glfwGetMonitorName(monitor: PGLFWmonitor): pchar; cdecl; external libglfw;
procedure glfwSetMonitorUserPointer(monitor: PGLFWmonitor; pointer: pointer); cdecl; external libglfw;
function glfwGetMonitorUserPointer(monitor: PGLFWmonitor): pointer; cdecl; external libglfw;
function glfwSetMonitorCallback(callback: TGLFWmonitorfun): TGLFWmonitorfun; cdecl; external libglfw;
function glfwGetVideoModes(monitor: PGLFWmonitor; count: Plongint): PGLFWvidmode; cdecl; external libglfw;
function glfwGetVideoMode(monitor: PGLFWmonitor): PGLFWvidmode; cdecl; external libglfw;
procedure glfwSetGamma(monitor: PGLFWmonitor; gamma: single); cdecl; external libglfw;
function glfwGetGammaRamp(monitor: PGLFWmonitor): PGLFWgammaramp; cdecl; external libglfw;
procedure glfwSetGammaRamp(monitor: PGLFWmonitor; ramp: PGLFWgammaramp); cdecl; external libglfw;
procedure glfwDefaultWindowHints; cdecl; external libglfw;
procedure glfwWindowHint(hint: longint; value: longint); cdecl; external libglfw;
procedure glfwWindowHintString(hint: longint; value: pchar); cdecl; external libglfw;
function glfwCreateWindow(width: longint; height: longint; title: pchar; monitor: PGLFWmonitor; share: PGLFWwindow): PGLFWwindow; cdecl; external libglfw;
procedure glfwDestroyWindow(window: PGLFWwindow); cdecl; external libglfw;
function glfwWindowShouldClose(window: PGLFWwindow): longint; cdecl; external libglfw;
procedure glfwSetWindowShouldClose(window: PGLFWwindow; value: longint); cdecl; external libglfw;
procedure glfwSetWindowTitle(window: PGLFWwindow; title: pchar); cdecl; external libglfw;
procedure glfwSetWindowIcon(window: PGLFWwindow; count: longint; images: PGLFWimage); cdecl; external libglfw;
procedure glfwGetWindowPos(window: PGLFWwindow; xpos: Plongint; ypos: Plongint); cdecl; external libglfw;
procedure glfwSetWindowPos(window: PGLFWwindow; xpos: longint; ypos: longint); cdecl; external libglfw;
procedure glfwGetWindowSize(window: PGLFWwindow; width: Plongint; height: Plongint); cdecl; external libglfw;
procedure glfwSetWindowSizeLimits(window: PGLFWwindow; minwidth: longint; minheight: longint; maxwidth: longint; maxheight: longint); cdecl; external libglfw;
procedure glfwSetWindowAspectRatio(window: PGLFWwindow; numer: longint; denom: longint); cdecl; external libglfw;
procedure glfwSetWindowSize(window: PGLFWwindow; width: longint; height: longint); cdecl; external libglfw;
procedure glfwGetFramebufferSize(window: PGLFWwindow; width: Plongint; height: Plongint); cdecl; external libglfw;
procedure glfwGetWindowFrameSize(window: PGLFWwindow; left: Plongint; top: Plongint; right: Plongint; bottom: Plongint); cdecl; external libglfw;
procedure glfwGetWindowContentScale(window: PGLFWwindow; xscale: Psingle; yscale: Psingle); cdecl; external libglfw;
function glfwGetWindowOpacity(window: PGLFWwindow): single; cdecl; external libglfw;
procedure glfwSetWindowOpacity(window: PGLFWwindow; opacity: single); cdecl; external libglfw;
procedure glfwIconifyWindow(window: PGLFWwindow); cdecl; external libglfw;
procedure glfwRestoreWindow(window: PGLFWwindow); cdecl; external libglfw;
procedure glfwMaximizeWindow(window: PGLFWwindow); cdecl; external libglfw;
procedure glfwShowWindow(window: PGLFWwindow); cdecl; external libglfw;
procedure glfwHideWindow(window: PGLFWwindow); cdecl; external libglfw;
procedure glfwFocusWindow(window: PGLFWwindow); cdecl; external libglfw;
procedure glfwRequestWindowAttention(window: PGLFWwindow); cdecl; external libglfw;
function glfwGetWindowMonitor(window: PGLFWwindow): PGLFWmonitor; cdecl; external libglfw;
procedure glfwSetWindowMonitor(window: PGLFWwindow; monitor: PGLFWmonitor; xpos: longint; ypos: longint; width: longint; height: longint; refreshRate: longint); cdecl; external libglfw;
function glfwGetWindowAttrib(window: PGLFWwindow; attrib: longint): longint; cdecl; external libglfw;
procedure glfwSetWindowAttrib(window: PGLFWwindow; attrib: longint; value: longint); cdecl; external libglfw;
procedure glfwSetWindowUserPointer(window: PGLFWwindow; pointer: pointer); cdecl; external libglfw;
function glfwGetWindowUserPointer(window: PGLFWwindow): pointer; cdecl; external libglfw;
function glfwSetWindowPosCallback(window: PGLFWwindow; callback: TGLFWwindowposfun): TGLFWwindowposfun; cdecl; external libglfw;
function glfwSetWindowSizeCallback(window: PGLFWwindow; callback: TGLFWwindowsizefun): TGLFWwindowsizefun; cdecl; external libglfw;
function glfwSetWindowCloseCallback(window: PGLFWwindow; callback: TGLFWwindowclosefun): TGLFWwindowclosefun; cdecl; external libglfw;
function glfwSetWindowRefreshCallback(window: PGLFWwindow; callback: TGLFWwindowrefreshfun): TGLFWwindowrefreshfun; cdecl; external libglfw;
function glfwSetWindowFocusCallback(window: PGLFWwindow; callback: TGLFWwindowfocusfun): TGLFWwindowfocusfun; cdecl; external libglfw;
function glfwSetWindowIconifyCallback(window: PGLFWwindow; callback: TGLFWwindowiconifyfun): TGLFWwindowiconifyfun; cdecl; external libglfw;
function glfwSetWindowMaximizeCallback(window: PGLFWwindow; callback: TGLFWwindowmaximizefun): TGLFWwindowmaximizefun; cdecl; external libglfw;
function glfwSetFramebufferSizeCallback(window: PGLFWwindow; callback: TGLFWframebuffersizefun): TGLFWframebuffersizefun; cdecl; external libglfw;
function glfwSetWindowContentScaleCallback(window: PGLFWwindow; callback: TGLFWwindowcontentscalefun): TGLFWwindowcontentscalefun; cdecl; external libglfw;
procedure glfwPollEvents; cdecl; external libglfw;
procedure glfwWaitEvents; cdecl; external libglfw;
procedure glfwWaitEventsTimeout(timeout: double); cdecl; external libglfw;
procedure glfwPostEmptyEvent; cdecl; external libglfw;
function glfwGetInputMode(window: PGLFWwindow; mode: longint): longint; cdecl; external libglfw;
procedure glfwSetInputMode(window: PGLFWwindow; mode: longint; value: longint); cdecl; external libglfw;
function glfwRawMouseMotionSupported: longint; cdecl; external libglfw;
function glfwGetKeyName(key: longint; scancode: longint): pchar; cdecl; external libglfw;
function glfwGetKeyScancode(key: longint): longint; cdecl; external libglfw;
function glfwGetKey(window: PGLFWwindow; key: longint): longint; cdecl; external libglfw;
function glfwGetMouseButton(window: PGLFWwindow; button: longint): longint; cdecl; external libglfw;
procedure glfwGetCursorPos(window: PGLFWwindow; xpos: Pdouble; ypos: Pdouble); cdecl; external libglfw;
procedure glfwSetCursorPos(window: PGLFWwindow; xpos: double; ypos: double); cdecl; external libglfw;
function glfwCreateCursor(image: PGLFWimage; xhot: longint; yhot: longint): PGLFWcursor; cdecl; external libglfw;
function glfwCreateStandardCursor(shape: longint): PGLFWcursor; cdecl; external libglfw;
procedure glfwDestroyCursor(cursor: PGLFWcursor); cdecl; external libglfw;
procedure glfwSetCursor(window: PGLFWwindow; cursor: PGLFWcursor); cdecl; external libglfw;
function glfwSetKeyCallback(window: PGLFWwindow; callback: TGLFWkeyfun): TGLFWkeyfun; cdecl; external libglfw;
function glfwSetCharCallback(window: PGLFWwindow; callback: TGLFWcharfun): TGLFWcharfun; cdecl; external libglfw;
function glfwSetCharModsCallback(window: PGLFWwindow; callback: TGLFWcharmodsfun): TGLFWcharmodsfun; cdecl; external libglfw;
function glfwSetMouseButtonCallback(window: PGLFWwindow; callback: TGLFWmousebuttonfun): TGLFWmousebuttonfun; cdecl; external libglfw;
function glfwSetCursorPosCallback(window: PGLFWwindow; callback: TGLFWcursorposfun): TGLFWcursorposfun; cdecl; external libglfw;
function glfwSetCursorEnterCallback(window: PGLFWwindow; callback: TGLFWcursorenterfun): TGLFWcursorenterfun; cdecl; external libglfw;
function glfwSetScrollCallback(window: PGLFWwindow; callback: TGLFWscrollfun): TGLFWscrollfun; cdecl; external libglfw;
function glfwSetDropCallback(window: PGLFWwindow; callback: TGLFWdropfun): TGLFWdropfun; cdecl; external libglfw;
function glfwJoystickPresent(jid: longint): longint; cdecl; external libglfw;
function glfwGetJoystickAxes(jid: longint; count: Plongint): Psingle; cdecl; external libglfw;
function glfwGetJoystickButtons(jid: longint; count: Plongint): pbyte; cdecl; external libglfw;
function glfwGetJoystickHats(jid: longint; count: Plongint): pbyte; cdecl; external libglfw;
function glfwGetJoystickName(jid: longint): pchar; cdecl; external libglfw;
function glfwGetJoystickGUID(jid: longint): pchar; cdecl; external libglfw;
procedure glfwSetJoystickUserPointer(jid: longint; pointer: pointer); cdecl; external libglfw;
function glfwGetJoystickUserPointer(jid: longint): pointer; cdecl; external libglfw;
function glfwJoystickIsGamepad(jid: longint): longint; cdecl; external libglfw;
function glfwSetJoystickCallback(callback: TGLFWjoystickfun): TGLFWjoystickfun; cdecl; external libglfw;
function glfwUpdateGamepadMappings(_string: pchar): longint; cdecl; external libglfw;
function glfwGetGamepadName(jid: longint): pchar; cdecl; external libglfw;
function glfwGetGamepadState(jid: longint; state: PGLFWgamepadstate): longint; cdecl; external libglfw;
procedure glfwSetClipboardString(window: PGLFWwindow; _string: pchar); cdecl; external libglfw;
function glfwGetClipboardString(window: PGLFWwindow): pchar; cdecl; external libglfw;
function glfwGetTime: double; cdecl; external libglfw;
procedure glfwSetTime(time: double); cdecl; external libglfw;
function glfwGetTimerValue: uint64; cdecl; external libglfw;
function glfwGetTimerFrequency: uint64; cdecl; external libglfw;
procedure glfwMakeContextCurrent(window: PGLFWwindow); cdecl; external libglfw;
function glfwGetCurrentContext: PGLFWwindow; cdecl; external libglfw;
procedure glfwSwapBuffers(window: PGLFWwindow); cdecl; external libglfw;
procedure glfwSwapInterval(interval: longint); cdecl; external libglfw;
function glfwExtensionSupported(extension: pchar): longint; cdecl; external libglfw;
function glfwGetProcAddress(procname: pchar): TGLFWglproc; cdecl; external libglfw;
function glfwVulkanSupported: longint; cdecl; external libglfw;
function glfwGetRequiredInstanceExtensions(count: Puint32): PPchar; cdecl; external libglfw;

function glfwGetInstanceProcAddress(instance: TVkInstance; procname: pchar): TGLFWvkproc; cdecl; external libglfw;
function glfwGetPhysicalDevicePresentationSupport(instance: TVkInstance; device: TVkPhysicalDevice; queuefamily: uint32): longint; cdecl; external libglfw;
function glfwCreateWindowSurface(instance: TVkInstance; window: PGLFWwindow; allocator: PVkAllocationCallbacks; surface: PVkSurfaceKHR): TVkResult; cdecl; external libglfw;


  // === Konventiert am: 21-6-25 15:14:27 ===


implementation



end.
