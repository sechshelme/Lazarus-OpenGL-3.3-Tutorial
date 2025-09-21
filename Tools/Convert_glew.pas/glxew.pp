
unit glxew;
interface

{
  Automatically converted by H2Pas 1.0.0 from glxew.h
  The following command line parameters were used:
    -p
    -T
    -d
    -c
    -e
    glxew.h
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
P_glXContextRec  = ^_glXContextRec;
P_GLXEvent  = ^_GLXEvent;
P_GLXFBConfigRec  = ^_GLXFBConfigRec;
Pchar  = ^char;
PDisplay  = ^Display;
Pdword  = ^dword;
PGLubyte  = ^GLubyte;
PGLuint  = ^GLuint;
PGLXBufferClobberEventSGIX  = ^GLXBufferClobberEventSGIX;
PGLXContext  = ^GLXContext;
PGLXContextID  = ^GLXContextID;
PGLXDrawable  = ^GLXDrawable;
PGLXEvent  = ^GLXEvent;
PGLXFBConfig  = ^GLXFBConfig;
PGLXFBConfigID  = ^GLXFBConfigID;
PGLXFBConfigIDSGIX  = ^GLXFBConfigIDSGIX;
PGLXFBConfigSGIX  = ^GLXFBConfigSGIX;
PGLXHyperpipeConfigSGIX  = ^GLXHyperpipeConfigSGIX;
PGLXHyperpipeNetworkSGIX  = ^GLXHyperpipeNetworkSGIX;
PGLXPbuffer  = ^GLXPbuffer;
PGLXPbufferClobberEvent  = ^GLXPbufferClobberEvent;
PGLXPbufferSGIX  = ^GLXPbufferSGIX;
PGLXPipeRect  = ^GLXPipeRect;
PGLXPipeRectLimits  = ^GLXPipeRectLimits;
PGLXPixmap  = ^GLXPixmap;
PGLXVideoCaptureDeviceNV  = ^GLXVideoCaptureDeviceNV;
PGLXVideoDeviceNV  = ^GLXVideoDeviceNV;
PGLXWindow  = ^GLXWindow;
Pint32_t  = ^int32_t;
Pint64_t  = ^int64_t;
Plongint  = ^longint;
PPFNGLXALLOCATEMEMORYNVPROC  = ^PFNGLXALLOCATEMEMORYNVPROC;
PPFNGLXCHOOSEFBCONFIGPROC  = ^PFNGLXCHOOSEFBCONFIGPROC;
PPFNGLXCHOOSEFBCONFIGSGIXPROC  = ^PFNGLXCHOOSEFBCONFIGSGIXPROC;
PPFNGLXENUMERATEVIDEOCAPTUREDEVICESNVPROC  = ^PFNGLXENUMERATEVIDEOCAPTUREDEVICESNVPROC;
PPFNGLXENUMERATEVIDEODEVICESNVPROC  = ^PFNGLXENUMERATEVIDEODEVICESNVPROC;
PPFNGLXGETCURRENTDISPLAYEXTPROC  = ^PFNGLXGETCURRENTDISPLAYEXTPROC;
PPFNGLXGETCURRENTDISPLAYPROC  = ^PFNGLXGETCURRENTDISPLAYPROC;
PPFNGLXGETFBCONFIGSPROC  = ^PFNGLXGETFBCONFIGSPROC;
PPFNGLXGETVISUALFROMFBCONFIGPROC  = ^PFNGLXGETVISUALFROMFBCONFIGPROC;
PPFNGLXGETVISUALFROMFBCONFIGSGIXPROC  = ^PFNGLXGETVISUALFROMFBCONFIGSGIXPROC;
PPFNGLXQUERYCURRENTRENDERERSTRINGMESAPROC  = ^PFNGLXQUERYCURRENTRENDERERSTRINGMESAPROC;
PPFNGLXQUERYHYPERPIPECONFIGSGIXPROC  = ^PFNGLXQUERYHYPERPIPECONFIGSGIXPROC;
PPFNGLXQUERYHYPERPIPENETWORKSGIXPROC  = ^PFNGLXQUERYHYPERPIPENETWORKSGIXPROC;
PPFNGLXQUERYRENDERERSTRINGMESAPROC  = ^PFNGLXQUERYRENDERERSTRINGMESAPROC;
Psingle  = ^single;
PXVisualInfo  = ^XVisualInfo;
{$IFDEF FPC}
{$PACKRECORDS C}
{$ENDIF}


{
** The OpenGL Extension Wrangler Library
** Copyright (C) 2008-2019, Nigel Stewart <nigels[]users sourceforge net>
** Copyright (C) 2002-2008, Milan Ikits <milan ikits[]ieee org>
** Copyright (C) 2002-2008, Marcelo E. Magallon <mmagallo[]debian org>
** Copyright (C) 2002, Lev Povalahev
** All rights reserved.
** 
** Redistribution and use in source and binary forms, with or without 
** modification, are permitted provided that the following conditions are met:
** 
** * Redistributions of source code must retain the above copyright notice, 
**   this list of conditions and the following disclaimer.
** * Redistributions in binary form must reproduce the above copyright notice, 
**   this list of conditions and the following disclaimer in the documentation 
**   and/or other materials provided with the distribution.
** * The name of the author may be used to endorse or promote products 
**   derived from this software without specific prior written permission.
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" 
** AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE 
** IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
** ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE 
** LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR 
** CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF 
** SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
** INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
** CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
** ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
** THE POSSIBILITY OF SUCH DAMAGE.
 }
{
 * Mesa 3-D graphics library
 * Version:  7.0
 *
 * Copyright (C) 1999-2007  Brian Paul   All Rights Reserved.
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
 * BRIAN PAUL BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
 * AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
  }
{
** Copyright (c) 2007 The Khronos Group Inc.
** 
** Permission is hereby granted, free of charge, to any person obtaining a
** copy of this software and/or associated documentation files (the
** "Materials"), to deal in the Materials without restriction, including
** without limitation the rights to use, copy, modify, merge, publish,
** distribute, sublicense, and/or sell copies of the Materials, and to
** permit persons to whom the Materials are furnished to do so, subject to
** the following conditions:
** 
** The above copyright notice and this permission notice shall be included
** in all copies or substantial portions of the Materials.
** 
** THE MATERIALS ARE PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
** EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
** MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
** IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
** CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
** TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
** MATERIALS OR THE USE OR OTHER DEALINGS IN THE MATERIALS.
 }
{$ifndef __glxew_h__}
{$define __glxew_h__}
{$define __GLXEW_H__}
{$ifdef __glxext_h_}
{$error glxext.h included before glxew.h}
{$endif}
{$if defined(GLX_H) || defined(__GLX_glx_h__) || defined(__glx_h__)}
{$error glx.h included before glxew.h}
{$endif}
{$define __glxext_h_}
{$define GLX_H}
{$define __GLX_glx_h__}
{$define __glx_h__}
{$include <X11/Xlib.h>}
{$include <X11/Xutil.h>}
{$include <X11/Xmd.h>}
{$ifndef GLEW_INCLUDE}
{$include <GL/glew.h>}
{$else}
{$include GLEW_INCLUDE}
{$endif}
{ C++ extern C conditionnal removed }
{ ---------------------------- GLX_VERSION_1_0 ---------------------------  }
{$ifndef GLX_VERSION_1_0}

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
{$ifdef __sun}

  PGLXContext = ^TGLXContext;
  TGLXContext = P_glXContextRec;
{$else}
type
  PGLXContext = ^TGLXContext;
  TGLXContext = P_GLXcontextRec;
{$endif}
type
  PGLXVideoDeviceNV = ^TGLXVideoDeviceNV;
  TGLXVideoDeviceNV = dword;

function glXQueryExtension(dpy:PDisplay; errorBase:Plongint; eventBase:Plongint):TBool;cdecl;external;
function glXQueryVersion(dpy:PDisplay; major:Plongint; minor:Plongint):TBool;cdecl;external;
function glXGetConfig(dpy:PDisplay; vis:PXVisualInfo; attrib:longint; value:Plongint):longint;cdecl;external;
function glXChooseVisual(dpy:PDisplay; screen:longint; attribList:Plongint):PXVisualInfo;cdecl;external;
function glXCreateGLXPixmap(dpy:PDisplay; vis:PXVisualInfo; pixmap:TPixmap):TGLXPixmap;cdecl;external;
procedure glXDestroyGLXPixmap(dpy:PDisplay; pix:TGLXPixmap);cdecl;external;
function glXCreateContext(dpy:PDisplay; vis:PXVisualInfo; shareList:TGLXContext; direct:TBool):TGLXContext;cdecl;external;
procedure glXDestroyContext(dpy:PDisplay; ctx:TGLXContext);cdecl;external;
function glXIsDirect(dpy:PDisplay; ctx:TGLXContext):TBool;cdecl;external;
procedure glXCopyContext(dpy:PDisplay; src:TGLXContext; dst:TGLXContext; mask:TGLulong);cdecl;external;
function glXMakeCurrent(dpy:PDisplay; drawable:TGLXDrawable; ctx:TGLXContext):TBool;cdecl;external;
function glXGetCurrentContext:TGLXContext;cdecl;external;
function glXGetCurrentDrawable:TGLXDrawable;cdecl;external;
procedure glXWaitGL;cdecl;external;
procedure glXWaitX;cdecl;external;
procedure glXSwapBuffers(dpy:PDisplay; drawable:TGLXDrawable);cdecl;external;
procedure glXUseXFont(font:TFont; first:longint; count:longint; listBase:longint);cdecl;external;
{ was #define dname def_expr }
function GLXEW_VERSION_1_0 : longint; { return type might be wrong }

{$endif}
{ GLX_VERSION_1_0  }
{ ---------------------------- GLX_VERSION_1_1 ---------------------------  }
{$ifndef GLX_VERSION_1_1}
{$define GLX_VERSION_1_1}

const
  GLX_VENDOR = $1;  
  GLX_VERSION = $2;  
  GLX_EXTENSIONS = $3;  
(* Const before type ignored *)

function glXQueryExtensionsString(dpy:PDisplay; screen:longint):Pchar;cdecl;external;
(* Const before type ignored *)
function glXGetClientString(dpy:PDisplay; name:longint):Pchar;cdecl;external;
(* Const before type ignored *)
function glXQueryServerString(dpy:PDisplay; screen:longint; name:longint):Pchar;cdecl;external;
{ was #define dname def_expr }
function GLXEW_VERSION_1_1 : longint; { return type might be wrong }

{$endif}
{ GLX_VERSION_1_1  }
{ ---------------------------- GLX_VERSION_1_2 ----------------------------  }
{$ifndef GLX_VERSION_1_2}

const
  GLX_VERSION_1_2 = 1;  
type
  PPFNGLXGETCURRENTDISPLAYPROC = ^TPFNGLXGETCURRENTDISPLAYPROC;
  TPFNGLXGETCURRENTDISPLAYPROC = function :PDisplay;cdecl;

{ was #define dname def_expr }
function glXGetCurrentDisplay : longint; { return type might be wrong }

{ was #define dname def_expr }
function GLXEW_VERSION_1_2 : longint; { return type might be wrong }

{$endif}
{ GLX_VERSION_1_2  }
{ ---------------------------- GLX_VERSION_1_3 ----------------------------  }
{$ifndef GLX_VERSION_1_3}

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
  TGLXFBConfig = P_GLXFBConfigRec;

  PGLXPbufferClobberEvent = ^TGLXPbufferClobberEvent;
  TGLXPbufferClobberEvent = record
      event_type : longint;
      draw_type : longint;
      serial : dword;
      send_event : TBool;
      display : PDisplay;
      drawable : TGLXDrawable;
      buffer_mask : dword;
      aux_buffer : dword;
      x : longint;
      y : longint;
      width : longint;
      height : longint;
      count : longint;
    end;

  P_GLXEvent = ^T_GLXEvent;
  T_GLXEvent = record
      case longint of
        0 : ( glxpbufferclobber : TGLXPbufferClobberEvent );
        1 : ( pad : array[0..23] of longint );
      end;
  TGLXEvent = T_GLXEvent;
  PGLXEvent = ^TGLXEvent;
(* Const before type ignored *)

  PPFNGLXCHOOSEFBCONFIGPROC = ^TPFNGLXCHOOSEFBCONFIGPROC;
  TPFNGLXCHOOSEFBCONFIGPROC = function (dpy:PDisplay; screen:longint; attrib_list:Plongint; nelements:Plongint):PGLXFBConfig;cdecl;

  TPFNGLXCREATENEWCONTEXTPROC = function (dpy:PDisplay; config:TGLXFBConfig; render_type:longint; share_list:TGLXContext; direct:TBool):TGLXContext;cdecl;
(* Const before type ignored *)

  TPFNGLXCREATEPBUFFERPROC = function (dpy:PDisplay; config:TGLXFBConfig; attrib_list:Plongint):TGLXPbuffer;cdecl;
(* Const before type ignored *)

  TPFNGLXCREATEPIXMAPPROC = function (dpy:PDisplay; config:TGLXFBConfig; pixmap:TPixmap; attrib_list:Plongint):TGLXPixmap;cdecl;
(* Const before type ignored *)

  TPFNGLXCREATEWINDOWPROC = function (dpy:PDisplay; config:TGLXFBConfig; win:TWindow; attrib_list:Plongint):TGLXWindow;cdecl;

  TPFNGLXDESTROYPBUFFERPROC = procedure (dpy:PDisplay; pbuf:TGLXPbuffer);cdecl;

  TPFNGLXDESTROYPIXMAPPROC = procedure (dpy:PDisplay; pixmap:TGLXPixmap);cdecl;

  TPFNGLXDESTROYWINDOWPROC = procedure (dpy:PDisplay; win:TGLXWindow);cdecl;

  TPFNGLXGETCURRENTREADDRAWABLEPROC = function (para1:pointer):TGLXDrawable;cdecl;

  TPFNGLXGETFBCONFIGATTRIBPROC = function (dpy:PDisplay; config:TGLXFBConfig; attribute:longint; value:Plongint):longint;cdecl;

  PPFNGLXGETFBCONFIGSPROC = ^TPFNGLXGETFBCONFIGSPROC;
  TPFNGLXGETFBCONFIGSPROC = function (dpy:PDisplay; screen:longint; nelements:Plongint):PGLXFBConfig;cdecl;

  TPFNGLXGETSELECTEDEVENTPROC = procedure (dpy:PDisplay; draw:TGLXDrawable; event_mask:Pdword);cdecl;

  PPFNGLXGETVISUALFROMFBCONFIGPROC = ^TPFNGLXGETVISUALFROMFBCONFIGPROC;
  TPFNGLXGETVISUALFROMFBCONFIGPROC = function (dpy:PDisplay; config:TGLXFBConfig):PXVisualInfo;cdecl;

  TPFNGLXMAKECONTEXTCURRENTPROC = function (display:PDisplay; draw:TGLXDrawable; read:TGLXDrawable; ctx:TGLXContext):TBool;cdecl;

  TPFNGLXQUERYCONTEXTPROC = function (dpy:PDisplay; ctx:TGLXContext; attribute:longint; value:Plongint):longint;cdecl;

  TPFNGLXQUERYDRAWABLEPROC = procedure (dpy:PDisplay; draw:TGLXDrawable; attribute:longint; value:Pdword);cdecl;

  TPFNGLXSELECTEVENTPROC = procedure (dpy:PDisplay; draw:TGLXDrawable; event_mask:dword);cdecl;

{ was #define dname def_expr }
function glXChooseFBConfig : longint; { return type might be wrong }

{ was #define dname def_expr }
function glXCreateNewContext : longint; { return type might be wrong }

{ was #define dname def_expr }
function glXCreatePbuffer : longint; { return type might be wrong }

{ was #define dname def_expr }
function glXCreatePixmap : longint; { return type might be wrong }

{ was #define dname def_expr }
function glXCreateWindow : longint; { return type might be wrong }

{ was #define dname def_expr }
function glXDestroyPbuffer : longint; { return type might be wrong }

{ was #define dname def_expr }
function glXDestroyPixmap : longint; { return type might be wrong }

{ was #define dname def_expr }
function glXDestroyWindow : longint; { return type might be wrong }

{ was #define dname def_expr }
function glXGetCurrentReadDrawable : longint; { return type might be wrong }

{ was #define dname def_expr }
function glXGetFBConfigAttrib : longint; { return type might be wrong }

{ was #define dname def_expr }
function glXGetFBConfigs : longint; { return type might be wrong }

{ was #define dname def_expr }
function glXGetSelectedEvent : longint; { return type might be wrong }

{ was #define dname def_expr }
function glXGetVisualFromFBConfig : longint; { return type might be wrong }

{ was #define dname def_expr }
function glXMakeContextCurrent : longint; { return type might be wrong }

{ was #define dname def_expr }
function glXQueryContext : longint; { return type might be wrong }

{ was #define dname def_expr }
function glXQueryDrawable : longint; { return type might be wrong }

{ was #define dname def_expr }
function glXSelectEvent : longint; { return type might be wrong }

{ was #define dname def_expr }
function GLXEW_VERSION_1_3 : longint; { return type might be wrong }

{$endif}
{ GLX_VERSION_1_3  }
{ ---------------------------- GLX_VERSION_1_4 ----------------------------  }
{$ifndef GLX_VERSION_1_4}

const
  GLX_VERSION_1_4 = 1;  
  GLX_SAMPLE_BUFFERS = 100000;  
  GLX_SAMPLES = 100001;  
(* Const before type ignored *)

function glXGetProcAddress(procName:PGLubyte):procedure ;cdecl;external;
{ was #define dname def_expr }
function GLXEW_VERSION_1_4 : longint; { return type might be wrong }

{$endif}
{ GLX_VERSION_1_4  }
{ -------------------------- GLX_3DFX_multisample -------------------------  }
{$ifndef GLX_3DFX_multisample}

const
  GLX_3DFX_multisample = 1;  
  GLX_SAMPLE_BUFFERS_3DFX = $8050;  
  GLX_SAMPLES_3DFX = $8051;  

{ was #define dname def_expr }
function GLXEW_3DFX_multisample : longint; { return type might be wrong }

{$endif}
{ GLX_3DFX_multisample  }
{ ------------------------ GLX_AMD_gpu_association ------------------------  }
{$ifndef GLX_AMD_gpu_association}

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

  TPFNGLXBLITCONTEXTFRAMEBUFFERAMDPROC = procedure (dstCtx:TGLXContext; srcX0:TGLint; srcY0:TGLint; srcX1:TGLint; srcY1:TGLint; 
                dstX0:TGLint; dstY0:TGLint; dstX1:TGLint; dstY1:TGLint; mask:TGLbitfield; 
                filter:TGLenum);cdecl;

  TPFNGLXCREATEASSOCIATEDCONTEXTAMDPROC = function (id:dword; share_list:TGLXContext):TGLXContext;cdecl;
(* Const before type ignored *)

  TPFNGLXCREATEASSOCIATEDCONTEXTATTRIBSAMDPROC = function (id:dword; share_context:TGLXContext; attribList:Plongint):TGLXContext;cdecl;

  TPFNGLXDELETEASSOCIATEDCONTEXTAMDPROC = function (ctx:TGLXContext):TBool;cdecl;

  TPFNGLXGETCONTEXTGPUIDAMDPROC = function (ctx:TGLXContext):dword;cdecl;

  TPFNGLXGETCURRENTASSOCIATEDCONTEXTAMDPROC = function (para1:pointer):TGLXContext;cdecl;

  TPFNGLXGETGPUIDSAMDPROC = function (maxCount:dword; ids:Pdword):dword;cdecl;

  TPFNGLXGETGPUINFOAMDPROC = function (id:dword; _property:longint; dataType:TGLenum; size:dword; data:pointer):longint;cdecl;

  TPFNGLXMAKEASSOCIATEDCONTEXTCURRENTAMDPROC = function (ctx:TGLXContext):TBool;cdecl;

{ was #define dname def_expr }
function glXBlitContextFramebufferAMD : longint; { return type might be wrong }

{ was #define dname def_expr }
function glXCreateAssociatedContextAMD : longint; { return type might be wrong }

{ was #define dname def_expr }
function glXCreateAssociatedContextAttribsAMD : longint; { return type might be wrong }

{ was #define dname def_expr }
function glXDeleteAssociatedContextAMD : longint; { return type might be wrong }

{ was #define dname def_expr }
function glXGetContextGPUIDAMD : longint; { return type might be wrong }

{ was #define dname def_expr }
function glXGetCurrentAssociatedContextAMD : longint; { return type might be wrong }

{ was #define dname def_expr }
function glXGetGPUIDsAMD : longint; { return type might be wrong }

{ was #define dname def_expr }
function glXGetGPUInfoAMD : longint; { return type might be wrong }

{ was #define dname def_expr }
function glXMakeAssociatedContextCurrentAMD : longint; { return type might be wrong }

{ was #define dname def_expr }
function GLXEW_AMD_gpu_association : longint; { return type might be wrong }

{$endif}
{ GLX_AMD_gpu_association  }
{ --------------------- GLX_ARB_context_flush_control ---------------------  }
{$ifndef GLX_ARB_context_flush_control}

const
  GLX_ARB_context_flush_control = 1;  
  GLX_CONTEXT_RELEASE_BEHAVIOR_NONE_ARB = 0;  
  GLX_CONTEXT_RELEASE_BEHAVIOR_ARB = $2097;  
  GLX_CONTEXT_RELEASE_BEHAVIOR_FLUSH_ARB = $2098;  

{ was #define dname def_expr }
function GLXEW_ARB_context_flush_control : longint; { return type might be wrong }

{$endif}
{ GLX_ARB_context_flush_control  }
{ ------------------------- GLX_ARB_create_context ------------------------  }
{$ifndef GLX_ARB_create_context}

const
  GLX_ARB_create_context = 1;  
  GLX_CONTEXT_DEBUG_BIT_ARB = $00000001;  
  GLX_CONTEXT_FORWARD_COMPATIBLE_BIT_ARB = $00000002;  
  GLX_CONTEXT_MAJOR_VERSION_ARB = $2091;  
  GLX_CONTEXT_MINOR_VERSION_ARB = $2092;  
  GLX_CONTEXT_FLAGS_ARB = $2094;  
(* Const before type ignored *)
type

  TPFNGLXCREATECONTEXTATTRIBSARBPROC = function (dpy:PDisplay; config:TGLXFBConfig; share_context:TGLXContext; direct:TBool; attrib_list:Plongint):TGLXContext;cdecl;

{ was #define dname def_expr }
function glXCreateContextAttribsARB : longint; { return type might be wrong }

{ was #define dname def_expr }
function GLXEW_ARB_create_context : longint; { return type might be wrong }

{$endif}
{ GLX_ARB_create_context  }
{ -------------------- GLX_ARB_create_context_no_error --------------------  }
{$ifndef GLX_ARB_create_context_no_error}

const
  GLX_ARB_create_context_no_error = 1;  
  GLX_CONTEXT_OPENGL_NO_ERROR_ARB = $31B3;  

{ was #define dname def_expr }
function GLXEW_ARB_create_context_no_error : longint; { return type might be wrong }

{$endif}
{ GLX_ARB_create_context_no_error  }
{ --------------------- GLX_ARB_create_context_profile --------------------  }
{$ifndef GLX_ARB_create_context_profile}

const
  GLX_ARB_create_context_profile = 1;  
  GLX_CONTEXT_CORE_PROFILE_BIT_ARB = $00000001;  
  GLX_CONTEXT_COMPATIBILITY_PROFILE_BIT_ARB = $00000002;  
  GLX_CONTEXT_PROFILE_MASK_ARB = $9126;  

{ was #define dname def_expr }
function GLXEW_ARB_create_context_profile : longint; { return type might be wrong }

{$endif}
{ GLX_ARB_create_context_profile  }
{ ------------------- GLX_ARB_create_context_robustness -------------------  }
{$ifndef GLX_ARB_create_context_robustness}

const
  GLX_ARB_create_context_robustness = 1;  
  GLX_CONTEXT_ROBUST_ACCESS_BIT_ARB = $00000004;  
  GLX_LOSE_CONTEXT_ON_RESET_ARB = $8252;  
  GLX_CONTEXT_RESET_NOTIFICATION_STRATEGY_ARB = $8256;  
  GLX_NO_RESET_NOTIFICATION_ARB = $8261;  

{ was #define dname def_expr }
function GLXEW_ARB_create_context_robustness : longint; { return type might be wrong }

{$endif}
{ GLX_ARB_create_context_robustness  }
{ ------------------------- GLX_ARB_fbconfig_float ------------------------  }
{$ifndef GLX_ARB_fbconfig_float}

const
  GLX_ARB_fbconfig_float = 1;  
  GLX_RGBA_FLOAT_BIT_ARB = $00000004;  
  GLX_RGBA_FLOAT_TYPE_ARB = $20B9;  

{ was #define dname def_expr }
function GLXEW_ARB_fbconfig_float : longint; { return type might be wrong }

{$endif}
{ GLX_ARB_fbconfig_float  }
{ ------------------------ GLX_ARB_framebuffer_sRGB -----------------------  }
{$ifndef GLX_ARB_framebuffer_sRGB}

const
  GLX_ARB_framebuffer_sRGB = 1;  
  GLX_FRAMEBUFFER_SRGB_CAPABLE_ARB = $20B2;  

{ was #define dname def_expr }
function GLXEW_ARB_framebuffer_sRGB : longint; { return type might be wrong }

{$endif}
{ GLX_ARB_framebuffer_sRGB  }
{ ------------------------ GLX_ARB_get_proc_address -----------------------  }
{$ifndef GLX_ARB_get_proc_address}

const
  GLX_ARB_get_proc_address = 1;  
(* Const before type ignored *)

function glXGetProcAddressARB(procName:PGLubyte):procedure ;cdecl;external;
{ was #define dname def_expr }
function GLXEW_ARB_get_proc_address : longint; { return type might be wrong }

{$endif}
{ GLX_ARB_get_proc_address  }
{ -------------------------- GLX_ARB_multisample --------------------------  }
{$ifndef GLX_ARB_multisample}

const
  GLX_ARB_multisample = 1;  
  GLX_SAMPLE_BUFFERS_ARB = 100000;  
  GLX_SAMPLES_ARB = 100001;  

{ was #define dname def_expr }
function GLXEW_ARB_multisample : longint; { return type might be wrong }

{$endif}
{ GLX_ARB_multisample  }
{ ---------------- GLX_ARB_robustness_application_isolation ---------------  }
{$ifndef GLX_ARB_robustness_application_isolation}

const
  GLX_ARB_robustness_application_isolation = 1;  
  GLX_CONTEXT_RESET_ISOLATION_BIT_ARB = $00000008;  

{ was #define dname def_expr }
function GLXEW_ARB_robustness_application_isolation : longint; { return type might be wrong }

{$endif}
{ GLX_ARB_robustness_application_isolation  }
{ ---------------- GLX_ARB_robustness_share_group_isolation ---------------  }
{$ifndef GLX_ARB_robustness_share_group_isolation}

const
  GLX_ARB_robustness_share_group_isolation = 1;  
  GLX_CONTEXT_RESET_ISOLATION_BIT_ARB = $00000008;  

{ was #define dname def_expr }
function GLXEW_ARB_robustness_share_group_isolation : longint; { return type might be wrong }

{$endif}
{ GLX_ARB_robustness_share_group_isolation  }
{ ---------------------- GLX_ARB_vertex_buffer_object ---------------------  }
{$ifndef GLX_ARB_vertex_buffer_object}

const
  GLX_ARB_vertex_buffer_object = 1;  
  GLX_CONTEXT_ALLOW_BUFFER_BYTE_ORDER_MISMATCH_ARB = $2095;  

{ was #define dname def_expr }
function GLXEW_ARB_vertex_buffer_object : longint; { return type might be wrong }

{$endif}
{ GLX_ARB_vertex_buffer_object  }
{ ----------------------- GLX_ATI_pixel_format_float ----------------------  }
{$ifndef GLX_ATI_pixel_format_float}

const
  GLX_ATI_pixel_format_float = 1;  
  GLX_RGBA_FLOAT_ATI_BIT = $00000100;  

{ was #define dname def_expr }
function GLXEW_ATI_pixel_format_float : longint; { return type might be wrong }

{$endif}
{ GLX_ATI_pixel_format_float  }
{ ------------------------- GLX_ATI_render_texture ------------------------  }
{$ifndef GLX_ATI_render_texture}

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

  TPFNGLXBINDTEXIMAGEATIPROC = procedure (dpy:PDisplay; pbuf:TGLXPbuffer; buffer:longint);cdecl;
(* Const before type ignored *)

  TPFNGLXDRAWABLEATTRIBATIPROC = procedure (dpy:PDisplay; draw:TGLXDrawable; attrib_list:Plongint);cdecl;

  TPFNGLXRELEASETEXIMAGEATIPROC = procedure (dpy:PDisplay; pbuf:TGLXPbuffer; buffer:longint);cdecl;

{ was #define dname def_expr }
function glXBindTexImageATI : longint; { return type might be wrong }

{ was #define dname def_expr }
function glXDrawableAttribATI : longint; { return type might be wrong }

{ was #define dname def_expr }
function glXReleaseTexImageATI : longint; { return type might be wrong }

{ was #define dname def_expr }
function GLXEW_ATI_render_texture : longint; { return type might be wrong }

{$endif}
{ GLX_ATI_render_texture  }
{ --------------------------- GLX_EXT_buffer_age --------------------------  }
{$ifndef GLX_EXT_buffer_age}

const
  GLX_EXT_buffer_age = 1;  
  GLX_BACK_BUFFER_AGE_EXT = $20F4;  

{ was #define dname def_expr }
function GLXEW_EXT_buffer_age : longint; { return type might be wrong }

{$endif}
{ GLX_EXT_buffer_age  }
{ ------------------------ GLX_EXT_context_priority -----------------------  }
{$ifndef GLX_EXT_context_priority}

const
  GLX_EXT_context_priority = 1;  
  GLX_CONTEXT_PRIORITY_LEVEL_EXT = $3100;  
  GLX_CONTEXT_PRIORITY_HIGH_EXT = $3101;  
  GLX_CONTEXT_PRIORITY_MEDIUM_EXT = $3102;  
  GLX_CONTEXT_PRIORITY_LOW_EXT = $3103;  

{ was #define dname def_expr }
function GLXEW_EXT_context_priority : longint; { return type might be wrong }

{$endif}
{ GLX_EXT_context_priority  }
{ ------------------- GLX_EXT_create_context_es2_profile ------------------  }
{$ifndef GLX_EXT_create_context_es2_profile}

const
  GLX_EXT_create_context_es2_profile = 1;  
  GLX_CONTEXT_ES2_PROFILE_BIT_EXT = $00000004;  

{ was #define dname def_expr }
function GLXEW_EXT_create_context_es2_profile : longint; { return type might be wrong }

{$endif}
{ GLX_EXT_create_context_es2_profile  }
{ ------------------- GLX_EXT_create_context_es_profile -------------------  }
{$ifndef GLX_EXT_create_context_es_profile}

const
  GLX_EXT_create_context_es_profile = 1;  
  GLX_CONTEXT_ES_PROFILE_BIT_EXT = $00000004;  

{ was #define dname def_expr }
function GLXEW_EXT_create_context_es_profile : longint; { return type might be wrong }

{$endif}
{ GLX_EXT_create_context_es_profile  }
{ --------------------- GLX_EXT_fbconfig_packed_float ---------------------  }
{$ifndef GLX_EXT_fbconfig_packed_float}

const
  GLX_EXT_fbconfig_packed_float = 1;  
  GLX_RGBA_UNSIGNED_FLOAT_BIT_EXT = $00000008;  
  GLX_RGBA_UNSIGNED_FLOAT_TYPE_EXT = $20B1;  

{ was #define dname def_expr }
function GLXEW_EXT_fbconfig_packed_float : longint; { return type might be wrong }

{$endif}
{ GLX_EXT_fbconfig_packed_float  }
{ ------------------------ GLX_EXT_framebuffer_sRGB -----------------------  }
{$ifndef GLX_EXT_framebuffer_sRGB}

const
  GLX_EXT_framebuffer_sRGB = 1;  
  GLX_FRAMEBUFFER_SRGB_CAPABLE_EXT = $20B2;  

{ was #define dname def_expr }
function GLXEW_EXT_framebuffer_sRGB : longint; { return type might be wrong }

{$endif}
{ GLX_EXT_framebuffer_sRGB  }
{ ------------------------- GLX_EXT_import_context ------------------------  }
{$ifndef GLX_EXT_import_context}

const
  GLX_EXT_import_context = 1;  
  GLX_SHARE_CONTEXT_EXT = $800A;  
  GLX_VISUAL_ID_EXT = $800B;  
  GLX_SCREEN_EXT = $800C;  
type
  PGLXContextID = ^TGLXContextID;
  TGLXContextID = TXID;

  TPFNGLXFREECONTEXTEXTPROC = procedure (dpy:PDisplay; context:TGLXContext);cdecl;
(* Const before type ignored *)

  TPFNGLXGETCONTEXTIDEXTPROC = function (context:TGLXContext):TGLXContextID;cdecl;

  PPFNGLXGETCURRENTDISPLAYEXTPROC = ^TPFNGLXGETCURRENTDISPLAYEXTPROC;
  TPFNGLXGETCURRENTDISPLAYEXTPROC = function :PDisplay;cdecl;

  TPFNGLXIMPORTCONTEXTEXTPROC = function (dpy:PDisplay; contextID:TGLXContextID):TGLXContext;cdecl;

  TPFNGLXQUERYCONTEXTINFOEXTPROC = function (dpy:PDisplay; context:TGLXContext; attribute:longint; value:Plongint):longint;cdecl;

{ was #define dname def_expr }
function glXFreeContextEXT : longint; { return type might be wrong }

{ was #define dname def_expr }
function glXGetContextIDEXT : longint; { return type might be wrong }

{ was #define dname def_expr }
function glXGetCurrentDisplayEXT : longint; { return type might be wrong }

{ was #define dname def_expr }
function glXImportContextEXT : longint; { return type might be wrong }

{ was #define dname def_expr }
function glXQueryContextInfoEXT : longint; { return type might be wrong }

{ was #define dname def_expr }
function GLXEW_EXT_import_context : longint; { return type might be wrong }

{$endif}
{ GLX_EXT_import_context  }
{ ---------------------------- GLX_EXT_libglvnd ---------------------------  }
{$ifndef GLX_EXT_libglvnd}

const
  GLX_EXT_libglvnd = 1;  
  GLX_VENDOR_NAMES_EXT = $20F6;  

{ was #define dname def_expr }
function GLXEW_EXT_libglvnd : longint; { return type might be wrong }

{$endif}
{ GLX_EXT_libglvnd  }
{ ----------------------- GLX_EXT_no_config_context -----------------------  }
{$ifndef GLX_EXT_no_config_context}

const
  GLX_EXT_no_config_context = 1;  

{ was #define dname def_expr }
function GLXEW_EXT_no_config_context : longint; { return type might be wrong }

{$endif}
{ GLX_EXT_no_config_context  }
{ -------------------------- GLX_EXT_scene_marker -------------------------  }
{$ifndef GLX_EXT_scene_marker}

const
  GLX_EXT_scene_marker = 1;  

{ was #define dname def_expr }
function GLXEW_EXT_scene_marker : longint; { return type might be wrong }

{$endif}
{ GLX_EXT_scene_marker  }
{ -------------------------- GLX_EXT_stereo_tree --------------------------  }
{$ifndef GLX_EXT_stereo_tree}

const
  GLX_EXT_stereo_tree = 1;  
  GLX_STEREO_NOTIFY_EXT = $00000000;  
  GLX_STEREO_NOTIFY_MASK_EXT = $00000001;  
  GLX_STEREO_TREE_EXT = $20F5;  

{ was #define dname def_expr }
function GLXEW_EXT_stereo_tree : longint; { return type might be wrong }

{$endif}
{ GLX_EXT_stereo_tree  }
{ -------------------------- GLX_EXT_swap_control -------------------------  }
{$ifndef GLX_EXT_swap_control}

const
  GLX_EXT_swap_control = 1;  
  GLX_SWAP_INTERVAL_EXT = $20F1;  
  GLX_MAX_SWAP_INTERVAL_EXT = $20F2;  
type

  TPFNGLXSWAPINTERVALEXTPROC = procedure (dpy:PDisplay; drawable:TGLXDrawable; interval:longint);cdecl;

{ was #define dname def_expr }
function glXSwapIntervalEXT : longint; { return type might be wrong }

{ was #define dname def_expr }
function GLXEW_EXT_swap_control : longint; { return type might be wrong }

{$endif}
{ GLX_EXT_swap_control  }
{ ----------------------- GLX_EXT_swap_control_tear -----------------------  }
{$ifndef GLX_EXT_swap_control_tear}

const
  GLX_EXT_swap_control_tear = 1;  
  GLX_LATE_SWAPS_TEAR_EXT = $20F3;  

{ was #define dname def_expr }
function GLXEW_EXT_swap_control_tear : longint; { return type might be wrong }

{$endif}
{ GLX_EXT_swap_control_tear  }
{ ---------------------- GLX_EXT_texture_from_pixmap ----------------------  }
{$ifndef GLX_EXT_texture_from_pixmap}

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
(* Const before type ignored *)
type

  TPFNGLXBINDTEXIMAGEEXTPROC = procedure (dpy:PDisplay; drawable:TGLXDrawable; buffer:longint; attrib_list:Plongint);cdecl;

  TPFNGLXRELEASETEXIMAGEEXTPROC = procedure (dpy:PDisplay; drawable:TGLXDrawable; buffer:longint);cdecl;

{ was #define dname def_expr }
function glXBindTexImageEXT : longint; { return type might be wrong }

{ was #define dname def_expr }
function glXReleaseTexImageEXT : longint; { return type might be wrong }

{ was #define dname def_expr }
function GLXEW_EXT_texture_from_pixmap : longint; { return type might be wrong }

{$endif}
{ GLX_EXT_texture_from_pixmap  }
{ -------------------------- GLX_EXT_visual_info --------------------------  }
{$ifndef GLX_EXT_visual_info}

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

{ was #define dname def_expr }
function GLXEW_EXT_visual_info : longint; { return type might be wrong }

{$endif}
{ GLX_EXT_visual_info  }
{ ------------------------- GLX_EXT_visual_rating -------------------------  }
{$ifndef GLX_EXT_visual_rating}

const
  GLX_EXT_visual_rating = 1;  
  GLX_VISUAL_CAVEAT_EXT = $20;  
  GLX_SLOW_VISUAL_EXT = $8001;  
  GLX_NON_CONFORMANT_VISUAL_EXT = $800D;  

{ was #define dname def_expr }
function GLXEW_EXT_visual_rating : longint; { return type might be wrong }

{$endif}
{ GLX_EXT_visual_rating  }
{ -------------------------- GLX_INTEL_swap_event -------------------------  }
{$ifndef GLX_INTEL_swap_event}

const
  GLX_INTEL_swap_event = 1;  
  GLX_EXCHANGE_COMPLETE_INTEL = $8180;  
  GLX_COPY_COMPLETE_INTEL = $8181;  
  GLX_FLIP_COMPLETE_INTEL = $8182;  
  GLX_BUFFER_SWAP_COMPLETE_INTEL_MASK = $04000000;  

{ was #define dname def_expr }
function GLXEW_INTEL_swap_event : longint; { return type might be wrong }

{$endif}
{ GLX_INTEL_swap_event  }
{ -------------------------- GLX_MESA_agp_offset --------------------------  }
{$ifndef GLX_MESA_agp_offset}

const
  GLX_MESA_agp_offset = 1;  
(* Const before type ignored *)
type

  TPFNGLXGETAGPOFFSETMESAPROC = function (pointer:pointer):dword;cdecl;

{ was #define dname def_expr }
function glXGetAGPOffsetMESA : longint; { return type might be wrong }

{ was #define dname def_expr }
function GLXEW_MESA_agp_offset : longint; { return type might be wrong }

{$endif}
{ GLX_MESA_agp_offset  }
{ ------------------------ GLX_MESA_copy_sub_buffer -----------------------  }
{$ifndef GLX_MESA_copy_sub_buffer}

const
  GLX_MESA_copy_sub_buffer = 1;  
type

  TPFNGLXCOPYSUBBUFFERMESAPROC = procedure (dpy:PDisplay; drawable:TGLXDrawable; x:longint; y:longint; width:longint; 
                height:longint);cdecl;

{ was #define dname def_expr }
function glXCopySubBufferMESA : longint; { return type might be wrong }

{ was #define dname def_expr }
function GLXEW_MESA_copy_sub_buffer : longint; { return type might be wrong }

{$endif}
{ GLX_MESA_copy_sub_buffer  }
{ ------------------------ GLX_MESA_pixmap_colormap -----------------------  }
{$ifndef GLX_MESA_pixmap_colormap}

const
  GLX_MESA_pixmap_colormap = 1;  
type

  TPFNGLXCREATEGLXPIXMAPMESAPROC = function (dpy:PDisplay; visual:PXVisualInfo; pixmap:TPixmap; cmap:TColormap):TGLXPixmap;cdecl;

{ was #define dname def_expr }
function glXCreateGLXPixmapMESA : longint; { return type might be wrong }

{ was #define dname def_expr }
function GLXEW_MESA_pixmap_colormap : longint; { return type might be wrong }

{$endif}
{ GLX_MESA_pixmap_colormap  }
{ ------------------------ GLX_MESA_query_renderer ------------------------  }
{$ifndef GLX_MESA_query_renderer}

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

  TPFNGLXQUERYCURRENTRENDERERINTEGERMESAPROC = function (attribute:longint; value:Pdword):TBool;cdecl;
(* Const before type ignored *)

  PPFNGLXQUERYCURRENTRENDERERSTRINGMESAPROC = ^TPFNGLXQUERYCURRENTRENDERERSTRINGMESAPROC;
  TPFNGLXQUERYCURRENTRENDERERSTRINGMESAPROC = function (attribute:longint):Pchar;cdecl;

  TPFNGLXQUERYRENDERERINTEGERMESAPROC = function (dpy:PDisplay; screen:longint; renderer:longint; attribute:longint; value:Pdword):TBool;cdecl;
(* Const before type ignored *)

  PPFNGLXQUERYRENDERERSTRINGMESAPROC = ^TPFNGLXQUERYRENDERERSTRINGMESAPROC;
  TPFNGLXQUERYRENDERERSTRINGMESAPROC = function (dpy:PDisplay; screen:longint; renderer:longint; attribute:longint):Pchar;cdecl;

{ was #define dname def_expr }
function glXQueryCurrentRendererIntegerMESA : longint; { return type might be wrong }

{ was #define dname def_expr }
function glXQueryCurrentRendererStringMESA : longint; { return type might be wrong }

{ was #define dname def_expr }
function glXQueryRendererIntegerMESA : longint; { return type might be wrong }

{ was #define dname def_expr }
function glXQueryRendererStringMESA : longint; { return type might be wrong }

{ was #define dname def_expr }
function GLXEW_MESA_query_renderer : longint; { return type might be wrong }

{$endif}
{ GLX_MESA_query_renderer  }
{ ------------------------ GLX_MESA_release_buffers -----------------------  }
{$ifndef GLX_MESA_release_buffers}

const
  GLX_MESA_release_buffers = 1;  
type

  TPFNGLXRELEASEBUFFERSMESAPROC = function (dpy:PDisplay; drawable:TGLXDrawable):TBool;cdecl;

{ was #define dname def_expr }
function glXReleaseBuffersMESA : longint; { return type might be wrong }

{ was #define dname def_expr }
function GLXEW_MESA_release_buffers : longint; { return type might be wrong }

{$endif}
{ GLX_MESA_release_buffers  }
{ ------------------------- GLX_MESA_set_3dfx_mode ------------------------  }
{$ifndef GLX_MESA_set_3dfx_mode}

const
  GLX_MESA_set_3dfx_mode = 1;  
  GLX_3DFX_WINDOW_MODE_MESA = $1;  
  GLX_3DFX_FULLSCREEN_MODE_MESA = $2;  
type

  TPFNGLXSET3DFXMODEMESAPROC = function (mode:TGLint):TGLboolean;cdecl;

{ was #define dname def_expr }
function glXSet3DfxModeMESA : longint; { return type might be wrong }

{ was #define dname def_expr }
function GLXEW_MESA_set_3dfx_mode : longint; { return type might be wrong }

{$endif}
{ GLX_MESA_set_3dfx_mode  }
{ ------------------------- GLX_MESA_swap_control -------------------------  }
{$ifndef GLX_MESA_swap_control}

const
  GLX_MESA_swap_control = 1;  
type

  TPFNGLXGETSWAPINTERVALMESAPROC = function (para1:pointer):longint;cdecl;

  TPFNGLXSWAPINTERVALMESAPROC = function (interval:dword):longint;cdecl;

{ was #define dname def_expr }
function glXGetSwapIntervalMESA : longint; { return type might be wrong }

{ was #define dname def_expr }
function glXSwapIntervalMESA : longint; { return type might be wrong }

{ was #define dname def_expr }
function GLXEW_MESA_swap_control : longint; { return type might be wrong }

{$endif}
{ GLX_MESA_swap_control  }
{ --------------------------- GLX_NV_copy_buffer --------------------------  }
{$ifndef GLX_NV_copy_buffer}

const
  GLX_NV_copy_buffer = 1;  
type

  TPFNGLXCOPYBUFFERSUBDATANVPROC = procedure (dpy:PDisplay; readCtx:TGLXContext; writeCtx:TGLXContext; readTarget:TGLenum; writeTarget:TGLenum; 
                readOffset:TGLintptr; writeOffset:TGLintptr; size:TGLsizeiptr);cdecl;

  TPFNGLXNAMEDCOPYBUFFERSUBDATANVPROC = procedure (dpy:PDisplay; readCtx:TGLXContext; writeCtx:TGLXContext; readBuffer:TGLuint; writeBuffer:TGLuint; 
                readOffset:TGLintptr; writeOffset:TGLintptr; size:TGLsizeiptr);cdecl;

{ was #define dname def_expr }
function glXCopyBufferSubDataNV : longint; { return type might be wrong }

{ was #define dname def_expr }
function glXNamedCopyBufferSubDataNV : longint; { return type might be wrong }

{ was #define dname def_expr }
function GLXEW_NV_copy_buffer : longint; { return type might be wrong }

{$endif}
{ GLX_NV_copy_buffer  }
{ --------------------------- GLX_NV_copy_image ---------------------------  }
{$ifndef GLX_NV_copy_image}

const
  GLX_NV_copy_image = 1;  
type

  TPFNGLXCOPYIMAGESUBDATANVPROC = procedure (dpy:PDisplay; srcCtx:TGLXContext; srcName:TGLuint; srcTarget:TGLenum; srcLevel:TGLint; 
                srcX:TGLint; srcY:TGLint; srcZ:TGLint; dstCtx:TGLXContext; dstName:TGLuint; 
                dstTarget:TGLenum; dstLevel:TGLint; dstX:TGLint; dstY:TGLint; dstZ:TGLint; 
                width:TGLsizei; height:TGLsizei; depth:TGLsizei);cdecl;

{ was #define dname def_expr }
function glXCopyImageSubDataNV : longint; { return type might be wrong }

{ was #define dname def_expr }
function GLXEW_NV_copy_image : longint; { return type might be wrong }

{$endif}
{ GLX_NV_copy_image  }
{ ------------------------ GLX_NV_delay_before_swap -----------------------  }
{$ifndef GLX_NV_delay_before_swap}

const
  GLX_NV_delay_before_swap = 1;  
type

  TPFNGLXDELAYBEFORESWAPNVPROC = function (dpy:PDisplay; drawable:TGLXDrawable; seconds:TGLfloat):TBool;cdecl;

{ was #define dname def_expr }
function glXDelayBeforeSwapNV : longint; { return type might be wrong }

{ was #define dname def_expr }
function GLXEW_NV_delay_before_swap : longint; { return type might be wrong }

{$endif}
{ GLX_NV_delay_before_swap  }
{ -------------------------- GLX_NV_float_buffer --------------------------  }
{$ifndef GLX_NV_float_buffer}

const
  GLX_NV_float_buffer = 1;  
  GLX_FLOAT_COMPONENTS_NV = $20B0;  

{ was #define dname def_expr }
function GLXEW_NV_float_buffer : longint; { return type might be wrong }

{$endif}
{ GLX_NV_float_buffer  }
{ ------------------------ GLX_NV_multigpu_context ------------------------  }
{$ifndef GLX_NV_multigpu_context}

const
  GLX_NV_multigpu_context = 1;  
  GLX_CONTEXT_MULTIGPU_ATTRIB_NV = $20AA;  
  GLX_CONTEXT_MULTIGPU_ATTRIB_SINGLE_NV = $20AB;  
  GLX_CONTEXT_MULTIGPU_ATTRIB_AFR_NV = $20AC;  
  GLX_CONTEXT_MULTIGPU_ATTRIB_MULTICAST_NV = $20AD;  
  GLX_CONTEXT_MULTIGPU_ATTRIB_MULTI_DISPLAY_MULTICAST_NV = $20AE;  

{ was #define dname def_expr }
function GLXEW_NV_multigpu_context : longint; { return type might be wrong }

{$endif}
{ GLX_NV_multigpu_context  }
{ ---------------------- GLX_NV_multisample_coverage ----------------------  }
{$ifndef GLX_NV_multisample_coverage}

const
  GLX_NV_multisample_coverage = 1;  
  GLX_COLOR_SAMPLES_NV = $20B3;  
  GLX_COVERAGE_SAMPLES_NV = 100001;  

{ was #define dname def_expr }
function GLXEW_NV_multisample_coverage : longint; { return type might be wrong }

{$endif}
{ GLX_NV_multisample_coverage  }
{ -------------------------- GLX_NV_present_video -------------------------  }
{$ifndef GLX_NV_present_video}

const
  GLX_NV_present_video = 1;  
  GLX_NUM_VIDEO_SLOTS_NV = $20F0;  
(* Const before type ignored *)
type

  TPFNGLXBINDVIDEODEVICENVPROC = function (dpy:PDisplay; video_slot:dword; video_device:dword; attrib_list:Plongint):longint;cdecl;

  PPFNGLXENUMERATEVIDEODEVICESNVPROC = ^TPFNGLXENUMERATEVIDEODEVICESNVPROC;
  TPFNGLXENUMERATEVIDEODEVICESNVPROC = function (dpy:PDisplay; screen:longint; nelements:Plongint):Pdword;cdecl;

{ was #define dname def_expr }
function glXBindVideoDeviceNV : longint; { return type might be wrong }

{ was #define dname def_expr }
function glXEnumerateVideoDevicesNV : longint; { return type might be wrong }

{ was #define dname def_expr }
function GLXEW_NV_present_video : longint; { return type might be wrong }

{$endif}
{ GLX_NV_present_video  }
{ ------------------ GLX_NV_robustness_video_memory_purge -----------------  }
{$ifndef GLX_NV_robustness_video_memory_purge}

const
  GLX_NV_robustness_video_memory_purge = 1;  
  GLX_GENERATE_RESET_ON_VIDEO_MEMORY_PURGE_NV = $20F7;  

{ was #define dname def_expr }
function GLXEW_NV_robustness_video_memory_purge : longint; { return type might be wrong }

{$endif}
{ GLX_NV_robustness_video_memory_purge  }
{ --------------------------- GLX_NV_swap_group ---------------------------  }
{$ifndef GLX_NV_swap_group}

const
  GLX_NV_swap_group = 1;  
type

  TPFNGLXBINDSWAPBARRIERNVPROC = function (dpy:PDisplay; group:TGLuint; barrier:TGLuint):TBool;cdecl;

  TPFNGLXJOINSWAPGROUPNVPROC = function (dpy:PDisplay; drawable:TGLXDrawable; group:TGLuint):TBool;cdecl;

  TPFNGLXQUERYFRAMECOUNTNVPROC = function (dpy:PDisplay; screen:longint; count:PGLuint):TBool;cdecl;

  TPFNGLXQUERYMAXSWAPGROUPSNVPROC = function (dpy:PDisplay; screen:longint; maxGroups:PGLuint; maxBarriers:PGLuint):TBool;cdecl;

  TPFNGLXQUERYSWAPGROUPNVPROC = function (dpy:PDisplay; drawable:TGLXDrawable; group:PGLuint; barrier:PGLuint):TBool;cdecl;

  TPFNGLXRESETFRAMECOUNTNVPROC = function (dpy:PDisplay; screen:longint):TBool;cdecl;

{ was #define dname def_expr }
function glXBindSwapBarrierNV : longint; { return type might be wrong }

{ was #define dname def_expr }
function glXJoinSwapGroupNV : longint; { return type might be wrong }

{ was #define dname def_expr }
function glXQueryFrameCountNV : longint; { return type might be wrong }

{ was #define dname def_expr }
function glXQueryMaxSwapGroupsNV : longint; { return type might be wrong }

{ was #define dname def_expr }
function glXQuerySwapGroupNV : longint; { return type might be wrong }

{ was #define dname def_expr }
function glXResetFrameCountNV : longint; { return type might be wrong }

{ was #define dname def_expr }
function GLXEW_NV_swap_group : longint; { return type might be wrong }

{$endif}
{ GLX_NV_swap_group  }
{ ----------------------- GLX_NV_vertex_array_range -----------------------  }
{$ifndef GLX_NV_vertex_array_range}

const
  GLX_NV_vertex_array_range = 1;  
type
  PPFNGLXALLOCATEMEMORYNVPROC = ^TPFNGLXALLOCATEMEMORYNVPROC;
  TPFNGLXALLOCATEMEMORYNVPROC = function (size:TGLsizei; readFrequency:TGLfloat; writeFrequency:TGLfloat; priority:TGLfloat):pointer;cdecl;

  TPFNGLXFREEMEMORYNVPROC = procedure (pointer:pointer);cdecl;

{ was #define dname def_expr }
function glXAllocateMemoryNV : longint; { return type might be wrong }

{ was #define dname def_expr }
function glXFreeMemoryNV : longint; { return type might be wrong }

{ was #define dname def_expr }
function GLXEW_NV_vertex_array_range : longint; { return type might be wrong }

{$endif}
{ GLX_NV_vertex_array_range  }
{ -------------------------- GLX_NV_video_capture -------------------------  }
{$ifndef GLX_NV_video_capture}

const
  GLX_NV_video_capture = 1;  
  GLX_DEVICE_ID_NV = $20CD;  
  GLX_UNIQUE_ID_NV = $20CE;  
  GLX_NUM_VIDEO_CAPTURE_SLOTS_NV = $20CF;  
type
  PGLXVideoCaptureDeviceNV = ^TGLXVideoCaptureDeviceNV;
  TGLXVideoCaptureDeviceNV = TXID;

  TPFNGLXBINDVIDEOCAPTUREDEVICENVPROC = function (dpy:PDisplay; video_capture_slot:dword; device:TGLXVideoCaptureDeviceNV):longint;cdecl;

  PPFNGLXENUMERATEVIDEOCAPTUREDEVICESNVPROC = ^TPFNGLXENUMERATEVIDEOCAPTUREDEVICESNVPROC;
  TPFNGLXENUMERATEVIDEOCAPTUREDEVICESNVPROC = function (dpy:PDisplay; screen:longint; nelements:Plongint):PGLXVideoCaptureDeviceNV;cdecl;

  TPFNGLXLOCKVIDEOCAPTUREDEVICENVPROC = procedure (dpy:PDisplay; device:TGLXVideoCaptureDeviceNV);cdecl;

  TPFNGLXQUERYVIDEOCAPTUREDEVICENVPROC = function (dpy:PDisplay; device:TGLXVideoCaptureDeviceNV; attribute:longint; value:Plongint):longint;cdecl;

  TPFNGLXRELEASEVIDEOCAPTUREDEVICENVPROC = procedure (dpy:PDisplay; device:TGLXVideoCaptureDeviceNV);cdecl;

{ was #define dname def_expr }
function glXBindVideoCaptureDeviceNV : longint; { return type might be wrong }

{ was #define dname def_expr }
function glXEnumerateVideoCaptureDevicesNV : longint; { return type might be wrong }

{ was #define dname def_expr }
function glXLockVideoCaptureDeviceNV : longint; { return type might be wrong }

{ was #define dname def_expr }
function glXQueryVideoCaptureDeviceNV : longint; { return type might be wrong }

{ was #define dname def_expr }
function glXReleaseVideoCaptureDeviceNV : longint; { return type might be wrong }

{ was #define dname def_expr }
function GLXEW_NV_video_capture : longint; { return type might be wrong }

{$endif}
{ GLX_NV_video_capture  }
{ ---------------------------- GLX_NV_video_out ---------------------------  }
{$ifndef GLX_NV_video_out}

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

  TPFNGLXBINDVIDEOIMAGENVPROC = function (dpy:PDisplay; VideoDevice:TGLXVideoDeviceNV; pbuf:TGLXPbuffer; iVideoBuffer:longint):longint;cdecl;

  TPFNGLXGETVIDEODEVICENVPROC = function (dpy:PDisplay; screen:longint; numVideoDevices:longint; pVideoDevice:PGLXVideoDeviceNV):longint;cdecl;

  TPFNGLXGETVIDEOINFONVPROC = function (dpy:PDisplay; screen:longint; VideoDevice:TGLXVideoDeviceNV; pulCounterOutputPbuffer:Pdword; pulCounterOutputVideo:Pdword):longint;cdecl;

  TPFNGLXRELEASEVIDEODEVICENVPROC = function (dpy:PDisplay; screen:longint; VideoDevice:TGLXVideoDeviceNV):longint;cdecl;

  TPFNGLXRELEASEVIDEOIMAGENVPROC = function (dpy:PDisplay; pbuf:TGLXPbuffer):longint;cdecl;

  TPFNGLXSENDPBUFFERTOVIDEONVPROC = function (dpy:PDisplay; pbuf:TGLXPbuffer; iBufferType:longint; pulCounterPbuffer:Pdword; bBlock:TGLboolean):longint;cdecl;

{ was #define dname def_expr }
function glXBindVideoImageNV : longint; { return type might be wrong }

{ was #define dname def_expr }
function glXGetVideoDeviceNV : longint; { return type might be wrong }

{ was #define dname def_expr }
function glXGetVideoInfoNV : longint; { return type might be wrong }

{ was #define dname def_expr }
function glXReleaseVideoDeviceNV : longint; { return type might be wrong }

{ was #define dname def_expr }
function glXReleaseVideoImageNV : longint; { return type might be wrong }

{ was #define dname def_expr }
function glXSendPbufferToVideoNV : longint; { return type might be wrong }

{ was #define dname def_expr }
function GLXEW_NV_video_out : longint; { return type might be wrong }

{$endif}
{ GLX_NV_video_out  }
{ -------------------------- GLX_OML_swap_method --------------------------  }
{$ifndef GLX_OML_swap_method}

const
  GLX_OML_swap_method = 1;  
  GLX_SWAP_METHOD_OML = $8060;  
  GLX_SWAP_EXCHANGE_OML = $8061;  
  GLX_SWAP_COPY_OML = $8062;  
  GLX_SWAP_UNDEFINED_OML = $8063;  

{ was #define dname def_expr }
function GLXEW_OML_swap_method : longint; { return type might be wrong }

{$endif}
{ GLX_OML_swap_method  }
{ -------------------------- GLX_OML_sync_control -------------------------  }
{$ifndef GLX_OML_sync_control}

const
  GLX_OML_sync_control = 1;  
type

  TPFNGLXGETMSCRATEOMLPROC = function (dpy:PDisplay; drawable:TGLXDrawable; numerator:Pint32_t; denominator:Pint32_t):TBool;cdecl;

  TPFNGLXGETSYNCVALUESOMLPROC = function (dpy:PDisplay; drawable:TGLXDrawable; ust:Pint64_t; msc:Pint64_t; sbc:Pint64_t):TBool;cdecl;

  TPFNGLXSWAPBUFFERSMSCOMLPROC = function (dpy:PDisplay; drawable:TGLXDrawable; target_msc:Tint64_t; divisor:Tint64_t; remainder:Tint64_t):Tint64_t;cdecl;

  TPFNGLXWAITFORMSCOMLPROC = function (dpy:PDisplay; drawable:TGLXDrawable; target_msc:Tint64_t; divisor:Tint64_t; remainder:Tint64_t; 
               ust:Pint64_t; msc:Pint64_t; sbc:Pint64_t):TBool;cdecl;

  TPFNGLXWAITFORSBCOMLPROC = function (dpy:PDisplay; drawable:TGLXDrawable; target_sbc:Tint64_t; ust:Pint64_t; msc:Pint64_t; 
               sbc:Pint64_t):TBool;cdecl;

{ was #define dname def_expr }
function glXGetMscRateOML : longint; { return type might be wrong }

{ was #define dname def_expr }
function glXGetSyncValuesOML : longint; { return type might be wrong }

{ was #define dname def_expr }
function glXSwapBuffersMscOML : longint; { return type might be wrong }

{ was #define dname def_expr }
function glXWaitForMscOML : longint; { return type might be wrong }

{ was #define dname def_expr }
function glXWaitForSbcOML : longint; { return type might be wrong }

{ was #define dname def_expr }
function GLXEW_OML_sync_control : longint; { return type might be wrong }

{$endif}
{ GLX_OML_sync_control  }
{ ------------------------ GLX_SGIS_blended_overlay -----------------------  }
{$ifndef GLX_SGIS_blended_overlay}

const
  GLX_SGIS_blended_overlay = 1;  
  GLX_BLENDED_RGBA_SGIS = $8025;  

{ was #define dname def_expr }
function GLXEW_SGIS_blended_overlay : longint; { return type might be wrong }

{$endif}
{ GLX_SGIS_blended_overlay  }
{ -------------------------- GLX_SGIS_color_range -------------------------  }
{$ifndef GLX_SGIS_color_range}

const
  GLX_SGIS_color_range = 1;  

{ was #define dname def_expr }
function GLXEW_SGIS_color_range : longint; { return type might be wrong }

{$endif}
{ GLX_SGIS_color_range  }
{ -------------------------- GLX_SGIS_multisample -------------------------  }
{$ifndef GLX_SGIS_multisample}

const
  GLX_SGIS_multisample = 1;  
  GLX_SAMPLE_BUFFERS_SGIS = 100000;  
  GLX_SAMPLES_SGIS = 100001;  

{ was #define dname def_expr }
function GLXEW_SGIS_multisample : longint; { return type might be wrong }

{$endif}
{ GLX_SGIS_multisample  }
{ ---------------------- GLX_SGIS_shared_multisample ----------------------  }
{$ifndef GLX_SGIS_shared_multisample}

const
  GLX_SGIS_shared_multisample = 1;  
  GLX_MULTISAMPLE_SUB_RECT_WIDTH_SGIS = $8026;  
  GLX_MULTISAMPLE_SUB_RECT_HEIGHT_SGIS = $8027;  

{ was #define dname def_expr }
function GLXEW_SGIS_shared_multisample : longint; { return type might be wrong }

{$endif}
{ GLX_SGIS_shared_multisample  }
{ --------------------------- GLX_SGIX_fbconfig ---------------------------  }
{$ifndef GLX_SGIX_fbconfig}

const
  GLX_SGIX_fbconfig = 1;  
  GLX_RGBA_BIT_SGIX = $00000001;  
  GLX_WINDOW_BIT_SGIX = $00000001;  
  GLX_COLOR_INDEX_BIT_SGIX = $00000002;  
  GLX_PIXMAP_BIT_SGIX = $00000002;  
  GLX_SCREEN_EXT = $800C;  
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
  TGLXFBConfigSGIX = P_GLXFBConfigRec;

  PPFNGLXCHOOSEFBCONFIGSGIXPROC = ^TPFNGLXCHOOSEFBCONFIGSGIXPROC;
  TPFNGLXCHOOSEFBCONFIGSGIXPROC = function (dpy:PDisplay; screen:longint; attrib_list:Plongint; nelements:Plongint):PGLXFBConfigSGIX;cdecl;

  TPFNGLXCREATECONTEXTWITHCONFIGSGIXPROC = function (dpy:PDisplay; config:TGLXFBConfigSGIX; render_type:longint; share_list:TGLXContext; direct:TBool):TGLXContext;cdecl;

  TPFNGLXCREATEGLXPIXMAPWITHCONFIGSGIXPROC = function (dpy:PDisplay; config:TGLXFBConfigSGIX; pixmap:TPixmap):TGLXPixmap;cdecl;

  TPFNGLXGETFBCONFIGATTRIBSGIXPROC = function (dpy:PDisplay; config:TGLXFBConfigSGIX; attribute:longint; value:Plongint):longint;cdecl;

  TPFNGLXGETFBCONFIGFROMVISUALSGIXPROC = function (dpy:PDisplay; vis:PXVisualInfo):TGLXFBConfigSGIX;cdecl;

  PPFNGLXGETVISUALFROMFBCONFIGSGIXPROC = ^TPFNGLXGETVISUALFROMFBCONFIGSGIXPROC;
  TPFNGLXGETVISUALFROMFBCONFIGSGIXPROC = function (dpy:PDisplay; config:TGLXFBConfigSGIX):PXVisualInfo;cdecl;

{ was #define dname def_expr }
function glXChooseFBConfigSGIX : longint; { return type might be wrong }

{ was #define dname def_expr }
function glXCreateContextWithConfigSGIX : longint; { return type might be wrong }

{ was #define dname def_expr }
function glXCreateGLXPixmapWithConfigSGIX : longint; { return type might be wrong }

{ was #define dname def_expr }
function glXGetFBConfigAttribSGIX : longint; { return type might be wrong }

{ was #define dname def_expr }
function glXGetFBConfigFromVisualSGIX : longint; { return type might be wrong }

{ was #define dname def_expr }
function glXGetVisualFromFBConfigSGIX : longint; { return type might be wrong }

{ was #define dname def_expr }
function GLXEW_SGIX_fbconfig : longint; { return type might be wrong }

{$endif}
{ GLX_SGIX_fbconfig  }
{ --------------------------- GLX_SGIX_hyperpipe --------------------------  }
{$ifndef GLX_SGIX_hyperpipe}

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
  PGLXHyperpipeNetworkSGIX = ^TGLXHyperpipeNetworkSGIX;
  TGLXHyperpipeNetworkSGIX = record
      pipeName : array[0..(GLX_HYPERPIPE_PIPE_NAME_LENGTH_SGIX)-1] of char;
      networkId : longint;
    end;

  PGLXPipeRectLimits = ^TGLXPipeRectLimits;
  TGLXPipeRectLimits = record
      pipeName : array[0..(GLX_HYPERPIPE_PIPE_NAME_LENGTH_SGIX)-1] of char;
      XOrigin : longint;
      YOrigin : longint;
      maxHeight : longint;
      maxWidth : longint;
    end;

  PGLXHyperpipeConfigSGIX = ^TGLXHyperpipeConfigSGIX;
  TGLXHyperpipeConfigSGIX = record
      pipeName : array[0..(GLX_HYPERPIPE_PIPE_NAME_LENGTH_SGIX)-1] of char;
      channel : longint;
      participationType : dword;
      timeSlice : longint;
    end;

  PGLXPipeRect = ^TGLXPipeRect;
  TGLXPipeRect = record
      pipeName : array[0..(GLX_HYPERPIPE_PIPE_NAME_LENGTH_SGIX)-1] of char;
      srcXOrigin : longint;
      srcYOrigin : longint;
      srcWidth : longint;
      srcHeight : longint;
      destXOrigin : longint;
      destYOrigin : longint;
      destWidth : longint;
      destHeight : longint;
    end;

  TPFNGLXBINDHYPERPIPESGIXPROC = function (dpy:PDisplay; hpId:longint):longint;cdecl;

  TPFNGLXDESTROYHYPERPIPECONFIGSGIXPROC = function (dpy:PDisplay; hpId:longint):longint;cdecl;

  TPFNGLXHYPERPIPEATTRIBSGIXPROC = function (dpy:PDisplay; timeSlice:longint; attrib:longint; size:longint; attribList:pointer):longint;cdecl;

  TPFNGLXHYPERPIPECONFIGSGIXPROC = function (dpy:PDisplay; networkId:longint; npipes:longint; cfg:PGLXHyperpipeConfigSGIX; hpId:Plongint):longint;cdecl;

  TPFNGLXQUERYHYPERPIPEATTRIBSGIXPROC = function (dpy:PDisplay; timeSlice:longint; attrib:longint; size:longint; returnAttribList:pointer):longint;cdecl;

  TPFNGLXQUERYHYPERPIPEBESTATTRIBSGIXPROC = function (dpy:PDisplay; timeSlice:longint; attrib:longint; size:longint; attribList:pointer; 
               returnAttribList:pointer):longint;cdecl;

  PPFNGLXQUERYHYPERPIPECONFIGSGIXPROC = ^TPFNGLXQUERYHYPERPIPECONFIGSGIXPROC;
  TPFNGLXQUERYHYPERPIPECONFIGSGIXPROC = function (dpy:PDisplay; hpId:longint; npipes:Plongint):PGLXHyperpipeConfigSGIX;cdecl;

  PPFNGLXQUERYHYPERPIPENETWORKSGIXPROC = ^TPFNGLXQUERYHYPERPIPENETWORKSGIXPROC;
  TPFNGLXQUERYHYPERPIPENETWORKSGIXPROC = function (dpy:PDisplay; npipes:Plongint):PGLXHyperpipeNetworkSGIX;cdecl;

{ was #define dname def_expr }
function glXBindHyperpipeSGIX : longint; { return type might be wrong }

{ was #define dname def_expr }
function glXDestroyHyperpipeConfigSGIX : longint; { return type might be wrong }

{ was #define dname def_expr }
function glXHyperpipeAttribSGIX : longint; { return type might be wrong }

{ was #define dname def_expr }
function glXHyperpipeConfigSGIX : longint; { return type might be wrong }

{ was #define dname def_expr }
function glXQueryHyperpipeAttribSGIX : longint; { return type might be wrong }

{ was #define dname def_expr }
function glXQueryHyperpipeBestAttribSGIX : longint; { return type might be wrong }

{ was #define dname def_expr }
function glXQueryHyperpipeConfigSGIX : longint; { return type might be wrong }

{ was #define dname def_expr }
function glXQueryHyperpipeNetworkSGIX : longint; { return type might be wrong }

{ was #define dname def_expr }
function GLXEW_SGIX_hyperpipe : longint; { return type might be wrong }

{$endif}
{ GLX_SGIX_hyperpipe  }
{ ---------------------------- GLX_SGIX_pbuffer ---------------------------  }
{$ifndef GLX_SGIX_pbuffer}

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

  PGLXBufferClobberEventSGIX = ^TGLXBufferClobberEventSGIX;
  TGLXBufferClobberEventSGIX = record
      _type : longint;
      serial : dword;
      send_event : TBool;
      display : PDisplay;
      drawable : TGLXDrawable;
      event_type : longint;
      draw_type : longint;
      mask : dword;
      x : longint;
      y : longint;
      width : longint;
      height : longint;
      count : longint;
    end;

  TPFNGLXCREATEGLXPBUFFERSGIXPROC = function (dpy:PDisplay; config:TGLXFBConfigSGIX; width:dword; height:dword; attrib_list:Plongint):TGLXPbufferSGIX;cdecl;

  TPFNGLXDESTROYGLXPBUFFERSGIXPROC = procedure (dpy:PDisplay; pbuf:TGLXPbufferSGIX);cdecl;

  TPFNGLXGETSELECTEDEVENTSGIXPROC = procedure (dpy:PDisplay; drawable:TGLXDrawable; mask:Pdword);cdecl;

  TPFNGLXQUERYGLXPBUFFERSGIXPROC = procedure (dpy:PDisplay; pbuf:TGLXPbufferSGIX; attribute:longint; value:Pdword);cdecl;

  TPFNGLXSELECTEVENTSGIXPROC = procedure (dpy:PDisplay; drawable:TGLXDrawable; mask:dword);cdecl;

{ was #define dname def_expr }
function glXCreateGLXPbufferSGIX : longint; { return type might be wrong }

{ was #define dname def_expr }
function glXDestroyGLXPbufferSGIX : longint; { return type might be wrong }

{ was #define dname def_expr }
function glXGetSelectedEventSGIX : longint; { return type might be wrong }

{ was #define dname def_expr }
function glXQueryGLXPbufferSGIX : longint; { return type might be wrong }

{ was #define dname def_expr }
function glXSelectEventSGIX : longint; { return type might be wrong }

{ was #define dname def_expr }
function GLXEW_SGIX_pbuffer : longint; { return type might be wrong }

{$endif}
{ GLX_SGIX_pbuffer  }
{ ------------------------- GLX_SGIX_swap_barrier -------------------------  }
{$ifndef GLX_SGIX_swap_barrier}

const
  GLX_SGIX_swap_barrier = 1;  
type

  TPFNGLXBINDSWAPBARRIERSGIXPROC = procedure (dpy:PDisplay; drawable:TGLXDrawable; barrier:longint);cdecl;

  TPFNGLXQUERYMAXSWAPBARRIERSSGIXPROC = function (dpy:PDisplay; screen:longint; max:Plongint):TBool;cdecl;

{ was #define dname def_expr }
function glXBindSwapBarrierSGIX : longint; { return type might be wrong }

{ was #define dname def_expr }
function glXQueryMaxSwapBarriersSGIX : longint; { return type might be wrong }

{ was #define dname def_expr }
function GLXEW_SGIX_swap_barrier : longint; { return type might be wrong }

{$endif}
{ GLX_SGIX_swap_barrier  }
{ -------------------------- GLX_SGIX_swap_group --------------------------  }
{$ifndef GLX_SGIX_swap_group}

const
  GLX_SGIX_swap_group = 1;  
type

  TPFNGLXJOINSWAPGROUPSGIXPROC = procedure (dpy:PDisplay; drawable:TGLXDrawable; member:TGLXDrawable);cdecl;

{ was #define dname def_expr }
function glXJoinSwapGroupSGIX : longint; { return type might be wrong }

{ was #define dname def_expr }
function GLXEW_SGIX_swap_group : longint; { return type might be wrong }

{$endif}
{ GLX_SGIX_swap_group  }
{ ------------------------- GLX_SGIX_video_resize -------------------------  }
{$ifndef GLX_SGIX_video_resize}

const
  GLX_SGIX_video_resize = 1;  
  GLX_SYNC_FRAME_SGIX = $00000000;  
  GLX_SYNC_SWAP_SGIX = $00000001;  
type

  TPFNGLXBINDCHANNELTOWINDOWSGIXPROC = function (display:PDisplay; screen:longint; channel:longint; window:TWindow):longint;cdecl;

  TPFNGLXCHANNELRECTSGIXPROC = function (display:PDisplay; screen:longint; channel:longint; x:longint; y:longint; 
               w:longint; h:longint):longint;cdecl;

  TPFNGLXCHANNELRECTSYNCSGIXPROC = function (display:PDisplay; screen:longint; channel:longint; synctype:TGLenum):longint;cdecl;

  TPFNGLXQUERYCHANNELDELTASSGIXPROC = function (display:PDisplay; screen:longint; channel:longint; x:Plongint; y:Plongint; 
               w:Plongint; h:Plongint):longint;cdecl;

  TPFNGLXQUERYCHANNELRECTSGIXPROC = function (display:PDisplay; screen:longint; channel:longint; dx:Plongint; dy:Plongint; 
               dw:Plongint; dh:Plongint):longint;cdecl;

{ was #define dname def_expr }
function glXBindChannelToWindowSGIX : longint; { return type might be wrong }

{ was #define dname def_expr }
function glXChannelRectSGIX : longint; { return type might be wrong }

{ was #define dname def_expr }
function glXChannelRectSyncSGIX : longint; { return type might be wrong }

{ was #define dname def_expr }
function glXQueryChannelDeltasSGIX : longint; { return type might be wrong }

{ was #define dname def_expr }
function glXQueryChannelRectSGIX : longint; { return type might be wrong }

{ was #define dname def_expr }
function GLXEW_SGIX_video_resize : longint; { return type might be wrong }

{$endif}
{ GLX_SGIX_video_resize  }
{ ---------------------- GLX_SGIX_visual_select_group ---------------------  }
{$ifndef GLX_SGIX_visual_select_group}

const
  GLX_SGIX_visual_select_group = 1;  
  GLX_VISUAL_SELECT_GROUP_SGIX = $8028;  

{ was #define dname def_expr }
function GLXEW_SGIX_visual_select_group : longint; { return type might be wrong }

{$endif}
{ GLX_SGIX_visual_select_group  }
{ ---------------------------- GLX_SGI_cushion ----------------------------  }
{$ifndef GLX_SGI_cushion}

const
  GLX_SGI_cushion = 1;  
type

  TPFNGLXCUSHIONSGIPROC = procedure (dpy:PDisplay; window:TWindow; cushion:single);cdecl;

{ was #define dname def_expr }
function glXCushionSGI : longint; { return type might be wrong }

{ was #define dname def_expr }
function GLXEW_SGI_cushion : longint; { return type might be wrong }

{$endif}
{ GLX_SGI_cushion  }
{ ----------------------- GLX_SGI_make_current_read -----------------------  }
{$ifndef GLX_SGI_make_current_read}

const
  GLX_SGI_make_current_read = 1;  
type

  TPFNGLXGETCURRENTREADDRAWABLESGIPROC = function (para1:pointer):TGLXDrawable;cdecl;

  TPFNGLXMAKECURRENTREADSGIPROC = function (dpy:PDisplay; draw:TGLXDrawable; read:TGLXDrawable; ctx:TGLXContext):TBool;cdecl;

{ was #define dname def_expr }
function glXGetCurrentReadDrawableSGI : longint; { return type might be wrong }

{ was #define dname def_expr }
function glXMakeCurrentReadSGI : longint; { return type might be wrong }

{ was #define dname def_expr }
function GLXEW_SGI_make_current_read : longint; { return type might be wrong }

{$endif}
{ GLX_SGI_make_current_read  }
{ -------------------------- GLX_SGI_swap_control -------------------------  }
{$ifndef GLX_SGI_swap_control}

const
  GLX_SGI_swap_control = 1;  
type

  TPFNGLXSWAPINTERVALSGIPROC = function (interval:longint):longint;cdecl;

{ was #define dname def_expr }
function glXSwapIntervalSGI : longint; { return type might be wrong }

{ was #define dname def_expr }
function GLXEW_SGI_swap_control : longint; { return type might be wrong }

{$endif}
{ GLX_SGI_swap_control  }
{ --------------------------- GLX_SGI_video_sync --------------------------  }
{$ifndef GLX_SGI_video_sync}

const
  GLX_SGI_video_sync = 1;  
type

  TPFNGLXGETVIDEOSYNCSGIPROC = function (count:Pdword):longint;cdecl;

  TPFNGLXWAITVIDEOSYNCSGIPROC = function (divisor:longint; remainder:longint; count:Pdword):longint;cdecl;

{ was #define dname def_expr }
function glXGetVideoSyncSGI : longint; { return type might be wrong }

{ was #define dname def_expr }
function glXWaitVideoSyncSGI : longint; { return type might be wrong }

{ was #define dname def_expr }
function GLXEW_SGI_video_sync : longint; { return type might be wrong }

{$endif}
{ GLX_SGI_video_sync  }
{ --------------------- GLX_SUN_get_transparent_index ---------------------  }
{$ifndef GLX_SUN_get_transparent_index}

const
  GLX_SUN_get_transparent_index = 1;  
type

  TPFNGLXGETTRANSPARENTINDEXSUNPROC = function (dpy:PDisplay; overlay:TWindow; underlay:TWindow; pTransparentIndex:Pdword):TStatus;cdecl;

{ was #define dname def_expr }
function glXGetTransparentIndexSUN : longint; { return type might be wrong }

{ was #define dname def_expr }
function GLXEW_SUN_get_transparent_index : longint; { return type might be wrong }

{$endif}
{ GLX_SUN_get_transparent_index  }
{ -------------------------- GLX_SUN_video_resize -------------------------  }
{$ifndef GLX_SUN_video_resize}

const
  GLX_SUN_video_resize = 1;  
  GLX_VIDEO_RESIZE_SUN = $8171;  
  GL_VIDEO_RESIZE_COMPENSATION_SUN = $85CD;  
type

  TPFNGLXGETVIDEORESIZESUNPROC = function (display:PDisplay; window:TGLXDrawable; factor:Psingle):longint;cdecl;

  TPFNGLXVIDEORESIZESUNPROC = function (display:PDisplay; window:TGLXDrawable; factor:single):longint;cdecl;

{ was #define dname def_expr }
function glXGetVideoResizeSUN : longint; { return type might be wrong }

{ was #define dname def_expr }
function glXVideoResizeSUN : longint; { return type might be wrong }

{ was #define dname def_expr }
function GLXEW_SUN_video_resize : longint; { return type might be wrong }

{$endif}
{ GLX_SUN_video_resize  }
{ -------------------------------------------------------------------------  }
{#define extern GLEW_FUN_EXPORT }
{#define extern GLEW_VAR_EXPORT }
  var
    __glewXGetCurrentDisplay : TPFNGLXGETCURRENTDISPLAYPROC;cvar;external;
    __glewXChooseFBConfig : TPFNGLXCHOOSEFBCONFIGPROC;cvar;external;
    __glewXCreateNewContext : TPFNGLXCREATENEWCONTEXTPROC;cvar;external;
    __glewXCreatePbuffer : TPFNGLXCREATEPBUFFERPROC;cvar;external;
    __glewXCreatePixmap : TPFNGLXCREATEPIXMAPPROC;cvar;external;
    __glewXCreateWindow : TPFNGLXCREATEWINDOWPROC;cvar;external;
    __glewXDestroyPbuffer : TPFNGLXDESTROYPBUFFERPROC;cvar;external;
    __glewXDestroyPixmap : TPFNGLXDESTROYPIXMAPPROC;cvar;external;
    __glewXDestroyWindow : TPFNGLXDESTROYWINDOWPROC;cvar;external;
    __glewXGetCurrentReadDrawable : TPFNGLXGETCURRENTREADDRAWABLEPROC;cvar;external;
    __glewXGetFBConfigAttrib : TPFNGLXGETFBCONFIGATTRIBPROC;cvar;external;
    __glewXGetFBConfigs : TPFNGLXGETFBCONFIGSPROC;cvar;external;
    __glewXGetSelectedEvent : TPFNGLXGETSELECTEDEVENTPROC;cvar;external;
    __glewXGetVisualFromFBConfig : TPFNGLXGETVISUALFROMFBCONFIGPROC;cvar;external;
    __glewXMakeContextCurrent : TPFNGLXMAKECONTEXTCURRENTPROC;cvar;external;
    __glewXQueryContext : TPFNGLXQUERYCONTEXTPROC;cvar;external;
    __glewXQueryDrawable : TPFNGLXQUERYDRAWABLEPROC;cvar;external;
    __glewXSelectEvent : TPFNGLXSELECTEVENTPROC;cvar;external;
    __glewXBlitContextFramebufferAMD : TPFNGLXBLITCONTEXTFRAMEBUFFERAMDPROC;cvar;external;
    __glewXCreateAssociatedContextAMD : TPFNGLXCREATEASSOCIATEDCONTEXTAMDPROC;cvar;external;
    __glewXCreateAssociatedContextAttribsAMD : TPFNGLXCREATEASSOCIATEDCONTEXTATTRIBSAMDPROC;cvar;external;
    __glewXDeleteAssociatedContextAMD : TPFNGLXDELETEASSOCIATEDCONTEXTAMDPROC;cvar;external;
    __glewXGetContextGPUIDAMD : TPFNGLXGETCONTEXTGPUIDAMDPROC;cvar;external;
    __glewXGetCurrentAssociatedContextAMD : TPFNGLXGETCURRENTASSOCIATEDCONTEXTAMDPROC;cvar;external;
    __glewXGetGPUIDsAMD : TPFNGLXGETGPUIDSAMDPROC;cvar;external;
    __glewXGetGPUInfoAMD : TPFNGLXGETGPUINFOAMDPROC;cvar;external;
    __glewXMakeAssociatedContextCurrentAMD : TPFNGLXMAKEASSOCIATEDCONTEXTCURRENTAMDPROC;cvar;external;
    __glewXCreateContextAttribsARB : TPFNGLXCREATECONTEXTATTRIBSARBPROC;cvar;external;
    __glewXBindTexImageATI : TPFNGLXBINDTEXIMAGEATIPROC;cvar;external;
    __glewXDrawableAttribATI : TPFNGLXDRAWABLEATTRIBATIPROC;cvar;external;
    __glewXReleaseTexImageATI : TPFNGLXRELEASETEXIMAGEATIPROC;cvar;external;
    __glewXFreeContextEXT : TPFNGLXFREECONTEXTEXTPROC;cvar;external;
    __glewXGetContextIDEXT : TPFNGLXGETCONTEXTIDEXTPROC;cvar;external;
    __glewXGetCurrentDisplayEXT : TPFNGLXGETCURRENTDISPLAYEXTPROC;cvar;external;
    __glewXImportContextEXT : TPFNGLXIMPORTCONTEXTEXTPROC;cvar;external;
    __glewXQueryContextInfoEXT : TPFNGLXQUERYCONTEXTINFOEXTPROC;cvar;external;
    __glewXSwapIntervalEXT : TPFNGLXSWAPINTERVALEXTPROC;cvar;external;
    __glewXBindTexImageEXT : TPFNGLXBINDTEXIMAGEEXTPROC;cvar;external;
    __glewXReleaseTexImageEXT : TPFNGLXRELEASETEXIMAGEEXTPROC;cvar;external;
    __glewXGetAGPOffsetMESA : TPFNGLXGETAGPOFFSETMESAPROC;cvar;external;
    __glewXCopySubBufferMESA : TPFNGLXCOPYSUBBUFFERMESAPROC;cvar;external;
    __glewXCreateGLXPixmapMESA : TPFNGLXCREATEGLXPIXMAPMESAPROC;cvar;external;
    __glewXQueryCurrentRendererIntegerMESA : TPFNGLXQUERYCURRENTRENDERERINTEGERMESAPROC;cvar;external;
    __glewXQueryCurrentRendererStringMESA : TPFNGLXQUERYCURRENTRENDERERSTRINGMESAPROC;cvar;external;
    __glewXQueryRendererIntegerMESA : TPFNGLXQUERYRENDERERINTEGERMESAPROC;cvar;external;
    __glewXQueryRendererStringMESA : TPFNGLXQUERYRENDERERSTRINGMESAPROC;cvar;external;
    __glewXReleaseBuffersMESA : TPFNGLXRELEASEBUFFERSMESAPROC;cvar;external;
    __glewXSet3DfxModeMESA : TPFNGLXSET3DFXMODEMESAPROC;cvar;external;
    __glewXGetSwapIntervalMESA : TPFNGLXGETSWAPINTERVALMESAPROC;cvar;external;
    __glewXSwapIntervalMESA : TPFNGLXSWAPINTERVALMESAPROC;cvar;external;
    __glewXCopyBufferSubDataNV : TPFNGLXCOPYBUFFERSUBDATANVPROC;cvar;external;
    __glewXNamedCopyBufferSubDataNV : TPFNGLXNAMEDCOPYBUFFERSUBDATANVPROC;cvar;external;
    __glewXCopyImageSubDataNV : TPFNGLXCOPYIMAGESUBDATANVPROC;cvar;external;
    __glewXDelayBeforeSwapNV : TPFNGLXDELAYBEFORESWAPNVPROC;cvar;external;
    __glewXBindVideoDeviceNV : TPFNGLXBINDVIDEODEVICENVPROC;cvar;external;
    __glewXEnumerateVideoDevicesNV : TPFNGLXENUMERATEVIDEODEVICESNVPROC;cvar;external;
    __glewXBindSwapBarrierNV : TPFNGLXBINDSWAPBARRIERNVPROC;cvar;external;
    __glewXJoinSwapGroupNV : TPFNGLXJOINSWAPGROUPNVPROC;cvar;external;
    __glewXQueryFrameCountNV : TPFNGLXQUERYFRAMECOUNTNVPROC;cvar;external;
    __glewXQueryMaxSwapGroupsNV : TPFNGLXQUERYMAXSWAPGROUPSNVPROC;cvar;external;
    __glewXQuerySwapGroupNV : TPFNGLXQUERYSWAPGROUPNVPROC;cvar;external;
    __glewXResetFrameCountNV : TPFNGLXRESETFRAMECOUNTNVPROC;cvar;external;
    __glewXAllocateMemoryNV : TPFNGLXALLOCATEMEMORYNVPROC;cvar;external;
    __glewXFreeMemoryNV : TPFNGLXFREEMEMORYNVPROC;cvar;external;
    __glewXBindVideoCaptureDeviceNV : TPFNGLXBINDVIDEOCAPTUREDEVICENVPROC;cvar;external;
    __glewXEnumerateVideoCaptureDevicesNV : TPFNGLXENUMERATEVIDEOCAPTUREDEVICESNVPROC;cvar;external;
    __glewXLockVideoCaptureDeviceNV : TPFNGLXLOCKVIDEOCAPTUREDEVICENVPROC;cvar;external;
    __glewXQueryVideoCaptureDeviceNV : TPFNGLXQUERYVIDEOCAPTUREDEVICENVPROC;cvar;external;
    __glewXReleaseVideoCaptureDeviceNV : TPFNGLXRELEASEVIDEOCAPTUREDEVICENVPROC;cvar;external;
    __glewXBindVideoImageNV : TPFNGLXBINDVIDEOIMAGENVPROC;cvar;external;
    __glewXGetVideoDeviceNV : TPFNGLXGETVIDEODEVICENVPROC;cvar;external;
    __glewXGetVideoInfoNV : TPFNGLXGETVIDEOINFONVPROC;cvar;external;
    __glewXReleaseVideoDeviceNV : TPFNGLXRELEASEVIDEODEVICENVPROC;cvar;external;
    __glewXReleaseVideoImageNV : TPFNGLXRELEASEVIDEOIMAGENVPROC;cvar;external;
    __glewXSendPbufferToVideoNV : TPFNGLXSENDPBUFFERTOVIDEONVPROC;cvar;external;
    __glewXGetMscRateOML : TPFNGLXGETMSCRATEOMLPROC;cvar;external;
    __glewXGetSyncValuesOML : TPFNGLXGETSYNCVALUESOMLPROC;cvar;external;
    __glewXSwapBuffersMscOML : TPFNGLXSWAPBUFFERSMSCOMLPROC;cvar;external;
    __glewXWaitForMscOML : TPFNGLXWAITFORMSCOMLPROC;cvar;external;
    __glewXWaitForSbcOML : TPFNGLXWAITFORSBCOMLPROC;cvar;external;
    __glewXChooseFBConfigSGIX : TPFNGLXCHOOSEFBCONFIGSGIXPROC;cvar;external;
    __glewXCreateContextWithConfigSGIX : TPFNGLXCREATECONTEXTWITHCONFIGSGIXPROC;cvar;external;
    __glewXCreateGLXPixmapWithConfigSGIX : TPFNGLXCREATEGLXPIXMAPWITHCONFIGSGIXPROC;cvar;external;
    __glewXGetFBConfigAttribSGIX : TPFNGLXGETFBCONFIGATTRIBSGIXPROC;cvar;external;
    __glewXGetFBConfigFromVisualSGIX : TPFNGLXGETFBCONFIGFROMVISUALSGIXPROC;cvar;external;
    __glewXGetVisualFromFBConfigSGIX : TPFNGLXGETVISUALFROMFBCONFIGSGIXPROC;cvar;external;
    __glewXBindHyperpipeSGIX : TPFNGLXBINDHYPERPIPESGIXPROC;cvar;external;
    __glewXDestroyHyperpipeConfigSGIX : TPFNGLXDESTROYHYPERPIPECONFIGSGIXPROC;cvar;external;
    __glewXHyperpipeAttribSGIX : TPFNGLXHYPERPIPEATTRIBSGIXPROC;cvar;external;
    __glewXHyperpipeConfigSGIX : TPFNGLXHYPERPIPECONFIGSGIXPROC;cvar;external;
    __glewXQueryHyperpipeAttribSGIX : TPFNGLXQUERYHYPERPIPEATTRIBSGIXPROC;cvar;external;
    __glewXQueryHyperpipeBestAttribSGIX : TPFNGLXQUERYHYPERPIPEBESTATTRIBSGIXPROC;cvar;external;
    __glewXQueryHyperpipeConfigSGIX : TPFNGLXQUERYHYPERPIPECONFIGSGIXPROC;cvar;external;
    __glewXQueryHyperpipeNetworkSGIX : TPFNGLXQUERYHYPERPIPENETWORKSGIXPROC;cvar;external;
    __glewXCreateGLXPbufferSGIX : TPFNGLXCREATEGLXPBUFFERSGIXPROC;cvar;external;
    __glewXDestroyGLXPbufferSGIX : TPFNGLXDESTROYGLXPBUFFERSGIXPROC;cvar;external;
    __glewXGetSelectedEventSGIX : TPFNGLXGETSELECTEDEVENTSGIXPROC;cvar;external;
    __glewXQueryGLXPbufferSGIX : TPFNGLXQUERYGLXPBUFFERSGIXPROC;cvar;external;
    __glewXSelectEventSGIX : TPFNGLXSELECTEVENTSGIXPROC;cvar;external;
    __glewXBindSwapBarrierSGIX : TPFNGLXBINDSWAPBARRIERSGIXPROC;cvar;external;
    __glewXQueryMaxSwapBarriersSGIX : TPFNGLXQUERYMAXSWAPBARRIERSSGIXPROC;cvar;external;
    __glewXJoinSwapGroupSGIX : TPFNGLXJOINSWAPGROUPSGIXPROC;cvar;external;
    __glewXBindChannelToWindowSGIX : TPFNGLXBINDCHANNELTOWINDOWSGIXPROC;cvar;external;
    __glewXChannelRectSGIX : TPFNGLXCHANNELRECTSGIXPROC;cvar;external;
    __glewXChannelRectSyncSGIX : TPFNGLXCHANNELRECTSYNCSGIXPROC;cvar;external;
    __glewXQueryChannelDeltasSGIX : TPFNGLXQUERYCHANNELDELTASSGIXPROC;cvar;external;
    __glewXQueryChannelRectSGIX : TPFNGLXQUERYCHANNELRECTSGIXPROC;cvar;external;
    __glewXCushionSGI : TPFNGLXCUSHIONSGIPROC;cvar;external;
    __glewXGetCurrentReadDrawableSGI : TPFNGLXGETCURRENTREADDRAWABLESGIPROC;cvar;external;
    __glewXMakeCurrentReadSGI : TPFNGLXMAKECURRENTREADSGIPROC;cvar;external;
    __glewXSwapIntervalSGI : TPFNGLXSWAPINTERVALSGIPROC;cvar;external;
    __glewXGetVideoSyncSGI : TPFNGLXGETVIDEOSYNCSGIPROC;cvar;external;
    __glewXWaitVideoSyncSGI : TPFNGLXWAITVIDEOSYNCSGIPROC;cvar;external;
    __glewXGetTransparentIndexSUN : TPFNGLXGETTRANSPARENTINDEXSUNPROC;cvar;external;
    __glewXGetVideoResizeSUN : TPFNGLXGETVIDEORESIZESUNPROC;cvar;external;
    __glewXVideoResizeSUN : TPFNGLXVIDEORESIZESUNPROC;cvar;external;
    __GLXEW_VERSION_1_0 : TGLboolean;cvar;external;
    __GLXEW_VERSION_1_1 : TGLboolean;cvar;external;
    __GLXEW_VERSION_1_2 : TGLboolean;cvar;external;
    __GLXEW_VERSION_1_3 : TGLboolean;cvar;external;
    __GLXEW_VERSION_1_4 : TGLboolean;cvar;external;
    __GLXEW_3DFX_multisample : TGLboolean;cvar;external;
    __GLXEW_AMD_gpu_association : TGLboolean;cvar;external;
    __GLXEW_ARB_context_flush_control : TGLboolean;cvar;external;
    __GLXEW_ARB_create_context : TGLboolean;cvar;external;
    __GLXEW_ARB_create_context_no_error : TGLboolean;cvar;external;
    __GLXEW_ARB_create_context_profile : TGLboolean;cvar;external;
    __GLXEW_ARB_create_context_robustness : TGLboolean;cvar;external;
    __GLXEW_ARB_fbconfig_float : TGLboolean;cvar;external;
    __GLXEW_ARB_framebuffer_sRGB : TGLboolean;cvar;external;
    __GLXEW_ARB_get_proc_address : TGLboolean;cvar;external;
    __GLXEW_ARB_multisample : TGLboolean;cvar;external;
    __GLXEW_ARB_robustness_application_isolation : TGLboolean;cvar;external;
    __GLXEW_ARB_robustness_share_group_isolation : TGLboolean;cvar;external;
    __GLXEW_ARB_vertex_buffer_object : TGLboolean;cvar;external;
    __GLXEW_ATI_pixel_format_float : TGLboolean;cvar;external;
    __GLXEW_ATI_render_texture : TGLboolean;cvar;external;
    __GLXEW_EXT_buffer_age : TGLboolean;cvar;external;
    __GLXEW_EXT_context_priority : TGLboolean;cvar;external;
    __GLXEW_EXT_create_context_es2_profile : TGLboolean;cvar;external;
    __GLXEW_EXT_create_context_es_profile : TGLboolean;cvar;external;
    __GLXEW_EXT_fbconfig_packed_float : TGLboolean;cvar;external;
    __GLXEW_EXT_framebuffer_sRGB : TGLboolean;cvar;external;
    __GLXEW_EXT_import_context : TGLboolean;cvar;external;
    __GLXEW_EXT_libglvnd : TGLboolean;cvar;external;
    __GLXEW_EXT_no_config_context : TGLboolean;cvar;external;
    __GLXEW_EXT_scene_marker : TGLboolean;cvar;external;
    __GLXEW_EXT_stereo_tree : TGLboolean;cvar;external;
    __GLXEW_EXT_swap_control : TGLboolean;cvar;external;
    __GLXEW_EXT_swap_control_tear : TGLboolean;cvar;external;
    __GLXEW_EXT_texture_from_pixmap : TGLboolean;cvar;external;
    __GLXEW_EXT_visual_info : TGLboolean;cvar;external;
    __GLXEW_EXT_visual_rating : TGLboolean;cvar;external;
    __GLXEW_INTEL_swap_event : TGLboolean;cvar;external;
    __GLXEW_MESA_agp_offset : TGLboolean;cvar;external;
    __GLXEW_MESA_copy_sub_buffer : TGLboolean;cvar;external;
    __GLXEW_MESA_pixmap_colormap : TGLboolean;cvar;external;
    __GLXEW_MESA_query_renderer : TGLboolean;cvar;external;
    __GLXEW_MESA_release_buffers : TGLboolean;cvar;external;
    __GLXEW_MESA_set_3dfx_mode : TGLboolean;cvar;external;
    __GLXEW_MESA_swap_control : TGLboolean;cvar;external;
    __GLXEW_NV_copy_buffer : TGLboolean;cvar;external;
    __GLXEW_NV_copy_image : TGLboolean;cvar;external;
    __GLXEW_NV_delay_before_swap : TGLboolean;cvar;external;
    __GLXEW_NV_float_buffer : TGLboolean;cvar;external;
    __GLXEW_NV_multigpu_context : TGLboolean;cvar;external;
    __GLXEW_NV_multisample_coverage : TGLboolean;cvar;external;
    __GLXEW_NV_present_video : TGLboolean;cvar;external;
    __GLXEW_NV_robustness_video_memory_purge : TGLboolean;cvar;external;
    __GLXEW_NV_swap_group : TGLboolean;cvar;external;
    __GLXEW_NV_vertex_array_range : TGLboolean;cvar;external;
    __GLXEW_NV_video_capture : TGLboolean;cvar;external;
    __GLXEW_NV_video_out : TGLboolean;cvar;external;
    __GLXEW_OML_swap_method : TGLboolean;cvar;external;
    __GLXEW_OML_sync_control : TGLboolean;cvar;external;
    __GLXEW_SGIS_blended_overlay : TGLboolean;cvar;external;
    __GLXEW_SGIS_color_range : TGLboolean;cvar;external;
    __GLXEW_SGIS_multisample : TGLboolean;cvar;external;
    __GLXEW_SGIS_shared_multisample : TGLboolean;cvar;external;
    __GLXEW_SGIX_fbconfig : TGLboolean;cvar;external;
    __GLXEW_SGIX_hyperpipe : TGLboolean;cvar;external;
    __GLXEW_SGIX_pbuffer : TGLboolean;cvar;external;
    __GLXEW_SGIX_swap_barrier : TGLboolean;cvar;external;
    __GLXEW_SGIX_swap_group : TGLboolean;cvar;external;
    __GLXEW_SGIX_video_resize : TGLboolean;cvar;external;
    __GLXEW_SGIX_visual_select_group : TGLboolean;cvar;external;
    __GLXEW_SGI_cushion : TGLboolean;cvar;external;
    __GLXEW_SGI_make_current_read : TGLboolean;cvar;external;
    __GLXEW_SGI_swap_control : TGLboolean;cvar;external;
    __GLXEW_SGI_video_sync : TGLboolean;cvar;external;
    __GLXEW_SUN_get_transparent_index : TGLboolean;cvar;external;
    __GLXEW_SUN_video_resize : TGLboolean;cvar;external;
{ ------------------------------------------------------------------------  }

function glxewInit:TGLenum;cdecl;external;
(* Const before type ignored *)
function glxewIsSupported(name:Pchar):TGLboolean;cdecl;external;
{#ifndef GLXEW_GET_VAR }
{#define GLXEW_GET_VAR(x) (*(const GLboolean*)&x) }
{#endif }
{/fndef GLXEW_GET_FUN }
{#define GLXEW_GET_FUN(x) x }
{#endif }
(* Const before type ignored *)
function glxewGetExtension(name:Pchar):TGLboolean;cdecl;external;
{ C++ end of extern C conditionnal removed }
{$endif}
{ __glxew_h__  }

implementation

{ was #define dname def_expr }
function GLXEW_VERSION_1_0 : longint; { return type might be wrong }
  begin
    GLXEW_VERSION_1_0:=GLXEW_GET_VAR(__GLXEW_VERSION_1_0);
  end;

{ was #define dname def_expr }
function GLXEW_VERSION_1_1 : longint; { return type might be wrong }
  begin
    GLXEW_VERSION_1_1:=GLXEW_GET_VAR(__GLXEW_VERSION_1_1);
  end;

{ was #define dname def_expr }
function glXGetCurrentDisplay : longint; { return type might be wrong }
  begin
    glXGetCurrentDisplay:=GLXEW_GET_FUN(__glewXGetCurrentDisplay);
  end;

{ was #define dname def_expr }
function GLXEW_VERSION_1_2 : longint; { return type might be wrong }
  begin
    GLXEW_VERSION_1_2:=GLXEW_GET_VAR(__GLXEW_VERSION_1_2);
  end;

{ was #define dname def_expr }
function glXChooseFBConfig : longint; { return type might be wrong }
  begin
    glXChooseFBConfig:=GLXEW_GET_FUN(__glewXChooseFBConfig);
  end;

{ was #define dname def_expr }
function glXCreateNewContext : longint; { return type might be wrong }
  begin
    glXCreateNewContext:=GLXEW_GET_FUN(__glewXCreateNewContext);
  end;

{ was #define dname def_expr }
function glXCreatePbuffer : longint; { return type might be wrong }
  begin
    glXCreatePbuffer:=GLXEW_GET_FUN(__glewXCreatePbuffer);
  end;

{ was #define dname def_expr }
function glXCreatePixmap : longint; { return type might be wrong }
  begin
    glXCreatePixmap:=GLXEW_GET_FUN(__glewXCreatePixmap);
  end;

{ was #define dname def_expr }
function glXCreateWindow : longint; { return type might be wrong }
  begin
    glXCreateWindow:=GLXEW_GET_FUN(__glewXCreateWindow);
  end;

{ was #define dname def_expr }
function glXDestroyPbuffer : longint; { return type might be wrong }
  begin
    glXDestroyPbuffer:=GLXEW_GET_FUN(__glewXDestroyPbuffer);
  end;

{ was #define dname def_expr }
function glXDestroyPixmap : longint; { return type might be wrong }
  begin
    glXDestroyPixmap:=GLXEW_GET_FUN(__glewXDestroyPixmap);
  end;

{ was #define dname def_expr }
function glXDestroyWindow : longint; { return type might be wrong }
  begin
    glXDestroyWindow:=GLXEW_GET_FUN(__glewXDestroyWindow);
  end;

{ was #define dname def_expr }
function glXGetCurrentReadDrawable : longint; { return type might be wrong }
  begin
    glXGetCurrentReadDrawable:=GLXEW_GET_FUN(__glewXGetCurrentReadDrawable);
  end;

{ was #define dname def_expr }
function glXGetFBConfigAttrib : longint; { return type might be wrong }
  begin
    glXGetFBConfigAttrib:=GLXEW_GET_FUN(__glewXGetFBConfigAttrib);
  end;

{ was #define dname def_expr }
function glXGetFBConfigs : longint; { return type might be wrong }
  begin
    glXGetFBConfigs:=GLXEW_GET_FUN(__glewXGetFBConfigs);
  end;

{ was #define dname def_expr }
function glXGetSelectedEvent : longint; { return type might be wrong }
  begin
    glXGetSelectedEvent:=GLXEW_GET_FUN(__glewXGetSelectedEvent);
  end;

{ was #define dname def_expr }
function glXGetVisualFromFBConfig : longint; { return type might be wrong }
  begin
    glXGetVisualFromFBConfig:=GLXEW_GET_FUN(__glewXGetVisualFromFBConfig);
  end;

{ was #define dname def_expr }
function glXMakeContextCurrent : longint; { return type might be wrong }
  begin
    glXMakeContextCurrent:=GLXEW_GET_FUN(__glewXMakeContextCurrent);
  end;

{ was #define dname def_expr }
function glXQueryContext : longint; { return type might be wrong }
  begin
    glXQueryContext:=GLXEW_GET_FUN(__glewXQueryContext);
  end;

{ was #define dname def_expr }
function glXQueryDrawable : longint; { return type might be wrong }
  begin
    glXQueryDrawable:=GLXEW_GET_FUN(__glewXQueryDrawable);
  end;

{ was #define dname def_expr }
function glXSelectEvent : longint; { return type might be wrong }
  begin
    glXSelectEvent:=GLXEW_GET_FUN(__glewXSelectEvent);
  end;

{ was #define dname def_expr }
function GLXEW_VERSION_1_3 : longint; { return type might be wrong }
  begin
    GLXEW_VERSION_1_3:=GLXEW_GET_VAR(__GLXEW_VERSION_1_3);
  end;

{ was #define dname def_expr }
function GLXEW_VERSION_1_4 : longint; { return type might be wrong }
  begin
    GLXEW_VERSION_1_4:=GLXEW_GET_VAR(__GLXEW_VERSION_1_4);
  end;

{ was #define dname def_expr }
function GLXEW_3DFX_multisample : longint; { return type might be wrong }
  begin
    GLXEW_3DFX_multisample:=GLXEW_GET_VAR(__GLXEW_3DFX_multisample);
  end;

{ was #define dname def_expr }
function glXBlitContextFramebufferAMD : longint; { return type might be wrong }
  begin
    glXBlitContextFramebufferAMD:=GLXEW_GET_FUN(__glewXBlitContextFramebufferAMD);
  end;

{ was #define dname def_expr }
function glXCreateAssociatedContextAMD : longint; { return type might be wrong }
  begin
    glXCreateAssociatedContextAMD:=GLXEW_GET_FUN(__glewXCreateAssociatedContextAMD);
  end;

{ was #define dname def_expr }
function glXCreateAssociatedContextAttribsAMD : longint; { return type might be wrong }
  begin
    glXCreateAssociatedContextAttribsAMD:=GLXEW_GET_FUN(__glewXCreateAssociatedContextAttribsAMD);
  end;

{ was #define dname def_expr }
function glXDeleteAssociatedContextAMD : longint; { return type might be wrong }
  begin
    glXDeleteAssociatedContextAMD:=GLXEW_GET_FUN(__glewXDeleteAssociatedContextAMD);
  end;

{ was #define dname def_expr }
function glXGetContextGPUIDAMD : longint; { return type might be wrong }
  begin
    glXGetContextGPUIDAMD:=GLXEW_GET_FUN(__glewXGetContextGPUIDAMD);
  end;

{ was #define dname def_expr }
function glXGetCurrentAssociatedContextAMD : longint; { return type might be wrong }
  begin
    glXGetCurrentAssociatedContextAMD:=GLXEW_GET_FUN(__glewXGetCurrentAssociatedContextAMD);
  end;

{ was #define dname def_expr }
function glXGetGPUIDsAMD : longint; { return type might be wrong }
  begin
    glXGetGPUIDsAMD:=GLXEW_GET_FUN(__glewXGetGPUIDsAMD);
  end;

{ was #define dname def_expr }
function glXGetGPUInfoAMD : longint; { return type might be wrong }
  begin
    glXGetGPUInfoAMD:=GLXEW_GET_FUN(__glewXGetGPUInfoAMD);
  end;

{ was #define dname def_expr }
function glXMakeAssociatedContextCurrentAMD : longint; { return type might be wrong }
  begin
    glXMakeAssociatedContextCurrentAMD:=GLXEW_GET_FUN(__glewXMakeAssociatedContextCurrentAMD);
  end;

{ was #define dname def_expr }
function GLXEW_AMD_gpu_association : longint; { return type might be wrong }
  begin
    GLXEW_AMD_gpu_association:=GLXEW_GET_VAR(__GLXEW_AMD_gpu_association);
  end;

{ was #define dname def_expr }
function GLXEW_ARB_context_flush_control : longint; { return type might be wrong }
  begin
    GLXEW_ARB_context_flush_control:=GLXEW_GET_VAR(__GLXEW_ARB_context_flush_control);
  end;

{ was #define dname def_expr }
function glXCreateContextAttribsARB : longint; { return type might be wrong }
  begin
    glXCreateContextAttribsARB:=GLXEW_GET_FUN(__glewXCreateContextAttribsARB);
  end;

{ was #define dname def_expr }
function GLXEW_ARB_create_context : longint; { return type might be wrong }
  begin
    GLXEW_ARB_create_context:=GLXEW_GET_VAR(__GLXEW_ARB_create_context);
  end;

{ was #define dname def_expr }
function GLXEW_ARB_create_context_no_error : longint; { return type might be wrong }
  begin
    GLXEW_ARB_create_context_no_error:=GLXEW_GET_VAR(__GLXEW_ARB_create_context_no_error);
  end;

{ was #define dname def_expr }
function GLXEW_ARB_create_context_profile : longint; { return type might be wrong }
  begin
    GLXEW_ARB_create_context_profile:=GLXEW_GET_VAR(__GLXEW_ARB_create_context_profile);
  end;

{ was #define dname def_expr }
function GLXEW_ARB_create_context_robustness : longint; { return type might be wrong }
  begin
    GLXEW_ARB_create_context_robustness:=GLXEW_GET_VAR(__GLXEW_ARB_create_context_robustness);
  end;

{ was #define dname def_expr }
function GLXEW_ARB_fbconfig_float : longint; { return type might be wrong }
  begin
    GLXEW_ARB_fbconfig_float:=GLXEW_GET_VAR(__GLXEW_ARB_fbconfig_float);
  end;

{ was #define dname def_expr }
function GLXEW_ARB_framebuffer_sRGB : longint; { return type might be wrong }
  begin
    GLXEW_ARB_framebuffer_sRGB:=GLXEW_GET_VAR(__GLXEW_ARB_framebuffer_sRGB);
  end;

{ was #define dname def_expr }
function GLXEW_ARB_get_proc_address : longint; { return type might be wrong }
  begin
    GLXEW_ARB_get_proc_address:=GLXEW_GET_VAR(__GLXEW_ARB_get_proc_address);
  end;

{ was #define dname def_expr }
function GLXEW_ARB_multisample : longint; { return type might be wrong }
  begin
    GLXEW_ARB_multisample:=GLXEW_GET_VAR(__GLXEW_ARB_multisample);
  end;

{ was #define dname def_expr }
function GLXEW_ARB_robustness_application_isolation : longint; { return type might be wrong }
  begin
    GLXEW_ARB_robustness_application_isolation:=GLXEW_GET_VAR(__GLXEW_ARB_robustness_application_isolation);
  end;

{ was #define dname def_expr }
function GLXEW_ARB_robustness_share_group_isolation : longint; { return type might be wrong }
  begin
    GLXEW_ARB_robustness_share_group_isolation:=GLXEW_GET_VAR(__GLXEW_ARB_robustness_share_group_isolation);
  end;

{ was #define dname def_expr }
function GLXEW_ARB_vertex_buffer_object : longint; { return type might be wrong }
  begin
    GLXEW_ARB_vertex_buffer_object:=GLXEW_GET_VAR(__GLXEW_ARB_vertex_buffer_object);
  end;

{ was #define dname def_expr }
function GLXEW_ATI_pixel_format_float : longint; { return type might be wrong }
  begin
    GLXEW_ATI_pixel_format_float:=GLXEW_GET_VAR(__GLXEW_ATI_pixel_format_float);
  end;

{ was #define dname def_expr }
function glXBindTexImageATI : longint; { return type might be wrong }
  begin
    glXBindTexImageATI:=GLXEW_GET_FUN(__glewXBindTexImageATI);
  end;

{ was #define dname def_expr }
function glXDrawableAttribATI : longint; { return type might be wrong }
  begin
    glXDrawableAttribATI:=GLXEW_GET_FUN(__glewXDrawableAttribATI);
  end;

{ was #define dname def_expr }
function glXReleaseTexImageATI : longint; { return type might be wrong }
  begin
    glXReleaseTexImageATI:=GLXEW_GET_FUN(__glewXReleaseTexImageATI);
  end;

{ was #define dname def_expr }
function GLXEW_ATI_render_texture : longint; { return type might be wrong }
  begin
    GLXEW_ATI_render_texture:=GLXEW_GET_VAR(__GLXEW_ATI_render_texture);
  end;

{ was #define dname def_expr }
function GLXEW_EXT_buffer_age : longint; { return type might be wrong }
  begin
    GLXEW_EXT_buffer_age:=GLXEW_GET_VAR(__GLXEW_EXT_buffer_age);
  end;

{ was #define dname def_expr }
function GLXEW_EXT_context_priority : longint; { return type might be wrong }
  begin
    GLXEW_EXT_context_priority:=GLXEW_GET_VAR(__GLXEW_EXT_context_priority);
  end;

{ was #define dname def_expr }
function GLXEW_EXT_create_context_es2_profile : longint; { return type might be wrong }
  begin
    GLXEW_EXT_create_context_es2_profile:=GLXEW_GET_VAR(__GLXEW_EXT_create_context_es2_profile);
  end;

{ was #define dname def_expr }
function GLXEW_EXT_create_context_es_profile : longint; { return type might be wrong }
  begin
    GLXEW_EXT_create_context_es_profile:=GLXEW_GET_VAR(__GLXEW_EXT_create_context_es_profile);
  end;

{ was #define dname def_expr }
function GLXEW_EXT_fbconfig_packed_float : longint; { return type might be wrong }
  begin
    GLXEW_EXT_fbconfig_packed_float:=GLXEW_GET_VAR(__GLXEW_EXT_fbconfig_packed_float);
  end;

{ was #define dname def_expr }
function GLXEW_EXT_framebuffer_sRGB : longint; { return type might be wrong }
  begin
    GLXEW_EXT_framebuffer_sRGB:=GLXEW_GET_VAR(__GLXEW_EXT_framebuffer_sRGB);
  end;

{ was #define dname def_expr }
function glXFreeContextEXT : longint; { return type might be wrong }
  begin
    glXFreeContextEXT:=GLXEW_GET_FUN(__glewXFreeContextEXT);
  end;

{ was #define dname def_expr }
function glXGetContextIDEXT : longint; { return type might be wrong }
  begin
    glXGetContextIDEXT:=GLXEW_GET_FUN(__glewXGetContextIDEXT);
  end;

{ was #define dname def_expr }
function glXGetCurrentDisplayEXT : longint; { return type might be wrong }
  begin
    glXGetCurrentDisplayEXT:=GLXEW_GET_FUN(__glewXGetCurrentDisplayEXT);
  end;

{ was #define dname def_expr }
function glXImportContextEXT : longint; { return type might be wrong }
  begin
    glXImportContextEXT:=GLXEW_GET_FUN(__glewXImportContextEXT);
  end;

{ was #define dname def_expr }
function glXQueryContextInfoEXT : longint; { return type might be wrong }
  begin
    glXQueryContextInfoEXT:=GLXEW_GET_FUN(__glewXQueryContextInfoEXT);
  end;

{ was #define dname def_expr }
function GLXEW_EXT_import_context : longint; { return type might be wrong }
  begin
    GLXEW_EXT_import_context:=GLXEW_GET_VAR(__GLXEW_EXT_import_context);
  end;

{ was #define dname def_expr }
function GLXEW_EXT_libglvnd : longint; { return type might be wrong }
  begin
    GLXEW_EXT_libglvnd:=GLXEW_GET_VAR(__GLXEW_EXT_libglvnd);
  end;

{ was #define dname def_expr }
function GLXEW_EXT_no_config_context : longint; { return type might be wrong }
  begin
    GLXEW_EXT_no_config_context:=GLXEW_GET_VAR(__GLXEW_EXT_no_config_context);
  end;

{ was #define dname def_expr }
function GLXEW_EXT_scene_marker : longint; { return type might be wrong }
  begin
    GLXEW_EXT_scene_marker:=GLXEW_GET_VAR(__GLXEW_EXT_scene_marker);
  end;

{ was #define dname def_expr }
function GLXEW_EXT_stereo_tree : longint; { return type might be wrong }
  begin
    GLXEW_EXT_stereo_tree:=GLXEW_GET_VAR(__GLXEW_EXT_stereo_tree);
  end;

{ was #define dname def_expr }
function glXSwapIntervalEXT : longint; { return type might be wrong }
  begin
    glXSwapIntervalEXT:=GLXEW_GET_FUN(__glewXSwapIntervalEXT);
  end;

{ was #define dname def_expr }
function GLXEW_EXT_swap_control : longint; { return type might be wrong }
  begin
    GLXEW_EXT_swap_control:=GLXEW_GET_VAR(__GLXEW_EXT_swap_control);
  end;

{ was #define dname def_expr }
function GLXEW_EXT_swap_control_tear : longint; { return type might be wrong }
  begin
    GLXEW_EXT_swap_control_tear:=GLXEW_GET_VAR(__GLXEW_EXT_swap_control_tear);
  end;

{ was #define dname def_expr }
function glXBindTexImageEXT : longint; { return type might be wrong }
  begin
    glXBindTexImageEXT:=GLXEW_GET_FUN(__glewXBindTexImageEXT);
  end;

{ was #define dname def_expr }
function glXReleaseTexImageEXT : longint; { return type might be wrong }
  begin
    glXReleaseTexImageEXT:=GLXEW_GET_FUN(__glewXReleaseTexImageEXT);
  end;

{ was #define dname def_expr }
function GLXEW_EXT_texture_from_pixmap : longint; { return type might be wrong }
  begin
    GLXEW_EXT_texture_from_pixmap:=GLXEW_GET_VAR(__GLXEW_EXT_texture_from_pixmap);
  end;

{ was #define dname def_expr }
function GLXEW_EXT_visual_info : longint; { return type might be wrong }
  begin
    GLXEW_EXT_visual_info:=GLXEW_GET_VAR(__GLXEW_EXT_visual_info);
  end;

{ was #define dname def_expr }
function GLXEW_EXT_visual_rating : longint; { return type might be wrong }
  begin
    GLXEW_EXT_visual_rating:=GLXEW_GET_VAR(__GLXEW_EXT_visual_rating);
  end;

{ was #define dname def_expr }
function GLXEW_INTEL_swap_event : longint; { return type might be wrong }
  begin
    GLXEW_INTEL_swap_event:=GLXEW_GET_VAR(__GLXEW_INTEL_swap_event);
  end;

{ was #define dname def_expr }
function glXGetAGPOffsetMESA : longint; { return type might be wrong }
  begin
    glXGetAGPOffsetMESA:=GLXEW_GET_FUN(__glewXGetAGPOffsetMESA);
  end;

{ was #define dname def_expr }
function GLXEW_MESA_agp_offset : longint; { return type might be wrong }
  begin
    GLXEW_MESA_agp_offset:=GLXEW_GET_VAR(__GLXEW_MESA_agp_offset);
  end;

{ was #define dname def_expr }
function glXCopySubBufferMESA : longint; { return type might be wrong }
  begin
    glXCopySubBufferMESA:=GLXEW_GET_FUN(__glewXCopySubBufferMESA);
  end;

{ was #define dname def_expr }
function GLXEW_MESA_copy_sub_buffer : longint; { return type might be wrong }
  begin
    GLXEW_MESA_copy_sub_buffer:=GLXEW_GET_VAR(__GLXEW_MESA_copy_sub_buffer);
  end;

{ was #define dname def_expr }
function glXCreateGLXPixmapMESA : longint; { return type might be wrong }
  begin
    glXCreateGLXPixmapMESA:=GLXEW_GET_FUN(__glewXCreateGLXPixmapMESA);
  end;

{ was #define dname def_expr }
function GLXEW_MESA_pixmap_colormap : longint; { return type might be wrong }
  begin
    GLXEW_MESA_pixmap_colormap:=GLXEW_GET_VAR(__GLXEW_MESA_pixmap_colormap);
  end;

{ was #define dname def_expr }
function glXQueryCurrentRendererIntegerMESA : longint; { return type might be wrong }
  begin
    glXQueryCurrentRendererIntegerMESA:=GLXEW_GET_FUN(__glewXQueryCurrentRendererIntegerMESA);
  end;

{ was #define dname def_expr }
function glXQueryCurrentRendererStringMESA : longint; { return type might be wrong }
  begin
    glXQueryCurrentRendererStringMESA:=GLXEW_GET_FUN(__glewXQueryCurrentRendererStringMESA);
  end;

{ was #define dname def_expr }
function glXQueryRendererIntegerMESA : longint; { return type might be wrong }
  begin
    glXQueryRendererIntegerMESA:=GLXEW_GET_FUN(__glewXQueryRendererIntegerMESA);
  end;

{ was #define dname def_expr }
function glXQueryRendererStringMESA : longint; { return type might be wrong }
  begin
    glXQueryRendererStringMESA:=GLXEW_GET_FUN(__glewXQueryRendererStringMESA);
  end;

{ was #define dname def_expr }
function GLXEW_MESA_query_renderer : longint; { return type might be wrong }
  begin
    GLXEW_MESA_query_renderer:=GLXEW_GET_VAR(__GLXEW_MESA_query_renderer);
  end;

{ was #define dname def_expr }
function glXReleaseBuffersMESA : longint; { return type might be wrong }
  begin
    glXReleaseBuffersMESA:=GLXEW_GET_FUN(__glewXReleaseBuffersMESA);
  end;

{ was #define dname def_expr }
function GLXEW_MESA_release_buffers : longint; { return type might be wrong }
  begin
    GLXEW_MESA_release_buffers:=GLXEW_GET_VAR(__GLXEW_MESA_release_buffers);
  end;

{ was #define dname def_expr }
function glXSet3DfxModeMESA : longint; { return type might be wrong }
  begin
    glXSet3DfxModeMESA:=GLXEW_GET_FUN(__glewXSet3DfxModeMESA);
  end;

{ was #define dname def_expr }
function GLXEW_MESA_set_3dfx_mode : longint; { return type might be wrong }
  begin
    GLXEW_MESA_set_3dfx_mode:=GLXEW_GET_VAR(__GLXEW_MESA_set_3dfx_mode);
  end;

{ was #define dname def_expr }
function glXGetSwapIntervalMESA : longint; { return type might be wrong }
  begin
    glXGetSwapIntervalMESA:=GLXEW_GET_FUN(__glewXGetSwapIntervalMESA);
  end;

{ was #define dname def_expr }
function glXSwapIntervalMESA : longint; { return type might be wrong }
  begin
    glXSwapIntervalMESA:=GLXEW_GET_FUN(__glewXSwapIntervalMESA);
  end;

{ was #define dname def_expr }
function GLXEW_MESA_swap_control : longint; { return type might be wrong }
  begin
    GLXEW_MESA_swap_control:=GLXEW_GET_VAR(__GLXEW_MESA_swap_control);
  end;

{ was #define dname def_expr }
function glXCopyBufferSubDataNV : longint; { return type might be wrong }
  begin
    glXCopyBufferSubDataNV:=GLXEW_GET_FUN(__glewXCopyBufferSubDataNV);
  end;

{ was #define dname def_expr }
function glXNamedCopyBufferSubDataNV : longint; { return type might be wrong }
  begin
    glXNamedCopyBufferSubDataNV:=GLXEW_GET_FUN(__glewXNamedCopyBufferSubDataNV);
  end;

{ was #define dname def_expr }
function GLXEW_NV_copy_buffer : longint; { return type might be wrong }
  begin
    GLXEW_NV_copy_buffer:=GLXEW_GET_VAR(__GLXEW_NV_copy_buffer);
  end;

{ was #define dname def_expr }
function glXCopyImageSubDataNV : longint; { return type might be wrong }
  begin
    glXCopyImageSubDataNV:=GLXEW_GET_FUN(__glewXCopyImageSubDataNV);
  end;

{ was #define dname def_expr }
function GLXEW_NV_copy_image : longint; { return type might be wrong }
  begin
    GLXEW_NV_copy_image:=GLXEW_GET_VAR(__GLXEW_NV_copy_image);
  end;

{ was #define dname def_expr }
function glXDelayBeforeSwapNV : longint; { return type might be wrong }
  begin
    glXDelayBeforeSwapNV:=GLXEW_GET_FUN(__glewXDelayBeforeSwapNV);
  end;

{ was #define dname def_expr }
function GLXEW_NV_delay_before_swap : longint; { return type might be wrong }
  begin
    GLXEW_NV_delay_before_swap:=GLXEW_GET_VAR(__GLXEW_NV_delay_before_swap);
  end;

{ was #define dname def_expr }
function GLXEW_NV_float_buffer : longint; { return type might be wrong }
  begin
    GLXEW_NV_float_buffer:=GLXEW_GET_VAR(__GLXEW_NV_float_buffer);
  end;

{ was #define dname def_expr }
function GLXEW_NV_multigpu_context : longint; { return type might be wrong }
  begin
    GLXEW_NV_multigpu_context:=GLXEW_GET_VAR(__GLXEW_NV_multigpu_context);
  end;

{ was #define dname def_expr }
function GLXEW_NV_multisample_coverage : longint; { return type might be wrong }
  begin
    GLXEW_NV_multisample_coverage:=GLXEW_GET_VAR(__GLXEW_NV_multisample_coverage);
  end;

{ was #define dname def_expr }
function glXBindVideoDeviceNV : longint; { return type might be wrong }
  begin
    glXBindVideoDeviceNV:=GLXEW_GET_FUN(__glewXBindVideoDeviceNV);
  end;

{ was #define dname def_expr }
function glXEnumerateVideoDevicesNV : longint; { return type might be wrong }
  begin
    glXEnumerateVideoDevicesNV:=GLXEW_GET_FUN(__glewXEnumerateVideoDevicesNV);
  end;

{ was #define dname def_expr }
function GLXEW_NV_present_video : longint; { return type might be wrong }
  begin
    GLXEW_NV_present_video:=GLXEW_GET_VAR(__GLXEW_NV_present_video);
  end;

{ was #define dname def_expr }
function GLXEW_NV_robustness_video_memory_purge : longint; { return type might be wrong }
  begin
    GLXEW_NV_robustness_video_memory_purge:=GLXEW_GET_VAR(__GLXEW_NV_robustness_video_memory_purge);
  end;

{ was #define dname def_expr }
function glXBindSwapBarrierNV : longint; { return type might be wrong }
  begin
    glXBindSwapBarrierNV:=GLXEW_GET_FUN(__glewXBindSwapBarrierNV);
  end;

{ was #define dname def_expr }
function glXJoinSwapGroupNV : longint; { return type might be wrong }
  begin
    glXJoinSwapGroupNV:=GLXEW_GET_FUN(__glewXJoinSwapGroupNV);
  end;

{ was #define dname def_expr }
function glXQueryFrameCountNV : longint; { return type might be wrong }
  begin
    glXQueryFrameCountNV:=GLXEW_GET_FUN(__glewXQueryFrameCountNV);
  end;

{ was #define dname def_expr }
function glXQueryMaxSwapGroupsNV : longint; { return type might be wrong }
  begin
    glXQueryMaxSwapGroupsNV:=GLXEW_GET_FUN(__glewXQueryMaxSwapGroupsNV);
  end;

{ was #define dname def_expr }
function glXQuerySwapGroupNV : longint; { return type might be wrong }
  begin
    glXQuerySwapGroupNV:=GLXEW_GET_FUN(__glewXQuerySwapGroupNV);
  end;

{ was #define dname def_expr }
function glXResetFrameCountNV : longint; { return type might be wrong }
  begin
    glXResetFrameCountNV:=GLXEW_GET_FUN(__glewXResetFrameCountNV);
  end;

{ was #define dname def_expr }
function GLXEW_NV_swap_group : longint; { return type might be wrong }
  begin
    GLXEW_NV_swap_group:=GLXEW_GET_VAR(__GLXEW_NV_swap_group);
  end;

{ was #define dname def_expr }
function glXAllocateMemoryNV : longint; { return type might be wrong }
  begin
    glXAllocateMemoryNV:=GLXEW_GET_FUN(__glewXAllocateMemoryNV);
  end;

{ was #define dname def_expr }
function glXFreeMemoryNV : longint; { return type might be wrong }
  begin
    glXFreeMemoryNV:=GLXEW_GET_FUN(__glewXFreeMemoryNV);
  end;

{ was #define dname def_expr }
function GLXEW_NV_vertex_array_range : longint; { return type might be wrong }
  begin
    GLXEW_NV_vertex_array_range:=GLXEW_GET_VAR(__GLXEW_NV_vertex_array_range);
  end;

{ was #define dname def_expr }
function glXBindVideoCaptureDeviceNV : longint; { return type might be wrong }
  begin
    glXBindVideoCaptureDeviceNV:=GLXEW_GET_FUN(__glewXBindVideoCaptureDeviceNV);
  end;

{ was #define dname def_expr }
function glXEnumerateVideoCaptureDevicesNV : longint; { return type might be wrong }
  begin
    glXEnumerateVideoCaptureDevicesNV:=GLXEW_GET_FUN(__glewXEnumerateVideoCaptureDevicesNV);
  end;

{ was #define dname def_expr }
function glXLockVideoCaptureDeviceNV : longint; { return type might be wrong }
  begin
    glXLockVideoCaptureDeviceNV:=GLXEW_GET_FUN(__glewXLockVideoCaptureDeviceNV);
  end;

{ was #define dname def_expr }
function glXQueryVideoCaptureDeviceNV : longint; { return type might be wrong }
  begin
    glXQueryVideoCaptureDeviceNV:=GLXEW_GET_FUN(__glewXQueryVideoCaptureDeviceNV);
  end;

{ was #define dname def_expr }
function glXReleaseVideoCaptureDeviceNV : longint; { return type might be wrong }
  begin
    glXReleaseVideoCaptureDeviceNV:=GLXEW_GET_FUN(__glewXReleaseVideoCaptureDeviceNV);
  end;

{ was #define dname def_expr }
function GLXEW_NV_video_capture : longint; { return type might be wrong }
  begin
    GLXEW_NV_video_capture:=GLXEW_GET_VAR(__GLXEW_NV_video_capture);
  end;

{ was #define dname def_expr }
function glXBindVideoImageNV : longint; { return type might be wrong }
  begin
    glXBindVideoImageNV:=GLXEW_GET_FUN(__glewXBindVideoImageNV);
  end;

{ was #define dname def_expr }
function glXGetVideoDeviceNV : longint; { return type might be wrong }
  begin
    glXGetVideoDeviceNV:=GLXEW_GET_FUN(__glewXGetVideoDeviceNV);
  end;

{ was #define dname def_expr }
function glXGetVideoInfoNV : longint; { return type might be wrong }
  begin
    glXGetVideoInfoNV:=GLXEW_GET_FUN(__glewXGetVideoInfoNV);
  end;

{ was #define dname def_expr }
function glXReleaseVideoDeviceNV : longint; { return type might be wrong }
  begin
    glXReleaseVideoDeviceNV:=GLXEW_GET_FUN(__glewXReleaseVideoDeviceNV);
  end;

{ was #define dname def_expr }
function glXReleaseVideoImageNV : longint; { return type might be wrong }
  begin
    glXReleaseVideoImageNV:=GLXEW_GET_FUN(__glewXReleaseVideoImageNV);
  end;

{ was #define dname def_expr }
function glXSendPbufferToVideoNV : longint; { return type might be wrong }
  begin
    glXSendPbufferToVideoNV:=GLXEW_GET_FUN(__glewXSendPbufferToVideoNV);
  end;

{ was #define dname def_expr }
function GLXEW_NV_video_out : longint; { return type might be wrong }
  begin
    GLXEW_NV_video_out:=GLXEW_GET_VAR(__GLXEW_NV_video_out);
  end;

{ was #define dname def_expr }
function GLXEW_OML_swap_method : longint; { return type might be wrong }
  begin
    GLXEW_OML_swap_method:=GLXEW_GET_VAR(__GLXEW_OML_swap_method);
  end;

{ was #define dname def_expr }
function glXGetMscRateOML : longint; { return type might be wrong }
  begin
    glXGetMscRateOML:=GLXEW_GET_FUN(__glewXGetMscRateOML);
  end;

{ was #define dname def_expr }
function glXGetSyncValuesOML : longint; { return type might be wrong }
  begin
    glXGetSyncValuesOML:=GLXEW_GET_FUN(__glewXGetSyncValuesOML);
  end;

{ was #define dname def_expr }
function glXSwapBuffersMscOML : longint; { return type might be wrong }
  begin
    glXSwapBuffersMscOML:=GLXEW_GET_FUN(__glewXSwapBuffersMscOML);
  end;

{ was #define dname def_expr }
function glXWaitForMscOML : longint; { return type might be wrong }
  begin
    glXWaitForMscOML:=GLXEW_GET_FUN(__glewXWaitForMscOML);
  end;

{ was #define dname def_expr }
function glXWaitForSbcOML : longint; { return type might be wrong }
  begin
    glXWaitForSbcOML:=GLXEW_GET_FUN(__glewXWaitForSbcOML);
  end;

{ was #define dname def_expr }
function GLXEW_OML_sync_control : longint; { return type might be wrong }
  begin
    GLXEW_OML_sync_control:=GLXEW_GET_VAR(__GLXEW_OML_sync_control);
  end;

{ was #define dname def_expr }
function GLXEW_SGIS_blended_overlay : longint; { return type might be wrong }
  begin
    GLXEW_SGIS_blended_overlay:=GLXEW_GET_VAR(__GLXEW_SGIS_blended_overlay);
  end;

{ was #define dname def_expr }
function GLXEW_SGIS_color_range : longint; { return type might be wrong }
  begin
    GLXEW_SGIS_color_range:=GLXEW_GET_VAR(__GLXEW_SGIS_color_range);
  end;

{ was #define dname def_expr }
function GLXEW_SGIS_multisample : longint; { return type might be wrong }
  begin
    GLXEW_SGIS_multisample:=GLXEW_GET_VAR(__GLXEW_SGIS_multisample);
  end;

{ was #define dname def_expr }
function GLXEW_SGIS_shared_multisample : longint; { return type might be wrong }
  begin
    GLXEW_SGIS_shared_multisample:=GLXEW_GET_VAR(__GLXEW_SGIS_shared_multisample);
  end;

{ was #define dname def_expr }
function glXChooseFBConfigSGIX : longint; { return type might be wrong }
  begin
    glXChooseFBConfigSGIX:=GLXEW_GET_FUN(__glewXChooseFBConfigSGIX);
  end;

{ was #define dname def_expr }
function glXCreateContextWithConfigSGIX : longint; { return type might be wrong }
  begin
    glXCreateContextWithConfigSGIX:=GLXEW_GET_FUN(__glewXCreateContextWithConfigSGIX);
  end;

{ was #define dname def_expr }
function glXCreateGLXPixmapWithConfigSGIX : longint; { return type might be wrong }
  begin
    glXCreateGLXPixmapWithConfigSGIX:=GLXEW_GET_FUN(__glewXCreateGLXPixmapWithConfigSGIX);
  end;

{ was #define dname def_expr }
function glXGetFBConfigAttribSGIX : longint; { return type might be wrong }
  begin
    glXGetFBConfigAttribSGIX:=GLXEW_GET_FUN(__glewXGetFBConfigAttribSGIX);
  end;

{ was #define dname def_expr }
function glXGetFBConfigFromVisualSGIX : longint; { return type might be wrong }
  begin
    glXGetFBConfigFromVisualSGIX:=GLXEW_GET_FUN(__glewXGetFBConfigFromVisualSGIX);
  end;

{ was #define dname def_expr }
function glXGetVisualFromFBConfigSGIX : longint; { return type might be wrong }
  begin
    glXGetVisualFromFBConfigSGIX:=GLXEW_GET_FUN(__glewXGetVisualFromFBConfigSGIX);
  end;

{ was #define dname def_expr }
function GLXEW_SGIX_fbconfig : longint; { return type might be wrong }
  begin
    GLXEW_SGIX_fbconfig:=GLXEW_GET_VAR(__GLXEW_SGIX_fbconfig);
  end;

{ was #define dname def_expr }
function glXBindHyperpipeSGIX : longint; { return type might be wrong }
  begin
    glXBindHyperpipeSGIX:=GLXEW_GET_FUN(__glewXBindHyperpipeSGIX);
  end;

{ was #define dname def_expr }
function glXDestroyHyperpipeConfigSGIX : longint; { return type might be wrong }
  begin
    glXDestroyHyperpipeConfigSGIX:=GLXEW_GET_FUN(__glewXDestroyHyperpipeConfigSGIX);
  end;

{ was #define dname def_expr }
function glXHyperpipeAttribSGIX : longint; { return type might be wrong }
  begin
    glXHyperpipeAttribSGIX:=GLXEW_GET_FUN(__glewXHyperpipeAttribSGIX);
  end;

{ was #define dname def_expr }
function glXHyperpipeConfigSGIX : longint; { return type might be wrong }
  begin
    glXHyperpipeConfigSGIX:=GLXEW_GET_FUN(__glewXHyperpipeConfigSGIX);
  end;

{ was #define dname def_expr }
function glXQueryHyperpipeAttribSGIX : longint; { return type might be wrong }
  begin
    glXQueryHyperpipeAttribSGIX:=GLXEW_GET_FUN(__glewXQueryHyperpipeAttribSGIX);
  end;

{ was #define dname def_expr }
function glXQueryHyperpipeBestAttribSGIX : longint; { return type might be wrong }
  begin
    glXQueryHyperpipeBestAttribSGIX:=GLXEW_GET_FUN(__glewXQueryHyperpipeBestAttribSGIX);
  end;

{ was #define dname def_expr }
function glXQueryHyperpipeConfigSGIX : longint; { return type might be wrong }
  begin
    glXQueryHyperpipeConfigSGIX:=GLXEW_GET_FUN(__glewXQueryHyperpipeConfigSGIX);
  end;

{ was #define dname def_expr }
function glXQueryHyperpipeNetworkSGIX : longint; { return type might be wrong }
  begin
    glXQueryHyperpipeNetworkSGIX:=GLXEW_GET_FUN(__glewXQueryHyperpipeNetworkSGIX);
  end;

{ was #define dname def_expr }
function GLXEW_SGIX_hyperpipe : longint; { return type might be wrong }
  begin
    GLXEW_SGIX_hyperpipe:=GLXEW_GET_VAR(__GLXEW_SGIX_hyperpipe);
  end;

{ was #define dname def_expr }
function glXCreateGLXPbufferSGIX : longint; { return type might be wrong }
  begin
    glXCreateGLXPbufferSGIX:=GLXEW_GET_FUN(__glewXCreateGLXPbufferSGIX);
  end;

{ was #define dname def_expr }
function glXDestroyGLXPbufferSGIX : longint; { return type might be wrong }
  begin
    glXDestroyGLXPbufferSGIX:=GLXEW_GET_FUN(__glewXDestroyGLXPbufferSGIX);
  end;

{ was #define dname def_expr }
function glXGetSelectedEventSGIX : longint; { return type might be wrong }
  begin
    glXGetSelectedEventSGIX:=GLXEW_GET_FUN(__glewXGetSelectedEventSGIX);
  end;

{ was #define dname def_expr }
function glXQueryGLXPbufferSGIX : longint; { return type might be wrong }
  begin
    glXQueryGLXPbufferSGIX:=GLXEW_GET_FUN(__glewXQueryGLXPbufferSGIX);
  end;

{ was #define dname def_expr }
function glXSelectEventSGIX : longint; { return type might be wrong }
  begin
    glXSelectEventSGIX:=GLXEW_GET_FUN(__glewXSelectEventSGIX);
  end;

{ was #define dname def_expr }
function GLXEW_SGIX_pbuffer : longint; { return type might be wrong }
  begin
    GLXEW_SGIX_pbuffer:=GLXEW_GET_VAR(__GLXEW_SGIX_pbuffer);
  end;

{ was #define dname def_expr }
function glXBindSwapBarrierSGIX : longint; { return type might be wrong }
  begin
    glXBindSwapBarrierSGIX:=GLXEW_GET_FUN(__glewXBindSwapBarrierSGIX);
  end;

{ was #define dname def_expr }
function glXQueryMaxSwapBarriersSGIX : longint; { return type might be wrong }
  begin
    glXQueryMaxSwapBarriersSGIX:=GLXEW_GET_FUN(__glewXQueryMaxSwapBarriersSGIX);
  end;

{ was #define dname def_expr }
function GLXEW_SGIX_swap_barrier : longint; { return type might be wrong }
  begin
    GLXEW_SGIX_swap_barrier:=GLXEW_GET_VAR(__GLXEW_SGIX_swap_barrier);
  end;

{ was #define dname def_expr }
function glXJoinSwapGroupSGIX : longint; { return type might be wrong }
  begin
    glXJoinSwapGroupSGIX:=GLXEW_GET_FUN(__glewXJoinSwapGroupSGIX);
  end;

{ was #define dname def_expr }
function GLXEW_SGIX_swap_group : longint; { return type might be wrong }
  begin
    GLXEW_SGIX_swap_group:=GLXEW_GET_VAR(__GLXEW_SGIX_swap_group);
  end;

{ was #define dname def_expr }
function glXBindChannelToWindowSGIX : longint; { return type might be wrong }
  begin
    glXBindChannelToWindowSGIX:=GLXEW_GET_FUN(__glewXBindChannelToWindowSGIX);
  end;

{ was #define dname def_expr }
function glXChannelRectSGIX : longint; { return type might be wrong }
  begin
    glXChannelRectSGIX:=GLXEW_GET_FUN(__glewXChannelRectSGIX);
  end;

{ was #define dname def_expr }
function glXChannelRectSyncSGIX : longint; { return type might be wrong }
  begin
    glXChannelRectSyncSGIX:=GLXEW_GET_FUN(__glewXChannelRectSyncSGIX);
  end;

{ was #define dname def_expr }
function glXQueryChannelDeltasSGIX : longint; { return type might be wrong }
  begin
    glXQueryChannelDeltasSGIX:=GLXEW_GET_FUN(__glewXQueryChannelDeltasSGIX);
  end;

{ was #define dname def_expr }
function glXQueryChannelRectSGIX : longint; { return type might be wrong }
  begin
    glXQueryChannelRectSGIX:=GLXEW_GET_FUN(__glewXQueryChannelRectSGIX);
  end;

{ was #define dname def_expr }
function GLXEW_SGIX_video_resize : longint; { return type might be wrong }
  begin
    GLXEW_SGIX_video_resize:=GLXEW_GET_VAR(__GLXEW_SGIX_video_resize);
  end;

{ was #define dname def_expr }
function GLXEW_SGIX_visual_select_group : longint; { return type might be wrong }
  begin
    GLXEW_SGIX_visual_select_group:=GLXEW_GET_VAR(__GLXEW_SGIX_visual_select_group);
  end;

{ was #define dname def_expr }
function glXCushionSGI : longint; { return type might be wrong }
  begin
    glXCushionSGI:=GLXEW_GET_FUN(__glewXCushionSGI);
  end;

{ was #define dname def_expr }
function GLXEW_SGI_cushion : longint; { return type might be wrong }
  begin
    GLXEW_SGI_cushion:=GLXEW_GET_VAR(__GLXEW_SGI_cushion);
  end;

{ was #define dname def_expr }
function glXGetCurrentReadDrawableSGI : longint; { return type might be wrong }
  begin
    glXGetCurrentReadDrawableSGI:=GLXEW_GET_FUN(__glewXGetCurrentReadDrawableSGI);
  end;

{ was #define dname def_expr }
function glXMakeCurrentReadSGI : longint; { return type might be wrong }
  begin
    glXMakeCurrentReadSGI:=GLXEW_GET_FUN(__glewXMakeCurrentReadSGI);
  end;

{ was #define dname def_expr }
function GLXEW_SGI_make_current_read : longint; { return type might be wrong }
  begin
    GLXEW_SGI_make_current_read:=GLXEW_GET_VAR(__GLXEW_SGI_make_current_read);
  end;

{ was #define dname def_expr }
function glXSwapIntervalSGI : longint; { return type might be wrong }
  begin
    glXSwapIntervalSGI:=GLXEW_GET_FUN(__glewXSwapIntervalSGI);
  end;

{ was #define dname def_expr }
function GLXEW_SGI_swap_control : longint; { return type might be wrong }
  begin
    GLXEW_SGI_swap_control:=GLXEW_GET_VAR(__GLXEW_SGI_swap_control);
  end;

{ was #define dname def_expr }
function glXGetVideoSyncSGI : longint; { return type might be wrong }
  begin
    glXGetVideoSyncSGI:=GLXEW_GET_FUN(__glewXGetVideoSyncSGI);
  end;

{ was #define dname def_expr }
function glXWaitVideoSyncSGI : longint; { return type might be wrong }
  begin
    glXWaitVideoSyncSGI:=GLXEW_GET_FUN(__glewXWaitVideoSyncSGI);
  end;

{ was #define dname def_expr }
function GLXEW_SGI_video_sync : longint; { return type might be wrong }
  begin
    GLXEW_SGI_video_sync:=GLXEW_GET_VAR(__GLXEW_SGI_video_sync);
  end;

{ was #define dname def_expr }
function glXGetTransparentIndexSUN : longint; { return type might be wrong }
  begin
    glXGetTransparentIndexSUN:=GLXEW_GET_FUN(__glewXGetTransparentIndexSUN);
  end;

{ was #define dname def_expr }
function GLXEW_SUN_get_transparent_index : longint; { return type might be wrong }
  begin
    GLXEW_SUN_get_transparent_index:=GLXEW_GET_VAR(__GLXEW_SUN_get_transparent_index);
  end;

{ was #define dname def_expr }
function glXGetVideoResizeSUN : longint; { return type might be wrong }
  begin
    glXGetVideoResizeSUN:=GLXEW_GET_FUN(__glewXGetVideoResizeSUN);
  end;

{ was #define dname def_expr }
function glXVideoResizeSUN : longint; { return type might be wrong }
  begin
    glXVideoResizeSUN:=GLXEW_GET_FUN(__glewXVideoResizeSUN);
  end;

{ was #define dname def_expr }
function GLXEW_SUN_video_resize : longint; { return type might be wrong }
  begin
    GLXEW_SUN_video_resize:=GLXEW_GET_VAR(__GLXEW_SUN_video_resize);
  end;


end.
