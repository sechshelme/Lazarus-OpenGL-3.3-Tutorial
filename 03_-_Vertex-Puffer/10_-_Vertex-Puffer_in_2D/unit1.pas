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
Wen man nur eine 2D-Mesh hat, kann man die Vektor-Koordinaten auch als <b>2D</b> in das VRAM laden.
Man kann sich dabei den <b>Z-Wert</b> sparen. Matrix-Operation mit eine 4x4 Matrix funktionieren wie wen es 3D wäre.
Für die Farbe wird hier nur eine <b>1D-Array</b> verwendet, da die Mesh nur Rot-Töne enthält. <b>Grün</b> und <b>Blau</b> wird im Shader auf <b>0.0</b> gesetzt.

Man könnte zusätzlich noch einen <b>VBO</b> für <b>Rot</b> und <b>Grün</b> erzeugen. Somit könnte man jede Farbe einzeln in eine Array schreiben.
*)

//lineal

type
  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
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

(*
Ein 2D-Vertex ist noch dazu gekommen.
*)
//code+
type
  TVertex2f = array[0..1] of GLfloat;
  //code-
  TVertex3f = array[0..2] of GLfloat;
  TFace2D = array[0..2] of TVertex2f;
  TFace = array[0..2] of TVertex3f;

(*
Die Vector-Konstanten sind nur noch 2D, der Z-Wert fehlt.
Die Farbe ist nur noch ein einfacher <b>float</b>, da nur Rot ausgegeben wird.
*)
//code+
const
  TriangleVector: array[0..0] of TFace2D =                     // Nur noch eine 2D-Array (XY).
    (((-0.4, 0.1), (0.4, 0.1), (0.0, 0.7)));
  TriangleColor: array[0..0] of TVertex3f = ((1.0, 0.5, 0.0)); // Nur eine Float-Array.
  QuadVector: array[0..1] of TFace2D =
    (((-0.2, -0.6), (-0.2, -0.1), (0.2, -0.1)),
    ((-0.2, -0.6), (0.2, -0.1), (0.2, -0.6)));
  QuadColor: array[0..1] of TVertex3f =
    ((0.5, 0.0, 1.0), (0.5, 1.0, 0.0));
//code-

type
  TVB = record
    VAO,
    VBOvert,         // VBO für Vektor.
    VBOcol: GLuint;  // VBO für Farbe.
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

procedure TForm1.CreateScene;
begin
  Shader := TShader.Create([FileToStr('Vertexshader.glsl'), FileToStr('Fragmentshader.glsl')]);
  Shader.UseProgram;

  glGenVertexArrays(1, @VBTriangle.VAO);
  glGenVertexArrays(1, @VBQuad.VAO);

  glGenBuffers(1, @VBTriangle.VBOvert);
  glGenBuffers(1, @VBTriangle.VBOcol);
  glGenBuffers(1, @VBQuad.VBOvert);
  glGenBuffers(1, @VBQuad.VBOcol);
end;

(*
Bei <b>glVertexAttribPointer(...</b> wurde der zweite Parameter, von <b>3</b> auf <b>2</b> ersetzt.
Bei einer Farb-Übergabe mit Alpha-Blending (RGBA), kann es auch eine <b>4</b> sein.
Hier wird sogar nur eine <b>1</b> verwendet, da die Rot-Töne nur eine einfache Array ist.
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
  glEnableVertexAttribArray(10);
  glVertexAttribPointer(10, 2, GL_FLOAT, GL_FALSE, 0, nil); // Der zweite Wert ist eine 2 für 2D.

  // Farbe
  glBindBuffer(GL_ARRAY_BUFFER, VBTriangle.VBOcol);
  glBufferData(GL_ARRAY_BUFFER, sizeof(TriangleColor), @TriangleColor, GL_STATIC_DRAW);
  glEnableVertexAttribArray(11);                         // Der zweite Wert ist eine 1 für eine Farbe (Rot).
  glVertexAttribPointer(11, 1, GL_FLOAT, GL_FALSE, 0, nil);
  //code-

  // --- Daten für Quadrat
  glBindVertexArray(VBQuad.VAO);

  // Vektor
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBOvert);
  glBufferData(GL_ARRAY_BUFFER, sizeof(QuadVector), @QuadVector, GL_STATIC_DRAW);
  glEnableVertexAttribArray(10);
  glVertexAttribPointer(10, 2, GL_FLOAT, GL_FALSE, 0, nil);

  // Farbe
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBOcol);
  glBufferData(GL_ARRAY_BUFFER, sizeof(QuadColor), @QuadColor, GL_STATIC_DRAW);
  glEnableVertexAttribArray(11);
  glVertexAttribPointer(11, 1, GL_FLOAT, GL_FALSE, 0, nil);
end;

procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT);

  Shader.UseProgram;

  // Zeichne Dreieck
  glBindVertexArray(VBTriangle.VAO);
  glDrawArrays(GL_TRIANGLES, 0, Length(TriangleVector) * 3);

  // Zeichne Quadrat
  glBindVertexArray(VBQuad.VAO);
  glDrawArrays(GL_TRIANGLES, 0, Length(QuadVector) * 3);

  ogc.SwapBuffers;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Shader.Free;

  glDeleteVertexArrays(1, @VBTriangle.VAO);
  glDeleteVertexArrays(1, @VBQuad.VAO);

  glDeleteBuffers(1, @VBTriangle.VBOvert);
  glDeleteBuffers(1, @VBTriangle.VBOcol);
  glDeleteBuffers(1, @VBQuad.VBOvert);
  glDeleteBuffers(1, @VBQuad.VBOcol);
end;

//lineal

(*
<b>Vertex-Shader:</b>

Der Z-Wert des Vektors wird konstant auf <b>0.0</b> gesetzt.
Eine Z-Bewegung der ganzen Mesh ist mit einer Matrix trozdem noch möglich. ZB. für Sprite-Darstellung.
Die <b>in</b>-Variable könnte man auch auf <b>vec3</b> belassen, wie bei einem normalen 3D-Shader. Es wird dann automatisch ein <b>0.0</b> für den Z-Wert gesetzt.

Die Farbe kommt nur noch in einem <b>float</b> an, aus diesem Grund hat <b>Grün</b> und <b>Blau</b> eine feste Konstante <b>0.0</b>.
*)
//includeglsl Vertexshader.glsl
//lineal

(*
<b>Fragment-Shader</b>
*)
//includeglsl Fragmentshader.glsl

end.


