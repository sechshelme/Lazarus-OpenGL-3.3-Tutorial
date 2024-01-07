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

type
  TVector2f = array [0..1] of GLfloat;
  TVector3f = array [0..2] of GLfloat;
  TSingleArray = array[0..15] of GLfloat;
  TMatrix = array[0..3, 0..3] of GLfloat;

  { TMatrixfHelper }

  TMatrixfHelper = type Helper for TMatrix
    procedure Indenty;
    procedure RotateC(angele: GLfloat);
    procedure Translate(v: TVector3f);
    procedure Translate(x, y, z: GLfloat);
    procedure TranslateLocalspace(x, y, z: GLfloat);

    function GetFloatList: TSingleArray;

    procedure Uniform(ShaderID: TJSWebGLUniformLocation);
  end;

implementation

procedure TMatrixfHelper.Indenty;
begin
  Self := [[1.0, 0.0, 0.0, 0.0], [0.0, 1.0, 0.0, 0.0], [0.0, 0.0, 1.0, 0.0], [0.0, 0.0, 0.0, 1.0]];
end;

procedure TMatrixfHelper.RotateC(angele: GLfloat);
var
  i: integer;
  x, y: GLfloat;
begin
  for i := 0 to 1 do begin
    x := Self[i, 0];
    y := Self[i, 1];
    Self[i, 0] := x * cos(angele) - y * sin(angele);
    Self[i, 1] := x * sin(angele) + y * cos(angele);
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

end.
