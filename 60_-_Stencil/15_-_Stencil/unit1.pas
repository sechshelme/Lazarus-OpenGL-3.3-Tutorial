unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, Menus,
  oglglad_gl,
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
    Shader, ShaderSingelColor: TShader; // Shader Klasse
    procedure CreateScene;
    procedure InitScene;
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

const

  // --- Vectoren
  QuadVertex: array[0..35] of TVector3f =
    ((-0.5, 0.5, 0.5), (-0.5, -0.5, 0.5), (0.5, -0.5, 0.5), (-0.5, 0.5, 0.5), (0.5, -0.5, 0.5), (0.5, 0.5, 0.5),
    (0.5, 0.5, 0.5), (0.5, -0.5, 0.5), (0.5, -0.5, -0.5), (0.5, 0.5, 0.5), (0.5, -0.5, -0.5), (0.5, 0.5, -0.5),
    (0.5, 0.5, -0.5), (0.5, -0.5, -0.5), (-0.5, -0.5, -0.5), (0.5, 0.5, -0.5), (-0.5, -0.5, -0.5), (-0.5, 0.5, -0.5),
    (-0.5, 0.5, -0.5), (-0.5, -0.5, -0.5), (-0.5, -0.5, 0.5), (-0.5, 0.5, -0.5), (-0.5, -0.5, 0.5), (-0.5, 0.5, 0.5),
    // oben
    (0.5, 0.5, 0.5), (0.5, 0.5, -0.5), (-0.5, 0.5, -0.5), (0.5, 0.5, 0.5), (-0.5, 0.5, -0.5), (-0.5, 0.5, 0.5),
    // unten
    (-0.5, -0.5, 0.5), (-0.5, -0.5, -0.5), (0.5, -0.5, -0.5), (-0.5, -0.5, 0.5), (0.5, -0.5, -0.5), (0.5, -0.5, 0.5));

  // --- Texturkoordinaten
  TextureVertex: array[0..35] of TVector2f =
    ((0.0, 1.0), (0.0, 0.0), (1.0, 0.0), (0.0, 1.0), (1.0, 0.0), (1.0, 1.0),
    (0.0, 1.0), (0.0, 0.0), (1.0, 0.0), (0.0, 1.0), (1.0, 0.0), (1.0, 1.0),
    (0.0, 1.0), (0.0, 0.0), (1.0, 0.0), (0.0, 1.0), (1.0, 0.0), (1.0, 1.0),
    (0.0, 1.0), (0.0, 0.0), (1.0, 0.0), (0.0, 1.0), (1.0, 0.0), (1.0, 1.0),
    (0.0, 1.0), (0.0, 0.0), (1.0, 0.0), (0.0, 1.0), (1.0, 0.0), (1.0, 1.0),
    (0.0, 1.0), (0.0, 0.0), (1.0, 0.0), (0.0, 1.0), (1.0, 0.0), (1.0, 1.0));

const
  stencil_testing_Vertex =
    '#version 330 core' + #10 +
    'layout (location = 0) in vec3 aPos;' + #10 +
    'layout (location = 1) in vec2 aTexCoords;' + #10 +
    '' + #10 +
    'out vec2 TexCoords;' + #10 +
    '' + #10 +
    'uniform mat4 model;' + #10 +
    //    'uniform mat4 view;' + #10 +
    'uniform mat4 projection;' + #10 +
    '' + #10 +
    'void main()' + #10 +
    '{' + #10 +
    '    TexCoords = aTexCoords;' + #10 +
    //    '    gl_Position = projection * view * model * vec4(aPos, 1.0f);' + #10 +
    '    gl_Position = projection * model * vec4(aPos, 1.0f);' + #10 +
    '}';
  stencil_testing_Fragment =
    '#version 330 core' + #10 +
    'out vec4 FragColor;' + #10 +
    '' + #10 +
    'in vec2 TexCoords;' + #10 +
    '' + #10 +
    'uniform sampler2D Sampler;' + #10 +
    '' + #10 +
    'void main()' + #10 +
    '{' + #10 +
    '    FragColor = texture(Sampler, TexCoords);' + #10 +
    '}';
  stencil_single_color_Fragment =
    '#version 330 core' + #10 +
    'out vec4 FragColor;' + #10 +
    '' + #10 +
    'void main()' + #10 +
    '{' + #10 +
    '    FragColor = vec4(0.04, 0.28, 0.26, 1.0);' + #10 +
    '}';



type
  TVB = record
    VAO,
    VBOVertex,        // Vertex-Koordinaten
    VBOTex: GLuint;   // Textur-Koordianten
  end;

(*
Den Textur-Puffer deklarieren.
*)
  //code+
var
  Textur: TTexturBuffer;
  //code-

  VBQuad: TVB;
  PerspectiveMatrix,
  WorldMatrix,

  RotMatrix, ScaleMatrix, ProdMatrix,
  ModelMatrix: TMatrix;

  ModelMatrix_ID,
  ProMatrix_ID: GLint;

  { TForm1 }

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
  InitScene;
  Timer1.Enabled := True;
end;

(*
Textur-Puffer erzeugen.
*)
//code+
procedure TForm1.CreateScene;
begin
  Textur := TTexturBuffer.Create;
  Textur.LoadTextures('mauer.bmp');
  //code-

  glGenVertexArrays(1, @VBQuad.VAO);
  glGenBuffers(1, @VBQuad.VBOVertex);
  glGenBuffers(1, @VBQuad.VBOTex);

  //   configure global opengl state
  //   -----------------------------
  glEnable(GL_DEPTH_TEST);
  glDepthFunc(GL_LESS);
  glEnable(GL_STENCIL_TEST);
  glStencilFunc(GL_NOTEQUAL, 1, $FF);
  glStencilOp(GL_KEEP, GL_KEEP, GL_REPLACE);


  Shader := TShader.Create;
  Shader.LoadShaderObject(GL_VERTEX_SHADER, stencil_testing_Vertex);
  Shader.LoadShaderObject(GL_FRAGMENT_SHADER, stencil_testing_Fragment);
  Shader.LinkProgram;
  Shader.UseProgram;
  with Shader do begin
    ProMatrix_ID := UniformLocation('projection');
    ModelMatrix_ID := UniformLocation('model');
    glUniform1i(UniformLocation('Sampler'), 0);
  end;

  ShaderSingelColor := TShader.Create;
  ShaderSingelColor.LoadShaderObject(GL_VERTEX_SHADER, stencil_testing_Vertex);
  ShaderSingelColor.LoadShaderObject(GL_FRAGMENT_SHADER, stencil_single_color_Fragment);
  ShaderSingelColor.LinkProgram;
  ShaderSingelColor.UseProgram;
  with ShaderSingelColor do begin
    ProMatrix_ID := UniformLocation('projection');
    ModelMatrix_ID := UniformLocation('model');
    glUniform1i(UniformLocation('Sampler'), 0);
  end;


  RotMatrix.Identity;
  ScaleMatrix.Identity;
  ScaleMatrix.Scale(0.2);
  ProdMatrix.Identity;
  PerspectiveMatrix.Identity;
  PerspectiveMatrix.Perspective(45, ClientWidth / ClientHeight, 0.1, 100.0);

  WorldMatrix.Identity;
  WorldMatrix.Translate(0, 0, -30.0);
  WorldMatrix.Scale(5);

end;

procedure TForm1.InitScene;
begin
  glBindVertexArray(VBQuad.VAO);

  // Vertex
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBOVertex);
  glBufferData(GL_ARRAY_BUFFER, sizeof(QuadVertex), @QuadVertex, GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 0, nil);

  // Textur-Koordinaten
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBOTex);
  glBufferData(GL_ARRAY_BUFFER, sizeof(TextureVertex), @TextureVertex, GL_STATIC_DRAW);
  glEnableVertexAttribArray(1);
  glVertexAttribPointer(1, 2, GL_FLOAT, GL_FALSE, 0, nil);
end;

procedure TForm1.ogcDrawScene(Sender: TObject);
const
  scale: GLfloat = 1.1;

begin
  glClearColor(0.1, 0.1, 0.1, 1.0);
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT or GL_STENCIL_BUFFER_BIT); // Stencil ein

  ScaleMatrix.Identity;
  RotMatrix.Identity;

  ModelMatrix.Identity;
  ShaderSingelColor.UseProgram;
  ProdMatrix := PerspectiveMatrix*WorldMatrix* ScaleMatrix * RotMatrix;
  ProdMatrix.Uniform(ProMatrix_ID);

  Shader.UseProgram;
  ProdMatrix := PerspectiveMatrix*WorldMatrix*ScaleMatrix * RotMatrix;
  ProdMatrix.Uniform(ProMatrix_ID);



  // 1st. render pass, draw objects as normal, writing to the stencil buffer
  // --------------------------------------------------------------------
  glStencilFunc(GL_ALWAYS, 1, $FF);
  glStencilMask($FF);

  // cubes
  glBindVertexArray(VBQuad.VAO);
  Textur.ActiveAndBind;
  ModelMatrix.Translate(-1.0, 0.0, -1.0);
  ModelMatrix.Uniform(ModelMatrix_ID);
  glDrawArrays(GL_TRIANGLES, 0, Length(QuadVertex));

  ModelMatrix.Identity;
  ModelMatrix.Translate(2.0, 0.0, 0.0);
  ModelMatrix.Uniform(ModelMatrix_ID);
  glDrawArrays(GL_TRIANGLES, 0, Length(QuadVertex));

  // 2nd. render pass: now draw slightly scaled versions of the objects, this time disabling stencil writing.
  // Because the stencil buffer is now filled with several 1s. The parts of the buffer that are 1 are not drawn, thus only drawing
  // the objects' size differences, making it look like borders.
  // -----------------------------------------------------------------------------------------------------------------------------
  glStencilFunc(GL_NOTEQUAL, 1, $FF);
  glStencilMask($00);
  glDisable(GL_DEPTH_TEST);
  ShaderSingelColor.UseProgram;
  // cubes
  glBindVertexArray(VBQuad.VAO);
  Textur.ActiveAndBind;

  ModelMatrix.Identity;
  ModelMatrix.Translate(-1.0, 0.0, -1.0);
  ModelMatrix.Scale(scale);
  ModelMatrix.Uniform(ModelMatrix_ID);
  glDrawArrays(GL_TRIANGLES, 0, Length(QuadVertex));

  ModelMatrix.Identity;
  ModelMatrix.Translate(2.0, 0.0, 0.0);
  ModelMatrix.Scale(scale);
  ModelMatrix.Uniform(ModelMatrix_ID);

  glDrawArrays(GL_TRIANGLES, 0, Length(QuadVertex));
  glBindVertexArray(0);
  glStencilMask($FF);
  glStencilFunc(GL_ALWAYS, 0, $FF);
  glEnable(GL_DEPTH_TEST);

  ogc.SwapBuffers;
end;

(*
Am Ende muss man die Klasse noch frei geben.
*)
//code+
procedure TForm1.FormDestroy(Sender: TObject);
begin
  Textur.Free;
  //code-

  Timer1.Enabled := False;

  glDeleteVertexArrays(1, @VBQuad.VAO);
  glDeleteBuffers(1, @VBQuad.VBOVertex);
  glDeleteBuffers(1, @VBQuad.VBOTex);

  Shader.Free;
  ShaderSingelColor.Free;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
const
  step: GLfloat = 0.01;
begin
  RotMatrix.RotateC(step);
  ogcDrawScene(Sender);
end;

//lineal

(*
<b>Vertex-Shader:</b>
*)
//-------includeglsl Vertexshader.glsl
//lineal

(*
<b>Fragment-Shader:</b>
*)
//-----------includeglsl Fragmentshader.glsl

end.
