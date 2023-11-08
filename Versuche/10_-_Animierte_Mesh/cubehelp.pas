unit CubeHelp;

{$mode ObjFPC}{$H+}
{$modeswitch typehelpers}
{$modeswitch arrayoperators}

interface

uses
  dglOpenGL,oglVectors;



type

  TCubeAnimate = type TGlInts;

  TCADirection=(caLeft,caRight,caTop,caBottom,caNear,caFar);

  { TGlfloatsHelper }

  TGlfloatsHelper = type Helper for TCubeAnimate
procedure   AddCube(dir:TCADirection;p,m:Integer);
  function Size: TGLsizei;
  function Ptr: TGLvoid;
  end;


implementation

{ TGlfloatsHelper }

procedure TGlfloatsHelper.AddCube(dir: TCADirection; p, m: Integer);
begin
  case dir of
  caLeft:begin
    Self +=[
    m,p,p,     m,p,m,
    p,m,m,     p,p,m,
    m,p,p,     m,p,m,
    p,p,p,     p,p,p,
    p,m,m,     p,m,p,
    m,m,m,     m,m,m];
    end;
  caRight:begin
    Self +=[
    p,m,m,     p,m,p,
    m,p,p,     m,m,p,
    p,m,m,     p,m,p,
    m,m,m,     m,m,m,
    m,p,p,     m,p,m,
    p,p,p,     p,p,p];
    end;
  end;

end;

//Self += [
//  // oben
//  -w2 + x, -h2 + y, d2 + z, w2 + x, -h2 + y, d2 + z, w2 + x, h2 + y, d2 + z,
//  -w2 + x, -h2 + y, d2 + z, w2 + x, h2 + y, d2 + z, -w2 + x, h2 + y, d2 + z,
//
//  // unten
//  w2 + x, h2 + y, -d2 + z, -w2 + x, -h2 + y, -d2 + z, -w2 + x, h2 + y, -d2 + z,
//  w2 + x, h2 + y, -d2 + z, w2 + x, -h2 + y, -d2 + z, -w2 + x, -h2 + y, -d2 + z,
//
//  // vorn
//  -w2 + x, -h2 + y, -d2 + z, w2 + x, -h2 + y, -d2 + z, w2 + x, -h2 + y, d2 + z,
//  -w2 + x, -h2 + y, -d2 + z, w2 + x, -h2 + y, d2 + z, -w2 + x, -h2 + y, d2 + z,
//
//  // rechts
//  w2 + x, -h2 + y, -d2 + z, w2 + x, h2 + y, -d2 + z, w2 + x, h2 + y, d2 + z,
//  w2 + x, -h2 + y, -d2 + z, w2 + x, h2 + y, d2 + z, w2 + x, -h2 + y, d2 + z,
//
//  // hinten
//  w2 + x, h2 + y, -d2 + z, -w2 + x, h2 + y, -d2 + z, -w2 + x, h2 + y, d2 + z,
//  w2 + x, h2 + y, -d2 + z, -w2 + x, h2 + y, d2 + z, w2 + x, h2 + y, d2 + z,
//
//  // links
//  -w2 + x, h2 + y, -d2 + z, -w2 + x, -h2 + y, -d2 + z, -w2 + x, -h2 + y, d2 + z,
//  -w2 + x, h2 + y, -d2 + z, -w2 + x, -h2 + y, d2 + z, -w2 + x, h2 + y, d2 + z];



function TGlfloatsHelper.Size: TGLsizei;
begin
  Result := Length(Self) * SizeOf(TGLint);
end;

function TGlfloatsHelper.Ptr: TGLvoid;
begin
  Result := TGLvoid(Self);
end;

end.

