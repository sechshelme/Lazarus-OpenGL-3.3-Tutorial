unit oglVBO;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Dialogs,
  dglOpenGL, oglVector, oglMatrix;

type
  //TFace4DArray = array of Tmat3x4;
  //TFace3DArray = array of Tmat3x3;
  //TFace2DArray = array of Tmat3x2;

  TModif = set of (CW, neg, normalize);

  { TVBO }

  TVBO = class(TObject)
  private
    GLfloatArray: TglFloatArray;
    Primitive_Size: integer;
    procedure SwapGLfloat(var v0, v1: GLfloat);
  protected
    VBO: GLint;
    VertexSize: integer;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Append(AVertexBufferObject: TVBO);
    function LoadVertexBuffer(Shader_Attriut_ID: GLint): cardinal;
    function GLfloatArrayCount: integer;
    function Count: integer;

    procedure SaveToStream(stream: TFileStream);
  end;


  { TVBO_Triangles2D }


  TVBO_Triangles2D = class(TVBO)
  private
    procedure Rotate2(Angele: single);
  public
    constructor Create;

    procedure Add(Face: TFace2D); overload;
    procedure Add(v0, v1, v2: TVector2f); overload;
    procedure Add(const Face: array of TFace2D); overload;
    procedure Copy(von, bis, anz: integer);
    procedure Rotate(Angele: single);
    procedure Scale(Factor: single); overload;
    procedure Scale(Factorx, Factory: single); overload;
    procedure Scale(Factor: TVector2f); overload;
    procedure Modif(von, bis: integer; m: TModif);
    procedure Modif(m: TModif);
  end;

  { TVBO_Triangles }

  TVBO_Triangles = class(TVBO)
  public
    constructor Create;

    procedure Add(Face: TFace3D); overload;
    procedure Add(v0, v1, v2: TVector3f); overload;
    procedure Add(const Face: array of TFace3D); overload;
    procedure Add(const f: TglFloatArray); overload;
    procedure Copy(von, bis, anz: integer);
    procedure RotateB(winkel: single); overload;
    procedure RotateB(winkel: single; von, bis: integer); overload;
    procedure Translate(v: TVector3f);
    procedure Modif(von, bis: integer; m: TModif);
    procedure Modif(m: TModif);
  end;

  { TVBO_LineStrip }

  TVBO_LineStrip = class(TVBO)
  public
    constructor Create;

    procedure Add(Vertex: TVector3f);
  end;


implementation

{ TVBO }

constructor TVBO.Create;
begin
  inherited Create;
  glGenBuffers(1, @VBO);
end;

function TVBO.LoadVertexBuffer(Shader_Attriut_ID: GLint): cardinal;
begin
  if Length(GLfloatArray) <> 0 then begin
    glBindBuffer(GL_ARRAY_BUFFER, VBO);
    glBufferData(GL_ARRAY_BUFFER, SizeOf(GLfloat) * Length(GLfloatArray), Pointer(GLfloatArray), GL_STATIC_DRAW);
    glEnableVertexAttribArray(Shader_Attriut_ID);
    glVertexAttribPointer(Shader_Attriut_ID, VertexSize, GL_FLOAT, False, 0, nil);
  end;

  Result := Length(GLfloatArray) div VertexSize;   // Wird bei Draw gebraucht.
  SetLength(GLfloatArray, 0);                      // Nach dem schreiben, Float-Buffer leeren
end;

procedure TVBO.SaveToStream(stream: TFileStream);
var
  len: GLint;
  Data: array of byte;
begin
  glBindBuffer(GL_ARRAY_BUFFER, VBO);

  glGetBufferParameteriv(GL_ARRAY_BUFFER, GL_BUFFER_SIZE, @len);
  SetLength(Data, len);
  glGetBufferSubData(GL_ARRAY_BUFFER, 0, len, Pointer(Data));

  stream.Write(len, SizeOf(len));

  stream.Write(Pointer(Data)^, len);
  SetLength(Data, 0);
end;

destructor TVBO.Destroy;
begin
  glDeleteBuffers(1, @VBO);
  inherited Destroy;
end;

procedure TVBO.SwapGLfloat(var v0, v1: GLfloat); inline;
var
  v: GLfloat;
begin
  v := v0;
  v0 := v1;
  v1 := v;
end;

procedure TVBO.Append(AVertexBufferObject: TVBO);
var
  l: integer;
begin
  l := Length(AVertexBufferObject.GLfloatArray);
  SetLength(GLfloatArray, l);

  if l <> 0 then begin
    Move(AVertexBufferObject.GLfloatArray[0], GLfloatArray[0], l * SizeOf(GLfloat));
  end;
end;

function TVBO.GLfloatArrayCount: integer;
begin
  Result := Length(GLfloatArray);
end;

function TVBO.Count: integer;
begin
  Result := Length(GLfloatArray) div Primitive_Size;
end;

{ TVBO_Triangles2D }

constructor TVBO_Triangles2D.Create;
begin
  inherited Create;
  VertexSize := 2;
  Primitive_Size := 6;
end;

procedure TVBO_Triangles2D.Add(Face: TFace2D); inline;
begin
  GLfloatArray.AddFace2D(Face);
end;

procedure TVBO_Triangles2D.Add(v0, v1, v2: TVector2f); inline;
begin
  GLfloatArray.AddFace2D(v0, v1, v2);
end;

procedure TVBO_Triangles2D.Add(const Face: array of TFace2D); inline;
begin
  GLfloatArray.AddFace2DArray(Face);
end;

procedure TVBO_Triangles2D.Copy(von, bis, anz: integer);
var
  i, l: integer;
begin
  l := Length(GLfloatArray) div 6;
  if bis + anz > l then begin
    SetLength(GLfloatArray, (bis + anz) * 6);
  end;
  for i := 0 to anz * 6 - 1 do begin
    GLfloatArray[bis * 6 + i] := GLfloatArray[von * 6 + i];
  end;
end;

procedure TVBO_Triangles2D.Rotate2(Angele: single);
var
  i: integer;
  fa: array of GLfloat;
  va: array of TVector2f absolute fa;
begin
  if Length(GLfloatArray) < 1 then begin
    Exit;
  end;
  fa := GLfloatArray;
  for i := 0 to (Length(GLfloatArray) - 1) div 2 do begin
    va[i].Rotate(Angele);
  end;
end;

procedure TVBO_Triangles2D.Rotate(Angele: single);
var
  i: integer;
  v: TVector2f;
begin
  if Length(GLfloatArray) < 1 then begin
    Exit;
  end;
  for i := 0 to (Length(GLfloatArray) - 1) div 2 do begin
    v := vec2(GLfloatArray[i * 2], GLfloatArray[i * 2 + 1]);
    v.Rotate(Angele);
    Move(v, GLfloatArray[i * 2], SizeOf(GLfloat) * 2);
  end;
end;

procedure TVBO_Triangles2D.Scale(Factor: single); inline;
begin
  GLfloatArray.Scale(Factor);
end;

procedure TVBO_Triangles2D.Scale(Factorx, Factory: single); inline;
begin
  GLfloatArray.Scale(Factorx, Factory);
end;

procedure TVBO_Triangles2D.Scale(Factor: TVector2f); inline;
begin
  Scale(Factor[0], Factor[1]);
end;

procedure TVBO_Triangles2D.Modif(von, bis: integer; m: TModif);
var
  i, j: integer;
begin
  if von < 0 then begin
    von := 0;
  end;
  if bis < 0 then begin
    bis := 0;
  end;
  i := Length(GLfloatArray) div 6;
  if i = 0 then begin
    Exit;
  end;
  if von > i then begin
    von := i;
  end;
  if bis > i then begin
    bis := i;
  end;
  if CW in m then begin
    for i := von to bis do begin
      for j := 0 to 1 do begin
        SwapGLfloat(GLfloatArray[i * 6 + 0 + j], GLfloatArray[i * 6 + 2 + j]);
      end;
    end;
  end;
end;

procedure TVBO_Triangles2D.Modif(m: TModif);
begin
  Modif(0, Length(GLfloatArray) div 6 - 1, m);
end;

{ TVBO_Triangles }

constructor TVBO_Triangles.Create;
begin
  inherited Create;
  VertexSize := 3;
  Primitive_Size := 9;
end;

procedure TVBO_Triangles.Add(Face: TFace3D); inline;
begin
  GLfloatArray.AddFace3D(Face);
end;

procedure TVBO_Triangles.Add(v0, v1, v2: TVector3f); inline;
begin
  Add(mat3(v0, v1, v2));
end;

procedure TVBO_Triangles.Add(const Face: array of TFace3D); inline;
begin
  GLfloatArray.AddFace3DArray(Face);
end;

procedure TVBO_Triangles.Add(const f: TglFloatArray);
var
  i, l, p: integer;
begin
  l := Length(f) div 9;
  for i := 0 to l - 1 do begin
    p := i * 9;
    Add(
      vec3(f[p + 0], f[p + 1], f[p + 2]),
      vec3(f[p + 3], f[p + 4], f[p + 5]),
      vec3(f[p + 6], f[p + 7], f[p + 8]));
  end;
end;

procedure TVBO_Triangles.Copy(von, bis, anz: integer);
var
  l, i: integer;
begin
  l := Length(GLfloatArray) div 9;
  if bis + anz > l then begin
    SetLength(GLfloatArray, (bis + anz) * 9);
  end;
  for i := 0 to anz * 9 - 1 do begin
    GLfloatArray[bis * 9 + i] := GLfloatArray[von * 9 + i];
  end;
end;

procedure TVBO_Triangles.RotateB(winkel: single);
begin
  RotateB(winkel, 0, Length(GLfloatArray) div 9 - 1);
end;

procedure TVBO_Triangles.RotateB(winkel: single; von, bis: integer);
var
  i: integer;
  v: TVector3f = (0.0, 0.0, 0.0);
begin
  if Length(GLfloatArray) < 1 then begin
    Exit;
  end;
  for i := von * 3 to bis * 3 + 2 do begin
    Move(GLfloatArray[i * 3], v, SizeOf(v));
    v.RotateB(winkel);
    Move(v, GLfloatArray[i * 3], SizeOf(v));
  end;
end;

procedure TVBO_Triangles.Translate(v: TVector3f);
var
  i, j: integer;
begin
  if Length(GLfloatArray) < 1 then begin
    Exit;
  end;
  for i := 0 to Length(GLfloatArray) div 3 - 1 do begin
    for j := 0 to 2 do begin
      GLfloatArray[i * 3 + j] += v[j];
    end;
  end;
end;

procedure TVBO_Triangles.Modif(von, bis: integer; m: TModif);
var
  i, j: integer;
  mat: Tmat3x3;
begin
  if von < 0 then begin
    von := 0;
  end;
  if bis < 0 then begin
    bis := 0;
  end;
  i := Length(GLfloatArray) div 9;
  if i = 0 then begin
    Exit;
  end;
  if von > i then begin
    von := i;
  end;
  if bis > i then begin
    bis := i;
  end;

  if normalize in m then begin
    for i := von to bis do begin
      Move(GLfloatArray[i * 9], mat, SizeOf(mat));
      FaceToNormale(mat, mat);
      Move(mat, GLfloatArray[i * 9], SizeOf(mat));
    end;
  end;
  if neg in m then begin
    for i := von * 9 to bis * 9 + 8 do begin
      GLfloatArray[i] := GLfloatArray[i] * -1;
    end;
  end;
  if CW in m then begin
    for i := von to bis do begin
      for j := 0 to 2 do begin
        SwapGLfloat(GLfloatArray[i * 9 + 0 + j], GLfloatArray[i * 9 + 3 + j]);
      end;
    end;
  end;
end;

procedure TVBO_Triangles.Modif(m: TModif);
begin
  Modif(0, Length(GLfloatArray) div 9 - 1, m);
end;

{ TVBO_LineStrip }

constructor TVBO_LineStrip.Create;
begin
  inherited Create;
  VertexSize := 3;
  Primitive_Size := 3;
end;

procedure TVBO_LineStrip.Add(Vertex: TVector3f); inline;
begin
  GLfloatArray.AddVector3f(Vertex);
end;

end.
