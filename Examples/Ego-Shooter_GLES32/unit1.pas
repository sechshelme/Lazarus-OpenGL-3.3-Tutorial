unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes,
  Forms,
  ExtCtrls,
  StdCtrls,
  SysUtils, FileUtil,  LConvEncoding,
  LCLType, Dialogs, Buttons,
  Baum,
  {$ifdef GLES32}
  oglglad_GLES32,
  {$else}
  oglglad_gl,
  {$endif}
  BGRABitmapTypes,
  oglVector, oglMatrix, oglShader, oglLighting,
  oglUnit, oglKoerper,
  oglTexturKoerper, oglTextur,
  oglBackGround, oglFontTextur;

type
  TLabyrint = record
    Width, Height: integer;
    Data: array of String;
  end;

  { TForm1 }

  TForm1 = class(TForm)
    ImageTextur: TImage;
    ImageNormale: TImage;
    ImageWand1: TImage;
    ImageWand2: TImage;
    Kiste: TImage;
    ImageBackground: TImage;
    ImageLicht: TImage;
    ImageBoden: TImage;
    Label1: TLabel;
    Panel1: TPanel;
    Timer1: TTimer;
    procedure FormKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure FormKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure Info;
    procedure Pruefen(var x, y: single);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: integer);
    procedure FormResize(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    Keys: array[0..255] of boolean;
    OpenGL: TOpenGL;

    Lighting: TLighting;

    TexturBox0, TexturBox1, TexturBox2, TexturBox3: TTexturBox;
    TexturBoxBoden: TBumpmappingTexturBox;

    //    Box: TCube;
    MyBackGround: TBackGround;
    Baum: TBaum;

    FontQuadRextur: TFontTextur;

    TexurBuffer: record
      texrot, texBackGround, BodenTextur, BodenNormale, texWand1, texWand2, texImage3, texLicht, texBoden, texBaum: TTexturBuffer;
    end;


    RenderTexturBuffer: TRenderTexturBuffer;
    RenderTexturBuffer2: TRenderTexturBuffer;

    Labyrint: TLabyrint;

    Ich: record
      Winkel: single;
      Pos: record
        x, y: single;
      end;
      Schritt: single;
    end;

    procedure InitScene;
    procedure RenderScene;
    procedure Up;
    procedure Down;
    procedure Left;
    procedure Right;
    procedure RotLeft;
    procedure RotRight;
  end;

var
  Form1: TForm1;


implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.InitScene;
begin
  with TexurBuffer do begin
    texBackGround := TTexturBuffer.Create;
    texBackGround.TexParameter.Add(GL_TEXTURE_WRAP_S, GL_MIRRORED_REPEAT);
    texBackGround.TexParameter.Add(GL_TEXTURE_WRAP_T, GL_MIRRORED_REPEAT);
    //    texBackGround.LoadTextures('wald.png');
    texBackGround.LoadTextures(ImageBackground.Picture.Bitmap.RawImage);

    texrot := TTexturBuffer.Create;
    texrot.LoadTextures(3, 2, [$FF0000FF, $FFFFFFFF, $FF0000FF, $FF000000, $FF0FF000, $FF000000]);

    BodenTextur := TTexturBuffer.Create;
    BodenTextur.LoadTextures(ImageTextur.Picture.Bitmap.RawImage);

    BodenNormale := TTexturBuffer.Create;
    BodenNormale.LoadTextures(ImageNormale.Picture.Bitmap.RawImage);

    texWand1 := TTexturBuffer.Create;
    texWand1.LoadTextures('rinde.jpg');

    texWand2 := TTexturBuffer.Create;
    texWand2.LoadTextures('Mauer2.bmp');

    texImage3 := TTexturBuffer.Create;
    texImage3.LoadTextures(Kiste.Picture.Bitmap.RawImage);

    texLicht := TTexturBuffer.Create;
    texLicht.LoadTextures(ImageLicht.Picture.Bitmap.RawImage);

    texBoden := TTexturBuffer.Create;
    texBoden.LoadTextures(ImageBoden.Picture.Bitmap.RawImage);

    texBaum := TTexturBuffer.Create;
    texBaum.TexParameter.Add(GL_TEXTURE_MAG_FILTER, GL_NEAREST);
    texBaum.TexParameter.Add(GL_TEXTURE_MIN_FILTER, GL_NEAREST);
    texBaum.LoadTextures('grass.png');
  end;

  TexturBox0 := TTexturBox.Create(0, True);
  TexturBox1 := TTexturBox.Create(1, True);
  TexturBox2 := TTexturBox.Create(2, True);
  TexturBox3 := TTexturBox.Create(3, True);

  TexturBoxBoden := TBumpmappingTexturBox.Create(True);

  TexturBox0.Color := vec4(0, 0, 1, 1);
  TexturBox0.WriteVertex;
  TexturBox1.WriteVertex;
  TexturBox2.WriteVertex;
  TexturBox3.WriteVertex;

//  TexturBoxBoden.LightingShader.MaterialParams.emission := vec4(1, 1, 1, 1);
  TexturBoxBoden.LightingShader.UpdateMaterial;
  TexturBoxBoden.WriteVertex;

  Baum := TBaum.Create(1, True);
  Baum.WriteVertex;

  Lighting := TLighting.Create;
  Lighting.Add(TexturBox0);
  Lighting.Add(TexturBox1);
  Lighting.Add(TexturBox2);
  Lighting.Add(TexturBox3);
  Lighting.Add(TexturBoxBoden);
  Lighting.Add(Baum);

  RenderTexturBuffer := TRenderTexturBuffer.Create(2048, 2048);
  RenderTexturBuffer2 := TRenderTexturBuffer.Create(512, 512);

  FontQuadRextur := TFontTextur.Create(False);
  FontQuadRextur.Font.Name := 'Arial';
  FontQuadRextur.Font.Size := 48;
  FontQuadRextur.Font.Color := $FF;


  with FontQuadRextur.Font do begin
    Color := 0;
    Height := 0;
  end;

  FontQuadRextur.SetBKColor(BGRA($00, $FF, $00, $80));
  FontQuadRextur.SetGradientColor(BGRA($FF, $00, $00), BGRA($00, $00, $FF));
  FontQuadRextur.gradient := True;

  FontQuadRextur.WriteVertex;

  MyBackGround := TBackGround.Create(1);
  MyBackGround.WriteVertex;

  with Ich do begin
    Winkel := 0.0;
    Pos.x := 4.0;
    Pos.y := 1.0;
    Schritt := 0.01;
  end;

  Lighting.Setposition(vec4(0.0, 0.0, -1.0, 0.0));
  Lighting.Update;
end;

procedure TForm1.RenderScene;
var
  x: integer;
  y: integer;
  IchMatrix: record
    Dreh: TMatrix;
    Trans: TMatrix;
  end;

begin
  //  Text-Cube rendern

  RenderTexturBuffer.Clear;

  with  RenderTexturBuffer.Camera do begin
    ObjectMatrix.Identity;
    ObjectMatrix.Translate(-1.0, -1.0, 0.0);
    ObjectMatrix.Scale(0.2);

    FontQuadRextur.Draw('X: ' + FloatToStr(Ich.Pos.x));
    MyBackGround.Draw(TexurBuffer.texWand1);
  end;


  RenderTexturBuffer2.Clear;

  with  RenderTexturBuffer2.Camera do begin
    ObjectMatrix.Identity;
    ObjectMatrix.Translate(-1.0, -1.0, 0.0);
    ObjectMatrix.Scale(0.4);

    FontQuadRextur.Draw('Y: ' + FloatToStr(Ich.Pos.y));
    MyBackGround.Draw(TexurBuffer.texBackGround);
  end;


  // Level rendern

  OpenGL.Clear;

  MyBackGround.Draw(TexurBuffer.texBackGround);

  IchMatrix.Dreh.Identity;
  IchMatrix.Trans.Identity;

  IchMatrix.Trans.Translate(Ich.Pos.x, 0.0, -Ich.Pos.y);
  IchMatrix.Dreh.RotateB(Ich.Winkel + Pi);

  IchMatrix.Dreh := IchMatrix.Dreh * IchMatrix.Trans;

  with Labyrint, OpenGL.Camera, TexurBuffer do begin
    for x := 0 to Width do begin
      for y := 0 to Height do begin
        ObjectMatrix.Identity;
        ObjectMatrix.Translate(-Width + (Width - x), 0, y);
//        ObjectMatrix.Multiply(IchMatrix.Dreh, ObjectMatrix);
        ObjectMatrix := IchMatrix.Dreh * ObjectMatrix;

        if Data[y, x+1] <> '0' then begin

          case Data[y, x+1] of
            '1': begin
              TexturBox2.Draw([texWand1, texLicht]);
            end;
            '2': begin
              TexturBox3.Draw([texWand2, texLicht, texrot]);
            end;
            '3': begin
              TexturBox2.Draw([texImage3, texLicht]);
            end;
            '4': begin
              TexturBox2.Draw([RenderTexturBuffer.TexturBuffer, texLicht]);
            end;
            '5': begin
              TexturBox2.Draw([RenderTexturBuffer2.TexturBuffer, texLicht]);
            end;
          end;
        end;

        // Boden

        OpenGL.Camera.ObjectMatrix.Translate(0, -1, 0);

        TexturBoxBoden.Draw(BodenTextur, BodenNormale);
      end;
    end;
    for x := 0 to Width do begin      // Aplha
      for y := 0 to Height do begin
        if Data[y, x+1] <> '0' then begin
          ObjectMatrix.Identity;
          ObjectMatrix.Translate(-Width + (Width - x), 0.5, y);
          ObjectMatrix := IchMatrix.Dreh * ObjectMatrix;

          case Data[y, x+1] of
            'b': begin
              Baum.Draw(texBaum);
            end;
          end;
        end;
      end;
    end;

    // Hub - Anzeige

    Enabled := False;
    ObjectMatrix.Identity;
    ObjectMatrix.Translate(-1.0, -1.0, +0.9999);
    ObjectMatrix.Scale(0.2);

    FontQuadRextur.Draw(CP437ToUTF8(#237)+ 'öööDoomäöüDoom');
    Enabled := True;
  end;

  OpenGL.SwapBuffers;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Width := 800;
  Height := 600;
  OpenGL := TOpenGL.Create(Self);
  OpenGL.AlphaBlending(True);
  InitScene;
  with Labyrint do begin
    Width := 8;
    Height := 15;
//    SetLength(Data, Height + 1, Width + 1);
    SetLength(Data, Height + 1);
    Data[15] := '111111111';
    Data[14] := '100030001';
    Data[13] := '100000001';
    Data[12] := '100203001';
    Data[11] := '100000001';
    Data[10] := '100202001';
    Data[09] := '100000001';
    Data[08] := '100000001';
    Data[07] := '100030001';
    Data[06] := '100000001';
    Data[05] := '100203001';
    Data[04] := '100000001';
    Data[03] := '4002b2001';
    Data[02] := '50b000b01';
    Data[01] := '400000001';
    Data[00] := '111111111';
  end;
  Timer1.Enabled := True;
end;

procedure TForm1.Info;

  function f(s: single): string; inline;
  begin
    Result := FloatToStrF(s, ffNumber, 6, 3);
  end;

begin
  with Ich do begin
    Label1.Caption := 'X: ' + f(Pos.x) + '  Y: ' + f(Pos.y) + '  W: ' + f(Winkel);
  end;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  TexturBox0.Free;
  TexturBox1.Free;
  TexturBox2.Free;
  TexturBox3.Free;

  TexturBoxBoden.Free;

  MyBackGround.Free;
  FontQuadRextur.Free;
  Baum.Free;

  with TexurBuffer do begin
    BodenTextur.Free;
    BodenNormale.Free;
    texWand1.Free;
    texWand2.Free;
    texImage3.Free;
    texLicht.Free;
    texBoden.Free;
    texBackGround.Free;
    texBaum.Free;
    texrot.Free;
  end;

  Lighting.Free;

  RenderTexturBuffer.Free;
  RenderTexturBuffer2.Free;
  OpenGL.Free;
end;

procedure TForm1.FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: integer);
begin
  if (x < Panel1.Width) and (y < Panel1.Height) then begin
    Panel1.Visible := True;
  end else begin
    Panel1.Visible := False;
  end;
end;

procedure TForm1.FormResize(Sender: TObject);
begin
  OpenGL.Resize(ClientWidth, ClientHeight);

  OpenGL.Camera.Perspective(60, ClientWidth / ClientHeight, 0.01, 700, 0.0, 1.0);
end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  Keys[Key] := True;
  if Key = VK_MENU then begin
    Key := 0;
  end;
end;

procedure TForm1.FormKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  Keys[Key] := False;
  if Key = VK_MENU then begin
    Key := 0;
  end;
end;

procedure TForm1.Pruefen(var x, y: single);
const
  Abstand = 0.4;
begin
  with Labyrint do begin
    // Y+
    if Data[Trunc(y) + 1, Round(x)] <> '0' then begin
      if Frac(y) > Abstand then begin
        y := Trunc(y) + Abstand;
      end;
    end;
    // Y-
    if Data[Trunc(y), Round(x)] <> '0' then begin
      if Frac(y) < 1.0 - Abstand then begin
        y := Trunc(y) + 1.0 - Abstand;
      end;
    end;
    // X+
    if Data[Round(y), Trunc(x) + 1] <> '0' then begin
      if Frac(x) > Abstand then begin
        x := Trunc(x) + Abstand;
      end;
    end;
    // X-
    if Data[Round(y), Trunc(x)] <> '0' then begin
      if Frac(x) < 1.0 - Abstand then begin
        x := Trunc(x) + 1.0 - Abstand;
      end;
    end;
  end;
end;

procedure TForm1.Up;
begin
  with Ich do begin
    Pos.x -= sin(Winkel) * Schritt;
    Pos.y += cos(Winkel) * Schritt;
    Pruefen(Pos.x, Pos.y);
  end;
end;

procedure TForm1.Down;
begin
  with Ich do begin
    Pos.x += sin(Winkel) * Schritt;
    Pos.y -= cos(Winkel) * Schritt;
    Pruefen(Pos.x, Pos.y);
  end;
end;

procedure TForm1.Left;
begin
  with Ich do begin
    Pos.x -= sin(Winkel + Pi / 2) * Schritt;
    Pos.y += cos(Winkel + Pi / 2) * Schritt;
    Pruefen(Pos.x, Pos.y);
  end;
end;

procedure TForm1.Right;
begin
  with Ich do begin
    Pos.x -= sin(Winkel - Pi / 2) * Schritt;
    Pos.y += cos(Winkel - Pi / 2) * Schritt;
    Pruefen(Pos.x, Pos.y);
  end;
end;

procedure TForm1.RotLeft;
begin
  with Ich do begin
    Winkel += Pi * (Schritt / 5);
    if Winkel > Pi * 2 then begin
      Winkel -= Pi * 2;
    end;
  end;
end;

procedure TForm1.RotRight;
begin
  with Ich do begin
    Winkel -= Pi * (Schritt / 5);
    if Winkel < 0 then begin
      Winkel += Pi * 2;
    end;
  end;
end;


procedure TForm1.Timer1Timer(Sender: TObject);
begin
  if Keys[VK_SHIFT] then begin
    Ich.Schritt := 0.03;
  end else begin
    Ich.Schritt := 0.01;
  end;
  if Keys[VK_LEFT] then begin
    if Keys[VK_MENU] then begin
      Left;
    end else begin
      RotLeft;
    end;
  end;
  if Keys[VK_RIGHT] then begin
    if Keys[VK_MENU] then begin
      Right;
    end else begin
      RotRight;
    end;
  end;
  if Keys[VK_UP] then begin
    Up;
  end;
  if Keys[VK_DOWN] then begin
    Down;
  end;
  if Keys[VK_C] then begin
    TexturBox0.Color.FromInt(Random($FFFFFF) + $FF000000);
  end;
  RenderScene;
  Info;
end;

end.
