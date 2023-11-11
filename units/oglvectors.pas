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

  TGlfloatsHelper = type Helper for TGlfloats
    function Size: TGLsizei;
    function Ptr: TGLvoid;
  end;

  TVectors2fHelper = type Helper (TGlfloatsHelper) for TVectors2f
  public
    procedure Add(x, y: TGLfloat); overload;
    procedure Add(const v: TVector2f); overload;
    procedure AddRectangle(w, h: TGLfloat; x: TGLfloat = 0; y: TGLfloat = 0);
    procedure AddQuadTexCoords;
    procedure AddCubeTexCoords;

    procedure Scale(AScale: TGLfloat); overload;
    procedure Scale(const AScale: TVector2f); overload;

    function Count: TGLint;

    procedure AddFace2D(const Face: TFace2D); overload;
    procedure AddFace2D(const v0, v1, v2: TVector2f); overload;
    procedure AddFace2DArray(const Face: array of TFace2D);
  end;

  TVectors3fHelper = type Helper(TGlfloatsHelper) for TVectors3f
  public
    procedure Add(x, y, z: TGLfloat); overload;
    procedure Add(const v: TVector3f); overload;
    procedure Add(const v: TVectors3f); overload;
    procedure AddRectangle(w, h: TGLfloat; x: TGLfloat = 0; y: TGLfloat = 0; z: TGLfloat = 0);
    procedure AddCube(w, h, d: TGLfloat; x: TGLfloat = 0; y: TGLfloat = 0; z: TGLfloat = 0);
    procedure AddCubeNormale;
    procedure AddCubeColor(col: TVector3f);

    procedure Scale(AScale: TGLfloat); overload;
    procedure Scale(const AScale: TVector3f); overload;
    procedure Translate(const ATranslate: TVector3f);
    procedure RotateA(angele: TGLfloat);
    procedure RotateB(angele: TGLfloat);
    procedure RotateC(angele: TGLfloat);

    function Count: TGLint;

    procedure AddFace3D(const Face: TFace3D); overload;
    procedure AddFace3D(const v0, v1, v2: TVector3f); overload;
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

function TGlfloatsHelper.Ptr: TGLvoid;
begin
  Result := TGLvoid(Self);
end;

{ TVectors2fHelper }

procedure TVectors2fHelper.Add(x, y: TGLfloat); inline;
begin
  Self += [x, y];
end;

procedure TVectors2fHelper.Add(const v: TVector2f);
begin
  Self += [v];
end;

procedure TVectors2fHelper.AddRectangle(w, h: TGLfloat; x: TGLfloat; y: TGLfloat);
begin
  Self += [
    0 + x, 0 + y, w + x, 0 + y, w + x, h + y,
    0 + x, 0 + y, w + x, h + y, 0 + x, h + y];
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
  p: SizeInt = 0;
begin
  for i := 0 to Length(Self) div 3 - 1 do begin
    Self[p] *= AScale.x;
    Inc(p);
    Self[p] *= AScale.y;
    Inc(p);
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

procedure TVectors3fHelper.Add(x, y, z: TGLfloat); inline;
begin
  Self += [x, y, z];
end;

procedure TVectors3fHelper.Add(const v: TVector3f);
begin
  Self += [v];
end;

procedure TVectors3fHelper.Add(const v: TVectors3f);
begin
  Self += v;
end;

procedure TVectors3fHelper.AddRectangle(w, h: TGLfloat; x: TGLfloat; y: TGLfloat; z: TGLfloat);
var
  w2, h2: TGLfloat;
begin
  w2 := w / 2;
  h2 := h / 2;
  Self += [
    -w2 + x, -h2 + y, z, w2 + x, -h2 + y, z, w2 + x, h2 + y, z,
    -w2 + x, -h2 + y, z, w2 + x, h2 + y, z, -w2 + x, h2 + y, z];
end;

procedure TVectors3fHelper.AddCube(w, h, d: TGLfloat; x: TGLfloat; y: TGLfloat; z: TGLfloat);
var
  w2, h2, d2: TGLfloat;
begin
  w2 := w / 2;
  h2 := h / 2;
  d2 := d / 2;
  Self += [
    // vorn
    -w2 + x, -h2 + y, d2 + z, w2 + x, -h2 + y, d2 + z, w2 + x, h2 + y, d2 + z,
    -w2 + x, -h2 + y, d2 + z, w2 + x, h2 + y, d2 + z, -w2 + x, h2 + y, d2 + z,

    // hinten
    w2 + x, h2 + y, -d2 + z, -w2 + x, -h2 + y, -d2 + z, -w2 + x, h2 + y, -d2 + z,
    w2 + x, h2 + y, -d2 + z, w2 + x, -h2 + y, -d2 + z, -w2 + x, -h2 + y, -d2 + z,

    // unten
    -w2 + x, -h2 + y, -d2 + z, w2 + x, -h2 + y, -d2 + z, w2 + x, -h2 + y, d2 + z,
    -w2 + x, -h2 + y, -d2 + z, w2 + x, -h2 + y, d2 + z, -w2 + x, -h2 + y, d2 + z,

    // rechts
    w2 + x, -h2 + y, -d2 + z, w2 + x, h2 + y, -d2 + z, w2 + x, h2 + y, d2 + z,
    w2 + x, -h2 + y, -d2 + z, w2 + x, h2 + y, d2 + z, w2 + x, -h2 + y, d2 + z,

    // oben
    w2 + x, h2 + y, -d2 + z, -w2 + x, h2 + y, -d2 + z, -w2 + x, h2 + y, d2 + z,
    w2 + x, h2 + y, -d2 + z, -w2 + x, h2 + y, d2 + z, w2 + x, h2 + y, d2 + z,

    // links
    -w2 + x, h2 + y, -d2 + z, -w2 + x, -h2 + y, -d2 + z, -w2 + x, -h2 + y, d2 + z,
    -w2 + x, h2 + y, -d2 + z, -w2 + x, -h2 + y, d2 + z, -w2 + x, h2 + y, d2 + z];
end;

procedure TVectors3fHelper.AddCubeNormale;
begin
  Self += [
    // vorn
    0.0, 0.0, 1.0, 0.0, 0.0, 1.0, 0.0, 0.0, 1.0, 0.0, 0.0, 1.0, 0.0, 0.0, 1.0, 0.0, 0.0, 1.0,
    // hinten
    0.0, 0.0, -1.0, 0.0, 0.0, -1.0, 0.0, 0.0, -1.0, 0.0, 0.0, -1.0, 0.0, 0.0, -1.0, 0.0, 0.0, -1.0,
    // unten
    0.0, -1.0, 0.0, 0.0, -1.0, 0.0, 0.0, -1.0, 0.0, 0.0, -1.0, 0.0, 0.0, -1.0, 0.0, 0.0, -1.0, 0.0,
    // rechts
    1.0, 0.0, 0.0, 1.0, 0.0, 0.0, 1.0, 0.0, 0.0, 1.0, 0.0, 0.0, 1.0, 0.0, 0.0, 1.0, 0.0, 0.0,
    // oben
    0.0, 1.0, 0.0, 0.0, 1.0, 0.0, 0.0, 1.0, 0.0, 0.0, 1.0, 0.0, 0.0, 1.0, 0.0, 0.0, 1.0, 0.0,
    // links
    0.0, -1.0, 0.0, 0.0, -1.0, 0.0, 0.0, -1.0, 0.0, 0.0, -1.0, 0.0, 0.0, -1.0, 0.0, 0.0, -1.0, 0.0];
end;

procedure TVectors3fHelper.AddCubeColor(col: TVector3f);
var
  i: integer;
begin
  for i := 0 to 35 do begin
    Self += [col];
  end;
end;

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
  p: SizeInt = 0;
begin
  for i := 0 to Length(Self) div 3 - 1 do begin
    Self[p] *= AScale.x;
    Inc(p);
    Self[p] *= AScale.y;
    Inc(p);
    Self[p] *= AScale.z;
    Inc(p);
  end;
end;

procedure TVectors3fHelper.Translate(const ATranslate: TVector3f);
var
  i: integer;
  p:Integer=0;
begin
  for i := 0 to Length(Self) div 3 - 1 do begin
//    PVector3f(@Self[i * 3])^.Translate(ATranslate);
    Self[p] += ATranslate.x;
    Inc(p);
    Self[p] += ATranslate.y;
    Inc(p);
    Self[p] += ATranslate.z;
    Inc(p);
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

procedure TVectors3fHelper.AddFace3D(const v0, v1, v2: TVector3f);
begin
  Self += [v0];
  Self += [v1];
  Self += [v2];
end;

procedure TVectors3fHelper.AddFace3DArray(const Face: array of TFace3D);
var
  p: integer;
begin
  p := Length(Self);
  SetLength(Self, p + 9 * Length(Face));
  Move(Face, Self[p], SizeOf(TFace3D) * Length(Face));
end;

end.
