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

  { TVAOTextur }

  TVAOTextur = class(TObject)
  private
    shader: TShader;
    posID, normalID, uvID: GLint;
    reader: TJSXMLHttpRequest;
    matrixID: TJSWebGLUniformLocation;

     posVBO,normalVBO,uvVBO: TVBO;
      numItems:Integer;
  public
    constructor Create(TexturPath: string);
    procedure onload;
    procedure draw(textur: TTextur);
  end;

implementation

{ TVBO }

constructor TVBO.Create(floatArray: TJSFloat32Array; vertexSize: GLsizei);
var
  i: Integer;
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

{ TVAOTextur }

constructor TVAOTextur.Create(TexturPath: string);
begin
 posVBO:=nil;
 normalVBO:=nil;
 uvVBO:=nil;

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
  reader.Open('GET', 'data/' + TexturPath + '.bin');
  reader.responseType := 'arraybuffer';
  reader.send(nil);

  numItems:=0;
end;

procedure TVAOTextur.onload;
var
  arrayBuffer: TJSArrayBuffer;
  floatBufferColor:TJSFloat32Array;

 pos,len: Integer;

begin
  if (reader.status = 200) then  begin

    arrayBuffer := TJSArrayBuffer( reader.response);
    Writeln('xhrlen: ',arrayBuffer.byteLength);

    floatBufferColor:= TJSFloat32Array.new (arrayBuffer, 0,4);

    Writeln(floatBufferColor[0]);
    Writeln(floatBufferColor[1]);
    Writeln(floatBufferColor[2]);
    Writeln(floatBufferColor[3]);

    pos:=4;
    // Vektor
    len:=TJSUint32Array.new(arrayBuffer)[pos] div 4;
    Inc(pos);

    numItems:=len div 3; // Drei Punkte im Dreieck
    Writeln('vertexCount: ', numItems);
    posVBO:=TVBO.Create(TJSFloat32Array.new(arrayBuffer,pos*4,len),3);
    inc(pos,len);

    // Normale
    len:=TJSUint32Array.new(arrayBuffer)[pos] div 4;
    Inc(pos);
    normalVBO:=TVBO.Create(TJSFloat32Array.new(arrayBuffer,pos*4,len),3);
    inc(pos,len);

    // Normale
    len:=TJSUint32Array.new(arrayBuffer)[pos] div 4;
    Inc(pos);
    uvVBO:=TVBO.Create(TJSFloat32Array.new(arrayBuffer,pos*4,len),2);
  end;
end;

procedure TVAOTextur.draw(textur: TTextur);
var
 m:TMatrix;
begin
  shader.UseProgram;

if posVBO<>nil then  posVBO.bind(posID);
if normalVBO<>nil then  normalVBO.bind(normalID);
if uvVBO<>nil then  uvVBO.bind(uvID);

 if textur<>nil then textur.activateAndBind(0);

  m.Indenty;

  m:=MatrixMultiple(WorldMatrix,ObjectMatrix);
//  m.Scale(0.5,0.5,0.5);

  m.Uniform(matrixID);

  gl.drawArrays(gl.TRIANGLES,0,numItems);
end;

end.
