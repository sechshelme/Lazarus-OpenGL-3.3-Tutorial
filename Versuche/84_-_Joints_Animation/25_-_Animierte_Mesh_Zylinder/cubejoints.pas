unit CubeJoints;

{$modeswitch arrayoperators}
{$modeswitch typehelpers}

interface

uses
  dglOpenGL, oglVectors;

type
  TJointIDs = type TGlInts;

  { TJointIDsHelper }

  TJointIDsHelper = type Helper(TglintsHelper) for TJointIDs
    procedure AddCube(pri, sek: integer);
    procedure AddCubeLateral(pri, sek: integer);
    procedure AddRectangle(pri: integer);
    procedure AddZylinder(pri, sek: integer);
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

procedure TJointIDsHelper.AddZylinder(pri, sek: integer);
var
  i: integer;
begin
  for i := 0 to Sektoren - 1 do begin
    Self += [
      sek, pri, pri, sek, pri, sek];
  end;
end;

end.
