unit oglVector;

{$modeswitch typehelpers}

interface

uses
  Classes, SysUtils, Dialogs, Clipbrd, dglOpenGL;

type
  TglFloatArray = array of glFloat;

  TVector2f = array[0..1] of GLfloat;
  TVector3f = array[0..2] of GLfloat;
  TVector4f = array[0..3] of GLfloat;

  TFace3D = array[0..2] of TVector3f;
  TFace3DArray = array of TFace3D;

  { TVector2fHelper }

  TVector2fHelper = type Helper for TVector2f
  private
    function GetX: GLfloat;
    function GetY: GLfloat;
    procedure SetX(AValue: GLfloat);
    procedure SetY(AValue: GLfloat);
  public
    property x: GLfloat read GetX write SetX;
    property y: GLfloat read GetY write SetY;
    procedure Rotate(Winkel: GLfloat);
    procedure Scale(Ax, Ay: GLfloat);
    procedure Translate(Ax, Ay: GLfloat);
    procedure Scale(s: GLfloat);
    procedure NormalCut;
    procedure Negate;
  end;

  { TVector3fHelper }

  TVector3fHelper = type Helper for TVector3f
  private
    function GetX: GLfloat;
    function GetY: GLfloat;
    function GetZ: GLfloat;
    function Getxy: TVector2f;
    procedure SetX(AValue: GLfloat);
    procedure SetY(AValue: GLfloat);
    procedure SetZ(AValue: GLfloat);
    procedure SetXY(AValue: TVector2f);
  public
    property x: GLfloat read GetX write SetX;
    property y: GLfloat read GetY write SetY;
    property z: GLfloat read GetZ write SetZ;
    property xy: TVector2f read GetXY write SetXY;

    procedure RotateA(Winkel: GLfloat);
    procedure RotateB(Winkel: GLfloat);
    procedure RotateC(Winkel: GLfloat);
    procedure Scale(Ax, Ay, Az: GLfloat);
    procedure Scale(s: GLfloat);
    procedure Translate(Ax, Ay, Az: GLfloat);
    procedure NormalCut;
    procedure Negate;

    procedure FromInt(i: UInt32);

    procedure WriteVectoren(var Vector: array of TVector3f);   // Für Testzwecke
    procedure WriteVectoren_and_Normal(var Vectoren, Normal: array of TVector3f);
  end;

  { TVector4fHelper }

  TVector4fHelper = type Helper for TVector4f
  private
    function GetX: GLfloat;
    function GetXYZ: TVector3f;
    function GetY: GLfloat;
    function GetZ: GLfloat;
    procedure SetX(AValue: GLfloat);
    procedure SetXYZ(AValue: TVector3f);
    procedure SetY(AValue: GLfloat);
    procedure SetZ(AValue: GLfloat);
  public
    property x: GLfloat read GetX write SetX;
    property y: GLfloat read GetY write SetY;
    property z: GLfloat read GetZ write SetZ;
    property xyz: TVector3f read GetXYZ write SetXYZ;

    function ToInt: Uint32;
    procedure FromInt(i: UInt32);
    procedure Scale(Ax, Ay, Az: GLfloat);
    procedure Scale(Ax, Ay, Az, Aw: GLfloat);
    procedure Scale(s: GLfloat);
  end;

function vec2(x, y: GLfloat): TVector2f;
function vec3(x, y, z: GLfloat): TVector3f;
function vec3(v: TVector2f; z: GLfloat): TVector3f; inline;
function vec4(x, y, z, w: GLfloat): TVector4f; overload;
function vec4(xyz: TVector3f; w: GLfloat): TVector4f; overload;

procedure FaceToNormale(var Face, Normal: array of TFace3D);


implementation

procedure FaceToNormale(var Face, Normal: array of TFace3D);

  function GetCrossProduct(P0, P1, P2: TVector3f): TVector3f;
  var
    a, b: TVector3f;
    i: integer;
  begin
    for i := 0 to 2 do begin
      a[i] := P1[i] - P0[i];
      b[i] := P2[i] - P0[i];
    end;
    Result[0] := a[1] * b[2] - a[2] * b[1];
    Result[1] := a[2] * b[0] - a[0] * b[2];
    Result[2] := a[0] * b[1] - a[1] * b[0];

    Result.NormalCut;
    ;
  end;

var
  i: integer;
  v: TVector3f;

begin
  if Length(Normal) < Length(Face) then begin
    ShowMessage('Fehler: Lenght(Normal) <> Length(Face)');
    Exit;
  end;
  for i := 0 to Length(Face) - 1 do begin
    v := GetCrossProduct(Face[i, 0], Face[i, 1], Face[i, 2]);
    Normal[i, 0] := v;
    Normal[i, 1] := v;
    Normal[i, 2] := v;
  end;
end;

function vec2(x, y: GLfloat): TVector2f; inline;
begin
  Result[0] := x;
  Result[1] := y;
end;

function vec3(x, y, z: GLfloat): TVector3f; inline;
begin
  Result[0] := x;
  Result[1] := y;
  Result[2] := z;
end;

function vec3(v: TVector2f; z: GLfloat): TVector3f; inline;
begin
  Result[0] := v[0];
  Result[1] := v[1];
  Result[2] := z;
end;

function vec4(x, y, z, w: GLfloat): TVector4f; inline;
begin
  Result[0] := x;
  Result[1] := y;
  Result[2] := z;
  Result[3] := w;
end;

function vec4(xyz: TVector3f; w: GLfloat): TVector4f; inline;
begin
  Result[0] := xyz[0];
  Result[1] := xyz[1];
  Result[2] := xyz[2];
  Result[3] := w;
end;

{ TVector2fHelper }

function TVector2fHelper.GetX: GLfloat; inline;
begin
  Result := Self[0];
end;

function TVector2fHelper.GetY: GLfloat; inline;
begin
  Result := Self[1];
end;

procedure TVector2fHelper.SetX(AValue: GLfloat); inline;
begin
  Self[0] := AValue;
end;

procedure TVector2fHelper.SetY(AValue: GLfloat); inline;
begin
  Self[1] := AValue;
end;

procedure TVector2fHelper.Rotate(Winkel: GLfloat);
var
  x0, y0, c, s: GLfloat;
begin
  c := cos(Winkel);
  s := sin(Winkel);
  x0 := Self[0];
  y0 := Self[1];
  Self[0] := x0 * c - y0 * s;
  Self[1] := x0 * s + y0 * c;
end;

procedure TVector2fHelper.Scale(Ax, Ay: GLfloat); inline;
begin
  Self[0] *= Ax;
  Self[1] *= Ay;
end;

procedure TVector2fHelper.Scale(s: GLfloat); inline;
begin
  Scale(s, s);
end;

procedure TVector2fHelper.Translate(Ax, Ay: GLfloat);
begin
  Self[0] += Ax;
  Self[1] += Ay;
end;

procedure TVector2fHelper.NormalCut;
var
  i: integer;
  l: GLfloat;
begin
  l := Sqrt(Sqr(Self[0]) + Sqr(Self[1]));
  if l = 0 then begin
    l := 1.0;
  end;
  for i := 0 to 1 do begin
    Self[i] := Self[i] / l;
  end;
end;

procedure TVector2fHelper.Negate; inline;
begin
  Self[0] *= (-1);
  Self[1] *= (-1);
end;


{ TVector3fHelper }

function TVector3fHelper.GetX: GLfloat; inline;
begin
  Result := Self[0];
end;

function TVector3fHelper.GetY: GLfloat; inline;
begin
  Result := Self[1];
end;

function TVector3fHelper.GetZ: GLfloat; inline;
begin
  Result := Self[2];
end;

procedure TVector3fHelper.SetX(AValue: GLfloat); inline;
begin
  Self[0] := AValue;
end;

procedure TVector3fHelper.SetY(AValue: GLfloat); inline;
begin
  Self[1] := AValue;
end;

procedure TVector3fHelper.SetZ(AValue: GLfloat); inline;
begin
  Self[2] := AValue;
end;

function TVector3fHelper.Getxy: TVector2f; inline;
begin
  Result[0] := Self[0];
  Result[1] := Self[1];
end;

procedure TVector3fHelper.SetXY(AValue: TVector2f); inline;
begin
  Self[0] := AValue[0];
  Self[1] := AValue[1];
end;

procedure TVector3fHelper.RotateA(Winkel: GLfloat);
var
  y0, z0, c, s: GLfloat;
begin
  c := cos(Winkel);
  s := sin(Winkel);
  y0 := Self[1];
  z0 := Self[2];
  Self[1] := y0 * c - z0 * s;
  Self[2] := y0 * s + z0 * c;
end;

procedure TVector3fHelper.RotateB(Winkel: GLfloat);
var
  x0, z0, c, s: GLfloat;
begin
  c := cos(Winkel);
  s := sin(Winkel);
  x0 := Self[0];
  z0 := Self[2];
  Self[0] := x0 * c - z0 * s;
  Self[2] := x0 * s + z0 * c;
end;

procedure TVector3fHelper.RotateC(Winkel: GLfloat);
var
  x0, y0, c, s: GLfloat;
begin
  c := cos(Winkel);
  s := sin(Winkel);
  x0 := Self[0];
  y0 := Self[1];
  Self[0] := x0 * c - y0 * s;
  Self[1] := x0 * s + y0 * c;
end;

procedure TVector3fHelper.Scale(Ax, Ay, Az: GLfloat);
begin
  Self[0] *= Ax;
  Self[1] *= Ay;
  Self[2] *= Az;
end;

procedure TVector3fHelper.Scale(s: GLfloat); inline;
begin
  Scale(s, s, s);
end;

procedure TVector3fHelper.Translate(Ax, Ay, Az: GLfloat);
begin
  Self[0] += Ax;
  Self[1] += Ay;
  Self[2] += Az;
end;

procedure TVector3fHelper.NormalCut;
var
  i: integer;
  l: GLfloat;
begin
  l := Sqrt(Sqr(Self[0]) + Sqr(Self[1]) + Sqr(Self[2]));
  if l = 0 then begin
    l := 1.0;
  end;
  for i := 0 to 2 do begin
    Self[i] := Self[i] / l;
  end;
end;

procedure TVector3fHelper.Negate;
var
  i: integer;
begin
  for i := 0 to 2 do begin
    Self[i] *= (-1);
  end;
end;

procedure TVector3fHelper.FromInt(i: UInt32);
begin
  Self[0] := i div $10000 mod $100 / $FF;
  Self[1] := i div $100 mod $100 / $FF;
  Self[2] := i div $1 mod $100 / $FF;
end;

procedure TVector3fHelper.WriteVectoren(var Vector: array of TVector3f);
var
  i: integer;
  s: string;

  function f(f1: GLfloat): string;
  begin
    f := FormatFloat('###0.00', f1) + '  ';
    if Pos('-', f) = 0 then begin
      f := ' ' + f;
    end;
  end;

begin
  s := '';
  for i := 0 to Length(Vector) - 1 do begin
    if i mod 3 = 0 then begin
      s := s + 'Vectoren:' + #13#10;
    end;
    s := s + 'x: ' + f(Vector[i, 0]) + 'y: ' + f(Vector[i, 1]) + 'z: ' + f(Vector[i, 2]);
    if i mod 3 = 2 then begin
      s := s + #13#10#13#10;
    end else begin
      s := s + ' ';
    end;
  end;
  Clipboard.AsText := s;
end;


procedure TVector3fHelper.WriteVectoren_and_Normal(var Vectoren,
  Normal: array of TVector3f);
var
  n, i: integer;
  s: string;

  function f(f1: GLfloat): string;
  begin
    Result := FormatFloat('###0.00', f1) + '  ';
    if Pos('-', Result) = 0 then begin
      Result := ' ' + Result;
    end;
  end;

begin
  s := '';
  if Length(Vectoren) <> Length(Normal) then begin
    s := 'Fehler: Ungleiche Anzahl Normale und Vectoren!';
  end else begin
    for i := 0 to (Length(Vectoren) div 3) - 1 do begin
      n := i * 3;
      s := s + 'Vectoren:' + #13#10;
      s := s + 'x: ' + f(Vectoren[n + 0, 0]) + 'y: ' + f(Vectoren[n + 0, 1]) + 'z: ' + f(Vectoren[n + 0, 2]) + '     ';
      s := s + 'x: ' + f(Vectoren[n + 1, 0]) + 'y: ' + f(Vectoren[n + 1, 1]) + 'z: ' + f(Vectoren[n + 1, 2]) + '     ';
      s := s + 'x: ' + f(Vectoren[n + 2, 0]) + 'y: ' + f(Vectoren[n + 2, 1]) + 'z: ' + f(Vectoren[n + 2, 2]) + #13#10;
      s := s + 'Normale:' + #13#10;
      s := s + 'x: ' + f(Normal[n + 0, 0]) + 'y: ' + f(Normal[n + 0, 1]) + 'z: ' + f(Normal[n + 0, 2]) + '     ';
      s := s + 'x: ' + f(Normal[n + 1, 0]) + 'y: ' + f(Normal[n + 1, 1]) + 'z: ' + f(Normal[n + 1, 2]) + '     ';
      s := s + 'x: ' + f(Normal[n + 2, 0]) + 'y: ' + f(Normal[n + 2, 1]) + 'z: ' + f(Normal[n + 2, 2]) + #13#10#13#10;
    end;
  end;
  ShowMessage('Vectoren und Normale' + LineEnding + s);
end;

{ TVector4fHelper }

function TVector4fHelper.GetX: GLfloat; inline;
begin
  Result := Self[0];
end;

function TVector4fHelper.GetY: GLfloat; inline;
begin
  Result := Self[1];
end;

function TVector4fHelper.GetZ: GLfloat; inline;
begin
  Result := Self[2];
end;

function TVector4fHelper.GetXYZ: TVector3f; inline;
begin
  Result[0] := Self[0];
  Result[1] := Self[1];
  Result[2] := Self[2];
end;

procedure TVector4fHelper.SetX(AValue: GLfloat); inline;
begin
  Self[0] := AValue;
end;

procedure TVector4fHelper.SetY(AValue: GLfloat); inline;
begin
  Self[1] := AValue;
end;

procedure TVector4fHelper.SetZ(AValue: GLfloat); inline;
begin
  Self[2] := AValue;
end;

procedure TVector4fHelper.SetXYZ(AValue: TVector3f); inline;
begin
  Self[0] := AValue[0];
  Self[1] := AValue[1];
  Self[2] := AValue[2];
end;

function TVector4fHelper.ToInt: Uint32;

  function v(s: single): longword; inline;
  begin
    Result := Round(s * $FF);
  end;

var
  i: integer;
begin
  for i := 0 to 3 do begin
    if Self[i] < 0.0 then begin
      Self[i] := 0.0;
    end;
    if Self[i] > 1.0 then begin
      Self[i] := 1.0;
    end;
  end;
  Result := v(Self[0]) + v(Self[1]) * $100 + v(Self[2]) * $10000 + v(Self[3]) * $1000000;
end;

procedure TVector4fHelper.FromInt(i: UInt32);
begin
  Self[0] := i div $10000 mod $100 / $FF;
  Self[1] := i div $100 mod $100 / $FF;
  Self[2] := i div $1 mod $100 / $FF;
  Self[3] := i div $1000000 / $FF;
end;

procedure TVector4fHelper.Scale(Ax, Ay, Az: GLfloat); inline;
begin
  Self[0] *= Ax;
  Self[1] *= Ay;
  Self[2] *= Az;
end;

procedure TVector4fHelper.Scale(Ax, Ay, Az, Aw: GLfloat); inline;
begin
  Self[0] *= Ax;
  Self[1] *= Ay;
  Self[2] *= Az;
  Self[3] *= Aw;
end;

procedure TVector4fHelper.Scale(s: GLfloat); inline;
begin
  Scale(s, s, s, s);
end;

end.


