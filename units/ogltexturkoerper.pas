unit oglTexturKoerper;

{$mode objfpc}{$H+}

interface

uses
  Classes,
  SysUtils,
  oglTextur, oglTexturVAO,
  oglMatrix;

type

  { TTexturRectangle }

  TTexturRectangle = class(TMultiTexturVAO)
  public
    procedure WriteVertex;
  end;

  { TTexturCube }

  TTexturCube = class(TMultiTexturVAO)
  public
    procedure WriteVertex;
  end;

  { TTexturBox }

  TTexturBox = class(TMultiTexturVAO)
  public
    procedure WriteVertex;
  end;

  { TBumpmappingTexturBox }

  TBumpmappingTexturBox = class(TBumpmappingTexturVAO)
  public
    procedure WriteVertex;
  end;

  { TTexturCylinder }

  TTexturCylinder = class(TMultiTexturVAO)
  public
    constructor Create(anzTextures: integer; light: boolean = True);
    procedure WriteVertex;
  private
    procedure Ring(r1, r2, h1, h2: single);
  end;


  { TBumpmappingTexturSphere }

  TBumpmappingTexturSphere = class(TBumpmappingTexturVAO)
  public
    constructor Create(light: boolean = True);
    procedure WriteVertex;
  end;


implementation

const
  Quad: array[0..11] of Tmat3x3 = (
    // Umfang
    ((-0.5, +0.5, +0.5), (-0.5, -0.5, +0.5), (+0.5, -0.5, +0.5)), ((-0.5, +0.5, +0.5), (+0.5, -0.5, +0.5), (+0.5, +0.5, +0.5)),
    ((+0.5, +0.5, +0.5), (+0.5, -0.5, +0.5), (+0.5, -0.5, -0.5)), ((+0.5, +0.5, +0.5), (+0.5, -0.5, -0.5), (+0.5, +0.5, -0.5)),
    ((+0.5, +0.5, -0.5), (+0.5, -0.5, -0.5), (-0.5, -0.5, -0.5)), ((+0.5, +0.5, -0.5), (-0.5, -0.5, -0.5), (-0.5, +0.5, -0.5)),
    ((-0.5, +0.5, -0.5), (-0.5, -0.5, -0.5), (-0.5, -0.5, +0.5)), ((-0.5, +0.5, -0.5), (-0.5, -0.5, +0.5), (-0.5, +0.5, +0.5)),
    // oben
    ((+0.5, +0.5, +0.5), (+0.5, +0.5, -0.5), (-0.5, +0.5, -0.5)), ((+0.5, +0.5, +0.5), (-0.5, +0.5, -0.5), (-0.5, +0.5, +0.5)),
    // unten
    ((-0.5, -0.5, +0.5), (-0.5, -0.5, -0.5), (+0.5, -0.5, -0.5)), ((-0.5, -0.5, +0.5), (+0.5, -0.5, -0.5), (+0.5, -0.5, +0.5)));

  QuadTextureVertex: array[0..11] of Tmat3x2 = (
    ((0.0, 0.0), (0.0, 1.0), (1.0, 1.0)), ((0.0, 0.0), (1.0, 1.0), (1.0, 0.0)),
    ((0.0, 0.0), (0.0, 1.0), (1.0, 1.0)), ((0.0, 0.0), (1.0, 1.0), (1.0, 0.0)),
    ((0.0, 0.0), (0.0, 1.0), (1.0, 1.0)), ((0.0, 0.0), (1.0, 1.0), (1.0, 0.0)),
    ((0.0, 0.0), (0.0, 1.0), (1.0, 1.0)), ((0.0, 0.0), (1.0, 1.0), (1.0, 0.0)),
    ((0.0, 0.0), (0.0, 1.0), (1.0, 1.0)), ((0.0, 0.0), (1.0, 1.0), (1.0, 0.0)),
    ((0.0, 0.0), (0.0, 1.0), (1.0, 1.0)), ((0.0, 0.0), (1.0, 1.0), (1.0, 0.0)));


{ TBumpmappingTexturBox }

procedure TBumpmappingTexturBox.WriteVertex;
begin
  Textur.TexCoord.Add(QuadTextureVertex);
  FVertexdata.Pos.Add(Quad);
  inherited WriteVertex;
end;

{ TTexturBox }

procedure TTexturBox.WriteVertex;
begin
  Textur.TexCoord.Add(QuadTextureVertex);
  FVertexdata.Pos.Add(Quad);
  inherited WriteVertex;
end;

{ TTexturCylinder }

constructor TTexturCylinder.Create(anzTextures: integer; light: boolean);
begin
  inherited Create(anzTextures, light);
  Sektoren := 12;
end;

procedure TTexturCylinder.WriteVertex;
var
  vPos: integer;
const
  Kegel = True;
begin
  if Kegel then begin
    vPos := 0;
    Ring(1, 2, -1, 1);
    vPos := FSektoren * 6;
    Ring(2, 0, 1, 1);
    vPos := vPos + FSektoren * 6;
    Ring(0, 1, -1, -1);
  end else begin
    //vPos := 0;
    //Ring(1, 1, -1, 1);
    //vPos := FSektoren * 6;
    //Ring(1, 0, 1, 1);
    //vPos := vPos + FSektoren * 6;
    //Ring(0, 1, -1, -1);
  end;

  inherited WriteVertex;
end;

procedure TTexturCylinder.Ring(r1, r2, h1, h2: single);
var
  i: integer;
begin
  inherited Ring(r1, r2, h1, h2);

  for i := 0 to FSektoren - 1 do begin
    with Textur do begin
      TexCoord.Add(
        vec2((i + 1) / FSektoren, 1.0),
        vec2((i + 1) / FSektoren, 0.0),
        vec2((i + 0) / FSektoren, 0.0));
      TexCoord.Add(
        vec2((i + 1) / FSektoren, 1.0),
        vec2((i + 0) / FSektoren, 0.0),
        vec2((i + 0) / FSektoren, 1.0));
    end;
  end;
end;

{ TBumpmappingTexturSphere }

constructor TBumpmappingTexturSphere.Create(light: boolean);
begin
  inherited Create(light);
  Sektoren := 16;
  Caption := 'Textur-Sphere';
end;

procedure TBumpmappingTexturSphere.WriteVertex;
const
  dm = 0.5;
  Stauchung = 1.0;
var
  i, j: integer;
  t, rk: single;

  Tab: array of array of record
    a, b, c: single;
  end;

begin
  t := 2 * pi / Sektoren;
  SetLength(Tab, FSektoren + 1, FSektoren div 2 + 1);
  for j := 0 to FSektoren div 2 do begin
    rk := sin(t * j);
    for i := 0 to FSektoren do begin
      with Tab[i, j] do begin
        a := sin(t * i) * rk;
        b := cos(t * i) * rk;
        c := cos(t * j);
      end;
    end;
  end;

  for j := 0 to FSektoren div 2 - 1 do begin
    for i := 0 to FSektoren - 1 do begin
      Quads(
        vec3(Tab[i + 0, j + 1].a * dm, Tab[i + 0, j + 1].c * dm * Stauchung, Tab[i + 0, j + 1].b * dm),
        vec3(Tab[i + 1, j + 1].a * dm, Tab[i + 1, j + 1].c * dm * Stauchung, Tab[i + 1, j + 1].b * dm),
        vec3(Tab[i + 1, j + 0].a * dm, Tab[i + 1, j + 0].c * dm * Stauchung, Tab[i + 1, j + 0].b * dm),
        vec3(Tab[i + 0, j + 0].a * dm, Tab[i + 0, j + 0].c * dm * Stauchung, Tab[i + 0, j + 0].b * dm),

        vec3(Tab[i + 0, j + 1].a, Tab[i + 0, j + 1].c / Stauchung, Tab[i + 0, j + 1].b),
        vec3(Tab[i + 1, j + 1].a, Tab[i + 1, j + 1].c / Stauchung, Tab[i + 1, j + 1].b),
        vec3(Tab[i + 1, j + 0].a, Tab[i + 1, j + 0].c / Stauchung, Tab[i + 1, j + 0].b),
        vec3(Tab[i + 0, j + 0].a, Tab[i + 0, j + 0].c / Stauchung, Tab[i + 0, j + 0].b));

      with Textur do begin
        TexCoord.Add(
          vec2((i + 0) / FSektoren, (j + 1) / FSektoren * 2),
          vec2((i + 1) / FSektoren, (j + 1) / FSektoren * 2),
          vec2((i + 1) / FSektoren, (j + 0) / FSektoren * 2));
        TexCoord.Add(
          vec2((i + 0) / FSektoren, (j + 1) / FSektoren * 2),
          vec2((i + 1) / FSektoren, (j + 0) / FSektoren * 2),
          vec2((i + 0) / FSektoren, (j + 0) / FSektoren * 2));
      end;
    end;
  end;
  SetLength(Tab, 0, 0);

  inherited WriteVertex;
end;


{ TTexturCube }

procedure TTexturCube.WriteVertex;
const
  Quad: array[0..7] of Tmat3x3 =
    (((-1.0, 1.0, 1.0), (-1.0, -1.0, 1.0), (1.0, -1.0, 1.0)), ((-1.0, 1.0, 1.0), (1.0, -1.0, 1.0), (1.0, 1.0, 1.0)),
    ((1.0, 1.0, 1.0), (1.0, -1.0, 1.0), (1.0, -1.0, -1.0)), ((1.0, 1.0, 1.0), (1.0, -1.0, -1.0), (1.0, 1.0, -1.0)),
    ((1.0, 1.0, -1.0), (1.0, -1.0, -1.0), (-1.0, -1.0, -1.0)), ((1.0, 1.0, -1.0), (-1.0, -1.0, -1.0), (-1.0, 1.0, -1.0)),
    ((-1.0, 1.0, -1.0), (-1.0, -1.0, -1.0), (-1.0, -1.0, 1.0)), ((-1.0, 1.0, -1.0), (-1.0, -1.0, 1.0), (-1.0, 1.0, 1.0)));

  QuadTextureVertex: array[0..7] of Tmat3x2 = (
    ((0.0, 1.0), (0.0, 0.0), (1.0, 0.0)), ((0.0, 1.0), (1.0, 0.0), (1.0, 1.0)),
    ((1.0, 1.0), (1.0, 0.0), (2.0, 0.0)), ((1.0, 1.0), (2.0, 0.0), (2.0, 1.0)),
    ((2.0, 1.0), (2.0, 0.0), (3.0, 0.0)), ((2.0, 1.0), (3.0, 0.0), (3.0, 1.0)),
    ((3.0, 1.0), (3.0, 0.0), (4.0, 0.0)), ((3.0, 1.0), (4.0, 0.0), (4.0, 1.0)));
begin
  with Textur do begin
    TexCoord.Add(QuadTextureVertex);
  end;
  with  FVertexdata do begin
    Pos.Add(Quad);
  end;

  inherited;
end;


{ TRectangle }

procedure TTexturRectangle.WriteVertex;
const
  Rectangle: array [0..1] of Tmat3x3 =
    (((-1.0, -1.0, 0.0), (1.0, 1.0, 0.0), (-1.0, 1.0, 0.0)),
    ((-1.0, -1.0, 0.0), (1.0, -1.0, 0.0), (1.0, 1.0, 0.0)));
  TextureVertex: array [0..1] of Tmat3x2 =
    (((0.0, 0.0), (1.0, 1.0), (0.0, 1.0)),
    ((0.0, 0.0), (1.0, 0.0), (1.0, 1.0)));
begin
  with Textur do begin
    TexCoord.Add(TextureVertex);
  end;
  with FVertexdata do begin
    Pos.Add(Rectangle);
  end;

  inherited WriteVertex;
end;

end.
