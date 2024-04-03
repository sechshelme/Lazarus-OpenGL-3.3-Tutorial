unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, OpenGLContext, Forms, Controls,
  Graphics, Dialogs, ExtCtrls, StdCtrls, ComCtrls,
  oglglad_gl,
  oglContext, oglShader, oglVector, oglMatrix;

type

  { TForm1 }

  TForm1 = class(TForm)
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    ogc: TContext;

    procedure CreateScene;
    procedure InitScene;
    procedure ogcDrawScene(Sender: TObject);
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

const
  Quad: array[0..1] of Tmat3x3 =
    (((-1.0, 1.0, 0.0), (-1.0, -1.0, 0.0), (1.0, -1.0, 0.0)), ((-1.0, 1.0, 0.0), (1.0, -1.0, 0.0), (1.0, 1.0, 0.0)));

const

  // --- Vectoren
  CubeVertex: array[0..11] of Tmat3x3 =
    (((-0.5, 0.5, 0.5), (-0.5, -0.5, 0.5), (0.5, -0.5, 0.5)), ((-0.5, 0.5, 0.5), (0.5, -0.5, 0.5), (0.5, 0.5, 0.5)),
    ((0.5, 0.5, 0.5), (0.5, -0.5, 0.5), (0.5, -0.5, -0.5)), ((0.5, 0.5, 0.5), (0.5, -0.5, -0.5), (0.5, 0.5, -0.5)),
    ((0.5, 0.5, -0.5), (0.5, -0.5, -0.5), (-0.5, -0.5, -0.5)), ((0.5, 0.5, -0.5), (-0.5, -0.5, -0.5), (-0.5, 0.5, -0.5)),
    ((-0.5, 0.5, -0.5), (-0.5, -0.5, -0.5), (-0.5, -0.5, 0.5)), ((-0.5, 0.5, -0.5), (-0.5, -0.5, 0.5), (-0.5, 0.5, 0.5)),
    // oben
    ((0.5, 0.5, 0.5), (0.5, 0.5, -0.5), (-0.5, 0.5, -0.5)), ((0.5, 0.5, 0.5), (-0.5, 0.5, -0.5), (-0.5, 0.5, 0.5)),
    // unten
    ((-0.5, -0.5, 0.5), (-0.5, -0.5, -0.5), (0.5, -0.5, -0.5)), ((-0.5, -0.5, 0.5), (0.5, -0.5, -0.5), (0.5, -0.5, 0.5)));

  // --- Texturkoordinaten
  CubeTextureVertex: array[0..11] of Tmat3x2 =
    (((0.0, 1.0), (0.0, 0.0), (1.0, 0.0)), ((0.0, 1.0), (1.0, 0.0), (1.0, 1.0)),
    ((0.0, 1.0), (0.0, 0.0), (1.0, 0.0)), ((0.0, 1.0), (1.0, 0.0), (1.0, 1.0)),
    ((0.0, 1.0), (0.0, 0.0), (1.0, 0.0)), ((0.0, 1.0), (1.0, 0.0), (1.0, 1.0)),
    ((0.0, 1.0), (0.0, 0.0), (1.0, 0.0)), ((0.0, 1.0), (1.0, 0.0), (1.0, 1.0)),
    ((0.0, 1.0), (0.0, 0.0), (1.0, 0.0)), ((0.0, 1.0), (1.0, 0.0), (1.0, 1.0)),
    ((0.0, 1.0), (0.0, 0.0), (1.0, 0.0)), ((0.0, 1.0), (1.0, 0.0), (1.0, 1.0)));

const
  TexturSize = 2048;

type
  TCube_VB = record
    VAO,
    VBOVertex,            // Vertex-Koordinaten
    VBOTex_Col: GLuint;   // Textur/Color-Koordinaten
  end;

  TQuad_VB = record
    VAO,
    VBOVertex: GLuint;   // Textur/Color-Koordinaten
  end;

var
  VBQuad: TQuad_VB;
  VBCube: TCube_VB;

  // Puffer für Quadrat.
  Quad_Shader: record
    WorldMatrix: TMatrix;
    col: GLfloat;

    Shader: TShader;
    Color_ID,
    WorldMatrix_ID: GLint;
      end;

  // Puffer für Würfel.
  Cube_Shader: record
    WorldMatrix: TMatrix;
    Shader: TShader;
    WorldMatrix_ID: GLint;
      end;

var
  // ID der Textur.
  textureID: GLuint;

  // Renderpuffer
  FramebufferName, depthrenderbuffer: GLuint;

procedure TForm1.FormCreate(Sender: TObject);
begin
  //remove+
  Width := 340;
  Height := 240;
  //remove-
  ogc := TContext.Create(Self);
  ogc.OnPaint := @ogcDrawScene;

  CreateScene;
  InitScene;
end;

procedure TForm1.CreateScene;
begin

  // Vertex Puffer erzeugen.
  glGenVertexArrays(1, @VBQuad.VAO);
  glGenBuffers(1, @VBQuad.VBOVertex);

  glGenVertexArrays(1, @VBCube.VAO);
  glGenBuffers(1, @VBCube.VBOVertex);
  glGenBuffers(1, @VBCube.VBOTex_Col);

  // Shader des Quadrates
  with Quad_Shader do begin
    Shader := TShader.Create([FileToStr('quad.vert'), FileToStr('quad.frag')]);
    with Shader do begin
      UseProgram;

      Color_ID := UniformLocation('col');
      WorldMatrix_ID := UniformLocation('Matrix');
    end;
  end;

  // Shader des Würfels.
  with Cube_Shader do begin
    Shader := TShader.Create([FileToStr('cube.vert'), FileToStr('cube.frag')]);
    with Shader do begin
      UseProgram;
      glUniform1i(UniformLocation('Sampler0'), 0);

      WorldMatrix_ID := UniformLocation('Matrix');
    end;
  end;

  Cube_Shader.WorldMatrix.Identity;
  Quad_Shader.WorldMatrix.Identity;
  Timer1.Enabled := True;
end;

procedure TForm1.InitScene;
begin
  glEnable(GL_DEPTH_TEST);
  glDepthFunc(GL_LESS);

  glEnable(GL_CULL_FACE);
  glCullface(GL_BACK);


  // --- Quadrat
  with Quad_Shader do begin
    WorldMatrix.Scale(1.5);

    glBindVertexArray(VBQuad.VAO);

    // Vertexkoordinaten
    glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBOVertex);
    glBufferData(GL_ARRAY_BUFFER, sizeof(Quad), @Quad, GL_STATIC_DRAW);
    glEnableVertexAttribArray(0);
    glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 0, nil);
  end;

  // --- Würfel
  with Cube_Shader do begin
    glBindVertexArray(VBCube.VAO);

    // Vertexkoordinaten
    glBindBuffer(GL_ARRAY_BUFFER, VBCube.VBOVertex);
    glBufferData(GL_ARRAY_BUFFER, sizeof(CubeVertex), @CubeVertex, GL_STATIC_DRAW);
    glEnableVertexAttribArray(0);
    glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 0, nil);

    // Texturkoordinaten
    glBindBuffer(GL_ARRAY_BUFFER, VBCube.VBOTex_Col);
    glBufferData(GL_ARRAY_BUFFER, sizeof(CubeTextureVertex), @CubeTextureVertex, GL_STATIC_DRAW);
    glEnableVertexAttribArray(1);
    glVertexAttribPointer(1, 2, GL_FLOAT, GL_FALSE, 0, nil);
  end;
  // ------------ Texturen erzeugen --------------

  // --- Textur

  glGenTextures(1, @textureID);
  glBindTexture(GL_TEXTURE_2D, textureID);

  glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, TexturSize, TexturSize, 0, GL_RGBA, GL_UNSIGNED_BYTE, nil);

  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);

  // Frame Puffer erzeugen.
  glGenFramebuffers(1, @FramebufferName);
  glBindFramebuffer(GL_FRAMEBUFFER, FramebufferName);

  // Render Puffer erzeugen.
  glGenRenderbuffers(1, @depthrenderbuffer);
  glBindRenderbuffer(GL_RENDERBUFFER, depthrenderbuffer);

  glRenderbufferStorage(GL_RENDERBUFFER, GL_DEPTH_COMPONENT, TexturSize, TexturSize);
  glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_DEPTH_ATTACHMENT, GL_RENDERBUFFER, depthrenderbuffer);

  // Die Textur mit dem Framebuffer koppeln
  glFramebufferTexture(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, textureID, 0);
end;

procedure TForm1.ogcDrawScene(Sender: TObject);
begin

  // --- In den Texturpuffer render.

  with Quad_Shader do begin // Quadrat

    // FramePuffer aktivieren.
    glBindFramebuffer(GL_FRAMEBUFFER, FramebufferName);

    glClearColor(0.3, 0.3, 1.0, 1.0);
    glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
    glViewport(0, 0, TexturSize, TexturSize);

    Shader.UseProgram;
    glBindVertexArray(VBQuad.VAO);

    WorldMatrix.Uniform(WorldMatrix_ID);
    glUniform1f(Color_ID, col);

    glDrawArrays(GL_TRIANGLES, 0, Length(Quad) * 3);
  end;


  //  --- Normal auf den Bildschirm rendern.

  with Cube_Shader do begin  // Würfel

    // BildschirmPuffer mit "0" aktivieren.
    glBindFramebuffer(GL_FRAMEBUFFER, 0);

    glClearColor(0.6, 0.6, 0.4, 1.0);
    glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
    glViewport(0, 0, ClientWidth, ClientHeight);

    glBindTexture(GL_TEXTURE_2D, textureID);

    Shader.UseProgram;
    glBindVertexArray(VBCube.VAO);

    WorldMatrix.Uniform(WorldMatrix_ID);
    glDrawArrays(GL_TriangleS, 0, Length(CubeVertex) * 3);

    ogc.SwapBuffers;
  end;

end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Timer1.Enabled := False;

  // Frame Puffer und Textur frei geben.
  glDeleteFramebuffers(1, @FramebufferName);
  glDeleteRenderbuffers(1, @depthrenderbuffer);
  glDeleteTextures(1, @textureID);

  // Vertex Puffer frei geben.
  glDeleteVertexArrays(1, @VBQuad.VAO);
  glDeleteBuffers(1, @VBQuad.VBOVertex);

  glDeleteVertexArrays(1, @VBCube.VAO);
  glDeleteBuffers(1, @VBCube.VBOVertex);
  glDeleteBuffers(1, @VBCube.VBOTex_Col);

  // Shader frei geben.
  Quad_Shader.Shader.Free;
  Cube_Shader.Shader.Free;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  with Quad_Shader do begin
    col := col + 0.1;
    if col >= 10.0 then begin
      col := col - 10.0;
    end;

    WorldMatrix.RotateC(-Pi / 124);
  end;

  with Cube_Shader do begin
    WorldMatrix.RotateC(Pi / 200);
    WorldMatrix.RotateA(Pi / 200);
  end;
  ogcDrawScene(Sender);
end;

end.
