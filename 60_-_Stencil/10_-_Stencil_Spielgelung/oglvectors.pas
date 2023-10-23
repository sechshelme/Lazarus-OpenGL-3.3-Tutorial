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

procedure TVectors2fHelper.AddQuadTexCoords;inline;
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
begin
  Self += [
    TVector3f([0 + x, 0 + y, 0 + z]), TVector3f([w + x, 0 + y, 0 + z]), TVector3f([w + x, h + y, 0 + z]),
    TVector3f([0 + x, 0 + y, 0 + z]), TVector3f([w + x, h + y, 0 + z]), TVector3f([0 + x, h + y, 0 + z])];
end;

procedure TVectors3fHelper.AddCube(w, h, d: TGLfloat; x: TGLfloat; y: TGLfloat; z: TGLfloat);
begin
  Self += [
    // open
    TVector3f([0 + x, 0 + y, d + z]), TVector3f([w + x, 0 + y, d + z]), TVector3f([w + x, h + y, d + z]),
    TVector3f([0 + x, 0 + y, d + z]), TVector3f([w + x, h + y, d + z]), TVector3f([0 + x, h + y, d + z]),

    // unten
    TVector3f([w + x, h + y, 0 + z]), TVector3f([0 + x, h + y, 0 + z]), TVector3f([0 + x, 0 + y, 0 + z]),
    TVector3f([w + x, h + y, 0 + z]), TVector3f([0 + x, 0 + y, 0 + z]), TVector3f([w + x, 0 + y, 0 + z]),

    // vorn
    TVector3f([0 + x, 0 + y, 0 + z]), TVector3f([w + x, 0 + y, 0 + z]), TVector3f([w + x, 0 + y, d + z]),
    TVector3f([0 + x, 0 + y, 0 + z]), TVector3f([w + x, 0 + y, d + z]), TVector3f([0 + x, 0 + y, d + z]),

    // rechts
    TVector3f([w + x, 0 + y, 0 + z]), TVector3f([w + x, h + y, 0 + z]), TVector3f([w + x, h + y, d + z]),
    TVector3f([w + x, 0 + y, 0 + z]), TVector3f([w + x, h + y, d + z]), TVector3f([w + x, 0 + y, d + z]),

    // hinten
    TVector3f([w + x, h + y, 0 + z]), TVector3f([0 + x, h + y, 0 + z]), TVector3f([0 + x, h + y, d + z]),
    TVector3f([w + x, h + y, 0 + z]), TVector3f([0 + x, h + y, d + z]), TVector3f([w + x, h + y, d + z]),

    // links
    TVector3f([0 + x, h + y, 0 + z]), TVector3f([0 + x, 0 + y, 0 + z]), TVector3f([0 + x, 0 + y, d + z]),
    TVector3f([0 + x, h + y, 0 + z]), TVector3f([0 + x, 0 + y, d + z]), TVector3f([0 + x, h + y, d + z])];
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
