unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, OpenGLContext, Forms, Controls,
  Graphics, Dialogs, ExtCtrls, StdCtrls, ComCtrls,
  dglOpenGL, BGRABitmap,
  Out_Images,
  oglShader, oglMatrix;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    ImageBaum: TImage;
    ImageLogo: TImage;
    Timer1: TTimer;
    ToolBar1: TToolBar;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private   { private declarations }
    OpenGLControl: TOpenGLControl;

    uiVAO: array[0..1] of glUINT;
    uiVBO: array[0..3] of glUINT;

    Cube_Shader: record
      Shader: TShader;
      WorldMatrix_id: GLint;
    end;

    RenderTextur_Shader: record
      Shader: TShader;
      WorldMatrix_id: GLint;
    end;

    TriangleMatrix, WorldMatrix: TMatrix;

    textureID0, textureID2: GLuint;

    // Render Bufffer
    FramebufferName, depthrenderbuffer: GLuint;

    TexturSize: integer;

  const
    Triangle: array[0..1] of Tmat3x3 =
      (((-0.3, 0.3, 0.0), (-0.3, -0.3, 0.0), (0.3, -0.3, 0.0)), ((-0.3, 0.3, 0.0), (0.3, -0.3, 0.0), (0.3, 0.3, 0.0)));
    TriangleTextureVertex: array[0..1] of Tmat3x2 =
      (((0.0, 1.0), (0.0, 0.0), (1.0, 0.0)), ((0.0, 1.0), (1.0, 0.0), (1.0, 1.0)));


    Quad: array[0..11] of Tmat3x3 =
      (((-0.5, 0.5, 0.5), (-0.5, -0.5, 0.5), (0.5, -0.5, 0.5)), ((-0.5, 0.5, 0.5), (0.5, -0.5, 0.5), (0.5, 0.5, 0.5)),
      ((0.5, 0.5, 0.5), (0.5, -0.5, 0.5), (0.5, -0.5, -0.5)), ((0.5, 0.5, 0.5), (0.5, -0.5, -0.5), (0.5, 0.5, -0.5)),
      ((0.5, 0.5, -0.5), (0.5, -0.5, -0.5), (-0.5, -0.5, -0.5)), ((0.5, 0.5, -0.5), (-0.5, -0.5, -0.5), (-0.5, 0.5, -0.5)),
      ((-0.5, 0.5, -0.5), (-0.5, -0.5, -0.5), (-0.5, -0.5, 0.5)), ((-0.5, 0.5, -0.5), (-0.5, -0.5, 0.5), (-0.5, 0.5, 0.5)),
      // oben
      ((0.5, 0.5, 0.5), (0.5, 0.5, -0.5), (-0.5, 0.5, -0.5)), ((0.5, 0.5, 0.5), (-0.5, 0.5, -0.5), (-0.5, 0.5, 0.5)),
      // unten
      ((-0.5, -0.5, 0.5), (-0.5, -0.5, -0.5), (0.5, -0.5, -0.5)), ((-0.5, -0.5, 0.5), (0.5, -0.5, -0.5), (0.5, -0.5, 0.5)));

    QuadTextureVertex0: array[0..11] of Tmat3x2 =
      (((0.0, 2.0), (0.0, 0.0), (2.0, 0.0)), ((0.0, 2.0), (2.0, 0.0), (2.0, 2.0)),
      ((0.0, 2.0), (0.0, 0.0), (2.0, 0.0)), ((0.0, 2.0), (2.0, 0.0), (2.0, 2.0)),
      ((0.0, 2.0), (0.0, 0.0), (2.0, 0.0)), ((0.0, 2.0), (2.0, 0.0), (2.0, 2.0)),
      ((0.0, 2.0), (0.0, 0.0), (2.0, 0.0)), ((0.0, 2.0), (2.0, 0.0), (2.0, 2.0)),
      ((0.0, 2.0), (0.0, 0.0), (2.0, 0.0)), ((0.0, 2.0), (2.0, 0.0), (2.0, 2.0)),
      ((0.0, 2.0), (0.0, 0.0), (2.0, 0.0)), ((0.0, 2.0), (2.0, 0.0), (2.0, 2.0)));

    procedure InitScene;
    procedure RenderScene;
  public        { public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.InitScene;

begin
  TexturSize := 4096;

  glEnable(GL_BLEND);
  glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);

  glEnable(GL_DEPTH_TEST);
  glDepthFunc(GL_LESS);

  glEnable(GL_CULL_FACE);
  glCullface(GL_BACK);

  with  Cube_Shader do begin
    Shader := TShader.Create([FileToStr('cube.glsl')]);
    with Shader do begin
      UseProgram;
      glUniform1i(UniformLocation('Sampler0'), 0);

      WorldMatrix_id := UniformLocation('Matrix');
    end;
  end;

  with  RenderTextur_Shader do begin
    Shader := TShader.Create([FileToStr('rendertexur.glsl')]);
    with Shader do begin
      UseProgram;
      glUniform1i(UniformLocation('Sampler0'), 0);

      WorldMatrix_id := UniformLocation('Matrix');
    end;
  end;

  glGenVertexArrays(2, uiVAO);
  glGenBuffers(4, uiVBO);

  with RenderTextur_Shader do begin // Triangle
    glBindVertexArray(uiVAO[0]);

    glBindBuffer(GL_ARRAY_BUFFER, uiVBO[0]);
    glBufferData(GL_ARRAY_BUFFER, sizeof(Triangle), @Triangle, GL_STATIC_DRAW);
    glEnableVertexAttribArray(0);
    glVertexAttribPointer(0, 3, GL_FLOAT, False, 0, nil);

    glBindBuffer(GL_ARRAY_BUFFER, uiVBO[1]);
    glBufferData(GL_ARRAY_BUFFER, sizeof(TriangleTextureVertex), @TriangleTextureVertex, GL_STATIC_DRAW);
    glEnableVertexAttribArray(10);
    glVertexAttribPointer(10, 2, GL_FLOAT, False, 0, nil);
  end;

  with Cube_Shader do begin  // Würfel
    glBindVertexArray(uiVAO[1]);

    glBindBuffer(GL_ARRAY_BUFFER, uiVBO[2]);
    glBufferData(GL_ARRAY_BUFFER, sizeof(Quad), @Quad, GL_STATIC_DRAW);
    glEnableVertexAttribArray(0);
    glVertexAttribPointer(0, 3, GL_FLOAT, False, 0, nil);

    glBindBuffer(GL_ARRAY_BUFFER, uiVBO[3]);
    glBufferData(GL_ARRAY_BUFFER, sizeof(QuadTextureVertex0), @QuadTextureVertex0, GL_STATIC_DRAW);
    glEnableVertexAttribArray(10);
    glVertexAttribPointer(10, 2, GL_FLOAT, False, 0, nil);
  end;


  // ------------ Texturen laden --------------

  // --- Textur 0

  glGenTextures(1, @textureID0);
  glBindTexture(GL_TEXTURE_2D, textureID0);

  glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, TexturSize, TexturSize, 0, GL_RGBA, GL_UNSIGNED_BYTE, nil);

  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);

  // Frame Buffer erzeugen

  glGenFramebuffers(1, @FramebufferName);
  glBindFramebuffer(GL_FRAMEBUFFER, FramebufferName);

  glGenRenderbuffers(1, @depthrenderbuffer);
  glBindRenderbuffer(GL_RENDERBUFFER, depthrenderbuffer);

  glRenderbufferStorage(GL_RENDERBUFFER, GL_DEPTH_COMPONENT, TexturSize, TexturSize);
  glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_DEPTH_ATTACHMENT, GL_RENDERBUFFER, depthrenderbuffer);

  glFramebufferTexture(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, textureID0, 0);

  // --- Textur 2 ( Baum )

  with ImageBaum.Picture.Bitmap.RawImage do begin
    glGenTextures(1, @textureID2);
    glBindTexture(GL_TEXTURE_2D, textureID2);

    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, Description.Width, Description.Height, 0, GL_BGRA, GL_UNSIGNED_BYTE, Data);

    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);

    glGenerateMipmap(GL_TEXTURE_2D);
  end;

  // end Textur

  TriangleMatrix.Scale(2.0);
end;

procedure TForm1.RenderScene;
begin

  // --- In den Texturbuffer render

  glBindFramebuffer(GL_FRAMEBUFFER, FramebufferName);

  glClearColor(0.3, 0.3, 1.0, 0.0);
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
  glViewport(0, 0, TexturSize, TexturSize);

  glBindTexture(GL_TEXTURE_2D, textureID2);

  with RenderTextur_Shader do begin // Triangle
    Shader.UseProgram;
    glBindVertexArray(uiVAO[0]);

    TriangleMatrix.Uniform(WorldMatrix_id);
    glDrawArrays(GL_TRIANGLES, 0, Length(Triangle) * 3);


    TriangleMatrix.Push;
    TriangleMatrix.Translate(0.4, 0.4, -0.4);
    TriangleMatrix.Uniform(WorldMatrix_id);
    glDrawArrays(GL_TRIANGLES, 0, Length(Triangle) * 3);
    TriangleMatrix.Pop;
  end;


  //  --- Normal auf den Bildschirm rendern

  glBindFramebuffer(GL_FRAMEBUFFER, 0);

  glClearColor(1.0, 0.5, 0.5, 1.0);
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);


  glViewport(0, 0, ClientWidth, ClientHeight);

  glBindTexture(GL_TEXTURE_2D, textureID0);

  with Cube_Shader do begin  // Rechteck
    Shader.UseProgram;
    glBindVertexArray(uiVAO[1]);

    WorldMatrix.Uniform(WorldMatrix_id);
    glDrawArrays(GL_TriangleS, 0, Length(Quad) * 3);
  end;

  OpenGLControl.SwapBuffers;
end;


procedure TForm1.FormCreate(Sender: TObject);
begin
  WorldMatrix := TMatrix.Create;
  TriangleMatrix := TMatrix.Create;

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

procedure TForm1.Button1Click(Sender: TObject);
begin
  with Form2.Image1.Picture do begin
    Bitmap.PixelFormat := pf32bit;
    //    Bitmap.Clear;
    Bitmap.Width := TexturSize;
    Bitmap.Height := TexturSize;
    glBindFramebuffer(GL_FRAMEBUFFER, FramebufferName);
    glReadPixels(0, 0, TexturSize, TexturSize, GL_BGRA, GL_UNSIGNED_BYTE, Bitmap.RawImage.Data);

    SaveToFile('test.png');
  end;
  Form2.ShowModal;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  bit: TBGRABitmap;
begin
  bit := TBGRABitmap.Create(TexturSize, TexturSize);

  glBindFramebuffer(GL_FRAMEBUFFER, FramebufferName);
  glReadPixels(0, 0, TexturSize, TexturSize, GL_RGBA, GL_UNSIGNED_BYTE, bit.Data);

  bit.SaveToFile('test.png');

  bit.Free;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  glDeleteVertexArrays(2, @uiVAO);
  glDeleteBuffers(5, @uiVBO);

  glDeleteFramebuffers(1, @FramebufferName);
  glDeleteRenderbuffers(1, @depthrenderbuffer);
  glDeleteTextures(1, @textureID0);

  OpenGLControl.Free;

  RenderTextur_Shader.Shader.Free;
  Cube_Shader.Shader.Free;

  WorldMatrix.Free;
  TriangleMatrix.Free;
end;


procedure TForm1.Timer1Timer(Sender: TObject);
begin
  WorldMatrix.RotateC(Pi / 200);
  WorldMatrix.RotateA(Pi / 200);
  TriangleMatrix.RotateC(-Pi / 124);
  RenderScene;
end;

end.
