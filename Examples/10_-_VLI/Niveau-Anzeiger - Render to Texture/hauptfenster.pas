unit HauptFenster;

{$mode objfpc}{$H+}

interface

uses
  SysUtils,
  Classes,
  Forms,
  ExtCtrls,
  Dialogs,
  Menus, StdCtrls,
  types, Graphics,
  dglOpenGL,
  oglUnit,
  oglTextur,
  oglMatrix, oglVector, oglShader, oglCamera,
  oglSteuerung, oglVAO,
  oglBackground, oglDarstellung, oglTexturVAO, oglTexturKoerper,
  VLIFluegeli, VLIAnzeigeschiene,
  VLIStandRohr,
  VLIArmaflex,
  VLIBasis,
  VLIStutzen,
  VLIFlansch,
  VLISchwimmer,
  VLIWasser,
  AnzeigerOptionen,
  Controls, Buttons;

type

  { THauptForm }

  THauptForm = class(TForm)
    Image1: TImage;
    MainMenu1: TMainMenu;
    MenuDarstellung: TMenuItem;
    MenuItem1: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    Zwei_Fenster: TMenuItem;
    MenuItem9: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem15: TMenuItem;
    MenuItem_Lichtsteuerung: TMenuItem;
    Steuerung: TMenuItem;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: integer; MousePos: TPoint; var Handled: boolean);
    procedure FormResize(Sender: TObject);
    procedure MenuDarstellungClick(Sender: TObject);
    procedure MenuItem10Click(Sender: TObject);
    procedure MenuItem11Click(Sender: TObject);
    procedure MenuItem15Click(Sender: TObject);
    procedure MenuItem8Click(Sender: TObject);
    procedure Zwei_FensterClick(Sender: TObject);
    procedure MenuItem_LichtsteuerungClick(Sender: TObject);
    procedure SteuerungClick(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    Niveau: record
      h: single;
      Richtung: (oben, unten);
    end;
    OpenGL: TOpenGL;

    RenderTexturBuffer: TRenderTexturBuffer;

    MyBackGround: TBackGround;
    texBackGround: TTexturBuffer;

    Fluegeli: TFluegeli;

    AnzeigeSchiene: TInnenProfil;
    AnzeigeSchieneSchnitt: TInnenProfilSchnitt;

    Schwimmer: TSchwimmer;
    SchwimmerSchnitt: TSchwimmerSchnitt;

    StandRohr: TStandRohr;
    StandRohrSchnitt: TStandRohrSchnitt;

    ArmaFlex: TArmaFlex;
    ArmaFlexSchnitt: TArmaFlexSchnitt;

    Stutzen: TStutzen;
    StutzenSchnitt: TStutzenSchnitt;

    RohrFlansch: TRohrFlansch;
    RohrFlanschSchnitt: TRohrFlanschSchnitt;

    ProcessFlansch: TProcessFlansch;
    ProcessFlanschSchnitt: TProcessFlanschSchnitt;

    WasserSchwimmer: TWasserSchwimmer;
    WasserSchwimmerSchnitt: TWasserSchwimmerSchnitt;

    WasserUnten: TWasserUnten;

    Cube: TTexturBox;

  const
    RenderTexturSize: integer = 1024;

    procedure RenderScene(Camera: TCamera);
  public
    procedure InitScene;
  end;

var
  HauptForm: THauptForm;

implementation

{$R *.lfm}


procedure MenuCheckAll(Item: TMenuItem);
var
  P: TMenuItem;
  i: integer;
begin
  Item.Checked := True;
  P := Item.Parent;
  if P = nil then begin
    Exit;
  end;
  for i := 0 to P.Count - 1 do begin
    if P.Items[i] <> Item then begin
      P.Items[i].Checked := False;
    end;
  end;
end;

{ THauptForm }

procedure THauptForm.InitScene;
begin
  //  TMaterialShader.LightParams.Position := vec4(1.0, 1.0, 1.4, 0.0);
  //  TMaterialShader.LightParams.Diffuse := vec4(1.3, 1.3, 1.3, 1.0);
  //  TMaterialShader.LightParams.Specular := vec4(1.0, 1.0, 1.0, 1.0);

  Fluegeli.WriteVertex;

  AnzeigeSchiene.Color := TUrAnzeiger.AluSchieneColor;
  AnzeigeSchiene.WriteVertex;

  AnzeigeSchieneSchnitt.WriteVertex;


  //  TUrAnzeiger.InoxColor:=vec4(1.0, 1.0, 0.5, 1.0);

  //  Filter(Image1.Picture.Bitmap);


  texBackGround.LoadTextures(Image1.Picture.Bitmap.RawImage);


  MyBackGround.WriteVertex;

  Schwimmer.Color := TUrAnzeiger.SchwimmerColor;
  Schwimmer.WriteVertex;

  SchwimmerSchnitt.WriteVertex;

  StandRohr.Color := TUrAnzeiger.InoxColor;
  StandRohr.WriteVertex;

  StandRohrSchnitt.WriteVertex;

  ArmaFlex.WriteVertex;
  ArmaFlexSchnitt.WriteVertex;

  Stutzen.Color := TUrAnzeiger.InoxColor;
  Stutzen.WriteVertex;

  StutzenSchnitt.WriteVertex;

  RohrFlansch.Color := TUrAnzeiger.InoxColor;
  RohrFlansch.WriteVertex;

  RohrFlanschSchnitt.WriteVertex;

  ProcessFlansch.Color := TUrAnzeiger.InoxColor;
  ProcessFlansch.WriteVertex;

  ProcessFlanschSchnitt.WriteVertex;

  WasserSchwimmer.WriteVertex;
  WasserSchwimmerSchnitt.WriteVertex;

  WasserUnten.WriteVertex;

  Cube.WriteVertex;

  RenderTexturBuffer.Camera.RotateB(-Pi / 4);
  OpenGL.Camera.RotateB(-Pi / 5);
  OpenGL.Camera.RotateA(-Pi / 12);

end;

procedure THauptForm.FormCreate(Sender: TObject);
begin
  Height := Screen.Height div 4 * 3;
  Width := Height;

  OpenGL := TOpenGL.Create(Self);

  OpenGL.BkColor := vec4(0.1, 0.4, 0.1, 0.0);
  Color := OpenGL.BkColorRGB;


  Fluegeli := TFluegeli.Create(True);
  AnzeigeSchiene := TInnenProfil.Create;
  AnzeigeSchieneSchnitt := TInnenProfilSchnitt.Create;
  Schwimmer := TSchwimmer.Create;
  SchwimmerSchnitt := TSchwimmerSchnitt.Create;
  StandRohr := TStandRohr.Create;
  StandRohrSchnitt := TStandRohrSchnitt.Create;
  ArmaFlex := TArmaFlex.Create;
  ArmaFlexSchnitt := TArmaFlexSchnitt.Create;
  Stutzen := TStutzen.Create;
  StutzenSchnitt := TStutzenSchnitt.Create;
  RohrFlansch := TRohrFlansch.Create;
  RohrFlanschSchnitt := TRohrFlanschSchnitt.Create;
  ProcessFlansch := TProcessFlansch.Create;
  ProcessFlanschSchnitt := TProcessFlanschSchnitt.Create;

  WasserSchwimmer := TWasserSchwimmer.Create;
  WasserSchwimmerSchnitt := TWasserSchwimmerSchnitt.Create;
  WasserUnten := TWasserUnten.Create;

  texBackGround := TTexturBuffer.Create;
  MyBackGround := TBackGround.Create(1);

  RenderTexturBuffer := TRenderTexturBuffer.Create(RenderTexturSize, RenderTexturSize);

  Cube := TTexturBox.Create(1, False);
  //  Cube.LoadTextures(RenderTexturBuffer.TexturBuffer);

  Darstellung1.Add(Fluegeli, [noSchnitt]);
  Darstellung1.Add(AnzeigeSchiene, []);
  Darstellung1.Add(Schwimmer, []);
  Darstellung1.Add(StandRohr, [], 1);
  Darstellung1.Add(Stutzen, [], 1);
  Darstellung1.Add(RohrFlansch, [], 1);
  Darstellung1.Add(ProcessFlansch, [], 1);
  Darstellung1.Add(ArmaFlex, [Zubehoer]);
  Darstellung1.Add(WasserSchwimmer, [noSchnitt]);

  Fluegeli.Darstellung := ganz;
  Schwimmer.Darstellung := ganz;
  WasserSchwimmer.Darstellung := ganz;
  ArmaFlex.Darstellung := Aus;

  InitScene;
  Timer1.Enabled := True;
end;

procedure THauptForm.RenderScene(Camera: TCamera);
var
  i: integer;
  AnzFluegeli: integer;
  FlugelWinkel: single;
  om: TMatrix;

  procedure Draw(const Koerper, Schnitt: TMultiTexturVAO);
  var
    m2: TMatrix;
  begin
    if not (Koerper.Darstellung = aus) then begin
      Koerper.Draw;
      if Koerper.Darstellung = geschnitten then begin
        if Schnitt <> nil then begin
          Schnitt.Draw;
        end;
      end else begin
        m2 := OpenGL.Camera.ObjectMatrix;
        OpenGL.Camera.ObjectMatrix.Scale(-1.0, 1.0, 1.0);
        OpenGL.SwapFrontFace;
        Koerper.Draw;
        OpenGL.SwapFrontFace;
        OpenGL.Camera.ObjectMatrix := m2;
      end;
    end;
  end;

begin
  with Camera do begin
    ObjectMatrix.Identity;
    ObjectMatrix.Translate(0, -TUrAnzeiger.AnzeigerMasse.StandRohr.L / 2, 0);

    om := ObjectMatrix;

    //  ProcessFlansch.SetMaterialAmbient(vec4(Random * 10, 0.0, 0.0, 1.0));

    // Background

    MyBackGround.Draw(texBackGround);

    // Flügeli

    if (Fluegeli.Darstellung = ganz) or (Fluegeli.Darstellung = geschnitten) then begin
      AnzFluegeli := Round((TUrAnzeiger.Anzeigermasse.StandRohr.L +
        TUrAnzeiger.AnzeigerMasse.Anzeigeschiene.Auslauf * 2) / 10);
      for i := 0 to anzFluegeli do begin
        FlugelWinkel := ((Niveau.h + 50) / 10 - i) * 30 + 90;
        if FlugelWinkel > 180 then begin
          FlugelWinkel := 180;
        end;
        if FlugelWinkel < 0 then begin
          FlugelWinkel := 0;
        end;

        ObjectMatrix.Translate(0, i * 10 - 50,
          TUrAnzeiger.AnzeigerMasse.StandRohr.AussenD / 2 + 10);
        ObjectMatrix.RotateA(FlugelWinkel / 180 * Pi);

        if i > 5 then begin
          Fluegeli.Color1 := vec4(1.0, 1.0, 1.0, 1.0);
          Fluegeli.Color2 := vec4(1.0, 0.0, 0.0, 1.0);
        end else begin
          Fluegeli.Color1 := vec4(1.0, 0.0, 0.0, 1.0);
          Fluegeli.Color2 := vec4(0.0, 1.0, 0.0, 1.0);
        end;

        Fluegeli.Draw;

        ObjectMatrix := om;
      end;
    end;

    // AnzeigeSchiene

    ObjectMatrix.Translate(0, -5, TUrAnzeiger.AnzeigerMasse.StandRohr.AussenD / 2);
    Draw(AnzeigeSchiene, AnzeigeSchieneSchnitt);
    ObjectMatrix := om;

    // Schwimmer

    ObjectMatrix.Translate(0, Niveau.h, 0);
    Draw(Schwimmer, SchwimmerSchnitt);
    ObjectMatrix := om;

    // StandRohr

    Draw(StandRohr, StandRohrSchnitt);

    // ArmaFlex

    Draw(ArmaFlex, ArmaFlexSchnitt);

    // Stutzen unten

    Draw(Stutzen, StutzenSchnitt);

    // Stutzen oben;

    ObjectMatrix.Translate(0.0, TUrAnzeiger.AnzeigerMasse.StandRohr.L, 0.0);
    Draw(Stutzen, StutzenSchnitt);
    ObjectMatrix := om;

    // RohrFlansch unten

    ObjectMatrix.Translate(0.0, -TUrAnzeiger.AnzeigerMasse.StandRohr.C1, 0.0);
    Draw(RohrFlansch, RohrFlanschSchnitt);
    ObjectMatrix := om;

    // RohrFlansch oben

    ObjectMatrix.RotateA(Pi);
    ObjectMatrix.Translate(0.0, TUrAnzeiger.AnzeigerMasse.StandRohr.L +
      TUrAnzeiger.AnzeigerMasse.StandRohr.C2, 0.0);
    Draw(RohrFlansch, RohrFlanschSchnitt);
    ObjectMatrix := om;

    // ProcessFlansch unten

    ObjectMatrix.RotateA(Pi / 2);
    ObjectMatrix.Translate(0, 0, -TUrAnzeiger.AnzeigerMasse.Stutzen.t);
    Draw(ProcessFlansch, ProcessFlanschSchnitt);
    ObjectMatrix := om;

    // ProcessFlansch oben

    ObjectMatrix.RotateA(Pi / 2);
    ObjectMatrix.Translate(0, TUrAnzeiger.AnzeigerMasse.StandRohr.L,
      -TUrAnzeiger.AnzeigerMasse.Stutzen.t);
    Draw(ProcessFlansch, ProcessFlanschSchnitt);
    ObjectMatrix := om;

    // WasserSchwimmer

    if (WasserSchwimmer.Darstellung = ganz) or
      (WasserSchwimmer.Darstellung = geschnitten) then begin
      ObjectMatrix.Translate(0, Niveau.h, 0);

      if (StandRohr.Darstellung = geschnitten) or
        (Schwimmer.Darstellung = geschnitten) then begin
        WasserSchwimmer.Darstellung := geschnitten;
      end else begin
        WasserSchwimmer.Darstellung := ganz;
      end;

      Draw(WasserSchwimmer, WasserSchwimmerSchnitt);
      ObjectMatrix := om;

      with TUrAnzeiger.AnzeigerMasse do begin
        ObjectMatrix.Scale(1.0, StandRohr.C1 + Niveau.h - Schwimmer.AussenD /
          2 - Schwimmer.AussenD * (Schwimmer.anzKugeln - 1), StandRohr.InnenD);
        ObjectMatrix.Translate(0.0, -StandRohr.C1, -StandRohr.InnenD / 2);
      end;
      WasserUnten.Draw;
    end;

    ObjectMatrix := om;
  end;  // with Camera

end;

procedure THauptForm.FormDestroy(Sender: TObject);
begin
  FreeAndNil(MyBackGround);
  FreeAndNil(texBackGround);

  FreeAndNil(Fluegeli);
  FreeAndNil(AnzeigeSchiene);
  FreeAndNil(AnzeigeSchieneSchnitt);
  FreeAndNil(Schwimmer);
  FreeAndNil(SchwimmerSchnitt);
  FreeAndNil(StandRohr);
  FreeAndNil(StandRohrSchnitt);
  FreeAndNil(ArmaFlex);
  FreeAndNil(ArmaFlexSchnitt);
  FreeAndNil(Stutzen);
  FreeAndNil(StutzenSchnitt);
  FreeAndNil(RohrFlansch);
  FreeAndNil(RohrFlanschSchnitt);
  FreeAndNil(ProcessFlansch);
  FreeAndNil(ProcessFlanschSchnitt);

  FreeAndNil(WasserSchwimmer);
  FreeAndNil(WasserSchwimmerSchnitt);
  FreeAndNil(WasserUnten);

  FreeAndNil(OpenGL);

  FreeAndNil(Cube);
end;

procedure THauptForm.FormMouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: integer; MousePos: TPoint; var Handled: boolean);
begin
  if WheelDelta < 0 then begin
    OpenGL.Camera.Scale(1.1);
  end else begin
    OpenGL.Camera.Scale(0.9);
  end;
end;

procedure THauptForm.FormResize(Sender: TObject);
begin
  OpenGL.Resize(ClientWidth, ClientHeight);
  OpenGL.Camera.Perspective(30, ClientWidth / ClientHeight, 0.3, 100, -5, 1 / 150);
end;

procedure THauptForm.MenuItem10Click(Sender: TObject); inline;
begin
  AnzeigerOptionenForm.Show;
end;

procedure THauptForm.MenuItem11Click(Sender: TObject);
begin
  RenderTexturSize := RenderTexturSize shr 1;
  RenderTexturBuffer.Resize(RenderTexturSize, RenderTexturSize);
end;

procedure THauptForm.MenuItem8Click(Sender: TObject);
begin
  RenderTexturSize := RenderTexturSize shl 1;
  RenderTexturBuffer.Resize(RenderTexturSize, RenderTexturSize);
end;


procedure THauptForm.MenuItem2Click(Sender: TObject); inline;
begin
  Close;
end;

procedure THauptForm.MenuItem4Click(Sender: TObject); inline;
begin
  ShowMessage('Copyright '#194#169' by M. Burkhard'#13#10'Version 0.6');
end;

procedure THauptForm.MenuItem15Click(Sender: TObject);
begin
  ShowMessage(OpenGL.GetVersion);
end;

procedure THauptForm.Zwei_FensterClick(Sender: TObject);
begin
  Zwei_Fenster.Checked := not Zwei_Fenster.Checked;
end;

procedure THauptForm.MenuItem_LichtsteuerungClick(Sender: TObject);
begin
  //LichtSteuerung1.Show;
  //LichtSteuerung1.Left := Left;
  //LichtSteuerung1.Top := Top;
  //LichtSteuerung1.Color := Color;
end;

procedure THauptForm.SteuerungClick(Sender: TObject);
begin
  CameraSteuerung.Show;
  CameraSteuerung.Left := Left;
  CameraSteuerung.Top := Top;
  CameraSteuerung.Color := Color;
end;

procedure THauptForm.MenuDarstellungClick(Sender: TObject);
begin
  Darstellung1.Show;
end;

procedure THauptForm.Timer1Timer(Sender: TObject);
begin
  with Niveau do begin
    if Niveau.Richtung = oben then begin
      h += 1;
      if h > TUrAnzeiger.AnzeigerMasse.StandRohr.L + 20 then begin
        h := TUrAnzeiger.AnzeigerMasse.StandRohr.L + 20;
        Richtung := unten;
      end;
    end else begin
      h -= 1;
      if h < -20 then begin
        h := -20;
        Richtung := oben;
      end;
    end;
  end;

  with RenderTexturBuffer do begin
    Clear;
    Camera.Perspective(30, Width / Height, 0.3, 100, -5, 1 / 300);
    RenderScene(Camera);
  end;


  // ========================================

  with  OpenGL do begin
    Clear;

    Camera.ObjectMatrix.Identity;
    Camera.ObjectMatrix.Scale(200);

    Cube.Draw(RenderTexturBuffer.TexturBuffer);

    MyBackGround.Draw(texBackGround);

    OpenGL.SwapBuffers;
  end;
end;

end.
