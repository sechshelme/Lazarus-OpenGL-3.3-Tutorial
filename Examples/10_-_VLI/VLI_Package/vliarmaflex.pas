unit VLIArmaflex;

{$mode objfpc}{$H+}

interface

uses
  oglVector, oglMatrix, oglVBO,
  VLIBasis;

type

  { TArmaFlex }

  TArmaFlex = class(TUrAnzeiger)
  public
    constructor Create;
    procedure WriteVertex;
  end;

  { TArmaFlexSchnitt }

  TArmaFlexSchnitt = class(TUrAnzeiger)
  public
    constructor Create;
    procedure WriteVertex;
  end;


implementation

{ TArmaFlex }

constructor TArmaFlex.Create;
begin
  inherited Create;
  Caption := 'Isolierung';
  Color := vec4(0.0, 0.0, 0.0, 1.0);
end;

procedure TArmaFlex.WriteVertex;

  procedure TeilLochRohr(h1, h2, RohrD, StutzenD, schlitz: single);
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
    RohrD /= 2;
    StutzenD /= 2;
    Hypotenuse := Sqrt(Sqr(RohrD) - Sqr(schlitz));
    VectorAlt1 := vec3(schlitz, h1, Hypotenuse);
    VectorAlt2 := vec3(schlitz, h2, Hypotenuse);

    t := 2 * Pi / Sektoren;

    for i := 27 to 35 do begin
      if cos(i * t) * RohrD > schlitz then begin
        ZweiEck(
          vec3(cos(i * t) * RohrD, h1, 0 - sin(i * t) * RohrD),
          vec3(cos(i * t) * RohrD, h2, 0 - sin(i * t) * RohrD));
      end;
    end;
    i := 0;
    while cos(i * t) * RohrD > StutzenD do begin
      ZweiEck(
        vec3(cos(i * t) * RohrD, h1, 0 - sin(i * t) * RohrD),
        vec3(cos(i * t) * RohrD, h2, 0 - sin(i * t) * RohrD));
      Inc(i);
    end;
    for i := 9 to 18 do begin
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
  schlitz: single = 20.0;         // Für Armaflex
  c1, c2: integer;

begin
  Sektoren := VLI_SEKTOREN;

  with Anzeigermasse do begin

    // --- Rohr Innen ---

    // ganz unten
    TeilLochRohr(ArmaFlex.L / 2, 0, ArmaFlex.AussenD, Stutzen.AussenD, schlitz);
    // oben
    TeilLochRohr(ArmaFlex.C2 + ArmaFlex.L, ArmaFlex.L, ArmaFlex.AussenD, Stutzen.AussenD, schlitz);
    FVertexData.Pos.Modif([CW]);
    FVertexData.Normal.Modif([CW, neg]);
    // unten
    c1 := FVertexData.Pos.Count;
    TeilLochRohr(-ArmaFlex.C1, 0, ArmaFlex.AussenD, Stutzen.AussenD, schlitz);
    // ganz oben
    TeilLochRohr(ArmaFlex.L / 2, ArmaFlex.L, ArmaFlex.AussenD, Stutzen.AussenD, schlitz);
    c2 := FVertexData.Pos.Count;
    FVertexData.Normal.Modif(c1, c2 - 1, [neg]);


    // --- Rohr Ausssen ---

    // unten
    c1 := c2;
    TeilLochRohr(-ArmaFlex.C1, 0, ArmaFlex.InnenD, Stutzen.InnenD, schlitz);
    // ganz oben
    TeilLochRohr(ArmaFlex.L / 2, ArmaFlex.L, ArmaFlex.InnenD, Stutzen.InnenD, schlitz);
    c2 := FVertexData.Pos.Count;
    FVertexData.Pos.Modif(c1, c2 - 1, [CW]);
    FVertexData.Normal.Modif(c1, c2 - 1, [CW]);

    // ganz unten
    TeilLochRohr(ArmaFlex.L / 2, 0, ArmaFlex.InnenD, Stutzen.InnenD, schlitz);
    // oben
    TeilLochRohr(ArmaFlex.C2 + ArmaFlex.L, ArmaFlex.L, ArmaFlex.InnenD, Stutzen.InnenD, schlitz);

  end;

  inherited WriteVertex;
end;

{ TArmaFlexSchnitt }

constructor TArmaFlexSchnitt.Create;
begin
  inherited Create;
  Color := vec4(0.8, 0.0, 0.0, 1.0);
end;

procedure TArmaFlexSchnitt.WriteVertex;
begin
  with Anzeigermasse do begin
    Quads(
      vec3(0, ArmaFlex.L + ArmaFlex.C2, ArmaFlex.InnenD / 2),
      vec3(0, -ArmaFlex.C1, ArmaFlex.InnenD / 2),
      vec3(0, -ArmaFlex.C1, ArmaFlex.AussenD / 2),
      vec3(0, ArmaFlex.L + ArmaFlex.C2, ArmaFlex.AussenD / 2));
    Quads(
      vec3(0, ArmaFlex.L + ArmaFlex.C2, -ArmaFlex.AussenD / 2),
      vec3(0, ArmaFlex.L + Stutzen.InnenD / 2, -ArmaFlex.AussenD / 2),
      vec3(0, ArmaFlex.L + Stutzen.InnenD / 2, -ArmaFlex.InnenD / 2),
      vec3(0, ArmaFlex.L + ArmaFlex.C2, -ArmaFlex.InnenD / 2));
    Quads(
      vec3(0, ArmaFlex.L - Stutzen.InnenD / 2, -ArmaFlex.AussenD / 2),
      vec3(0, 0 + Stutzen.InnenD / 2, -ArmaFlex.AussenD / 2),
      vec3(0, 0 + Stutzen.InnenD / 2, -ArmaFlex.InnenD / 2),
      vec3(0, ArmaFlex.L - Stutzen.InnenD / 2, -ArmaFlex.InnenD / 2));
    Quads(
      vec3(0, 0 - Stutzen.InnenD / 2, -ArmaFlex.AussenD / 2),
      vec3(0, -ArmaFlex.C1, -ArmaFlex.AussenD / 2),
      vec3(0, -ArmaFlex.C1, -ArmaFlex.InnenD / 2),
      vec3(0, 0 - Stutzen.InnenD / 2, -ArmaFlex.InnenD / 2));
  end;
  inherited WriteVertex;
end;


end.
