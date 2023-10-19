unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, Menus,
  dglOpenGL,
  oglContext, oglShader, oglVector, oglMatrix,
  oglTextur; // Unit für Texturen

type

  { TForm1 }

  TForm1 = class(TForm)
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    ogc: TContext;
    Shader: TShader; // Shader Klasse
    procedure CreateScene;
    procedure ogcDrawScene(Sender: TObject);
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

//image image.png
//lineal

// https://learnopengl.com/code_viewer_gh.php?code=src/4.advanced_opengl/2.stencil_testing/stencil_testing.cpp
// https://learnopengl.com/Advanced-OpenGL/Stencil-testing

// https://open.gl/depthstencils
// https://open.gl/content/code/c5_reflection.txt

// https://learnopengl.com/Advanced-OpenGL/Stencil-testing
// https://en.wikibooks.org/wiki/OpenGL_Programming/Stencil_buffer
// https://gist.github.com/sealfin/d22f4ba4d1022e1b89dd
// https://lazyfoo.net/tutorials/OpenGL/26_the_stencil_buffer/index.php

const
  verticesReflect: array of GLfloat = (
    -1.0, -1.0, -0.5, 0.0, 0.0, 0.0, 0.0, 0.0,
    1.0, -1.0, -0.5, 0.0, 0.0, 0.0, 1.0, 0.0,
    1.0, 1.0, -0.5, 0.0, 0.0, 0.0, 1.0, 1.0,
    1.0, 1.0, -0.5, 0.0, 0.0, 0.0, 1.0, 1.0,
    -1.0, 1.0, -0.5, 0.0, 0.0, 0.0, 0.0, 1.0,
    -1.0, -1.0, -0.5, 0.0, 0.0, 0.0, 0.0, 0.0);

  verticesCube: array of GLfloat = (
    -0.5, -0.5, -0.5, 1.0, 1.0, 1.0, 0.0, 0.0,
    0.5, -0.5, -0.5, 1.0, 1.0, 1.0, 1.0, 0.0,
    0.5, 0.5, -0.5, 1.0, 1.0, 1.0, 1.0, 1.0,
    0.5, 0.5, -0.5, 1.0, 1.0, 1.0, 1.0, 1.0,
    -0.5, 0.5, -0.5, 1.0, 1.0, 1.0, 0.0, 1.0,
    -0.5, -0.5, -0.5, 1.0, 1.0, 1.0, 0.0, 0.0,

    -0.5, -0.5, 0.5, 1.0, 1.0, 1.0, 0.0, 0.0,
    0.5, -0.5, 0.5, 1.0, 1.0, 1.0, 1.0, 0.0,
    0.5, 0.5, 0.5, 1.0, 1.0, 1.0, 1.0, 1.0,
    0.5, 0.5, 0.5, 1.0, 1.0, 1.0, 1.0, 1.0,
    -0.5, 0.5, 0.5, 1.0, 1.0, 1.0, 0.0, 1.0,
    -0.5, -0.5, 0.5, 1.0, 1.0, 1.0, 0.0, 0.0,

    -0.5, 0.5, 0.5, 1.0, 1.0, 1.0, 1.0, 0.0,
    -0.5, 0.5, -0.5, 1.0, 1.0, 1.0, 1.0, 1.0,
    -0.5, -0.5, -0.5, 1.0, 1.0, 1.0, 0.0, 1.0,
    -0.5, -0.5, -0.5, 1.0, 1.0, 1.0, 0.0, 1.0,
    -0.5, -0.5, 0.5, 1.0, 1.0, 1.0, 0.0, 0.0,
    -0.5, 0.5, 0.5, 1.0, 1.0, 1.0, 1.0, 0.0,

    0.5, 0.5, 0.5, 1.0, 1.0, 1.0, 1.0, 0.0,
    0.5, 0.5, -0.5, 1.0, 1.0, 1.0, 1.0, 1.0,
    0.5, -0.5, -0.5, 1.0, 1.0, 1.0, 0.0, 1.0,
    0.5, -0.5, -0.5, 1.0, 1.0, 1.0, 0.0, 1.0,
    0.5, -0.5, 0.5, 1.0, 1.0, 1.0, 0.0, 0.0,
    0.5, 0.5, 0.5, 1.0, 1.0, 1.0, 1.0, 0.0,

    -0.5, -0.5, -0.5, 1.0, 1.0, 1.0, 0.0, 1.0,
    0.5, -0.5, -0.5, 1.0, 1.0, 1.0, 1.0, 1.0,
    0.5, -0.5, 0.5, 1.0, 1.0, 1.0, 1.0, 0.0,
    0.5, -0.5, 0.5, 1.0, 1.0, 1.0, 1.0, 0.0,
    -0.5, -0.5, 0.5, 1.0, 1.0, 1.0, 0.0, 0.0,
    -0.5, -0.5, -0.5, 1.0, 1.0, 1.0, 0.0, 1.0,

    -0.5, 0.5, -0.5, 1.0, 1.0, 1.0, 0.0, 1.0,
    0.5, 0.5, -0.5, 1.0, 1.0, 1.0, 1.0, 1.0,
    0.5, 0.5, 0.5, 1.0, 1.0, 1.0, 1.0, 0.0,
    0.5, 0.5, 0.5, 1.0, 1.0, 1.0, 1.0, 0.0,
    -0.5, 0.5, 0.5, 1.0, 1.0, 1.0, 0.0, 0.0,
    -0.5, 0.5, -0.5, 1.0, 1.0, 1.0, 0.0, 1.0);

var
  Textur: TTexturBuffer;

  VAOReflect,
  VBOReflect,
  VAOCube,
  VBOCube: GLuint;
  ViewMatrix, ProdMatrix, RotateMatrix: TMatrix;

  Color_ID,
  ModelMatrix_ID,
  ViewMatrix_ID,
  ProMatrix_ID: GLint;

procedure TForm1.FormCreate(Sender: TObject);
begin
  //remove+
  Width := 340;
  Height := 240;
  //remove-
  ogc := TContext.Create(Self);
  ogc.OnPaint := @ogcDrawScene;
  WriteLn(ogc.StencilBits);
  WriteLn(ogc.DepthBits);

  CreateScene;
  Timer1.Enabled := True;
end;

procedure TForm1.CreateScene;
begin
  // --- Shader laden
  Shader := TShader.Create;
  Shader.LoadShaderObjectFromFile(GL_VERTEX_SHADER, 'Vertexshader.glsl');
  Shader.LoadShaderObjectFromFile(GL_FRAGMENT_SHADER, 'Fragmentshader.glsl');
  Shader.LinkProgramm;
  Shader.UseProgram;
  with Shader do begin
    ModelMatrix_ID := UniformLocation('model');
    ViewMatrix_ID := UniformLocation('view');
    ProMatrix_ID := UniformLocation('proj');
    Color_ID := UniformLocation('overrideColor');
    glUniform1i(UniformLocation('texKitten'), 0);
  end;
  glUniform3f(Color_ID, 2.0, 2.0, 2.0);

  RotateMatrix.Identity;
  ViewMatrix.Identity;
  ViewMatrix.Translate(0, 0.3, -4);
  ViewMatrix.RotateA(2.0 + pi);
  ProdMatrix.Identity;
  ProdMatrix.Perspective(45, ClientWidth / ClientHeight, 0.1, 100.0);

  glEnable(GL_DEPTH_TEST);

  // Reflect
  glGenVertexArrays(1, @VAOReflect);
  glBindVertexArray(VAOReflect);
  glGenBuffers(1, @VBOReflect);

  glBindBuffer(GL_ARRAY_BUFFER, VBOReflect);
  glBufferData(GL_ARRAY_BUFFER, Length(verticesReflect) * sizeof(GLfloat), PGLvoid(verticesReflect), GL_STATIC_DRAW);

  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 3, GL_FLOAT, False, 8 * SizeOf(GLfloat), nil);

  glEnableVertexAttribArray(1);
  glVertexAttribPointer(1, 3, GL_FLOAT, False, 8 * SizeOf(GLfloat), PGLvoid(3 * SizeOf(GLfloat)));

  glEnableVertexAttribArray(2);
  glVertexAttribPointer(2, 2, GL_FLOAT, False, 8 * SizeOf(GLfloat), PGLvoid(6 * SizeOf(GLfloat)));

  // Cube
  glGenVertexArrays(1, @VAOCube);
  glBindVertexArray(VAOCube);
  glGenBuffers(1, @VBOCube);

  glBindBuffer(GL_ARRAY_BUFFER, VBOCube);
  glBufferData(GL_ARRAY_BUFFER, Length(verticesCube) * sizeof(GLfloat), PGLvoid(verticesCube), GL_STATIC_DRAW);

  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 3, GL_FLOAT, False, 8 * SizeOf(GLfloat), nil);

  glEnableVertexAttribArray(1);
  glVertexAttribPointer(1, 3, GL_FLOAT, False, 8 * SizeOf(GLfloat), PGLvoid(3 * SizeOf(GLfloat)));

  glEnableVertexAttribArray(2);
  glVertexAttribPointer(2, 2, GL_FLOAT, False, 8 * SizeOf(GLfloat), PGLvoid(6 * SizeOf(GLfloat)));

  // Uniform
  ViewMatrix.Uniform(ViewMatrix_ID);
  ProdMatrix.Uniform(ProMatrix_ID);

  Textur := TTexturBuffer.Create;
  Textur.LoadTextures('woodenbox.png');
  Textur.ActiveAndBind;
end;

procedure TForm1.ogcDrawScene(Sender: TObject);
var
  mat: TMatrix;
begin
  Shader.UseProgram;

  glClearColor(0.3, 0.1, 0.2, 1.0);
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);

  // Draw cube
  glBindVertexArray(VAOCube);
  mat.Identity;
  mat := mat * RotateMatrix;
  mat.Uniform(ModelMatrix_ID);
  glDrawArrays(GL_TRIANGLES, 0, 36);

  // Draw Reflect
  glBindVertexArray(VAOReflect);
  glEnable(GL_STENCIL_TEST);
  glStencilFunc(GL_ALWAYS, 1, $FF);
  glStencilOp(GL_KEEP, GL_KEEP, GL_REPLACE);
  glStencilMask($FF);
  glDepthMask(GL_FALSE);
  glClear(GL_STENCIL_BUFFER_BIT);
  glDrawArrays(GL_TRIANGLES, 0, 6);

  // Draw cube reflect
  glBindVertexArray(VAOCube);
  // glStencilFunc(GL_NOTEQUAL, 1, $FF);
  glStencilFunc(GL_EQUAL, 1, $FF);
  glStencilMask($00);
  glDepthMask(GL_TRUE);

  mat.TranslateZ(-1.0);
  mat.Scale(1, 1, -1);
  mat.Uniform(ModelMatrix_ID);
  glUniform3f(Color_ID, 0.3, 0.3, 0.3);
  glDrawArrays(GL_TRIANGLES, 0, 36);
  glUniform3f(Color_ID, 0.8, 0.8, 0.8);

  glDisable(GL_STENCIL_TEST);

  ogc.SwapBuffers;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Textur.Free;
  Shader.Free;

  Timer1.Enabled := False;

  glDeleteVertexArrays(1, @VAOCube);
  glDeleteBuffers(1, @VBOCube);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
const
  step: GLfloat = 0.02;
begin
  RotateMatrix.RotateC(step);
  ogcDrawScene(Sender);
end;

//lineal

(*
<b>Vertex-Shader:</b>
*)
//includeglsl Vertexshader.glsl
//lineal

(*
<b>Fragment-Shader:</b>
*)
//includeglsl Fragmentshader.glsl

end.
