# unit glad_gl.pas bauen

## glad_gl bauen

Zuerst folgende Web-Seite öffnen: [glad](https://glad.dav1d.de/)

Folgende Einstellungen vornehmen:
  
* Language -> Pascal
* API -> gl ->   Version 3.3
* Profile -> Core
* [GENERATE]

## Folgende Änderungen in der Unit glad_gl.pa vornehmen:
* Wichtig, die unit **dynlibs** muss eingebunden werden !
* Der **TGLboolean** und **GLboolean** auf **Boolean8** setzen.
* Bei Zeile 25 folgendes hinzufügen:
```pascal
...
interface

uses
  SysUtils, StrUtils, dynlibs;

procedure Load_GLADE;  // Neu

type
  TGLVULKANPROCNV = pointer;
  TGLbitfield = uint32;
  TGLboolean = Boolean8; // Byte -> Boolean8
  TGLbyte = int8;
  TGLchar = char;
  TGLcharARB = byte;
  TGLclampd = double;
  TGLclampf = single;
  TGLclampx = int32;
  TGLdouble = double;
  TGLeglClientBufferEXT = pointer;
  TGLeglImageOES = pointer;
  TGLenum = uint32;
  TGLfixed = int32;
  TGLfloat = single;
  TGLhalf = uint16;
  TGLhalfARB = uint16;
  TGLhalfNV = uint16;
  TGLhandleARB = uint32;
  TGLint = int32;
  TGLint64 = int64;
  TGLint64EXT = int64;
  TGLintptr = int32;
  TGLintptrARB = int32;
  TGLshort = int16;
  TGLsizei = int32;
  TGLsizeiptr = int32;
  TGLsizeiptrARB = int32;
  TGLsync = pointer;
  TGLubyte = uint8;
  TGLuint = uint32;
  TGLuint64 = uint64;
  TGLuint64EXT = uint64;
  TGLushort = uint16;
  TGLvdpauSurfaceNV = int32;
  TGLvoid = pointer;
...
```

Folgendes zu unterst ergänzen.
```pascal
// === Eigenes

var
  LibGL: TLibHandle;

{$IFDEF Linux}
function wglGetProcAddress(proc: pansichar): Pointer;
begin
  Result := GetProcAddress(LibGL, proc);
end;
{$ENDIF}

{$IFDEF Windows}
function wglGetProcAddress(proc: pansichar): Pointer; cdecl external 'OpenGL32.dll';
{$ENDIF}

function LoadProc(proc: pansichar): TLoadProc;
const
  first: Boolean = True;
begin
  Result := GetProcAddress(LibGL, proc);
  {$IFDEF Windows}
  {$push}
  {$i-}
  if first  then begin
    WriteLn('');
    first := False;
  end;
  {$pop}
  if @Result = nil then  begin
    Result := wglGetProcAddress(proc);
  end;
  {$ENDIF}
end;

procedure Load_GLADE;
begin
  {$IFDEF Linux}
  LibGL := LoadLibrary(pansichar('libGL.so.1'));
  {$ENDIF}
  {$IFDEF Windows}
  LibGL := LoadLibrary(pansichar('OpenGL32.dll'));
  {$ENDIF}
  gladLoadGL(@LoadProc);
end;

end.  // Unit Ende
```

## Einbinden der unit
### LCL
Unter Windows muss zwingend zuerst den OpenGL Context erzweugt werden.
Anschliessend kann `Load_GLADE;` verwendet werden.
Erst nach Aufruf von `Load_GLADE;` dürfen OpenGL Befehle verwendet werden.
```pascal
  OpenGLControl1.MakeCurrent;
  Load_GLADE;
```





