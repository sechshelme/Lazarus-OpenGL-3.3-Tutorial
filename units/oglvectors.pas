unit oglVectors;

{$modeswitch typehelpers on}
{$modeswitch arrayoperators on}
//{$modeswitch multihelpers}

interface

uses
  Classes, SysUtils, dglOpenGL, oglvector;

type
  TGlInts = array of TGLint;
  TGlfloats = array of TGlfloat;

  TVectors2f = type TGlfloats;
  TVectors3f = type TGlfloats;

  { Tglints }

  TglintsHelper = type Helper for Tglints
    function Size: TGLsizei;
    function Ptr: TGLvoid;
  end;

  { TGlfloatsHelper }

  TGlfloatsHelper = type Helper for TGlfloats
    function Size: TGLsizei;
    function SizePtr: TGLvoid;
    function Ptr: TGLvoid;
  end;

  { TVectors2fHelper }

  TVectors2fHelper = type Helper (TGlfloatsHelper) for TVectors2f
  public
    procedure Add(const v: TVector2f); overload;
    procedure Add(const v: TVectors2f); overload;

    procedure AddRectangle;

    procedure AddQuadTexCoords;
    procedure AddCubeTexCoords;

    procedure Scale(AScale: TGLfloat); overload;
    procedure Scale(const AScale: TVector2f); overload;
    procedure Translate(const ATranslate: TVector2f);
    procedure Rotate(angele: TGLfloat);

    function Count: TGLint;

    procedure AddFace2D(const Face: TFace2D); overload;
    procedure AddFace2D(const v0, v1, v2: TVector2f); overload;
    procedure AddFace2DArray(const Face: array of TFace2D);
  end;

  { TVectors3fHelper }

  TVectors3fHelper = type Helper(TGlfloatsHelper) for TVectors3f
  public
    procedure Add(const v: TVector3f); overload;
    procedure Add(const v: TVectors3f); overload;
    procedure Add(const v: array of TVector3f); overload;

    procedure AddRectangle;
    procedure AddRectangleColor(const col: TVector3f);
    procedure AddRectangleNormale;

    procedure AddCubeLateral;
    procedure AddCubeLateralColor(const col: TVector3f);
    procedure AddCubeLateralNormale;

    procedure AddCube;
    procedure AddCubeColor(const col: TVector3f);
    procedure AddCubeNormale;

    procedure AddSphere;
    procedure AddSphereNormale;

    procedure Scale(AScale: TGLfloat); overload;
    procedure Scale(const AScale: TVector3f); overload;
    procedure Translate(const ATranslate: TVector3f);
    procedure RotateA(angele: TGLfloat);
    procedure RotateB(angele: TGLfloat);
    procedure RotateC(angele: TGLfloat);

    function Count: TGLint;

    procedure AddFace3D(const Face: TFace3D); overload;
    procedure AddFace3DArray(const Face: array of TFace3D);
  end;

implementation

{ Tglints }

function TglintsHelper.Size: TGLsizei;
begin
  Result := Length(Self) * SizeOf(TGLint);
end;

function TglintsHelper.Ptr: TGLvoid;
begin
  Result := TGLvoid(Self);
end;

{ TGlfloatsHelper }

function TGlfloatsHelper.Size: TGLsizei;
begin
  Result := Length(Self) * SizeOf(TGLfloat);
end;

function TGlfloatsHelper.SizePtr: TGLvoid;
begin
  Result := TGLvoid(Size);
end;

function TGlfloatsHelper.Ptr: TGLvoid;
begin
  Result := TGLvoid(Self);
end;

{ TVectors2fHelper }

procedure TVectors2fHelper.Add(const v: TVector2f);
begin
  Self += [v];
end;

procedure TVectors2fHelper.Add(const v: TVectors2f);
begin
  Self += v;
end;

procedure TVectors2fHelper.AddRectangle;
begin
  Self += [
    -0.5, -0.5, 0.5, -0.5, 0.5, 0.5,
    -0.5, -0.5, 0.5, 0.5, -0.5, 0.5];
end;

procedure TVectors2fHelper.AddQuadTexCoords; inline;
begin
  Self += [
    0, 0, 1, 0, 1, 1,
    0, 0, 1, 1, 0, 1];
end;

procedure TVectors2fHelper.AddCubeTexCoords;
const
  quad: array of TGLfloat = (
    0, 0, 1, 0, 1, 1,
    0, 0, 1, 1, 0, 1);
begin
  Self += quad + quad + quad + quad + quad + quad;
end;


procedure TVectors2fHelper.Scale(AScale: TGLfloat);
var
  i: integer;
begin
  for i := 0 to Length(Self) - 1 do begin
    Self[i] *= AScale;
  end;
end;

procedure TVectors2fHelper.Scale(const AScale: TVector2f);
var
  i: integer;
  pv: PVector2f;
begin
  pv := PVector2f(Self);
  for i := 0 to Length(Self) div 2 - 1 do begin
    pv^.Scale(AScale.x, AScale.y);
    Inc(pv);
  end;
end;

procedure TVectors2fHelper.Translate(const ATranslate: TVector2f);
var
  i: integer;
  pv: PVector2f;
begin
  pv := PVector2f(Self);
  for i := 0 to Length(Self) div 2 - 1 do begin
    pv^.Translate(ATranslate.x, ATranslate.y);
    Inc(pv);
  end;
end;

procedure TVectors2fHelper.Rotate(angele: TGLfloat);
var
  i: integer;
  pv: PVector2f;
begin
  pv := PVector2f(Self);
  for i := 0 to Length(Self) div 2 - 1 do begin
    pv^.Rotate(angele);
    Inc(pv);
  end;
end;

function TVectors2fHelper.Count: TGLint; inline;
begin
  Result := Length(Self) div 2;
end;

procedure TVectors2fHelper.AddFace2D(const Face: TFace2D);
var
  p: integer;
begin
  p := Length(Self);
  SetLength(Self, p + 6);
  Move(Face, Self[p], SizeOf(TFace2D));
end;

procedure TVectors2fHelper.AddFace2D(const v0, v1, v2: TVector2f);
begin
  Add(v0);
  Add(v1);
  Add(v2);
end;

procedure TVectors2fHelper.AddFace2DArray(const Face: array of TFace2D);
var
  p: integer;
begin
  p := Length(Self);
  SetLength(Self, p + 6 * Length(Face));
  Move(Face, Self[p], SizeOf(TFace2D) * Length(Face));
end;

{ TVectors3fHelper }

// === Standard Funktionen

procedure TVectors3fHelper.Scale(AScale: TGLfloat); inline;
var
  i: integer;
begin
  for i := 0 to Length(Self) - 1 do begin
    Self[i] *= AScale;
  end;
end;

procedure TVectors3fHelper.Scale(const AScale: TVector3f);
var
  i: integer;
  pv: PVector3f;
begin
  pv := PVector3f(Self);
  for i := 0 to Length(Self) div 3 - 1 do begin
    pv^.Scale(AScale);
    Inc(pv);
  end;
end;

procedure TVectors3fHelper.Translate(const ATranslate: TVector3f);
var
  i: integer;
  pv: PVector3f;
begin
  pv := PVector3f(Self);
  for i := 0 to Length(Self) div 3 - 1 do begin
    pv^.Translate(ATranslate);
    Inc(pv);
  end;
end;

procedure TVectors3fHelper.RotateA(angele: TGLfloat);
var
  i: integer;
begin
  for i := 0 to Length(Self) div 3 - 1 do begin
    PVector3f(@Self[i * 3])^.RotateA(angele);
  end;
end;

procedure TVectors3fHelper.RotateB(angele: TGLfloat);
var
  i: integer;
begin
  for i := 0 to Length(Self) div 3 - 1 do begin
    PVector3f(@Self[i * 3])^.RotateB(angele);
  end;
end;

procedure TVectors3fHelper.RotateC(angele: TGLfloat);
var
  i: integer;
begin
  for i := 0 to Length(Self) div 3 - 1 do begin
    PVector3f(@Self[i * 3])^.RotateC(angele);
  end;
end;

function TVectors3fHelper.Count: TGLint; inline;
begin
  Result := Length(Self) div 3;
end;

procedure TVectors3fHelper.AddFace3D(const Face: TFace3D);
var
  p: integer;
begin
  p := Length(Self);
  SetLength(Self, p + 9);
  Move(Face, Self[p], SizeOf(TFace3D));
end;
//
procedure TVectors3fHelper.AddFace3DArray(const Face: array of TFace3D);
var
  p: integer;
begin
  p := Length(Self);
  SetLength(Self, p + 9 * Length(Face));
  Move(Face, Self[p], SizeOf(TFace3D) * Length(Face));
end;

procedure TVectors3fHelper.Add(const v: TVector3f);
begin
  Self += [v];
end;

procedure TVectors3fHelper.Add(const v: TVectors3f);
begin
  Self += v;
end;

procedure TVectors3fHelper.Add(const v: array of TVector3f);
var
  len_v, len_self: SizeInt;
begin
  len_v := Length(v) * 3;
  len_self := Length(Self);
  SetLength(Self, len_self + len_v);
  move(v[0], Self[len_self], len_v * 4);
end;

// === Rechteck

procedure TVectors3fHelper.AddRectangle;
begin
  Self += [
    -0.5, -0.5, 0, 0.5, -0.5, 0, 0.5, 0.5, 0,
    -0.5, -0.5, 0, 0.5, 0.5, 0, -0.5, 0.5, 0];
end;

procedure TVectors3fHelper.AddRectangleColor(const col: TVector3f);
var
  i: integer;
begin
  for i := 0 to 5 do begin
    Self += [col];
  end;
end;

procedure TVectors3fHelper.AddRectangleNormale;
begin
  Self += [
    //     vorn
    0.0, 0.0, 1.0, 0.0, 0.0, 1.0, 0.0, 0.0, 1.0, 0.0, 0.0, 1.0, 0.0, 0.0, 1.0, 0.0, 0.0, 1.0];

end;

// === Würfel ohne Boden und Deckel

procedure TVectors3fHelper.AddCubeLateral;
begin
  Self += [
    // Y-
    -0.5, -0.5, -0.5, 0.5, -0.5, -0.5, 0.5, -0.5, 0.5,
    -0.5, -0.5, -0.5, 0.5, -0.5, 0.5, -0.5, -0.5, 0.5,

    // X+
    0.5, -0.5, -0.5, 0.5, 0.5, -0.5, 0.5, 0.5, 0.5,
    0.5, -0.5, -0.5, 0.5, 0.5, 0.5, 0.5, -0.5, 0.5,

    // Y+
    0.5, 0.5, -0.5, -0.5, 0.5, -0.5, -0.5, 0.5, 0.5,
    0.5, 0.5, -0.5, -0.5, 0.5, 0.5, 0.5, 0.5, 0.5,

    // X-
    -0.5, 0.5, -0.5, -0.5, -0.5, -0.5, -0.5, -0.5, 0.5,
    -0.5, 0.5, -0.5, -0.5, -0.5, 0.5, -0.5, 0.5, 0.5];
end;

procedure TVectors3fHelper.AddCubeLateralNormale;
begin
  Self += [
    // Y-
    0.0, -1.0, 0.0, 0.0, -1.0, 0.0, 0.0, -1.0, 0.0, 0.0, -1.0, 0.0, 0.0, -1.0, 0.0, 0.0, -1.0, 0.0,
    // X+
    1.0, 0.0, 0.0, 1.0, 0.0, 0.0, 1.0, 0.0, 0.0, 1.0, 0.0, 0.0, 1.0, 0.0, 0.0, 1.0, 0.0, 0.0,
    // Y+
    0.0, 1.0, 0.0, 0.0, 1.0, 0.0, 0.0, 1.0, 0.0, 0.0, 1.0, 0.0, 0.0, 1.0, 0.0, 0.0, 1.0, 0.0,
    // X-
    -1.0, 0.0, 0.0, -1.0, 0.0, 0.0, -1.0, 0.0, 0.0, -1.0, 0.0, 0.0, -1.0, 0.0, 0.0, -1.0, 0.0, 0.0];
end;

// === Würfel

procedure TVectors3fHelper.AddCube;
begin
  Self += [
    // Z+
    -0.5, -0.5, 0.5, 0.5, -0.5, 0.5, 0.5, 0.5, 0.5,
    -0.5, -0.5, 0.5, 0.5, 0.5, 0.5, -0.5, 0.5, 0.5,

    // Z-
    0.5, 0.5, -0.5, -0.5, -0.5, -0.5, -0.5, 0.5, -0.5,
    0.5, 0.5, -0.5, 0.5, -0.5, -0.5, -0.5, -0.5, -0.5,

    // Y-
    -0.5, -0.5, -0.5, 0.5, -0.5, -0.5, 0.5, -0.5, 0.5,
    -0.5, -0.5, -0.5, 0.5, -0.5, 0.5, -0.5, -0.5, 0.5,

    // X+
    0.5, -0.5, -0.5, 0.5, 0.5, -0.5, 0.5, 0.5, 0.5,
    0.5, -0.5, -0.5, 0.5, 0.5, 0.5, 0.5, -0.5, 0.5,

    // Y+
    0.5, 0.5, -0.5, -0.5, 0.5, -0.5, -0.5, 0.5, 0.5,
    0.5, 0.5, -0.5, -0.5, 0.5, 0.5, 0.5, 0.5, 0.5,

    // X-
    -0.5, 0.5, -0.5, -0.5, -0.5, -0.5, -0.5, -0.5, 0.5,
    -0.5, 0.5, -0.5, -0.5, -0.5, 0.5, -0.5, 0.5, 0.5];
end;

procedure TVectors3fHelper.AddCubeNormale;
begin
  Self += [
    // Z+
    0.0, 0.0, 1.0, 0.0, 0.0, 1.0, 0.0, 0.0, 1.0, 0.0, 0.0, 1.0, 0.0, 0.0, 1.0, 0.0, 0.0, 1.0,
    // Z-
    0.0, 0.0, -1.0, 0.0, 0.0, -1.0, 0.0, 0.0, -1.0, 0.0, 0.0, -1.0, 0.0, 0.0, -1.0, 0.0, 0.0, -1.0,
    // Y-
    0.0, -1.0, 0.0, 0.0, -1.0, 0.0, 0.0, -1.0, 0.0, 0.0, -1.0, 0.0, 0.0, -1.0, 0.0, 0.0, -1.0, 0.0,
    // X+
    1.0, 0.0, 0.0, 1.0, 0.0, 0.0, 1.0, 0.0, 0.0, 1.0, 0.0, 0.0, 1.0, 0.0, 0.0, 1.0, 0.0, 0.0,
    // Y+
    0.0, 1.0, 0.0, 0.0, 1.0, 0.0, 0.0, 1.0, 0.0, 0.0, 1.0, 0.0, 0.0, 1.0, 0.0, 0.0, 1.0, 0.0,
    // X-
    -1.0, 0.0, 0.0, -1.0, 0.0, 0.0, -1.0, 0.0, 0.0, -1.0, 0.0, 0.0, -1.0, 0.0, 0.0, -1.0, 0.0, 0.0];
end;

procedure TVectors3fHelper.AddCubeColor(const col: TVector3f);
var
  i: integer;
begin
  for i := 0 to 35 do begin
    Self += [col];
  end;
end;

procedure TVectors3fHelper.AddCubeLateralColor(const col: TVector3f);
var
  i: integer;
begin
  for i := 0 to 23 do begin
    Self += [col];
  end;
end;

// === Kugel

procedure TVectors3fHelper.AddSphere;
type
  quadVector = array[0..3] of TVector3f;

  procedure Quads(Vector: quadVector); inline;
  begin
    Self.Add([Vector[0], Vector[1], Vector[2], Vector[0], Vector[2], Vector[3]]);
  end;

const
  Sektoren = 36;
var
  i, j: integer;
  t, rk: TGLfloat;

  Tab: array of array of record
    a, b, c: TGLfloat;
    end
  = nil;

begin
  t := 2 * pi / Sektoren;
  SetLength(Tab, Sektoren + 1, Sektoren div 2 + 1);
  for j := 0 to Sektoren div 2 do begin
    rk := sin(t * j);
    for i := 0 to Sektoren do begin
      with Tab[i, j] do begin
        a := sin(t * i) * rk;
        b := cos(t * i) * rk;
        c := cos(t * j);
      end;
    end;
  end;

  for j := 0 to Sektoren div 2 - 1 do begin
    for i := 0 to Sektoren - 1 do begin
      Quads([
        [Tab[i + 0, j + 1].a, Tab[i + 0, j + 1].c, Tab[i + 0, j + 1].b],
        [Tab[i + 1, j + 1].a, Tab[i + 1, j + 1].c, Tab[i + 1, j + 1].b],
        [Tab[i + 1, j + 0].a, Tab[i + 1, j + 0].c, Tab[i + 1, j + 0].b],
        [Tab[i + 0, j + 0].a, Tab[i + 0, j + 0].c, Tab[i + 0, j + 0].b]]);
    end;
  end;
end;

procedure TVectors3fHelper.AddSphereNormale;
begin
  Self.AddSphere;
end;

end.
