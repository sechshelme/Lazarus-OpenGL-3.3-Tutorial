unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes,
  SysUtils,
  FileUtil,
  OpenGLContext,
  Forms,
  Controls,
  Graphics,
  Dialogs,
  ExtCtrls,
  StdCtrls,
  dglOpenGL,
  oglShader,
  oglVector, oglMatrix, oglTextur;

type

  { TForm1 }

  TForm1 = class(TForm)
    Image1: TImage;
    Image2: TImage;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private   { private declarations }
    OpenGLControl: TOpenGLControl;
    procedure InitScene;
    procedure RenderScene;
  public        { public declarations }
    Shader: TShader;

    Textur: array[0..1] of TTexturBuffer;
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

type
  TTRiangle = array[0..11] of Tmat3x3;

const
  Triangle: TTRiangle =
    (((-0.5, 0.5, 0.5), (-0.5, -0.5, 0.5), (0.5, -0.5, 0.5)), ((-0.5, 0.5, 0.5), (0.5, -0.5, 0.5), (0.5, 0.5, 0.5)),
    ((0.5, 0.5, 0.5), (0.5, -0.5, 0.5), (0.5, -0.5, -0.5)), ((0.5, 0.5, 0.5), (0.5, -0.5, -0.5), (0.5, 0.5, -0.5)),
    ((0.5, 0.5, -0.5), (0.5, -0.5, -0.5), (-0.5, -0.5, -0.5)), ((0.5, 0.5, -0.5), (-0.5, -0.5, -0.5), (-0.5, 0.5, -0.5)),
    ((-0.5, 0.5, -0.5), (-0.5, -0.5, -0.5), (-0.5, -0.5, 0.5)), ((-0.5, 0.5, -0.5), (-0.5, -0.5, 0.5), (-0.5, 0.5, 0.5)),
    // oben
    ((0.5, 0.5, 0.5), (0.5, 0.5, -0.5), (-0.5, 0.5, -0.5)), ((0.5, 0.5, 0.5), (-0.5, 0.5, -0.5), (-0.5, 0.5, 0.5)),
    // unten
    ((-0.5, -0.5, 0.5), (-0.5, -0.5, -0.5), (0.5, -0.5, -0.5)), ((-0.5, -0.5, 0.5), (0.5, -0.5, -0.5), (0.5, -0.5, 0.5)));

  TriangleTextureVertex0: array[0..11] of Tmat3x2 =
    (((0.0, 5.0), (0.0, 0.0), (5.0, 0.0)), ((0.0, 5.0), (5.0, 0.0), (5.0, 5.0)),
    ((0.0, 5.0), (0.0, 0.0), (5.0, 0.0)), ((0.0, 5.0), (5.0, 0.0), (5.0, 5.0)),
    ((0.0, 5.0), (0.0, 0.0), (5.0, 0.0)), ((0.0, 5.0), (5.0, 0.0), (5.0, 5.0)),
    ((0.0, 5.0), (0.0, 0.0), (5.0, 0.0)), ((0.0, 5.0), (5.0, 0.0), (5.0, 5.0)),
    ((0.0, 5.0), (0.0, 0.0), (5.0, 0.0)), ((0.0, 5.0), (5.0, 0.0), (5.0, 5.0)),
    ((0.0, 5.0), (0.0, 0.0), (5.0, 0.0)), ((0.0, 5.0), (5.0, 0.0), (5.0, 5.0)));

  TriangleTextureVertex1: array[0..11] of Tmat3x2 =
    (((0.0, 1.0), (0.0, 0.0), (1.0, 0.0)), ((0.0, 1.0), (1.0, 0.0), (1.0, 1.0)),
    ((0.0, 1.0), (0.0, 0.0), (1.0, 0.0)), ((0.0, 1.0), (1.0, 0.0), (1.0, 1.0)),
    ((0.0, 1.0), (0.0, 0.0), (1.0, 0.0)), ((0.0, 1.0), (1.0, 0.0), (1.0, 1.0)),
    ((0.0, 1.0), (0.0, 0.0), (1.0, 0.0)), ((0.0, 1.0), (1.0, 0.0), (1.0, 1.0)),
    ((0.0, 1.0), (0.0, 0.0), (1.0, 0.0)), ((0.0, 1.0), (1.0, 0.0), (1.0, 1.0)),
    ((0.0, 1.0), (0.0, 0.0), (1.0, 0.0)), ((0.0, 1.0), (1.0, 0.0), (1.0, 1.0)));


var
  TriangleNormal: TTRiangle;

  uiVBO: array[0..10] of glUINT;
  uiVAO: array[0..2] of glUINT;

  WorldMatrix_id: GLint;

  WorldMatrix: TMatrix;


procedure TForm1.InitScene;
begin
  FaceToNormale(Triangle, TriangleNormal);

  glClearColor(0.0, 0.5, 1.0, 1.0);

  glEnable(GL_DEPTH_TEST);
  glDepthFunc(GL_LESS);

  Shader := TShader.Create(FileToStr('shader.glsl'));
  with Shader do begin
    glUniform1i(UniformLocation('Sampler[0]'), 0);
    glUniform1i(UniformLocation('Sampler[1]'), 1);

    WorldMatrix_id := UniformLocation('WorldMatrix');
  end;

  glGenVertexArrays(1, uiVAO);
  glGenBuffers(4, uiVBO);

  glBindVertexArray(uiVAO[0]); // Würfel

  glBindBuffer(GL_ARRAY_BUFFER, uiVBO[0]);
  glBufferData(GL_ARRAY_BUFFER, sizeof(Triangle), @Triangle, GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 3, GL_FLOAT, False, 0, nil);

  glBindBuffer(GL_ARRAY_BUFFER, uiVBO[1]);
  glBufferData(GL_ARRAY_BUFFER, sizeof(Triangle), @TriangleNormal, GL_STATIC_DRAW);
  glEnableVertexAttribArray(1);
  glVertexAttribPointer(1, 3, GL_FLOAT, False, 0, nil);

  glBindBuffer(GL_ARRAY_BUFFER, uiVBO[2]);
  glBufferData(GL_ARRAY_BUFFER, sizeof(TriangleTextureVertex0), @TriangleTextureVertex0, GL_STATIC_DRAW);
  glEnableVertexAttribArray(10);
  glVertexAttribPointer(10, 2, GL_FLOAT, False, 0, nil);

  glBindBuffer(GL_ARRAY_BUFFER, uiVBO[3]);
  glBufferData(GL_ARRAY_BUFFER, sizeof(TriangleTextureVertex1), @TriangleTextureVertex1, GL_STATIC_DRAW);
  glEnableVertexAttribArray(11);
  glVertexAttribPointer(11, 2, GL_FLOAT, False, 0, nil);


  // ------------ Texturen laden --------------

  Textur[0] := TTexturBuffer.Create;
  Textur[1] := TTexturBuffer.Create;

  Textur[0].LoadTextures(Image1.Picture.Bitmap.RawImage);
  Textur[1].LoadTextures(Image2.Picture.Bitmap.RawImage);

  WorldMatrix.Scale(0.5);
end;

procedure TForm1.RenderScene;
var
  m: TMatrix;
begin
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);

  glEnable(GL_CULL_FACE);
  glCullface(GL_BACK);

  glActiveTexture(GL_TEXTURE0);
  glBindTexture(GL_TEXTURE_2D, Textur[0].ID);

  glActiveTexture(GL_TEXTURE1);
  glBindTexture(GL_TEXTURE_2D, Textur[1].ID);


  glBindVertexArray(uiVAO[0]); // Dreieck

  glViewport(0, 0, ClientWidth div 2, ClientHeight div 2);
  WorldMatrix.Uniform(WorldMatrix_id);
  glDrawArrays(GL_TRIANGLES, 0, Length(Triangle) * 3);

  glViewport(ClientWidth div 2, ClientHeight div 2, ClientWidth div 2, ClientHeight div 2);
  m := WorldMatrix;
  WorldMatrix.RotateA(Pi / 4);
  WorldMatrix.Uniform(WorldMatrix_id);
  glDrawArrays(GL_TRIANGLES, 0, Length(Triangle) * 3);
  WorldMatrix := m;

  OpenGLControl.SwapBuffers;
end;


procedure TForm1.FormCreate(Sender: TObject);
begin
  WorldMatrix.Identity;

  OpenGLControl := TOpenGLControl.Create(Self);
  OpenGLControl.Parent := Self;
  OpenGLControl.Align := alClient;
  OpenGLControl.OpenGLMajorVersion := 3;
  OpenGLControl.OpenGLMinorVersion := 3;

  InitOpenGL;
  OpenGLControl.MakeCurrent;
  ReadExtensions;
  ReadImplementationProperties;

  InitScene;

  Timer1.Enabled := True;
end;

procedure TForm1.FormDestroy(Sender: TObject);
var
  i: integer;
begin
  glDeleteBuffers(1, @uiVBO);
  glDeleteVertexArrays(1, @uiVAO);
  OpenGLControl.Free;
  Shader.Free;
  for i := 0 to 1 do begin
    Textur[i].Free;
  end;
end;


procedure TForm1.Timer1Timer(Sender: TObject);
begin
  WorldMatrix.RotateC(Pi / 200);
  WorldMatrix.RotateB(Pi / 200);
  RenderScene;
end;

end.
