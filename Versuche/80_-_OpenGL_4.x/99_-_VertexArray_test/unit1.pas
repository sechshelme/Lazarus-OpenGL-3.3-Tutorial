unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  dglOpenGL,
  oglContext, oglVector, oglMatrix, oglShader;

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
  VAO, VB0ver, VBOcol: gluint;

const
  NumVertices = 6;

const
  vertices: array [0..NumVertices - 1] of TVector3f = (
    (-0.90, -0.90,0), // Triangle 1
    (0.85, -0.90,0),
    (-0.90, 0.85,0),
    (0.90, -0.85,0), // Triangle 2
    (0.90, 0.90,0),
    (-0.85, 0.90,0));

  colors: array [0..NumVertices - 1] of TVector3f = (
    (1, 0, 0),
    (0, 1, 0),
    (0, 0, 1),
    (1, 1, 0),
    (0, 1, 1),
    (1, 0, 1));


procedure TForm1.FormCreate(Sender: TObject);
begin
  Width := 340;
  Height := 240;
  ogc := TContext.Create(Self);
  ogc.OnPaint := @ogcDrawScene;

  CreateScene;
end;

procedure TForm1.CreateScene;
begin
  Shader := TShader.Create([FileToStr('Vertexshader.glsl'), FileToStr('Fragmentshader.glsl')]);
  Shader.UseProgram;

  glClearColor(1, 0, 0.5, 0);

  glCreateVertexArrays(1, @VAO);

  glCreateBuffers(1, @VB0ver);
  glCreateBuffers(1, @VBOcol);

  glNamedBufferData(VB0ver, SizeOf(vertices), @vertices, GL_STATIC_DRAW);
  glNamedBufferData(VBOcol, SizeOf(colors), @colors, GL_STATIC_DRAW);

  glEnableVertexArrayAttrib(VAO, 0);
  glVertexArrayAttribFormat(VAO, 0, 3, GL_FLOAT, GL_FALSE, 0);
  glVertexArrayAttribBinding(VAO, 0, 0);
  glVertexArrayVertexBuffer(VAO, 0, VB0ver, 0, SizeOf(TVector3f));

  glEnableVertexArrayAttrib(VAO, 1);
  glVertexArrayAttribFormat(VAO, 1, 3, GL_FLOAT, GL_FALSE, 0);
  glVertexArrayAttribBinding(VAO, 1, 1);
  glVertexArrayVertexBuffer(VAO, 1, VBOcol, 0, SizeOf(TVector3f));
end;

procedure TForm1.ogcDrawScene(Sender: TObject);
const
  black: TVector4f = (0, 0.5, 0, 0);
begin
  glClearBufferfv(GL_COLOR, 0, black);

  glBindVertexArray(VAO);
  glDrawArrays(GL_TRIANGLES, 0, NumVertices);

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
