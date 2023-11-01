unit oglFloatArray;

{$modeswitch typehelpers}

interface

uses
  dglOpenGL, oglVector;

  { TglFloatArrayHelper }

type
  TglFloatArray = array of glFloat;
  PglFloatArray = ^TglFloatArray;

  TglFloatArrayHelper = type Helper for TglFloatArray
    procedure AddglFloatf(f: GLfloat);

    procedure AddVector2f(const Vertex: TVector2f); overload;
    procedure AddVector2f(x, y: GLfloat); overload;
    procedure AddVector3f(const Vertex: TVector3f); overload;
    procedure AddVector3f(x, y, z: GLfloat); overload;
    procedure AddVector4f(const Vertex: TVector4f); overload;
    procedure AddVector4f(x, y, z, w: GLfloat); overload;

    procedure AddFace2D(const Face: TFace2D); overload;
    procedure AddFace2D(const v0, v1, v2: TVector2f); overload;
    procedure AddFace2DArray(const Face: array of TFace2D);

    procedure AddFace3D(const Face: TFace3D); overload;
    procedure AddFace3D(const v0, v1, v2: TVector3f); overload;
    procedure AddFace3DArray(const Face: array of TFace3D);

    procedure Scale(factor: GLfloat); overload;
    procedure Scale(x, y: GLfloat); overload;
    procedure Scale(x, y, z: GLfloat); overload;

    function Size: SizeInt;
    function Vector2DCount: SizeInt;
    function Vector3DCount: SizeInt;
  end;

implementation

// ====  FloatArray Helper

procedure TglFloatArrayHelper.AddglFloatf(f: GLfloat);
var
  p: integer;
begin
  p := Length(Self);
  SetLength(Self, p + 1);
  Move(f, Self[p], SizeOf(GLfloat));
end;

procedure TglFloatArrayHelper.AddVector2f(const Vertex: TVector2f);
var
  p: integer;
begin
  p := Length(Self);
  SetLength(Self, p + 2);
  Move(Vertex, Self[p], SizeOf(TVector2f));
end;

procedure TglFloatArrayHelper.AddVector2f(x, y: GLfloat);
begin
  AddVector2f(vec2(x, y));
end;

procedure TglFloatArrayHelper.AddVector3f(const Vertex: TVector3f);
var
  p: integer;
begin
  p := Length(Self);
  SetLength(Self, p + 3);
  Move(Vertex, Self[p], SizeOf(TVector3f));
end;

procedure TglFloatArrayHelper.AddVector3f(x, y, z: GLfloat);
begin
  AddVector3f(vec3(x, y, z));
end;

procedure TglFloatArrayHelper.AddVector4f(const Vertex: TVector4f);
var
  p: integer;
begin
  p := Length(Self);
  SetLength(Self, p + 4);
  Move(Vertex, Self[p], SizeOf(TVector4f));
end;

procedure TglFloatArrayHelper.AddVector4f(x, y, z, w: GLfloat);
begin
  AddVector4f(vec4(x, y, z, w));
end;

procedure TglFloatArrayHelper.AddFace2D(const Face: TFace2D);
var
  p: integer;
begin
  p := Length(Self);
  SetLength(Self, p + 6);
  Move(Face, Self[p], SizeOf(TFace2D));
end;

procedure TglFloatArrayHelper.AddFace2D(const v0, v1, v2: TVector2f);
begin
  AddVector2f(v0);
  AddVector2f(v1);
  AddVector2f(v2);
end;

procedure TglFloatArrayHelper.AddFace2DArray(const Face: array of TFace2D);
var
  p: integer;
begin
  p := Length(Self);
  SetLength(Self, p + 6 * Length(Face));
  Move(Face, Self[p], SizeOf(TFace2D) * Length(Face));
end;

procedure TglFloatArrayHelper.AddFace3D(const Face: TFace3D);
var
  p: integer;
begin
  p := Length(Self);
  SetLength(Self, p + 9);
  Move(Face, Self[p], SizeOf(TFace3D));
end;

procedure TglFloatArrayHelper.AddFace3D(const v0, v1, v2: TVector3f);
begin
  AddVector3f(v0);
  AddVector3f(v1);
  AddVector3f(v2);
end;

procedure TglFloatArrayHelper.AddFace3DArray(const Face: array of TFace3D);
var
  p: integer;
begin
  p := Length(Self);
  SetLength(Self, p + 9 * Length(Face));
  Move(Face, Self[p], SizeOf(TFace3D) * Length(Face));
end;

procedure TglFloatArrayHelper.Scale(factor: GLfloat);
var
  i: integer;
begin
  for i := 0 to Length(Self) - 1 do begin
    Self[i] *= factor;
  end;
end;

procedure TglFloatArrayHelper.Scale(x, y: GLfloat);
var
  i: integer;
begin
  for i := 0 to (Length(Self) - 1) div 2 do begin
    Self[i * 2 + 0] *= x;
    Self[i * 2 + 1] *= y;
  end;
end;

procedure TglFloatArrayHelper.Scale(x, y, z: GLfloat);
var
  i: integer;
begin
  for i := 0 to (Length(Self) - 1) div 3 do begin
    Self[i * 3 + 0] *= x;
    Self[i * 3 + 1] *= y;
    Self[i * 3 + 2] *= z;
  end;
end;

function TglFloatArrayHelper.Size: SizeInt;
begin
  Result := Length(Self) * SizeOf(GLfloat);
end;

function TglFloatArrayHelper.Vector2DCount: SizeInt;
begin
  Result := Length(Self) div 2;
end;

function TglFloatArrayHelper.Vector3DCount: SizeInt;
begin
  Result := Length(Self) div 3;
end;

end.
