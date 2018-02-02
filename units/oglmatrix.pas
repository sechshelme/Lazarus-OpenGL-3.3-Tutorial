unit oglMatrix;

{$mode objfpc}{$H+}
{$modeswitch typehelpers}

interface

uses
  SysUtils, Forms, Dialogs, Clipbrd, dglOpenGL;

type
  TglFloatArray = array of glFloat;

  TVector2f = array[0..1] of GLfloat;
  TVector3f = array[0..2] of GLfloat;
  TVector4f = array[0..3] of GLfloat;

  Tmat2x2 = array[0..1] of TVector2f;
  Tmat3x3 = array[0..2] of TVector3f;
  Tmat4x4 = array[0..3] of TVector4f;

  Tmat3x2 = array[0..2] of TVector2f;
  Tmat3x4 = array[0..2] of TVector4f;

  TFace3D = Tmat3x3;
  TFace3DArray = array of TFace3D;

  { TVector2fHelper }

  TVector2fHelper = Type Helper for TVector2f
  private
    function GetX: GLfloat;
    function GetY: GLfloat;
    procedure SetX(AValue: GLfloat);
    procedure SetY(AValue: GLfloat);
  public
    property x: GLfloat read GetX write SetX;
    property y: GLfloat read GetY write SetY;
    procedure Rotate(Winkel: GLfloat);
    procedure Scale(x, y: GLfloat);
    procedure Scale(s: GLfloat);
    procedure NormalCut;
    procedure Negate;
  end;

  { TVector3fHelper }

  TVector3fHelper = Type Helper for TVector3f
  private
    function GetX: GLfloat;
    function Getxy: TVector2f;
    function GetY: GLfloat;
    function GetZ: GLfloat;
    procedure SetX(AValue: GLfloat);
    procedure SetXY(AValue: TVector2f);
    procedure SetY(AValue: GLfloat);
    procedure SetZ(AValue: GLfloat);
  public
    property xy: TVector2f read GetXY write SetXY;
    property x: GLfloat read GetX write SetX;
    property y: GLfloat read GetY write SetY;
    property z: GLfloat read GetZ write SetZ;

    procedure RotateA(Winkel: GLfloat);
    procedure RotateB(Winkel: GLfloat);
    procedure RotateC(Winkel: GLfloat);
    procedure Scale(x, y, z: GLfloat);
    procedure Scale(s: GLfloat);
    procedure NormalCut;
    procedure Negate;

    procedure WriteVectoren(var Vector: array of TVector3f);   // Für Testzwecke
    procedure WriteVectoren_and_Normal(var Vectoren, Normal: array of TVector3f);
  end;

  { TVector4fHelper }

  TVector4fHelper = Type Helper for TVector4f
  public
    function VectorToWord: LongWord;
    procedure WordToVector(w: longword);
    procedure Scale(x, y, z, w: GLfloat);
    procedure Scale(s: GLfloat);
  end;

  { TMatrix2D }

  TMatrix2D = class(TObject)   // Arbeitet nicht richtig mit Shader zusammen
  private
    FMatrix: TMat3x3;
    BackupMatrix: array of Tmat3x3;
  public
    property Matrix: TMat3x3 read FMatrix;

    constructor Create;
    procedure Identity;
    procedure Assign(m: TMatrix2D);
    procedure Multiply(m1, m2: TMatrix2D);

    procedure Push;             // Legt aktuelle Matrix auf Stack
    procedure Pop;              // Holt Matrix vom Stack
    procedure LoadStack;        // Gibt aktuelle Matrix vom Stack, Stack bleibt gleich

    procedure Uniform(ShaderID: GLint);

    procedure Scale(x, y: single); overload;
    procedure Scale(s: single); overload;
    procedure Translate(x, y: single);
    procedure Rotate(w: single);
    procedure Shear(x, y: single);

    function Vektor_Multi(Vector: TVector3f): TVector3f;

    procedure SetMatrix(m: TMat3x3);

    procedure Frustum(left, right, zNear, zFar: single);       // ??????????????
  end;

  { TMatrix }

  TMatrix = class(TObject)
  private
    FMatrix: Tmat4x4;
    BackupMatrix: array of Tmat4x4;
  public
    constructor Create;
    procedure Identity;
    procedure Assign(m: TMatrix);
    procedure Multiply(const m1t, m2t: TMatrix);

    procedure Push;             // Legt aktuelle Matrix auf Stack
    procedure Pop;              // Holt Matrix vom Stack
    procedure LoadStack;        // Gibt aktuelle Matrix vom Stack, Stack bleibt gleich

    procedure Uniform(ShaderID: GLint);

    procedure Ortho(left, right, bottom, top, znear, zfar: single);
    procedure Frustum(left, right, bottom, top, znear, zfar: single);
    procedure Perspective(fovy, aspect, znear, zfar: single);

    procedure Rotate(Winkel, x, y, z: GLfloat); overload;
    procedure Rotate(Winkel: GLfloat; a: TVector3f); overload;
    procedure RotateA(Winkel: GLfloat);
    procedure RotateB(Winkel: GLfloat);
    procedure RotateC(Winkel: GLfloat);
    procedure Translate(x, y, z: GLfloat);
    procedure NewTranslate(x, y, z: GLfloat);
    procedure Scale(Faktor: GLfloat); overload;
    procedure Scale(FaktorX, FaktorY, FaktorZ: GLfloat); overload;
    procedure Transpose;

    procedure WriteMatrix;   // Für Testzwecke
  end;

function vec2(x, y: GLfloat): TVector2f;
function vec3(x, y, z: GLfloat): TVector3f;
function vec3(v: TVector2f; z: GLfloat): TVector3f; inline;
function vec4(x, y, z, w: GLfloat): TVector4f; overload;
function vec4(xyz: TVector3f; w: GLfloat): TVector4f; overload;

function mat3(v0, v1, v2: TVector3f): Tmat3x3;
function mat3x2(v0, v1, v2: TVector2f): Tmat3x2;

procedure FaceToNormale(var Face, Normal: array of TFace3D);


operator * (const m1, m2: Tmat4x4) res: Tmat4x4;


implementation

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

procedure FaceToNormale(var Face, Normal: array of TFace3D);

    function GetCrossProduct(P0, P1, P2: TVector3f): TVector3f;
    var
      a, b: TVector3f;
      i: Integer;
    begin
      for i := 0 to 2 do begin
        a[i] := P1[i] - P0[i];
        b[i] := P2[i] - P0[i];
      end;
      Result[0] := a[1] * b[2] - a[2] * b[1];
      Result[1] := a[2] * b[0] - a[0] * b[2];
      Result[2] := a[0] * b[1] - a[1] * b[0];

      Result.NormalCut;;
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
  x, y, c, s: GLfloat;
begin
  c := cos(Winkel);
  s := sin(Winkel);
  x := Self[0];
  y := Self[1];
  Self[0] := x * c - y * s;
  Self[1] := x * s + y * c;
end;

procedure TVector2fHelper.Scale(x, y: GLfloat); inline;
begin
  Self[0] *= x;
  Self[1] *= y;
end;

procedure TVector2fHelper.Scale(s: GLfloat); inline;
begin
  Scale(s, s);
end;

procedure TVector2fHelper.NormalCut;
var
  i: Integer;
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
  y, z, c, s: GLfloat;
begin
  c := cos(Winkel);
  s := sin(Winkel);
  y := Self[1];
  z := Self[2];
  Self[1] := y * c - z * s;
  Self[2] := y * s + z * c;
end;

procedure TVector3fHelper.RotateB(Winkel: GLfloat);
var
  x, z, c, s: GLfloat;
begin
  c := cos(Winkel);
  s := sin(Winkel);
  x := Self[0];
  z := Self[2];
  Self[0] := x * c - z * s;
  Self[2] := x * s + z * c;
end;

procedure TVector3fHelper.RotateC(Winkel: GLfloat);
var
  x, y, c, s: GLfloat;
begin
  c := cos(Winkel);
  s := sin(Winkel);
  x := Self[0];
  y := Self[1];
  Self[0] := x * c - y * s;
  Self[1] := x * s + y * c;
end;

procedure TVector3fHelper.Scale(x, y, z: GLfloat); inline;
begin
  Self[0] *= x;
  Self[1] *= y;
  Self[2] *= z;
end;

procedure TVector3fHelper.Scale(s: GLfloat); inline;
begin
  Scale(s, s, s);
end;

procedure TVector3fHelper.NormalCut;
var
  i: Integer;
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
  i: Integer;
begin
  for i := 0 to 2 do begin
    Self[i] *= (-1);
  end;
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
  Application.MessageBox(PChar(s), 'Vectoren und Normale', 0);
end;

{ TVector4fHelper }

function TVector4fHelper.VectorToWord: LongWord;

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

procedure TVector4fHelper.WordToVector(w: longword);
begin
  Self[0] := w div $10000 mod $100 / $FF;
  Self[1] := w div $100 mod $100 / $FF;
  Self[2] := w div $1 mod $100 / $FF;
  Self[3] := w div $1000000 / $FF;
end;

procedure TVector4fHelper.Scale(x, y, z, w: GLfloat); inline;
begin
  Self[0] *= x;
  Self[1] *= y;
  Self[2] *= z;
//  Self[3] *= w;
end;

procedure TVector4fHelper.Scale(s: GLfloat); inline;
begin
  Scale(s, s, s, s);
end;

{ TMatrix2D }

constructor TMatrix2D.Create;
begin
  inherited Create;
  Identity;
end;

procedure TMatrix2D.Identity;
const
  m: TMat3x3 = ((1.0, 0.0, 0.0), (0.0, 1.0, 0.0), (0.0, 0.0, 1.0));
begin
  FMatrix := m;
end;

procedure TMatrix2D.Assign(m: TMatrix2D);
begin
  FMatrix := m.FMatrix;
end;

procedure TMatrix2D.Scale(x, y: single);
var
  i: integer;
begin
  for i := 0 to 1 do begin
    FMatrix[i, 0] := FMatrix[i, 0] * x;
    FMatrix[i, 1] := FMatrix[i, 1] * y;
  end;
end;

procedure TMatrix2D.Scale(s: single);
begin
  Scale(s, s);
end;

procedure TMatrix2D.Translate(x, y: single);
begin
  FMatrix[2, 0] := FMatrix[2, 0] + x;
  FMatrix[2, 1] := FMatrix[2, 1] + y;
end;

procedure TMatrix2D.Rotate(w: single);
var
  i: integer;
  x, y: GLfloat;
begin
  for i := 0 to 1 do begin
    x := FMatrix[i, 0];
    y := FMatrix[i, 1];
    FMatrix[i, 0] := x * cos(w) - y * sin(w);
    FMatrix[i, 1] := x * sin(w) + y * cos(w);
  end;
end;

procedure TMatrix2D.Multiply(m1, m2: TMatrix2D);
var
  i, j, k: integer;
  m: TMat3x3;
begin
  for  i := 0 to 2 do begin
    for j := 0 to 2 do begin
      m[i, j] := 0;
      for k := 0 to 2 do begin
        m[i, j] := m[i, j] + m2.FMatrix[i, k] * m1.FMatrix[k, j];
      end;
    end;
  end;
  FMatrix := m;
end;

procedure TMatrix2D.Push;
var
  pos: integer;
begin
  pos := Length(BackupMatrix);
  SetLength(BackupMatrix, pos + 1);
  BackupMatrix[pos] := FMatrix;
end;

procedure TMatrix2D.Pop;
var
  pos: integer;
begin
  pos := Length(BackupMatrix) - 1;
  FMatrix := BackupMatrix[pos];
  SetLength(BackupMatrix, pos);
end;

procedure TMatrix2D.LoadStack;
begin
  FMatrix := BackupMatrix[Length(BackupMatrix) - 1];
end;

procedure TMatrix2D.Uniform(ShaderID: GLint);
begin
  glUniformMatrix3fv(ShaderID, 1, False, @FMatrix);
end;

function TMatrix2D.Vektor_Multi(Vector: TVector3f): TVector3f;
var
  i: integer;
begin
  for i := 0 to 2 do begin
    Result[i] := FMatrix[0, i] * Vector[0] + FMatrix[1, i] * Vector[1] + FMatrix[2, i] * Vector[2];
  end;
end;

procedure TMatrix2D.SetMatrix(m: TMat3x3);
begin
  FMatrix := m;
end;

procedure TMatrix2D.Shear(x, y: single);
begin
  FMatrix[0, 1] += y;
  FMatrix[1, 0] += x;
end;

procedure TMatrix2D.Frustum(left, right, zNear, zFar: single); // geht nicht.
begin
  Identity;
  FMatrix[0, 0] := 2 * zNear / (right - left);
  FMatrix[1, 0] := (right + left) / (right - left);
  FMatrix[1, 1] := -(zFar + zNear) / (zFar - zNear);
  FMatrix[1, 2] := -1;
  FMatrix[2, 1] := -2 * zFar * zNear / (zFar - zNear);
  FMatrix[2, 2] := 0;
end;

{ TMatrix }

constructor TMatrix.Create;
begin
  inherited Create;
  Identity;
end;

procedure TMatrix.Identity;
const
  m: Tmat4x4 = ((1.0, 0.0, 0.0, 0.0), (0.0, 1.0, 0.0, 0.0), (0.0, 0.0, 1.0, 0.0), (0.0, 0.0, 0.0, 1.0));
begin
  FMatrix := m;
end;

procedure TMatrix.Assign(m: TMatrix);
begin
  FMatrix := m.FMatrix;
end;

procedure TMatrix.Ortho(left, right, bottom, top, znear, zfar: single);
begin
  Identity;
  FMatrix[0, 0] := 2 / (right - left);
  FMatrix[1, 1] := 2 / (top - bottom);
  FMatrix[2, 2] := -2 / (zfar - znear);
  FMatrix[3, 0] := -(right + left) / (right - left);
  FMatrix[3, 1] := -(top + bottom) / (top - bottom);
  FMatrix[3, 2] := -(zfar + znear) / (zfar - znear);
end;

procedure TMatrix.Frustum(left, right, bottom, top, znear, zfar: single);
begin
  Identity;
  FMatrix[0, 0] := 2 * znear / (right - left);
  FMatrix[1, 1] := 2 * znear / (top - bottom);
  FMatrix[2, 0] := (right + left) / (right - left);
  FMatrix[2, 1] := (top + bottom) / (top - bottom);
  FMatrix[2, 2] := -(zfar + znear) / (zfar - znear);
  FMatrix[2, 3] := -1;
  FMatrix[3, 2] := -2 * zfar * znear / (zfar - znear);
  FMatrix[3, 3] := 0;
end;

procedure TMatrix.Perspective(fovy, aspect, znear, zfar: single);
var
  p, right, top: single;
begin
  p := fovy * Pi / 360;
  top := znear * (sin(p) / cos(p));
//    top := znear * tan(p);
  right := top * aspect;
  Frustum(-right, right, -top, top, znear, zfar);
end;


procedure TMatrix.Rotate(Winkel, x, y, z: GLfloat);
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
  FMatrix := m;
end;

procedure TMatrix.Rotate(Winkel: GLfloat; a: TVector3f);
begin
  Rotate(Winkel, a[0], a[1], a[2]);
end;

procedure TMatrix.Translate(x, y, z: GLfloat);
begin
  FMatrix[3, 0] := FMatrix[3, 0] + x;
  FMatrix[3, 1] := FMatrix[3, 1] + y;
  FMatrix[3, 2] := FMatrix[3, 2] + z;
end;

procedure TMatrix.NewTranslate(x, y, z: GLfloat);
var
  i: integer;
begin
  for i := 0 to 3 do begin
    FMatrix[3, i] += FMatrix[0, i] * x + FMatrix[1, i] * y + FMatrix[2, i] * z;
  end;
end;


procedure TMatrix.RotateA(Winkel: GLfloat);
var
  i: integer;
  y, z, c, s: GLfloat;
begin
  c := cos(Winkel);
  s := sin(Winkel);
  for i := 0 to 2 do begin
    y := FMatrix[i, 1];
    z := FMatrix[i, 2];
    FMatrix[i, 1] := y * c - z * s;
    FMatrix[i, 2] := y * s + z * c;
  end;
end;


procedure TMatrix.RotateB(Winkel: GLfloat);
var
  i: integer;
  x, z, c, s: GLfloat;
begin
  c := cos(Winkel);
  s := sin(Winkel);
  for i := 0 to 2 do begin
    x := FMatrix[i, 0];
    z := FMatrix[i, 2];
    FMatrix[i, 0] := x * c - z * s;
    FMatrix[i, 2] := x * s + z * c;
  end;
end;


procedure TMatrix.RotateC(Winkel: GLfloat);
var
  i: integer;
  x, y, c, s: GLfloat;
begin
  c := cos(Winkel);
  s := sin(Winkel);
  for i := 0 to 2 do begin
    x := FMatrix[i, 0];
    y := FMatrix[i, 1];
    FMatrix[i, 0] := x * c - y * s;
    FMatrix[i, 1] := x * s + y * c;
  end;
end;


procedure TMatrix.Scale(Faktor: GLfloat);
var
  x, y: integer;
begin
  for x := 0 to 2 do begin
    for y := 0 to 2 do begin
      FMatrix[x, y] *= Faktor;
    end;
  end;
end;

procedure TMatrix.Scale(FaktorX, FaktorY, FaktorZ: GLfloat);
var
  i: integer;
begin
  for i := 0 to 2 do begin
    FMatrix[i, 0] *= FaktorX;
    FMatrix[i, 1] *= FaktorY;
    FMatrix[i, 2] *= FaktorZ;
  end;
end;

procedure TMatrix.Transpose;
var
  i, j: integer;
  m: Tmat4x4;
begin
  for i := 0 to 3 do begin
    for j := 0 to 3 do begin
      m[i, j] := FMatrix[j, i];
    end;
  end;
  FMatrix := m;
end;

procedure TMatrix.Multiply(const m1t, m2t: TMatrix);
var
  x, y, i: integer;
  m: Tmat4x4;
begin
  for x := 0 to 3 do begin
    for y := 0 to 3 do begin
      m[x, y] := 0;
      for i := 0 to 3 do begin
        m[x, y] += m1t.FMatrix[i, y] * m2t.FMatrix[x, i];
      end;
    end;
  end;
  FMatrix := m;
end;

procedure TMatrix.Push;
var
  pos: integer;
begin
  pos := Length(BackupMatrix);
  SetLength(BackupMatrix, pos + 1);
  BackupMatrix[pos] := FMatrix;
end;

procedure TMatrix.Pop;
var
  pos: integer;
begin
  pos := Length(BackupMatrix) - 1;
  FMatrix := BackupMatrix[pos];
  SetLength(BackupMatrix, pos);
end;

procedure TMatrix.LoadStack;
begin
  FMatrix := BackupMatrix[Length(BackupMatrix) - 1];
end;

procedure TMatrix.Uniform(ShaderID: GLint);
begin
  glUniformMatrix4fv(ShaderID, 1, False, @FMatrix);
end;


procedure TMatrix.WriteMatrix;
var
  x, y: integer;
begin
  for y := 0 to 3 do begin
    for x := 0 to 3 do begin
      Write(FormatFloat('###0.0000', FMatrix[x, y]));
    end;
    Writeln;
  end;
end;

end.
