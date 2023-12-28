unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes,
  Forms,
  Dialogs,
  ExtCtrls,
  Buttons, StdCtrls, Graphics, ComCtrls,
  OpenGLContext,
  dglOpenGL, BGRABitmap, BGRABitmapTypes,
  oglUnit,
  oglVector, oglMatrix, oglShader,
  oglColorKoerper,
  oglSteuerung, oglTextur,
  oglTexturKoerper,
  oglKoerper,
  oglBackground;

type

  { TForm1 }

  TForm1 = class(TForm)
    ImageCloudsTextur: TImage;
    ImageCloudsNormal: TImage;
    ImageGlobusNormal: TImage;
    ImageGlobusPos: TImage;
    ImageBackground: TImage;
    OpenDialog1: TOpenDialog;
    SpeedButton1: TSpeedButton;
    Timer1: TTimer;
    ToolBar1: TToolBar;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: char);
    procedure FormResize(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private   { private declarations }
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

      BackGround: TBackGround;
    end;


    procedure InitScene;
    procedure RenderScene;
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }


procedure TForm1.InitScene;

  procedure SetTextPara(tex: TTexturBuffer);
  begin
    tex.TexParameter.Add(GL_TEXTURE_WRAP_S, GL_REPEAT);
    tex.TexParameter.Add(GL_TEXTURE_WRAP_T, GL_REPEAT);
    tex.TexParameter.Add(GL_TEXTURE_MAG_FILTER, GL_LINEAR_MIPMAP_LINEAR);
    tex.TexParameter.Add(GL_TEXTURE_MIN_FILTER, GL_LINEAR_MIPMAP_LINEAR);
  end;

begin

  with Globus do begin
    GlobusMatrix.Identity;
    WolkenMatrix.Identity;

    with EarthTextur do begin
      Pos := TTexturBuffer.Create;
      SetTextPara(Pos);
      Pos.LoadTextures(ImageGlobusPos.Picture.Bitmap.RawImage);
      Normal := TTexturBuffer.Create;
      SetTextPara(Normal);
      Normal.LoadTextures(ImageGlobusNormal.Picture.Bitmap.RawImage);
    end;

    with CloudsTextur do begin
      Pos := TTexturBuffer.Create;
      SetTextPara(Pos);
      Pos.LoadTextures(ImageCloudsTextur.Picture.Bitmap.RawImage);
      Normal := TTexturBuffer.Create;
      SetTextPara(Normal);
      Normal.LoadTextures(ImageCloudsNormal.Picture.Bitmap.RawImage);
    end;

    Sphere := TBumpmappingTexturSphere.Create(True);
    Sphere.LightingShader.SetMaterial('PlasticWhite');
    Sphere.LightingShader.MaterialParams.ambient := vec4(0.4, 0.4, 0.4, 1.0);
    Sphere.LightingShader.UpdateMaterial;
    Sphere.Sektoren := 64;
    Sphere.WriteVertex;
  end;

  with All do begin
    Textur := TTexturBuffer.Create;
    Textur.LoadTextures(ImageBackground.Picture.Bitmap.RawImage);

    BackGround := TBackGround.Create(1);
    //    BackGround.SetTexCoord(3, 4);
    BackGround.WriteVertex;
  end;

  OpenGL.Camera.Scale(0.2);
end;

procedure TForm1.RenderScene;
var
  m: TMatrix;
begin
  OpenGL.Clear;

  with OpenGL.Camera do begin

    //    glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);


    // MyBackGround;

    with All do begin
      BackGround.Draw([Textur]);
    end;

    m := ObjectMatrix;

    // Kugel

    with Globus do begin
      ObjectMatrix := GlobusMatrix;
      ObjectMatrix.Scale(8.0);

      with EarthTextur do begin
        Sphere.Draw(Pos, Normal);
      end;

      ObjectMatrix := WolkenMatrix;

      ObjectMatrix.Scale(8.0);
      ObjectMatrix.Scale(1.01);

      with CloudsTextur do begin
        Sphere.Draw(Pos, Normal);
      end;
    end;

    ObjectMatrix := m;
  end;

  OpenGL.SwapBuffers;
end;


procedure TForm1.FormCreate(Sender: TObject);
begin
  OpenGL := TOpenGL.Create(Self);
  OpenGL.AlphaBlending(True);
  OpenGL.Camera.MouseMoveStep := 0.005;
  //  InitOpenGLDebug;
  InitScene;
  Timer1.Enabled := True;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  OpenGL.Free;


  with All do begin
    BackGround.Free;
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

  end;
end;


procedure TForm1.FormKeyPress(Sender: TObject; var Key: char);
begin
  OpenGL.Camera.ModifKey(Key);
end;

procedure TForm1.FormResize(Sender: TObject);
begin
  OpenGL.Resize(ClientWidth, ClientHeight);
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
  Globus.Sphere.LightingShader.LightParams.position := vec4(-50 + Random(100), -50 + Random(100), -50 + Random(100), 0.0);
  Globus.Sphere.LightingShader.UpdateLight;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  with Globus do begin
    WolkenMatrix.RotateB(Pi / 800);
    //  WolkenMatrix.RotateA(Pi / 8900);
    GlobusMatrix.RotateB(Pi / 700);
  end;

  RenderScene;
end;

end.
