unit VLIStutzen;

{$mode objfpc}{$H+}

interface

uses
  VLIBasis, oglVector, oglMatrix, oglVBO;

type

  { TStutzen }

  TStutzen = class(TUrAnzeiger)
  public
    constructor Create;
    procedure WriteVertex;
  end;

  { TStutzenSchnitt }

  TStutzenSchnitt = class(TUrAnzeiger)
  public
    constructor Create;
    procedure WriteVertex;
  end;


implementation

{ TStutzen }

constructor TStutzen.Create;
begin
  inherited Create;
  Caption := 'Stutzen';
end;

procedure TStutzen.WriteVertex;
var
  t: single;

  procedure TeilStutzen(Rohr, Stutzen, StutzenLaenge: single);
  var
    i: integer;
    hs1, hs2: single;

  begin
    Rohr /= 2;
    Stutzen /= 2;
    for i := 0 to Sektoren div 2 - 1 do begin
      hs1 := Sqrt(Sqr(Rohr) - Sqr(sin((i + 0) * t) * Stutzen));
      hs2 := Sqrt(Sqr(Rohr) - Sqr(sin((i + 1) * t) * Stutzen));

      Quads(
        vec3(sin((i + 0) * t) * Stutzen, cos((i + 0) * t) * Stutzen, -hs1),
        vec3(sin((i + 1) * t) * Stutzen, cos((i + 1) * t) * Stutzen, -hs2),
        vec3(sin((i + 1) * t) * Stutzen, cos((i + 1) * t) * Stutzen, -StutzenLaenge),
        vec3(sin((i + 0) * t) * Stutzen, cos((i + 0) * t) * Stutzen, -StutzenLaenge),

        vec3(sin((i + 0) * t), cos((i + 0) * t), 0),
        vec3(sin((i + 1) * t), cos((i + 1) * t), 0),
        vec3(sin((i + 1) * t), cos((i + 1) * t), 0),
        vec3(sin((i + 0) * t), cos((i + 0) * t), 0));
    end;
  end;

  procedure Stirn(DInnen, DAussen, h: single);
  var
    i: integer;
    RA, RI: single;
  begin
    RA := DAussen / 2;
    RI := DInnen / 2;
    for i := 0 to Sektoren div 2 - 1 do begin
      Quads(
        vec3(sin((i + 1) * t) * RA, cos((i + 1) * t) * RA, h),
        vec3(sin((i + 1) * t) * RI, cos((i + 1) * t) * RI, h),
        vec3(sin((i + 0) * t) * RI, cos((i + 0) * t) * RI, h),
        vec3(sin((i + 0) * t) * RA, cos((i + 0) * t) * RA, h));
    end;
  end;

begin
  Sektoren := VLI_SEKTOREN;
  t := pi * 2 / Sektoren;

  with Anzeigermasse do begin
    TeilStutzen(StandRohr.InnenD, Stutzen.InnenD, Stutzen.t);

    FVertexData.Pos.Modif([CW]);
    FVertexData.Normal.Modif([CW, neg]);

    TeilStutzen(StandRohr.AussenD, Stutzen.AussenD, Stutzen.t);

    Stirn(Stutzen.InnenD, Stutzen.AussenD, -Stutzen.t);
  end;
  inherited WriteVertex;
end;

{ TStutzenSchnitt }

constructor TStutzenSchnitt.Create;
begin
  inherited Create;
  Caption := 'StutzenSchnitt';
  Color := vec4(1.0, 0.0, 0.0, 1.0);
end;


procedure TStutzenSchnitt.WriteVertex;
begin
  with Anzeigermasse do begin
    Quads(
      vec3(0, Stutzen.AussenD / 2, -Stutzen.t),
      vec3(0, Stutzen.InnenD / 2, -Stutzen.t),
      vec3(0, Stutzen.InnenD / 2, -StandRohr.AussenD / 2),
      vec3(0, Stutzen.AussenD / 2, -StandRohr.AussenD / 2));
    Quads(
      vec3(0, -Stutzen.InnenD / 2, -Stutzen.t),
      vec3(0, -Stutzen.AussenD / 2, -Stutzen.t),
      vec3(0, -Stutzen.AussenD / 2, -StandRohr.AussenD / 2),
      vec3(0, -Stutzen.InnenD / 2, -StandRohr.AussenD / 2));
  end;
  inherited WriteVertex;
end;

end.



