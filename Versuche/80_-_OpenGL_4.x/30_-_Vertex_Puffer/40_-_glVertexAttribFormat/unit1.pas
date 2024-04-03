unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  oglglad_gl,
  oglContext, oglVector, oglMatrix, oglShader, oglDebug;

type

  { TForm1 }

  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    ogc: TContext;
    Shader: TShader;
    procedure CreateScene;
    procedure ogcDrawScene(Sender: TObject);
    procedure ogcKeyPress(Sender: TObject; var Key: char);
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

// https://gist.github.com/cagelight/3eb282c683fb9c9be666

var
  VAO0, VAO1, VBO0, VBO1: gluint;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Width := 340;
  Height := 240;
  ogc := TContext.Create(Self);
  ogc.OnPaint := @ogcDrawScene;

  ogc.OnKeyPress := @ogcKeyPress;

  CreateScene;
end;

// https://github.com/NeilMonday/ogl-samples/blob/master/tests/gl-430-draw-vertex-attrib-binding.cpp

const
  vertices0: array of TVector3f = (
    (-0.90, -0.90, 0), (1, 0, 0), (-0.10, -0.90, 0), (0, 1, 0), (-0.90, 0.85, 0), (0, 0, 1),
    (-0.05, -0.85, 0), (1, 0, 0), (-0.05, 0.90, 0), (0, 1, 0), (-0.85, 0.90, 0), (0, 0, 1));

  vertices1: array of TVector3f = (
    (0.10, -0.90, 0), (0.90, -0.90, 0), (0.10, 0.85, 0), (0.95, -0.85, 0), (0.95, 0.90, 0), (0.15, 0.90, 0),
    (1, 0, 0), (0, 1, 0), (0, 0, 1), (1, 0, 0), (0, 1, 0), (0, 0, 1));

procedure TForm1.CreateScene;
begin
  Shader := TShader.Create;
  Shader.LoadShaderObjectFromFile(GL_VERTEX_SHADER, 'Vertexshader.glsl');
  Shader.LoadShaderObjectFromFile(GL_FRAGMENT_SHADER, 'Fragmentshader.glsl');
  Shader.LinkProgram;
  Shader.UseProgram;

  // Mesh 0
  glCreateBuffers(1, @VBO0);
  glNamedBufferData(VBO0, Length(vertices0) * SizeOf(TVector3f), PVector3f(vertices0), GL_STATIC_DRAW);

  glGenVertexArrays(1, @VAO0);
  glBindVertexArray(VAO0);

  glVertexAttribBinding(0, 0);
  glVertexAttribFormat(0, 3, GL_FLOAT, GL_FALSE, 0);
  glEnableVertexAttribArray(0);

  glVertexAttribBinding(1, 0);
  glVertexAttribFormat(1, 3, GL_FLOAT, GL_FALSE, 12);
  glEnableVertexAttribArray(1);

  glBindVertexBuffer(0, VBO0, 0, 24);

  // Mesh 1
  glCreateBuffers(1, @VBO1);
  glNamedBufferData(VBO1, Length(vertices1) * SizeOf(TVector3f), PVector3f(vertices1), GL_STATIC_DRAW);

  glGenVertexArrays(1, @VAO1);
  glBindVertexArray(VAO1);

  glVertexAttribBinding(0, 10);
  glVertexAttribFormat(0, 3, GL_FLOAT, GL_FALSE, 0);
  glEnableVertexAttribArray(0);

  glVertexAttribBinding(1, 10);
  glVertexAttribFormat(1, 3, GL_FLOAT, GL_FALSE, 72);
  glEnableVertexAttribArray(1);

  glBindVertexBuffer(10, VBO1, 0, 12);
end;

procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  glClearBufferfv(GL_COLOR, 0, vec4(0.5, 0.0, 0.5, 1.0));

  glBindVertexArray(VAO0);
  glDrawArrays(GL_TRIANGLES, 0, 6);

  glBindVertexArray(VAO1);
  glDrawArrays(GL_TRIANGLES, 0, 6);

  ogc.SwapBuffers;
end;

procedure TForm1.ogcKeyPress(Sender: TObject; var Key: char);
const
  YellowBuffer: array of TVector3f = ((1, 1, 0), (1, 1, 0), (1, 1, 0));
var
  v: TVector3f;
  YellowVBO: gluint;

  procedure NewVector;
  begin
    glNamedBufferSubData(VBO0, SizeOf(TVector3f) * 1, SizeOf(v), @v);
    glNamedBufferSubData(VBO0, SizeOf(TVector3f) * 3, SizeOf(v), @v);
    glNamedBufferSubData(VBO0, SizeOf(TVector3f) * 5, SizeOf(v), @v);

    glNamedBufferSubData(VBO1, SizeOf(TVector3f) * (6 + 0), SizeOf(v), @v);
    glNamedBufferSubData(VBO1, SizeOf(TVector3f) * (6 + 1), SizeOf(v), @v);
    glNamedBufferSubData(VBO1, SizeOf(TVector3f) * (6 + 2), SizeOf(v), @v);
  end;

begin
  case key of
    #27: begin
      Close;
    end;
    'r': begin
      v := [1, 0, 0];
      NewVector;
    end;
    'g': begin
      v := [0, 1, 0];
      NewVector;
    end;
    'b': begin
      v := [0, 0, 1];
      NewVector;
    end;
    'z': begin
      v.Random;
      NewVector;
    end;
    'c': begin
      glCopyNamedBufferSubData(VBO1, VBO1, 72, 72 + 36, 36);
    end;
    'd': begin
      glCopyNamedBufferSubData(VBO1, VBO0, 72 + 12, 72 + 12 + 24, 12);
    end;
    'y': begin
      // YellowBuffer
      glCreateBuffers(1, @YellowVBO);
      glNamedBufferData(YellowVBO, Length(YellowBuffer) * SizeOf(TVector3f), PVector3f(YellowBuffer), GL_STATIC_DRAW);

      glCopyNamedBufferSubData(YellowVBO, VBO1, 0, 72, 36);
      glDeleteBuffers(1, @YellowVBO);
    end;
  end;

  ogcDrawScene(Sender);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Shader.Free;

  glDeleteVertexArrays(1, @VAO0);
  glDeleteVertexArrays(1, @VAO1);

  glDeleteBuffers(1, @VBO0);
  glDeleteBuffers(1, @VBO1);
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
