unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls,
  dglOpenGL,
  oglContext, oglVector, oglShader;

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
    procedure ogcDrawScene(Sender: TObject);
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

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

  // Atomic Buffer
  ABO: GLuint;
  atomic: record
    pixel, r, g, b: GLuint;
      end;

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
end;

(*
CreateScene wurde um zwei Zeilen erweitert.
Die VB0 für den Farben-Puffer müssen noch generiert werden.
*)

// https://www.lighthouse3d.com/tutorials/opengl-atomic-counters/
// http://forum.lwjgl.org/index.php?topic=7175.0
// https://www.geeks3d.com/20120309/opengl-4-2-atomic-counter-demo-rendering-order-of-fragments/#overview

procedure TForm1.CreateScene;
begin
  glClearColor(0.6, 0.6, 0.4, 1.0); // Hintergrundfarbe

  Shader := TShader.Create;
  Shader.LoadShaderObjectFromFile(GL_VERTEX_SHADER, 'Vertexshader.glsl');
  Shader.LoadShaderObjectFromFile(GL_FRAGMENT_SHADER, 'Fragmentshader.glsl');
  Shader.LinkProgramm;
  Shader.UseProgram;

  glGenVertexArrays(1, @VBTriangle.VAO);
  glBindVertexArray(VBTriangle.VAO);

  // Vektor
  glGenBuffers(1, @VBTriangle.VBOvert);
  glBindBuffer(GL_ARRAY_BUFFER, VBTriangle.VBOvert);
  glBufferData(GL_ARRAY_BUFFER, sizeof(TriangleVector), @TriangleVector, GL_STATIC_DRAW);
  glEnableVertexAttribArray(10);                         // 10 ist die Location in inPos Shader.
  glVertexAttribPointer(10, 3, GL_FLOAT, False, 0, nil);

  // Farbe
  glGenBuffers(1, @VBTriangle.VBOcol);
  glBindBuffer(GL_ARRAY_BUFFER, VBTriangle.VBOcol);
  glBufferData(GL_ARRAY_BUFFER, sizeof(TriangleColor), @TriangleColor, GL_STATIC_DRAW);
  glEnableVertexAttribArray(11);                         // 11 ist die Location in inCol Shader.
  glVertexAttribPointer(11, 3, GL_FLOAT, False, 0, nil);

  // --- Daten für Quadrat
  glGenVertexArrays(1, @VBQuad.VAO);
  glBindVertexArray(VBQuad.VAO);

  // Vektor
  glGenBuffers(1, @VBQuad.VBOvert);
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBOvert);
  glBufferData(GL_ARRAY_BUFFER, sizeof(QuadVector), @QuadVector, GL_STATIC_DRAW);
  glEnableVertexAttribArray(10);
  glVertexAttribPointer(10, 3, GL_FLOAT, False, 0, nil);

  // Farbe
  glGenBuffers(1, @VBQuad.VBOcol);
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBOcol);
  glBufferData(GL_ARRAY_BUFFER, sizeof(QuadColor), @QuadColor, GL_STATIC_DRAW);
  glEnableVertexAttribArray(11);
  glVertexAttribPointer(11, 3, GL_FLOAT, False, 0, nil);

  // --- Atomic Buffer
  glGenBuffers(1, @ABO);
  glBindBuffer(GL_ATOMIC_COUNTER_BUFFER, ABO);
  glBindBufferBase(GL_ATOMIC_COUNTER_BUFFER, 1, ABO);
  glBufferData(GL_ATOMIC_COUNTER_BUFFER, SizeOf(atomic), nil, GL_DYNAMIC_DRAW);
  glBindBuffer(GL_ATOMIC_COUNTER_BUFFER, 0);
end;

//code-

(*
Jetzt kommt wieder ein grosser Vorteil von OpenGL 3.3, das Zeichnen geht gleich einfach wie wen man nur ein VBO hat.
*)
procedure TForm1.ogcDrawScene(Sender: TObject);
const
  zero: array[0..3] of GLfloat = (0, 0, 0, 0);
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

  // Atomic Counter
  glBindBuffer(GL_ATOMIC_COUNTER_BUFFER, ABO);
  glGetBufferSubData(GL_ATOMIC_COUNTER_BUFFER, 0, SizeOf(atomic), @atomic);
  glBufferSubData(GL_ATOMIC_COUNTER_BUFFER, 0, SizeOf(zero), @zero);
//glClearBufferData( GL_ATOMIC_COUNTER_BUFFER, GL_R32UI, GL_RED, GL_UNSIGNED_INT, nil );
  glBindBuffer(GL_ATOMIC_COUNTER_BUFFER, 0);
  WriteLn('Pixel: ', atomic.pixel, ' r: ', atomic.r, ' g: ', atomic.g, ' b: ', atomic.b);
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
