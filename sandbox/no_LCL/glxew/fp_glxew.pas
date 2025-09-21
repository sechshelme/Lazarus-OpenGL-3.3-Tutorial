unit fp_glxew;

interface

uses
  {$ifdef linux}
  x, xlib, xutil,
  {$endif}
  ctypes, fp_glew;

  {$IFDEF FPC}
  {$PACKRECORDS C}
  {$ENDIF}

type
  TProc = procedure;

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

  // ===========================

const
  GLX_VERSION_1_0 = 1;
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

type
  PGLXDrawable = ^TGLXDrawable;
  TGLXDrawable = TXID;

  PGLXPixmap = ^TGLXPixmap;
  TGLXPixmap = TXID;

type
  PGLXContext = ^TGLXContext;
  TGLXContext = type Pointer;

type
  PGLXVideoDeviceNV = ^TGLXVideoDeviceNV;
  TGLXVideoDeviceNV = dword;

function glXQueryExtension(dpy: PDisplay; errorBase: Plongint; eventBase: Plongint): TBool; cdecl; external libGLXEW;
function glXQueryVersion(dpy: PDisplay; major: Plongint; minor: Plongint): TBool; cdecl; external libGLXEW;
function glXGetConfig(dpy: PDisplay; vis: PXVisualInfo; attrib: longint; value: Plongint): longint; cdecl; external libGLXEW;
function glXChooseVisual(dpy: PDisplay; screen: longint; attribList: Plongint): PXVisualInfo; cdecl; external libGLXEW;
function glXCreateGLXPixmap(dpy: PDisplay; vis: PXVisualInfo; pixmap: TPixmap): TGLXPixmap; cdecl; external libGLXEW;
procedure glXDestroyGLXPixmap(dpy: PDisplay; pix: TGLXPixmap); cdecl; external libGLXEW;
function glXCreateContext(dpy: PDisplay; vis: PXVisualInfo; shareList: TGLXContext; direct: TBool): TGLXContext; cdecl; external libGLXEW;
procedure glXDestroyContext(dpy: PDisplay; ctx: TGLXContext); cdecl; external libGLXEW;
function glXIsDirect(dpy: PDisplay; ctx: TGLXContext): TBool; cdecl; external libGLXEW;
procedure glXCopyContext(dpy: PDisplay; src: TGLXContext; dst: TGLXContext; mask: TGLulong); cdecl; external libGLXEW;
function glXMakeCurrent(dpy: PDisplay; drawable: TGLXDrawable; ctx: TGLXContext): TBool; cdecl; external libGLXEW;
function glXGetCurrentContext: TGLXContext; cdecl; external libGLXEW;
function glXGetCurrentDrawable: TGLXDrawable; cdecl; external libGLXEW;
procedure glXWaitGL; cdecl; external libGLXEW;
procedure glXWaitX; cdecl; external libGLXEW;
procedure glXSwapBuffers(dpy: PDisplay; drawable: TGLXDrawable); cdecl; external libGLXEW;
procedure glXUseXFont(font: TFont; first: longint; count: longint; listBase: longint); cdecl; external libGLXEW;


{ ---------------------------- GLX_VERSION_1_1 ---------------------------  }

const
  GLX_VENDOR = $1;
  GLX_VERSION = $2;
  GLX_EXTENSIONS = $3;

function glXQueryExtensionsString(dpy: PDisplay; screen: longint): pchar; cdecl; external libGLXEW;
function glXGetClientString(dpy: PDisplay; name: longint): pchar; cdecl; external libGLXEW;
function glXQueryServerString(dpy: PDisplay; screen: longint; name: longint): pchar; cdecl; external libGLXEW;


{ ---------------------------- GLX_VERSION_1_2 ----------------------------  }

const
  GLX_VERSION_1_2 = 1;

type
  PPFNGLXGETCURRENTDISPLAYPROC = ^TPFNGLXGETCURRENTDISPLAYPROC;
  TPFNGLXGETCURRENTDISPLAYPROC = function: PDisplay; cdecl;


  { ---------------------------- GLX_VERSION_1_3 ----------------------------  }

const
  GLX_VERSION_1_3 = 1;
  GLX_FRONT_LEFT_BUFFER_BIT = $00000001;
  GLX_RGBA_BIT = $00000001;
  GLX_WINDOW_BIT = $00000001;
  GLX_COLOR_INDEX_BIT = $00000002;
  GLX_FRONT_RIGHT_BUFFER_BIT = $00000002;
  GLX_PIXMAP_BIT = $00000002;
  GLX_BACK_LEFT_BUFFER_BIT = $00000004;
  GLX_PBUFFER_BIT = $00000004;
  GLX_BACK_RIGHT_BUFFER_BIT = $00000008;
  GLX_AUX_BUFFERS_BIT = $00000010;
  GLX_CONFIG_CAVEAT = $20;
  GLX_DEPTH_BUFFER_BIT = $00000020;
  GLX_X_VISUAL_TYPE = $22;
  GLX_TRANSPARENT_TYPE = $23;
  GLX_TRANSPARENT_INDEX_VALUE = $24;
  GLX_TRANSPARENT_RED_VALUE = $25;
  GLX_TRANSPARENT_GREEN_VALUE = $26;
  GLX_TRANSPARENT_BLUE_VALUE = $27;
  GLX_TRANSPARENT_ALPHA_VALUE = $28;
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
  GLX_PBUFFER_CLOBBER_MASK = $08000000;
  GLX_DONT_CARE = $FFFFFFFF;

type
  PGLXFBConfigID = ^TGLXFBConfigID;
  TGLXFBConfigID = TXID;

  PGLXPbuffer = ^TGLXPbuffer;
  TGLXPbuffer = TXID;

  PGLXWindow = ^TGLXWindow;
  TGLXWindow = TXID;

  PGLXFBConfig = ^TGLXFBConfig;
  TGLXFBConfig = type Pointer;

  PGLXPbufferClobberEvent = ^TGLXPbufferClobberEvent;

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

  P_GLXEvent = ^T_GLXEvent;
  T_GLXEvent = record
    case longint of
      0: (glxpbufferclobber: TGLXPbufferClobberEvent);
      1: (pad: array[0..23] of longint);
  end;
  TGLXEvent = T_GLXEvent;
  PGLXEvent = ^TGLXEvent;

  TPFNGLXCHOOSEFBCONFIGPROC = function(dpy: PDisplay; screen: longint; attrib_list: Plongint; nelements: Plongint): PGLXFBConfig; cdecl;
  TPFNGLXCREATENEWCONTEXTPROC = function(dpy: PDisplay; config: TGLXFBConfig; render_type: longint; share_list: TGLXContext; direct: TBool): TGLXContext; cdecl;
  TPFNGLXCREATEPBUFFERPROC = function(dpy: PDisplay; config: TGLXFBConfig; attrib_list: Plongint): TGLXPbuffer; cdecl;
  TPFNGLXCREATEPIXMAPPROC = function(dpy: PDisplay; config: TGLXFBConfig; pixmap: TPixmap; attrib_list: Plongint): TGLXPixmap; cdecl;
  TPFNGLXCREATEWINDOWPROC = function(dpy: PDisplay; config: TGLXFBConfig; win: TWindow; attrib_list: Plongint): TGLXWindow; cdecl;
  TPFNGLXDESTROYPBUFFERPROC = procedure(dpy: PDisplay; pbuf: TGLXPbuffer); cdecl;
  TPFNGLXDESTROYPIXMAPPROC = procedure(dpy: PDisplay; pixmap: TGLXPixmap); cdecl;
  TPFNGLXDESTROYWINDOWPROC = procedure(dpy: PDisplay; win: TGLXWindow); cdecl;
  TPFNGLXGETCURRENTREADDRAWABLEPROC = function(para1: pointer): TGLXDrawable; cdecl;
  TPFNGLXGETFBCONFIGATTRIBPROC = function(dpy: PDisplay; config: TGLXFBConfig; attribute: longint; value: Plongint): longint; cdecl;
  TPFNGLXGETFBCONFIGSPROC = function(dpy: PDisplay; screen: longint; nelements: Plongint): PGLXFBConfig; cdecl;
  TPFNGLXGETSELECTEDEVENTPROC = procedure(dpy: PDisplay; draw: TGLXDrawable; event_mask: Pdword); cdecl;
  TPFNGLXGETVISUALFROMFBCONFIGPROC = function(dpy: PDisplay; config: TGLXFBConfig): PXVisualInfo; cdecl;
  TPFNGLXMAKECONTEXTCURRENTPROC = function(display: PDisplay; draw: TGLXDrawable; read: TGLXDrawable; ctx: TGLXContext): TBool; cdecl;
  TPFNGLXQUERYCONTEXTPROC = function(dpy: PDisplay; ctx: TGLXContext; attribute: longint; value: Plongint): longint; cdecl;
  TPFNGLXQUERYDRAWABLEPROC = procedure(dpy: PDisplay; draw: TGLXDrawable; attribute: longint; value: Pdword); cdecl;
  TPFNGLXSELECTEVENTPROC = procedure(dpy: PDisplay; draw: TGLXDrawable; event_mask: dword); cdecl;


  { ---------------------------- GLX_VERSION_1_4 ----------------------------  }

const
  GLX_VERSION_1_4 = 1;
  GLX_SAMPLE_BUFFERS = 100000;
  GLX_SAMPLES = 100001;

function glXGetProcAddress(procName: PGLubyte): TProc; cdecl; external libGLXEW;


{ -------------------------- GLX_3DFX_multisample -------------------------  }

const
  GLX_3DFX_multisample = 1;
  GLX_SAMPLE_BUFFERS_3DFX = $8050;
  GLX_SAMPLES_3DFX = $8051;


  { ------------------------ GLX_AMD_gpu_association ------------------------  }

const
  GLX_AMD_gpu_association = 1;
  GLX_GPU_VENDOR_AMD = $1F00;
  GLX_GPU_RENDERER_STRING_AMD = $1F01;
  GLX_GPU_OPENGL_VERSION_STRING_AMD = $1F02;
  GLX_GPU_FASTEST_TARGET_GPUS_AMD = $21A2;
  GLX_GPU_RAM_AMD = $21A3;
  GLX_GPU_CLOCK_AMD = $21A4;
  GLX_GPU_NUM_PIPES_AMD = $21A5;
  GLX_GPU_NUM_SIMD_AMD = $21A6;
  GLX_GPU_NUM_RB_AMD = $21A7;
  GLX_GPU_NUM_SPI_AMD = $21A8;

type

  TPFNGLXBLITCONTEXTFRAMEBUFFERAMDPROC = procedure(dstCtx: TGLXContext; srcX0: TGLint; srcY0: TGLint; srcX1: TGLint; srcY1: TGLint;
    dstX0: TGLint; dstY0: TGLint; dstX1: TGLint; dstY1: TGLint; mask: TGLbitfield;
    filter: TGLenum); cdecl;
  TPFNGLXCREATEASSOCIATEDCONTEXTAMDPROC = function(id: dword; share_list: TGLXContext): TGLXContext; cdecl;
  TPFNGLXCREATEASSOCIATEDCONTEXTATTRIBSAMDPROC = function(id: dword; share_context: TGLXContext; attribList: Plongint): TGLXContext; cdecl;
  TPFNGLXDELETEASSOCIATEDCONTEXTAMDPROC = function(ctx: TGLXContext): TBool; cdecl;
  TPFNGLXGETCONTEXTGPUIDAMDPROC = function(ctx: TGLXContext): dword; cdecl;
  TPFNGLXGETCURRENTASSOCIATEDCONTEXTAMDPROC = function(para1: pointer): TGLXContext; cdecl;
  TPFNGLXGETGPUIDSAMDPROC = function(maxCount: dword; ids: Pdword): dword; cdecl;
  TPFNGLXGETGPUINFOAMDPROC = function(id: dword; _property: longint; dataType: TGLenum; size: dword; data: pointer): longint; cdecl;
  TPFNGLXMAKEASSOCIATEDCONTEXTCURRENTAMDPROC = function(ctx: TGLXContext): TBool; cdecl;


  { --------------------- GLX_ARB_context_flush_control ---------------------  }

const
  GLX_ARB_context_flush_control = 1;
  GLX_CONTEXT_RELEASE_BEHAVIOR_NONE_ARB = 0;
  GLX_CONTEXT_RELEASE_BEHAVIOR_ARB = $2097;
  GLX_CONTEXT_RELEASE_BEHAVIOR_FLUSH_ARB = $2098;


  { ------------------------- GLX_ARB_create_context ------------------------  }

const
  GLX_ARB_create_context = 1;
  GLX_CONTEXT_DEBUG_BIT_ARB = $00000001;
  GLX_CONTEXT_FORWARD_COMPATIBLE_BIT_ARB = $00000002;
  GLX_CONTEXT_MAJOR_VERSION_ARB = $2091;
  GLX_CONTEXT_MINOR_VERSION_ARB = $2092;
  GLX_CONTEXT_FLAGS_ARB = $2094;

type
  TPFNGLXCREATECONTEXTATTRIBSARBPROC = function(dpy: PDisplay; config: TGLXFBConfig; share_context: TGLXContext; direct: TBool; attrib_list: Plongint): TGLXContext; cdecl;


  { -------------------- GLX_ARB_create_context_no_error --------------------  }

const
  GLX_ARB_create_context_no_error = 1;
  GLX_CONTEXT_OPENGL_NO_ERROR_ARB = $31B3;


  { --------------------- GLX_ARB_create_context_profile --------------------  }

const
  GLX_ARB_create_context_profile = 1;
  GLX_CONTEXT_CORE_PROFILE_BIT_ARB = $00000001;
  GLX_CONTEXT_COMPATIBILITY_PROFILE_BIT_ARB = $00000002;
  GLX_CONTEXT_PROFILE_MASK_ARB = $9126;


  { ------------------- GLX_ARB_create_context_robustness -------------------  }

const
  GLX_ARB_create_context_robustness = 1;
  GLX_CONTEXT_ROBUST_ACCESS_BIT_ARB = $00000004;
  GLX_LOSE_CONTEXT_ON_RESET_ARB = $8252;
  GLX_CONTEXT_RESET_NOTIFICATION_STRATEGY_ARB = $8256;
  GLX_NO_RESET_NOTIFICATION_ARB = $8261;


  { ------------------------- GLX_ARB_fbconfig_float ------------------------  }

const
  GLX_ARB_fbconfig_float = 1;
  GLX_RGBA_FLOAT_BIT_ARB = $00000004;
  GLX_RGBA_FLOAT_TYPE_ARB = $20B9;


  { ------------------------ GLX_ARB_framebuffer_sRGB -----------------------  }

const
  GLX_ARB_framebuffer_sRGB = 1;
  GLX_FRAMEBUFFER_SRGB_CAPABLE_ARB = $20B2;


  { ------------------------ GLX_ARB_get_proc_address -----------------------  }

const
  GLX_ARB_get_proc_address = 1;

function glXGetProcAddressARB(procName: PGLubyte): TProc; cdecl; external libGLXEW;

{ -------------------------- GLX_ARB_multisample --------------------------  }

const
  GLX_ARB_multisample = 1;
  GLX_SAMPLE_BUFFERS_ARB = 100000;
  GLX_SAMPLES_ARB = 100001;


  { ---------------- GLX_ARB_robustness_application_isolation ---------------  }

const
  GLX_ARB_robustness_application_isolation = 1;
  GLX_CONTEXT_RESET_ISOLATION_BIT_ARB = $00000008;


  { ---------------- GLX_ARB_robustness_share_group_isolation ---------------  }

const
  GLX_ARB_robustness_share_group_isolation = 1;
  //  GLX_CONTEXT_RESET_ISOLATION_BIT_ARB = $00000008;  Doppelt


  { ---------------------- GLX_ARB_vertex_buffer_object ---------------------  }

const
  GLX_ARB_vertex_buffer_object = 1;
  GLX_CONTEXT_ALLOW_BUFFER_BYTE_ORDER_MISMATCH_ARB = $2095;


  { ----------------------- GLX_ATI_pixel_format_float ----------------------  }

const
  GLX_ATI_pixel_format_float = 1;
  GLX_RGBA_FLOAT_ATI_BIT = $00000100;


  { ------------------------- GLX_ATI_render_texture ------------------------  }

const
  GLX_ATI_render_texture = 1;
  GLX_BIND_TO_TEXTURE_RGB_ATI = $9800;
  GLX_BIND_TO_TEXTURE_RGBA_ATI = $9801;
  GLX_TEXTURE_FORMAT_ATI = $9802;
  GLX_TEXTURE_TARGET_ATI = $9803;
  GLX_MIPMAP_TEXTURE_ATI = $9804;
  GLX_TEXTURE_RGB_ATI = $9805;
  GLX_TEXTURE_RGBA_ATI = $9806;
  GLX_NO_TEXTURE_ATI = $9807;
  GLX_TEXTURE_CUBE_MAP_ATI = $9808;
  GLX_TEXTURE_1D_ATI = $9809;
  GLX_TEXTURE_2D_ATI = $980A;
  GLX_MIPMAP_LEVEL_ATI = $980B;
  GLX_CUBE_MAP_FACE_ATI = $980C;
  GLX_TEXTURE_CUBE_MAP_POSITIVE_X_ATI = $980D;
  GLX_TEXTURE_CUBE_MAP_NEGATIVE_X_ATI = $980E;
  GLX_TEXTURE_CUBE_MAP_POSITIVE_Y_ATI = $980F;
  GLX_TEXTURE_CUBE_MAP_NEGATIVE_Y_ATI = $9810;
  GLX_TEXTURE_CUBE_MAP_POSITIVE_Z_ATI = $9811;
  GLX_TEXTURE_CUBE_MAP_NEGATIVE_Z_ATI = $9812;
  GLX_FRONT_LEFT_ATI = $9813;
  GLX_FRONT_RIGHT_ATI = $9814;
  GLX_BACK_LEFT_ATI = $9815;
  GLX_BACK_RIGHT_ATI = $9816;
  GLX_AUX0_ATI = $9817;
  GLX_AUX1_ATI = $9818;
  GLX_AUX2_ATI = $9819;
  GLX_AUX3_ATI = $981A;
  GLX_AUX4_ATI = $981B;
  GLX_AUX5_ATI = $981C;
  GLX_AUX6_ATI = $981D;
  GLX_AUX7_ATI = $981E;
  GLX_AUX8_ATI = $981F;
  GLX_AUX9_ATI = $9820;
  GLX_BIND_TO_TEXTURE_LUMINANCE_ATI = $9821;
  GLX_BIND_TO_TEXTURE_INTENSITY_ATI = $9822;

type
  TPFNGLXBINDTEXIMAGEATIPROC = procedure(dpy: PDisplay; pbuf: TGLXPbuffer; buffer: longint); cdecl;
  TPFNGLXDRAWABLEATTRIBATIPROC = procedure(dpy: PDisplay; draw: TGLXDrawable; attrib_list: Plongint); cdecl;
  TPFNGLXRELEASETEXIMAGEATIPROC = procedure(dpy: PDisplay; pbuf: TGLXPbuffer; buffer: longint); cdecl;


  { --------------------------- GLX_EXT_buffer_age --------------------------  }

const
  GLX_EXT_buffer_age = 1;
  GLX_BACK_BUFFER_AGE_EXT = $20F4;


  { ------------------------ GLX_EXT_context_priority -----------------------  }

const
  GLX_EXT_context_priority = 1;
  GLX_CONTEXT_PRIORITY_LEVEL_EXT = $3100;
  GLX_CONTEXT_PRIORITY_HIGH_EXT = $3101;
  GLX_CONTEXT_PRIORITY_MEDIUM_EXT = $3102;
  GLX_CONTEXT_PRIORITY_LOW_EXT = $3103;


  { ------------------- GLX_EXT_create_context_es2_profile ------------------  }

const
  GLX_EXT_create_context_es2_profile = 1;
  GLX_CONTEXT_ES2_PROFILE_BIT_EXT = $00000004;


  { ------------------- GLX_EXT_create_context_es_profile -------------------  }

const
  GLX_EXT_create_context_es_profile = 1;
  GLX_CONTEXT_ES_PROFILE_BIT_EXT = $00000004;


  { --------------------- GLX_EXT_fbconfig_packed_float ---------------------  }

const
  GLX_EXT_fbconfig_packed_float = 1;
  GLX_RGBA_UNSIGNED_FLOAT_BIT_EXT = $00000008;
  GLX_RGBA_UNSIGNED_FLOAT_TYPE_EXT = $20B1;


  { ------------------------ GLX_EXT_framebuffer_sRGB -----------------------  }

const
  GLX_EXT_framebuffer_sRGB = 1;
  GLX_FRAMEBUFFER_SRGB_CAPABLE_EXT = $20B2;


  { ------------------------- GLX_EXT_import_context ------------------------  }

const
  GLX_EXT_import_context = 1;
  GLX_SHARE_CONTEXT_EXT = $800A;
  GLX_VISUAL_ID_EXT = $800B;
  GLX_SCREEN_EXT = $800C;

type
  PGLXContextID = ^TGLXContextID;
  TGLXContextID = TXID;

  TPFNGLXFREECONTEXTEXTPROC = procedure(dpy: PDisplay; context: TGLXContext); cdecl;
  TPFNGLXGETCONTEXTIDEXTPROC = function(context: TGLXContext): TGLXContextID; cdecl;
  TPFNGLXGETCURRENTDISPLAYEXTPROC = function: PDisplay; cdecl;
  TPFNGLXIMPORTCONTEXTEXTPROC = function(dpy: PDisplay; contextID: TGLXContextID): TGLXContext; cdecl;
  TPFNGLXQUERYCONTEXTINFOEXTPROC = function(dpy: PDisplay; context: TGLXContext; attribute: longint; value: Plongint): longint; cdecl;


  { ---------------------------- GLX_EXT_libglvnd ---------------------------  }

const
  GLX_EXT_libglvnd = 1;
  GLX_VENDOR_NAMES_EXT = $20F6;


  { ----------------------- GLX_EXT_no_config_context -----------------------  }

const
  GLX_EXT_no_config_context = 1;


  { -------------------------- GLX_EXT_scene_marker -------------------------  }

const
  GLX_EXT_scene_marker = 1;


  { -------------------------- GLX_EXT_stereo_tree --------------------------  }

const
  GLX_EXT_stereo_tree = 1;
  GLX_STEREO_NOTIFY_EXT = $00000000;
  GLX_STEREO_NOTIFY_MASK_EXT = $00000001;
  GLX_STEREO_TREE_EXT = $20F5;


  { -------------------------- GLX_EXT_swap_control -------------------------  }

const
  GLX_EXT_swap_control = 1;
  GLX_SWAP_INTERVAL_EXT = $20F1;
  GLX_MAX_SWAP_INTERVAL_EXT = $20F2;

type
  TPFNGLXSWAPINTERVALEXTPROC = procedure(dpy: PDisplay; drawable: TGLXDrawable; interval: longint); cdecl;


  { ----------------------- GLX_EXT_swap_control_tear -----------------------  }

const
  GLX_EXT_swap_control_tear = 1;
  GLX_LATE_SWAPS_TEAR_EXT = $20F3;


  { ---------------------- GLX_EXT_texture_from_pixmap ----------------------  }

const
  GLX_EXT_texture_from_pixmap = 1;
  GLX_TEXTURE_1D_BIT_EXT = $00000001;
  GLX_TEXTURE_2D_BIT_EXT = $00000002;
  GLX_TEXTURE_RECTANGLE_BIT_EXT = $00000004;
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
  GLX_TEXTURE_1D_EXT = $20DB;
  GLX_TEXTURE_2D_EXT = $20DC;
  GLX_TEXTURE_RECTANGLE_EXT = $20DD;
  GLX_FRONT_EXT = $20DE;
  GLX_FRONT_LEFT_EXT = $20DE;
  GLX_FRONT_RIGHT_EXT = $20DF;
  GLX_BACK_EXT = $20E0;
  GLX_BACK_LEFT_EXT = $20E0;
  GLX_BACK_RIGHT_EXT = $20E1;
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

type
  TPFNGLXBINDTEXIMAGEEXTPROC = procedure(dpy: PDisplay; drawable: TGLXDrawable; buffer: longint; attrib_list: Plongint); cdecl;
  TPFNGLXRELEASETEXIMAGEEXTPROC = procedure(dpy: PDisplay; drawable: TGLXDrawable; buffer: longint); cdecl;


  { -------------------------- GLX_EXT_visual_info --------------------------  }

const
  GLX_EXT_visual_info = 1;
  GLX_X_VISUAL_TYPE_EXT = $22;
  GLX_TRANSPARENT_TYPE_EXT = $23;
  GLX_TRANSPARENT_INDEX_VALUE_EXT = $24;
  GLX_TRANSPARENT_RED_VALUE_EXT = $25;
  GLX_TRANSPARENT_GREEN_VALUE_EXT = $26;
  GLX_TRANSPARENT_BLUE_VALUE_EXT = $27;
  GLX_TRANSPARENT_ALPHA_VALUE_EXT = $28;
  GLX_NONE_EXT = $8000;
  GLX_TRUE_COLOR_EXT = $8002;
  GLX_DIRECT_COLOR_EXT = $8003;
  GLX_PSEUDO_COLOR_EXT = $8004;
  GLX_STATIC_COLOR_EXT = $8005;
  GLX_GRAY_SCALE_EXT = $8006;
  GLX_STATIC_GRAY_EXT = $8007;
  GLX_TRANSPARENT_RGB_EXT = $8008;
  GLX_TRANSPARENT_INDEX_EXT = $8009;


  { ------------------------- GLX_EXT_visual_rating -------------------------  }

const
  GLX_EXT_visual_rating = 1;
  GLX_VISUAL_CAVEAT_EXT = $20;
  GLX_SLOW_VISUAL_EXT = $8001;
  GLX_NON_CONFORMANT_VISUAL_EXT = $800D;


  { -------------------------- GLX_INTEL_swap_event -------------------------  }

const
  GLX_INTEL_swap_event = 1;
  GLX_EXCHANGE_COMPLETE_INTEL = $8180;
  GLX_COPY_COMPLETE_INTEL = $8181;
  GLX_FLIP_COMPLETE_INTEL = $8182;
  GLX_BUFFER_SWAP_COMPLETE_INTEL_MASK = $04000000;


  { -------------------------- GLX_MESA_agp_offset --------------------------  }

const
  GLX_MESA_agp_offset = 1;

type
  TPFNGLXGETAGPOFFSETMESAPROC = function(pointer: pointer): dword; cdecl;


  { ------------------------ GLX_MESA_copy_sub_buffer -----------------------  }

const
  GLX_MESA_copy_sub_buffer = 1;

type
  TPFNGLXCOPYSUBBUFFERMESAPROC = procedure(dpy: PDisplay; drawable: TGLXDrawable; x: longint; y: longint; width: longint; height: longint); cdecl;


  { ------------------------ GLX_MESA_pixmap_colormap -----------------------  }

const
  GLX_MESA_pixmap_colormap = 1;

type
  TPFNGLXCREATEGLXPIXMAPMESAPROC = function(dpy: PDisplay; visual: PXVisualInfo; pixmap: TPixmap; cmap: TColormap): TGLXPixmap; cdecl;


  { ------------------------ GLX_MESA_query_renderer ------------------------  }

const
  GLX_MESA_query_renderer = 1;
  GLX_RENDERER_VENDOR_ID_MESA = $8183;
  GLX_RENDERER_DEVICE_ID_MESA = $8184;
  GLX_RENDERER_VERSION_MESA = $8185;
  GLX_RENDERER_ACCELERATED_MESA = $8186;
  GLX_RENDERER_VIDEO_MEMORY_MESA = $8187;
  GLX_RENDERER_UNIFIED_MEMORY_ARCHITECTURE_MESA = $8188;
  GLX_RENDERER_PREFERRED_PROFILE_MESA = $8189;
  GLX_RENDERER_OPENGL_CORE_PROFILE_VERSION_MESA = $818A;
  GLX_RENDERER_OPENGL_COMPATIBILITY_PROFILE_VERSION_MESA = $818B;
  GLX_RENDERER_OPENGL_ES_PROFILE_VERSION_MESA = $818C;
  GLX_RENDERER_OPENGL_ES2_PROFILE_VERSION_MESA = $818D;

type
  TPFNGLXQUERYCURRENTRENDERERINTEGERMESAPROC = function(attribute: longint; value: Pdword): TBool; cdecl;
  TPFNGLXQUERYCURRENTRENDERERSTRINGMESAPROC = function(attribute: longint): pchar; cdecl;
  TPFNGLXQUERYRENDERERINTEGERMESAPROC = function(dpy: PDisplay; screen: longint; renderer: longint; attribute: longint; value: Pdword): TBool; cdecl;
  TPFNGLXQUERYRENDERERSTRINGMESAPROC = function(dpy: PDisplay; screen: longint; renderer: longint; attribute: longint): pchar; cdecl;


  { ------------------------ GLX_MESA_release_buffers -----------------------  }

const
  GLX_MESA_release_buffers = 1;

type
  TPFNGLXRELEASEBUFFERSMESAPROC = function(dpy: PDisplay; drawable: TGLXDrawable): TBool; cdecl;


  { ------------------------- GLX_MESA_set_3dfx_mode ------------------------  }

const
  GLX_MESA_set_3dfx_mode = 1;
  GLX_3DFX_WINDOW_MODE_MESA = $1;
  GLX_3DFX_FULLSCREEN_MODE_MESA = $2;

type
  TPFNGLXSET3DFXMODEMESAPROC = function(mode: TGLint): TGLboolean; cdecl;


  { ------------------------- GLX_MESA_swap_control -------------------------  }

const
  GLX_MESA_swap_control = 1;

type
  TPFNGLXGETSWAPINTERVALMESAPROC = function(para1: pointer): longint; cdecl;
  TPFNGLXSWAPINTERVALMESAPROC = function(interval: dword): longint; cdecl;

  { --------------------------- GLX_NV_copy_buffer --------------------------  }

const
  GLX_NV_copy_buffer = 1;

type
  TPFNGLXCOPYBUFFERSUBDATANVPROC = procedure(dpy: PDisplay; readCtx: TGLXContext; writeCtx: TGLXContext; readTarget: TGLenum; writeTarget: TGLenum;
    readOffset: TGLintptr; writeOffset: TGLintptr; size: TGLsizeiptr); cdecl;
  TPFNGLXNAMEDCOPYBUFFERSUBDATANVPROC = procedure(dpy: PDisplay; readCtx: TGLXContext; writeCtx: TGLXContext; readBuffer: TGLuint; writeBuffer: TGLuint;
    readOffset: TGLintptr; writeOffset: TGLintptr; size: TGLsizeiptr); cdecl;


  { --------------------------- GLX_NV_copy_image ---------------------------  }

const
  GLX_NV_copy_image = 1;

type
  TPFNGLXCOPYIMAGESUBDATANVPROC = procedure(dpy: PDisplay; srcCtx: TGLXContext; srcName: TGLuint; srcTarget: TGLenum; srcLevel: TGLint;
    srcX: TGLint; srcY: TGLint; srcZ: TGLint; dstCtx: TGLXContext; dstName: TGLuint;
    dstTarget: TGLenum; dstLevel: TGLint; dstX: TGLint; dstY: TGLint; dstZ: TGLint;
    width: TGLsizei; height: TGLsizei; depth: TGLsizei); cdecl;


  { ------------------------ GLX_NV_delay_before_swap -----------------------  }

const
  GLX_NV_delay_before_swap = 1;

type
  TPFNGLXDELAYBEFORESWAPNVPROC = function(dpy: PDisplay; drawable: TGLXDrawable; seconds: TGLfloat): TBool; cdecl;


  { -------------------------- GLX_NV_float_buffer --------------------------  }

const
  GLX_NV_float_buffer = 1;
  GLX_FLOAT_COMPONENTS_NV = $20B0;


  { ------------------------ GLX_NV_multigpu_context ------------------------  }

const
  GLX_NV_multigpu_context = 1;
  GLX_CONTEXT_MULTIGPU_ATTRIB_NV = $20AA;
  GLX_CONTEXT_MULTIGPU_ATTRIB_SINGLE_NV = $20AB;
  GLX_CONTEXT_MULTIGPU_ATTRIB_AFR_NV = $20AC;
  GLX_CONTEXT_MULTIGPU_ATTRIB_MULTICAST_NV = $20AD;
  GLX_CONTEXT_MULTIGPU_ATTRIB_MULTI_DISPLAY_MULTICAST_NV = $20AE;


  { ---------------------- GLX_NV_multisample_coverage ----------------------  }

const
  GLX_NV_multisample_coverage = 1;
  GLX_COLOR_SAMPLES_NV = $20B3;
  GLX_COVERAGE_SAMPLES_NV = 100001;


  { -------------------------- GLX_NV_present_video -------------------------  }

const
  GLX_NV_present_video = 1;
  GLX_NUM_VIDEO_SLOTS_NV = $20F0;

type
  TPFNGLXBINDVIDEODEVICENVPROC = function(dpy: PDisplay; video_slot: dword; video_device: dword; attrib_list: Plongint): longint; cdecl;
  TPFNGLXENUMERATEVIDEODEVICESNVPROC = function(dpy: PDisplay; screen: longint; nelements: Plongint): Pdword; cdecl;


  { ------------------ GLX_NV_robustness_video_memory_purge -----------------  }

const
  GLX_NV_robustness_video_memory_purge = 1;
  GLX_GENERATE_RESET_ON_VIDEO_MEMORY_PURGE_NV = $20F7;


  { --------------------------- GLX_NV_swap_group ---------------------------  }

const
  GLX_NV_swap_group = 1;

type
  TPFNGLXBINDSWAPBARRIERNVPROC = function(dpy: PDisplay; group: TGLuint; barrier: TGLuint): TBool; cdecl;
  TPFNGLXJOINSWAPGROUPNVPROC = function(dpy: PDisplay; drawable: TGLXDrawable; group: TGLuint): TBool; cdecl;
  TPFNGLXQUERYFRAMECOUNTNVPROC = function(dpy: PDisplay; screen: longint; count: PGLuint): TBool; cdecl;
  TPFNGLXQUERYMAXSWAPGROUPSNVPROC = function(dpy: PDisplay; screen: longint; maxGroups: PGLuint; maxBarriers: PGLuint): TBool; cdecl;
  TPFNGLXQUERYSWAPGROUPNVPROC = function(dpy: PDisplay; drawable: TGLXDrawable; group: PGLuint; barrier: PGLuint): TBool; cdecl;
  TPFNGLXRESETFRAMECOUNTNVPROC = function(dpy: PDisplay; screen: longint): TBool; cdecl;


  { ----------------------- GLX_NV_vertex_array_range -----------------------  }

const
  GLX_NV_vertex_array_range = 1;

type
  TPFNGLXALLOCATEMEMORYNVPROC = function(size: TGLsizei; readFrequency: TGLfloat; writeFrequency: TGLfloat; priority: TGLfloat): pointer; cdecl;
  TPFNGLXFREEMEMORYNVPROC = procedure(pointer: pointer); cdecl;


  { -------------------------- GLX_NV_video_capture -------------------------  }

const
  GLX_NV_video_capture = 1;
  GLX_DEVICE_ID_NV = $20CD;
  GLX_UNIQUE_ID_NV = $20CE;
  GLX_NUM_VIDEO_CAPTURE_SLOTS_NV = $20CF;

type
  PGLXVideoCaptureDeviceNV = ^TGLXVideoCaptureDeviceNV;
  TGLXVideoCaptureDeviceNV = TXID;

  TPFNGLXBINDVIDEOCAPTUREDEVICENVPROC = function(dpy: PDisplay; video_capture_slot: dword; device: TGLXVideoCaptureDeviceNV): longint; cdecl;
  TPFNGLXENUMERATEVIDEOCAPTUREDEVICESNVPROC = function(dpy: PDisplay; screen: longint; nelements: Plongint): PGLXVideoCaptureDeviceNV; cdecl;
  TPFNGLXLOCKVIDEOCAPTUREDEVICENVPROC = procedure(dpy: PDisplay; device: TGLXVideoCaptureDeviceNV); cdecl;
  TPFNGLXQUERYVIDEOCAPTUREDEVICENVPROC = function(dpy: PDisplay; device: TGLXVideoCaptureDeviceNV; attribute: longint; value: Plongint): longint; cdecl;
  TPFNGLXRELEASEVIDEOCAPTUREDEVICENVPROC = procedure(dpy: PDisplay; device: TGLXVideoCaptureDeviceNV); cdecl;


  { ---------------------------- GLX_NV_video_out ---------------------------  }

const
  GLX_NV_video_out = 1;
  GLX_VIDEO_OUT_COLOR_NV = $20C3;
  GLX_VIDEO_OUT_ALPHA_NV = $20C4;
  GLX_VIDEO_OUT_DEPTH_NV = $20C5;
  GLX_VIDEO_OUT_COLOR_AND_ALPHA_NV = $20C6;
  GLX_VIDEO_OUT_COLOR_AND_DEPTH_NV = $20C7;
  GLX_VIDEO_OUT_FRAME_NV = $20C8;
  GLX_VIDEO_OUT_FIELD_1_NV = $20C9;
  GLX_VIDEO_OUT_FIELD_2_NV = $20CA;
  GLX_VIDEO_OUT_STACKED_FIELDS_1_2_NV = $20CB;
  GLX_VIDEO_OUT_STACKED_FIELDS_2_1_NV = $20CC;

type
  TPFNGLXBINDVIDEOIMAGENVPROC = function(dpy: PDisplay; VideoDevice: TGLXVideoDeviceNV; pbuf: TGLXPbuffer; iVideoBuffer: longint): longint; cdecl;
  TPFNGLXGETVIDEODEVICENVPROC = function(dpy: PDisplay; screen: longint; numVideoDevices: longint; pVideoDevice: PGLXVideoDeviceNV): longint; cdecl;
  TPFNGLXGETVIDEOINFONVPROC = function(dpy: PDisplay; screen: longint; VideoDevice: TGLXVideoDeviceNV; pulCounterOutputPbuffer: Pdword; pulCounterOutputVideo: Pdword): longint; cdecl;
  TPFNGLXRELEASEVIDEODEVICENVPROC = function(dpy: PDisplay; screen: longint; VideoDevice: TGLXVideoDeviceNV): longint; cdecl;
  TPFNGLXRELEASEVIDEOIMAGENVPROC = function(dpy: PDisplay; pbuf: TGLXPbuffer): longint; cdecl;
  TPFNGLXSENDPBUFFERTOVIDEONVPROC = function(dpy: PDisplay; pbuf: TGLXPbuffer; iBufferType: longint; pulCounterPbuffer: Pdword; bBlock: TGLboolean): longint; cdecl;


  { -------------------------- GLX_OML_swap_method --------------------------  }

const
  GLX_OML_swap_method = 1;
  GLX_SWAP_METHOD_OML = $8060;
  GLX_SWAP_EXCHANGE_OML = $8061;
  GLX_SWAP_COPY_OML = $8062;
  GLX_SWAP_UNDEFINED_OML = $8063;


  { -------------------------- GLX_OML_sync_control -------------------------  }

const
  GLX_OML_sync_control = 1;

type
  TPFNGLXGETMSCRATEOMLPROC = function(dpy: PDisplay; drawable: TGLXDrawable; numerator: Pint32_t; denominator: Pint32_t): TBool; cdecl;
  TPFNGLXGETSYNCVALUESOMLPROC = function(dpy: PDisplay; drawable: TGLXDrawable; ust: Pint64_t; msc: Pint64_t; sbc: Pint64_t): TBool; cdecl;
  TPFNGLXSWAPBUFFERSMSCOMLPROC = function(dpy: PDisplay; drawable: TGLXDrawable; target_msc: Tint64_t; divisor: Tint64_t; remainder: Tint64_t): Tint64_t; cdecl;
  TPFNGLXWAITFORMSCOMLPROC = function(dpy: PDisplay; drawable: TGLXDrawable; target_msc: Tint64_t; divisor: Tint64_t; remainder: Tint64_t; ust: Pint64_t; msc: Pint64_t; sbc: Pint64_t): TBool; cdecl;
  TPFNGLXWAITFORSBCOMLPROC = function(dpy: PDisplay; drawable: TGLXDrawable; target_sbc: Tint64_t; ust: Pint64_t; msc: Pint64_t; sbc: Pint64_t): TBool; cdecl;


  { ------------------------ GLX_SGIS_blended_overlay -----------------------  }

const
  GLX_SGIS_blended_overlay = 1;
  GLX_BLENDED_RGBA_SGIS = $8025;


  { -------------------------- GLX_SGIS_color_range -------------------------  }

const
  GLX_SGIS_color_range = 1;


  { -------------------------- GLX_SGIS_multisample -------------------------  }

const
  GLX_SGIS_multisample = 1;
  GLX_SAMPLE_BUFFERS_SGIS = 100000;
  GLX_SAMPLES_SGIS = 100001;


  { ---------------------- GLX_SGIS_shared_multisample ----------------------  }

const
  GLX_SGIS_shared_multisample = 1;
  GLX_MULTISAMPLE_SUB_RECT_WIDTH_SGIS = $8026;
  GLX_MULTISAMPLE_SUB_RECT_HEIGHT_SGIS = $8027;


  { --------------------------- GLX_SGIX_fbconfig ---------------------------  }

const
  GLX_SGIX_fbconfig = 1;
  GLX_RGBA_BIT_SGIX = $00000001;
  GLX_WINDOW_BIT_SGIX = $00000001;
  GLX_COLOR_INDEX_BIT_SGIX = $00000002;
  GLX_PIXMAP_BIT_SGIX = $00000002;
  //  GLX_SCREEN_EXT = $800C;  Doppelt
  GLX_DRAWABLE_TYPE_SGIX = $8010;
  GLX_RENDER_TYPE_SGIX = $8011;
  GLX_X_RENDERABLE_SGIX = $8012;
  GLX_FBCONFIG_ID_SGIX = $8013;
  GLX_RGBA_TYPE_SGIX = $8014;
  GLX_COLOR_INDEX_TYPE_SGIX = $8015;

type
  PGLXFBConfigIDSGIX = ^TGLXFBConfigIDSGIX;
  TGLXFBConfigIDSGIX = TXID;

  PGLXFBConfigSGIX = ^TGLXFBConfigSGIX;
  TGLXFBConfigSGIX = type Pointer;

  TPFNGLXCHOOSEFBCONFIGSGIXPROC = function(dpy: PDisplay; screen: longint; attrib_list: Plongint; nelements: Plongint): PGLXFBConfigSGIX; cdecl;
  TPFNGLXCREATECONTEXTWITHCONFIGSGIXPROC = function(dpy: PDisplay; config: TGLXFBConfigSGIX; render_type: longint; share_list: TGLXContext; direct: TBool): TGLXContext; cdecl;
  TPFNGLXCREATEGLXPIXMAPWITHCONFIGSGIXPROC = function(dpy: PDisplay; config: TGLXFBConfigSGIX; pixmap: TPixmap): TGLXPixmap; cdecl;
  TPFNGLXGETFBCONFIGATTRIBSGIXPROC = function(dpy: PDisplay; config: TGLXFBConfigSGIX; attribute: longint; value: Plongint): longint; cdecl;
  TPFNGLXGETFBCONFIGFROMVISUALSGIXPROC = function(dpy: PDisplay; vis: PXVisualInfo): TGLXFBConfigSGIX; cdecl;
  TPFNGLXGETVISUALFROMFBCONFIGSGIXPROC = function(dpy: PDisplay; config: TGLXFBConfigSGIX): PXVisualInfo; cdecl;


  { --------------------------- GLX_SGIX_hyperpipe --------------------------  }

const
  GLX_SGIX_hyperpipe = 1;
  GLX_HYPERPIPE_DISPLAY_PIPE_SGIX = $00000001;
  GLX_PIPE_RECT_SGIX = $00000001;
  GLX_HYPERPIPE_RENDER_PIPE_SGIX = $00000002;
  GLX_PIPE_RECT_LIMITS_SGIX = $00000002;
  GLX_HYPERPIPE_STEREO_SGIX = $00000003;
  GLX_HYPERPIPE_PIXEL_AVERAGE_SGIX = $00000004;
  GLX_HYPERPIPE_PIPE_NAME_LENGTH_SGIX = 80;
  GLX_BAD_HYPERPIPE_CONFIG_SGIX = 91;
  GLX_BAD_HYPERPIPE_SGIX = 92;
  GLX_HYPERPIPE_ID_SGIX = $8030;

type
  TGLXHyperpipeNetworkSGIX = record
    pipeName: array[0..(GLX_HYPERPIPE_PIPE_NAME_LENGTH_SGIX) - 1] of char;
    networkId: longint;
  end;
  PGLXHyperpipeNetworkSGIX = ^TGLXHyperpipeNetworkSGIX;

  TGLXPipeRectLimits = record
    pipeName: array[0..(GLX_HYPERPIPE_PIPE_NAME_LENGTH_SGIX) - 1] of char;
    XOrigin: longint;
    YOrigin: longint;
    maxHeight: longint;
    maxWidth: longint;
  end;
  PGLXPipeRectLimits = ^TGLXPipeRectLimits;

  TGLXHyperpipeConfigSGIX = record
    pipeName: array[0..(GLX_HYPERPIPE_PIPE_NAME_LENGTH_SGIX) - 1] of char;
    channel: longint;
    participationType: dword;
    timeSlice: longint;
  end;
  PGLXHyperpipeConfigSGIX = ^TGLXHyperpipeConfigSGIX;

  TGLXPipeRect = record
    pipeName: array[0..(GLX_HYPERPIPE_PIPE_NAME_LENGTH_SGIX) - 1] of char;
    srcXOrigin: longint;
    srcYOrigin: longint;
    srcWidth: longint;
    srcHeight: longint;
    destXOrigin: longint;
    destYOrigin: longint;
    destWidth: longint;
    destHeight: longint;
  end;
  PGLXPipeRect = ^TGLXPipeRect;

  TPFNGLXBINDHYPERPIPESGIXPROC = function(dpy: PDisplay; hpId: longint): longint; cdecl;
  TPFNGLXDESTROYHYPERPIPECONFIGSGIXPROC = function(dpy: PDisplay; hpId: longint): longint; cdecl;
  TPFNGLXHYPERPIPEATTRIBSGIXPROC = function(dpy: PDisplay; timeSlice: longint; attrib: longint; size: longint; attribList: pointer): longint; cdecl;
  TPFNGLXHYPERPIPECONFIGSGIXPROC = function(dpy: PDisplay; networkId: longint; npipes: longint; cfg: PGLXHyperpipeConfigSGIX; hpId: Plongint): longint; cdecl;
  TPFNGLXQUERYHYPERPIPEATTRIBSGIXPROC = function(dpy: PDisplay; timeSlice: longint; attrib: longint; size: longint; returnAttribList: pointer): longint; cdecl;
  TPFNGLXQUERYHYPERPIPEBESTATTRIBSGIXPROC = function(dpy: PDisplay; timeSlice: longint; attrib: longint; size: longint; attribList: pointer; returnAttribList: pointer): longint; cdecl;
  TPFNGLXQUERYHYPERPIPECONFIGSGIXPROC = function(dpy: PDisplay; hpId: longint; npipes: Plongint): PGLXHyperpipeConfigSGIX; cdecl;
  TPFNGLXQUERYHYPERPIPENETWORKSGIXPROC = function(dpy: PDisplay; npipes: Plongint): PGLXHyperpipeNetworkSGIX; cdecl;


  { ---------------------------- GLX_SGIX_pbuffer ---------------------------  }

const
  GLX_SGIX_pbuffer = 1;
  GLX_FRONT_LEFT_BUFFER_BIT_SGIX = $00000001;
  GLX_FRONT_RIGHT_BUFFER_BIT_SGIX = $00000002;
  GLX_BACK_LEFT_BUFFER_BIT_SGIX = $00000004;
  GLX_PBUFFER_BIT_SGIX = $00000004;
  GLX_BACK_RIGHT_BUFFER_BIT_SGIX = $00000008;
  GLX_AUX_BUFFERS_BIT_SGIX = $00000010;
  GLX_DEPTH_BUFFER_BIT_SGIX = $00000020;
  GLX_STENCIL_BUFFER_BIT_SGIX = $00000040;
  GLX_ACCUM_BUFFER_BIT_SGIX = $00000080;
  GLX_SAMPLE_BUFFERS_BIT_SGIX = $00000100;
  GLX_MAX_PBUFFER_WIDTH_SGIX = $8016;
  GLX_MAX_PBUFFER_HEIGHT_SGIX = $8017;
  GLX_MAX_PBUFFER_PIXELS_SGIX = $8018;
  GLX_OPTIMAL_PBUFFER_WIDTH_SGIX = $8019;
  GLX_OPTIMAL_PBUFFER_HEIGHT_SGIX = $801A;
  GLX_PRESERVED_CONTENTS_SGIX = $801B;
  GLX_LARGEST_PBUFFER_SGIX = $801C;
  GLX_WIDTH_SGIX = $801D;
  GLX_HEIGHT_SGIX = $801E;
  GLX_EVENT_MASK_SGIX = $801F;
  GLX_DAMAGED_SGIX = $8020;
  GLX_SAVED_SGIX = $8021;
  GLX_WINDOW_SGIX = $8022;
  GLX_PBUFFER_SGIX = $8023;
  GLX_BUFFER_CLOBBER_MASK_SGIX = $08000000;

type
  PGLXPbufferSGIX = ^TGLXPbufferSGIX;
  TGLXPbufferSGIX = TXID;

  TGLXBufferClobberEventSGIX = record
    _type: longint;
    serial: dword;
    send_event: TBool;
    display: PDisplay;
    drawable: TGLXDrawable;
    event_type: longint;
    draw_type: longint;
    mask: dword;
    x: longint;
    y: longint;
    width: longint;
    height: longint;
    count: longint;
  end;
  PGLXBufferClobberEventSGIX = ^TGLXBufferClobberEventSGIX;

  TPFNGLXCREATEGLXPBUFFERSGIXPROC = function(dpy: PDisplay; config: TGLXFBConfigSGIX; width: dword; height: dword; attrib_list: Plongint): TGLXPbufferSGIX; cdecl;
  TPFNGLXDESTROYGLXPBUFFERSGIXPROC = procedure(dpy: PDisplay; pbuf: TGLXPbufferSGIX); cdecl;
  TPFNGLXGETSELECTEDEVENTSGIXPROC = procedure(dpy: PDisplay; drawable: TGLXDrawable; mask: Pdword); cdecl;
  TPFNGLXQUERYGLXPBUFFERSGIXPROC = procedure(dpy: PDisplay; pbuf: TGLXPbufferSGIX; attribute: longint; value: Pdword); cdecl;
  TPFNGLXSELECTEVENTSGIXPROC = procedure(dpy: PDisplay; drawable: TGLXDrawable; mask: dword); cdecl;


  { ------------------------- GLX_SGIX_swap_barrier -------------------------  }

const
  GLX_SGIX_swap_barrier = 1;

type
  TPFNGLXBINDSWAPBARRIERSGIXPROC = procedure(dpy: PDisplay; drawable: TGLXDrawable; barrier: longint); cdecl;
  TPFNGLXQUERYMAXSWAPBARRIERSSGIXPROC = function(dpy: PDisplay; screen: longint; max: Plongint): TBool; cdecl;


  { -------------------------- GLX_SGIX_swap_group --------------------------  }

const
  GLX_SGIX_swap_group = 1;

type
  TPFNGLXJOINSWAPGROUPSGIXPROC = procedure(dpy: PDisplay; drawable: TGLXDrawable; member: TGLXDrawable); cdecl;


  { ------------------------- GLX_SGIX_video_resize -------------------------  }

const
  GLX_SGIX_video_resize = 1;
  GLX_SYNC_FRAME_SGIX = $00000000;
  GLX_SYNC_SWAP_SGIX = $00000001;

type
  TPFNGLXBINDCHANNELTOWINDOWSGIXPROC = function(display: PDisplay; screen: longint; channel: longint; window: TWindow): longint; cdecl;
  TPFNGLXCHANNELRECTSGIXPROC = function(display: PDisplay; screen: longint; channel: longint; x: longint; y: longint; w: longint; h: longint): longint; cdecl;
  TPFNGLXCHANNELRECTSYNCSGIXPROC = function(display: PDisplay; screen: longint; channel: longint; synctype: TGLenum): longint; cdecl;
  TPFNGLXQUERYCHANNELDELTASSGIXPROC = function(display: PDisplay; screen: longint; channel: longint; x: Plongint; y: Plongint; w: Plongint; h: Plongint): longint; cdecl;
  TPFNGLXQUERYCHANNELRECTSGIXPROC = function(display: PDisplay; screen: longint; channel: longint; dx: Plongint; dy: Plongint; dw: Plongint; dh: Plongint): longint; cdecl;


  { ---------------------- GLX_SGIX_visual_select_group ---------------------  }

const
  GLX_SGIX_visual_select_group = 1;
  GLX_VISUAL_SELECT_GROUP_SGIX = $8028;


  { ---------------------------- GLX_SGI_cushion ----------------------------  }

const
  GLX_SGI_cushion = 1;

type
  TPFNGLXCUSHIONSGIPROC = procedure(dpy: PDisplay; window: TWindow; cushion: single); cdecl;


  { ----------------------- GLX_SGI_make_current_read -----------------------  }

const
  GLX_SGI_make_current_read = 1;

type
  TPFNGLXGETCURRENTREADDRAWABLESGIPROC = function(para1: pointer): TGLXDrawable; cdecl;
  TPFNGLXMAKECURRENTREADSGIPROC = function(dpy: PDisplay; draw: TGLXDrawable; read: TGLXDrawable; ctx: TGLXContext): TBool; cdecl;


  { -------------------------- GLX_SGI_swap_control -------------------------  }

const
  GLX_SGI_swap_control = 1;

type
  TPFNGLXSWAPINTERVALSGIPROC = function(interval: longint): longint; cdecl;


  { --------------------------- GLX_SGI_video_sync --------------------------  }

const
  GLX_SGI_video_sync = 1;

type
  TPFNGLXGETVIDEOSYNCSGIPROC = function(count: Pdword): longint; cdecl;
  TPFNGLXWAITVIDEOSYNCSGIPROC = function(divisor: longint; remainder: longint; count: Pdword): longint; cdecl;


  { --------------------- GLX_SUN_get_transparent_index ---------------------  }

const
  GLX_SUN_get_transparent_index = 1;

type
  TPFNGLXGETTRANSPARENTINDEXSUNPROC = function(dpy: PDisplay; overlay: TWindow; underlay: TWindow; pTransparentIndex: Pdword): TStatus; cdecl;


  { -------------------------- GLX_SUN_video_resize -------------------------  }

const
  GLX_SUN_video_resize = 1;
  GLX_VIDEO_RESIZE_SUN = $8171;
  GL_VIDEO_RESIZE_COMPENSATION_SUN = $85CD;

type
  TPFNGLXGETVIDEORESIZESUNPROC = function(display: PDisplay; window: TGLXDrawable; factor: Psingle): longint; cdecl;
  TPFNGLXVIDEORESIZESUNPROC = function(display: PDisplay; window: TGLXDrawable; factor: single): longint; cdecl;


  { -------------------------------------------------------------------------  }

var
  __glewXGetCurrentDisplay: TPFNGLXGETCURRENTDISPLAYPROC; cvar;external libGLXEW;
  glXGetCurrentDisplay: TPFNGLXGETCURRENTDISPLAYPROC absolute __glewXGetCurrentDisplay;

  __glewXChooseFBConfig: TPFNGLXCHOOSEFBCONFIGPROC; cvar;external libGLXEW;
  glXChooseFBConfig: TPFNGLXCHOOSEFBCONFIGPROC absolute __glewXChooseFBConfig;

  __glewXCreateNewContext: TPFNGLXCREATENEWCONTEXTPROC; cvar;external libGLXEW;
  glXCreateNewContext: TPFNGLXCREATENEWCONTEXTPROC absolute __glewXCreateNewContext;

  __glewXCreatePbuffer: TPFNGLXCREATEPBUFFERPROC; cvar;external libGLXEW;
  glXCreatePbuffer: TPFNGLXCREATEPBUFFERPROC absolute __glewXCreatePbuffer;

  __glewXCreatePixmap: TPFNGLXCREATEPIXMAPPROC; cvar;external libGLXEW;
  glXCreatePixmap: TPFNGLXCREATEPIXMAPPROC absolute __glewXCreatePixmap;

  __glewXCreateWindow: TPFNGLXCREATEWINDOWPROC; cvar;external libGLXEW;
  glXCreateWindow: TPFNGLXCREATEWINDOWPROC absolute __glewXCreateWindow;

  __glewXDestroyPbuffer: TPFNGLXDESTROYPBUFFERPROC; cvar;external libGLXEW;
  glXDestroyPbuffer: TPFNGLXDESTROYPBUFFERPROC absolute __glewXDestroyPbuffer;

  __glewXDestroyPixmap: TPFNGLXDESTROYPIXMAPPROC; cvar;external libGLXEW;
  glXDestroyPixmap: TPFNGLXDESTROYPIXMAPPROC absolute __glewXDestroyPixmap;

  __glewXDestroyWindow: TPFNGLXDESTROYWINDOWPROC; cvar;external libGLXEW;
  glXDestroyWindow: TPFNGLXDESTROYWINDOWPROC absolute __glewXDestroyWindow;

  __glewXGetCurrentReadDrawable: TPFNGLXGETCURRENTREADDRAWABLEPROC; cvar;external libGLXEW;
  glXGetCurrentReadDrawable: TPFNGLXGETCURRENTREADDRAWABLEPROC absolute __glewXGetCurrentReadDrawable;

  __glewXGetFBConfigAttrib: TPFNGLXGETFBCONFIGATTRIBPROC; cvar;external libGLXEW;
  glXGetFBConfigAttrib: TPFNGLXGETFBCONFIGATTRIBPROC absolute __glewXGetFBConfigAttrib;

  __glewXGetFBConfigs: TPFNGLXGETFBCONFIGSPROC; cvar;external libGLXEW;
  glXGetFBConfigs: TPFNGLXGETFBCONFIGSPROC absolute __glewXGetFBConfigs;

  __glewXGetSelectedEvent: TPFNGLXGETSELECTEDEVENTPROC; cvar;external libGLXEW;
  glXGetSelectedEvent: TPFNGLXGETSELECTEDEVENTPROC absolute __glewXGetSelectedEvent;

  __glewXGetVisualFromFBConfig: TPFNGLXGETVISUALFROMFBCONFIGPROC; cvar;external libGLXEW;
  glXGetVisualFromFBConfig: TPFNGLXGETVISUALFROMFBCONFIGPROC absolute __glewXGetVisualFromFBConfig;

  __glewXMakeContextCurrent: TPFNGLXMAKECONTEXTCURRENTPROC; cvar;external libGLXEW;
  glXMakeContextCurrent: TPFNGLXMAKECONTEXTCURRENTPROC absolute __glewXMakeContextCurrent;

  __glewXQueryContext: TPFNGLXQUERYCONTEXTPROC; cvar;external libGLXEW;
  glXQueryContext: TPFNGLXQUERYCONTEXTPROC absolute __glewXQueryContext;

  __glewXQueryDrawable: TPFNGLXQUERYDRAWABLEPROC; cvar;external libGLXEW;
  glXQueryDrawable: TPFNGLXQUERYDRAWABLEPROC absolute __glewXQueryDrawable;

  __glewXSelectEvent: TPFNGLXSELECTEVENTPROC; cvar;external libGLXEW;
  glXSelectEvent: TPFNGLXSELECTEVENTPROC absolute __glewXSelectEvent;

  __glewXBlitContextFramebufferAMD: TPFNGLXBLITCONTEXTFRAMEBUFFERAMDPROC; cvar;external libGLXEW;
  glXBlitContextFramebufferAMD: TPFNGLXBLITCONTEXTFRAMEBUFFERAMDPROC absolute __glewXBlitContextFramebufferAMD;

  __glewXCreateAssociatedContextAMD: TPFNGLXCREATEASSOCIATEDCONTEXTAMDPROC; cvar;external libGLXEW;
  glXCreateAssociatedContextAMD: TPFNGLXCREATEASSOCIATEDCONTEXTAMDPROC absolute __glewXCreateAssociatedContextAMD;

  __glewXCreateAssociatedContextAttribsAMD: TPFNGLXCREATEASSOCIATEDCONTEXTATTRIBSAMDPROC; cvar;external libGLXEW;
  glXCreateAssociatedContextAttribsAMD: TPFNGLXCREATEASSOCIATEDCONTEXTATTRIBSAMDPROC absolute __glewXCreateAssociatedContextAttribsAMD;

  __glewXDeleteAssociatedContextAMD: TPFNGLXDELETEASSOCIATEDCONTEXTAMDPROC; cvar;external libGLXEW;
  glXDeleteAssociatedContextAMD: TPFNGLXDELETEASSOCIATEDCONTEXTAMDPROC absolute __glewXDeleteAssociatedContextAMD;

  __glewXGetContextGPUIDAMD: TPFNGLXGETCONTEXTGPUIDAMDPROC; cvar;external libGLXEW;
  glXGetContextGPUIDAMD: TPFNGLXGETCONTEXTGPUIDAMDPROC absolute __glewXGetContextGPUIDAMD;

  __glewXGetCurrentAssociatedContextAMD: TPFNGLXGETCURRENTASSOCIATEDCONTEXTAMDPROC; cvar;external libGLXEW;
  glXGetCurrentAssociatedContextAMD: TPFNGLXGETCURRENTASSOCIATEDCONTEXTAMDPROC absolute __glewXGetCurrentAssociatedContextAMD;

  __glewXGetGPUIDsAMD: TPFNGLXGETGPUIDSAMDPROC; cvar;external libGLXEW;
  glXGetGPUIDsAMD: TPFNGLXGETGPUIDSAMDPROC absolute __glewXGetGPUIDsAMD;

  __glewXGetGPUInfoAMD: TPFNGLXGETGPUINFOAMDPROC; cvar;external libGLXEW;
  glXGetGPUInfoAMD: TPFNGLXGETGPUINFOAMDPROC absolute __glewXGetGPUInfoAMD;

  __glewXMakeAssociatedContextCurrentAMD: TPFNGLXMAKEASSOCIATEDCONTEXTCURRENTAMDPROC; cvar;external libGLXEW;
  glXMakeAssociatedContextCurrentAMD: TPFNGLXMAKEASSOCIATEDCONTEXTCURRENTAMDPROC absolute __glewXMakeAssociatedContextCurrentAMD;

  __glewXCreateContextAttribsARB: TPFNGLXCREATECONTEXTATTRIBSARBPROC; cvar;external libGLXEW;
  glXCreateContextAttribsARB: TPFNGLXCREATECONTEXTATTRIBSARBPROC absolute __glewXCreateContextAttribsARB;

  __glewXBindTexImageATI: TPFNGLXBINDTEXIMAGEATIPROC; cvar;external libGLXEW;
  glXBindTexImageATI: TPFNGLXBINDTEXIMAGEATIPROC absolute __glewXBindTexImageATI;

  __glewXDrawableAttribATI: TPFNGLXDRAWABLEATTRIBATIPROC; cvar;external libGLXEW;
  glXDrawableAttribATI: TPFNGLXDRAWABLEATTRIBATIPROC absolute __glewXDrawableAttribATI;

  __glewXReleaseTexImageATI: TPFNGLXRELEASETEXIMAGEATIPROC; cvar;external libGLXEW;
  glXReleaseTexImageATI: TPFNGLXRELEASETEXIMAGEATIPROC absolute __glewXReleaseTexImageATI;

  __glewXFreeContextEXT: TPFNGLXFREECONTEXTEXTPROC; cvar;external libGLXEW;
  glXFreeContextEXT: TPFNGLXFREECONTEXTEXTPROC absolute __glewXFreeContextEXT;

  __glewXGetContextIDEXT: TPFNGLXGETCONTEXTIDEXTPROC; cvar;external libGLXEW;
  glXGetContextIDEXT: TPFNGLXGETCONTEXTIDEXTPROC absolute __glewXGetContextIDEXT;

  __glewXGetCurrentDisplayEXT: TPFNGLXGETCURRENTDISPLAYEXTPROC; cvar;external libGLXEW;
  glXGetCurrentDisplayEXT: TPFNGLXGETCURRENTDISPLAYEXTPROC absolute __glewXGetCurrentDisplayEXT;

  __glewXImportContextEXT: TPFNGLXIMPORTCONTEXTEXTPROC; cvar;external libGLXEW;
  glXImportContextEXT: TPFNGLXIMPORTCONTEXTEXTPROC absolute __glewXImportContextEXT;

  __glewXQueryContextInfoEXT: TPFNGLXQUERYCONTEXTINFOEXTPROC; cvar;external libGLXEW;
  glXQueryContextInfoEXT: TPFNGLXQUERYCONTEXTINFOEXTPROC absolute __glewXQueryContextInfoEXT;

  __glewXSwapIntervalEXT: TPFNGLXSWAPINTERVALEXTPROC; cvar;external libGLXEW;
  glXSwapIntervalEXT: TPFNGLXSWAPINTERVALEXTPROC absolute __glewXSwapIntervalEXT;

  __glewXBindTexImageEXT: TPFNGLXBINDTEXIMAGEEXTPROC; cvar;external libGLXEW;
  glXBindTexImageEXT: TPFNGLXBINDTEXIMAGEEXTPROC absolute __glewXBindTexImageEXT;

  __glewXReleaseTexImageEXT: TPFNGLXRELEASETEXIMAGEEXTPROC; cvar;external libGLXEW;
  glXReleaseTexImageEXT: TPFNGLXRELEASETEXIMAGEEXTPROC absolute __glewXReleaseTexImageEXT;

  __glewXGetAGPOffsetMESA: TPFNGLXGETAGPOFFSETMESAPROC; cvar;external libGLXEW;
  glXGetAGPOffsetMESA: TPFNGLXGETAGPOFFSETMESAPROC absolute __glewXGetAGPOffsetMESA;

  __glewXCopySubBufferMESA: TPFNGLXCOPYSUBBUFFERMESAPROC; cvar;external libGLXEW;
  glXCopySubBufferMESA: TPFNGLXCOPYSUBBUFFERMESAPROC absolute __glewXCopySubBufferMESA;

  __glewXCreateGLXPixmapMESA: TPFNGLXCREATEGLXPIXMAPMESAPROC; cvar;external libGLXEW;
  glXCreateGLXPixmapMESA: TPFNGLXCREATEGLXPIXMAPMESAPROC absolute __glewXCreateGLXPixmapMESA;

  __glewXQueryCurrentRendererIntegerMESA: TPFNGLXQUERYCURRENTRENDERERINTEGERMESAPROC; cvar;external libGLXEW;
  glXQueryCurrentRendererIntegerMESA: TPFNGLXQUERYCURRENTRENDERERINTEGERMESAPROC absolute __glewXQueryCurrentRendererIntegerMESA;

  __glewXQueryCurrentRendererStringMESA: TPFNGLXQUERYCURRENTRENDERERSTRINGMESAPROC; cvar;external libGLXEW;
  glXQueryCurrentRendererStringMESA: TPFNGLXQUERYCURRENTRENDERERSTRINGMESAPROC absolute __glewXQueryCurrentRendererStringMESA;

  __glewXQueryRendererIntegerMESA: TPFNGLXQUERYRENDERERINTEGERMESAPROC; cvar;external libGLXEW;
  glXQueryRendererIntegerMESA: TPFNGLXQUERYRENDERERINTEGERMESAPROC absolute __glewXQueryRendererIntegerMESA;

  __glewXQueryRendererStringMESA: TPFNGLXQUERYRENDERERSTRINGMESAPROC; cvar;external libGLXEW;
  glXQueryRendererStringMESA: TPFNGLXQUERYRENDERERSTRINGMESAPROC absolute __glewXQueryRendererStringMESA;

  __glewXReleaseBuffersMESA: TPFNGLXRELEASEBUFFERSMESAPROC; cvar;external libGLXEW;
  glXReleaseBuffersMESA: TPFNGLXRELEASEBUFFERSMESAPROC absolute __glewXReleaseBuffersMESA;

  __glewXSet3DfxModeMESA: TPFNGLXSET3DFXMODEMESAPROC; cvar;external libGLXEW;
  glXSet3DfxModeMESA: TPFNGLXSET3DFXMODEMESAPROC absolute __glewXSet3DfxModeMESA;

  __glewXGetSwapIntervalMESA: TPFNGLXGETSWAPINTERVALMESAPROC; cvar;external libGLXEW;
  glXGetSwapIntervalMESA: TPFNGLXGETSWAPINTERVALMESAPROC absolute __glewXGetSwapIntervalMESA;

  __glewXSwapIntervalMESA: TPFNGLXSWAPINTERVALMESAPROC; cvar;external libGLXEW;
  glXSwapIntervalMESA: TPFNGLXSWAPINTERVALMESAPROC absolute __glewXSwapIntervalMESA;

  __glewXCopyBufferSubDataNV: TPFNGLXCOPYBUFFERSUBDATANVPROC; cvar;external libGLXEW;
  glXCopyBufferSubDataNV: TPFNGLXCOPYBUFFERSUBDATANVPROC absolute __glewXCopyBufferSubDataNV;

  __glewXNamedCopyBufferSubDataNV: TPFNGLXNAMEDCOPYBUFFERSUBDATANVPROC; cvar;external libGLXEW;
  glXNamedCopyBufferSubDataNV: TPFNGLXNAMEDCOPYBUFFERSUBDATANVPROC absolute __glewXNamedCopyBufferSubDataNV;

  __glewXCopyImageSubDataNV: TPFNGLXCOPYIMAGESUBDATANVPROC; cvar;external libGLXEW;
  glXCopyImageSubDataNV: TPFNGLXCOPYIMAGESUBDATANVPROC absolute __glewXCopyImageSubDataNV;

  __glewXDelayBeforeSwapNV: TPFNGLXDELAYBEFORESWAPNVPROC; cvar;external libGLXEW;
  glXDelayBeforeSwapNV: TPFNGLXDELAYBEFORESWAPNVPROC absolute __glewXDelayBeforeSwapNV;

  __glewXBindVideoDeviceNV: TPFNGLXBINDVIDEODEVICENVPROC; cvar;external libGLXEW;
  glXBindVideoDeviceNV: TPFNGLXBINDVIDEODEVICENVPROC absolute __glewXBindVideoDeviceNV;

  __glewXEnumerateVideoDevicesNV: TPFNGLXENUMERATEVIDEODEVICESNVPROC; cvar;external libGLXEW;
  glXEnumerateVideoDevicesNV: TPFNGLXENUMERATEVIDEODEVICESNVPROC absolute __glewXEnumerateVideoDevicesNV;

  __glewXBindSwapBarrierNV: TPFNGLXBINDSWAPBARRIERNVPROC; cvar;external libGLXEW;
  glXBindSwapBarrierNV: TPFNGLXBINDSWAPBARRIERNVPROC absolute __glewXBindSwapBarrierNV;

  __glewXJoinSwapGroupNV: TPFNGLXJOINSWAPGROUPNVPROC; cvar;external libGLXEW;
  glXJoinSwapGroupNV: TPFNGLXJOINSWAPGROUPNVPROC absolute __glewXJoinSwapGroupNV;

  __glewXQueryFrameCountNV: TPFNGLXQUERYFRAMECOUNTNVPROC; cvar;external libGLXEW;
  glXQueryFrameCountNV: TPFNGLXQUERYFRAMECOUNTNVPROC absolute __glewXQueryFrameCountNV;

  __glewXQueryMaxSwapGroupsNV: TPFNGLXQUERYMAXSWAPGROUPSNVPROC; cvar;external libGLXEW;
  glXQueryMaxSwapGroupsNV: TPFNGLXQUERYMAXSWAPGROUPSNVPROC absolute __glewXQueryMaxSwapGroupsNV;

  __glewXQuerySwapGroupNV: TPFNGLXQUERYSWAPGROUPNVPROC; cvar;external libGLXEW;
  glXQuerySwapGroupNV: TPFNGLXQUERYSWAPGROUPNVPROC absolute __glewXQuerySwapGroupNV;

  __glewXResetFrameCountNV: TPFNGLXRESETFRAMECOUNTNVPROC; cvar;external libGLXEW;
  glXResetFrameCountNV: TPFNGLXRESETFRAMECOUNTNVPROC absolute __glewXResetFrameCountNV;

  __glewXAllocateMemoryNV: TPFNGLXALLOCATEMEMORYNVPROC; cvar;external libGLXEW;
  glXAllocateMemoryNV: TPFNGLXALLOCATEMEMORYNVPROC absolute __glewXAllocateMemoryNV;

  __glewXFreeMemoryNV: TPFNGLXFREEMEMORYNVPROC; cvar;external libGLXEW;
  glXFreeMemoryNV: TPFNGLXFREEMEMORYNVPROC absolute __glewXFreeMemoryNV;

  __glewXBindVideoCaptureDeviceNV: TPFNGLXBINDVIDEOCAPTUREDEVICENVPROC; cvar;external libGLXEW;
  glXBindVideoCaptureDeviceNV: TPFNGLXBINDVIDEOCAPTUREDEVICENVPROC absolute __glewXBindVideoCaptureDeviceNV;

  __glewXEnumerateVideoCaptureDevicesNV: TPFNGLXENUMERATEVIDEOCAPTUREDEVICESNVPROC; cvar;external libGLXEW;
  glXEnumerateVideoCaptureDevicesNV: TPFNGLXENUMERATEVIDEOCAPTUREDEVICESNVPROC absolute __glewXEnumerateVideoCaptureDevicesNV;

  __glewXLockVideoCaptureDeviceNV: TPFNGLXLOCKVIDEOCAPTUREDEVICENVPROC; cvar;external libGLXEW;
  glXLockVideoCaptureDeviceNV: TPFNGLXLOCKVIDEOCAPTUREDEVICENVPROC absolute __glewXLockVideoCaptureDeviceNV;

  __glewXQueryVideoCaptureDeviceNV: TPFNGLXQUERYVIDEOCAPTUREDEVICENVPROC; cvar;external libGLXEW;
  glXQueryVideoCaptureDeviceNV: TPFNGLXQUERYVIDEOCAPTUREDEVICENVPROC absolute __glewXQueryVideoCaptureDeviceNV;

  __glewXReleaseVideoCaptureDeviceNV: TPFNGLXRELEASEVIDEOCAPTUREDEVICENVPROC; cvar;external libGLXEW;
  glXReleaseVideoCaptureDeviceNV: TPFNGLXRELEASEVIDEOCAPTUREDEVICENVPROC absolute __glewXReleaseVideoCaptureDeviceNV;

  __glewXBindVideoImageNV: TPFNGLXBINDVIDEOIMAGENVPROC; cvar;external libGLXEW;
  glXBindVideoImageNV: TPFNGLXBINDVIDEOIMAGENVPROC absolute __glewXBindVideoImageNV;

  __glewXGetVideoDeviceNV: TPFNGLXGETVIDEODEVICENVPROC; cvar;external libGLXEW;
  glXGetVideoDeviceNV: TPFNGLXGETVIDEODEVICENVPROC absolute __glewXGetVideoDeviceNV;

  __glewXGetVideoInfoNV: TPFNGLXGETVIDEOINFONVPROC; cvar;external libGLXEW;
  glXGetVideoInfoNV: TPFNGLXGETVIDEOINFONVPROC absolute __glewXGetVideoInfoNV;

  __glewXReleaseVideoDeviceNV: TPFNGLXRELEASEVIDEODEVICENVPROC; cvar;external libGLXEW;
  glXReleaseVideoDeviceNV: TPFNGLXRELEASEVIDEODEVICENVPROC absolute __glewXReleaseVideoDeviceNV;

  __glewXReleaseVideoImageNV: TPFNGLXRELEASEVIDEOIMAGENVPROC; cvar;external libGLXEW;
  glXReleaseVideoImageNV: TPFNGLXRELEASEVIDEOIMAGENVPROC absolute __glewXReleaseVideoImageNV;

  __glewXSendPbufferToVideoNV: TPFNGLXSENDPBUFFERTOVIDEONVPROC; cvar;external libGLXEW;
  glXSendPbufferToVideoNV: TPFNGLXSENDPBUFFERTOVIDEONVPROC absolute __glewXSendPbufferToVideoNV;

  __glewXGetMscRateOML: TPFNGLXGETMSCRATEOMLPROC; cvar;external libGLXEW;
  glXGetMscRateOML: TPFNGLXGETMSCRATEOMLPROC absolute __glewXGetMscRateOML;

  __glewXGetSyncValuesOML: TPFNGLXGETSYNCVALUESOMLPROC; cvar;external libGLXEW;
  glXGetSyncValuesOML: TPFNGLXGETSYNCVALUESOMLPROC absolute __glewXGetSyncValuesOML;

  __glewXSwapBuffersMscOML: TPFNGLXSWAPBUFFERSMSCOMLPROC; cvar;external libGLXEW;
  glXSwapBuffersMscOML: TPFNGLXSWAPBUFFERSMSCOMLPROC absolute __glewXSwapBuffersMscOML;

  __glewXWaitForMscOML: TPFNGLXWAITFORMSCOMLPROC; cvar;external libGLXEW;
  glXWaitForMscOML: TPFNGLXWAITFORMSCOMLPROC absolute __glewXWaitForMscOML;

  __glewXWaitForSbcOML: TPFNGLXWAITFORSBCOMLPROC; cvar;external libGLXEW;
  glXWaitForSbcOML: TPFNGLXWAITFORSBCOMLPROC absolute __glewXWaitForSbcOML;

  __glewXChooseFBConfigSGIX: TPFNGLXCHOOSEFBCONFIGSGIXPROC; cvar;external libGLXEW;
  glXChooseFBConfigSGIX: TPFNGLXCHOOSEFBCONFIGSGIXPROC absolute __glewXChooseFBConfigSGIX;

  __glewXCreateContextWithConfigSGIX: TPFNGLXCREATECONTEXTWITHCONFIGSGIXPROC; cvar;external libGLXEW;
  glXCreateContextWithConfigSGIX: TPFNGLXCREATECONTEXTWITHCONFIGSGIXPROC absolute __glewXCreateContextWithConfigSGIX;

  __glewXCreateGLXPixmapWithConfigSGIX: TPFNGLXCREATEGLXPIXMAPWITHCONFIGSGIXPROC; cvar;external libGLXEW;
  glXCreateGLXPixmapWithConfigSGIX: TPFNGLXCREATEGLXPIXMAPWITHCONFIGSGIXPROC absolute __glewXCreateGLXPixmapWithConfigSGIX;

  __glewXGetFBConfigAttribSGIX: TPFNGLXGETFBCONFIGATTRIBSGIXPROC; cvar;external libGLXEW;
  glXGetFBConfigAttribSGIX: TPFNGLXGETFBCONFIGATTRIBSGIXPROC absolute __glewXGetFBConfigAttribSGIX;

  __glewXGetFBConfigFromVisualSGIX: TPFNGLXGETFBCONFIGFROMVISUALSGIXPROC; cvar;external libGLXEW;
  glXGetFBConfigFromVisualSGIX: TPFNGLXGETFBCONFIGFROMVISUALSGIXPROC absolute __glewXGetFBConfigFromVisualSGIX;

  __glewXGetVisualFromFBConfigSGIX: TPFNGLXGETVISUALFROMFBCONFIGSGIXPROC; cvar;external libGLXEW;
  glXGetVisualFromFBConfigSGIX: TPFNGLXGETVISUALFROMFBCONFIGSGIXPROC absolute __glewXGetVisualFromFBConfigSGIX;

  __glewXBindHyperpipeSGIX: TPFNGLXBINDHYPERPIPESGIXPROC; cvar;external libGLXEW;
  glXBindHyperpipeSGIX: TPFNGLXBINDHYPERPIPESGIXPROC absolute __glewXBindHyperpipeSGIX;

  __glewXDestroyHyperpipeConfigSGIX: TPFNGLXDESTROYHYPERPIPECONFIGSGIXPROC; cvar;external libGLXEW;
  glXDestroyHyperpipeConfigSGIX: TPFNGLXDESTROYHYPERPIPECONFIGSGIXPROC absolute __glewXDestroyHyperpipeConfigSGIX;

  __glewXHyperpipeAttribSGIX: TPFNGLXHYPERPIPEATTRIBSGIXPROC; cvar;external libGLXEW;
  glXHyperpipeAttribSGIX: TPFNGLXHYPERPIPEATTRIBSGIXPROC absolute __glewXHyperpipeAttribSGIX;

  __glewXHyperpipeConfigSGIX: TPFNGLXHYPERPIPECONFIGSGIXPROC; cvar;external libGLXEW;
  glXHyperpipeConfigSGIX: TPFNGLXHYPERPIPECONFIGSGIXPROC absolute __glewXHyperpipeConfigSGIX;

  __glewXQueryHyperpipeAttribSGIX: TPFNGLXQUERYHYPERPIPEATTRIBSGIXPROC; cvar;external libGLXEW;
  glXQueryHyperpipeAttribSGIX: TPFNGLXQUERYHYPERPIPEATTRIBSGIXPROC absolute __glewXQueryHyperpipeAttribSGIX;

  __glewXQueryHyperpipeBestAttribSGIX: TPFNGLXQUERYHYPERPIPEBESTATTRIBSGIXPROC; cvar;external libGLXEW;
  glXQueryHyperpipeBestAttribSGIX: TPFNGLXQUERYHYPERPIPEBESTATTRIBSGIXPROC absolute __glewXQueryHyperpipeBestAttribSGIX;

  __glewXQueryHyperpipeConfigSGIX: TPFNGLXQUERYHYPERPIPECONFIGSGIXPROC; cvar;external libGLXEW;
  glXQueryHyperpipeConfigSGIX: TPFNGLXQUERYHYPERPIPECONFIGSGIXPROC absolute __glewXQueryHyperpipeConfigSGIX;

  __glewXQueryHyperpipeNetworkSGIX: TPFNGLXQUERYHYPERPIPENETWORKSGIXPROC; cvar;external libGLXEW;
  glXQueryHyperpipeNetworkSGIX: TPFNGLXQUERYHYPERPIPENETWORKSGIXPROC absolute __glewXQueryHyperpipeNetworkSGIX;

  __glewXCreateGLXPbufferSGIX: TPFNGLXCREATEGLXPBUFFERSGIXPROC; cvar;external libGLXEW;
  glXCreateGLXPbufferSGIX: TPFNGLXCREATEGLXPBUFFERSGIXPROC absolute __glewXCreateGLXPbufferSGIX;

  __glewXDestroyGLXPbufferSGIX: TPFNGLXDESTROYGLXPBUFFERSGIXPROC; cvar;external libGLXEW;
  glXDestroyGLXPbufferSGIX: TPFNGLXDESTROYGLXPBUFFERSGIXPROC absolute __glewXDestroyGLXPbufferSGIX;

  __glewXGetSelectedEventSGIX: TPFNGLXGETSELECTEDEVENTSGIXPROC; cvar;external libGLXEW;
  glXGetSelectedEventSGIX: TPFNGLXGETSELECTEDEVENTSGIXPROC absolute __glewXGetSelectedEventSGIX;

  __glewXQueryGLXPbufferSGIX: TPFNGLXQUERYGLXPBUFFERSGIXPROC; cvar;external libGLXEW;
  glXQueryGLXPbufferSGIX: TPFNGLXQUERYGLXPBUFFERSGIXPROC absolute __glewXQueryGLXPbufferSGIX;

  __glewXSelectEventSGIX: TPFNGLXSELECTEVENTSGIXPROC; cvar;external libGLXEW;
  glXSelectEventSGIX: TPFNGLXSELECTEVENTSGIXPROC absolute __glewXSelectEventSGIX;

  __glewXBindSwapBarrierSGIX: TPFNGLXBINDSWAPBARRIERSGIXPROC; cvar;external libGLXEW;
  glXBindSwapBarrierSGIX: TPFNGLXBINDSWAPBARRIERSGIXPROC absolute __glewXBindSwapBarrierSGIX;

  __glewXQueryMaxSwapBarriersSGIX: TPFNGLXQUERYMAXSWAPBARRIERSSGIXPROC; cvar;external libGLXEW;
  glXQueryMaxSwapBarriersSGIX: TPFNGLXQUERYMAXSWAPBARRIERSSGIXPROC absolute __glewXQueryMaxSwapBarriersSGIX;

  __glewXJoinSwapGroupSGIX: TPFNGLXJOINSWAPGROUPSGIXPROC; cvar;external libGLXEW;
  glXJoinSwapGroupSGIX: TPFNGLXJOINSWAPGROUPSGIXPROC absolute __glewXJoinSwapGroupSGIX;

  __glewXBindChannelToWindowSGIX: TPFNGLXBINDCHANNELTOWINDOWSGIXPROC; cvar;external libGLXEW;
  glXBindChannelToWindowSGIX: TPFNGLXBINDCHANNELTOWINDOWSGIXPROC absolute __glewXBindChannelToWindowSGIX;

  __glewXChannelRectSGIX: TPFNGLXCHANNELRECTSGIXPROC; cvar;external libGLXEW;
  glXChannelRectSGIX: TPFNGLXCHANNELRECTSGIXPROC absolute __glewXChannelRectSGIX;

  __glewXChannelRectSyncSGIX: TPFNGLXCHANNELRECTSYNCSGIXPROC; cvar;external libGLXEW;
  glXChannelRectSyncSGIX: TPFNGLXCHANNELRECTSYNCSGIXPROC absolute __glewXChannelRectSyncSGIX;

  __glewXQueryChannelDeltasSGIX: TPFNGLXQUERYCHANNELDELTASSGIXPROC; cvar;external libGLXEW;
  glXQueryChannelDeltasSGIX: TPFNGLXQUERYCHANNELDELTASSGIXPROC absolute __glewXQueryChannelDeltasSGIX;

  __glewXQueryChannelRectSGIX: TPFNGLXQUERYCHANNELRECTSGIXPROC; cvar;external libGLXEW;
  glXQueryChannelRectSGIX: TPFNGLXQUERYCHANNELRECTSGIXPROC absolute __glewXQueryChannelRectSGIX;

  __glewXCushionSGI: TPFNGLXCUSHIONSGIPROC; cvar;external libGLXEW;
  glXCushionSGI: TPFNGLXCUSHIONSGIPROC absolute __glewXCushionSGI;

  __glewXGetCurrentReadDrawableSGI: TPFNGLXGETCURRENTREADDRAWABLESGIPROC; cvar;external libGLXEW;
  glXGetCurrentReadDrawableSGI: TPFNGLXGETCURRENTREADDRAWABLESGIPROC absolute __glewXGetCurrentReadDrawableSGI;

  __glewXMakeCurrentReadSGI: TPFNGLXMAKECURRENTREADSGIPROC; cvar;external libGLXEW;
  glXMakeCurrentReadSGI: TPFNGLXMAKECURRENTREADSGIPROC absolute __glewXMakeCurrentReadSGI;

  __glewXSwapIntervalSGI: TPFNGLXSWAPINTERVALSGIPROC; cvar;external libGLXEW;
  glXSwapIntervalSGI: TPFNGLXSWAPINTERVALSGIPROC absolute __glewXSwapIntervalSGI;

  __glewXGetVideoSyncSGI: TPFNGLXGETVIDEOSYNCSGIPROC; cvar;external libGLXEW;
  glXGetVideoSyncSGI: TPFNGLXGETVIDEOSYNCSGIPROC absolute __glewXGetVideoSyncSGI;

  __glewXWaitVideoSyncSGI: TPFNGLXWAITVIDEOSYNCSGIPROC; cvar;external libGLXEW;
  glXWaitVideoSyncSGI: TPFNGLXWAITVIDEOSYNCSGIPROC absolute __glewXWaitVideoSyncSGI;

  __glewXGetTransparentIndexSUN: TPFNGLXGETTRANSPARENTINDEXSUNPROC; cvar;external libGLXEW;
  glXGetTransparentIndexSUN: TPFNGLXGETTRANSPARENTINDEXSUNPROC absolute __glewXGetTransparentIndexSUN;

  __glewXGetVideoResizeSUN: TPFNGLXGETVIDEORESIZESUNPROC; cvar;external libGLXEW;
  glXGetVideoResizeSUN: TPFNGLXGETVIDEORESIZESUNPROC absolute __glewXGetVideoResizeSUN;

  __glewXVideoResizeSUN: TPFNGLXVIDEORESIZESUNPROC; cvar;external libGLXEW;
  glXVideoResizeSUN: TPFNGLXVIDEORESIZESUNPROC absolute __glewXVideoResizeSUN;

  __GLXEW_VERSION_1_0: TGLboolean; cvar;external libGLXEW;
  __GLXEW_VERSION_1_1: TGLboolean; cvar;external libGLXEW;
  __GLXEW_VERSION_1_2: TGLboolean; cvar;external libGLXEW;
  __GLXEW_VERSION_1_3: TGLboolean; cvar;external libGLXEW;
  __GLXEW_VERSION_1_4: TGLboolean; cvar;external libGLXEW;
  __GLXEW_3DFX_multisample: TGLboolean; cvar;external libGLXEW;
  __GLXEW_AMD_gpu_association: TGLboolean; cvar;external libGLXEW;
  __GLXEW_ARB_context_flush_control: TGLboolean; cvar;external libGLXEW;
  __GLXEW_ARB_create_context: TGLboolean; cvar;external libGLXEW;
  __GLXEW_ARB_create_context_no_error: TGLboolean; cvar;external libGLXEW;
  __GLXEW_ARB_create_context_profile: TGLboolean; cvar;external libGLXEW;
  __GLXEW_ARB_create_context_robustness: TGLboolean; cvar;external libGLXEW;
  __GLXEW_ARB_fbconfig_float: TGLboolean; cvar;external libGLXEW;
  __GLXEW_ARB_framebuffer_sRGB: TGLboolean; cvar;external libGLXEW;
  __GLXEW_ARB_get_proc_address: TGLboolean; cvar;external libGLXEW;
  __GLXEW_ARB_multisample: TGLboolean; cvar;external libGLXEW;
  __GLXEW_ARB_robustness_application_isolation: TGLboolean; cvar;external libGLXEW;
  __GLXEW_ARB_robustness_share_group_isolation: TGLboolean; cvar;external libGLXEW;
  __GLXEW_ARB_vertex_buffer_object: TGLboolean; cvar;external libGLXEW;
  __GLXEW_ATI_pixel_format_float: TGLboolean; cvar;external libGLXEW;
  __GLXEW_ATI_render_texture: TGLboolean; cvar;external libGLXEW;
  __GLXEW_EXT_buffer_age: TGLboolean; cvar;external libGLXEW;
  __GLXEW_EXT_context_priority: TGLboolean; cvar;external libGLXEW;
  __GLXEW_EXT_create_context_es2_profile: TGLboolean; cvar;external libGLXEW;
  __GLXEW_EXT_create_context_es_profile: TGLboolean; cvar;external libGLXEW;
  __GLXEW_EXT_fbconfig_packed_float: TGLboolean; cvar;external libGLXEW;
  __GLXEW_EXT_framebuffer_sRGB: TGLboolean; cvar;external libGLXEW;
  __GLXEW_EXT_import_context: TGLboolean; cvar;external libGLXEW;
  __GLXEW_EXT_libglvnd: TGLboolean; cvar;external libGLXEW;
  __GLXEW_EXT_no_config_context: TGLboolean; cvar;external libGLXEW;
  __GLXEW_EXT_scene_marker: TGLboolean; cvar;external libGLXEW;
  __GLXEW_EXT_stereo_tree: TGLboolean; cvar;external libGLXEW;
  __GLXEW_EXT_swap_control: TGLboolean; cvar;external libGLXEW;
  __GLXEW_EXT_swap_control_tear: TGLboolean; cvar;external libGLXEW;
  __GLXEW_EXT_texture_from_pixmap: TGLboolean; cvar;external libGLXEW;
  __GLXEW_EXT_visual_info: TGLboolean; cvar;external libGLXEW;
  __GLXEW_EXT_visual_rating: TGLboolean; cvar;external libGLXEW;
  __GLXEW_INTEL_swap_event: TGLboolean; cvar;external libGLXEW;
  __GLXEW_MESA_agp_offset: TGLboolean; cvar;external libGLXEW;
  __GLXEW_MESA_copy_sub_buffer: TGLboolean; cvar;external libGLXEW;
  __GLXEW_MESA_pixmap_colormap: TGLboolean; cvar;external libGLXEW;
  __GLXEW_MESA_query_renderer: TGLboolean; cvar;external libGLXEW;
  __GLXEW_MESA_release_buffers: TGLboolean; cvar;external libGLXEW;
  __GLXEW_MESA_set_3dfx_mode: TGLboolean; cvar;external libGLXEW;
  __GLXEW_MESA_swap_control: TGLboolean; cvar;external libGLXEW;
  __GLXEW_NV_copy_buffer: TGLboolean; cvar;external libGLXEW;
  __GLXEW_NV_copy_image: TGLboolean; cvar;external libGLXEW;
  __GLXEW_NV_delay_before_swap: TGLboolean; cvar;external libGLXEW;
  __GLXEW_NV_float_buffer: TGLboolean; cvar;external libGLXEW;
  __GLXEW_NV_multigpu_context: TGLboolean; cvar;external libGLXEW;
  __GLXEW_NV_multisample_coverage: TGLboolean; cvar;external libGLXEW;
  __GLXEW_NV_present_video: TGLboolean; cvar;external libGLXEW;
  __GLXEW_NV_robustness_video_memory_purge: TGLboolean; cvar;external libGLXEW;
  __GLXEW_NV_swap_group: TGLboolean; cvar;external libGLXEW;
  __GLXEW_NV_vertex_array_range: TGLboolean; cvar;external libGLXEW;
  __GLXEW_NV_video_capture: TGLboolean; cvar;external libGLXEW;
  __GLXEW_NV_video_out: TGLboolean; cvar;external libGLXEW;
  __GLXEW_OML_swap_method: TGLboolean; cvar;external libGLXEW;
  __GLXEW_OML_sync_control: TGLboolean; cvar;external libGLXEW;
  __GLXEW_SGIS_blended_overlay: TGLboolean; cvar;external libGLXEW;
  __GLXEW_SGIS_color_range: TGLboolean; cvar;external libGLXEW;
  __GLXEW_SGIS_multisample: TGLboolean; cvar;external libGLXEW;
  __GLXEW_SGIS_shared_multisample: TGLboolean; cvar;external libGLXEW;
  __GLXEW_SGIX_fbconfig: TGLboolean; cvar;external libGLXEW;
  __GLXEW_SGIX_hyperpipe: TGLboolean; cvar;external libGLXEW;
  __GLXEW_SGIX_pbuffer: TGLboolean; cvar;external libGLXEW;
  __GLXEW_SGIX_swap_barrier: TGLboolean; cvar;external libGLXEW;
  __GLXEW_SGIX_swap_group: TGLboolean; cvar;external libGLXEW;
  __GLXEW_SGIX_video_resize: TGLboolean; cvar;external libGLXEW;
  __GLXEW_SGIX_visual_select_group: TGLboolean; cvar;external libGLXEW;
  __GLXEW_SGI_cushion: TGLboolean; cvar;external libGLXEW;
  __GLXEW_SGI_make_current_read: TGLboolean; cvar;external libGLXEW;
  __GLXEW_SGI_swap_control: TGLboolean; cvar;external libGLXEW;
  __GLXEW_SGI_video_sync: TGLboolean; cvar;external libGLXEW;
  __GLXEW_SUN_get_transparent_index: TGLboolean; cvar;external libGLXEW;
  __GLXEW_SUN_video_resize: TGLboolean; cvar;external libGLXEW;
  { ------------------------------------------------------------------------  }

function glxewInit: TGLenum; cdecl; external libGLXEW;
function glxewIsSupported(name: pchar): TGLboolean; cdecl; external libGLXEW;
function glxewGetExtension(name: pchar): TGLboolean; cdecl; external libGLXEW;

// === Konventiert am: 21-9-25 15:48:53 ===


implementation


end.
