unit integer_types;

interface

uses
  ctypes;

{$IFDEF FPC}
{$PACKRECORDS C}
{$ENDIF}

const
  FT_CHAR_BIT = 8;
const
  FT_SIZEOF_INT = Sizeof(cint);

const
  FT_SIZEOF_LONG =  Sizeof(clong);

const
  FT_SIZEOF_LONG_LONG =  Sizeof(clonglong);

type
  PFT_Int16 = ^TFT_Int16;
  TFT_Int16 = Int16;

  PFT_UInt16 = ^TFT_UInt16;
  TFT_UInt16 = UInt16;

  PFT_Int32 = ^TFT_Int32;
  TFT_Int32 = Int32;

  PFT_UInt32 = ^TFT_UInt32;
  TFT_UInt32 = UInt32;

  PFT_Int64 = ^TFT_Int64;
  TFT_Int64 = int64;

  PFT_UInt64 = ^TFT_UInt64;
  TFT_UInt64 = UInt64;
type
  PFT_Fast = ^TFT_Fast;
  TFT_Fast = longint;

  PFT_UFast = ^TFT_UFast;
  TFT_UFast = dword;

implementation

end.
