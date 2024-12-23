unit ftsystem;

interface

{$IFDEF FPC}
{$PACKRECORDS C}
{$ENDIF}

type
  PFT_Memory = ^TFT_Memory;
  TFT_Memory = ^TFT_MemoryRec_;

  PFT_Alloc_Func = ^TFT_Alloc_Func;
  TFT_Alloc_Func = function(memory: TFT_Memory; size: longint): pointer; cdecl;
  TFT_Free_Func = procedure(memory: TFT_Memory; block: pointer); cdecl;
  PFT_Realloc_Func = ^TFT_Realloc_Func;
  TFT_Realloc_Func = function(memory: TFT_Memory; cur_size: longint; new_size: longint; block: pointer): pointer; cdecl;

  PFT_MemoryRec_ = ^TFT_MemoryRec_;

  TFT_MemoryRec_ = record
    user: pointer;//cdecl;
    alloc: TFT_Alloc_Func;
    Free: TFT_Free_Func;
    realloc: TFT_Realloc_Func;
  end;

  PFT_Stream = ^TFT_Stream;
  TFT_Stream = ^TFT_StreamRec_;

  PFT_StreamDesc_ = ^TFT_StreamDesc_;
  TFT_StreamDesc_ = record
    case longint of
      0: (Value: longint);
      1: (pointer: pointer);
  end;
  TFT_StreamDesc = TFT_StreamDesc_;
  PFT_StreamDesc = ^TFT_StreamDesc;

  TFT_Stream_IoFunc = function(stream: TFT_Stream; offset: dword; buffer: pbyte; Count: dword): dword; cdecl;
  TFT_Stream_CloseFunc = procedure(stream: TFT_Stream); cdecl;

  PFT_StreamRec_ = ^TFT_StreamRec_;

  TFT_StreamRec_ = record
    base: pbyte;
    size: dword;
    pos: dword;
    descriptor: TFT_StreamDesc;
    pathname: TFT_StreamDesc;
    Read: TFT_Stream_IoFunc;
    Close: TFT_Stream_CloseFunc;
    memory: TFT_Memory;
    cursor: pbyte;
    limit: pbyte;
  end;
  TFT_StreamRec = TFT_StreamRec_;
  PFT_StreamRec = ^TFT_StreamRec;

implementation

end.
