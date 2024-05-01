unit BlumeDonut;

{$modeswitch typehelpers on}
{$modeswitch arrayoperators on}
//{$modeswitch multihelpers}
{$modeswitch advancedrecords}

interface

uses
  Classes, SysUtils,
  oglVector, oglVectors;

type
  TDonut3f = type TVectors3f;

  TDonut3fHelper = type Helper(TVectors3fHelper) for TDonut3f
  public
    procedure AddDonut6(rd: single = 0.5);
    procedure AddDonut6Normale;
  end;

implementation

procedure TDonut3fHelper.AddDonut6(rd: single);
type
  quadVector = array[0..3] of TVector3f;

  procedure Quads(Vector: quadVector); inline;
  begin
    Self.Add([Vector[0], Vector[1], Vector[2], Vector[0], Vector[2], Vector[3]]);
  end;

var
  Donut: array of array of record
    x, y, z: single;
    end;
  i, j, Sektoren: integer;
  pi2sek, x1, y1, y2: single;
begin
  Sektoren:=SphereTab.Sectors;
  SetLength(Donut, Sektoren + 1, Sektoren + 1);

  pi2sek := Pi * 2 / Sektoren;

  for i := 0 to Sektoren do begin
    x1 := sin(i * pi2sek) * 0.5;
    y1 := cos(i * pi2sek) * 0.5;
    for j := 0 to Sektoren do begin
      y2 := cos(j * pi2sek) * rd;
      Donut[i, j].z := sin(j * pi2sek) * rd;
      Donut[i, j].x := (x1 + sin(i * pi2sek) * y2);
      Donut[i, j].y := (y1 + cos(i * pi2sek) * y2);
    end;
  end;

  for i := 0 to Sektoren div 6 - 1 do begin
    for j := 0 to Sektoren - 1 do begin
      Quads([
        [Donut[i + 0, j + 0].x, Donut[i + 0, j + 0].y, Donut[i + 0, j + 0].z],
        [Donut[i + 0, j + 1].x, Donut[i + 0, j + 1].y, Donut[i + 0, j + 1].z],
        [Donut[i + 1, j + 1].x, Donut[i + 1, j + 1].y, Donut[i + 1, j + 1].z],
        [Donut[i + 1, j + 0].x, Donut[i + 1, j + 0].y, Donut[i + 1, j + 0].z]]);
    end;
  end;
end;

procedure TDonut3fHelper.AddDonut6Normale;
type
  quadVector = array[0..3] of TVector3f;

  procedure Quads(Vector: quadVector); inline;
  begin
    Self.Add([Vector[0], Vector[1], Vector[2], Vector[0], Vector[2], Vector[3]]);
  end;

var
  Donut: array of array of record
    x, y, z: single;
    end;
  i, j, Sektoren: integer;
  pi2sek, y2: single;

begin
  Sektoren:=SphereTab.Sectors;
  SetLength(Donut, Sektoren + 1, Sektoren + 1);
  pi2sek := Pi * 2 / Sektoren;

  for i := 0 to Sektoren do begin
    for j := 0 to Sektoren do begin
      y2 := cos(j * pi2sek) * 1;
      Donut[i, j].z := sin(j * pi2sek) * 1;
      Donut[i, j].x := +sin(i * pi2sek) * y2;
      Donut[i, j].y := +cos(i * pi2sek) * y2;
    end;
  end;

  for i := 0 to Sektoren div 6 - 1 do begin
    for j := 0 to Sektoren - 1 do begin
      Quads([
        [Donut[i + 0, j + 0].x, Donut[i + 0, j + 0].y, Donut[i + 0, j + 0].z],
        [Donut[i + 0, j + 1].x, Donut[i + 0, j + 1].y, Donut[i + 0, j + 1].z],
        [Donut[i + 1, j + 1].x, Donut[i + 1, j + 1].y, Donut[i + 1, j + 1].z],
        [Donut[i + 1, j + 0].x, Donut[i + 1, j + 0].y, Donut[i + 1, j + 0].z]]);
    end;
  end;

end;

end.
