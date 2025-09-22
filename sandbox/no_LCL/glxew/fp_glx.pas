unit fp_glx;

interface

uses
  {$ifdef linux}
  x, xlib, xutil,
  {$endif}
  fp_glew;

const
  {$ifdef linux}
  libGL = 'libGL';
  libGLX = 'libGLX';
  libGLEW = 'libGLEW';
  libGLXEW = 'libGLEW';
  {$endif}

  {$IFDEF FPC}
  {$PACKRECORDS C}
  {$ENDIF}

type
  Tuint8_t = uint8;
  Puint8_t = ^Tuint8_t;
  PPuint8_t = ^Puint8_t;
  Tuint16_t = uint16;
  Puint16_t = ^Tuint16_t;
  PPuint16_t = ^Puint16_t;
  Tuint32_t = uint32;
  Puint32_t = ^Tuint32_t;
  PPuint32_t = ^Puint32_t;
  Tuint64_t = uint64;
  Puint64_t = ^Tuint64_t;
  PPuint64_t = ^Puint64_t;

  Tint8_t = int8;
  Pint8_t = ^Tint8_t;
  PPint8_t = ^Pint8_t;
  Tint16_t = int16;
  Pint16_t = ^Tint16_t;
  PPint16_t = ^Pint16_t;
  Tint32_t = int32;
  Pint32_t = ^Tint32_t;
  PPint32_t = ^Pint32_t;
  Tint64_t = int64;
  Pint64_t = ^Tint64_t;
  PPint64_t = ^Pint64_t;

type
  TProc = procedure;

  // ===========================

const
  GLX_VERSION_1_1 = 1;
  GLX_VERSION_1_2 = 1;
  GLX_VERSION_1_3 = 1;
  GLX_VERSION_1_4 = 1;
  GLX_EXTENSION_NAME = 'GLX';
  GLX_USE_GL = 1;
  GLX_BUFFER_SIZE = 2;
  GLX_LEVEL = 3;
  GLX_RGBA = 4;
  GLX_DOUBLEBUFFER = 5;
  GLX_STEREO = 6;
  GLX_AUX_BUFFERS = 7;
  GLX_RED_SIZE = 8;
  GLX_GREEN_SIZE = 9;
  GLX_BLUE_SIZE = 10;
  GLX_ALPHA_SIZE = 11;
  GLX_DEPTH_SIZE = 12;
  GLX_STENCIL_SIZE = 13;
  GLX_ACCUM_RED_SIZE = 14;
  GLX_ACCUM_GREEN_SIZE = 15;
  GLX_ACCUM_BLUE_SIZE = 16;
  GLX_ACCUM_ALPHA_SIZE = 17;
  GLX_BAD_SCREEN = 1;
  GLX_BAD_ATTRIBUTE = 2;
  GLX_NO_EXTENSION = 3;
  GLX_BAD_VISUAL = 4;
  GLX_BAD_CONTEXT = 5;
  GLX_BAD_VALUE = 6;
  GLX_BAD_ENUM = 7;
  GLX_VENDOR = 1;
  GLX_VERSION = 2;
  GLX_EXTENSIONS = 3;
  GLX_CONFIG_CAVEAT = $20;
  GLX_DONT_CARE = $FFFFFFFF;
  GLX_X_VISUAL_TYPE = $22;
  GLX_TRANSPARENT_TYPE = $23;
  GLX_TRANSPARENT_INDEX_VALUE = $24;
  GLX_TRANSPARENT_RED_VALUE = $25;
  GLX_TRANSPARENT_GREEN_VALUE = $26;
  GLX_TRANSPARENT_BLUE_VALUE = $27;
  GLX_TRANSPARENT_ALPHA_VALUE = $28;
  GLX_WINDOW_BIT = $00000001;
  GLX_PIXMAP_BIT = $00000002;
  GLX_PBUFFER_BIT = $00000004;
  GLX_AUX_BUFFERS_BIT = $00000010;
  GLX_FRONT_LEFT_BUFFER_BIT = $00000001;
  GLX_FRONT_RIGHT_BUFFER_BIT = $00000002;
  GLX_BACK_LEFT_BUFFER_BIT = $00000004;
  GLX_BACK_RIGHT_BUFFER_BIT = $00000008;
  GLX_DEPTH_BUFFER_BIT = $00000020;
  GLX_STENCIL_BUFFER_BIT = $00000040;
  GLX_ACCUM_BUFFER_BIT = $00000080;
  GLX_NONE = $8000;
  GLX_SLOW_CONFIG = $8001;
  GLX_TRUE_COLOR = $8002;
  GLX_DIRECT_COLOR = $8003;
  GLX_PSEUDO_COLOR = $8004;
  GLX_STATIC_COLOR = $8005;
  GLX_GRAY_SCALE = $8006;
  GLX_STATIC_GRAY = $8007;
  GLX_TRANSPARENT_RGB = $8008;
  GLX_TRANSPARENT_INDEX = $8009;
  GLX_VISUAL_ID = $800B;
  GLX_SCREEN = $800C;
  GLX_NON_CONFORMANT_CONFIG = $800D;
  GLX_DRAWABLE_TYPE = $8010;
  GLX_RENDER_TYPE = $8011;
  GLX_X_RENDERABLE = $8012;
  GLX_FBCONFIG_ID = $8013;
  GLX_RGBA_TYPE = $8014;
  GLX_COLOR_INDEX_TYPE = $8015;
  GLX_MAX_PBUFFER_WIDTH = $8016;
  GLX_MAX_PBUFFER_HEIGHT = $8017;
  GLX_MAX_PBUFFER_PIXELS = $8018;
  GLX_PRESERVED_CONTENTS = $801B;
  GLX_LARGEST_PBUFFER = $801C;
  GLX_WIDTH = $801D;
  GLX_HEIGHT = $801E;
  GLX_EVENT_MASK = $801F;
  GLX_DAMAGED = $8020;
  GLX_SAVED = $8021;
  GLX_WINDOW = $8022;
  GLX_PBUFFER = $8023;
  GLX_PBUFFER_HEIGHT = $8040;
  GLX_PBUFFER_WIDTH = $8041;
  GLX_RGBA_BIT = $00000001;
  GLX_COLOR_INDEX_BIT = $00000002;
  GLX_PBUFFER_CLOBBER_MASK = $08000000;
  GLX_SAMPLE_BUFFERS = $186a0;
  GLX_SAMPLES = $186a1;

type
  PGLXContext = ^TGLXContext;
  TGLXContext = type Pointer;

  PGLXPixmap = ^TGLXPixmap;
  TGLXPixmap = TXID;

  PGLXDrawable = ^TGLXDrawable;
  TGLXDrawable = TXID;

  PGLXFBConfig = ^TGLXFBConfig;
  TGLXFBConfig = type Pointer;

  PGLXFBConfigID = ^TGLXFBConfigID;
  TGLXFBConfigID = TXID;

  PGLXContextID = ^TGLXContextID;
  TGLXContextID = TXID;

  PGLXWindow = ^TGLXWindow;
  TGLXWindow = TXID;

  PGLXPbuffer = ^TGLXPbuffer;
  TGLXPbuffer = TXID;

const
  GLX_PbufferClobber = 0;
  GLX_BufferSwapComplete = 1;
  __GLX_NUMBER_EVENTS = 17;

function glXChooseVisual(dpy: PDisplay; screen: longint; attribList: Plongint): PXVisualInfo; cdecl; external libGLX;
function glXCreateContext(dpy: PDisplay; vis: PXVisualInfo; shareList: TGLXContext; direct: TBool): TGLXContext; cdecl; external libGLX;
procedure glXDestroyContext(dpy: PDisplay; ctx: TGLXContext); cdecl; external libGLX;
function glXMakeCurrent(dpy: PDisplay; drawable: TGLXDrawable; ctx: TGLXContext): TBool; cdecl; external libGLX;
procedure glXCopyContext(dpy: PDisplay; src: TGLXContext; dst: TGLXContext; mask: dword); cdecl; external libGLX;
procedure glXSwapBuffers(dpy: PDisplay; drawable: TGLXDrawable); cdecl; external libGLX;
function glXCreateGLXPixmap(dpy: PDisplay; visual: PXVisualInfo; pixmap: TPixmap): TGLXPixmap; cdecl; external libGLX;
procedure glXDestroyGLXPixmap(dpy: PDisplay; pixmap: TGLXPixmap); cdecl; external libGLX;
function glXQueryExtension(dpy: PDisplay; errorb: Plongint; event: Plongint): TBool; cdecl; external libGLX;
function glXQueryVersion(dpy: PDisplay; maj: Plongint; min: Plongint): TBool; cdecl; external libGLX;
function glXIsDirect(dpy: PDisplay; ctx: TGLXContext): TBool; cdecl; external libGLX;
function glXGetConfig(dpy: PDisplay; visual: PXVisualInfo; attrib: longint; value: Plongint): longint; cdecl; external libGLX;
function glXGetCurrentContext: TGLXContext; cdecl; external libGLX;
function glXGetCurrentDrawable: TGLXDrawable; cdecl; external libGLX;
procedure glXWaitGL; cdecl; external libGLX;
procedure glXWaitX; cdecl; external libGLX;
procedure glXUseXFont(font: TFont; first: longint; count: longint; list: longint); cdecl; external libGLX;
function glXQueryExtensionsString(dpy: PDisplay; screen: longint): pchar; cdecl; external libGLX;
function glXQueryServerString(dpy: PDisplay; screen: longint; name: longint): pchar; cdecl; external libGLX;
function glXGetClientString(dpy: PDisplay; name: longint): pchar; cdecl; external libGLX;
function glXGetCurrentDisplay: PDisplay; cdecl; external libGLX;
function glXChooseFBConfig(dpy: PDisplay; screen: longint; attribList: Plongint; nitems: Plongint): PGLXFBConfig; cdecl; external libGLX;
function glXGetFBConfigAttrib(dpy: PDisplay; config: TGLXFBConfig; attribute: longint; value: Plongint): longint; cdecl; external libGLX;
function glXGetFBConfigs(dpy: PDisplay; screen: longint; nelements: Plongint): PGLXFBConfig; cdecl; external libGLX;
function glXGetVisualFromFBConfig(dpy: PDisplay; config: TGLXFBConfig): PXVisualInfo; cdecl; external libGLX;
function glXCreateWindow(dpy: PDisplay; config: TGLXFBConfig; win: TWindow; attribList: Plongint): TGLXWindow; cdecl; external libGLX;
procedure glXDestroyWindow(dpy: PDisplay; window: TGLXWindow); cdecl; external libGLX;
function glXCreatePixmap(dpy: PDisplay; config: TGLXFBConfig; pixmap: TPixmap; attribList: Plongint): TGLXPixmap; cdecl; external libGLX;
procedure glXDestroyPixmap(dpy: PDisplay; pixmap: TGLXPixmap); cdecl; external libGLX;
function glXCreatePbuffer(dpy: PDisplay; config: TGLXFBConfig; attribList: Plongint): TGLXPbuffer; cdecl; external libGLX;
procedure glXDestroyPbuffer(dpy: PDisplay; pbuf: TGLXPbuffer); cdecl; external libGLX;
procedure glXQueryDrawable(dpy: PDisplay; draw: TGLXDrawable; attribute: longint; value: Pdword); cdecl; external libGLX;
function glXCreateNewContext(dpy: PDisplay; config: TGLXFBConfig; renderType: longint; shareList: TGLXContext; direct: TBool): TGLXContext; cdecl; external libGLX;
function glXMakeContextCurrent(dpy: PDisplay; draw: TGLXDrawable; read: TGLXDrawable; ctx: TGLXContext): TBool; cdecl; external libGLX;
function glXGetCurrentReadDrawable: TGLXDrawable; cdecl; external libGLX;
function glXQueryContext(dpy: PDisplay; ctx: TGLXContext; attribute: longint; value: Plongint): longint; cdecl; external libGLX;
procedure glXSelectEvent(dpy: PDisplay; drawable: TGLXDrawable; mask: dword); cdecl; external libGLX;
procedure glXGetSelectedEvent(dpy: PDisplay; drawable: TGLXDrawable; mask: Pdword); cdecl; external libGLX;

const
  GLX_ARB_get_proc_address = 1;

type
  TGLXextFuncPtr = procedure(para1: pointer); cdecl;

function glXGetProcAddressARB(para1: PGLubyte): TGLXextFuncPtr; cdecl; external libGLX;
function glXGetProcAddress(procname: PGLubyte): Tproc; cdecl; external libGLX;

function glXAllocateMemoryNV(size: TGLsizei; readfreq: TGLfloat; writefreq: TGLfloat; priority: TGLfloat): pointer; cdecl; external libGLX;
procedure glXFreeMemoryNV(pointer: PGLvoid); cdecl; external libGLX;

const
  GLX_ARB_render_texture = 1;

function glXBindTexImageARB(dpy: PDisplay; pbuffer: TGLXPbuffer; buffer: longint): TBool; cdecl; external libGLX;
function glXReleaseTexImageARB(dpy: PDisplay; pbuffer: TGLXPbuffer; buffer: longint): TBool; cdecl; external libGLX;
function glXDrawableAttribARB(dpy: PDisplay; draw: TGLXDrawable; attribList: Plongint): TBool; cdecl; external libGLX;

const
  GLX_NV_float_buffer = 1;
  GLX_FLOAT_COMPONENTS_NV = $20B0;

const
  GLX_MESA_swap_frame_usage = 1;

function glXGetFrameUsageMESA(dpy: PDisplay; drawable: TGLXDrawable; usage: Psingle): longint; cdecl; external libGLX;
function glXBeginFrameTrackingMESA(dpy: PDisplay; drawable: TGLXDrawable): longint; cdecl; external libGLX;
function glXEndFrameTrackingMESA(dpy: PDisplay; drawable: TGLXDrawable): longint; cdecl; external libGLX;
function glXQueryFrameTrackingMESA(dpy: PDisplay; drawable: TGLXDrawable; swapCount: Pint64_t; missedFrames: Pint64_t; lastMissedUsage: Psingle): longint; cdecl; external libGLX;

const
  GLX_MESA_swap_control = 1;

function glXSwapIntervalMESA(interval: dword): longint; cdecl; external libGLX;
function glXGetSwapIntervalMESA: longint; cdecl; external libGLX;

const
  GLX_EXT_texture_from_pixmap = 1;
  GLX_BIND_TO_TEXTURE_RGB_EXT = $20D0;
  GLX_BIND_TO_TEXTURE_RGBA_EXT = $20D1;
  GLX_BIND_TO_MIPMAP_TEXTURE_EXT = $20D2;
  GLX_BIND_TO_TEXTURE_TARGETS_EXT = $20D3;
  GLX_Y_INVERTED_EXT = $20D4;
  GLX_TEXTURE_FORMAT_EXT = $20D5;
  GLX_TEXTURE_TARGET_EXT = $20D6;
  GLX_MIPMAP_TEXTURE_EXT = $20D7;
  GLX_TEXTURE_FORMAT_NONE_EXT = $20D8;
  GLX_TEXTURE_FORMAT_RGB_EXT = $20D9;
  GLX_TEXTURE_FORMAT_RGBA_EXT = $20DA;
  GLX_TEXTURE_1D_BIT_EXT = $00000001;
  GLX_TEXTURE_2D_BIT_EXT = $00000002;
  GLX_TEXTURE_RECTANGLE_BIT_EXT = $00000004;
  GLX_TEXTURE_1D_EXT = $20DB;
  GLX_TEXTURE_2D_EXT = $20DC;
  GLX_TEXTURE_RECTANGLE_EXT = $20DD;
  GLX_FRONT_LEFT_EXT = $20DE;
  GLX_FRONT_RIGHT_EXT = $20DF;
  GLX_BACK_LEFT_EXT = $20E0;
  GLX_BACK_RIGHT_EXT = $20E1;
  GLX_FRONT_EXT = GLX_FRONT_LEFT_EXT;
  GLX_BACK_EXT = GLX_BACK_LEFT_EXT;
  GLX_AUX0_EXT = $20E2;
  GLX_AUX1_EXT = $20E3;
  GLX_AUX2_EXT = $20E4;
  GLX_AUX3_EXT = $20E5;
  GLX_AUX4_EXT = $20E6;
  GLX_AUX5_EXT = $20E7;
  GLX_AUX6_EXT = $20E8;
  GLX_AUX7_EXT = $20E9;
  GLX_AUX8_EXT = $20EA;
  GLX_AUX9_EXT = $20EB;

procedure glXBindTexImageEXT(dpy: PDisplay; drawable: TGLXDrawable; buffer: longint; attrib_list: Plongint); cdecl; external libGLX;
procedure glXReleaseTexImageEXT(dpy: PDisplay; drawable: TGLXDrawable; buffer: longint); cdecl; external libGLX;

type
  TGLXPbufferClobberEvent = record
    event_type: longint;
    draw_type: longint;
    serial: dword;
    send_event: TBool;
    display: PDisplay;
    drawable: TGLXDrawable;
    buffer_mask: dword;
    aux_buffer: dword;
    x: longint;
    y: longint;
    width: longint;
    height: longint;
    count: longint;
  end;
  PGLXPbufferClobberEvent = ^TGLXPbufferClobberEvent;

  TGLXBufferSwapComplete = record
    _type: longint;
    serial: dword;
    send_event: TBool;
    display: PDisplay;
    drawable: TGLXDrawable;
    event_type: longint;
    ust: Tint64_t;
    msc: Tint64_t;
    sbc: Tint64_t;
  end;
  PGLXBufferSwapComplete = ^TGLXBufferSwapComplete;

  T_GLXEvent = record
    case longint of
      0: (glxpbufferclobber: TGLXPbufferClobberEvent);
      1: (glxbufferswapcomplete: TGLXBufferSwapComplete);
      2: (pad: array[0..23] of longint);
  end;
  P_GLXEvent = ^T_GLXEvent;

  TGLXEvent = T_GLXEvent;
  PGLXEvent = ^TGLXEvent;

  // === Konventiert am: 22-9-25 17:32:36 ===


implementation



end.
