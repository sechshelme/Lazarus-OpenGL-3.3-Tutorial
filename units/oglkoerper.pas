unit oglKoerper;

{$mode objfpc}{$H+}

interface

uses
  oglVAO, oglVertex, oglMatrix;

type

  { TTriangle }

  TTriangle = class(TMonoColorVAO)
  public
    procedure WriteVertex;
  end;

  { TRectangle }

  TRectangle = class(TMonoColorVAO)
  public
    procedure WriteVertex;
  end;

  { TQuad }

  TQuad = class(TMonoColorVAO)
  public
    procedure WriteVertex;
  end;

  { TCube }

  TCube = class(TMonoColorVAO)
  public
    procedure WriteVertex;
  end;

  { TCylinder }

  TCylinder = class(TMonoColorVAO)
  public
    constructor Create;
    procedure WriteVertex;
  end;

  { THollowCylinder }

  THollowCylinder = class(TMonoColorVAO)
  public
    constructor Create;
    procedure WriteVertex;
  end;

  { THollowCone }

  THollowCone = class(TMonoColorVAO)
  private
    Masse: record
      r1, r2, r3, r4, h1, h2: single;
    end;
  public
    constructor Create;
    procedure WriteVertex;
  end;

  { TDonut }

  TDonut = class(TMonoColorVAO)
  public
    procedure WriteVertex;
  end;


implementation

{ TTriangle }

procedure TTriangle.WriteVertex;
const
  Triangle: array [0..0] of Tmat3x3 = (((-0.4, 0.1, 0.0), (0.4, 0.1, 0.0), (0.0, 0.7, 0.0)));
begin
  FVertexdata.Pos.Add(Triangle);

  inherited;
end;

{ TRectangle }

procedure TRectangle.WriteVertex;
const
  Rectangle: array [0..1] of Tmat3x3 = (((-1.0, -1.0, 0.0), (1.0, 1.0, 0.0), (-1.0, 1.0, 0.0)),
    ((-1.0, -1.0, 0.0), (1.0, -1.0, 0.0), (1.0, 1.0, 0.0)));
begin
  FVertexdata.Pos.Add(Rectangle);

  inherited;
end;


{ TQuad }

procedure TQuad.WriteVertex;
const
  Quad: array[0..7] of Tmat3x3 =
    (((-0.5, 0.5, 0.5), (-0.5, -0.5, 0.5), (0.5, -0.5, 0.5)), ((-0.5, 0.5, 0.5), (0.5, -0.5, 0.5), (0.5, 0.5, 0.5)),
    ((0.5, 0.5, 0.5), (0.5, -0.5, 0.5), (0.5, -0.5, -0.5)), ((0.5, 0.5, 0.5), (0.5, -0.5, -0.5), (0.5, 0.5, -0.5)),
    ((0.5, 0.5, -0.5), (0.5, -0.5, -0.5), (-0.5, -0.5, -0.5)), ((0.5, 0.5, -0.5), (-0.5, -0.5, -0.5), (-0.5, 0.5, -0.5)),
    ((-0.5, 0.5, -0.5), (-0.5, -0.5, -0.5), (-0.5, -0.5, 0.5)), ((-0.5, 0.5, -0.5), (-0.5, -0.5, 0.5), (-0.5, 0.5, 0.5)));

begin
  FVertexdata.Pos.Add(Quad);

  inherited;
end;


{ TCube }

procedure TCube.WriteVertex;
const
  Cube: array[0..11] of Tmat3x3 =
    (((-0.5, -0.5, -0.5), (-0.5, -0.5, 0.5), (-0.5, 0.5, 0.5)), ((0.5, 0.5, -0.5), (-0.5, -0.5, -0.5), (-0.5, 0.5, -0.5)),
    ((0.5, -0.5, 0.5), (-0.5, -0.5, -0.5), (0.5, -0.5, -0.5)), ((0.5, 0.5, -0.5), (0.5, -0.5, -0.5), (-0.5, -0.5, -0.5)),
    ((-0.5, -0.5, -0.5), (-0.5, 0.5, 0.5), (-0.5, 0.5, -0.5)), ((0.5, -0.5, 0.5), (-0.5, -0.5, 0.5), (-0.5, -0.5, -0.5)),
    ((-0.5, 0.5, 0.5), (-0.5, -0.5, 0.5), (0.5, -0.5, 0.5)), ((0.5, 0.5, 0.5), (0.5, -0.5, -0.5), (0.5, 0.5, -0.5)),
    ((0.5, -0.5, -0.5), (0.5, 0.5, 0.5), (0.5, -0.5, 0.5)), ((0.5, 0.5, 0.5), (0.5, 0.5, -0.5), (-0.5, 0.5, -0.5)),
    ((0.5, 0.5, 0.5), (-0.5, 0.5, -0.5), (-0.5, 0.5, 0.5)), ((0.5, 0.5, 0.5), (-0.5, 0.5, 0.5), (0.5, -0.5, 0.5)));

begin
  FVertexdata.Pos.Add(Cube);
  FVertexData.Pos.RotateB(Pi/5);

  inherited;
end;

{ TCylinder }

constructor TCylinder.Create;
begin
  inherited Create;
//  Kreis.Aktiv := True;
  Sektoren := 3;
end;

procedure TCylinder.WriteVertex;
var
  vPos: integer;
begin
  vPos := 0;
  Ring(1, 2, -1, 1);
  vPos := FSektoren * 6;
  Ring(2, 0, 1, 1);
  vPos := vPos + FSektoren * 6;
  Ring(0, 1, -1, -1);

  inherited WriteVertex;
end;

{ THollowCone }

constructor THollowCone.Create;
begin
  inherited Create;
//  Kreis.Aktiv := True;
  Sektoren := 3;

  with Masse do begin
    r1 := 1.5;
    r2 := 0.5;
    r3 := 1.0;
    r4 := 0.7;
    h1 := -1.0;
    h2 := 1.0;
  end;
end;

procedure THollowCone.WriteVertex;
var
  vPos: integer;
begin
  with Masse do begin
    vPos := 0;
    Ring(r1, r3, h1, h2);     // Achsial aussen
    vPos := FSektoren * 6;
    Ring(r4, r2, h2, h1);     // Achsial innen
    vPos := vPos + FSektoren * 6;
    Ring(r2, r1, h1, h1);     // Stirnseite unten
    vPos := vPos + FSektoren * 6;
    Ring(r3, r4, h2, h2);     // Stirnseite oben
  end;

  inherited WriteVertex;
end;

{ THollowCylinder }

constructor THollowCylinder.Create;
begin
  inherited Create;
  Sektoren := 3;
end;

procedure THollowCylinder.WriteVertex;
begin

end;

{ TDonut }

procedure TDonut.WriteVertex;
var
  Donut: array of array of record
    x, y, z: real;
  end;
  i, j: integer;
  x1, x2, x3, x4, y1, y2, y3, y4, z1, z2, z3, z4: single;

begin
  SetLength(Donut, Sektoren + 1, Sektoren + 1);

  for i := 0 to FSektoren do begin
    x1 := sin(i * Pi * 2 / FSektoren) * 200;
    y1 := cos(i * Pi * 2 / FSektoren) * 200;
    for j := 0 to FSektoren do begin
      with Donut[i, j] do begin
        y2 := cos(j * Pi * 2 / FSektoren) * 80;
        z := (sin(j * Pi * 2 / FSektoren) * 80) / 400;
        x := (x1 + sin(i * Pi * 2 / FSektoren) * y2) / 400;
        y := (y1 + cos(i * Pi * 2 / FSektoren) * y2) / 400;
      end;
    end;
  end;

  for i := 0 to FSektoren - 1 do begin
    for j := 0 to FSektoren - 1 do begin
      with Donut[i, j] do begin
        x1 := x;
        y1 := y;
        z1 := z;
      end;
      with Donut[i, j + 1] do begin
        x2 := x;
        y2 := y;
        z2 := z;
      end;
      with Donut[i + 1, j + 1] do begin
        x3 := x;
        y3 := y;
        z3 := z;
      end;
      with Donut[i + 1, j] do begin
        x4 := x;
        y4 := y;
        z4 := z;
      end;
      Quads(
        vec3(x1, y1, z1), vec3(x2, y2, z2), vec3(x3, y3, z3), vec3(x4, y4, z4),
        vec3(x1, y1, z1), vec3(x2, y2, z2), vec3(x3, y3, z3), vec3(x4, y4, z4));
    end;
  end;

  inherited;
end;

end.

