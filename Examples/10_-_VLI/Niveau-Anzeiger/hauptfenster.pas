unit HauptFenster;

{$mode objfpc}{$H+}

interface

uses
  SysUtils,  Classes,  Forms,  ExtCtrls,  Dialogs,  Menus, StdCtrls,  types, Graphics,
  LCLVersion, Controls, Buttons,
  oglglad_gl,
  oglUnit,  oglTextur, oglTexturVAO, oglTexturKoerper,  oglVector, oglMatrix,
  oglLighting,  oglSteuerung,  oglBackground, oglDarstellung, oglVAO,
  VLIAnzeigeschiene,  VLIFluegeli,  VLIStandRohr,  VLIArmaflex,  VLIBasis,
  VLIStutzen,  VLIFlansch,  VLISchwimmer,  VLIDichtung,  AnzeigerOptionen,
  VLIWasser;

type

  { THauptForm }

  THauptForm = class(TForm)
    ImageEarthTextur: TImage;
    ImageEarthNormal: TImage;
    ImageCloudTextur: TImage;
    ImageCloudNormal: TImage;
    ImageAll: TImage;
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
    MenuItemSpeichern: TMenuItem;
    MenuItem9: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem15: TMenuItem;
    MenuItem_Lichtsteuerung: TMenuItem;
    Steuerung: TMenuItem;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure MenuDarstellungClick(Sender: TObject);
    procedure MenuItem10Click(Sender: TObject);
    procedure MenuItem15Click(Sender: TObject);
    procedure MenuItemSpeichernClick(Sender: TObject);
    procedure MenuItem_LichtsteuerungClick(Sender: TObject);
    procedure SteuerungClick(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    Niveau: record
      Pegel: single;
      Richtung: (oben, unten);
      end;
    OpenGL: TOpenGL;

    Globus: record
      Sphere: TBumpmappingTexturSphere;
      GlobusMatrix, WolkenMatrix: TMatrix;

      EarthTextur: record
        Pos, Normal: TTexturBuffer;
        end;

      CloudsTextur: record
        Pos, Normal: TTexturBuffer;
        end;
      end;

    All: record
      Textur: TTexturBuffer;
      Background: TBackGround;
      end;
  public
    VLILighting: TLightingDlg;
    GlobusLighting: TLightingDlg;

    VLITeile: record
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

      DichtungRohrFlansch: TVLIDichtungRohrFlansch;
      DichtungRohrFlanschSchnitt: TVLIDichtungRohrFlanschSchnitt;
      DichtungProcessFlansch: TVLIDichtungProcessFlansch;
      DichtungProcessFlanschSchnitt: TVLIDichtungProcessFlanschSchnitt;

      WasserSchwimmer: TWasserSchwimmer;
      WasserSchwimmerSchnitt: TWasserSchwimmerSchnitt;

      WasserUnten: TWasserUnten;
      end;

    procedure RenderScene;
    procedure InitScene;
  end;

var
  HauptForm: THauptForm;

implementation

{$R *.lfm}


{ THauptForm }

procedure THauptForm.FormCreate(Sender: TObject);
var
  r: TRect;
begin
  Color := clBlack;
  Height := Screen.Height div 4 * 3;
  Width := Height;

  OpenGL := TOpenGL.Create(Self, 3, 3, 4);
  //  InitOpenGLDebug;

  with OpenGL do begin
    AlphaBlending(True);
    Camera.RotateB(-Pi / 4);
    Camera.Scale(0.6);
    Camera.SetCameraMatrixTransform(False);
    BkColor := vec4(0.0, 0.0, 0.0, 0.0);
  end;

  Color := OpenGL.BkColorRGB;

  with VLITeile do begin
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
    ProcessFlansch := TProcessFlansch.Create;
    ProcessFlanschSchnitt := TProcessFlanschSchnitt.Create;
    RohrFlansch := TRohrFlansch.Create;
    RohrFlanschSchnitt := TRohrFlanschSchnitt.Create;

    DichtungRohrFlansch := TVLIDichtungRohrFlansch.Create;
    DichtungRohrFlanschSchnitt := TVLIDichtungRohrFlanschSchnitt.Create;
    DichtungProcessFlansch := TVLIDichtungProcessFlansch.Create;
    DichtungProcessFlanschSchnitt := TVLIDichtungProcessFlanschSchnitt.Create;

    WasserSchwimmer := TWasserSchwimmer.Create;
    WasserSchwimmerSchnitt := TWasserSchwimmerSchnitt.Create;
    WasserUnten := TWasserUnten.Create;

    VLILighting := TLightingDlg.Create;
    VLILighting.Form.Caption := 'Licht VLI';

    VLILighting.Add(Fluegeli);
    VLILighting.Add(AnzeigeSchiene);
    VLILighting.Add(AnzeigeSchieneSchnitt);
    VLILighting.Add(Schwimmer);
    VLILighting.Add(SchwimmerSchnitt);
    VLILighting.Add(StandRohr);
    VLILighting.Add(StandRohrSchnitt);
    VLILighting.Add(ArmaFlex);
    VLILighting.Add(ArmaFlexSchnitt);
    VLILighting.Add(Stutzen);
    VLILighting.Add(StutzenSchnitt);
    VLILighting.Add(ProcessFlansch);
    VLILighting.Add(ProcessFlanschSchnitt);
    VLILighting.Add(RohrFlansch);
    VLILighting.Add(RohrFlanschSchnitt);

    VLILighting.Add(DichtungRohrFlansch);
    VLILighting.Add(DichtungRohrFlanschSchnitt);
    VLILighting.Add(DichtungProcessFlansch);
    VLILighting.Add(DichtungProcessFlanschSchnitt);

    Darstellung1.Add(Fluegeli, [noSchnitt]);
    Darstellung1.Add(AnzeigeSchiene, []);
    Darstellung1.Add(Schwimmer, []);
    Darstellung1.Add(StandRohr, [], 1);
    Darstellung1.Add(Stutzen, [], 1);
    Darstellung1.Add(RohrFlansch, [], 1);
    Darstellung1.Add(ProcessFlansch, [], 1);
    Darstellung1.Add(DichtungRohrFlansch, [], 2);
    Darstellung1.Add(DichtungProcessFlansch, [], 2);
    Darstellung1.Add(ArmaFlex, [Zubehoer]);
    Darstellung1.Add(WasserSchwimmer, [noSchnitt]);

    Fluegeli.Darstellung := ganz;
    Schwimmer.Darstellung := ganz;
    WasserSchwimmer.Darstellung := ganz;
    ArmaFlex.Darstellung := Aus;
  end;

  with All do begin
    Textur := TTexturBuffer.Create;
    Background := TBackGround.Create(1, True);          // Muss für Java-Script und Android auf TRUE sein !
  end;

  with Globus do begin
    GlobusMatrix.Identity;
    ;
    WolkenMatrix.Identity;
    ;

    with EarthTextur do begin
      Pos := TTexturBuffer.Create;
      Normal := TTexturBuffer.Create;
    end;

    with CloudsTextur do begin
      Pos := TTexturBuffer.Create;
      Normal := TTexturBuffer.Create;
    end;

    GlobusLighting := TLightingDlg.Create;
    GlobusLighting.Form.Caption := 'Licht Globus';

    Sphere := TBumpmappingTexturSphere.Create(True);
    Sphere.Caption := 'Earth';

    GlobusLighting.Add(Sphere);
  end;

  InitScene;
  Timer1.Enabled := True;
end;

procedure THauptForm.InitScene;

  procedure SetTextPara(tex: TTexturBuffer);
  begin
    tex.TexParameter.Add(GL_TEXTURE_MAG_FILTER, GL_LINEAR_MIPMAP_LINEAR);
    tex.TexParameter.Add(GL_TEXTURE_MIN_FILTER, GL_LINEAR_MIPMAP_LINEAR);
    tex.TexParameter.Add(GL_TEXTURE_WRAP_S, GL_REPEAT);
    tex.TexParameter.Add(GL_TEXTURE_WRAP_T, GL_REPEAT);
  end;

begin
  with VLILighting do begin
    position := vec4(-100.0, 100.0, 100.0, 0.0);
    ambient := vec4(0.5, 0.5, 0.5, 1.0);
    diffuse := vec4(3.3, 3.3, 3.3, 1.0);
    specular := vec4(1.0, 1.0, 1.0, 1.0);
    Update;
  end;

  with VLITeile do begin
    Fluegeli.WriteVertex;

    AnzeigeSchiene.Color := TUrAnzeiger.AluSchieneColor;
    AnzeigeSchiene.WriteVertex;

    AnzeigeSchieneSchnitt.WriteVertex;

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

    DichtungRohrFlansch.WriteVertex;
    DichtungRohrFlanschSchnitt.WriteVertex;
    DichtungProcessFlansch.WriteVertex;
    DichtungProcessFlanschSchnitt.WriteVertex;

    WasserSchwimmer.WriteVertex;
    WasserSchwimmerSchnitt.WriteVertex;

    WasserUnten.WriteVertex;
  end;

  with All do begin
    Textur.LoadTextures(ImageAll.Picture.Bitmap.RawImage);
    Background.WriteVertex;
  end;

  with Globus do begin

    with EarthTextur do begin
      SetTextPara(Pos);
      Pos.LoadTextures(ImageEarthTextur.Picture.Bitmap.RawImage);
      SetTextPara(Normal);
      Normal.LoadTextures(ImageEarthNormal.Picture.Bitmap.RawImage);
    end;

    with CloudsTextur do begin
      SetTextPara(Pos);
      Pos.LoadTextures(ImageCloudTextur.Picture.Bitmap.RawImage);
      SetTextPara(Normal);
      Normal.LoadTextures(ImageCloudNormal.Picture.Bitmap.RawImage);
    end;

    Sphere.LightingShader.SetMaterial('PlasticWhite');
    Sphere.LightingShader.MaterialParams.ambient := vec4(0.4, 0.4, 0.4, 1.0);
    Sphere.LightingShader.UpdateMaterial;
    Sphere.Sektoren := 64;
    Sphere.WriteVertex;
  end;

end;

procedure THauptForm.RenderScene;
var
  i: integer;
  AnzFluegeli: integer;
  FlugelWinkel: single;
  omGlobal, omVLI: TMatrix;

  procedure DrawElement(const Koerper, Schnitt: TMultiTexturVAO);
  var
    m: TMatrix;
  begin
    if not (Koerper.Darstellung = aus) then begin
      Koerper.Draw;
      if Koerper.Darstellung = geschnitten then begin
        if Schnitt <> nil then begin
          Schnitt.Draw;
        end;
      end else begin
        m := OpenGL.Camera.ObjectMatrix;
        OpenGL.Camera.ObjectMatrix.Scale(-1.0, 1.0, 1.0);
        OpenGL.SwapFrontFace;
        Koerper.Draw;
        OpenGL.SwapFrontFace;
        OpenGL.Camera.ObjectMatrix := m;
      end;
    end;
  end;

  procedure MatScale(var mat: TMatrix; x, y, z: single);
  var
    i: integer;
  begin
    for i := 0 to 2 do begin
      mat[i, 0] *= x;
      mat[i, 1] *= y;
      mat[i, 2] *= z;
    end;
  end;


begin

  with OpenGL.Camera do begin

    omGlobal := ObjectMatrix;

    // --- VLI --- //

    with VLITeile do begin
      ObjectMatrix.Identity;
      ObjectMatrix.Translate(0, -TUrAnzeiger.AnzeigerMasse.StandRohr.L / 2, 0);
      omVLI := ObjectMatrix;


      // Flügeli

      if (Fluegeli.Darstellung = ganz) or (Fluegeli.Darstellung = geschnitten) then begin
        AnzFluegeli := Round((TUrAnzeiger.Anzeigermasse.StandRohr.L +
          TUrAnzeiger.AnzeigerMasse.Anzeigeschiene.Auslauf * 2) / 10);

        for i := 0 to anzFluegeli do begin
          FlugelWinkel := ((Niveau.Pegel + 50) / 10 - i) * 30 + 90;
          if FlugelWinkel > 180 then begin
            FlugelWinkel := 180;
          end;
          if FlugelWinkel < 0 then begin
            FlugelWinkel := 0;
          end;

          ObjectMatrix.Translate(0, i * 10 -
            TUrAnzeiger.AnzeigerMasse.Anzeigeschiene.Auslauf + 5.0,
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

          ObjectMatrix := omVLI;
        end;
      end;

      // AnzeigeSchiene

      ObjectMatrix.Translate(0, 0, TUrAnzeiger.AnzeigerMasse.StandRohr.AussenD / 2);
      DrawElement(AnzeigeSchiene, AnzeigeSchieneSchnitt);
      ObjectMatrix := omVLI;

      // Schwimmer

      ObjectMatrix.Translate(0, Niveau.Pegel, 0);
      DrawElement(Schwimmer, SchwimmerSchnitt);
      ObjectMatrix := omVLI;

      // StandRohr

      DrawElement(StandRohr, StandRohrSchnitt);

      // ArmaFlex

      DrawElement(ArmaFlex, ArmaFlexSchnitt);

      // Stutzen unten

      DrawElement(Stutzen, StutzenSchnitt);

      // Stutzen oben;

      ObjectMatrix.Translate(0.0, TUrAnzeiger.AnzeigerMasse.StandRohr.L, 0.0);
      DrawElement(Stutzen, StutzenSchnitt);
      ObjectMatrix := omVLI;

      // RohrFlansch unten

      ObjectMatrix.Translate(0.0, -TUrAnzeiger.AnzeigerMasse.StandRohr.C1, 0.0);
      DrawElement(RohrFlansch, RohrFlanschSchnitt);
      ObjectMatrix := omVLI;

      // RohrFlansch oben

      ObjectMatrix.RotateA(Pi);
      ObjectMatrix.Translate(0.0, TUrAnzeiger.AnzeigerMasse.StandRohr.L + TUrAnzeiger.AnzeigerMasse.StandRohr.C2, 0.0);
      DrawElement(RohrFlansch, RohrFlanschSchnitt);
      ObjectMatrix := omVLI;

      // ProcessFlansch unten

      ObjectMatrix.RotateA(Pi / 2);
      ObjectMatrix.Translate(0, 0, -TUrAnzeiger.AnzeigerMasse.Stutzen.t);
      DrawElement(ProcessFlansch, ProcessFlanschSchnitt);
      ObjectMatrix := omVLI;

      // ProcessFlansch oben

      ObjectMatrix.RotateA(Pi / 2);
      ObjectMatrix.Translate(0, TUrAnzeiger.AnzeigerMasse.StandRohr.L, -TUrAnzeiger.AnzeigerMasse.Stutzen.t);
      DrawElement(ProcessFlansch, ProcessFlanschSchnitt);
      ObjectMatrix := omVLI;

      // RohrFlanschDichtung unten

      ObjectMatrix.Translate(0.0, -TUrAnzeiger.AnzeigerMasse.StandRohr.C1 - 2.0, 0.0);
      DrawElement(DichtungRohrFlansch, DichtungRohrFlanschSchnitt);
      ObjectMatrix := omVLI;

      // RohrFlanschDichtung oben

      ObjectMatrix.RotateA(Pi);
      ObjectMatrix.Translate(0.0, TUrAnzeiger.AnzeigerMasse.StandRohr.L + TUrAnzeiger.AnzeigerMasse.StandRohr.C2 + 2.0, 0.0);
      DrawElement(DichtungRohrFlansch, DichtungRohrFlanschSchnitt);
      ObjectMatrix := omVLI;

      // ProcessFlanschDichtung unten

      ObjectMatrix.RotateA(Pi / 2);
      ObjectMatrix.Translate(0, 0, -TUrAnzeiger.AnzeigerMasse.Stutzen.t - 2.0);
      DrawElement(DichtungProcessFlansch, DichtungProcessFlanschSchnitt);
      ObjectMatrix := omVLI;

      // ProcessFlanschDichtuing oben

      ObjectMatrix.RotateA(Pi / 2);
      ObjectMatrix.Translate(0, TUrAnzeiger.AnzeigerMasse.StandRohr.L, -TUrAnzeiger.AnzeigerMasse.Stutzen.t - 2.0);
      DrawElement(DichtungProcessFlansch, DichtungProcessFlanschSchnitt);
      ObjectMatrix := omVLI;

      // WasserSchwimmer

      if (WasserSchwimmer.Darstellung = ganz) or
        (WasserSchwimmer.Darstellung = geschnitten) then begin
        ObjectMatrix.Translate(0, Niveau.Pegel, 0);

        if (StandRohr.Darstellung = geschnitten) or
          (Schwimmer.Darstellung = geschnitten) then begin
          WasserSchwimmer.Darstellung := geschnitten;
        end else begin
          WasserSchwimmer.Darstellung := ganz;
        end;

        DrawElement(WasserSchwimmer, WasserSchwimmerSchnitt);
        ObjectMatrix := omVLI;

        with TUrAnzeiger.AnzeigerMasse do begin
          ObjectMatrix.Scale(1.0, StandRohr.C1 + Niveau.Pegel -
            Schwimmer.AussenD / 2 - Schwimmer.AussenD * (Schwimmer.anzKugeln - 1),
            StandRohr.InnenD);
          ObjectMatrix.Translate(0.0, -StandRohr.C1, -StandRohr.InnenD / 2);
        end;
        WasserUnten.Draw;
      end;

      ObjectMatrix := omVLI;
    end;

    // --- Weltall --- //

    with All do begin
      Background.Draw([Textur]);
    end;

    // --- Globus --- //

    with Globus do begin
      Sphere.Camera.Enabled := False;

      ObjectMatrix := GlobusMatrix;
      ObjectMatrix.Translate(0.0, 0.0, -1.0);

      MatScale(ObjectMatrix, 1.5 * (ClientHeight / ClientWidth), 1.5, 0.01);
      //      ObjectMatrix.Scale(1.5 * (ClientHeight / ClientWidth), 1.5, 0.01);

      with EarthTextur do begin
        Sphere.Draw(Pos, Normal);
      end;

      ObjectMatrix := WolkenMatrix;
      ObjectMatrix.Translate(0.0, 0.0, -0.99);
      MatScale(ObjectMatrix, 1.5 * (ClientHeight / ClientWidth), 1.5, 0.01);
      //    ObjectMatrix.Scale(1.5 * (ClientHeight / ClientWidth), 1.5, 0.01);

      with CloudsTextur do begin
        Sphere.Draw(Pos, Normal);
      end;
      Sphere.Camera.Enabled := True;
    end;

    ObjectMatrix := omGlobal;

  end; // OpenGL.Camera

end;

procedure THauptForm.FormDestroy(Sender: TObject);
begin
  Timer1.Enabled := False;

  with All do begin
    Background.Free;
    Textur.Free;
  end;

  with Globus do begin
    Sphere.Free;

    with EarthTextur do begin
      Pos.Free;
      Normal.Free;
    end;
    with CloudsTextur do begin
      Pos.Free;
      Normal.Free;
    end;

    GlobusLighting.Free;
  end;

  with VLITeile do begin
    FreeAndNil(VLILighting);

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

    FreeAndNil(DichtungRohrFlansch);
    FreeAndNil(DichtungRohrFlanschSchnitt);
    FreeAndNil(DichtungProcessFlansch);
    FreeAndNil(DichtungProcessFlanschSchnitt);

    FreeAndNil(WasserSchwimmer);
    FreeAndNil(WasserSchwimmerSchnitt);
    FreeAndNil(WasserUnten);
  end;

  FreeAndNil(OpenGL);
end;

procedure THauptForm.FormResize(Sender: TObject);
begin
  OpenGL.Resize(ClientWidth, ClientHeight);

  OpenGL.Camera.Perspective(30, ClientWidth / ClientHeight, 0.3, 1000, -5, 1 / 150);
end;

procedure THauptForm.MenuItem10Click(Sender: TObject); inline;
begin
  AnzeigerOptionenForm.Show;
end;

procedure THauptForm.MenuItem2Click(Sender: TObject); inline;
begin
  Close;
end;

procedure THauptForm.MenuItem4Click(Sender: TObject); inline;
var
  FPC_Info: record
    Lazarus, FPC, OS, CPU: string
      end;

begin
  with FPC_Info do begin
    Lazarus := lcl_version;
    FPC := {$I %FPCVERSION%};
    OS := {$I %FPCTARGETOS%};
    CPU := {$I %FPCTARGETCPU%};
  end;
  with FPC_Info do begin
    ShowMessage('Copyright '#194#169' by M. Burkhard' + LineEnding + LineEnding + 'Compiliert mit Lazarus: ' +
      Lazarus + '   FPC: ' + FPC + LineEnding + 'OS: ' + OS + '   CPU: ' + CPU);
  end;
end;

procedure THauptForm.MenuItem7Click(Sender: TObject);

  procedure WriteData(pfad: string);

    procedure WriteTexturVertexData(const Koerper: TMultiTexturVAO);
    var
      stream: TFileStream;
    begin
      stream := TFileStream.Create(pfad + Koerper.Caption + '.bin', fmCreate);
      Koerper.SaveToStream(stream);
      stream.Free;
    end;

    procedure WriteBumpMapTexturVertexData(const Koerper: TBumpmappingTexturVAO);
    var
      stream: TFileStream;
    begin
      stream := TFileStream.Create(pfad + Koerper.Caption + '.bin', fmCreate);
      Koerper.SaveToStream(stream);
      stream.Free;
    end;

  var
    f: single;
    stream: TFileStream;

  begin
    DoDirSeparators(pfad);

    with VLITeile do begin
      //      WriteTexturVertexData(All.BackGround); Achtung Light muss auf true sein !
      WriteBumpMapTexturVertexData(Globus.Sphere);

      WriteTexturVertexData(Fluegeli);
      WriteTexturVertexData(AnzeigeSchiene);
      WriteTexturVertexData(AnzeigeSchieneSchnitt);

      WriteTexturVertexData(Schwimmer);
      WriteTexturVertexData(SchwimmerSchnitt);
      WriteTexturVertexData(StandRohr);
      WriteTexturVertexData(StandRohrSchnitt);
      WriteTexturVertexData(Stutzen);
      WriteTexturVertexData(StutzenSchnitt);
      WriteTexturVertexData(RohrFlansch);
      WriteTexturVertexData(RohrFlanschSchnitt);
      WriteTexturVertexData(ProcessFlansch);
      WriteTexturVertexData(ProcessFlanschSchnitt);

      WriteTexturVertexData(DichtungRohrFlansch);
      WriteTexturVertexData(DichtungRohrFlanschSchnitt);
      WriteTexturVertexData(DichtungProcessFlansch);
      WriteTexturVertexData(DichtungProcessFlanschSchnitt);

      WriteTexturVertexData(WasserSchwimmer);
      WriteTexturVertexData(WasserSchwimmerSchnitt);
      WriteTexturVertexData(WasserUnten);

    end;

    with TUrAnzeiger.AnzeigerMasse do begin
      stream := TFileStream.Create(Pfad + 'VLIMasse.bin', fmCreate);

      stream.Write(StandRohr.L, SizeOf(single));
      stream.Write(StandRohr.C1, SizeOf(single));
      stream.Write(StandRohr.C2, SizeOf(single));
      stream.Write(Stutzen.t, SizeOf(single));

      f := StandRohr.L + 100;          // Schienenlänge;
      stream.Write(f, SizeOf(single));

      stream.Write(StandRohr.AussenD, SizeOf(single));
      stream.Write(StandRohr.InnenD, SizeOf(single));
      stream.Write(Schwimmer.anzKugeln, SizeOf(int32));
      stream.Write(Schwimmer.AussenD, SizeOf(single));

      stream.Free;
    end;
  end;

begin
  WriteData('..\..\..\NetBeans\JavaScript\Niveau-Anzeiger\public_html\data\');
  WriteData('..\..\..\eclipse\Android\OpenGL\Ur - Anzeiger\Niveau-Anzeiger\assets\');
end;


procedure THauptForm.MenuItem15Click(Sender: TObject);
begin
  ShowMessage(OpenGL.GetVersion);
end;

procedure THauptForm.MenuItemSpeichernClick(Sender: TObject);
var
  Picture: TPicture;
begin
  Picture := TPicture.Create;
  with Picture do begin
    Bitmap.PixelFormat := pf32bit;
    Bitmap.Width := ClientWidth;
    Bitmap.Height := ClientHeight;
    //      glBindFramebuffer(GL_FRAMEBUFFER, FramebufferName);
    glBindFramebuffer(GL_FRAMEBUFFER, 0);
    glReadPixels(0, 0, ClientWidth, ClientHeight, GL_RGBA, GL_UNSIGNED_BYTE, Bitmap.RawImage.Data);

    SaveToFile('test.png');
  end;
  Picture.Free;
end;

procedure THauptForm.MenuItem_LichtsteuerungClick(Sender: TObject);
begin
  GlobusLighting.Show;
  VLILighting.Show;
end;

procedure THauptForm.SteuerungClick(Sender: TObject);
begin
  CameraSteuerung.Show;
end;

procedure THauptForm.MenuDarstellungClick(Sender: TObject);
begin
  Darstellung1.Show;
end;

procedure THauptForm.Timer1Timer(Sender: TObject);
begin
  OpenGL.Clear;

  with Niveau do begin
    if Niveau.Richtung = oben then begin
      Pegel += 1;
      if Pegel > TUrAnzeiger.AnzeigerMasse.StandRohr.L + 20 then begin
        Pegel := TUrAnzeiger.AnzeigerMasse.StandRohr.L + 20;
        Richtung := unten;
      end;
    end else begin
      Pegel -= 1;
      if Pegel < -20 then begin
        Pegel := -20;
        Richtung := oben;
      end;
    end;
  end;

  with Globus do begin
    WolkenMatrix.RotateB(Pi / 800);
    GlobusMatrix.RotateB(Pi / 700);
  end;

  //    MatrixModif.RotateY(OpenGL.Camera.WorldMatrix, Pi / 199);
  //    MatrixModif.Rotatez(OpenGL.Camera.WorldMatrix, Pi / 2234);

  RenderScene;

  OpenGL.SwapBuffers;
end;

end.
