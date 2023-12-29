unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes,  SysUtils,  FileUtil,  OpenGLContext,  Forms,  Controls,  Graphics,
  Dialogs,  ExtCtrls,  StdCtrls,
  dglOpenGL,  oglShader,  oglMatrix;

type

  { TForm1 }

  TForm1 = class(TForm)
    Image1: TImage;
    Image2: TImage;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    OpenGLControl: TOpenGLControl;
    procedure InitScene;
    procedure RenderScene;
  public
    TriangleShader, TexturShader: TShader;
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

const
  TexturSize = 4096;

  Triangle: array[0..0] of Tmat3x3 =
    (((-0.4, -0.2, 0.0), (0.4, -0.2, 0.0), (0.0, 0.4, 0.0)));
  TriangleColor: array[0..0] of Tmat3x3 =
    (((1.0, 0.0, 0.0), (0.0, 1.0, 0.0), (0.0, 0.0, 1.0)));


const
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
    (((0.0, 1.0), (0.0, 0.0), (1.0, 0.0)), ((0.0, 1.0), (1.0, 0.0), (1.0, 1.0)),
    ((0.0, 1.0), (0.0, 0.0), (1.0, 0.0)), ((0.0, 1.0), (1.0, 0.0), (1.0, 1.0)),
    ((0.0, 1.0), (0.0, 0.0), (1.0, 0.0)), ((0.0, 1.0), (1.0, 0.0), (1.0, 1.0)),
    ((0.0, 1.0), (0.0, 0.0), (1.0, 0.0)), ((0.0, 1.0), (1.0, 0.0), (1.0, 1.0)),
    ((0.0, 1.0), (0.0, 0.0), (1.0, 0.0)), ((0.0, 1.0), (1.0, 0.0), (1.0, 1.0)),
    ((0.0, 1.0), (0.0, 0.0), (1.0, 0.0)), ((0.0, 1.0), (1.0, 0.0), (1.0, 1.0)));

  QuadTextureVertex1: array[0..11] of Tmat3x2 =
    (((0.0, 2.0), (0.0, 0.0), (2.0, 0.0)), ((0.0, 2.0), (2.0, 0.0), (2.0, 2.0)),
    ((0.0, 2.0), (0.0, 0.0), (2.0, 0.0)), ((0.0, 2.0), (2.0, 0.0), (2.0, 2.0)),
    ((0.0, 2.0), (0.0, 0.0), (2.0, 0.0)), ((0.0, 2.0), (2.0, 0.0), (2.0, 2.0)),
    ((0.0, 2.0), (0.0, 0.0), (2.0, 0.0)), ((0.0, 2.0), (2.0, 0.0), (2.0, 2.0)),
    ((0.0, 2.0), (0.0, 0.0), (2.0, 0.0)), ((0.0, 2.0), (2.0, 0.0), (2.0, 2.0)),
    ((0.0, 2.0), (0.0, 0.0), (2.0, 0.0)), ((0.0, 2.0), (2.0, 0.0), (2.0, 2.0)));


var
  uiVAO: array[0..1] of glUINT;
  uiVBO: array[0..4] of glUINT;

  Textur_Shader_ID: record
    WorldMatrix_id: GLint;
  end;

  Triangle_Shader_ID: record
    WorldMatrix_id: GLint;
  end;

  textureID0, textureID1: GLuint;

  TriangleMatrix, WorldMatrix: TMatrix;

procedure TForm1.InitScene;
var
  DataPointer: Pointer;
begin
  glEnable(GL_DEPTH_TEST);
  glDepthFunc(GL_LESS);

  TexturShader := TShader.Create([FileToStr('textur.vert'), FileToStr('textur.frag')]);
  with TexturShader, Textur_Shader_ID do begin
    UseProgram;
    glUniform1i(UniformLocation('Sampler0'), 0);
    glUniform1i(UniformLocation('Sampler1'), 1);

    WorldMatrix_id := UniformLocation('Matrix');
  end;

  TriangleShader := TShader.Create([FileToStr('triangle.vert'), FileToStr('triangle.frag')]);
  with TriangleShader, Triangle_Shader_ID do begin
    UseProgram;
    WorldMatrix_id := UniformLocation('Matrix');
  end;

  glGenVertexArrays(2, uiVAO);
  glGenBuffers(5, uiVBO);

  with Triangle_Shader_ID do begin // Triangle
    glBindVertexArray(uiVAO[0]);

    glBindBuffer(GL_ARRAY_BUFFER, uiVBO[0]);
    glBufferData(GL_ARRAY_BUFFER, sizeof(Triangle), @Triangle, GL_STATIC_DRAW);
    glEnableVertexAttribArray(0);
    glVertexAttribPointer(0, 3, GL_FLOAT, False, 0, nil);

    glBindBuffer(GL_ARRAY_BUFFER, uiVBO[1]);
    glBufferData(GL_ARRAY_BUFFER, sizeof(TriangleColor), @TriangleColor, GL_STATIC_DRAW);
    glEnableVertexAttribArray(2);
    glVertexAttribPointer(2, 3, GL_FLOAT, False, 0, nil);
  end;

  with Textur_Shader_ID do begin  // Würfel
    glBindVertexArray(uiVAO[1]);

    glBindBuffer(GL_ARRAY_BUFFER, uiVBO[2]);
    glBufferData(GL_ARRAY_BUFFER, sizeof(Quad), @Quad, GL_STATIC_DRAW);
    glEnableVertexAttribArray(0);
    glVertexAttribPointer(0, 3, GL_FLOAT, False, 0, nil);

    glBindBuffer(GL_ARRAY_BUFFER, uiVBO[3]);
    glBufferData(GL_ARRAY_BUFFER, sizeof(QuadTextureVertex0), @QuadTextureVertex0, GL_STATIC_DRAW);
    glEnableVertexAttribArray(10);
    glVertexAttribPointer(10, 2, GL_FLOAT, False, 0, nil);

    glBindBuffer(GL_ARRAY_BUFFER, uiVBO[4]);
    glBufferData(GL_ARRAY_BUFFER, sizeof(QuadTextureVertex1), @QuadTextureVertex1, GL_STATIC_DRAW);
    glEnableVertexAttribArray(11);
    glVertexAttribPointer(11, 2, GL_FLOAT, False, 0, nil);
  end;


  // ------------ Texturen laden --------------

  GetMem(DataPointer, TexturSize * TexturSize * 4);
  FillDWord(DataPointer^, TexturSize * TexturSize, $FF0000FF);
  glGenTextures(1, @textureID0);
  glBindTexture(GL_TEXTURE_2D, textureID0);

  glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, TexturSize, TexturSize, 0, GL_RGBA, GL_UNSIGNED_BYTE, DataPointer);

  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
  glGenerateMipmap(GL_TEXTURE_2D);

  Freemem(DataPointer);

  with Image2.Picture.Bitmap.RawImage do begin   // Textur 1
    glGenTextures(1, @textureID1);
    glBindTexture(GL_TEXTURE_2D, textureID1);

    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, Description.Width, Description.Height, 0, GL_BGRA, GL_UNSIGNED_BYTE, Data);

    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);

    glGenerateMipmap(GL_TEXTURE_2D);
  end;

  TriangleMatrix.Scale(2.0);
end;

procedure TForm1.RenderScene;
const
  maxX = 4;
  maxY = 4;
  RandX = 32 div maxX;
  RandY = 32 div maxY;
var
  SizeX: integer;
  SizeY: integer;
  y: integer;
  x: integer;
begin
  // Dreieck auf Textur rendern

  glClearColor(0.0, 1.0, 0.0, 1.0);
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
  glViewport(0, 0, TexturSize, TexturSize);

  glEnable(GL_CULL_FACE);
  glCullface(GL_BACK);

  with Triangle_Shader_ID do begin // Triangle
    TriangleShader.UseProgram;
    glBindVertexArray(uiVAO[0]);

    TriangleMatrix.Uniform(WorldMatrix_id);
    glDrawArrays(GL_TriangleS, 0, Length(Triangle) * 3);
  end;

  SizeX := TexturSize div maxX;
  SizeY := TexturSize div maxY;

  glActiveTexture(GL_TEXTURE0);
  glBindTexture(GL_TEXTURE_2D, textureID0);

  for x := 0 to maxX - 1 do begin
    for y := 0 to maxY - 1 do begin
      glCopyTexSubImage2D(GL_TEXTURE_2D, 0, x * SizeX + RandX, y * SizeY + RandY, x * SizeX + RandX, y * SizeY + RandY, SizeX - 2 * RandX, SizeY - RandY * 2);
    end;
  end;

  //  glCopyTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, 0, 0, TexturSize, TexturSize, 0);


  // Würfel rendern

  glClearColor(1.0, 0.5, 1.0, 0.0);
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);


  glViewport(0, OpenGLControl.Height - ClientHeight, ClientWidth, ClientHeight);
  //    glViewport(0, 0, ClientWidth, ClientHeight);

  glActiveTexture(GL_TEXTURE0);
  glBindTexture(GL_TEXTURE_2D, textureID0);

  glActiveTexture(GL_TEXTURE1);
  glBindTexture(GL_TEXTURE_2D, textureID1);

  with Textur_Shader_ID do begin  // Rechteck
    TexturShader.UseProgram;
    glBindVertexArray(uiVAO[1]);

    WorldMatrix.Uniform(WorldMatrix_id);
    glDrawArrays(GL_TriangleS, 0, Length(Quad) * 3);
  end;

  OpenGLControl.SwapBuffers;
end;


procedure TForm1.FormCreate(Sender: TObject);
begin
  WorldMatrix.Identity;
  TriangleMatrix.Identity;

  OpenGLControl := TOpenGLControl.Create(Self);
  OpenGLControl.Parent := Self;
  OpenGLControl.SetBounds(0, 0, TexturSize, TexturSize);


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
  glDeleteVertexArrays(2, @uiVAO);
  glDeleteBuffers(5, @uiVBO);
  OpenGLControl.Free;
  TexturShader.Free;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  WorldMatrix.RotateC(Pi / 200);
  WorldMatrix.RotateA(Pi / 200);
  TriangleMatrix.RotateC(-Pi / 124);
  TriangleMatrix.RotateA(-Pi / 124);

  RenderScene;
end;

end.
