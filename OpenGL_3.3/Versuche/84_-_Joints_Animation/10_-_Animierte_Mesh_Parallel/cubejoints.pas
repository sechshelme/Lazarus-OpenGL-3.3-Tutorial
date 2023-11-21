unit CubeJoints;

{$modeswitch arrayoperators}
{$modeswitch typehelpers}

interface

uses
  dglOpenGL, oglVectors;

type

  TJointIDs = type TGlInts;
  TJointDirection = (jdLeft, jdRight, jdTop, jdBottom, jdNear, jdFar);

  TJointIDsHelper = type Helper(TglintsHelper) for TJointIDs
    procedure AddCube(pri, sek: integer);
  end;


implementation

procedure TJointIDsHelper.AddCube(pri, sek: integer);
begin
      Self += [
        sek, sek, sek, sek, sek, sek,  // vorn
        pri, pri, pri, pri, pri, pri,  // hinten
        pri, pri, sek, pri, sek, sek,  // unten
        pri, pri, sek, pri, sek, sek,  // rechts
        pri, pri, sek, pri, sek, sek,  // oben
        pri, pri, sek, pri, sek, sek]; // unten
end;

end.
