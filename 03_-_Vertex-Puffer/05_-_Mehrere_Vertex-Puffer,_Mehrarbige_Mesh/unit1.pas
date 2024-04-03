unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls,
  oglglad_gl,
  oglContext, oglShader;

//image image.png
(*
Bis jetzt wurde immer nur ein Vertex-Puffer pro Mesh geladen, hier wird ein zweiter geladen, welcher die Farben der Vektoren enthält.
Somit werden die Mesh mehrfarbig.
*)

//lineal

type
  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
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

type
  TVertex3f = array[0..2] of GLfloat;
  TFace = array[0..2] of TVertex3f;

(*
Es sind zwei zusätzliche Vertex-Konstanten dazu gekommen, welche die Farben der Ecken enthält.
*)
//code+
const
  TriangleVector: array[0..0] of TFace =
    (((-0.4, 0.1, 0.0), (0.4, 0.1, 0.0), (0.0, 0.7, 0.0)));
  TriangleColor: array[0..0] of TFace =   // Rot / Grün / Blau
    (((1.0, 0.0, 0.0), (0.0, 1.0, 0.0), (0.0, 0.0, 1.0)));
  QuadVector: array[0..1] of TFace =
    (((-0.2, -0.6, 0.0), (-0.2, -0.1, 0.0), (0.2, -0.1, 0.0)),
    ((-0.2, -0.6, 0.0), (0.2, -0.1, 0.0), (0.2, -0.6, 0.0)));
  QuadColor: array[0..1] of TFace =       // Rot / Grün / Gelb / Rot / Gelb / Mint
    (((1.0, 0.0, 0.0), (0.0, 1.0, 0.0), (1.0, 1.0, 0.0)),
    ((1.0, 0.0, 0.0), (1.0, 1.0, 0.0), (0.0, 1.0, 1.0)));
//code-

(*
Für die Farbe ist ein zusätzliches <b>Vertex Buffer Object</b> (VBO) hinzugekommen.
*)
//code+
type
  TVB = record
    VAO,
    VBOvert,         // VBO für Vektor.
    VBOcol: GLuint;  // VBO für Farbe.
  end;
//code-

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
CreateScene wurde um zwei Zeilen erweitert.
Die VB0 für den Farben-Puffer müssen noch generiert werden.
*)

procedure TForm1.CreateScene;
begin
  Shader := TShader.Create([FileToStr('Vertexshader.glsl'), FileToStr('Fragmentshader.glsl')]);
  Shader.UseProgram;

  glGenVertexArrays(1, @VBTriangle.VAO);
  glGenVertexArrays(1, @VBQuad.VAO);

  //code+
  glGenBuffers(1, @VBTriangle.VBOvert);
  glGenBuffers(1, @VBTriangle.VBOcol);   // neu hinzugekommen
  glGenBuffers(1, @VBQuad.VBOvert);
  glGenBuffers(1, @VBQuad.VBOcol);       // neu hinzugekommen
  //code-
end;

(*
Hier fast der wichtigste Teil, pro <b>Vertex Array Object</b> (VAO) wird ein zweiter Puffer in das VRAM geladen.
Die 10 und 11, muss indentisch sein, mit dem <b>location</b> im Shader.
*)
//code+
procedure TForm1.InitScene;
begin
  glClearColor(0.6, 0.6, 0.4, 1.0); // Hintergrundfarbe

  // --- Daten für Dreieck
  glBindVertexArray(VBTriangle.VAO);

  // Vektor
  glBindBuffer(GL_ARRAY_BUFFER, VBTriangle.VBOvert);
  glBufferData(GL_ARRAY_BUFFER, sizeof(TriangleVector), @TriangleVector, GL_STATIC_DRAW);
  glEnableVertexAttribArray(10);                         // 10 ist die Location in inPos Shader.
  glVertexAttribPointer(10, 3, GL_FLOAT, GL_FALSE, 0, nil);

  // Farbe
  glBindBuffer(GL_ARRAY_BUFFER, VBTriangle.VBOcol);
  glBufferData(GL_ARRAY_BUFFER, sizeof(TriangleColor), @TriangleColor, GL_STATIC_DRAW);
  glEnableVertexAttribArray(11);                         // 11 ist die Location in inCol Shader.
  glVertexAttribPointer(11, 3, GL_FLOAT, GL_FALSE, 0, nil);

  // --- Daten für Quadrat
  glBindVertexArray(VBQuad.VAO);

  // Vektor
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBOvert);
  glBufferData(GL_ARRAY_BUFFER, sizeof(QuadVector), @QuadVector, GL_STATIC_DRAW);
  glEnableVertexAttribArray(10);
  glVertexAttribPointer(10, 3, GL_FLOAT, GL_FALSE, 0, nil);

  // Farbe
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBOcol);
  glBufferData(GL_ARRAY_BUFFER, sizeof(QuadColor), @QuadColor, GL_STATIC_DRAW);
  glEnableVertexAttribArray(11);
  glVertexAttribPointer(11, 3, GL_FLOAT, GL_FALSE, 0, nil);
end;
//code-

(*
Jetzt kommt wieder ein grosser Vorteil von OpenGL 3.3, das Zeichnen geht gleich einfach wie wen man nur ein VBO hat.
*)
procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT);

  Shader.UseProgram;

  //code+
  // Zeichne Dreieck
  glBindVertexArray(VBTriangle.VAO);
  glDrawArrays(GL_TRIANGLES, 0, Length(TriangleVector) * 3);

  // Zeichne Quadrat
  glBindVertexArray(VBQuad.VAO);
  glDrawArrays(GL_TRIANGLES, 0, Length(QuadVector) * 3);
  //code-

  ogc.SwapBuffers;
end;

(*
Am Ende müssen noch die zusätzlichen VBO-Puffer frei gegeben werden.
Freigaben müssen immer gleich viele sein wie Erzeugungen.
*)

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Shader.Free;

  glDeleteVertexArrays(1, @VBTriangle.VAO);
  glDeleteVertexArrays(1, @VBQuad.VAO);

  //code+
  glDeleteBuffers(1, @VBTriangle.VBOvert);
  glDeleteBuffers(1, @VBTriangle.VBOcol);
  glDeleteBuffers(1, @VBQuad.VBOvert);
  glDeleteBuffers(1, @VBQuad.VBOcol);
  //code-
end;

//lineal

(*
<b>Vertex-Shader:</b>

Hier ist eine zweite Location hinzugekommen, wichtig ist, das die Location-Nummer übereinstimmt, mit denen beim Vertex-Laden.
*)
//includeglsl Vertexshader.glsl
//lineal

(*
<b>Fragment-Shader</b>
*)
//includeglsl Fragmentshader.glsl

end.


