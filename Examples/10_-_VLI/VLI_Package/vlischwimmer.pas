unit VLISchwimmer;

{$mode objfpc}{$H+}

interface

uses
  VLIBasis,
  oglVector, oglMatrix, oglVBO;

type

  { TSchwimmer }

  TSchwimmer = class(TUrAnzeiger)
    constructor Create;
    procedure WriteVertex;
  end;

  { TSchwimmerSchnitt }

  TSchwimmerSchnitt = class(TUrAnzeiger)
    constructor Create;
    procedure WriteVertex;
  end;

implementation

{ TSchwimmer }

constructor TSchwimmer.Create;
begin
  inherited Create;
  Caption := 'Schwimmer';
end;

procedure TSchwimmer.WriteVertex;
var
  c1, c2, k: integer;
  h: single;

begin
  Sektoren := VLI_SEKTOREN;
  with AnzeigerMasse.Schwimmer do begin
    if anzKugeln > 0 then begin          // KugelSchwimmer
      for k := 0 to anzKugeln - 1 do begin
        h := k * (-AussenD);

        c1 := FVertexData.Pos.Count;
        HalbKugel(InnenD / 2, h, 1, True);
        HalbKugel(InnenD / 2, h, 1, False);
        c2 := FVertexData.Pos.Count;

        FVertexData.Pos.Modif(c1, c2 - 1, [CW]);
        FVertexData.Normal.Modif(c1, c2 - 1, [CW, neg]);

        HalbKugel(AussenD / 2, h, 1, True);
        HalbKugel(AussenD / 2, h, 1, False);
      end;
    end else begin // normaler Schwimmer
    end;

  end;
  inherited WriteVertex;
end;

{ TSchwimmerSchnitt }

constructor TSchwimmerSchnitt.Create;
begin
  inherited Create;
  Caption := 'SchwimmerSchnitt';
  Color := vec4(1.0, 0.0, 0.0, 1.0);
end;

procedure TSchwimmerSchnitt.WriteVertex;
var
  i, k: integer;
  t, h: single;
begin
  Sektoren := VLI_SEKTOREN;
  t := 2 * pi / Sektoren;
  with AnzeigerMasse.Schwimmer do begin
    if anzKugeln > 0 then begin          // KugelSchwimmer
      for k := 0 to anzKugeln - 1 do begin
        h := k * (-AussenD);
        for i := 0 to FSektoren - 1 do begin
          Quads(
            vec3(0, sin((i + 0) * t) * AussenD / 2 + h, cos((i + 0) * t) * AussenD / 2),
            vec3(0, sin((i + 1) * t) * AussenD / 2 + h, cos((i + 1) * t) * AussenD / 2),
            vec3(0, sin((i + 1) * t) * InnenD / 2 + h, cos((i + 1) * t) * InnenD / 2),
            vec3(0, sin((i + 0) * t) * InnenD / 2 + h, cos((i + 0) * t) * InnenD / 2));
        end;
      end;
    end else begin // normaler Schwimmer
    end;
  end;

  inherited WriteVertex;
end;

end.
