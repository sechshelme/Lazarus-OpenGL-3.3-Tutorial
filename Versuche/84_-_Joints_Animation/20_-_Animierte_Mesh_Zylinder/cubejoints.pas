unit CubeJoints;

{$modeswitch arrayoperators}
{$modeswitch typehelpers}

interface

uses
  dglOpenGL, oglVectors;

type
  TJointIDs = type TGlInts;

  TJointIDsHelper = type Helper(TglintsHelper) for TJointIDs
    procedure AddRectangle(pri: integer);
    procedure AddCube(pri, sek: integer);
    procedure AddCubeLateral(pri, sek: integer);
    procedure AddDisc(pri: integer);
    procedure AddZylinder(pri, sek: integer);
  end;

implementation

procedure TJointIDsHelper.AddRectangle(pri: integer);
begin
  Self += [pri, pri, pri, pri, pri, pri];
end;

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

procedure TJointIDsHelper.AddDisc(pri: integer);
var
  i, Sektoren: integer;
begin
  Sektoren:=SphereTab.Sectors;
  for i := 0 to Sektoren - 1 do begin
    Self += [pri, pri, pri];
  end;
end;

procedure TJointIDsHelper.AddZylinder(pri, sek: integer);
var
  i, Sektoren: integer;
begin
  Sektoren:=SphereTab.Sectors;
  for i := 0 to Sektoren - 1 do begin
    Self += [sek, pri, pri, sek, pri, sek];
  end;
end;

end.
