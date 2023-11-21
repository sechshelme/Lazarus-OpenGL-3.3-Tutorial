unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, StdCtrls, OpenGLContext,
  dglOpenGL, oglShader, oglVector, oglMatrix;

type
  TTexturData = record
    Width, Height: integer;
    Data: array of GLuint;
  end;

  { TForm1 }

  TForm1 = class(TForm)
    ImageWald: TImage;
    ImageStern: TImage;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure ImageSternClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private   { private declarations }
    OpenGLControl: TOpenGLControl;
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

type
  TTRiangle = array[0..1] of Tmat3x3;

const
  Triangle: TTRiangle =
    (((-1.0, -1.0, 0.0), (1.0, 1.0, 0.0), (-1.0, 1.0, 0.0)),
    ((-1.0, -1.0, 0.0), (1.0, -1.0, 0.0), (1.0, 1.0, 0.0)));

  WaldTextureVertex: array[0..5] of TVector2f =
    ((0.0, 0.0), (1.0, 1.0), (0.0, 1.0),
    (0.0, 0.0), (1.0, 0.0), (1.0, 1.0));

  TriangleTextureVertex1: array[0..5] of TVector2f =
    ((0.0, 0.0), (1.0, 1.0), (0.0, 1.0),
    (0.0, 0.0), (1.0, 0.0), (1.0, 1.0));


var
  uiVBO: array[0..10] of glUINT;
  uiVAO: array[0..2] of glUINT;

  WorldMatrix_id, texture_id0, texture_id1, pos_id, texturexy_id: GLint;

  textureIDWald, textureIDStern: GLuint;

  WorldMatrix: TMatrix;

  TexturXY: record
    x, y: GLfloat;
  end;

procedure TForm1.InitScene;
begin
  glClearColor(0.0, 0.5, 1.0, 1.0);

  glEnable(GL_BLEND);
  glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);

  glEnable(GL_DEPTH_TEST);
  glDepthFunc(GL_LESS);

  Shader := TShader.Create([FileToStr('Vertexshader.glsl'), FileToStr('Fragmentshader.glsl')]);
  with Shader do begin
    pos_id := AttribLocation('inPos');
    texture_id0 := AttribLocation('vertexUV0');
    texture_id1 := AttribLocation('vertexUV1');

    glUniform1i(UniformLocation('Sampler0'), 0);
    glUniform1i(UniformLocation('Sampler1'), 1);

    WorldMatrix_id := UniformLocation('Matrix');
    texturexy_id := UniformLocation('Texturxy');
  end;

  glGenVertexArrays(1, uiVAO);
  glGenBuffers(3, uiVBO);

  glBindVertexArray(uiVAO[0]); // Rechteck

  glBindBuffer(GL_ARRAY_BUFFER, uiVBO[0]);
  glBufferData(GL_ARRAY_BUFFER, sizeof(Triangle), @Triangle, GL_STATIC_DRAW);
  glEnableVertexAttribArray(pos_id);
  glVertexAttribPointer(pos_id, 3, GL_FLOAT, False, 0, nil);

  glBindBuffer(GL_ARRAY_BUFFER, uiVBO[1]);
  glBufferData(GL_ARRAY_BUFFER, sizeof(WaldTextureVertex), @WaldTextureVertex, GL_STATIC_DRAW);
  glEnableVertexAttribArray(texture_id0);
  glVertexAttribPointer(texture_id0, 2, GL_FLOAT, False, 0, nil);

  glBindBuffer(GL_ARRAY_BUFFER, uiVBO[2]);
  glBufferData(GL_ARRAY_BUFFER, sizeof(TriangleTextureVertex1), @TriangleTextureVertex1, GL_STATIC_DRAW);
  glEnableVertexAttribArray(texture_id1);
  glVertexAttribPointer(texture_id1, 2, GL_FLOAT, False, 0, nil);


  // ------------ Texturen laden --------------

  with ImageWald.Picture.Bitmap do begin
    glGenTextures(1, @textureIDWald);
    glBindTexture(GL_TEXTURE_2D, textureIDWald);

    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB8, Width, Height, 0, GL_BGRA, GL_UNSIGNED_BYTE, RawImage.Data);

    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
    glGenerateMipmap(GL_TEXTURE_2D);
  end;

  with ImageStern.Picture.Bitmap do begin
    glGenTextures(1, @textureIDStern);
    glBindTexture(GL_TEXTURE_2D, textureIDStern);

    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB8, Width, Height, 0, GL_BGR, GL_UNSIGNED_BYTE, RawImage.Data);

    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR_MIPMAP_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR_MIPMAP_LINEAR);

    glGenerateMipmap(GL_TEXTURE_2D);
  end;
end;

procedure TForm1.RenderScene;
begin
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);

  glEnable(GL_CULL_FACE);
  glCullface(GL_BACK);

  glActiveTexture(GL_TEXTURE0);
  glBindTexture(GL_TEXTURE_2D, textureIDWald);

  glActiveTexture(GL_TEXTURE1);
  glBindTexture(GL_TEXTURE_2D, textureIDStern);


  glBindVertexArray(uiVAO[0]); // Dreieck

  WorldMatrix.Uniform(WorldMatrix_id);

  glUniform2fv(texturexy_id, 1, @TexturXY);

  glDrawArrays(GL_TRIANGLES, 0, Length(Triangle) * 3);

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
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  glDeleteBuffers(3, @uiVBO);
  glDeleteVertexArrays(1, @uiVAO);
  OpenGLControl.Free;
  Shader.Free;
end;


procedure TForm1.FormResize(Sender: TObject);
begin
  glViewport(0, 0, ClientWidth, ClientHeight);
end;

procedure TForm1.ImageSternClick(Sender: TObject);
begin

end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  with  TexturXY do begin
    x += 0.0034;
    y += 0.0045;
    if x > 1.0 then begin
      x -= 1.0;
    end;
    if y > 1.0 then begin
      y -= 1.0;
    end;
  end;

  //  WorldMatrix.RotateC(Pi / 200);
  RenderScene;
end;

end.
