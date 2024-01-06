unit GLUtils;

interface

uses
  MemoryBuffer,
  BrowserConsole, WebGL, JS,
  Types, SysUtils;


const
  kModelVertexFloats = 3 + 2 + 3;

  var
      gl: TJSWebGLRenderingContext=nil;


function GLSizeof(glType: nativeint): integer;

implementation

{=============================================}
{@! ___Utilities___ }
{=============================================}

function GLSizeof(glType: nativeint): integer;
begin
  case glType of
    TJSWebGLRenderingContext.UNSIGNED_BYTE, TJSWebGLRenderingContext.byte: begin
      Result := 1;
    end;
    TJSWebGLRenderingContext.SHORT, TJSWebGLRenderingContext.UNSIGNED_SHORT: begin
      Result := 2;
    end;
    TJSWebGLRenderingContext.INT, TJSWebGLRenderingContext.UNSIGNED_INT: begin
      Result := 4;
    end;
    TJSWebGLRenderingContext.FLOAT: begin
      Result := 4;
    end;
    otherwise
    begin
    end;
  end;
end;


end.
