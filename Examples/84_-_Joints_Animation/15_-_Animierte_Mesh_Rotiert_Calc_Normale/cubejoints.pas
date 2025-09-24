unit CubeJoints;

{$modeswitch arrayoperators}
{$modeswitch typehelpers}

interface

uses
  oglglad_gl, oglVectors;

type
  TJointIDs = type TGlInts;

  { TJointIDsHelper }

  TJointIDsHelper = type Helper(TglintsHelper) for TJointIDs
procedure AddCube(pri, sek: integer);
procedure AddCubeLateral(pri, sek: integer);
procedure AddRectangle(pri: integer);
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

procedure TJointIDsHelper.AddCubeLateral(pri, sek: integer);
begin
      Self += [
        pri, pri, sek, pri, sek, sek,  // unten
        pri, pri, sek, pri, sek, sek,  // rechts
        pri, pri, sek, pri, sek, sek,  // oben
        pri, pri, sek, pri, sek, sek]; // unten
end;

procedure TJointIDsHelper.AddRectangle(pri: integer);
begin
      Self += [
        pri, pri, pri, pri, pri, pri];
end;

end.
