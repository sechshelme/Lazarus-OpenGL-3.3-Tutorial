unit oglMatrix;

{$modeswitch typehelpers}

// === Öffentlicher Teil ===

interface

uses
  SysUtils, Forms, Dialogs, Clipbrd, dglOpenGL, oglVector;

type
  Tmat2x2 = array[0..1] of TVector2f;
  Tmat3x3 = array[0..2] of TVector3f;
  Tmat4x4 = array[0..3] of TVector4f;

  Tmat3x2 = array[0..2] of TVector2f;
  Tmat3x4 = array[0..2] of TVector4f;

  TMatrix = Tmat4x4;
  TMatrix2D = Tmat3x3;

  PMatrix = ^TMatrix;

  { Tmat2x2Helper }

  Tmat2x2Helper = type Helper for Tmat2x2
  public
    procedure Identity;
    procedure Zero;
  end;

  { Tmat3x3Helper }

  Tmat3x3Helper = type Helper for Tmat3x3  // Arbeitet nicht richtig mit Shadern zusammen !
  public
    procedure Identity;
    procedure Zero;

    procedure Scale(x, y: GLfloat); overload;
    procedure Scale(s: GLfloat); overload;
    procedure Translate(x, y: GLfloat);
    procedure NewTranslate(x, y: GLfloat);
    procedure Rotate(w: GLfloat);
    procedure Transpose;
    procedure Shear(x, y: GLfloat);

    procedure Frustum(left, right, zNear, zFar: GLfloat);

    procedure Uniform(ShaderID: GLint);
  end;

  { TMatrixHelper }

  TMatrixHelper = type Helper for Tmat4x4
  public
    procedure Identity;
    procedure Zero;

    procedure Ortho(left, right, bottom, top, znear, zfar: GLfloat);
    procedure Frustum(left, right, bottom, top, znear, zfar: GLfloat);
    procedure Perspective(fovy, aspect, znear, zfar: GLfloat);

    procedure Scale(Faktor: GLfloat); overload;
    procedure Scale(FaktorX, FaktorY, FaktorZ: GLfloat); overload;
    procedure Translate(x, y, z: GLfloat); overload;
    procedure Translate(const v: TVector3f); overload;
    procedure NewTranslate(x, y, z: GLfloat);
    procedure Rotate(Winkel, x, y, z: GLfloat); overload;
    procedure Rotate(Winkel: GLfloat; const a: TVector3f); overload;
    procedure RotateA(Winkel: GLfloat);
    procedure RotateB(Winkel: GLfloat);
    procedure RotateC(Winkel: GLfloat);
    procedure Transpose;
    procedure ShearA(y, z: GLfloat);
    procedure ShearB(x, z: GLfloat);
    procedure ShearC(x, y: GLfloat);

    procedure Uniform(ShaderID: GLint);

    procedure WriteMatrix;   // Für Testzwecke
  end;

// === Hilfsfunktionen, ähnlich GLSL ===

function mat3(const v0, v1, v2: TVector3f): Tmat3x3;
function mat4(const v0, v1, v2, v3: TVector4f): Tmat4x4;
function mat3x2(const v0, v1, v2: TVector2f): Tmat3x2;

// === Überladene Opertoren für Matrixmultiplikation ===

operator * (const m: Tmat2x2; v:TVector2f) Res: TVector2f;
operator * (const m: Tmat3x3; v:TVector3f) Res: TVector3f;
operator * (const m: Tmat4x4; v:TVector4f) Res: TVector4f;

operator + (const mat0, mat1: Tmat2x2) Res: Tmat2x2;
operator + (const mat0, mat1: Tmat3x3) Res: Tmat3x3;
operator + (const mat0, mat1: Tmat4x4) Res: Tmat4x4;

operator - (const mat0, mat1: Tmat2x2) Res: Tmat2x2;
operator - (const mat0, mat1: Tmat3x3) Res: Tmat3x3;
operator - (const mat0, mat1: Tmat4x4) Res: Tmat4x4;

operator * (const mat0, mat1: Tmat2x2) Res: Tmat2x2;
operator * (const mat0, mat1: Tmat3x3) Res: Tmat3x3;
operator * (const mat0, mat1: Tmat4x4) Res: Tmat4x4;

// === Privater Teil ===

implementation

operator * (const m: Tmat2x2; v: TVector2f) Res: TVector2f;
var
  i: integer;
begin
  for i := 0 to 1 do begin
    Res[i] := m[0, i] * v[0] + m[1, i] * v[1];
  end;
end;

operator * (const m: Tmat3x3; v: TVector3f) Res: TVector3f;
var
  i: integer;
begin
  for i := 0 to 2 do begin
    Res[i] := m[0, i] * v[0] + m[1, i] * v[1] + m[2, i] * v[2];
  end;
end;

operator * (const m: Tmat4x4; v: TVector4f) Res: TVector4f;
var
  i: integer;
begin
  for i := 0 to 3 do begin
    Res[i] := m[0, i] * v[0] + m[1, i] * v[1] + m[2, i] * v[2]+ m[3, i] * v[3];
  end;
end;

operator + (const mat0, mat1: Tmat2x2)Res: Tmat2x2;
var
  i, j:Integer;
begin
  for i:=0 to 1 do for j:=0 to 1 do Res[i, j]:=mat0[i,j]+mat1[i,j];
end;

operator + (const mat0, mat1: Tmat3x3)Res: Tmat3x3;
var
  i, j:Integer;
begin
  for i:=0 to 2 do for j:=0 to 2 do Res[i, j]:=mat0[i,j]+mat1[i,j];
end;

operator + (const mat0, mat1: Tmat4x4)Res: Tmat4x4;
var
  i, j:Integer;
begin
  for i:=0 to 3 do for j:=0 to 3 do Res[i, j]:=mat0[i,j]+mat1[i,j];
end;

operator - (const mat0, mat1: Tmat2x2)Res: Tmat2x2;
var
  i, j:Integer;
begin
  for i:=0 to 1 do for j:=0 to 1 do Res[i, j]:=mat0[i,j]-mat1[i,j];
end;

operator - (const mat0, mat1: Tmat3x3)Res: Tmat3x3;
var
  i, j:Integer;
begin
  for i:=0 to 2 do for j:=0 to 2 do Res[i, j]:=mat0[i,j]-mat1[i,j];
end;

operator - (const mat0, mat1: Tmat4x4)Res: Tmat4x4;
var
  i, j:Integer;
begin
  for i:=0 to 3 do for j:=0 to 3 do Res[i, j]:=mat0[i,j]-mat1[i,j];
end;

operator * (const mat0, mat1: Tmat2x2) Res: Tmat2x2;
var
  i, j, k: integer;
begin
  for i := 0 to 1 do begin
    for j := 0 to 1 do begin
      Res[i, j] := 0.0;
      for k := 0 to 1 do begin
        Res[i, j] += mat1[i, k] * mat0[k, j];
      end;
    end;
  end;
end;

operator * (const mat0, mat1: Tmat3x3) Res: Tmat3x3;
var
  i, j, k: integer;
begin
  for i := 0 to 2 do begin
    for j := 0 to 2 do begin
      Res[i, j] := 0.0;
      for k := 0 to 2 do begin
        Res[i, j] += mat1[i, k] * mat0[k, j];
      end;
    end;
  end;
end;

operator * (const mat0, mat1: Tmat4x4) Res: Tmat4x4;
var
  i, j, k: integer;
begin
  for i := 0 to 3 do begin
    for j := 0 to 3 do begin
      Res[i, j] := 0.0;
      for k := 0 to 3 do begin
        Res[i, j] += mat1[i, k] * mat0[k, j];
      end;
    end;
  end;
end;

function mat3(const v0, v1, v2: TVector3f): Tmat3x3; inline;
begin
  Result[0] := v0;
  Result[1] := v1;
  Result[2] := v2;
end;

function mat4(const v0, v1, v2, v3: TVector4f): Tmat4x4; inline;
begin
  Result[0] := v0;
  Result[1] := v1;
  Result[2] := v2;
  Result[3] := v3;
end;

function mat3x2(const v0, v1, v2: TVector2f): Tmat3x2; inline;
begin
  Result[0] := v0;
  Result[1] := v1;
  Result[2] := v2;
end;

{ Tmat2x2Helper }

procedure Tmat2x2Helper.Identity; inline;
const
  m: TMat2x2 = ((1.0, 0.0), (0.0, 1.0));
begin
  Self := m;
end;

procedure Tmat2x2Helper.Zero; inline;
const
  m: TMat2x2 = (( 0.0, 0.0), (0.0, 0.0));
begin
  Self := m;
end;

{ Tmat3x3Helper }

procedure Tmat3x3Helper.Identity; inline;
const
  m: TMat3x3 = ((1.0, 0.0, 0.0), (0.0, 1.0, 0.0), (0.0, 0.0, 1.0));
begin
  Self := m;
end;

procedure Tmat3x3Helper.Zero; inline;
const
  m: TMat3x3 = ((0.0, 0.0, 0.0), (0.0, 0.0, 0.0), (0.0, 0.0, 0.0));
begin
  Self := m;
end;

procedure Tmat3x3Helper.Scale(x, y: GLfloat);
var
  i: integer;
begin
  for i := 0 to 1 do begin
    Self[i, 0] *= x;
    Self[i, 1] *= y;
  end;
end;

procedure Tmat3x3Helper.Scale(s: GLfloat);
var
  i: Integer;
begin
  for i := 0 to 1 do begin
    Self[i, 0] *= s;
    Self[i, 1] *= s;
  end;
end;

procedure Tmat3x3Helper.Translate(x, y: GLfloat); inline;
begin
  Self[2, 0] += x;
  Self[2, 1] += y;
end;

procedure Tmat3x3Helper.NewTranslate(x, y: GLfloat);
var
  i: integer;
begin
  for i := 0 to 2 do begin
    Self[2, i] += Self[0, i] * x + Self[1, i] * y;
  end;
end;

procedure Tmat3x3Helper.Rotate(w: GLfloat);
var
  i: integer;
  x, y: GLfloat;
begin
  for i := 0 to 1 do begin
    x := Self[i, 0];
    y := Self[i, 1];
    Self[i, 0] := x * cos(w) - y * sin(w);
    Self[i, 1] := x * sin(w) + y * cos(w);
  end;
end;

procedure Tmat3x3Helper.Transpose;
var
  i, j: integer;
  m: Tmat3x3;
begin
  for i := 0 to 2 do begin
    for j := 0 to 2 do begin
      m[i, j] := Self[j, i];
    end;
  end;
  Self := m;
end;

procedure Tmat3x3Helper.Uniform(ShaderID: GLint);
begin
  glUniformMatrix3fv(ShaderID, 1, False, @Self);
end;

procedure Tmat3x3Helper.Shear(x, y: GLfloat);
begin
  Self[0, 1] += y;
  Self[1, 0] += x;
end;

procedure Tmat3x3Helper.Frustum(left, right, zNear, zFar: GLfloat); // geht nicht.
begin
  Identity;
  Self[0, 0] := 2 * zNear / (right - left);
  Self[1, 0] := (right + left) / (right - left);
  Self[1, 1] := -(zFar + zNear) / (zFar - zNear);
  Self[1, 2] := -1.0;
  Self[2, 1] := -2 * zFar * zNear / (zFar - zNear);
  Self[2, 2] := 0.0;
end;

{ TMatrix }

procedure TMatrixHelper.Identity; inline;
const
  m: Tmat4x4 = ((1.0, 0.0, 0.0, 0.0), (0.0, 1.0, 0.0, 0.0), (0.0, 0.0, 1.0, 0.0), (0.0, 0.0, 0.0, 1.0));
begin
  Self := m;
end;

procedure TMatrixHelper.Zero; inline;
const
  m: Tmat4x4 = ((0.0, 0.0, 0.0, 0.0), (0.0, 0.0, 0.0, 0.0), (0.0, 0.0, 0.0, 0.0), (0.0, 0.0, 0.0, 0.0));
begin
  Self := m;
end;

procedure TMatrixHelper.Ortho(left, right, bottom, top, znear, zfar: GLfloat);
begin
  Identity;
  Self[0, 0] := 2 / (right - left);
  Self[1, 1] := 2 / (top - bottom);
  Self[2, 2] := -2 / (zfar - znear);
  Self[3, 0] := -(right + left) / (right - left);
  Self[3, 1] := -(top + bottom) / (top - bottom);
  Self[3, 2] := -(zfar + znear) / (zfar - znear);
end;

procedure TMatrixHelper.Frustum(left, right, bottom, top, znear, zfar: GLfloat);
begin
  Identity;
  Self[0, 0] := 2 * znear / (right - left);
  Self[1, 1] := 2 * znear / (top - bottom);
  Self[2, 0] := (right + left) / (right - left);
  Self[2, 1] := (top + bottom) / (top - bottom);
  Self[2, 2] := -(zfar + znear) / (zfar - znear);
  Self[2, 3] := -1.0;
  Self[3, 2] := -2 * zfar * znear / (zfar - znear);
  Self[3, 3] := 0.0;
end;

procedure TMatrixHelper.Perspective(fovy, aspect, znear, zfar: GLfloat);
var
  p, right, top: GLfloat;
begin
  p := fovy * Pi / 360;
  top := znear * (sin(p) / cos(p)); // top := znear * tan(p);
  right := top * aspect;
  Frustum(-right, right, -top, top, znear, zfar);
end;


procedure TMatrixHelper.Rotate(Winkel, x, y, z: GLfloat);
var
  c, s: GLfloat;      // Funktionierts ?????
  m: Tmat4x4;
begin
  c := cos(Winkel);
  s := sin(Winkel);

  m[0, 0] := x * x * (1 - c) + c;
  m[1, 0] := x * y * (1 - c) - z * s;
  m[2, 0] := x * z * (1 - c) + y * s;

  m[0, 1] := y * x * (1 - c) + z * s;
  m[1, 1] := y * y * (1 - c) + c;
  m[2, 1] := y * z * (1 - c) - x * s;

  m[0, 2] := x * z * (1 - c) - y * s;
  m[1, 2] := y * z * (1 - c) + x * s;
  m[2, 2] := z * z * (1 - c) + c;
  Self := m;
end;

procedure TMatrixHelper.Rotate(Winkel: GLfloat; const a: TVector3f);
begin
  Rotate(Winkel, a[0], a[1], a[2]);
end;

procedure TMatrixHelper.Translate(x, y, z: GLfloat); inline;
begin
  Self[3, 0] += x;
  Self[3, 1] += y;
  Self[3, 2] += z;
end;

procedure TMatrixHelper.Translate(const v: TVector3f); inline;
begin
  Self[3, 0] += v[0];
  Self[3, 1] += v[1];
  Self[3, 2] += v[2];
end;

procedure TMatrixHelper.NewTranslate(x, y, z: GLfloat);
var
  i: integer;
begin
  for i := 0 to 3 do begin
    Self[3, i] += Self[0, i] * x + Self[1, i] * y + Self[2, i] * z;
  end;
end;


procedure TMatrixHelper.RotateA(Winkel: GLfloat);
var
  i: integer;
  y, z, c, s: GLfloat;
begin
  c := cos(Winkel);
  s := sin(Winkel);
  for i := 0 to 2 do begin
    y := Self[i, 1];
    z := Self[i, 2];
    Self[i, 1] := y * c - z * s;
    Self[i, 2] := y * s + z * c;
  end;
end;


procedure TMatrixHelper.RotateB(Winkel: GLfloat);
var
  i: integer;
  x, z, c, s: GLfloat;
begin
  c := cos(Winkel);
  s := sin(Winkel);
  for i := 0 to 2 do begin
    x := Self[i, 0];
    z := Self[i, 2];
    Self[i, 0] := x * c - z * s;
    Self[i, 2] := x * s + z * c;
  end;
end;


procedure TMatrixHelper.RotateC(Winkel: GLfloat);
var
  i: integer;
  x, y, c, s: GLfloat;
begin
  c := cos(Winkel);
  s := sin(Winkel);
  for i := 0 to 2 do begin
    x := Self[i, 0];
    y := Self[i, 1];
    Self[i, 0] := x * c - y * s;
    Self[i, 1] := x * s + y * c;
  end;
end;

procedure TMatrixHelper.Scale(Faktor: GLfloat);
var
  x, y: integer;
begin
  for x := 0 to 2 do begin
    for y := 0 to 2 do begin
      Self[x, y] *= Faktor;
    end;
  end;
end;

procedure TMatrixHelper.Scale(FaktorX, FaktorY, FaktorZ: GLfloat);
var
  i: integer;
begin
  for i := 0 to 2 do begin
    Self[i, 0] *= FaktorX;
    Self[i, 1] *= FaktorY;
    Self[i, 2] *= FaktorZ;
  end;
end;

procedure TMatrixHelper.ShearA(y, z: GLfloat);
begin
  Self[2, 1] += y;
  Self[1, 2] += z;
end;

procedure TMatrixHelper.ShearB(x, z: GLfloat);
begin
  Self[2, 0] += x;
  Self[0, 2] += z;
end;

procedure TMatrixHelper.ShearC(x, y: GLfloat);
begin
  Self[1, 0] += x;
  Self[0, 1] += y;
end;


procedure TMatrixHelper.Transpose;
var
  i, j: integer;
  m: Tmat4x4;
begin
  for i := 0 to 3 do begin
    for j := 0 to 3 do begin
      m[i, j] := Self[j, i];
    end;
  end;
  Self := m;
end;

procedure TMatrixHelper.Uniform(ShaderID: GLint); inline;
begin
  glUniformMatrix4fv(ShaderID, 1, False, @Self);
end;


procedure TMatrixHelper.WriteMatrix;
var
  x, y: integer;
begin
  for y := 0 to 3 do begin
    for x := 0 to 3 do begin
      Write(FormatFloat('###0.0000', Self[x, y]));
    end;
    Writeln;
  end;
end;

end.
