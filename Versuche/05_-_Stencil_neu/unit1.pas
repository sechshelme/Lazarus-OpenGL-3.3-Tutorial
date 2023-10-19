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
  vertices: array of GLfloat = (
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
    -0.5, 0.5, -0.5, 1.0, 1.0, 1.0, 0.0, 1.0,

    -1.0, -1.0, -0.5, 0.0, 0.0, 0.0, 0.0, 0.0,
    1.0, -1.0, -0.5, 0.0, 0.0, 0.0, 1.0, 0.0,
    1.0, 1.0, -0.5, 0.0, 0.0, 0.0, 1.0, 1.0,
    1.0, 1.0, -0.5, 0.0, 0.0, 0.0, 1.0, 1.0,
    -1.0, 1.0, -0.5, 0.0, 0.0, 0.0, 0.0, 1.0,
    -1.0, -1.0, -0.5, 0.0, 0.0, 0.0, 0.0, 0.0);

const
  Vertex_Shader =
    '#version 330 core' + #10 +
    'layout (location = 0) in vec3 position;' + #10 +
    'layout (location = 1) in vec3 color;' + #10 +
    'layout (location = 2) in vec2 texcoord;' + #10 +
    'out vec3 Color;' + #10 +
    'out vec2 Texcoord;' + #10 +
    'uniform mat4 model;' + #10 +
    'uniform mat4 view;' + #10 +
    'uniform mat4 proj;' + #10 +
    'uniform vec3 overrideColor;' + #10 +
    'void main()' + #10 +
    '{' + #10 +
    '    Color = overrideColor * color;' + #10 +
    '    Texcoord = texcoord;' + #10 +
    '    gl_Position = proj * view * model * vec4(position, 1.0);' + #10 +
    '}';

  Fragment_Shader =
    '#version 330 core' + #10 +
    'in vec3 Color;' + #10 +
    'in vec2 Texcoord;' + #10 +
    'out vec4 outColor;' + #10 +
    'uniform sampler2D texKitten;' + #10 +
    'uniform sampler2D texPuppy;' + #10 +
    'void main()' + #10 +
    '{' + #10 +
    //    '    outColor = vec4(Color, 1.0) * mix(texture(texKitten, Texcoord), texture(texPuppy, Texcoord), 0.5);' + #10 +
    '    outColor = vec4(Color, 1.0) * texture(texKitten, Texcoord);' + #10 +
    '}';


var
  Textur: TTexturBuffer;

  VAO, VBO: GLuint;
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
//  ogc.StencilBits:=0;
  ogc.OnPaint := @ogcDrawScene;
  WriteLn(ogc.StencilBits);
  WriteLn(ogc.DepthBits);
  //  ogc.DepthBits:=24;

  CreateScene;
  Timer1.Enabled := True;
end;

procedure TForm1.CreateScene;
begin
  Shader := TShader.Create;
  Shader.LoadShaderObject(GL_VERTEX_SHADER, Vertex_Shader);
  Shader.LoadShaderObject(GL_FRAGMENT_SHADER, Fragment_Shader);
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
  ViewMatrix.TranslateZ(-4);
  ViewMatrix.RotateA(2.0 + pi);
  ProdMatrix.Identity;
  ProdMatrix.Perspective(45, ClientWidth / ClientHeight, 0.1, 100.0);

  glEnable(GL_DEPTH_TEST);

  glGenVertexArrays(1, @VAO);
  glBindVertexArray(VAO);
  glGenBuffers(1, @VBO);

  // Vertex
  glBindBuffer(GL_ARRAY_BUFFER, VBO);
  glBufferData(GL_ARRAY_BUFFER, Length(vertices) * sizeof(GLfloat), PGLvoid(vertices), GL_STATIC_DRAW);

  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 3, GL_FLOAT, False, 8 * SizeOf(GLfloat), nil);

  glEnableVertexAttribArray(1);
  glVertexAttribPointer(1, 3, GL_FLOAT, False, 8 * SizeOf(GLfloat), PGLvoid(3 * SizeOf(GLfloat)));

  glEnableVertexAttribArray(2);
  glVertexAttribPointer(2, 2, GL_FLOAT, False, 8 * SizeOf(GLfloat), PGLvoid(6 * SizeOf(GLfloat)));

  ViewMatrix.Uniform(ViewMatrix_ID);
  ProdMatrix.Uniform(ProMatrix_ID);

  Textur := TTexturBuffer.Create;
  Textur.LoadTextures('mauer.bmp');
  Textur.ActiveAndBind;
end;

procedure TForm1.ogcDrawScene(Sender: TObject);
var
  mat: TMatrix;
begin
  glBindVertexArray(VAO);
  Shader.UseProgram;

  glClearColor(1.0, 1.0, 1.0, 1.0);
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);

  // Draw cube
  mat.Identity;
  mat:=mat * RotateMatrix;
  mat.Uniform(ModelMatrix_ID);
  glDrawArrays(GL_TRIANGLES, 0, 36);

  // Draw floor
  glEnable(GL_STENCIL_TEST);
  glStencilFunc(GL_ALWAYS, 1, $FF);
  glStencilOp(GL_KEEP, GL_KEEP, GL_REPLACE);
  glStencilMask($FF);
  glDepthMask(GL_FALSE);
  glClear(GL_STENCIL_BUFFER_BIT);
  glDrawArrays(GL_TRIANGLES, 36, 6);

  // Draw cube reflect
 // glStencilFunc(GL_NOTEQUAL, 1, $FF);
  glStencilFunc(GL_EQUAL, 1, $FF);
  glStencilMask($00);
 glDepthMask(GL_TRUE);

  mat.TranslateZ(-1.0);
  mat.Scale(1, 1, -1);
  mat.Uniform(ModelMatrix_ID);
  glUniform3f(Color_ID, 0.3, 0.3, 0.3);
  glDrawArrays(GL_TRIANGLES, 0, 36);
  glUniform3f(Color_ID, 1.0, 1.0, 1.0);

  glDisable(GL_STENCIL_TEST);

  ogc.SwapBuffers;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Textur.Free;
  Shader.Free;

  Timer1.Enabled := False;

  glDeleteVertexArrays(1, @VAO);
  glDeleteBuffers(1, @VBO);
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
