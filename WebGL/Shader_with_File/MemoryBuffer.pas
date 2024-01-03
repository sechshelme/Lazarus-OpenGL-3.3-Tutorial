{$mode objfpc}

unit MemoryBuffer;

interface

uses
  JS;

type
  TMBFloat32 = double;

  TMemoryBuffer = class
  private
    byteBuffer: TJSUint8Array;
  public
    constructor Create(size: integer);

    { UInt8 }
    procedure AddBytes(Count: integer; Data: array of byte);

    { Float32 }
    procedure AddFloats(Count: integer; Data: array of TMBFloat32);
    procedure AddFloat(Data: TMBFloat32);

    { UInt16 }
    procedure AddWords(Count: integer; Data: array of word);

    property GetBytes: TJSUint8Array read byteBuffer;
  private
    byteOffset: integer;
    floatBuffer: TJSFloat32Array;
    wordBuffer: TJSUInt16Array;
  end;

implementation

constructor TMemoryBuffer.Create(size: integer);
begin
  byteBuffer := TJSUint8Array.New(size);
end;

procedure TMemoryBuffer.AddBytes(Count: integer; Data: array of byte);
begin
  //writeln('AddBytes: @', byteOffset, ' -> ', data);
  byteBuffer._set(Data, byteOffset);
  byteOffset := byteOffset + (Count * 1);
end;

procedure TMemoryBuffer.AddFloat(Data: TMBFloat32);
begin
  AddFloats(1, [Data]);
end;

procedure TMemoryBuffer.AddFloats(Count: integer; Data: array of TMBFloat32);
const
  kElementSize = 4;
var
  floatOffset: integer;
begin
  floatOffset := byteOffset div kElementSize;
  //writeln('AddFloats: @', byteOffset, '/', floatOffset, ' -> ', data);

  if floatBuffer = nil then begin
    floatBuffer := TJSFloat32Array.New(byteBuffer.buffer, 0, byteBuffer.byteLength div kElementSize);
  end;

  floatBuffer._set(Data, floatOffset);

  byteOffset := byteOffset + (Count * kElementSize);
end;

procedure TMemoryBuffer.AddWords(Count: integer; Data: array of word);
const
  kElementSize = 2;
var
  wordOffset: integer;
begin
  wordOffset := byteOffset div kElementSize;

  if wordBuffer = nil then begin
    wordBuffer := TJSUInt16Array.New(byteBuffer.buffer, 0, byteBuffer.byteLength div kElementSize);
  end;

  wordBuffer._set(Data, wordOffset);

  byteOffset := byteOffset + (Count * kElementSize);
end;

end.
