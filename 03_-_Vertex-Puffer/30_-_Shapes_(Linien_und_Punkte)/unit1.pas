unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, Menus,
  oglglad_gl,
  oglContext, oglShader;

type

  { TForm1 }

  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    ogc: TContext;
    Shader: TShader; // Shader-Object
    procedure CreateVertex;
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
Bis jetzt wurde alles mit kompletten Dreiecken gerendert und gezeichnet. Es gibt aber noch zwei andere Varianten um Dreiecke zu rendern.
Dies wurde beim Zeichnen mit <b>glDrawArrays(GL_TRIANGLES, ...</b> veranlasst. Diese Version wird in der Paraxis am meisten angewendet.
Man kann die Dreiecke auch als Streifen hintereinander rendern, dies gerschieht mit <b>glDrawArrays(GL_TRIANGLES_STRIP, ...</b>.
Oder wie ein Wedel, dabei ist der erste Vektor die Mitte, und der Rest die Eckpunkte. Dies geschieht dann mit <b>glDrawArrays(GL_TRIANGLES_FAN, ...</b>.

Das schreiben in die Grafikkarte, ist bei allen Varianten gleich, der Unterschied ist legendlich beim Zeichenen mit <b>glDrawArrays(...</b>.
*)

//lineal

type
  TVertex2f = array[0..1] of GLfloat;

(*
Die Deklaration der Vektor-Koordianten Konstanten, zur Vereinfachung habe ich nur 2D-Vektoren genommen. Natürlich können diese auch 3D sein.
*)
//code+
var
  Linies: array of TVertex2f; // XY-Koordinaten
//code-

type
  TVB = record
    VAO,
    VBO: GLuint;
  end;

var
  X_ID, Y_ID: GLint;      // ID für X und Y
  Color_ID: GLint;        // ID für Farbe

  VBTriangle: TVB;

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  //remove+
  Width := 340;
  Height := 240;
  //remove-
  ogc := TContext.Create(Self);
  ogc.OnPaint := @ogcDrawScene;

  CreateVertex;

  CreateScene;
  InitScene;
end;

procedure TForm1.CreateScene;
begin
  Shader := TShader.Create([FileToStr('Vertexshader.glsl'), FileToStr('Fragmentshader.glsl')]);
  Shader.UseProgram;
  Color_ID := Shader.UniformLocation('Color');
  X_ID := Shader.UniformLocation('x'); // Ermittelt die ID von x.
  Y_ID := Shader.UniformLocation('y'); // Ermittelt die ID von y.

  glGenVertexArrays(1, @VBTriangle.VAO);
  glGenBuffers(1, @VBTriangle.VBO);
end;

procedure TForm1.CreateVertex;
const
  r = 0.3;
  sek = 14;
var
  i: integer;
begin
  SetLength(Linies, sek);
  for i := 0 to sek - 1 do begin
    Linies[i, 0] := sin(Pi * 2 / sek * i) * r;
    Linies[i, 1] := cos(Pi * 2 / sek * i) * r;
  end;
end;

(*
Hier werden die Daten in die Grafikkarte geschrieben.
Es hat nichts besonderes, da für jede Mesh die gleichen Koordinaten verwendet werden.
*)

//code+
procedure TForm1.InitScene;
begin
  glClearColor(0.6, 0.6, 0.4, 1.0); // Hintergrundfarbe

  // Daten für GL_TRIANGLE
  glBindVertexArray(VBTriangle.VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBTriangle.VBO);
  glBufferData(GL_ARRAY_BUFFER, sizeof(TVertex2f) * Length(Linies), Pointer(Linies), GL_STATIC_DRAW);
  glEnableVertexAttribArray(10);
  glVertexAttribPointer(10, 2, GL_FLOAT, GL_FALSE, 0, nil);
end;
//code-

(*
Bei <b>glDrawArrays(...</b> ist der erste Parameter das wichtigste, hier wird angegeben, wie die Vektor-Koordinaten gezeichnet werden.
Hier werden vier Möglichkeiten gezeigt, dazu werden immer die gleichen Vertex-Koordinaten verwendet. Daher sieht man den Unterschied gut.

Mit <b>glLineWidth(...</b> kann die Linienbreite angegeben werden, default ist <b>1.0</b> .
Mit <b>glPointSize(...</b> kann der Durchmesser der Punkte angegeben werden, default ist <b>1.0</b> .
Für die Punkte gibt es noch eine andere Möglichkeit, man kann den Durchmesser auch im Shader angegeben, dazu später.

Wen mit <b>glPolygonMode(...</b> auf Punkte oder Linien umgestellt wird, haben diese beiden Parameter auch einen Einfluss.
*)
//code+
procedure TForm1.ogcDrawScene(Sender: TObject);
const
  ofs = 0.4;
begin
  glClear(GL_COLOR_BUFFER_BIT);
  Shader.UseProgram;
  glBindVertexArray(VBTriangle.VAO);

  // Zeichne GL_LINES
  glLineWidth(3);                        // Linie 3 Pixel breit.
  glUniform3f(Color_ID, 1.0, 1.0, 0.0) ; // Gelb
  glUniform1f(X_ID, -ofs);               // links-
  glUniform1f(Y_ID, -ofs);               // unten
  glDrawArrays(GL_LINES, 0, Length(Linies));

  // Zeichne GL_LINE_STRIP
  glLineWidth(1);                        // Linie 1 Pixel breit.
  glUniform3f(Color_ID, 1.0, 0.0, 0.0);  // Rot
  glUniform1f(X_ID, ofs);                // rechts-
  glUniform1f(Y_ID, -ofs);               // unten
  glDrawArrays(GL_LINE_STRIP, 0, Length(Linies));

  // Zeichne GL_LINE_LOOP
  glLineWidth(6);                        // Linie 6 Pixel breit.
  glUniform3f(Color_ID, 0.0, 1.0, 0.0);  // Grün
  glUniform1f(X_ID, ofs);                // rechts-
  glUniform1f(Y_ID, ofs);                // oben
  glDrawArrays(GL_LINE_LOOP, 0, Length(Linies));

  // Zeichne GL_POINTS
  glPointSize(5);                        // Punkte Durchmesser 5 Pixel.
  glUniform3f(Color_ID, 0.0, 0.0, 1.0);  // Blau
  glUniform1f(X_ID, -ofs);               // links-
  glUniform1f(Y_ID, ofs);                // oben
  glDrawArrays(GL_POINTS, 0, Length(Linies));
  //code-

  ogc.SwapBuffers;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Shader.Free;

  glDeleteVertexArrays(1, @VBTriangle.VAO);
  glDeleteBuffers(1, @VBTriangle.VBO);
end;

//lineal

(*
<b>Vertex-Shader:</b>

Da die Koordinaten nur als 2D gespeichert sind, wird im Vertex-Shader der Z-Wert auf 0.0 gesetzt.
*)
//includeglsl Vertexshader.glsl
//lineal

(*
<b>Fragment-Shader:</b>
*)
//includeglsl Fragmentshader.glsl

end.
