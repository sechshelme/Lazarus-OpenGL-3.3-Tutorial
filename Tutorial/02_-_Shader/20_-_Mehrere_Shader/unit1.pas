unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls,
  dglOpenGL,
  oglContext, oglShader;

type

  { TForm1 }

  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    ogc: TContext;
    Shader: array[0..1] of TShader; // Shader-Objecte
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
Hier wird gezeigt, wie man mit mehreren Shader arbeitet. In diesem Beispiel sind es zwei.
Der Unterschied der beiden Shader ist, dass der eine das Mesh grün färbt, der andere rot.
Normalerweise würde man dies mit nur einem Shader über eine Uniform-Variable realisieren, jedoch geht es hier darum zu zeigen, wie man mehrere Shader verwendet.
*)

//lineal

type
  TVertex3f = array[0..2] of GLfloat;
  TFace = array[0..2] of TVertex3f;

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
  VBTriangle, VBQuad: TVB;

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
end;

(*
In diesem Codeausschnitt sind die ersten beiden Zeilen interessant.
Hier werden die zwei Shader in die Grafikkarte geladen.

Der Vertex-Shader ist in beiden Shader-Programs der Gleiche, daher wird zwei mal die gleiche glsl-Datei geladen.
*)

//code+
procedure TForm1.CreateScene;
begin
  Shader[0] := TShader.Create([FileToStr('Vertexshader.glsl'), FileToStr('Fragmentshader0.glsl')]);
  Shader[1] := TShader.Create([FileToStr('Vertexshader.glsl'), FileToStr('Fragmentshader1.glsl')]);
  //code-

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
  glEnableVertexAttribArray(10);
  glVertexAttribPointer(10, 3, GL_FLOAT, False, 0, nil);

  // Daten für Quadrat
  glBindVertexArray(VBQuad.VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBO);
  glBufferData(GL_ARRAY_BUFFER, sizeof(Quad), @Quad, GL_STATIC_DRAW);
  glEnableVertexAttribArray(10);
  glVertexAttribPointer(10, 3, GL_FLOAT, False, 0, nil);
end;

(*
Beim Zeichnen muss man jetzt tatsächlich mit <b>Shader[x].UseProgram(...</b> den Shader wählen, da mehr als ein Shader verwendet wird.
Die Meshes sollten nun zwei verschiedene Farben haben.
*)

procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT);


//code+
  // Zeichne Dreieck
  Shader[0].UseProgram;  //  Shader 0 wählen  ( Rot )
  glBindVertexArray(VBTriangle.VAO);
  glDrawArrays(GL_TRIANGLES, 0, Length(Triangle) * 3);

  // Zeichne Quadrat
  Shader[1].UseProgram;  //  Shader 1 wählen  ( Grün )
  glBindVertexArray(VBQuad.VAO);
  glDrawArrays(GL_TRIANGLES, 0, Length(Quad) * 3);

  //code-
  ogc.SwapBuffers;
end;

(*
Am Ende noch mit <b>Shader[x].Free</b> die Shader in der Grafikkarte wieder freigeben.
*)

//code+
procedure TForm1.FormDestroy(Sender: TObject);
begin
  Shader[0].Free;
  Shader[1].Free;
  //code-

  glDeleteVertexArrays(1, @VBTriangle.VAO);
  glDeleteVertexArrays(1, @VBQuad.VAO);

  glDeleteBuffers(1, @VBTriangle.VBO);
  glDeleteBuffers(1, @VBQuad.VBO);
end;

//lineal
(*
<b>Fragment-Shader 0:</b>
*)
//includeglsl Fragmentshader0.glsl

(*
<b>Fragment-Shader 1:</b>
*)
//includeglsl Fragmentshader1.glsl
(*
In der zweitletzten Zeile sieht man, dass man eine andere Farbe an den Ausgang übergibt.
*)


end.
