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
    procedure AddCube(dir: TJointDirection; pri, sek: integer);
  end;


implementation

procedure TJointIDsHelper.AddCube(dir: TJointDirection; pri, sek: integer);
begin
  case dir of
    jdFar: begin
      Self += [
        sek, sek, sek, sek, sek, sek,  // vorn
        pri, pri, pri, pri, pri, pri,  // hinten
        pri, pri, sek, pri, sek, sek,  // unten
        pri, pri, sek, pri, sek, sek,  // rechts
        pri, pri, sek, pri, sek, sek,  // oben
        pri, pri, sek, pri, sek, sek]; // unten
    end;
    jdNear: begin
      Self += [
        pri, pri, pri, pri, pri, pri,
        sek, sek, sek, sek, sek, sek,
        sek, sek, pri, sek, pri, pri,
        sek, sek, pri, sek, pri, pri,
        sek, sek, pri, sek, pri, pri,
        sek, sek, pri, sek, pri, pri];
    end;
    jdBottom: begin
      Self += [
        sek, sek, pri, sek, pri, pri,
        pri, sek, pri, pri, sek, sek,
        sek, sek, sek, sek, sek, sek,
        sek, pri, pri, sek, pri, sek,
        pri, pri, pri, pri, pri, pri,
        pri, sek, sek, pri, sek, pri];
    end;
    jdRight: begin
      Self += [
        pri, sek, sek, pri, sek, pri,
        sek, pri, pri, sek, sek, pri,
        pri, sek, sek, pri, sek, pri,
        sek, sek, sek, sek, sek, sek,
        sek, pri, pri, sek, pri, sek,
        pri, pri, pri, pri, pri, pri];
    end;
    jdTop: begin
      Self += [
        pri, pri, sek, pri, sek, sek,
        sek, pri, sek, sek, pri, pri,
        pri, pri, pri, pri, pri, pri,
        pri, sek, sek, pri, sek, pri,
        sek, sek, sek, sek, sek, sek,
        sek, pri, pri, sek, pri, sek];
    end;
    jdLeft: begin
      Self += [
        sek, pri, pri, sek, pri, sek,
        pri, sek, sek, pri, pri, sek,
        sek, pri, pri, sek, pri, sek,
        pri, pri, pri, pri, pri, pri,
        pri, sek, sek, pri, sek, pri,
        sek, sek, sek, sek, sek, sek];
    end;
  end;
end;

end.
