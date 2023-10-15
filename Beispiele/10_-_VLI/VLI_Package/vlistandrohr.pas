unit VLIStandRohr;

{$mode objfpc}{$H+}

interface

uses
  oglVector, oglMatrix, oglVBO,
  VLIBasis;

type

  { TStandRohr }

  TStandRohr = class(TUrAnzeiger)
  public
    constructor Create;
    procedure WriteVertex;
  end;

  { TStandRohrSchnitt }

  TStandRohrSchnitt = class(TUrAnzeiger)
  public
    constructor Create;
    procedure WriteVertex;
  end;


implementation

{ TStandRohr }

constructor TStandRohr.Create;
begin
  inherited Create;
  Caption := 'StandRohr';
end;

procedure TStandRohr.WriteVertex;

  procedure TeilLochRohr(h1, h2, RohrD, StutzenD: single);
  var
    VectorAlt1, VectorAlt2: TVector3f;

    procedure ZweiEck(const Vector1, Vector2: TVector3f);

      function Y0(const V: TVector3f): TVector3f; inline;
      begin
        Result := V;
        Result[1] := 0.0;
      end;

    begin
      Quads(VectorAlt1, Vector1, Vector2, VectorAlt2, Y0(VectorAlt1), Y0(Vector1), Y0(Vector2), Y0(VectorAlt2));
      VectorAlt1 := Vector1;
      VectorAlt2 := Vector2;
    end;

  var
    i: integer;
    t, Hypotenuse, y2, h: single;

  begin
    t := 2 * pi / Sektoren;
    RohrD /= 2;
    StutzenD /= 2;
    Hypotenuse := Sqrt(Sqr(RohrD));
    VectorAlt1 := vec3(0.0, h1, Hypotenuse);
    VectorAlt2 := vec3(0.0, h2, Hypotenuse);

    for i := Sektoren div 4 * 3 to Sektoren - 1 do begin
      ZweiEck(
        vec3(cos(i * t) * RohrD, h1, 0 - sin(i * t) * RohrD),
        vec3(cos(i * t) * RohrD, h2, 0 - sin(i * t) * RohrD));
    end;
    i := 0;
    while cos(i * t) * RohrD > StutzenD do begin
      ZweiEck(
        vec3(cos(i * t) * RohrD, h1, 0 - sin(i * t) * RohrD),
        vec3(cos(i * t) * RohrD, h2, 0 - sin(i * t) * RohrD));
      Inc(i);
    end;
    for i := Sektoren div 4 to Sektoren div 2 do begin
      if h1 > h2 then begin
        h := h2 - cos(i * t) * StutzenD;
      end else begin
        h := h2 + cos(i * t) * StutzenD;
      end;
      y2 := Sqrt(Sqr(RohrD) - Sqr(sin(i * t) * StutzenD));
      ZweiEck(
        vec3(sin(i * t) * StutzenD, h1, 0 - y2),
        vec3(sin(i * t) * StutzenD, h, 0 - y2));
    end;

  end;

var
  c1, c2: integer;

begin
  Sektoren := VLI_SEKTOREN;

  with Anzeigermasse do begin

    // --- Rohr Innen ---

    // ganz unten
    TeilLochRohr(-StandRohr.C1, 0, StandRohr.InnenD, Stutzen.InnenD);
    // oben
    TeilLochRohr(StandRohr.L / 2, StandRohr.L, StandRohr.InnenD, Stutzen.InnenD);
    FVertexData.Pos.Modif([CW]);
    FVertexData.Normal.Modif([CW, neg]);
    // unten
    c1 := FVertexData.Pos.Count;
    TeilLochRohr(StandRohr.L / 2, 0, StandRohr.InnenD, Stutzen.InnenD);
    // ganz oben
    TeilLochRohr(StandRohr.C2 + StandRohr.L, StandRohr.L, StandRohr.InnenD, Stutzen.InnenD);
    c2 := FVertexData.Pos.Count;
    FVertexData.Normal.Modif(c1, c2 - 1, [neg]);


    // --- Rohr Ausssen ---

    // unten
    c1 := c2;
    TeilLochRohr(StandRohr.L / 2, 0, StandRohr.AussenD, Stutzen.AussenD);
    // ganz oben
    TeilLochRohr(StandRohr.C2 + StandRohr.L, StandRohr.L, StandRohr.AussenD, Stutzen.AussenD);
    c2 := FVertexData.Pos.Count;
    FVertexData.Pos.Modif(c1, c2 - 1, [CW]);
    FVertexData.Normal.Modif(c1, c2 - 1, [CW]);

    // ganz unten
    TeilLochRohr(-StandRohr.C1, 0, StandRohr.AussenD, Stutzen.AussenD);
    // oben
    TeilLochRohr(StandRohr.L / 2, StandRohr.L, StandRohr.AussenD, Stutzen.AussenD);


    // Stirnseite unten
    LochDisk(StandRohr.InnenD, StandRohr.AussenD, -StandRohr.C1, 2);
    // Stirnseite oben
    LochDisk(StandRohr.AussenD, StandRohr.InnenD, StandRohr.L + StandRohr.C2, 2);
  end;

  inherited WriteVertex;
end;

{ TStandRohrSchnitt }

constructor TStandRohrSchnitt.Create;
begin
  inherited Create;
  Color := vec4(1.0, 0.0, 0.0, 1.0);
  Caption := 'StandRohrSchnitt';
end;

procedure TStandRohrSchnitt.WriteVertex;
begin
  with Anzeigermasse do begin
    Quads(
      vec3(0, StandRohr.L + StandRohr.C2, StandRohr.InnenD / 2),
      vec3(0, -StandRohr.C1, StandRohr.InnenD / 2),
      vec3(0, -StandRohr.C1, StandRohr.AussenD / 2),
      vec3(0, StandRohr.L + StandRohr.C2, StandRohr.AussenD / 2));
    Quads(
      vec3(0, StandRohr.L + StandRohr.C2, -StandRohr.AussenD / 2),
      vec3(0, StandRohr.L + Stutzen.InnenD / 2, -StandRohr.AussenD / 2),
      vec3(0, StandRohr.L + Stutzen.InnenD / 2, -StandRohr.InnenD / 2),
      vec3(0, StandRohr.L + StandRohr.C2, -StandRohr.InnenD / 2));
    Quads(
      vec3(0, StandRohr.L - Stutzen.InnenD / 2, -StandRohr.AussenD / 2),
      vec3(0, 0 + Stutzen.InnenD / 2, -StandRohr.AussenD / 2),
      vec3(0, 0 + Stutzen.InnenD / 2, -StandRohr.InnenD / 2),
      vec3(0, StandRohr.L - Stutzen.InnenD / 2, -StandRohr.InnenD / 2));
    Quads(
      vec3(0, 0 - Stutzen.InnenD / 2, -StandRohr.AussenD / 2),
      vec3(0, -StandRohr.C1, -StandRohr.AussenD / 2),
      vec3(0, -StandRohr.C1, -StandRohr.InnenD / 2),
      vec3(0, 0 - Stutzen.InnenD / 2, -StandRohr.InnenD / 2));
  end;
  inherited WriteVertex;
end;


end.
