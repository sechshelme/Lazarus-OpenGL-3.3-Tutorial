unit wglMatrix;

{$modeswitch typehelpers}
{$modeswitch arrayoperators}
//{$modeswitch multihelpers}
{$modeswitch advancedrecords}

interface

uses
  Types, SysUtils,
  BrowserConsole, WebGL, JS,
  wglCommon;

var
  isGold:Boolean=False;
  Geschnitten:Boolean=True;

type
  TVector2f = array [0..1] of GLfloat;
  TVector3f = array [0..2] of GLfloat;
  TVector4f = array [0..3] of GLfloat;
  TSingleArray = array[0..15] of GLfloat;
  TMatrix = array[0..3, 0..3] of GLfloat;

  { TMatrixfHelper }

  TMatrixfHelper = type Helper for TMatrix
    procedure Identity;

      procedure Ortho(left, right, bottom, top, znear, zfar: GLfloat);
    //    FrustumMatrix.Frustum(-w, w, -w, w, 2.5, 1000.0);
    procedure Frustum(left, right, bottom, top, znear, zfar: GLfloat);
    //    FrustumMatrix.Perspective(45, ClientWidth / ClientHeight, 2.5, 1000.0);
    procedure Perspective(fovy, aspect, znear, zfar: GLfloat);

    procedure Scale(Faktor: TVector3f);
    procedure Scale(Faktor: GLfloat);
    procedure RotateA(angele: GLfloat);
    procedure RotateB(angele: GLfloat);
    procedure RotateC(angele: GLfloat);
    procedure Translate(v: TVector3f);
    procedure Translate(x, y, z: GLfloat);
    procedure TranslateLocalspace(x, y, z: GLfloat);

    function GetFloatList: TSingleArray;

    procedure Uniform(ShaderID: TJSWebGLUniformLocation);
  end;

function MatrixMultiple(const mat0, mat1: TMatrix):TMatrix;

var
  WorldMatrix,
  ObjectMatrix,
  GlobusMatrix,
  CloudsMatrix,
  mProjectionMatrix,
  mRotationMatrix: TMatrix;

implementation

procedure TMatrixfHelper.Identity;
begin
  Self := [[1.0, 0.0, 0.0, 0.0], [0.0, 1.0, 0.0, 0.0], [0.0, 0.0, 1.0, 0.0], [0.0, 0.0, 0.0, 1.0]];
end;

procedure TMatrixfHelper.Ortho(left, right, bottom, top, znear, zfar: GLfloat);
begin
  Identity;
  Self[0, 0] := 2 / (right - left);
  Self[1, 1] := 2 / (top - bottom);
  Self[2, 2] := -2 / (zfar - znear);
  Self[3, 0] := -(right + left) / (right - left);
  Self[3, 1] := -(top + bottom) / (top - bottom);
  Self[3, 2] := -(zfar + znear) / (zfar - znear);
end;

procedure TMatrixfHelper.Frustum(left, right, bottom, top, znear, zfar: GLfloat  );
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

procedure TMatrixfHelper.Perspective(fovy, aspect, znear, zfar: GLfloat);
var
  p, right, top: GLfloat;
begin
  p := fovy * Pi / 360;
  top := znear * (sin(p) / cos(p)); // top := znear * tan(p);
  right := top * aspect;
  Frustum(-right, right, -top, top, znear, zfar);
end;

procedure TMatrixfHelper.Scale(Faktor: TVector3f);
var
  i: integer;
begin
  for i := 0 to 2 do begin
    Self[i, 0] *= Faktor[0];
    Self[i, 1] *= Faktor[1];
    Self[i, 2] *= Faktor[2];
  end;
end;

procedure TMatrixfHelper.Scale(Faktor: GLfloat);
var
  i: integer;
begin
  for i := 0 to 2 do begin
    Self[i, 0] *= Faktor;
    Self[i, 1] *= Faktor;
    Self[i, 2] *= Faktor;
  end;
end;

procedure TMatrixfHelper.RotateA(angele: GLfloat);
var
  i: integer;
  y, z, c, s: GLfloat;
begin
  c := cos(angele);
  s := sin(angele);
  for i := 0 to 2 do begin
    y := Self[i, 1];
    z := Self[i, 2];
    Self[i, 1] := y * c - z * s;
    Self[i, 2] := y * s + z * c;
  end;
end;

procedure TMatrixfHelper.RotateB(angele: GLfloat);
var
  i: integer;
  x, z, c, s: GLfloat;
begin
  c := cos(angele);
  s := sin(angele);
  for i := 0 to 2 do begin
    x := Self[i, 0];
    z := Self[i, 2];
    Self[i, 0] := x * c - z * s;
    Self[i, 2] := x * s + z * c;
  end;
end;

procedure TMatrixfHelper.RotateC(angele: GLfloat);
var
  i: integer;
  x, y, c, s: GLfloat;
begin
  c := cos(angele);
  s := sin(angele);
  for i := 0 to 2 do begin
    x := Self[i, 0];
    y := Self[i, 1];
    Self[i, 0] := x * c - y * s;
    Self[i, 1] := x * s + y * c;
  end;
end;

procedure TMatrixfHelper.Translate(v: TVector3f);
begin
  Self[3, 0] += v[0];
  Self[3, 1] += v[1];
  Self[3, 2] += v[2];
end;

procedure TMatrixfHelper.Translate(x, y, z: GLfloat);
begin
  Self[3, 0] += x;
  Self[3, 1] += y;
  Self[3, 2] += z;
end;

procedure TMatrixfHelper.TranslateLocalspace(x, y, z: GLfloat);
var
  i: integer;
begin
  for i := 0 to 3 do begin
    Self[3, i] += Self[0, i] * x + Self[1, i] * y + Self[2, i] * z;
  end;
end;

function TMatrixfHelper.GetFloatList: TSingleArray;
var
  x, y: integer;
begin
  for x := 0 to 3 do begin
    for y := 0 to 3 do begin
      Result[x * 4 + y] := Self[x, y];
    end;
  end;
end;

procedure TMatrixfHelper.Uniform(ShaderID: TJSWebGLUniformLocation);
type
  //  PFloat32List=^Single;
  //  PSingleArray=^TSingleArray;

  t = array[0..15] of GLfloat;
  t2 = JSValue;
  ta = TSingleArray;
var
  m: TMatrix;
  i: integer;
  a: ta;

  v: array[0..2] of single;


begin
  //  a := (self[1]);

  //  for i:=0 to Length(m)-1 do Write(m[i],'  ');
  //  Writeln;

  //  a:=Value.GetFloatList;
  //    Writeln('len: ', Length(a));

  //  gl.uniformMatrix4fv(UniformLocation(Name), False,  JSValue(Value));
  // gl.uniformMatrix4fv(UniformLocation(Name), False, Value.GetFloatList);
  //gl.uniformMatrix4fv(UniformLocation(Name), False,t( Value));
  //  gl.uniformMatrix4fv(ShaderID, False, m);

  gl.uniformMatrix4fv(ShaderID, False, Self.GetFloatList);
end;

function MatrixMultiple(const mat0, mat1: TMatrix): TMatrix;
var
  i, j, k: integer;
begin
  for i := 0 to 3 do begin
    for j := 0 to 3 do begin
      Result[i, j] := 0.0;
      for k := 0 to 3 do begin
        Result[i, j] += mat1[i, k] * mat0[k, j];
      end;
    end;
  end;
end;

begin
  WorldMatrix.Identity;
  ObjectMatrix.Identity;
  GlobusMatrix.Identity;
  CloudsMatrix.Identity;
  mProjectionMatrix.Identity;
  mRotationMatrix.Identity;
end.
