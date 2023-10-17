unit Unit1;

{$mode objfpc}{$H+}
{$modeswitch typehelpers}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, Menus,
  dglOpenGL, oglVector, oglMatrix,
  oglContext, oglShader,oglTextur;

type

  { TForm1 }

  TForm1 = class(TForm)
    Image1: TImage;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    ogc: TContext;
    Shader: TShader; // Shader Klasse
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

(*
*)
const
  Triangle: array[0..0] of TFace =
    (((-0.4, 0.1, 0.0), (0.4, 0.1, 0.0), (0.0, 0.7, 0.0)));
  Quad: array[0..1] of TFace =
    (((-0.2, -0.6, 0.0), (-0.2, -0.1, 0.0), (0.2, -0.1, 0.0)),
    ((-0.2, -0.6, 0.0), (0.2, -0.1, 0.0), (0.2, -0.6, 0.0)));

type
  TVB = record
    VAO,
    VBO: GLuint;
  end;

var
  MatrixRot: TMatrix;     // Matrix
  MatrixRot_ID: GLint;    // ID für Matrix.
  Color_ID: GLint;

  VBTriangle, VBQuad: TVB;
var
  Texture: TTexturBuffer;


  { TForm1 }

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
  Timer1.Enabled := True;
end;

// https://learnopengl.com/code_viewer_gh.php?code=src/4.advanced_opengl/2.stencil_testing/stencil_testing.cpp
// https://learnopengl.com/Advanced-OpenGL/Stencil-testing

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
//    'uniform mat4 projection;' + #10 +
    '' + #10 +
    'void main()' + #10 +
    '{' + #10 +
    '    TexCoords = aTexCoords;' + #10 +
//    '    gl_Position = projection * view * model * vec4(aPos, 1.0f);' + #10 +
    '    gl_Position = model * vec4(aPos, 1.0f);' + #10 +
    '}';
  stencil_testing_Fragment =
    '#version 330 core' + #10 +
    'out vec4 FragColor;' + #10 +
    '' + #10 +
    'in vec2 TexCoords;' + #10 +
    '' + #10 +
    'uniform sampler2D texture1;' + #10 +
    '' + #10 +
    'void main()' + #10 +
    '{' + #10 +
    '    FragColor = texture(texture1, TexCoords);' + #10 +
    '}';
  stencil_single_color_Fragment =
    '#version 330 core' + #10 +
    'out vec4 FragColor;' + #10 +
    '' + #10 +
    'void main()' + #10 +
    '{' + #10 +
    '    FragColor = vec4(0.04, 0.28, 0.26, 1.0);' + #10 +
    '}';



procedure TForm1.CreateScene;
begin
  //Shader := TShader.Create;
  //Shader.LoadShaderObjectFromFile(GL_VERTEX_SHADER, 'Vertexshader.glsl');
  //Shader.LoadShaderObjectFromFile(GL_FRAGMENT_SHADER, 'Fragmentshader.glsl');
  //Shader.LinkProgramm;
  //Shader.UseProgram;

  Shader := TShader.Create;
  Shader.LoadShaderObject(GL_VERTEX_SHADER, stencil_testing_Vertex);
  Shader.LoadShaderObject(GL_FRAGMENT_SHADER, stencil_testing_Fragment);
  Shader.LinkProgramm;
  Shader.UseProgram;

  Texture:=TTexturBuffer.Create;

  Color_ID := Shader.UniformLocation('Color');
  MatrixRot_ID := Shader.UniformLocation('model');
  MatrixRot.Identity;


  glGenVertexArrays(1, @VBTriangle.VAO);
  glGenVertexArrays(1, @VBQuad.VAO);

  glGenBuffers(1, @VBTriangle.VBO);
  glGenBuffers(1, @VBQuad.VBO);
end;

procedure TForm1.InitScene;
begin
  glEnable(GL_DEPTH_TEST);
  glDepthFunc(GL_LESS);
  glEnable(GL_STENCIL_TEST);
  glStencilFunc(GL_NOTEQUAL, 1, $FF);
  glStencilOp(GL_KEEP, GL_KEEP, GL_REPLACE);
  glClearColor(0.6, 0.6, 0.4, 1.0); // Hintergrundfarbe

  // Daten für Dreieck
  glBindVertexArray(VBTriangle.VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBTriangle.VBO);
  glBufferData(GL_ARRAY_BUFFER, sizeof(Triangle), @Triangle, GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 3, GL_FLOAT, False, 0, nil);

  // Daten für Quadrat
  glBindVertexArray(VBQuad.VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBO);
  glBufferData(GL_ARRAY_BUFFER, sizeof(Quad), @Quad, GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 3, GL_FLOAT, False, 0, nil);
end;

procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT or GL_STENCIL_BUFFER_BIT); // Stencil ein
  glStencilMask($FF);

  Shader.UseProgram;
  glUniformMatrix4fv(MatrixRot_ID, 1, False, @MatrixRot); // MatrixRot in den Shader.

  // Zeichne Dreieck
  glUniform3f(Color_ID, 0.0, 1.0, 1.0);
  glBindVertexArray(VBTriangle.VAO);
  glDrawArrays(GL_TRIANGLES, 0, Length(Triangle) * 3);

  // Zeichne Quadrat
  glUniform3f(Color_ID, 1.0, 0.0, 1.0);
  glBindVertexArray(VBQuad.VAO);
  glDrawArrays(GL_TRIANGLES, 0, Length(Quad) * 3);

  ogc.SwapBuffers;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Timer1.Enabled := False;

  Shader.Free;

  glDeleteVertexArrays(1, @VBTriangle.VAO);
  glDeleteVertexArrays(1, @VBQuad.VAO);

  glDeleteBuffers(1, @VBTriangle.VBO);
  glDeleteBuffers(1, @VBQuad.VBO);
end;

procedure TForm1.Image1Click(Sender: TObject);
begin

end;

procedure TForm1.Timer1Timer(Sender: TObject);
const
  step: GLfloat = 0.01;          // Der Winkel ist im Bogenmass.
begin
  MatrixRot.RotateC(step);        // MatrixRot rotieren.
  ogcDrawScene(Sender);          // Neu zeichnen.
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
