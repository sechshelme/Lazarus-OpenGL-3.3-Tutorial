unit oglVectors;

{$modeswitch typehelpers}
{$modeswitch arrayoperators}

interface

uses
  Classes, SysUtils, dglOpenGL, oglvector;

type
  TVectors2f = array of TVector2f;
  TVectors3f = array of TVector3f;

  { TVectors2fHelper }

  TVectors2fHelper = type Helper for TVectors2f
  public
    procedure Add(x, y, z: TGLfloat);
    procedure AddRectangle(w, h: TGLfloat; x: TGLfloat = 0; y: TGLfloat = 0);
    procedure AddQuadTexCoords;
    procedure AddCubeTexCoords;
    function Count: TGLint;
    function Size: TGLsizei;
    function Ptr: TGLvoid;
  end;


  { TVectors3fHelper }

  TVectors3fHelper = type Helper for TVectors3f
  public
    procedure Add(x, y, z: TGLfloat);
    procedure AddRectangle(w, h: TGLfloat; x: TGLfloat = 0; y: TGLfloat = 0; z: TGLfloat = 0);
    procedure AddCube(w, h, d: TGLfloat; x: TGLfloat = 0; y: TGLfloat = 0; z: TGLfloat = 0);
    procedure AddCubeNormale;
    procedure Scale(AScale: TGLfloat);
    procedure Scale(AScale: TVector3f);
    procedure Translate(ATranslate: TVector3f);
    function Count: TGLint;
    function Size: TGLsizei;
    function Ptr: TGLvoid;
  end;

implementation

{ TVectors2fHelper }

procedure TVectors2fHelper.Add(x, y, z: TGLfloat); inline;
begin
  Self += [TVector2f([x, y])];
end;

procedure TVectors2fHelper.AddRectangle(w, h: TGLfloat; x: TGLfloat; y: TGLfloat);
begin
  Self += [
    TVector2f([0 + x, 0 + y]), TVector2f([w + x, 0 + y]), TVector2f([w + x, h + y]),
    TVector2f([0 + x, 0 + y]), TVector2f([w + x, h + y]), TVector2f([0 + x, h + y])];
end;

procedure TVectors2fHelper.AddQuadTexCoords; inline;
const
  quad: TVectors2f = (
    (0, 0), (1, 0), (1, 1),
    (0, 0), (1, 1), (0, 1));
begin
  Self += quad;
end;

procedure TVectors2fHelper.AddCubeTexCoords;
const
  quad: TVectors2f = (
    (0, 0), (1, 0), (1, 1),
    (0, 0), (1, 1), (0, 1));
begin
  Self += quad + quad + quad + quad + quad + quad;
end;

function TVectors2fHelper.Count: TGLint; inline;
begin
  Result := Length(Self);
end;

function TVectors2fHelper.Size: TGLsizei; inline;
begin
  Result := Length(Self) * SizeOf(TVector2f);
end;

function TVectors2fHelper.Ptr: TGLvoid; inline;
begin
  Result := TGLvoid(Self);
end;

{ TVectors3fHelper }

procedure TVectors3fHelper.Add(x, y, z: TGLfloat); inline;
begin
  Self += [TVector3f([x, y, z])];
end;

procedure TVectors3fHelper.AddRectangle(w, h: TGLfloat; x: TGLfloat; y: TGLfloat; z: TGLfloat);
var
  w2, h2: TGLfloat;
begin
  w2 := w / 2;
  h2 := h / 2;
  Self += [
    [-w2 + x, -h2 + y, z], [w2 + x, -h2 + y, z], [w2 + x, h2 + y, z],
    [-w2 + x, -h2 + y, z], [w2 + x, h2 + y, z], [-w2 + x, h2 + y, z]];
end;

procedure TVectors3fHelper.AddCube(w, h, d: TGLfloat; x: TGLfloat; y: TGLfloat; z: TGLfloat);
var
  w2, h2, d2: TGLfloat;
begin
  w2 := w / 2;
  h2 := h / 2;
  d2 := d / 2;
  Self += [
    // oben
    [-w2 + x, -h2 + y, d2 + z], [w2 + x, -h2 + y, d2 + z], [w2 + x, h2 + y, d2 + z],
    [-w2 + x, -h2 + y, d2 + z], [w2 + x, h2 + y, d2 + z], [-w2 + x, h2 + y, d2 + z],

    // unten
    [w2 + x, h2 + y, -d2 + z], [-w2 + x, h2 + y, -d2 + z], [-w2 + x, -h2 + y, -d2 + z],
    [w2 + x, h2 + y, -d2 + z], [-w2 + x, -h2 + y, -d2 + z], [w2 + x, -h2 + y, -d2 + z],

    // vorn
    [-w2 + x, -h2 + y, -d2 + z], [w2 + x, -h2 + y, -d2 + z], [w2 + x, -h2 + y, d2 + z],
    [-w2 + x, -h2 + y, -d2 + z], [w2 + x, -h2 + y, d2 + z], [-w2 + x, -h2 + y, d2 + z],

    // rechts
    [w2 + x, -h2 + y, -d2 + z], [w2 + x, h2 + y, -d2 + z], [w2 + x, h2 + y, d2 + z],
    [w2 + x, -h2 + y, -d2 + z], [w2 + x, h2 + y, d2 + z], [w2 + x, -h2 + y, d2 + z],

    // hinten
    [w2 + x, h2 + y, -d2 + z], [-w2 + x, h2 + y, -d2 + z], [-w2 + x, h2 + y, d2 + z],
    [w2 + x, h2 + y, -d2 + z], [-w2 + x, h2 + y, d2 + z], [w2 + x, h2 + y, d2 + z],

    // links
    [-w2 + x, h2 + y, -d2 + z], [-w2 + x, -h2 + y, -d2 + z], [-w2 + x, -h2 + y, d2 + z],
    [-w2 + x, h2 + y, -d2 + z], [-w2 + x, -h2 + y, d2 + z], [-w2 + x, h2 + y, d2 + z]];
end;

procedure TVectors3fHelper.AddCubeNormale;
begin
  Self += [
    // oben
    [0.0, 0.0, 1.0], [0.0, 0.0, 1.0], [0.0, 0.0, 1.0], [0.0, 0.0, 1.0], [0.0, 0.0, 1.0], [0.0, 0.0, 1.0],
    // unten
    [0.0, 0.0, -1.0], [0.0, 0.0, -1.0], [0.0, 0.0, -1.0], [0.0, 0.0, -1.0], [0.0, 0.0, -1.0], [0.0, 0.0, -1.0],
    // vorn
    [0.0, -1.0, 0.0], [0.0, -1.0, 0.0], [0.0, -1.0, 0.0], [0.0, -1.0, 0.0], [0.0, -1.0, 0.0], [0.0, -1.0, 0.0],
    // rechts
    [1.0, 0.0, 0.0], [1.0, 0.0, 0.0], [1.0, 0.0, 0.0], [1.0, 0.0, 0.0], [1.0, 0.0, 0.0], [1.0, 0.0, 0.0],
    // hinten
    [0.0, 1.0, 0.0], [0.0, 1.0, 0.0], [0.0, 1.0, 0.0], [0.0, 1.0, 0.0], [0.0, 1.0, 0.0], [0.0, 1.0, 0.0],
    // links
    [0.0, -1.0, 0.0], [0.0, -1.0, 0.0], [0.0, -1.0, 0.0], [0.0, -1.0, 0.0], [0.0, -1.0, 0.0], [0.0, -1.0, 0.0]];
end;

procedure TVectors3fHelper.Scale(AScale: TGLfloat);
begin
  Self.Scale([AScale, AScale, AScale]);
end;

procedure TVectors3fHelper.Scale(AScale: TVector3f);
var
  i: integer;
begin
  for i := 0 to Length(Self) - 1 do begin
    Self[i].x := Self[i].x * AScale.x;
    Self[i].y := Self[i].y * AScale.y;
    Self[i].z := Self[i].z * AScale.z;
  end;
end;

procedure TVectors3fHelper.Translate(ATranslate: TVector3f);
var
  i: integer;
begin
  for i := 0 to Length(Self) - 1 do begin
    Self[i].x := Self[i].x + ATranslate.x;
    Self[i].y := Self[i].y + ATranslate.y;
    Self[i].z := Self[i].z + ATranslate.z;
  end;
end;

function TVectors3fHelper.Count: TGLint; inline;
begin
  Result := Length(Self);
end;

function TVectors3fHelper.Size: TGLsizei; inline;
begin
  Result := Length(Self) * SizeOf(TVector3f);
end;

function TVectors3fHelper.Ptr: TGLvoid; inline;
begin
  Result := TGLvoid(Self);
end;

end.