unit v4l2_driver;

interface

  {$L v4l2_driver.o}
  {$LinkLib c}

  {$IFDEF FPC}
  {$PACKRECORDS C}
  {$ENDIF}

const
  BUF_NUM = 4;

var
  IMAGE_WIDTH: longint; cvar;external;
  IMAGE_HEIGHT: longint; cvar;external;

type
  Pv4l2_ubuffer = ^Tv4l2_ubuffer;

  Tv4l2_ubuffer = record
    start: pointer;
    length: dword;
  end;

var
  v4l2_ubuffers: Pv4l2_ubuffer; cvar;external;

function v4l2_open(device: PChar): longint; cdecl; external;
function v4l2_close(fd: longint): longint; cdecl; external;
function v4l2_querycap(fd: longint; device: PChar): longint; cdecl; external;
function v4l2_sfmt(fd: longint; pfmt: uint32): longint; cdecl; external;
function v4l2_gfmt(fd: longint): longint; cdecl; external;
function v4l2_mmap(fd: longint): longint; cdecl; external;
function v4l2_munmap: longint; cdecl; external;
function v4l2_sfps(fd: longint; fps: longint): longint; cdecl; external;
function v4l2_streamon(fd: longint): longint; cdecl; external;
function v4l2_streamoff(fd: longint): longint; cdecl; external;

implementation

end.
