unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, StdCtrls, OpenGLContext,
  dglOpenGL, oglShader, oglMatrix, oglTextur, oglVBO;

type

  { TForm1 }

  TForm1 = class(TForm)
    Image1: TImage;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private   { private declarations }
    OpenGLControl: TOpenGLControl;

    uiVAO: array[0..2] of glUINT;

    WorldMatrix_id, TexMatrix_id0, TexMatrix_id1: GLint;

    texture0, texture1: TTexturBuffer;

    WorldMatrix: TMatrix;
    TexturMatrix0, TexturMatrix1: TMatrix2D;

    texVBO: TVBO_Triangles2D;
    PosVBO: TVBO_Triangles;

    anzVertex: cardinal;

    procedure InitScene;
    procedure RenderScene;
  public        { public declarations }
    Shader: TShader;
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

const
  Quad: array[0..1] of Tmat3x3 =
    (((-0.8, -0.8, 0.0), (0.8, 0.8, 0.0), (-0.8, 0.8, 0.0)),
    ((-0.8, -0.8, 0.0), (0.8, -0.8, 0.0), (0.8, 0.8, 0.0)));

  QuadTextureVertex0: array[0..1] of Tmat3x2 =
    (((0.0, 0.0), (7.0, 7.0), (0.0, 7.0)),
    ((0.0, 0.0), (7.0, 0.0), (7.0, 7.0)));


procedure TForm1.InitScene;
const
  ia: array[0..1] of integer = (0, 1);
var
  aIcon: TIcon;
  aPicture: TPicture;
begin
  glClearColor(0.0, 0.5, 1.0, 1.0);

  glEnable(GL_DEPTH_TEST);
  glDepthFunc(GL_LESS);

  glEnable(GL_BLEND);
  glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);


  // ------------ Shader inizialisieren -------

  Shader := TShader.Create([FileToStr('shader.glsl')]);
  with Shader do begin
    WorldMatrix_id := UniformLocation('Matrix');
    TexMatrix_id0 := UniformLocation('TexMatrix0');
    TexMatrix_id1 := UniformLocation('TexMatrix1');
  end;
  glUniform1iv(Shader.UniformLocation('Sampler0'), 2, ia);


  // ------------ Vectoren laden --------------

  glGenVertexArrays(1, uiVAO);
  glBindVertexArray(uiVAO[0]);

  anzVertex := texVBO.LoadVertexBuffer(10);
  PosVBO.LoadVertexBuffer(0);


  // ------------ Texturen laden --------------

  with texture0 do begin
    aPicture := TPicture.Create;
    aPicture.LoadFromFile('40.png');
    TexParameter.Add(GL_TEXTURE_WRAP_S, GL_MIRRORED_REPEAT);
    TexParameter.Add(GL_TEXTURE_WRAP_T, GL_MIRRORED_REPEAT);
    LoadTextures(aPicture.Bitmap.RawImage);
    aPicture.Free;
  end;

  with texture1 do begin
    aIcon := TIcon.Create;
    aIcon.LoadFromFile('project1.ico');
    aIcon.Current := 5;
    TexParameter.Add(GL_TEXTURE_WRAP_S, GL_MIRRORED_REPEAT);
    TexParameter.Add(GL_TEXTURE_WRAP_T, GL_MIRRORED_REPEAT);
    LoadTextures(aIcon.RawImage);
    aIcon.Free;
  end;

end;

procedure TForm1.RenderScene;
begin
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);

  glEnable(GL_CULL_FACE);
  glCullface(GL_BACK);

  texture0.ActiveAndBind(0);
  texture1.ActiveAndBind(1);

  glBindVertexArray(uiVAO[0]);

  WorldMatrix.Uniform(WorldMatrix_id);

  TexturMatrix0.Uniform(TexMatrix_id0);
  TexturMatrix1.Uniform(TexMatrix_id1);

  glDrawArrays(GL_Triangles, 0, anzVertex);

  OpenGLControl.SwapBuffers;
end;


procedure TForm1.FormCreate(Sender: TObject);
begin
  OpenGLControl := TOpenGLControl.Create(Self);
  with OpenGLControl do begin
    Parent := Self;
    Align := alClient;
    OpenGLMajorVersion := 3;
    OpenGLMinorVersion := 3;
    AutoResizeViewport := True;
    InitOpenGL;
    MakeCurrent;
    ReadExtensions;
    ReadImplementationProperties;
  end;

  WorldMatrix := TMatrix.Create;
  TexturMatrix0 := TMatrix2D.Create;
  TexturMatrix0.Scale(0.35);
  TexturMatrix1 := TMatrix2D.Create;
  texture0 := TTexturBuffer.Create;
  texture1 := TTexturBuffer.Create;

  texVBO := TVBO_Triangles2D.Create;
  texVBO.Add(QuadTextureVertex0);

  PosVBO := TVBO_Triangles.Create;
  PosVBO.Add(Quad);

  InitScene;

  Timer1.Enabled := True;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  glDeleteVertexArrays(1, @uiVAO);

  OpenGLControl.Free;
  Shader.Free;
  WorldMatrix.Free;
  TexturMatrix0.Free;
  TexturMatrix1.Free;

  texture0.Free;
  texture1.Free;

  texVBO.Free;
  PosVBO.Free;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  WorldMatrix.RotateC(Pi / 200);

  TexturMatrix0.Rotate(Pi / 1100);
  TexturMatrix1.Rotate(Pi / 2000);
  RenderScene;
end;

end.
