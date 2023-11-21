unit VLIDichtung;

{$mode objfpc}{$H+}

interface

uses
  Classes,
  Dialogs,
  SysUtils,
  VLIBasis,
  oglVector, oglMatrix, oglVBO;

type

  { TVLIDichtung }

  TVLIDichtung = class(TUrAnzeiger)
  public
    constructor Create;
    procedure WriteVertex(di, da, h: single);
  end;

  { TVLIDichtungSchnitt }

  TVLIDichtungSchnitt = class(TUrAnzeiger)
  public
    constructor Create;
    procedure WriteVertex(di, da, h: single);
  end;

  { TVLIDichtungRohrFlansch }

  TVLIDichtungRohrFlansch = class(TVLIDichtung)
    constructor Create;
    procedure WriteVertex;
  end;

  { TVLIDichtungRohrFlanschSchnitt }

  TVLIDichtungRohrFlanschSchnitt = class(TVLIDichtungSchnitt)
    constructor Create;
    procedure WriteVertex;
  end;

  { TVLIDichtungProcessFlansch }

  TVLIDichtungProcessFlansch = class(TVLIDichtung)
    constructor Create;
    procedure WriteVertex;
  end;


  { TVLIDichtungProcessFlanschSchnitt }

  TVLIDichtungProcessFlanschSchnitt = class(TVLIDichtungSchnitt)
    constructor Create;
    procedure WriteVertex;
  end;


implementation

{ TVLIDichtung }

constructor TVLIDichtung.Create;
begin
  inherited Create;
  Color := vec4(0.0, 1.0, 0.0, 1.0);
  //  Kreis.Aktiv := True;
end;

procedure TVLIDichtung.WriteVertex(di, da, h: single);
var
  i: integer;
  t: single;
begin
  Sektoren := VLI_SEKTOREN;
  t := 2 * pi / Sektoren;
  for i := 0 to FSektoren div 2 - 1 do begin
    Quads(
      vec3(sin((i + 0) * t) * da / 2, 0, cos((i + 0) * t) * da / 2),
      vec3(sin((i + 0) * t) * di / 2, 0, cos((i + 0) * t) * di / 2),
      vec3(sin((i + 1) * t) * di / 2, 0, cos((i + 1) * t) * di / 2),
      vec3(sin((i + 1) * t) * da / 2, 0, cos((i + 1) * t) * da / 2));

    Quads(
      vec3(sin((i + 0) * t) * da / 2, h, cos((i + 0) * t) * da / 2),
      vec3(sin((i + 1) * t) * da / 2, h, cos((i + 1) * t) * da / 2),
      vec3(sin((i + 1) * t) * di / 2, h, cos((i + 1) * t) * di / 2),
      vec3(sin((i + 0) * t) * di / 2, h, cos((i + 0) * t) * di / 2));

    // Innen
    Quads(
      vec3(sin((i + 0) * t) * di / 2, h, cos((i + 0) * t) * di / 2),
      vec3(sin((i + 1) * t) * di / 2, h, cos((i + 1) * t) * di / 2),
      vec3(sin((i + 1) * t) * di / 2, 0, cos((i + 1) * t) * di / 2),
      vec3(sin((i + 0) * t) * di / 2, 0, cos((i + 0) * t) * di / 2),

      vec3(-sin((i + 0) * t) / 2, 0, -cos((i + 0) * t) / 2),
      vec3(-sin((i + 1) * t) / 2, 0, -cos((i + 1) * t) / 2),
      vec3(-sin((i + 1) * t) / 2, 0, -cos((i + 1) * t) / 2),
      vec3(-sin((i + 0) * t) / 2, 0, -cos((i + 0) * t) / 2));

    // Aussen
    Quads(
      vec3(sin((i + 0) * t) * da / 2, 0, cos((i + 0) * t) * da / 2),
      vec3(sin((i + 1) * t) * da / 2, 0, cos((i + 1) * t) * da / 2),
      vec3(sin((i + 1) * t) * da / 2, h, cos((i + 1) * t) * da / 2),
      vec3(sin((i + 0) * t) * da / 2, h, cos((i + 0) * t) * da / 2),

      vec3(sin((i + 0) * t) / 2, 0, cos((i + 0) * t) / 2),
      vec3(sin((i + 1) * t) / 2, 0, cos((i + 1) * t) / 2),
      vec3(sin((i + 1) * t) / 2, 0, cos((i + 1) * t) / 2),
      vec3(sin((i + 0) * t) / 2, 0, cos((i + 0) * t) / 2));
  end;

  inherited WriteVertex;
end;

{ TVLIDichtungSchnitt }

constructor TVLIDichtungSchnitt.Create;
begin
  inherited Create;
  Color := vec4(1.0, 0.5, 0.0, 1.0);
end;

procedure TVLIDichtungSchnitt.WriteVertex(di, da, h: single);
begin
  Quads(
    vec3(0, 0, -di / 2),
    vec3(0, h, -di / 2),
    vec3(0, h, -da / 2),
    vec3(0, 0, -da / 2));

  Quads(
    vec3(0, 0, da / 2),
    vec3(0, h, da / 2),
    vec3(0, h, di / 2),
    vec3(0, 0, di / 2));

  inherited WriteVertex;
end;

{ TVLIDichtungRohrFlansch }

constructor TVLIDichtungRohrFlansch.Create;
begin
  inherited Create;
  Caption := 'DichtungRohrFlansch';
end;

procedure TVLIDichtungRohrFlansch.WriteVertex;
begin
  with AnzeigerMasse do begin
    inherited WriteVertex(StandRohr.AussenD, RohrFlanschMasse.Dichtleiste.d, 2);
  end;
end;

{ TVLIDichtungRohrFlanschSchnitt }

constructor TVLIDichtungRohrFlanschSchnitt.Create;
begin
  inherited Create;
  Caption := 'DichtungRohrFlanschSchnitt';
end;

procedure TVLIDichtungRohrFlanschSchnitt.WriteVertex;
begin
  with AnzeigerMasse do begin
    inherited WriteVertex(StandRohr.AussenD, RohrFlanschMasse.Dichtleiste.d, 2);
  end;
end;

{ TVLIDichtungProcessFlansch }

constructor TVLIDichtungProcessFlansch.Create;
begin
  inherited Create;
  Caption := 'DichtungProcessFlansch';
end;

procedure TVLIDichtungProcessFlansch.WriteVertex;
begin
  with AnzeigerMasse do begin
    inherited WriteVertex(Stutzen.AussenD, ProcessFlanschMasse.Dichtleiste.d, 2);
  end;
end;

{ TVLIDichtungProcessFlanschSchnitt }

constructor TVLIDichtungProcessFlanschSchnitt.Create;
begin
  inherited Create;
  Caption := 'DichtungProcessFlanschSchnitt';
end;

procedure TVLIDichtungProcessFlanschSchnitt.WriteVertex;
begin
  with AnzeigerMasse do begin
    inherited WriteVertex(Stutzen.AussenD, ProcessFlanschMasse.Dichtleiste.d, 2);
  end;
end;

end.
