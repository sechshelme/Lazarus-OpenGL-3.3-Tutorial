unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, OpenGLContext, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, Menus,
  oglContext, oglShader, oglVector,
  dglOpenGL;

type

  { TForm1 }

  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    ItemGL_EQUAL: TMenuItem;
    ItemGL_NOTEQUAL: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ItemGL_EQUALClick(Sender: TObject);
    procedure ItemGL_NOTEQUALClick(Sender: TObject);
  private
    ogc: TContext;
    Shader: TShader;
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

(*
Einfacher Stecil Buffer
<b>Wichtig</b> dabei, bei der Context-Erzeugung muss mitgeteilt werden, dan man Stencil verwenden will.
Ich habe dies bei der unit olgContext.pas eingebaut.
*)
//lineal

const
  Triangle: array[0..0] of TFace =
    (((-0.6, -0.8, 0.0), (0.6, -0.8, 0.0), (0.0, 0.7, 0.0)));
  Quad: array[0..1] of TFace =
    (((-0.4, -0.6, 0.0), (-0.4, 0.3, 0.0), (0.4, 0.3, 0.0)),
    ((-0.4, -0.6, 0.0), (0.4, 0.3, 0.0), (0.4, -0.6, 0.0)));

type
  TVB = record
    VAO,
    VBO: GLuint;
  end;

var
  VBTriangle, VBQuad: TVB;
  Color_ID: GLint;
  StencilEnum: GLenum = GL_EQUAL;

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
  Shader := TShader.Create;
  Shader.LoadShaderObjectFromFile(GL_VERTEX_SHADER, 'Vertexshader.glsl');
  Shader.LoadShaderObjectFromFile(GL_FRAGMENT_SHADER, 'Fragmentshader.glsl');
  Shader.LinkProgramm;
  Shader.UseProgram;
  Color_ID := Shader.UniformLocation('color');

  glGenVertexArrays(1, @VBTriangle.VAO);
  glGenVertexArrays(1, @VBQuad.VAO);

  glGenBuffers(1, @VBTriangle.VBO);
  glGenBuffers(1, @VBQuad.VBO);
end;

procedure TForm1.InitScene;
begin
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

  glEnable(GL_STENCIL_TEST);
end;

procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT or GL_STENCIL_BUFFER_BIT);
  Shader.UseProgram;

  // --- Zeichne Dreieck
  glUniform3f(Color_ID, 1, 0, 0);
  glBindVertexArray(VBTriangle.VAO);

  glStencilFunc(GL_ALWAYS, 1, $FF);
  glStencilOp(GL_KEEP, GL_KEEP, GL_REPLACE);

  glDrawArrays(GL_TRIANGLES, 0, Length(Triangle) * 3);

  // --- Zeichne Quadrat
  glUniform3f(Color_ID, 0, 1, 0);
  glBindVertexArray(VBQuad.VAO);

  glStencilFunc(StencilEnum, 1, $FF);

  glDrawArrays(GL_TRIANGLES, 0, Length(Quad) * 3);

  ogc.SwapBuffers;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Shader.Free;

  glDeleteVertexArrays(1, @VBTriangle.VAO);
  glDeleteVertexArrays(1, @VBQuad.VAO);

  glDeleteBuffers(1, @VBTriangle.VBO);
  glDeleteBuffers(1, @VBQuad.VBO);
end;

procedure TForm1.ItemGL_EQUALClick(Sender: TObject);
begin
  StencilEnum := GL_EQUAL;
  ogcDrawScene(Sender);
end;

procedure TForm1.ItemGL_NOTEQUALClick(Sender: TObject);
begin
  StencilEnum := GL_NOTEQUAL;
  ogcDrawScene(Sender);
end;

end.
