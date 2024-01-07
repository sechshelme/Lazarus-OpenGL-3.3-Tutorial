unit wglVAO;

{$mode ObjFPC}

interface

uses
  Types, SysUtils,
  BrowserConsole, WebGL, JS,
  wglCommon,wglMatrix,wglTextur;

type

  { TVBO }

  TVBO=class(TObject)
    private
    ID: TJSWebGLBuffer;
    fVertexSize:GLsizei;
    public
    constructor Create(floatArray:TJSFloat32Array;vertexSize:GLsizei);
    procedure Bind(uniformID: GLuint);
  end;

  { TVAO }

  TVAO=class(TObject)
  constructor Create(path:String);
  procedure onload;
  procedure draw(textur:TTextur);
  end;

implementation

{ TVBO }

constructor TVBO.Create(floatArray: TJSFloat32Array; vertexSize: GLsizei);
begin
  inherited Create;
  fVertexSize:=vertexSize;
  ID:=gl.createBuffer;
  gl.bindBuffer(gl.ARRAY_BUFFER, ID);
  gl.bufferData(gl.ARRAY_BUFFER,floatArray,gl.STATIC_DRAW);
end;

procedure TVBO.Bind(uniformID: GLuint);
begin
  gl.enableVertexAttribArray(uniformID);
  gl.bindBuffer(gl.ARRAY_BUFFER,ID);
  gl.vertexAttribPointer(uniformID,fVertexSize,gl.FLOAT,False,0,0);
end;

{ TVAO }

constructor TVAO.Create(path: String);
begin

end;

procedure TVAO.onload;
begin

end;

procedure TVAO.draw(textur: TTextur);
begin

end;

end.

