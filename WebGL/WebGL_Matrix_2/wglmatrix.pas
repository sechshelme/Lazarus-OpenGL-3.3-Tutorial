unit wglMatrix;

{$modeswitch typehelpers}

interface

uses
  Types, SysUtils,
  BrowserConsole, WebGL, JS,
  MemoryBuffer, GLUtils;

type
  TVector3f = array [0..2] of GLfloat;

  TSingleArray = array[0..15] of GLfloat;

  TMatrix = array[0..3, 0..3] of GLfloat;

  { TMatrixfHelper }

  TMatrixfHelper = type Helper for TMatrix
    procedure Indenty;
    procedure RotateC(angele: GLfloat);
    function GetFloatList: TSingleArray;

    procedure Uniform(ShaderID: TJSWebGLUniformLocation);
  end;

implementation

procedure TMatrixfHelper.Indenty;
const
  MatrixIndenty: TMatrix = ((1.0, 0.0, 0.0, 0.0), (0.0, 1.0, 0.0, 0.0), (0.0, 0.0, 1.0, 0.0), (0.0, 0.0, 0.0, 1.0));
begin
  Self := MatrixIndenty;
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

function TMatrixfHelper.GetFloatList: TSingleArray;
var
  x, y: integer;
begin
  for x := 0 to 3 do begin
    for y := 0 to 3 do begin
      Result[x + y * 4] := Self[x, y];
    end;
  end;
end;

procedure TMatrixfHelper.Uniform(ShaderID: TJSWebGLUniformLocation);
type
  //  PFloat32List=^Single;
  //  PSingleArray=^TSingleArray;

  t = array[0..15] of GLfloat;
  t2 = JSValue;
  ta = array of GLfloat;
var
  m: t absolute self;
  i: integer;
  a: t;
begin
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
