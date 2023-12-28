unit VLIFluegeli;

{$mode objfpc}{$H+}

interface

uses
  oglVector, oglMatrix,
  VLIBasis;

type

  { TFluegeli }

  TFluegeli = class(TUrAnzeiger)
  private
    FColor1: TVector4f;
    FColor2: TVector4f;
    TempMatrix: TMatrix;
    procedure SetColor1(AValue: TVector4f);
    procedure SetColor2(AValue: TVector4f);
  public
    constructor Create(light: boolean = True);
    destructor Destroy; override;
    property Color1: TVector4f read FColor1 write SetColor1;
    property Color2: TVector4f read FColor2 write SetColor2;
    procedure WriteVertex;
    procedure Draw;
  end;

implementation

{ TFluegeli }

procedure TFluegeli.SetColor1(AValue: TVector4f); inline;
begin
  FColor1 := AValue;
end;

procedure TFluegeli.SetColor2(AValue: TVector4f); inline;
begin
  FColor2 := AValue;
end;

constructor TFluegeli.Create(light: boolean);
begin
  inherited Create(light);
  Color1 := vec4(1.0, 1.0, 1.0, 1.0);
  Color2 := vec4(1.0, 0.0, 0.0, 1.0);
  Caption := 'Fluegeli';
  TempMatrix.Identity;
end;

destructor TFluegeli.Destroy;
begin
  inherited Destroy;
end;

procedure TFluegeli.WriteVertex;
var
  i: integer;
  t, fbi, x0, y0, x1, y1: single;
begin
  Sektoren := VLI_SEKTOREN;
  t := Pi * 2 / Sektoren;

  fbi := (AnzeigerMasse.Anzeigeschiene.Breite.Innen - 0.3) / 2;

  for i := 0 to (Sektoren div 4) - 1 do begin
    x0 := sin((i + 0) * t) * 3;
    y0 := cos((i + 0) * t) * 3;
    x1 := sin((i + 1) * t) * 3;
    y1 := cos((i + 1) * t) * 3;

    Quads(
      vec3(x0, 3.5, y0), vec3(x0, -3.5, y0), vec3(x1, -3.5, y1), vec3(x1, 3.5, y1),
      vec3(x0, 0, y0), vec3(x0, 0, y0), vec3(x1, 0, y1), vec3(x1, 0, y1));

    Quads(
      vec3(x0, -3.5, y0), vec3(x0 * 0.85, -4, y0 * 0.85), vec3(x1 * 0.85, -4, y1 * 0.85), vec3(x1, -3.5, y1),
      vec3(x0, 0, y0), vec3(0, -1, 0), vec3(0, -1, 0), vec3(x1, 0, y1));

    Quads(
      vec3(x1 * 0.85, 4, y1 * 0.85), vec3(x0 * 0.85, 4, y0 * 0.85), vec3(x0, 3.5, y0), vec3(x1, 3.5, y1),
      vec3(0, 1, 0), vec3(0, 1, 0), vec3(x0, 0, y0), vec3(x1, 0, y1));

    Triangles(vec3(x0 * 0.85, 4, y0 * 0.85), vec3(x1 * 0.85, 4, y1 * 0.85), vec3(0, 4, 0));
    Triangles(vec3(x1 * 0.85, -4, y1 * 0.85), vec3(x0 * 0.85, -4, y0 * 0.85), vec3(0, -4, 0));
  end;

  Quads(vec3(2.5, 4, 0.5), vec3(2.5, -4, 0.5), vec3(fbi, -4, 0.5), vec3(fbi, 4, 0.5));           // ganze Fläche
  Quads(vec3(2.5, -4, 0.5), vec3(2.5, -4, 0.0), vec3(fbi, -4, 0.0), vec3(fbi, -4, 0.5));         // ganze Fläche - Seiten
  Quads(vec3(fbi, 4, 0.5), vec3(fbi, 4, 0.0), vec3(2.5, 4, 0.0), vec3(2.5, 4, 0.5));             // ganze Fläche - Seiten
  Quads(vec3(fbi, -4, 0.5), vec3(fbi, -4, 0.0), vec3(fbi, 4, 0.0), vec3(fbi, 4, 0.5));             // StirnSeite

  Quads(vec3(fbi, 0.5, 0.5), vec3(fbi, -0.5, 0.5), vec3(fbi + 1, -0.5, 0.5), vec3(fbi + 1, 0.5, 0.5));     // Achse
  Quads(vec3(fbi, -0.5, 0.5), vec3(fbi, -0.5, 0.0), vec3(fbi + 1, -0.5, 0.0), vec3(fbi + 1, -0.5, 0.5));   // Achse - Seiten
  Quads(vec3(fbi + 1, 0.5, 0.5), vec3(fbi + 1, 0.5, 0.0), vec3(fbi, 0.5, 0.0), vec3(fbi, 0.5, 0.5));       // Achse - Seiten
  Quads(vec3(fbi + 1, -0.5, 0.5), vec3(fbi + 1, -0.5, 0.0), vec3(fbi + 1, 0.5, 0.0), vec3(fbi + 1, 0.5, 0.5));     // Achse StirnSeite

  Quads(vec3(9, 4.01, -0.51), vec3(9, 4.01, 0.5), vec3(10, 4.01, 0.5), vec3(10, 4.01, -0.51)); // Lasche
  Quads(vec3(10, 4.01, -0.51), vec3(10, 3, -0.51), vec3(9, 3, -0.51), vec3(9, 4.01, -0.51));

  inherited WriteVertex;
end;

procedure TFluegeli.Draw;
var
  m: TMatrix;
begin
  with Camera do begin
    TempMatrix.Identity;

    m := ObjectMatrix;
    Color := Color1;
    inherited Draw;

    TempMatrix.RotateC(Pi);
    ObjectMatrix := ObjectMatrix * TempMatrix;
    inherited Draw;

    Color := Color2;

    ObjectMatrix := m;
    TempMatrix.RotateA(Pi);
    ObjectMatrix := ObjectMatrix * TempMatrix;
    inherited Draw;

    ObjectMatrix := m;
    TempMatrix.RotateC(Pi);
    ObjectMatrix := ObjectMatrix * TempMatrix;
    inherited Draw;

    ObjectMatrix := m;
  end;
end;

end.
