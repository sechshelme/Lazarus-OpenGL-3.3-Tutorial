unit VLIFlansch;

{$mode objfpc}{$H+}

interface

uses
  Classes,
  Dialogs,
  SysUtils,
  VLIBasis,
  oglVector, oglMatrix, oglVBO;

type
  TFlansch = class(TUrAnzeiger)
  private
    procedure LochFlansch(DInnen, DAussen, LochKreis, Bohrung, h: single);
    procedure FlanschUmfang(aussen, h1, h2: single);
    procedure FlanschBohrung(lk, BohrungD, h1, h2: single);
    procedure Schnitt_L_Form(l01, l1, l2, aussen_d, mitte_d, innen_d: single);
  end;


  { TRohrFlanschen }

  TRohrFlansch = class(TFlansch)
  public
    constructor Create;
    procedure WriteVertex;
  end;

  { TRohrFlanschSchnitt }

  TRohrFlanschSchnitt = class(TFlansch)
  public
    constructor Create;
    procedure WriteVertex;
  end;

  { TProcessFlansch }

  TProcessFlansch = class(TFlansch)
  public
    constructor Create;
    procedure WriteVertex;
  end;

  { TProcessFlanschSchnitt }

  TProcessFlanschSchnitt = class(TFlansch)
  public
    constructor Create;
    procedure WriteVertex;
  end;


implementation

procedure TFlansch.LochFlansch(DInnen, DAussen, LochKreis, Bohrung, h: single);
var
  i, Sek, i2: integer;
  t, r3, l: single;

  function rot(v: TVector3f; Winkel: single): TVector3f;
  begin
    v.RotateB(Winkel);
    Result := v;
  end;

begin
  DInnen /= 2;
  DAussen /= 2;
  LochKreis /= 2;
  Bohrung /= 2;

  l := (DAussen - DInnen) / (FSektoren div 4) * 2;
  r3 := LochKreis / Sqrt(2);
  Sek := FSektoren div 2;
  t := pi * 2 / FSektoren;

  for i := 0 to Sek div 4 - 1 do begin
    i2 := i * 2;
    // Innen
    Quads(
      vec3(r3 - cos((i2 + 2) * t) * Bohrung, h, r3 - sin((i2 + 2) * t) * Bohrung),
      vec3(r3 - cos((i2 + 0) * t) * Bohrung, h, r3 - sin((i2 + 0) * t) * Bohrung),
      vec3(sin((i + Sek div 8 + 0) * t) * DInnen, h, cos((i + Sek div 8 + 0) * t) * DInnen),
      vec3(sin((i + Sek div 8 + 1) * t) * DInnen, h, cos((i + Sek div 8 + 1) * t) * DInnen));
    // Aussen
    Quads(
      vec3(r3 + sin((i2 + 0) * t) * Bohrung, h, r3 + cos((i2 + 0) * t) * Bohrung),
      vec3(r3 + sin((i2 + 2) * t) * Bohrung, h, r3 + cos((i2 + 2) * t) * Bohrung),
      vec3(sin((i + Sek div 8 + 1) * t) * DAussen, h, cos((i + Sek div 8 + 1) * t) * DAussen),
      vec3(sin((i + Sek div 8 + 0) * t) * DAussen, h, cos((i + Sek div 8 + 0) * t) * DAussen));
    // Senkrecht
    Quads(
      rot(vec3(0, h, DInnen + i * l + l), -Pi / 8),
      rot(vec3(0, h, DInnen + i * l), -Pi / 8),
      vec3(r3 - cos((i2 + 0) * t) * Bohrung, h, r3 + sin((i2 + 0) * t) * Bohrung),
      vec3(r3 - cos((i2 + 2) * t) * Bohrung, h, r3 + sin((i2 + 2) * t) * Bohrung));
    // Wagrecht
    Quads(
      vec3(r3 + sin((i2 + 2) * t) * Bohrung, h, r3 - cos((i2 + 2) * t) * Bohrung),
      vec3(r3 + sin((i2 + 0) * t) * Bohrung, h, r3 - cos((i2 + 0) * t) * Bohrung),
      rot(vec3(DInnen + i * l, h, 0), Pi / 8),
      rot(vec3(DInnen + i * l + l, h, 0), Pi / 8));
  end;

  for i := 0 to FSektoren div 4 div 4 - 1 do begin
    Quads(
      vec3(sin((i + 1) * t) * DAussen, h, cos((i + 1) * t) * DAussen),
      vec3(sin((i + 0) * t) * DAussen, h, cos((i + 0) * t) * DAussen),
      vec3(sin((i + 0) * t) * DInnen, h, cos((i + 0) * t) * DInnen),
      vec3(sin((i + 1) * t) * DInnen, h, cos((i + 1) * t) * DInnen));

    i2 := i + (FSektoren div 16) * 3;

    Quads(
      vec3(sin((i2 + 1) * t) * DAussen, h, cos((i2 + 1) * t) * DAussen),
      vec3(sin((i2 + 0) * t) * DAussen, h, cos((i2 + 0) * t) * DAussen),
      vec3(sin((i2 + 0) * t) * DInnen, h, cos((i2 + 0) * t) * DInnen),
      vec3(sin((i2 + 1) * t) * DInnen, h, cos((i2 + 1) * t) * DInnen));
  end;

end;

procedure TFlansch.FlanschBohrung(lk, BohrungD, h1, h2: single);
var
  i: integer;
  i2: integer;
  t: single;
begin
  t := pi * 2 / FSektoren;
  lk := lk / 2 / Sqrt(2);
  BohrungD /= 2;
  for i := 0 to FSektoren div 2 - 1 do begin
    i2 := i * 2;
    Quads(
      vec3(sin((i2 + 2) * t) * BohrungD + lk, h1, cos((i2 + 2) * t) * BohrungD + lk),
      vec3(sin((i2 + 2) * t) * BohrungD + lk, h2, cos((i2 + 2) * t) * BohrungD + lk),
      vec3(sin((i2 + 0) * t) * BohrungD + lk, h2, cos((i2 + 0) * t) * BohrungD + lk),
      vec3(sin((i2 + 0) * t) * BohrungD + lk, h1, cos((i2 + 0) * t) * BohrungD + lk),

      vec3(-sin((i2 + 2) * t), 0, -cos((i2 + 2) * t)),
      vec3(-sin((i2 + 2) * t), 0, -cos((i2 + 2) * t)),
      vec3(-sin((i2 + 0) * t), 0, -cos((i2 + 0) * t)),
      vec3(-sin((i2 + 0) * t), 0, -cos((i2 + 0) * t)));
  end;
end;


procedure TFlansch.FlanschUmfang(aussen, h1, h2: single);
var
  i: integer;
  t: single;
begin
  t := pi * 2 / FSektoren;
  aussen /= 2;
  for i := 0 to FSektoren div 4 - 1 do begin
    Quads(
      vec3(sin((i + 1) * t) * aussen, h1, cos((i + 1) * t) * aussen),
      vec3(sin((i + 0) * t) * aussen, h1, cos((i + 0) * t) * aussen),
      vec3(sin((i + 0) * t) * aussen, h2, cos((i + 0) * t) * aussen),
      vec3(sin((i + 1) * t) * aussen, h2, cos((i + 1) * t) * aussen),

      vec3(sin((i + 1) * t), 0, cos((i + 1) * t)),
      vec3(sin((i + 0) * t), 0, cos((i + 0) * t)),
      vec3(sin((i + 0) * t), 0, cos((i + 0) * t)),
      vec3(sin((i + 1) * t), 0, cos((i + 1) * t)));
  end;
end;

procedure TFlansch.Schnitt_L_Form(l01, l1, l2, aussen_d, mitte_d, innen_d: single);
begin
  aussen_d /= 2;
  mitte_d /= 2;
  innen_d /= 2;
  Quads(vec3(0, l1, -aussen_d), vec3(0, l1, -mitte_d), vec3(0, l2, -mitte_d), vec3(0, l2, -aussen_d));
  Quads(vec3(0, l01, -mitte_d), vec3(0, l01, -innen_d), vec3(0, l2, -innen_d), vec3(0, l2, -mitte_d));

  Quads(vec3(0, l1, aussen_d), vec3(0, l2, aussen_d), vec3(0, l2, mitte_d), vec3(0, l1, mitte_d));
  Quads(vec3(0, l01, mitte_d), vec3(0, l2, mitte_d), vec3(0, l2, innen_d), vec3(0, l01, innen_d));
end;


// --- Rohr Flansch --- //

{ TRohrFlanschen }

constructor TRohrFlansch.Create;
begin
  inherited Create;
  Caption := 'RohrFlansch';
end;

procedure TRohrFlansch.WriteVertex;
var
  i: integer;
  di: single;
begin
  Sektoren := VLI_SEKTOREN;
  di := AnzeigerMasse.StandRohr.AussenD;
  with AnzeigerMasse.RohrFlanschMasse do begin
    LochFlansch(di, AussenD, LochKreis, Bohrung, Hoehe);
    FlanschUmfang(di, Hoehe, 0);
    FlanschUmfang(Dichtleiste.d, 0.0, Dichtleiste.h);

    FVertexData.Pos.Modif([CW]);
    FVertexData.Normal.Modif([CW, neg]);


    LochDisk(di, Dichtleiste.d, 0.0, 4);
    FlanschUmfang(AussenD, hoehe, Dichtleiste.h);
    LochFlansch(Dichtleiste.d, AussenD, LochKreis, Bohrung, 0.0 - 3.0);
    FlanschBohrung(LochKreis, Bohrung, Hoehe, Dichtleiste.h);
  end;

  i := FVertexData.Pos.Count;
  FVertexData.Pos.Copy(0, i, i);
  FVertexData.Pos.RotateB(-Pi / 2, 0, i - 1);
  FVertexData.Normal.Copy(0, i, i);
  FVertexData.Normal.RotateB(-Pi / 2, 0, i - 1);

  inherited WriteVertex;
end;

{ TRohrFlanschSchnitt }

constructor TRohrFlanschSchnitt.Create;
begin
  inherited Create;
  Caption := 'RohrFlanschSchnitt';
  Color := vec4(1.0, 0.0, 0.0, 1.0);
end;

procedure TRohrFlanschSchnitt.WriteVertex;
begin
  with AnzeigerMasse.RohrFlanschMasse do begin
    Schnitt_L_Form(0, DichtLeiste.h, Hoehe, AussenD, (Dichtleiste.d), AnzeigerMasse.StandRohr.AussenD);
  end;

  inherited WriteVertex;
end;

// --- Process Flansch --- //

{ TProcessFlansch }

constructor TProcessFlansch.Create;
begin
  inherited Create;
  Caption := 'ProcessFlansch';
end;

procedure TProcessFlansch.WriteVertex;
var
  i: integer;
  d: single;
begin
  Sektoren := VLI_SEKTOREN;
  d := AnzeigerMasse.Stutzen.AussenD;
  with AnzeigerMasse.ProcessFlanschMasse do begin
    FlanschUmfang(d, Hoehe, 0.0);
    LochFlansch(d, AussenD, LochKreis, Bohrung, Hoehe);

    FVertexData.Pos.Modif([CW]);
    FVertexData.Normal.Modif([CW, neg]);


    LochDisk(d, Dichtleiste.d, 0.0, 4);
    FlanschUmfang(Dichtleiste.d, Dichtleiste.h, 0.0);
    LochFlansch(Dichtleiste.d, AussenD, LochKreis, Bohrung, Dichtleiste.h);
    FlanschUmfang(AussenD, Hoehe, Dichtleiste.h);
    FlanschBohrung(LochKreis, Bohrung, Hoehe, Dichtleiste.h);
  end;

  i := FVertexData.Pos.Count;
  FVertexData.Pos.Copy(0, i, i);
  FVertexData.Pos.RotateB(-Pi / 2, 0, i - 1);
  FVertexData.Normal.Copy(0, i, i);
  FVertexData.Normal.RotateB(-Pi / 2, 0, i - 1);

  inherited WriteVertex;
end;

{ TProcessFlanschSchnitt }

constructor TProcessFlanschSchnitt.Create;
begin
  inherited Create;
  Caption := 'ProcessFlanschSchnitt';
  Color := vec4(1.0, 0.0, 0.0, 1.0);
end;

procedure TProcessFlanschSchnitt.WriteVertex;
begin
  with AnzeigerMasse.ProcessFlanschMasse do begin
    Schnitt_L_Form(0, DichtLeiste.h, Hoehe, AussenD, (Dichtleiste.d), AnzeigerMasse.Stutzen.AussenD);
  end;
  inherited WriteVertex;
end;


end.
