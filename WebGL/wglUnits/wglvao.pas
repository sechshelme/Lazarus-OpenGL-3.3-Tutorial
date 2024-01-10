unit wglVAO;

{$mode ObjFPC}

interface

uses
  Types, SysUtils,
  Web, BrowserConsole, WebGL, JS,
  wglCommon, wglMatrix, wglShader, wglTextur,
  ShaderSource;

type

  { TVBO }

  TVBO = class(TObject)
  private
    ID: TJSWebGLBuffer;
    fVertexSize: GLsizei;
  public
    constructor Create(floatArray: TJSFloat32Array; vertexSize: GLsizei);
    destructor Destroy; override;
    procedure Bind(uniformID: GLuint);
  end;

  { TVAOMonoColor }

  TVAOMonoColor = class(TObject)
  private
    reader: TJSXMLHttpRequest;
    shader: TShader;
    posID, normalID: GLint;
    colorID,
    matrixID: TJSWebGLUniformLocation;

    posVBO, normalVBO: TVBO;
    numItems: integer;
  public
    Color: TVector4f;
    constructor Create(VertexPath: string);
    procedure onload;
    procedure draw;
    procedure setColor(Acol:TVector4f);
  end;

  { TVAOTextur }

  TVAOTextur = class(TObject)
  private
    reader: TJSXMLHttpRequest;
    shader: TShader;
    posID, normalID, uvID: GLint;
    matrixID: TJSWebGLUniformLocation;

    posVBO, normalVBO, uvVBO: TVBO;
    numItems: integer;
  public
    constructor Create(VertexPath: string);
    procedure onload;
    procedure draw(textur: TTextur);
  end;

  { TVAOBumpMapingTextur }

  TVAOBumpMapingTextur = class(TObject)
  private
    reader: TJSXMLHttpRequest;
    shader: TShader;
    posID, normalID, uvID: GLint;
    matrixID: TJSWebGLUniformLocation;

    posVBO, normalVBO, uvVBO: TVBO;
    numItems: integer;
  public
    constructor Create(VertexPath: string);
    procedure onload;
    procedure draw(textur, normal: TTextur);
  end;

implementation

{ TVBO }

constructor TVBO.Create(floatArray: TJSFloat32Array; vertexSize: GLsizei);
var
  i: integer;
begin
  inherited Create;
  fVertexSize := vertexSize;
  ID := gl.createBuffer;
  gl.bindBuffer(gl.ARRAY_BUFFER, ID);
  gl.bufferData(gl.ARRAY_BUFFER, floatArray, gl.STATIC_DRAW);
end;

destructor TVBO.Destroy;
begin
  gl.deleteBuffer(ID);
  inherited Destroy;
end;

procedure TVBO.Bind(uniformID: GLuint);
begin
  gl.enableVertexAttribArray(uniformID);
  gl.bindBuffer(gl.ARRAY_BUFFER, ID);
  gl.vertexAttribPointer(uniformID, fVertexSize, gl.FLOAT, False, 0, 0);
end;

{ TVAOMonoColor }

constructor TVAOMonoColor.Create(VertexPath: string);
begin
  posVBO := nil;
  normalVBO := nil;

  shader := TShader.Create;
  shader.LoadShaderObject(gl.VERTEX_SHADER, monoColorVertex);
  shader.LoadShaderObject(gl.FRAGMENT_SHADER, monoColorFragment);
  shader.LinkProgram;

  posID := shader.AttribLocation('inPos');
  normalID := shader.AttribLocation('inNormal');

  colorID := shader.uniformLocation('VecColor');
  matrixID := shader.uniformLocation('ObjectMatrix');

  reader := TJSXMLHttpRequest.New;
  reader.addEventListener('load', @onload);
  reader.Open('GET', 'data/' + VertexPath + '.bin');
  reader.responseType := 'arraybuffer';
  reader.send(nil);

  numItems := 0;
end;

procedure TVAOMonoColor.onload;
var
  arrayBuffer: TJSArrayBuffer;
  floatBufferColor: TJSFloat32Array;
  pos, len, i: integer;
begin
  if (reader.status = 200) then  begin

    arrayBuffer := TJSArrayBuffer(reader.response);
    Writeln('VAOlen: ', arrayBuffer.byteLength);

    floatBufferColor := TJSFloat32Array.new(arrayBuffer, 0, 4);
    for i := 0 to 3 do begin
      Color[i] := floatBufferColor[i];
    end;

    pos := 4;
    // Vektor
    len := TJSUint32Array.new(arrayBuffer)[pos] div 4;
    Inc(pos);

    numItems := len div 3; // Drei Punkte im Dreieck
    Writeln('vertexCount: ', numItems);
    posVBO := TVBO.Create(TJSFloat32Array.new(arrayBuffer, pos * 4, len), 3);
    Inc(pos, len);

    // Normale
    len := TJSUint32Array.new(arrayBuffer)[pos] div 4;
    Inc(pos);
    normalVBO := TVBO.Create(TJSFloat32Array.new(arrayBuffer, pos * 4, len), 3);
    Inc(pos, len);
  end;
end;

procedure TVAOMonoColor.draw;
var
  m: TMatrix;
const
  GoldCol: TVector4f = (1.0, 1.0, 0.5, 1.0);
begin
  shader.UseProgram;

  if posVBO <> nil then  begin
    posVBO.bind(posID);
  end;
  if normalVBO <> nil then  begin
    normalVBO.bind(normalID);
  end;

  if isGold then begin
    gl.uniform4fv(colorID, GoldCol);
  end else begin
    gl.uniform4fv(colorID, Color);
  end;

  m.Indenty;
  m := MatrixMultiple(WorldMatrix, ObjectMatrix);
  m.Uniform(matrixID);

  gl.drawArrays(gl.TRIANGLES, 0, numItems);
end;

procedure TVAOMonoColor.setColor(Acol: TVector4f);
begin
  Color:=Acol;
end;

{ TVAOTextur }

constructor TVAOTextur.Create(VertexPath: string);
begin
  posVBO := nil;
  normalVBO := nil;
  uvVBO := nil;

  shader := TShader.Create;
  shader.LoadShaderObject(gl.VERTEX_SHADER, texturVertex);
  shader.LoadShaderObject(gl.FRAGMENT_SHADER, texturFragment);
  shader.LinkProgram;

  posID := shader.AttribLocation('inPos');
  normalID := shader.AttribLocation('inNormal');
  uvID := shader.AttribLocation('inUV');

  matrixID := shader.uniformLocation('ObjectMatrix');
  gl.uniform1i(shader.uniformLocation('Sampler0'), 0);

  reader := TJSXMLHttpRequest.New;
  reader.addEventListener('load', @onload);
  reader.Open('GET', 'data/' + VertexPath + '.bin');
  reader.responseType := 'arraybuffer';
  reader.send(nil);

  numItems := 0;
end;

procedure TVAOTextur.onload;
var
  arrayBuffer: TJSArrayBuffer;
  //  floatBufferColor:TJSFloat32Array;
  pos, len: integer;
begin
  if (reader.status = 200) then  begin

    arrayBuffer := TJSArrayBuffer(reader.response);
    //    Writeln('VAOlen: ',arrayBuffer.byteLength);

    //    floatBufferColor:= TJSFloat32Array.new (arrayBuffer, 0,4);

    pos := 4;
    // Vektor
    len := TJSUint32Array.new(arrayBuffer)[pos] div 4;
    Inc(pos);

    numItems := len div 3; // Drei Punkte im Dreieck
    Writeln('vertexCount: ', numItems);
    posVBO := TVBO.Create(TJSFloat32Array.new(arrayBuffer, pos * 4, len), 3);
    Inc(pos, len);

    // Normale
    len := TJSUint32Array.new(arrayBuffer)[pos] div 4;
    Inc(pos);
    normalVBO := TVBO.Create(TJSFloat32Array.new(arrayBuffer, pos * 4, len), 3);
    Inc(pos, len);

    // uv
    len := TJSUint32Array.new(arrayBuffer)[pos] div 4;
    Inc(pos);
    uvVBO := TVBO.Create(TJSFloat32Array.new(arrayBuffer, pos * 4, len), 2);
  end;
end;

procedure TVAOTextur.draw(textur: TTextur);
var
  m: TMatrix;
begin
  shader.UseProgram;

  if posVBO <> nil then  begin
    posVBO.bind(posID);
  end;
  if normalVBO <> nil then  begin
    normalVBO.bind(normalID);
  end;
  if uvVBO <> nil then  begin
    uvVBO.bind(uvID);
  end;

  if textur <> nil then begin
    textur.activateAndBind(0);
  end;

  m.Indenty;
  m := MatrixMultiple(WorldMatrix, ObjectMatrix);
  m.Uniform(matrixID);

  gl.drawArrays(gl.TRIANGLES, 0, numItems);
end;

{ TVAOBumpMapingTextur }

constructor TVAOBumpMapingTextur.Create(VertexPath: string);
begin
  posVBO := nil;
  normalVBO := nil;
  uvVBO := nil;

  shader := TShader.Create;
  shader.LoadShaderObject(gl.VERTEX_SHADER, texturBumpMapingVertex);
  shader.LoadShaderObject(gl.FRAGMENT_SHADER, texturBumpMapingFragment);
  shader.LinkProgram;

  posID := shader.AttribLocation('inPos');
  normalID := shader.AttribLocation('inNormal');
  uvID := shader.AttribLocation('inUV');

  matrixID := shader.uniformLocation('ObjectMatrix');
  gl.uniform1i(shader.uniformLocation('Sampler0'), 0);
  gl.uniform1i(shader.uniformLocation('Sampler1'), 1);

  reader := TJSXMLHttpRequest.New;
  reader.addEventListener('load', @onload);
  reader.Open('GET', 'data/' + VertexPath + '.bin');
  reader.responseType := 'arraybuffer';
  reader.send(nil);

  numItems := 0;
end;

procedure TVAOBumpMapingTextur.onload;
var
  arrayBuffer: TJSArrayBuffer;
  floatBufferColor: TJSFloat32Array;
  pos, len: integer;
begin
  if (reader.status = 200) then  begin

    arrayBuffer := TJSArrayBuffer(reader.response);
    //    Writeln('VAOlen: ',arrayBuffer.byteLength);

    floatBufferColor := TJSFloat32Array.new(arrayBuffer, 0, 4);

    //    pos:=4;
    pos := 0;
    // Vektor
    len := TJSUint32Array.new(arrayBuffer)[pos] div 4;
    Inc(pos);

    numItems := len div 3; // Drei Punkte im Dreieck
    Writeln('vertexCount: ', numItems);
    posVBO := TVBO.Create(TJSFloat32Array.new(arrayBuffer, pos * 4, len), 3);
    Inc(pos, len);

    // Normale
    len := TJSUint32Array.new(arrayBuffer)[pos] div 4;
    Inc(pos);
    normalVBO := TVBO.Create(TJSFloat32Array.new(arrayBuffer, pos * 4, len), 3);
    Inc(pos, len);

    // uv
    len := TJSUint32Array.new(arrayBuffer)[pos] div 4;
    Inc(pos);
    uvVBO := TVBO.Create(TJSFloat32Array.new(arrayBuffer, pos * 4, len), 2);
  end;
end;

procedure TVAOBumpMapingTextur.draw(textur, normal: TTextur);
var
  m: TMatrix;
begin
  shader.UseProgram;

  if posVBO <> nil then  begin
    posVBO.bind(posID);
  end;
  if normalVBO <> nil then  begin
    normalVBO.bind(normalID);
  end;
  if uvVBO <> nil then  begin
    uvVBO.bind(uvID);
  end;

  if textur <> nil then begin
    textur.activateAndBind(0);
  end;
  if normal <> nil then begin
    normal.activateAndBind(1);
  end;

  m.Indenty;
  m := MatrixMultiple(WorldMatrix, ObjectMatrix);
  m.Uniform(matrixID);

  gl.drawArrays(gl.TRIANGLES, 0, numItems);
end;

end.
