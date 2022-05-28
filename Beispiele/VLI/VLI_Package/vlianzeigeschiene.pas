unit VLIAnzeigeschiene;

{$mode objfpc}{$H+}

interface

uses
  VLIBasis, oglVector, oglMatrix;

type

  { TInnenProfil }

  TInnenProfil = class(TUrAnzeiger)
  public
    constructor Create;
    procedure WriteVertex;
  end;

  { TInnenProfilSchnitt }

  TInnenProfilSchnitt = class(TUrAnzeiger)
  public
    constructor Create;
    procedure WriteVertex;
  end;


implementation

{ TInnenProfil }

constructor TInnenProfil.Create;
begin
  inherited Create;
  Color := vec4(0.8, 0.8, 0.8, 1.0);
  Caption := 'InnenProfil';
end;

procedure TInnenProfil.WriteVertex;
var
  inn, aus, wand, o, u: single;
  anz: integer;
  i: integer;

const
  achse = 2.0;
  posz = 0.0;
  tiefe = 10.0;
begin
  with  AnzeigerMasse do begin
    inn := Anzeigeschiene.Breite.Innen / 2;
    aus := Anzeigeschiene.Breite.Aussen / 2;
    wand := aus - inn;

    anz := Round((StandRohr.L + Anzeigeschiene.Auslauf * 2) / 10);

    u := 0 - Anzeigeschiene.Auslauf;
    o := u + anz * 10 + 10;
    //    posz := StandRohr.AussenD / 2;
  end;

  // == Aussen

  // Unten

  Quads(
    vec3(aus, u, posz + tiefe + achse / 2),
    vec3(aus, u, posz + tiefe - achse / 2),
    vec3(aus, u + 5 - achse / 2, posz + tiefe - achse / 2),
    vec3(aus, u + 5 - achse / 2, posz + tiefe + achse / 2));

  // Mitte

  for i := 1 to anz do begin
    Quads(
      vec3(aus, u + i * 10 - (5 - achse / 2), posz + tiefe + achse / 2),
      vec3(aus, u + i * 10 - (5 - achse / 2), posz + tiefe - achse / 2),
      vec3(aus, u + i * 10 + (5 - achse / 2), posz + tiefe - achse / 2),
      vec3(aus, u + i * 10 + (5 - achse / 2), posz + tiefe + achse / 2));
  end;

  // Oben

  Quads(
    vec3(aus, o - 5 + achse / 2, posz + tiefe + achse / 2),
    vec3(aus, o - 5 + achse / 2, posz + tiefe - achse / 2),
    vec3(aus, o, posz + 10 - achse / 2),
    vec3(aus, o, posz + 10 + achse / 2));

  // Fläche

  Quads(
    vec3(aus, u, posz + tiefe - achse / 2),
    vec3(aus, u, posz),
    vec3(aus, o, posz),
    vec3(aus, o, posz + tiefe - achse / 2));


  // == Flächen zwischen Schlitz

  // Unten

  Quads(
    vec3(aus, u, posz + tiefe + achse / 2),
    vec3(aus, u + 5 - achse / 2, posz + tiefe + achse / 2),
    vec3(inn, u + 5 - achse / 2, posz + tiefe + achse / 2),
    vec3(inn, u, posz + tiefe + achse / 2));

  // Mitte

  for i := 1 to anz do begin
    Quads(
      vec3(aus, u + i * 10 - (5 - achse / 2), posz + tiefe + achse / 2),
      vec3(aus, u + i * 10 + (5 - achse / 2), posz + tiefe + achse / 2),
      vec3(inn, u + i * 10 + (5 - achse / 2), posz + tiefe + achse / 2),
      vec3(inn, u + i * 10 - (5 - achse / 2), posz + tiefe + achse / 2));
  end;

  // oben

  Quads(
    vec3(aus, o - 5 + achse / 2, posz + tiefe + achse / 2),
    vec3(aus, o, posz + tiefe + achse / 2),
    vec3(inn, o, posz + tiefe + achse / 2),
    vec3(inn, o - 5 + achse / 2, posz + tiefe + achse / 2));


  // == Innen

  // Unten

  Quads(
    vec3(inn, u, posz + 10 + achse / 2),
    vec3(inn, u + 5 - achse / 2, posz + tiefe + achse / 2),
    vec3(inn, u + 5 - achse / 2, posz + tiefe - achse / 2),
    vec3(inn, u, posz + 10 - achse / 2));

  // Mitte

  for i := 1 to anz do begin
    Quads(
      vec3(inn, u + i * 10 - (5 - achse / 2), posz + tiefe + achse / 2),
      vec3(inn, u + i * 10 + (5 - achse / 2), posz + tiefe + achse / 2),
      vec3(inn, u + i * 10 + (5 - achse / 2), posz + tiefe - achse / 2),
      vec3(inn, u + i * 10 - (5 - achse / 2), posz + tiefe - achse / 2));
  end;

  // Oben

  Quads(
    vec3(inn, o - 5 + achse / 2, posz + tiefe + achse / 2),
    vec3(inn, o, posz + tiefe + achse / 2),
    vec3(inn, o, posz + tiefe - achse / 2),
    vec3(inn, o - 5 + achse / 2, posz + tiefe - achse / 2));

  // Fläche

  Quads(
    vec3(inn, u, posz + tiefe - achse / 2),
    vec3(inn, o, posz + tiefe - achse / 2),
    vec3(inn, o, posz + wand),
    vec3(inn, u, posz + wand));

  // == Schlitz

  for i := 0 to anz do begin
    //unten
    Quads(
      vec3(aus, u + i * 10 + (5 - achse / 2), posz + tiefe - achse / 2),
      vec3(inn, u + i * 10 + (5 - achse / 2), posz + tiefe - achse / 2),
      vec3(inn, u + i * 10 + (5 - achse / 2), posz + tiefe + achse / 2),
      vec3(aus, u + i * 10 + (5 - achse / 2), posz + tiefe + achse / 2));
    // mitte
    Quads(
      vec3(aus, u + i * 10 + (5 - achse / 2), posz + tiefe - achse / 2),
      vec3(aus, u + i * 10 + (5 + achse / 2), posz + tiefe - achse / 2),
      vec3(inn, u + i * 10 + (5 + achse / 2), posz + tiefe - achse / 2),
      vec3(inn, u + i * 10 + (5 - achse / 2), posz + tiefe - achse / 2));
    //oben
    Quads(
      vec3(aus, u + i * 10 + (5 + achse / 2), posz + tiefe - achse / 2),
      vec3(aus, u + i * 10 + (5 + achse / 2), posz + tiefe + achse / 2),
      vec3(inn, u + i * 10 + (5 + achse / 2), posz + tiefe + achse / 2),
      vec3(inn, u + i * 10 + (5 + achse / 2), posz + tiefe - achse / 2));
  end;

  // == Boden

  // innen

  Quads(
    vec3(0, u, posz + wand),
    vec3(inn, u, posz + wand),
    vec3(inn, o, posz + wand),
    vec3(0, o, posz + wand));

  // aussen

  Quads(
    vec3(0, u, posz),
    vec3(0, o, posz),
    vec3(aus, o, posz),
    vec3(aus, u, posz));

  // == Unten

  Quads(
    vec3(inn, u, posz + tiefe + achse / 2),
    vec3(inn, u, posz),
    vec3(aus, u, posz),
    vec3(aus, u, posz + tiefe + achse / 2));
  Quads(
    vec3(0, u, posz),
    vec3(inn, u, posz),
    vec3(inn, u, posz + wand),
    vec3(0, u, posz + wand));


  // == Oben

  Quads(
    vec3(inn, o, posz + tiefe + achse / 2),
    vec3(aus, o, posz + tiefe + achse / 2),
    vec3(aus, o, posz),
    vec3(inn, o, posz));
  Quads(
    vec3(0, o, posz),
    vec3(0, o, posz + wand),
    vec3(inn, o, posz + wand),
    vec3(inn, o, posz));

  inherited WriteVertex;
end;

{ TInnenProfilSchnitt }

constructor TInnenProfilSchnitt.Create;
begin
  inherited Create;
  Color := vec4(1.0, 0.0, 0.0, 1.0);
  Caption := 'InnenProfilSchnitt';
end;


procedure TInnenProfilSchnitt.WriteVertex;
var
  l, a: single;
const
  wand = 2.0;
  posz = 0.0;

begin
  with TUrAnzeiger.AnzeigerMasse do begin
    l := Round((StandRohr.L + Anzeigeschiene.Auslauf * 2) / 10) * 10 + 20.0;
    a := Round((Anzeigeschiene.Auslauf) / 10) * 10 + 10.0;
  end;

  Quads(
    vec3(0, -a + l, posz),
    vec3(0, -a, posz),
    vec3(0, -a, posz + wand),
    vec3(0, -a + l, posz + wand));

  inherited WriteVertex;
end;

end.
