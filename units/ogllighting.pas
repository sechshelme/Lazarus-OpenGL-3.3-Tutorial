unit oglLighting;

{$mode objfpc}{$H+}

interface

uses
  LCL, LCLType, SysUtils, Controls,
  Forms, StdCtrls, ExtCtrls, Buttons,
  dglOpenGL,
  oglMatrix, oglVAO;

type

  { TLighting }

  TLighting = class(TObject)
  private
    FVAO: array of TTriangleVAO;

  public
    position, ambient, diffuse, specular: TVector4f;

    constructor Create;

    procedure Add(VAO: TTriangleVAO);
    procedure Delete(VAO: TTriangleVAO);
    procedure Clear;

    procedure Setposition(v: TVector4f);
    procedure Setambient(v: TVector4f);
    procedure Setdiffuse(v: TVector4f);
    procedure Setspecular(v: TVector4f);
    procedure Update;     // Muss nach jeder Änderung aufgerufen werden !
  end;

  { TLightingDlg }

  TLightingDlg = class(TLighting)
  private
    initz: boolean;

    MyLabel: array[0..3] of TLabel;
    ScrollBar: array[0..11] of record
      SB: TScrollBar;
      Shape: TShape;
      PosLabel: TLabel;
    end;
    CloseButton: TBitBtn;
    procedure ScrollBarChange(Sender: TObject);
  public
    Form: TForm;

    constructor Create;
    destructor Destroy; override;

    procedure Show;
  end;


implementation

{ TLighting }

constructor TLighting.Create;
begin
  inherited Create;

  position := vec4(200.0, 300.0, 100.0, 0.0);
  ambient := vec4(0.8, 0.8, 0.8, 0.0);    // Umgebungslicht
  diffuse := vec4(2.0, 2.0, 2.0, 1.0);    // Lichtfarbe
  specular := vec4(1.0, 1.0, 1.0, 1.0);   // Spiegelnd
end;

procedure TLighting.Add(VAO: TTriangleVAO);
var
  l: integer;
begin
  l := Length(FVAO);
  SetLength(FVAO, l + 1);
  FVAO[l] := VAO;
end;

procedure TLighting.Delete(VAO: TTriangleVAO);
var
  i, j: integer;
begin
  for i := 0 to Length(FVAO) - 1 do begin
    if FVAO[i] = VAO then begin
      for j := i to Length(FVAO) - 2 do begin
        FVAO[j] := FVAO[j + 1];
      end;
      SetLength(FVAO, Length(FVAO) - 1);
    end;
  end;
end;

procedure TLighting.Clear;
begin
  SetLength(FVAO, 0);
end;

procedure TLighting.Setposition(v: TVector4f);
begin
  position := v;
end;

procedure TLighting.Setambient(v: TVector4f);
begin
  ambient := v;
end;

procedure TLighting.Setdiffuse(v: TVector4f);
begin
  diffuse := v;
end;

procedure TLighting.Setspecular(v: TVector4f);
begin
  specular := v;
end;

procedure TLighting.Update;
var
  i: integer;
begin
  for i := 0 to Length(FVAO) - 1 do begin
    FVAO[i].LightingShader.LightParams.position := position;
    FVAO[i].LightingShader.LightParams.ambient := ambient;
    FVAO[i].LightingShader.LightParams.diffuse := diffuse;
    FVAO[i].LightingShader.LightParams.specular := specular;
    FVAO[i].LightingShader.UpdateLight;
  end;
end;

{ TLightingDlg }

constructor TLightingDlg.Create;
var
  i: integer;
const
  shRand = 5;
begin
  inherited Create;

  Form := TForm.Create(nil);

  with Form do begin
    Caption := 'Licht-Steuerung';
    Position := poDefault;
    Width := 450;
    Height := 500;
    Constraints.MaxHeight := 500;
    Constraints.MinHeight := 500;
  end;

  CloseButton := TBitBtn.Create(Form);
  with CloseButton do begin
    Parent := Form;
    Top := 450;
    Left := Form.ClientWidth - 100;
    Anchors := [akRight];
    Kind := bkClose;
    ModalResult := mrClose;
  end;

  for i := 0 to Length(MyLabel) - 1 do begin
    MyLabel[i] := TLabel.Create(Form);
    with  MyLabel[i] do begin
      Parent := Form;
      Left := 40;
      Anchors := [akTop, akLeft];
      Top := 25 * 4 * i + 25;
    end;
  end;

  MyLabel[0].Caption := 'Position:';
  MyLabel[1].Caption := 'Umgebunglicht:';
  MyLabel[2].Caption := 'Farbe:';
  MyLabel[3].Caption := 'Glanz:';

  for i := 0 to Length(ScrollBar) - 1 do begin
    with ScrollBar[i] do begin
      SB := TScrollBar.Create(Form);
      with SB do begin
        Parent := Form;
        Left := 40;
        Width := Form.ClientWidth - 2 * Left - 50;
        Anchors := [akTop, akLeft, akRight];
        Top := 25 * i + (i div 3) * 25 + 50;
        OnChange := @ScrollBarChange;
      end;

      Shape := TShape.Create(Form);
      with Shape do begin
        Parent := Form;
        Left := 40 - shRand;
        Width := Form.ClientWidth - 2 * Left + 2 * shRand;
        Anchors := [akTop, akLeft, akRight];
        Top := 25 * i + (i div 3) * 25 + 50 - shRand;
        Height := SB.Height + 2 * shRand;
        Brush.Color := $FF shl ((i mod 3) * 8);
        Pen.Color := Brush.Color;
      end;

      PosLabel := TLabel.Create(Form);
      with PosLabel do begin
        Parent := Form;
        Left := Form.ClientWidth - 2 * Left - 100;
        Anchors := [akTop, akRight];
        Top := 25 * i + (i div 3) * 25 + 50;
        Caption := '00.00';
      end;
    end;
  end;

  for i := 0 to 2 do begin
    ScrollBar[0 + i].SB.Min := -65536;
    ScrollBar[0 + i].SB.Max := 65536;
    ScrollBar[3 + i].SB.Min := 0;
    ScrollBar[3 + i].SB.Max := 1024;
    ScrollBar[6 + i].SB.Min := 0;
    ScrollBar[6 + i].SB.Max := 1024;
    ScrollBar[9 + i].SB.Min := 0;
    ScrollBar[9 + i].SB.Max := 1024;
  end;
end;

destructor TLightingDlg.Destroy;
begin
  Form.Free;

  inherited Destroy;
end;

procedure TLightingDlg.Show;

  function GetPos(f: glFloat): integer; inline;
  begin
    Result := round(f * $100);
  end;

var
  i: integer;
begin
  Form.Show;

  initz := False;

  for i := 0 to 2 do begin
    ScrollBar[0 + i].SB.Position := GetPos(Position[i]);
    ScrollBar[3 + i].SB.Position := GetPos(Ambient[i]);
    ScrollBar[6 + i].SB.Position := GetPos(Diffuse[i]);
    ScrollBar[9 + i].SB.Position := GetPos(Specular[i]);
  end;
  initz := True;
end;

procedure TLightingDlg.ScrollBarChange(Sender: TObject);

  function GetPos(Bar: TScrollBar): glFloat; inline;
  begin
    Result := Bar.Position / $100;
  end;

  function FF(f: single): string;
  begin
    Result := FormatFloat('0.000', f);
  end;

var
  i: integer;
begin
  if initz then begin
    for i := 0 to 2 do begin
      position[i] := GetPos(ScrollBar[0 + i].SB);
      ambient[i] := GetPos(ScrollBar[3 + i].SB);
      diffuse[i] := GetPos(ScrollBar[6 + i].SB);
      specular[i] := GetPos(ScrollBar[9 + i].SB);
    end;
    Position[3] := 1.0;
    Ambient[3] := 1.0;
    Diffuse[3] := 1.0;
    Specular[3] := 1.0;

    Update;
  end;

  for i := 0 to 2 do begin
    ScrollBar[0 + i].PosLabel.Caption := FF(position[i]);
    ScrollBar[3 + i].PosLabel.Caption := FF(ambient[i]);
    ScrollBar[6 + i].PosLabel.Caption := FF(diffuse[i]);
    ScrollBar[9 + i].PosLabel.Caption := FF(specular[i]);
  end;
end;

end.
