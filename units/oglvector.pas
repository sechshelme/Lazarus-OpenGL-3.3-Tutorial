unit oglVector;

{$modeswitch typehelpers}

interface

uses
  {$ifdef GLES32}
  oglglad_GLES32;
  {$else}
  oglglad_gl;
  {$endif}

type
  TVector2b = array[0..1] of TGLboolean;
  TVector3b = array[0..2] of TGLboolean;
  TVector4b = array[0..3] of TGLboolean;

  TVector2i = array[0..1] of GLint;
  TVector3i = array[0..2] of GLint;
  TVector4i = array[0..3] of GLint;

  TVector2f = array[0..1] of GLfloat;
  PVector2f = ^TVector2f;

  TVector3f = array[0..2] of GLfloat;
  PVector3f = ^TVector3f;
  PPVector3f = ^PVector3f;

  TVector4f = array[0..3] of GLfloat;
  PVector4f = ^TVector4f;

  TVector5f = array[0..4] of GLfloat;
  PVector5f = ^TVector5f;

  TVector6f = array[0..5] of GLfloat;
  PVector6f = ^TVector6f;

  TLine2D = array[0..1] of TVector2f;
  PLine2D = ^TLine2D;

  TLine3D = array[0..1] of TVector3f;
  PLine3D = ^TLine3D;

  TFace2D = array[0..2] of TVector2f;
  PFace2D = ^TFace2D;

  TFace3D = array[0..2] of TVector3f;
  PFace3D = ^TFace3D;

  TFace = TFace3D;
  PFace = ^TFace;

  TFace3DArray = array of TFace3D;
  PFace3DArray = ^TFace3DArray;

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
    procedure Normalize;
    procedure Negate;

    function Length: GLfloat;
    function ToString: string;

    procedure Uniform(ShaderID: GLint);
  end;

  { TVector3fHelper }

  TVector3fHelper = type Helper for TVector3f
  private
    function GetX: GLfloat;
    function GetY: GLfloat;
    function GetZ: GLfloat;
    function GetXY: TVector2f;
    procedure SetX(AValue: GLfloat);
    procedure SetY(AValue: GLfloat);
    procedure SetZ(AValue: GLfloat);
    procedure SetXY(const AValue: TVector2f);
  public
    property x: GLfloat read GetX write SetX;
    property y: GLfloat read GetY write SetY;
    property z: GLfloat read GetZ write SetZ;
    property xy: TVector2f read GetXY write SetXY;

    function ToInt: uint32;
    procedure FromInt(i: uint32);

    procedure RotateA(Winkel: GLfloat);
    procedure RotateB(Winkel: GLfloat);
    procedure RotateC(Winkel: GLfloat);
    procedure Scale(Ax, Ay, Az: GLfloat);overload;
    procedure Scale(s: GLfloat);overload;
    procedure Scale(sv: TVector3f);                  overload;
    procedure Translate(Ax, Ay, Az: GLfloat); overload;
    procedure Translate(Atranslate: TVector3f); overload;
    procedure Normalize;
    procedure Negate;
    procedure Cross(const v0, v1: TVector3f); overload;
    procedure Cross(const v0, v1, v2: TVector3f); overload;
    procedure Random;

    function Length: GLfloat;
    function ToString: string;

    procedure Uniform(ShaderID: GLint);
  end;

  { TVector4fHelper }

  TVector4fHelper = type Helper for TVector4f
  private
    function GetX: GLfloat;
    function GetY: GLfloat;
    function GetZ: GLfloat;
    function GetW: GLfloat;
    function GetXY: TVector2f;
    function GetXYZ: TVector3f;
    function GetXYW: TVector3f;
    procedure SetX(AValue: GLfloat);
    procedure SetY(AValue: GLfloat);
    procedure SetZ(AValue: GLfloat);
    procedure SetW(AValue: GLfloat);
    procedure SetXY(const AValue: TVector2f);
    procedure SetXYZ(const AValue: TVector3f);
    procedure SetXYW(const AValue: TVector3f);
  public
    property x: GLfloat read GetX write SetX;
    property y: GLfloat read GetY write SetY;
    property z: GLfloat read GetZ write SetZ;
    property w: GLfloat read GetW write SetW;
    property xy: TVector2f read GetXY write SetXY;
    property xyz: TVector3f read GetXYZ write SetXYZ;
    property xyw: TVector3f read GetXYW write SetXYW;

    function ToInt: uint32;
    procedure FromInt(i: uint32);
    procedure Scale(Ax, Ay, Az: GLfloat);
    procedure Scale(Ax, Ay, Az, Aw: GLfloat);

    function ToString: string;

    procedure Uniform(ShaderID: GLint);
  end;

const
  {$push,}{$J-}
  vec3black: TVector3f = (0.0, 0.0, 0.0);
  vec3blue: TVector3f = (0.0, 0.0, 1.0);
  vec3green: TVector3f = (0.0, 1.0, 0.0);
  vec3cyan: TVector3f = (0.0, 1.0, 1.0);
  vec3red: TVector3f = (1.0, 0.0, 0.0);
  vec3magenta: TVector3f = (1.0, 0.0, 1.0);
  vec3yellow: TVector3f = (1.0, 1.0, 0.0);
  vec3white: TVector3f = (1.0, 1.0, 1.0);
{$J+}{$pop}

  // --- GLSL Ähnliches

function vec2(x, y: GLfloat): TVector2f;
function vec3(x, y, z: GLfloat): TVector3f; overload;
function vec3(const xy: TVector2f; z: GLfloat): TVector3f; overload;
function vec4(x, y, z, w: GLfloat): TVector4f; overload;
function vec4(const xy: TVector2f; z, w: GLfloat): TVector4f; overload;
function vec4(const xyz: TVector3f; w: GLfloat): TVector4f; overload;

function min(a, b: GLfloat): GLfloat; overload;
function min(const a, b: TVector2f): TVector2f; overload;
function min(const a, b: TVector3f): TVector3f; overload;

function max(a, b: GLfloat): GLfloat; overload;
function max(const a, b: TVector2f): TVector2f; overload;
function max(const a, b: TVector3f): TVector3f; overload;

function clamp(x, minVal, maxVal: GLfloat): GLfloat; overload;
function clamp(const x, minVal, maxVal: TVector2f): TVector2f; overload;
function clamp(const x, minVal, maxVal: TVector3f): TVector3f; overload;

function mix(val0, val1, a: GLfloat): GLfloat; overload;
function mix(val0, val1: TVector2f; a: GLfloat): TVector2f; overload;
function mix(val0, val1: TVector3f; a: GLfloat): TVector3f; overload;
function mix(val0, val1, a: TVector2f): TVector2f; overload;
function mix(val0, val1, a: TVector3f): TVector3f; overload;

function dot(const v0, v1: TVector2f): single; overload;
function dot(const v0, v1: TVector3f): single; overload;
function cross(const v0, v1: TVector3f): TVector3f; overload;
function normalize(const v: TVector3f): TVector3f;

operator +(const v0, v1: TVector2f) Res: TVector2f;
operator -(const v0, v1: TVector2f) Res: TVector2f;
operator -(const v: TVector2f) Res: TVector2f;
operator +(const v0, v1: TVector3f) Res: TVector3f;
operator -(const v0, v1: TVector3f) Res: TVector3f;
operator -(const v: TVector3f) Res: TVector3f;
operator +(const v0, v1: TVector4f) Res: TVector4f;
operator -(const v0, v1: TVector4f) Res: TVector4f;
operator -(const v: TVector4f) Res: TVector4f;

operator * (const v: TVector2f; const f: GLfloat) Res: TVector2f;
operator / (const v: TVector2f; const f: GLfloat) Res: TVector2f;
operator * (const v: TVector3f; const f: GLfloat) Res: TVector3f;
operator / (const v: TVector3f; const f: GLfloat) Res: TVector3f;
operator * (const v: TVector4f; const f: GLfloat) Res: TVector4f;
operator / (const v: TVector4f; const f: GLfloat) Res: TVector4f;

operator * (const v0: TVector2f; const v1: TVector2f) Res: TGLfloat;
operator * (const v0: TVector3f; const v1: TVector3f) Res: TGLfloat;
operator * (const v0: TVector4f; const v1: TVector4f) Res: TGLfloat;

// --- Sonstige

procedure FaceToNormale(var Face, Normal: array of TFace3D);
procedure SwapglFloat(var f0, f1: GLfloat);
procedure SwapVertex2f(var f0, f1: TVector2f);
procedure SwapVertex3f(var f0, f1: TVector3f);
procedure SwapVertex4f(var f0, f1: TVector4f);

implementation

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

procedure TVector2fHelper.Scale(Ax, Ay: GLfloat); //inline;
begin
  Self[0] *= Ax;
  Self[1] *= Ay;
end;

procedure TVector2fHelper.Scale(s: GLfloat); inline;
begin
  Self[0] *= s;
  Self[1] *= s;
end;

procedure TVector2fHelper.Translate(Ax, Ay: GLfloat);// inline;
begin
  Self[0] += Ax;
  Self[1] += Ay;
end;

procedure TVector2fHelper.Normalize;
var
  l: GLfloat;
begin
  l := Sqrt(Sqr(Self[0]) + Sqr(Self[1]));
  if l = 0 then begin
    l := 1.0;
  end;
  Self /= l;
end;

procedure TVector2fHelper.Negate; inline;
begin
  Self *= -1;
end;

function TVector2fHelper.Length: GLfloat;
begin
  Result := sqrt(sqr(Self[0]) + sqr(Self[1]));
end;

function TVector2fHelper.ToString: string;
var
  s: string;
begin
  Str(Self[0]: 1: 1, s);
  Result := s + ' ';
  Str(Self[1]: 1: 1, s);
  Result += s;
end;

procedure TVector2fHelper.Uniform(ShaderID: GLint); inline;
begin
  glUniform2fv(ShaderID, 1, @Self);
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

function TVector3fHelper.GetXY: TVector2f; inline;
begin
  Result[0] := Self[0];
  Result[1] := Self[1];
end;

procedure TVector3fHelper.SetXY(const AValue: TVector2f); inline;
begin
  Self[0] := AValue[0];
  Self[1] := AValue[1];
end;

function TVector3fHelper.ToInt: uint32;

  function v(s: GLfloat): byte; inline;
  begin
    Result := Round(s * $FF);
  end;

var
  i: integer;
begin
  for i := 0 to 2 do begin
    if Self[i] < 0.0 then begin
      Self[i] := 0.0;
    end;
    if Self[i] > 1.0 then begin
      Self[i] := 1.0;
    end;
  end;
  Result := v(Self[0]) + v(Self[1]) * $100 + v(Self[2]) * $10000;
end;

procedure TVector3fHelper.FromInt(i: uint32);
begin
  Self[0] := i div $10000 mod $100 / $FF;
  Self[1] := i div $100 mod $100 / $FF;
  Self[2] := i div $1 mod $100 / $FF;
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

procedure TVector3fHelper.Scale(Ax, Ay, Az: GLfloat); inline;
begin
  Self[0] *= Ax;
  Self[1] *= Ay;
  Self[2] *= Az;
end;

procedure TVector3fHelper.Scale(s: GLfloat);
begin
  Self *= s;
end;

procedure TVector3fHelper.Scale(sv: TVector3f);
begin
  Self[0] *= sv.x;
  Self[1] *= sv.y;
  Self[2] *= sv.z;
end;

procedure TVector3fHelper.Translate(Ax, Ay, Az: GLfloat); inline;
begin
  Self[0] += Ax;
  Self[1] += Ay;
  Self[2] += Az;
end;

procedure TVector3fHelper.Translate(Atranslate: TVector3f);// inline;
begin
  Self += Atranslate;
end;

procedure TVector3fHelper.Normalize;
var
  l: GLfloat;
begin
  l := Sqrt(Sqr(Self[0]) + Sqr(Self[1]) + Sqr(Self[2]));
  if l = 0.0 then begin
    l := 1.0;
  end;
  Self *= 1 / l;
end;

procedure TVector3fHelper.Negate; inline;
begin
  Self *= -1;
end;

procedure TVector3fHelper.Cross(const v0, v1: TVector3f);
begin
  Self[0] := v0[1] * v1[2] - v0[2] * v1[1];
  Self[1] := v0[2] * v1[0] - v0[0] * v1[2];
  Self[2] := v0[0] * v1[1] - v0[1] * v1[0];

  Normalize;
end;

procedure TVector3fHelper.Cross(const v0, v1, v2: TVector3f); inline;
begin
  Cross(v1 - v0, v2 - v0);
end;

procedure TVector3fHelper.Random;
begin
  Self[0] := system.Random;
  Self[1] := system.Random;
  Self[2] := system.Random;
end;

function TVector3fHelper.Length: GLfloat;
begin
  Result := sqrt(sqr(Self[0]) + sqr(Self[1]) + sqr(Self[2]));
end;

function TVector3fHelper.ToString: string;
var
  s: string;
begin
  Str(Self[0]: 1: 1, s);
  Result := s + ' ';
  Str(Self[1]: 1: 1, s);
  Result += s + ' ';
  Str(Self[2]: 1: 1, s);
  Result += s;
end;

procedure TVector3fHelper.Uniform(ShaderID: GLint); //inline;
begin
  glUniform3fv(ShaderID, 1, @Self);
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

function TVector4fHelper.GetW: GLfloat; inline;
begin
  Result := Self[3];
end;

function TVector4fHelper.GetXY: TVector2f; inline;
begin
  Result[0] := Self[0];
  Result[1] := Self[1];
end;

function TVector4fHelper.GetXYZ: TVector3f; inline;
begin
  Result[0] := Self[0];
  Result[1] := Self[1];
  Result[2] := Self[2];
end;

function TVector4fHelper.GetXYW: TVector3f; inline;
begin
  Result[0] := Self[0];
  Result[1] := Self[1];
  Result[2] := Self[3];
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

procedure TVector4fHelper.SetW(AValue: GLfloat); inline;
begin
  Self[3] := AValue;
end;

procedure TVector4fHelper.SetXY(const AValue: TVector2f); inline;
begin
  Self[0] := AValue[0];
  Self[1] := AValue[1];
end;

procedure TVector4fHelper.SetXYZ(const AValue: TVector3f); inline;
begin
  Self[0] := AValue[0];
  Self[1] := AValue[1];
  Self[2] := AValue[2];
end;

procedure TVector4fHelper.SetXYW(const AValue: TVector3f); inline;
begin
  Self[0] := AValue[0];
  Self[1] := AValue[1];
  Self[3] := AValue[2];
end;

function TVector4fHelper.ToInt: uint32;

  function v(s: GLfloat): byte; inline;
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

procedure TVector4fHelper.FromInt(i: uint32);
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

function TVector4fHelper.ToString: string;
var
  s: string;
begin
  Str(Self[0]: 1: 1, s);
  Result := s + ' ';
  Str(Self[1]: 1: 1, s);
  Result += s + ' ';
  Str(Self[2]: 1: 1, s);
  Result += s + ' ';
  Str(Self[3]: 1: 1, s);
  Result += s;
end;

procedure TVector4fHelper.Uniform(ShaderID: GLint); inline;
begin
  glUniform4fv(ShaderID, 1, @Self);
end;

// === GLSL Ähnliche Funktionen


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

function vec3(const xy: TVector2f; z: GLfloat): TVector3f; inline;
begin
  Result[0] := xy[0];
  Result[1] := xy[1];
  Result[2] := z;
end;

function vec4(x, y, z, w: GLfloat): TVector4f; inline;
begin
  Result[0] := x;
  Result[1] := y;
  Result[2] := z;
  Result[3] := w;
end;

function vec4(const xy: TVector2f; z, w: GLfloat): TVector4f; inline;
begin
  Result[0] := xy[0];
  Result[1] := xy[1];
  Result[2] := z;
  Result[3] := w;
end;

function vec4(const xyz: TVector3f; w: GLfloat): TVector4f; inline;
begin
  Result[0] := xyz[0];
  Result[1] := xyz[1];
  Result[2] := xyz[2];
  Result[3] := w;
end;

function min(a, b: GLfloat): GLfloat; inline;
begin
  if a < b then begin
    Result := a;
  end else begin
    Result := b;
  end;
end;

function min(const a, b: TVector2f): TVector2f; inline;
begin
  Result[0] := min(a[0], b[0]);
  Result[1] := min(a[1], b[1]);
end;

function min(const a, b: TVector3f): TVector3f; inline;
begin
  Result[0] := min(a[0], b[0]);
  Result[1] := min(a[1], b[1]);
  Result[2] := min(a[2], b[2]);
end;

function max(a, b: GLfloat): GLfloat; inline;
begin
  if a > b then begin
    Result := a;
  end else begin
    Result := b;
  end;
end;

function max(const a, b: TVector2f): TVector2f; inline;
begin
  Result[0] := max(a[0], b[0]);
  Result[1] := max(a[1], b[1]);
end;

function max(const a, b: TVector3f): TVector3f; inline;
begin
  Result[0] := max(a[0], b[0]);
  Result[1] := max(a[1], b[1]);
  Result[2] := max(a[2], b[2]);
end;

function clamp(x, minVal, maxVal: GLfloat): GLfloat; inline;
begin
  if x < minVal then begin
    Result := minVal;
  end else if x > maxVal then begin
    Result := maxVal;
  end else begin
    Result := x;
  end;
end;

function clamp(const x, minVal, maxVal: TVector2f): TVector2f; inline;
begin
  Result[0] := clamp(x[0], minVal[0], maxVal[0]);
  Result[1] := clamp(x[1], minVal[1], maxVal[1]);
end;

function clamp(const x, minVal, maxVal: TVector3f): TVector3f; inline;
begin
  Result[0] := clamp(x[0], minVal[0], maxVal[0]);
  Result[1] := clamp(x[1], minVal[1], maxVal[1]);
  Result[2] := clamp(x[2], minVal[0], maxVal[2]);
end;

function mix(val0, val1, a: GLfloat): GLfloat; inline;
begin
  Result := (1 - a) * val0 + val1 * a;
end;

function mix(val0, val1: TVector2f; a: GLfloat): TVector2f; inline;
begin
  Result[0] := mix(val0[0], val1[0], a);
  Result[1] := mix(val0[1], val1[1], a);
end;

function mix(val0, val1: TVector3f; a: GLfloat): TVector3f; inline;
begin
  Result[0] := mix(val0[0], val1[0], a);
  Result[1] := mix(val0[1], val1[1], a);
  Result[2] := mix(val0[2], val1[2], a);
end;

function mix(val0, val1, a: TVector2f): TVector2f; inline;
begin
  Result[0] := mix(val0[0], val1[0], a[0]);
  Result[1] := mix(val0[1], val1[1], a[1]);
end;

function mix(val0, val1, a: TVector3f): TVector3f; inline;
begin
  Result[0] := mix(val0[0], val1[0], a[0]);
  Result[1] := mix(val0[1], val1[1], a[1]);
  Result[2] := mix(val0[2], val1[2], a[2]);
end;

function dot(const v0, v1: TVector2f): single; inline;
begin
  Result := v0.x * v1.x + v0.y * v1.y;
end;

function dot(const v0, v1: TVector3f): single; inline;
begin
  Result := v0.x * v1.x + v0.y * v1.y + v0.z * v1.z;
end;

function cross(const v0, v1: TVector3f): TVector3f; inline;
begin
  Result.Cross(v0, v1);
end;

function normalize(const v: TVector3f): TVector3f; inline;
begin
  Result := v;
  Result.Normalize;
end;

// === Überladene Operatoren für Vektoren

operator +(const v0, v1: TVector2f) Res: TVector2f; inline;
begin
  Res[0] := v0[0] + v1[0];
  Res[1] := v0[1] + v1[1];
end;

operator -(const v0, v1: TVector2f) Res: TVector2f; inline;
begin
  Res[0] := v0[0] - v1[0];
  Res[1] := v0[1] - v1[1];
end;

operator -(const v: TVector2f)Res: TVector2f; inline;
begin
  Res[0] := -v[0];
  Res[1] := -v[1];
end;

operator +(const v0, v1: TVector3f) Res: TVector3f; inline;
begin
  Res[0] := v0[0] + v1[0];
  Res[1] := v0[1] + v1[1];
  Res[2] := v0[2] + v1[2];
end;

operator -(const v0, v1: TVector3f) Res: TVector3f; inline;
begin
  Res[0] := v0[0] - v1[0];
  Res[1] := v0[1] - v1[1];
  Res[2] := v0[2] - v1[2];
end;

operator -(const v: TVector3f)Res: TVector3f; inline;
begin
  Res[0] := -v[0];
  Res[1] := -v[1];
  Res[2] := -v[2];
end;

operator +(const v0, v1: TVector4f) Res: TVector4f; inline;
begin
  Res[0] := v0[0] + v1[0];
  Res[1] := v0[1] + v1[1];
  Res[2] := v0[2] + v1[2];
  Res[3] := v0[3] + v1[3];
end;

operator -(const v0, v1: TVector4f) Res: TVector4f; inline;
begin
  Res[0] := v0[0] - v1[0];
  Res[1] := v0[1] - v1[1];
  Res[2] := v0[2] - v1[2];
  Res[3] := v0[3] - v1[3];
end;

operator -(const v: TVector4f)Res: TVector4f; inline;
begin
  Res[0] := -v[0];
  Res[1] := -v[1];
  Res[2] := -v[2];
  Res[3] := -v[3];
end;

operator * (const v: TVector2f; const f: GLfloat) Res: TVector2f; inline;
begin
  Res[0] := v[0] * f;
  Res[1] := v[1] * f;
end;

operator / (const v: TVector2f; const f: GLfloat) Res: TVector2f; inline;
begin
  Res[0] := v[0] / f;
  Res[1] := v[1] / f;
end;

operator * (const v: TVector3f; const f: GLfloat) Res: TVector3f; inline;
begin
  Res[0] := v[0] * f;
  Res[1] := v[1] * f;
  Res[2] := v[2] * f;
end;

operator / (const v: TVector3f; const f: GLfloat) Res: TVector3f; inline;
begin
  Res[0] := v[0] / f;
  Res[1] := v[1] / f;
  Res[2] := v[2] / f;
end;

operator * (const v: TVector4f; const f: GLfloat) Res: TVector4f; inline;
begin
  Res[0] := v[0] * f;
  Res[1] := v[1] * f;
  Res[2] := v[2] * f;
  Res[3] := v[3] * f;
end;

operator / (const v: TVector4f; const f: GLfloat) Res: TVector4f; inline;
begin
  Res[0] := v[0] / f;
  Res[1] := v[1] / f;
  Res[2] := v[2] / f;
  Res[3] := v[3] / f;
end;

operator * (const v0: TVector2f; const v1: TVector2f) Res: TGLfloat; inline;
begin
  Res := v0[0] * v1[0] + v0[1] * v1[1];
end;

operator * (const v0: TVector3f; const v1: TVector3f) Res: TGLfloat; inline;
begin
  Res := v0[0] * v1[0] + v0[1] * v1[1] + v0[2] * v1[2];
end;

operator * (const v0: TVector4f; const v1: TVector4f) Res: TGLfloat; inline;
begin
  Res := v0[0] * v1[0] + v0[1] * v1[1] + v0[2] * v1[2] + v0[3] * v1[3];
end;

// === Hilfsfunktionen

procedure FaceToNormale(var Face, Normal: array of TFace3D);
var
  i: integer;
  v: TVector3f;
begin
  if Length(Normal) <> Length(Face) then begin
    //    ShowMessage('Fehler: Lenght(Normal) <> Length(Face)');
    //    WriteLn(  'Fehler: Lenght(Normal) <> Length(Face)');
    Exit;
  end;
  for i := 0 to Length(Face) - 1 do begin
    v.Cross(Face[i, 0], Face[i, 1], Face[i, 2]);
    Normal[i, 0] := v;
    Normal[i, 1] := v;
    Normal[i, 2] := v;
  end;
end;

procedure SwapglFloat(var f0, f1: GLfloat); inline;
var
  dummy: GLfloat;
begin
  dummy := f0;
  f0 := f1;
  f1 := dummy;
end;

procedure SwapVertex2f(var f0, f1: TVector2f); inline;
var
  dummy: TVector2f;
begin
  dummy := f0;
  f0 := f1;
  f1 := dummy;
end;

procedure SwapVertex3f(var f0, f1: TVector3f); inline;
var
  dummy: TVector3f;
begin
  dummy := f0;
  f0 := f1;
  f1 := dummy;
end;

procedure SwapVertex4f(var f0, f1: TVector4f); inline;
var
  dummy: TVector4f;
begin
  dummy := f0;
  f0 := f1;
  f1 := dummy;
end;

end.
