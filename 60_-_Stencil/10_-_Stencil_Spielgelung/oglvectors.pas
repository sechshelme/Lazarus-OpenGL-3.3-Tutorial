unit oglVectors;

{$modeswitch typehelpers}
{$modeswitch arrayoperators}

interface

uses
  Classes, SysUtils, dglOpenGL, oglvector;

type
  TVectors3f = array of TVector3f;

  { TVectors3fHelper }

  TVectors3fHelper = type Helper for TVectors3f
  public
    procedure Add(x, y, z: TGLfloat);
    procedure AddRectangle(w, h: TGLfloat; x: TGLfloat = 0; y: TGLfloat = 0; z: TGLfloat = 0);
    procedure AddCube(w, h, d: TGLfloat; x: TGLfloat = 0; y: TGLfloat = 0; z: TGLfloat = 0);
  end;

implementation

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

end.
