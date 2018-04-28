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

  { TMatrix2DHelper }

  TMatrix2DHelper = type Helper for TMatrix2D  // Arbeitet nicht richtig mit Shader zusammen
  public
    procedure Identity;
    procedure Multiply(m1, m2: TMatrix2D);

    procedure Uniform(ShaderID: GLint);

    procedure Scale(x, y: single); overload;
    procedure Scale(s: single); overload;
    procedure Translate(x, y: single);
    procedure Rotate(w: single);
    procedure Shear(x, y: single);

    function Vektor_Multi(Vector: TVector3f): TVector3f;

    procedure Frustum(left, right, zNear, zFar: single);       // ??????????????
  end;

  { TMatrix }

  { TMatrixHelper }

  TMatrixHelper = type Helper for Tmat4x4
  public
    procedure Identity;
    procedure Multiply(const m1t, m2t: TMatrix);

    procedure Uniform(ShaderID: GLint);

    procedure Ortho(left, right, bottom, top, znear, zfar: single);
    procedure Frustum(left, right, bottom, top, znear, zfar: single);
    procedure Perspective(fovy, aspect, znear, zfar: single);

    procedure Rotate(Winkel, x, y, z: GLfloat); overload;
    procedure Rotate(Winkel: GLfloat; a: TVector3f); overload;
    procedure RotateA(Winkel: GLfloat);
    procedure RotateB(Winkel: GLfloat);
    procedure RotateC(Winkel: GLfloat);
    procedure Translate(x, y, z: GLfloat); overload;
    procedure Translate(v: TVector3f); overload;
    procedure NewTranslate(x, y, z: GLfloat);
    procedure Scale(Faktor: GLfloat); overload;
    procedure Scale(FaktorX, FaktorY, FaktorZ: GLfloat); overload;
    procedure Transpose;

    procedure WriteMatrix;   // Für Testzwecke
  end;

function mat3(v0, v1, v2: TVector3f): Tmat3x3;
function mat3x2(v0, v1, v2: TVector2f): Tmat3x2;

operator * (const m1, m2: Tmat4x4) res: Tmat4x4;

// === Privater Teil ===

implementation

operator * (const m1, m2: Tmat4x4) res: Tmat4x4;
var
  i, j, k: integer;
begin
  for i := 0 to 3 do begin
    for j := 0 to 3 do begin
      Res[i, j] := 0;
      for k := 0 to 3 do begin
        Res[i, j] := Res[i, j] + m2[i, k] * m1[k, j];
      end;
    end;
  end;
end;

function mat3(v0, v1, v2: TVector3f): Tmat3x3; inline;
begin
  Result[0] := v0;
  Result[1] := v1;
  Result[2] := v2;
end;

function mat3x2(v0, v1, v2: TVector2f): Tmat3x2; inline;
begin
  Result[0] := v0;
  Result[1] := v1;
  Result[2] := v2;
end;

{ TMatrix2DHelper }

procedure TMatrix2DHelper.Identity;
const
  m: TMat3x3 = ((1.0, 0.0, 0.0), (0.0, 1.0, 0.0), (0.0, 0.0, 1.0));
begin
  Self := m;
end;

procedure TMatrix2DHelper.Scale(x, y: single);
var
  i: integer;
begin
  for i := 0 to 1 do begin
    Self[i, 0] := Self[i, 0] * x;
    Self[i, 1] := Self[i, 1] * y;
  end;
end;

procedure TMatrix2DHelper.Scale(s: single);
begin
  Scale(s, s);
end;

procedure TMatrix2DHelper.Translate(x, y: single);
begin
  Self[2, 0] := Self[2, 0] + x;
  Self[2, 1] := Self[2, 1] + y;
end;

procedure TMatrix2DHelper.Rotate(w: single);
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

procedure TMatrix2DHelper.Multiply(m1, m2: TMatrix2D);
var
  i, j, k: integer;
  m: TMat3x3;
begin
  for  i := 0 to 2 do begin
    for j := 0 to 2 do begin
      m[i, j] := 0;
      for k := 0 to 2 do begin
        m[i, j] := m[i, j] + m2[i, k] * m1[k, j];
      end;
    end;
  end;
  Self := m;
end;

procedure TMatrix2DHelper.Uniform(ShaderID: GLint);
begin
  glUniformMatrix3fv(ShaderID, 1, False, @Self);
end;

function TMatrix2DHelper.Vektor_Multi(Vector: TVector3f): TVector3f;
var
  i: integer;
begin
  for i := 0 to 2 do begin
    Result[i] := Self[0, i] * Vector[0] + Self[1, i] * Vector[1] + Self[2, i] * Vector[2];
  end;
end;

procedure TMatrix2DHelper.Shear(x, y: single);
begin
  Self[0, 1] += y;
  Self[1, 0] += x;
end;

procedure TMatrix2DHelper.Frustum(left, right, zNear, zFar: single); // geht nicht.
begin
  Identity;
  Self[0, 0] := 2 * zNear / (right - left);
  Self[1, 0] := (right + left) / (right - left);
  Self[1, 1] := -(zFar + zNear) / (zFar - zNear);
  Self[1, 2] := -1;
  Self[2, 1] := -2 * zFar * zNear / (zFar - zNear);
  Self[2, 2] := 0;
end;

{ TMatrix }

procedure TMatrixHelper.Identity;
const
  m: Tmat4x4 = ((1.0, 0.0, 0.0, 0.0), (0.0, 1.0, 0.0, 0.0), (0.0, 0.0, 1.0, 0.0), (0.0, 0.0, 0.0, 1.0));
begin
  Self := m;
end;

procedure TMatrixHelper.Ortho(left, right, bottom, top, znear, zfar: single);
begin
  Identity;
  Self[0, 0] := 2 / (right - left);
  Self[1, 1] := 2 / (top - bottom);
  Self[2, 2] := -2 / (zfar - znear);
  Self[3, 0] := -(right + left) / (right - left);
  Self[3, 1] := -(top + bottom) / (top - bottom);
  Self[3, 2] := -(zfar + znear) / (zfar - znear);
end;

procedure TMatrixHelper.Frustum(left, right, bottom, top, znear, zfar: single);
begin
  Identity;
  Self[0, 0] := 2 * znear / (right - left);
  Self[1, 1] := 2 * znear / (top - bottom);
  Self[2, 0] := (right + left) / (right - left);
  Self[2, 1] := (top + bottom) / (top - bottom);
  Self[2, 2] := -(zfar + znear) / (zfar - znear);
  Self[2, 3] := -1;
  Self[3, 2] := -2 * zfar * znear / (zfar - znear);
  Self[3, 3] := 0;
end;

procedure TMatrixHelper.Perspective(fovy, aspect, znear, zfar: single);
var
  p, right, top: single;
begin
  p := fovy * Pi / 360;
  top := znear * (sin(p) / cos(p));
  //    top := znear * tan(p);
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

procedure TMatrixHelper.Rotate(Winkel: GLfloat; a: TVector3f);
begin
  Rotate(Winkel, a[0], a[1], a[2]);
end;

procedure TMatrixHelper.Translate(x, y, z: GLfloat); inline;
begin
  Self[3, 0] += x;
  Self[3, 1] += y;
  Self[3, 2] += z;
end;

procedure TMatrixHelper.Translate(v: TVector3f); inline;
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

procedure TMatrixHelper.Multiply(const m1t, m2t: TMatrix);
var
  x, y, i: integer;
  m: Tmat4x4;
begin
  for x := 0 to 3 do begin
    for y := 0 to 3 do begin
      m[x, y] := 0;
      for i := 0 to 3 do begin
        m[x, y] += m1t[i, y] * m2t[x, i];
      end;
    end;
  end;
  Self := m;
end;

procedure TMatrixHelper.Uniform(ShaderID: GLint);
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
