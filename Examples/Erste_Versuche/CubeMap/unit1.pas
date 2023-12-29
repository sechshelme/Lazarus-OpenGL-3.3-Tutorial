unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Graphics,
  Forms, types, Controls, ComCtrls,
  Dialogs,
  ExtCtrls, FileUtil, LazUTF8,
  Buttons, StdCtrls, OpenGLContext,
  oglVector, oglMatrix, oglShader,
  oglColorKoerper,
  oglUnit,
  oglSteuerung, oglTextur,
  oglTexturKoerper,
  oglKoerper,
  oglBackGround,

  TexturCubeMap;

type

  { TForm1 }

  TForm1 = class(TForm)
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private   { private declarations }
    OpenGL: TOpenGL;

    Sphere: TSphereCubeMapMultiTexturVAO;
    Box: TBoxCubeMapMultiTexturVAO;

    texKiste: TCubeTexturBuffer;
    texBackGround: TTexturBuffer;

    MyBackGround: TBackGround;

    procedure InitScene;
    procedure RenderScene;
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }


procedure TForm1.InitScene;

  function ResourceToPicture(Resource: string): TPicture;
  var
    rs: TResourceStream;
  begin

    rs := TResourceStream.Create(HINSTANCE, Resource, RT_RCDATA);
    try
      Result := TPicture.Create;
      Result.LoadFromStream(rs);
    finally
      rs.Free;
    end;
  end;

var
  Pic: TPicture;
const
  amb = 5.0;

begin

  texBackGround := TTexturBuffer.Create;
  texKiste := TCubeTexturBuffer.Create;


  //  Pic := ResourceToPicture('WORLD_CUBE_NET');
  Pic := ResourceToPicture('CUBIC');
  texKiste.LoadTextures(Pic.Bitmap.RawImage);
  Pic.Free;

  Pic := ResourceToPicture('WALD');
  texBackGround.LoadTextures(Pic.Bitmap.RawImage);
  Pic.Free;

  Sphere := TSphereCubeMapMultiTexturVAO.Create(1);
  Sphere.LightingShader.LightParams.ambient := vec4(amb, amb, amb, 1.0);
  Sphere.LightingShader.UpdateLight;
  Sphere.WriteVertex;


  Box := TBoxCubeMapMultiTexturVAO.Create(1);
  Box.LightingShader.LightParams.ambient := vec4(amb, amb, amb, 1.0);
  Box.LightingShader.UpdateLight;
  Box.WriteVertex;


  MyBackGround := TBackGround.Create(1);
  //  MyBackGround.SetTexCoord(3, 4);
  MyBackGround.WriteVertex;
end;

procedure TForm1.RenderScene;
var
  m: TMatrix;
begin
  OpenGL.Clear;
  //  OpenGL.AlphaBlending(False); // ----------------------

  with  OpenGL.Camera do begin
    m := ObjectMatrix;

    // MyBackGround

    MyBackGround.Draw(texBackGround);


    // Box

//    ObjectMatrix.Translate(40.0, 0.0, 0.0);
    ObjectMatrix.Scale(40.0);
    Box.Draw(texKiste);

    // Sphere;

    ObjectMatrix := m;

//    ObjectMatrix.Translate(-40.0, 0.0, 0.0);
    ObjectMatrix.Scale(40.0);
//    Sphere.Draw(texKiste);

    ObjectMatrix := m;
  end;

  OpenGL.SwapBuffers;
end;


procedure TForm1.FormCreate(Sender: TObject);
begin
  OpenGL := TOpenGL.Create(Self);
  OpenGL.Camera.SetCameraMatrixTransform(False);
  InitScene;
  Timer1.Enabled := True;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  OpenGL.Free;

  Box.Free;
  Sphere.Free;
  texBackGround.Free;
  texKiste.Free;
end;


procedure TForm1.FormResize(Sender: TObject);
begin
  OpenGL.Resize(ClientWidth, ClientHeight);
  OpenGL.Camera.Perspective(30, ClientWidth / ClientHeight, 0.01, 700, -50.0, 0.2);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  RenderScene;
end;

end.
