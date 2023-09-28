unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  dglOpenGL,
  oglContext, oglVector, oglMatrix, oglShader,oglLogForm;

type
  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    ogc: TContext;
    Shader: TShader;
    procedure CreateScene;
    procedure ogcDrawScene(Sender: TObject);
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

// https://gist.github.com/cagelight/3eb282c683fb9c9be666

var
  VAO, VBO: gluint;



procedure TForm1.FormCreate(Sender: TObject);
begin
  Width := 340;
  Height := 240;
  ogc := TContext.Create(Self);
  ogc.OnPaint := @ogcDrawScene;

  CreateScene;
end;

// https://github.com/NeilMonday/ogl-samples/blob/master/tests/gl-430-draw-vertex-attrib-binding.cpp

const
  vertices: array of TVector3f = (
    (-0.90, -0.90, 0), (1, 0, 0),
    (0.85, -0.90, 0), (0, 1, 0),
    (-0.90, 0.85, 0), (0, 0, 1),
    (0.90, -0.85, 0), (1, 0, 0),
    (0.90, 0.90, 0), (0, 1, 0),
    (-0.85, 0.90, 0), (0, 0, 1));

procedure TForm1.CreateScene;
begin
  InitOpenGLDebug;
  LogForm.Show;

  Shader := TShader.Create([GL_VERTEX_SHADER, FileToStr('Vertexshader.glsl'), GL_FRAGMENT_SHADER, FileToStr('Fragmentshader.glsl')]);
  Shader.UseProgram;

  glCreateBuffers(1, @VBO);
  glNamedBufferData(VBO, Length(vertices) * SizeOf(TVector3f), PVector3f(vertices), GL_STATIC_DRAW);

  glGenVertexArrays(1, @VAO);
  glBindVertexArray(VAO);

  glVertexAttribBinding(0, 0);
  glVertexAttribFormat(0, 3, GL_FLOAT, GL_FALSE, 0);
  glEnableVertexAttribArray(0);

  glVertexAttribBinding(1, 1);
  glVertexAttribFormat(1, 3, GL_FLOAT, GL_FALSE, SizeOf(TVector3f));
  glEnableVertexAttribArray(1);

  glBindVertexBuffer(0, VBO, 0, 24);
  glBindVertexBuffer(1, VBO, 0, 24);
end;

procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  glClearColor(12,12,12,12);
  glClearBufferfv(GL_COLOR, 0, vec4(10.5, 0.0, 0.5, 1.0));

  glBindVertexArray(VAO);
  glDrawArrays(GL_TRIANGLES, 0, Length(vertices));

  ogc.SwapBuffers;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Shader.Free;
end;

(*
<b>Vertex-Shader:</b>
*)
//includeglsl Vertexshader.glsl
//lineal

(*
<b>Fragment-Shader:</b>

Hier wird der Tiefenwert korrigiert.
*)
//includeglsl Fragmentshader.glsl

end.
