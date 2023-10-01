unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, Menus,
  dglOpenGL,
  oglContext, oglShader, oglVector, oglMatrix, oglTextur;

  //image image.png

(*
*)

  //lineal

type
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

// https://www.shadertoy.com/view/tsKXzW

{$R *.lfm}

const
  CubeVertex: array of Tmat4x3 =
    (((-0.5, 0.5, 0.5), (-0.5, -0.5, 0.5), (0.5, 0.5, 0.5), (0.5, -0.5, 0.5)),
    ((0.5, 0.5, 0.5), (0.5, -0.5, 0.5), (0.5, 0.5, -0.5), (0.5, -0.5, -0.5)),
    ((0.5, 0.5, -0.5), (0.5, -0.5, -0.5), (-0.5, 0.5, -0.5), (-0.5, -0.5, -0.5)),
    ((-0.5, 0.5, -0.5), (-0.5, -0.5, -0.5), (-0.5, 0.5, 0.5), (-0.5, -0.5, 0.5)),
    // oben
    ((0.5, 0.5, 0.5), (0.5, 0.5, -0.5), (-0.5, 0.5, 0.5), (-0.5, 0.5, -0.5)),
    // unten
    ((-0.5, -0.5, 0.5), (-0.5, -0.5, -0.5), (0.5, -0.5, 0.5), (0.5, -0.5, -0.5)));

  // --- Texturkoordinaten
  CubeTextureVertex: array of Tmat4x2 =
    (((0.0, 1.0), (0.0, 0.0), (1.0, 1.0), (1.0, 0.0)),
    ((0.0, 1.0), (0.0, 0.0), (1.0, 1.0), (1.0, 0.0)),
    ((0.0, 1.0), (0.0, 0.0), (1.0, 1.0), (1.0, 0.0)),
    ((0.0, 1.0), (0.0, 0.0), (1.0, 1.0), (1.0, 0.0)),
    ((0.0, 1.0), (0.0, 0.0), (1.0, 1.0), (1.0, 0.0)),
    ((0.0, 1.0), (0.0, 0.0), (1.0, 1.0), (1.0, 0.0)));

const
  TexturSize = 4096;

var
  Quad_Shader: record
    Shader: TShader;
    WorldMatrix: TMatrix;
    col: GLfloat;
    Color_ID,
    WorldMatrix_ID: GLint;
      end;

  Cube_Shader: record
    VBCube: record
      VAO,
      VBOVertex,
      VBOTex_Col: GLuint;
      end;

    Shader: TShader;
    WorldMatrix: TMatrix;
    WorldMatrix_ID: GLint;
      end;


var
  textureID: GLuint;
  FramebufferName, depthrenderbuffer: GLuint;

procedure TForm1.FormCreate(Sender: TObject);
begin
  //remove+
  Width := 340;
  Height := 240;
  //remove-
  ogc := TContext.Create(Self, True, 4, 0);
  ogc.OnPaint := @ogcDrawScene;

  CreateScene;
  InitScene;
end;

procedure TForm1.CreateScene;
begin
  glEnable(GL_DEPTH_TEST);
  glDepthFunc(GL_LESS);

  // Shader des Quadrates
  with Quad_Shader do begin
    Shader := TShader.Create([
      GL_VERTEX_SHADER, FileToStr('quad.vert'),
      GL_FRAGMENT_SHADER, FileToStr('quad.frag')]);

    with Shader do begin
      UseProgram;
      Color_ID := UniformLocation('col');
      WorldMatrix_ID := UniformLocation('Matrix');
      WorldMatrix.Identity;
    end;
  end;

  with Cube_Shader do begin
    Shader := TShader.Create([
      GL_VERTEX_SHADER, FileToStr('Vertexshader.glsl'),
      GL_TESS_EVALUATION_SHADER, FileToStr('Tesselationshader.glsl'),
      GL_FRAGMENT_SHADER, FileToStr('Fragmentshader.glsl')]);

    with Shader do begin
      UseProgram;
      WorldMatrix_ID := UniformLocation('Matrix');
      glUniform1i(UniformLocation('heightMap'), 0);  // Dem Sampler[0] 0 zuweisen.
      WorldMatrix.Identity;
    end;

    glGenVertexArrays(1, @VBCube.VAO);
    glGenBuffers(1, @VBCube.VBOVertex);
    glGenBuffers(1, @VBCube.VBOTex_Col);
  end;

  //code-

  Timer1.Enabled := True;
end;

procedure TForm1.InitScene;
const
  cnt = 1024;
  outer_levels: array of GLfloat = (cnt, cnt, cnt, cnt);
  inner_levels: array of GLfloat = (cnt, cnt);
begin
  // --- Auflösung für Teselations-Shader

  glPatchParameterfv(GL_PATCH_DEFAULT_OUTER_LEVEL, PGLfloat(outer_levels));
  glPatchParameterfv(GL_PATCH_DEFAULT_INNER_LEVEL, PGLfloat(inner_levels));
  glPatchParameteri(GL_PATCH_VERTICES, 4);

  // --- Quadrat
  with Quad_Shader do begin
    glClearColor(0.6, 0.6, 0.4, 1.0);

    //  glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);
    glPolygonMode(GL_FRONT, GL_POINT);
    glPolygonMode(GL_BACK, GL_LINE);
    Quad_Shader.WorldMatrix.Scale(1.5);
    WorldMatrix.Scale(1.5);
    // Es werden keine Vertexkoordinaten gebraucht, da dies im Vertex-Shader
  end;

  // ---- Cube
  with Cube_Shader do begin
    glBindVertexArray(VBCube.VAO);

    // Vertexkoordinaten
    glBindBuffer(GL_ARRAY_BUFFER, VBCube.VBOVertex);
    glBufferData(GL_ARRAY_BUFFER, sizeof(Tmat4x3) * Length(CubeVertex), Pmat4x3(CubeVertex), GL_STATIC_DRAW);
    glEnableVertexAttribArray(0);
    glVertexAttribPointer(0, 3, GL_FLOAT, False, 0, nil);

    // Texturkoordinaten
    glBindBuffer(GL_ARRAY_BUFFER, VBCube.VBOTex_Col);
    glBufferData(GL_ARRAY_BUFFER, sizeof(Tmat4x2) * Length(CubeTextureVertex), Pmat4x2(CubeTextureVertex), GL_STATIC_DRAW);
    glEnableVertexAttribArray(1);
    glVertexAttribPointer(1, 2, GL_FLOAT, False, 0, nil);
  end;

  // ------------ Texturen erzeugen --------------

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
    glBindFramebuffer(GL_FRAMEBUFFER, FramebufferName);
    glClearColor(0.3, 0.3, 1.0, 1.0);
    Shader.UseProgram;

    glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
    glViewport(0, 0, TexturSize, TexturSize);

    WorldMatrix.Uniform(WorldMatrix_ID);
    glUniform1f(Color_ID, col);

    glDrawArrays(GL_TRIANGLES, 0, 6);
  end;

  //  --- Normal auf den Bildschirm rendern.
  with Cube_Shader do begin
    glBindFramebuffer(GL_FRAMEBUFFER, 0);
    Shader.UseProgram;

    glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
    glViewport(0, 0, ClientWidth, ClientHeight);

    glBindTexture(GL_TEXTURE_2D, textureID);

    WorldMatrix.Uniform(WorldMatrix_ID);

    glBindVertexArray(VBCube.VAO);
    glDrawArrays(GL_PATCHES, 0, Length(CubeTextureVertex) * 4);

    ogc.SwapBuffers;
  end;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  with Quad_Shader do begin
    Shader.Free;
  end;

  with Cube_Shader do begin
    glDeleteVertexArrays(1, @VBCube.VAO);
    glDeleteBuffers(1, @VBCube.VBOVertex);
    glDeleteBuffers(1, @VBCube.VBOTex_Col);
    Shader.Free;
  end;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  with Quad_Shader do begin
    col := col + 0.1;
    if col >= 10.0 then begin
      col := col - 10.0;
    end;

    col := 5;

    WorldMatrix.RotateC(-Pi / 124);
  end;

  with Cube_Shader do begin
    WorldMatrix.RotateB(0.0223);
    WorldMatrix.RotateA(0.0423);
  end;
  ogcDrawScene(Sender);
end;

//lineal

(*
<b>Vertex-Shader:</b>
*)
//includeglsl Vertexshader.glsl
//lineal

(*
<b>Geometrie-Shader:</b>
*)
//includeglsl Geometrieshader.glsl
//lineal

(*
<b>Fragment-Shader</b>
*)
//includeglsl Fragmentshader.glsl

end.
