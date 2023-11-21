unit VLIWasser;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, VLIBasis, oglVector, oglMatrix;

type

  { TWasserSchwimmer }

  TWasserSchwimmer = class(TUrAnzeiger)
    constructor Create;
    procedure WriteVertex;
  end;


  { TWasserSchwimmerSchnitt }

  TWasserSchwimmerSchnitt = class(TUrAnzeiger)
    constructor Create;
    procedure WriteVertex;
  end;


  { TWasserUnten }

  TWasserUnten = class(TUrAnzeiger)
    constructor Create;
    procedure WriteVertex;
  end;


implementation

{ TWasserUnten }

constructor TWasserUnten.Create;
begin
  inherited Create;
  Color := vec4(0.0, 0.0, 1.0, 0.5);
  Caption := 'WasserUnten';
end;

procedure TWasserUnten.WriteVertex;
begin
  Quads(vec3(0, 0, 0), vec3(0, 0, 1), vec3(0, 1, 1), vec3(0, 1, 0));

  inherited WriteVertex;
end;

{ TWasserSchwimmer }

constructor TWasserSchwimmer.Create;
begin
  inherited Create;
  Caption := 'Wasser';
  Color := vec4(0.0, 0.0, 1.0, 0.5);
  Caption := 'WasserSchwimmer';
end;

procedure TWasserSchwimmer.WriteVertex;
var
  i: integer;
  t: single;
begin
  Sektoren := VLI_SEKTOREN;
  t := pi * 2 / Sektoren;
  with AnzeigerMasse do begin
    for i := 0 to FSektoren div 2 - 1 do begin
      Quads(
        vec3(sin((i + 0) * t) * StandRohr.InnenD / 2, 0, cos((i + 0) * t) * StandRohr.InnenD / 2),
        vec3(sin((i + 1) * t) * StandRohr.InnenD / 2, 0, cos((i + 1) * t) * StandRohr.InnenD / 2),
        vec3(sin((i + 1) * t) * Schwimmer.AussenD / 2, 0, cos((i + 1) * t) * Schwimmer.AussenD / 2),
        vec3(sin((i + 0) * t) * Schwimmer.AussenD / 2, 0, cos((i + 0) * t) * Schwimmer.AussenD / 2));
    end;
  end;

  inherited WriteVertex;
end;

{ TWasserSchwimmerSchnitt }

constructor TWasserSchwimmerSchnitt.Create;
begin
  inherited Create;
  Color := vec4(0.0, 0.0, 1.0, 0.5);
  Caption := 'WasserSchwimmerSchnitt';
end;

procedure TWasserSchwimmerSchnitt.WriteVertex;
var
  i, k, p: integer;
  t, h: single;
begin
  Sektoren := VLI_SEKTOREN;
  t := pi * 2 / Sektoren;
  with AnzeigerMasse.Schwimmer do begin
    if anzKugeln > 0 then begin
      for k := 0 to anzKugeln - 1 do begin
        h := k * (-AussenD);
        for i := 0 to FSektoren div 2 - 1 do begin  // unten
          Quads(
            vec3(0, -sin((i + 0) * t) * AussenD / 2 + h, cos((i + 0) * t) * AussenD / 2),
            vec3(0, -sin((i + 1) * t) * AussenD / 2 + h, cos((i + 1) * t) * AussenD / 2),
            vec3(0, -AussenD / 2 + h, cos((i + 1) * t) * AussenD / 2),
            vec3(0, -AussenD / 2 + h, cos((i + 0) * t) * AussenD / 2));
          if k <> 0 then begin
            p := i + FSektoren div 2;
            Quads(
              vec3(0, -sin((p + 0) * t) * AussenD / 2 + h, cos((p + 0) * t) * AussenD / 2),
              vec3(0, -sin((p + 1) * t) * AussenD / 2 + h, cos((p + 1) * t) * AussenD / 2),
              vec3(0, -AussenD / 2 + h + AussenD, cos((p + 1) * t) * AussenD / 2),
              vec3(0, -AussenD / 2 + h + AussenD, cos((p + 0) * t) * AussenD / 2));
          end;
        end;
      end;
      with AnzeigerMasse do begin
        h := -AussenD / 2 - AussenD * (anzKugeln - 1);
        Quads(
          vec3(0, 0, -AussenD / 2),
          vec3(0, 0, -StandRohr.InnenD / 2),
          vec3(0, h, -StandRohr.InnenD / 2),
          vec3(0, h, -AussenD / 2));

        Quads(
          vec3(0, 0, StandRohr.InnenD / 2),
          vec3(0, 0, AussenD / 2),
          vec3(0, h, AussenD / 2),
          vec3(0, h, StandRohr.InnenD / 2));
      end;
    end else begin
    end;
  end;

  inherited WriteVertex;
end;

end.
