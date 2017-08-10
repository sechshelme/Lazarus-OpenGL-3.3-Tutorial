unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls,
  dglOpenGL,
  oglContext, oglShader;

//image image.png

(*
Hier wird ein sehr einfacher Shader geladen, welcher nichts anderes macht, als die Dreiecke rot darzustellen.
*)

//lineal

(*
Hier wird noch ein Objekt der Klasse TShader deklariert.
*)
//code+
type

  { TForm1 }

  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    ogc: TContext;
    Shader: TShader; // Shader-Object
    //code-
    procedure CreateScene;
    procedure InitScene;
    procedure ogcDrawScene(Sender: TObject);
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

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
Dieser Code wurde um 2 Zeilen erweitert.

In der ersten Zeile wird der Shader in die Grafikkarte geladen.
Da die Shader-Objecte als Text-Dateien vorliegen, wird hier <b>FileToStr(Datei)</b> verwendet.
Die zweite Zeile aktiviert den Shader.
*)

//code+
procedure TForm1.CreateScene;
begin
  Shader := TShader.Create([FileToStr('Vertexshader.glsl'), FileToStr('Fragmentshader.glsl')]);
  Shader.UseProgram;
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
Beim Zeichnen muss man auch mit <b>Shader[x].UseProgram(...</b> den Shader wählen, wenn man mehr als einen Shader verwendet.
In der Shader-Klasse steht nichts anderes als<b>glUseProgram(ShaderID);</b> .
Bei diesem Mini-Code mit nur einem Shader könnte dies weggelassen werden.
*)

//code+
procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT);

  Shader.UseProgram;
  //code-

  // Zeichne Dreieck
  glBindVertexArray(VBTriangle.VAO);
  glDrawArrays(GL_TRIANGLES, 0, Length(Triangle) * 3);

  // Zeichne Quadrat
  glBindVertexArray(VBQuad.VAO);
  glDrawArrays(GL_TRIANGLES, 0, Length(Quad) * 3);

  ogc.SwapBuffers;
end;

(*
Am Ende werden mit <b>Shader.Free</b> die Shader in der Grafikkarte wieder freigeben.
In diesem Destruktor steht <b>glDeleteShader(ShaderID);</b>
*)

//code+
procedure TForm1.FormDestroy(Sender: TObject);
begin
  Shader.Free;
  //code-

  glDeleteVertexArrays(1, @VBTriangle.VAO);
  glDeleteVertexArrays(1, @VBQuad.VAO);

  glDeleteBuffers(1, @VBTriangle.VBO);
  glDeleteBuffers(1, @VBQuad.VBO);
end;

//lineal
(*
Diese Kommentare, welche man hier im Shader sind, werden auch dem der Grafik-Teiber übergeben, ab in dieser ingnoriert sie dann.
Wen man voll auf Perfornance beil laden ab ist, sollte man Kommentare im Shader-Code meiden.
Auch jede Leerzeile und jede Einrückung bremsen ein wenig ab.
Auf die später Zeichengeschwindigkeit hat dies aber keinen Einfluss.
Aber hier im Tutorial wird voll auf solche Optimierungen verzichtet, da wir übersichtlichen Shader-Code sehen wollen.
*)
//lineal
(*
<b>Vertex-Shader:</b>
*)
//includeglsl Vertexshader.glsl
//lineal

(*
<b>Fragment-Shader</b>
*)
//includeglsl Fragmentshader.glsl

//lineal
(*
So könnte ein optimierter Shader-Code aussehen, dafür ist er aber sehr schlecht leserlich.
<b>Vertex-Shader:</b>
*)
//includeglsl Vertexshader_optimiert.glsl

end.


