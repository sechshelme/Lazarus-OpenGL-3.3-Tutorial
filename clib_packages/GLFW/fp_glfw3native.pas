unit fp_glfw3native;

interface

uses
  {$ifdef linux}
  x, xlib,
  xrandr,
  {$endif}
  {$ifdef windows}
  windows,
  {$endif}
  {$ifdef darwin}
  CocoaAll,
  {$endif}
  fp_glfw3;

  {$IFDEF FPC}
  {$PACKRECORDS C}
  {$ENDIF}


{$ifdef windows}
function glfwGetWin32Adapter(monitor: PGLFWmonitor): pchar; cdecl; external libglfw;
function glfwGetWin32Monitor(monitor: PGLFWmonitor): pchar; cdecl; external libglfw;
function glfwGetWin32Window(window: PGLFWwindow): HWND; cdecl; external libglfw;
function glfwGetWGLContext(window: PGLFWwindow): HGLRC; cdecl; external libglfw;
{$endif}

{$ifdef darwin}
function glfwGetCocoaMonitor(monitor: PGLFWmonitor): TCGDirectDisplayID; cdecl; external libglfw;
function glfwGetCocoaWindow(window: PGLFWwindow): Tid; cdecl; external libglfw;
function glfwGetNSGLContext(window: PGLFWwindow): Tid; cdecl; external libglfw;
{$endif}

//{$ifdef linux}
//function glfwGetX11Display: PDisplay; cdecl; external libglfw;
//function glfwGetX11Adapter(monitor: PGLFWmonitor): TRRCrtc; cdecl; external libglfw;
//function glfwGetX11Monitor(monitor: PGLFWmonitor): TRROutput; cdecl; external libglfw;
//function glfwGetX11Window(window: PGLFWwindow): TWindow; cdecl; external libglfw;
//procedure glfwSetX11SelectionString(_string: pchar); cdecl; external libglfw;
//function glfwGetX11SelectionString: pchar; cdecl; external libglfw;
//function glfwGetGLXContext(window: PGLFWwindow): TGLXContext; cdecl; external libglfw;
//function glfwGetGLXWindow(window: PGLFWwindow): TGLXWindow; cdecl; external libglfw;
//
//function glfwGetWaylandDisplay: Pwl_display; cdecl; external libglfw;
//function glfwGetWaylandMonitor(monitor: PGLFWmonitor): Pwl_output; cdecl; external libglfw;
//function glfwGetWaylandWindow(window: PGLFWwindow): Pwl_surface; cdecl; external libglfw;
//{$endif}
//
//function glfwGetEGLDisplay: TEGLDisplay; cdecl; external libglfw;
//function glfwGetEGLContext(window: PGLFWwindow): TEGLContext; cdecl; external libglfw;
//function glfwGetEGLSurface(window: PGLFWwindow): TEGLSurface; cdecl; external libglfw;
//
//function glfwGetOSMesaColorBuffer(window: PGLFWwindow; width: Plongint; height: Plongint; format: Plongint; buffer: Ppointer): longint; cdecl; external libglfw;
//function glfwGetOSMesaDepthBuffer(window: PGLFWwindow; width: Plongint; height: Plongint; bytesPerValue: Plongint; buffer: Ppointer): longint; cdecl; external libglfw;
//function glfwGetOSMesaContext(window: PGLFWwindow): TOSMesaContext; cdecl; external libglfw;

// === Konventiert am: 21-6-25 15:14:31 ===


implementation



end.
