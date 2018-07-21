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
Man kann die Vertex-Daten, auch alles in einen Daten-Block schreiben. Hier werden die Vector- und Color - Daten alle in einen Block geschrieben.
In den vorherigen Beispielen hat es für die Vector- und  Color - Daten eine separate TFace-Array gehabt.
Hier werden zwei Möglichkeiten vorgestellt, wie die Daten in der Array sind.
Variante1: <b>Vec0, Col0, ..., Vecn, Coln</b>
Variante2: <b>Vec0, ..., Vecn, Col0, ..., Coln</b>
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
  TVertex6f = array[0..5] of GLfloat;
  TFace = array[0..2] of TVertex3f;
  TFace2 = array[0..2] of TVertex6f;

(*
Die zwei Daten-Varianten:
Variante 0: <b>XYZ RGB XYZ RGB XYZ RGB XYZ RGB XYZ RGB XYZ RGB</b>
Variante 1: <b>XYZ XYZ XYZ XYZ XYZ XYZ RGB RGB RGB RGB RGB RGB</b>

Bei dem zweiten Quadrat, sind die Y-Werte gespiegelt, es sollten zwei Quadrate sichtbar sein.
*)
//code+
const
  QuadVektor0: array[0..1] of TFace2 =
    // Vec, Col, Vec, Col, ....
    (((-0.2, 0.6, 0.0, 1.0, 0.0, 0.0), (-0.2, 0.1, 0.0, 0.0, 1.0, 0.0), (0.2, 0.1, 0.0, 1.0, 1.0, 0.0)),
    ((-0.2, 0.6, 0.0, 1.0, 0.0, 0.0), (0.2, 0.1, 0.0, 1.0, 1.0, 0.0), (0.2, 0.6, 0.0, 0.0, 1.0, 1.0)));
  QuadVektor1: array[0..3] of TFace =
    // Vec
    (((-0.2, -0.6, 0.0), (-0.2, -0.1, 0.0), (0.2, -0.1, 0.0)),
    ((-0.2, -0.6, 0.0), (0.2, -0.1, 0.0), (0.2, -0.6, 0.0)),
    // Col
    ((1.0, 0.0, 1.0), (1.0, 1.0, 0.0), (1.0, 1.0, 1.0)),
    ((1.0, 0.0, 1.0), (1.0, 1.0, 1.0), (0.0, 1.0, 1.0)));
//code-

type
  TVB = record
    VAO,
    VBOvert,
    VBOcol: GLuint;
  end;

var
  VBQuad0, VBQuad1: TVB;

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

procedure TForm1.CreateScene;
begin
  Shader := TShader.Create([FileToStr('Vertexshader.glsl'), FileToStr('Fragmentshader.glsl')]);
  Shader.UseProgram;

  glGenVertexArrays(1, @VBQuad0.VAO);
  glGenVertexArrays(1, @VBQuad1.VAO);

  glGenBuffers(1, @VBQuad0.VBOvert);
  glGenBuffers(1, @VBQuad0.VBOcol);
  glGenBuffers(1, @VBQuad1.VBOvert);
  glGenBuffers(1, @VBQuad1.VBOcol);
end;

(*
Hier die wichtigste Änderung:
Relevant sind die zwei letzten Parameter von <b>glVertexAttribPointer(...</b>
Was irritiert der einte Parameter ist direkt ein Integer, der andere braucht eine Typenumwandlung auf einen Pointer.
Der zweitletzte Parameter (stride), gibt das <b>Byte</b> Offset, zum nächsten Attribut-Wert an.
Der letzte Parameter (pointer), gibt die Position zum ersten Attribut-Wert an.
Die Werte sind immer als <b>Byte</b>, somit muss man bei einem <b>glFloat</b> immer <b>4x</b> rechnen.

Varinate0:
Die Vektoren beginnen bei 0, Die Grösse ist 24Byte = 6 glFloat x 4 entspricht <b>XYZRGB</b>.
Die Farben beginnen beim 12Byte. Die Grösse ist mit 24Byte gleich wie bei den Vektoren.

Varinate1:
Da die Vektoren hintereinander stehen, darf dieser Default (0) sein.
Die Farben beginnen beim 72Byte.
*)
//code+
procedure TForm1.InitScene;
begin
  glClearColor(0.6, 0.6, 0.4, 1.0); // Hintergrundfarbe

  // --- Daten für Quadrat 0
  glBindVertexArray(VBQuad0.VAO);

  // Vektor
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad0.VBOvert);
  glBufferData(GL_ARRAY_BUFFER, sizeof(QuadVektor0), @QuadVektor0, GL_STATIC_DRAW);
  glEnableVertexAttribArray(10);
  glVertexAttribPointer(10, 3, GL_FLOAT, False, 24, nil);  // nil = Pointer(0)

  // Farbe
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad0.VBOcol);
  glBufferData(GL_ARRAY_BUFFER, sizeof(QuadVektor0), @QuadVektor0, GL_STATIC_DRAW);
  glEnableVertexAttribArray(11);
  glVertexAttribPointer(11, 3, GL_FLOAT, False, 24, Pointer(12));

  // --- Daten für Quadrat 1
  glBindVertexArray(VBQuad1.VAO);

  // Vektor
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad1.VBOvert);
  glBufferData(GL_ARRAY_BUFFER, sizeof(QuadVektor1), @QuadVektor1, GL_STATIC_DRAW);
  glEnableVertexAttribArray(10);
  glVertexAttribPointer(10, 3, GL_FLOAT, False, 0, nil);

  // Farbe
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad1.VBOcol);
  glBufferData(GL_ARRAY_BUFFER, sizeof(QuadVektor1), @QuadVektor1, GL_STATIC_DRAW);
  glEnableVertexAttribArray(11);
  glVertexAttribPointer(11, 3, GL_FLOAT, False, 0, Pointer(72));
end;
//code-

(*
Das Zeichnen ist gleich, wie wen man separate Datenblöcke hätte. 
Es wurde das <b>Length(...</b> entfernt, da die einte Array zwei und die andere vier Elemente hat.
Was aber sicher ist, das beide Quadrate aus sechs Vektoren bestehen.
*)
procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT);

  Shader.UseProgram;

  //code+
  // Zeichne Quadrat 0
  glBindVertexArray(VBQuad0.VAO);
  glDrawArrays(GL_TRIANGLES, 0, 6);  // 6 Vertex pro Quadrat

  // Zeichne Quadrat 1
  glBindVertexArray(VBQuad1.VAO);
  glDrawArrays(GL_TRIANGLES, 0, 6);  // 6 Vertex pro Quadrat
  //code-

  ogc.SwapBuffers;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Shader.Free;

  glDeleteVertexArrays(1, @VBQuad0.VAO);
  glDeleteVertexArrays(1, @VBQuad1.VAO);

  glDeleteBuffers(1, @VBQuad0.VBOvert);
  glDeleteBuffers(1, @VBQuad0.VBOcol);
  glDeleteBuffers(1, @VBQuad1.VBOvert);
  glDeleteBuffers(1, @VBQuad1.VBOcol);
end;

//lineal

(*
<b>Vertex-Shader:</b>

Im Shader gibt es keine Änderung, da es diesem egal ist, wie <b>glVertexAttribPointer(...</b> die Daten übergibt.
*)
//includeglsl Vertexshader.glsl
//lineal

(*
<b>Fragment-Shader</b>
*)
//includeglsl Fragmentshader.glsl

end.


