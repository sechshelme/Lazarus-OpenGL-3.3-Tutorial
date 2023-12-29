unit VLIBasis;

{$mode objfpc}{$H+}

interface

uses
  oglVAO, oglTextur, oglTexturVAO, oglVector, oglMatrix;

const
  VLI_SEKTOREN = 16 * 4;

type
  TAnzeigerMasse = record
    StandRohr: record
      C1: single;
      L: single;
      C2: single;
      AussenD: single;
      InnenD: single
    end;
    ArmaFlex: record
      C1: single;
      L: single;
      C2: single;
      AussenD: single;
      InnenD: single
    end;
    RohrFlanschMasse: record
      AussenD,
      //      InnenD,
      LochKreis,
      Bohrung,
      Hoehe: single;
      Dichtleiste: record
        d, h: single;
      end;
    end;
    Stutzen: record
      t: single;
      AussenD: single;
      InnenD: single
    end;
    ProcessFlanschMasse: record
      AussenD,
      //      InnenD,
      LochKreis,
      Bohrung,
      Hoehe: single;
      Dichtleiste: record
        d, h: single;
      end;
    end;
    Schwimmer: record
      anzKugeln: Int32;
      Laenge,
      AussenD,
      InnenD: single;
    end;
    Anzeigeschiene: record
      Breite: record
        Innen, Aussen: single;
      end;
      Auslauf: single;
    end;
  end;

type

  { TUrAnzeiger }

  TUrAnzeiger = class(TMultiTexturVAO)
  public
    class var AnzeigerMasse: TAnzeigerMasse;
    constructor Create(light: boolean = True);
  const
    WasserColor: TVector4f = (0.0, 0.0, 1.0, 0.5);
    SchnittColor: TVector4f = (1.0, 0.0, 0.0, 1.0);
    InoxColor: TVector4f = (1.0, 1.0, 1.0, 1.0);
    SchwimmerColor: TVector4f = (0.8, 0.7, 0.7, 1.0);
    AluSchieneColor: TVector4f = (0.9, 0.9, 0.9, 1.0);
  protected
    procedure LochDisk(DInnen, DAussen, h: single; Teilung: integer);
    procedure HalbKugel(dm, h, Stauchung: single; oben: boolean);
  end;

implementation


{ TUrAnzeiger }


constructor TUrAnzeiger.Create(light: boolean);
begin
  inherited Create(0, light);
  Darstellung := geschnitten;

  LightingShader.SetMaterial('Chrome');
end;

procedure TUrAnzeiger.LochDisk(DInnen, DAussen, h: single; Teilung: integer);
var
  i: integer;
  t, RA, RI: single;
begin
  t := 2 * Pi / Sektoren;
  ;
  RA := DAussen / 2;
  RI := DInnen / 2;
  for i := 0 to FSektoren div Teilung - 1 do begin
    Quads(
      vec3(sin((i + 1) * t) * RA, h, cos((i + 1) * t) * RA),
      vec3(sin((i + 0) * t) * RA, h, cos((i + 0) * t) * RA),
      vec3(sin((i + 0) * t) * RI, h, cos((i + 0) * t) * RI),
      vec3(sin((i + 1) * t) * RI, h, cos((i + 1) * t) * RI));
  end;
end;

procedure TUrAnzeiger.HalbKugel(dm, h, Stauchung: single; oben: boolean);
var
  o, i, j: integer;
  t, rk: single;

  Tab: array of array of record
    a, b, c: single;
  end;

begin
  t := 2 * pi / Sektoren;

  SetLength(Tab, FSektoren + 1, FSektoren + 1);
  for j := 0 to FSektoren do begin
    rk := sin(t * j);
    for i := 0 to FSektoren do begin
      with Tab[i, j] do begin
        a := sin(t * i) * rk;
        b := cos(t * i) * rk;
        c := cos(t * j);
      end;
    end;
  end;

  if oben then begin
    o := 0;
  end else begin
    o := FSektoren div 4;
  end;

  for i := 0 to FSektoren div 2 - 1 do begin
    for j := 0 to FSektoren div 4 - 1 do begin
      Quads(
        vec3(Tab[i + 0, j + o + 1].a * dm, Tab[i + 0, j + o + 1].c * dm * Stauchung + h, Tab[i + 0, j + o + 1].b * dm),
        vec3(Tab[i + 1, j + o + 1].a * dm, Tab[i + 1, j + o + 1].c * dm * Stauchung + h, Tab[i + 1, j + o + 1].b * dm),
        vec3(Tab[i + 1, j + o + 0].a * dm, Tab[i + 1, j + o + 0].c * dm * Stauchung + h, Tab[i + 1, j + o + 0].b * dm),
        vec3(Tab[i + 0, j + o + 0].a * dm, Tab[i + 0, j + o + 0].c * dm * Stauchung + h, Tab[i + 0, j + o + 0].b * dm),

        vec3(Tab[i + 0, j + o + 1].a, Tab[i + 0, j + o + 1].c / Stauchung, Tab[i + 0, j + o + 1].b),
        vec3(Tab[i + 1, j + o + 1].a, Tab[i + 1, j + o + 1].c / Stauchung, Tab[i + 1, j + o + 1].b),
        vec3(Tab[i + 1, j + o + 0].a, Tab[i + 1, j + o + 0].c / Stauchung, Tab[i + 1, j + o + 0].b),
        vec3(Tab[i + 0, j + o + 0].a, Tab[i + 0, j + o + 0].c / Stauchung, Tab[i + 0, j + o + 0].b));
    end;
  end;

  SetLength(Tab, 0, 0);
end;

const
  ConstAnzeigerMasse: TAnzeigerMasse = (
    StandRohr: (C1: 190; L: 300; C2: 130; AussenD: 60; InnenD: 54);
    ArmaFlex: (C1: 170; L: 300; C2: 110; AussenD: 100; InnenD: 60);
    RohrFlanschMasse: (AussenD: 105; LochKreis: 85; Bohrung: 14; Hoehe: 15; Dichtleiste: (d: 70; h: -3));
    Stutzen: (t: 110; AussenD: 30; InnenD: 26);
    ProcessFlanschMasse: (AussenD: 105; LochKreis: 75; Bohrung: 20; Hoehe: 15; Dichtleiste: (d: 50; h: 3));
    Schwimmer: (anzKugeln: 3; Laenge: 110; AussenD: 46; InnenD: 40);
    Anzeigeschiene: (Breite: (Innen: 30; Aussen: 32); Auslauf: 50));


begin
  TUrAnzeiger.AnzeigerMasse := ConstAnzeigerMasse;
end.
