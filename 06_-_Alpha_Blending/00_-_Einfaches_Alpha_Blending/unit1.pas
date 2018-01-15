unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, Menus,
  dglOpenGL,
  oglContext, oglShader, oglMatrix;

type

  { TForm1 }

  TForm1 = class(TForm)
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
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

//image image.png

(*
Mit OpenGL kann man auch (halb)tranparente Elemente zeichen.
Dafür gibt es Alphablending. Der Transparent-Faktor wird mit dem vierten Wert im Vector angegeben. Dies ist auch im Shader der Fall.
Alphablending kann man auch auf Texturen anwenden, zB. um eine Baum zu zeichnen, oder auch nur eine Scheibe. Dazu mehr unter Texturen.
*)

//lineal

(*
Neben einem Face mit 3 Werten, gibt es jetzt noch eines mit einem vierten, welcher dann den Aplhablending angibt.
*)
//code+
type
  TFace3f = array[0..2] of TVector3f;
  TFace4f = array[0..2] of TVector4f;  // Mit Alpha
  //code-

(*
Beim Color sieht man auch den vierten Parameter. Wobei <b>0.0</b> voll Transparent ist. und <b>1.0</b> undurchsichtig.
Wen man nur den RGB-Wert betrachtet, wäre das Dreieck voll rot und das Rechteck grün.
*)
//code+
const
  TriangleVector: array[0..0] of TFace3f =
    (((-0.4, 0.1, 0.0), (0.4, 0.1, 0.0), (0.0, 0.7, 0.0)));
  TriangleColor: array[0..0] of TFace4f =
    (((1.0, 0.0, 0.0, 1.0), (1.0, 0.0, 0.0, 0.5), (1.0, 0.0, 0.0, 0.0)));

  QuadVector: array[0..1] of TFace3f =
    (((-0.2, -0.6, 0.0), (-0.2, -0.1, 0.0), (0.2, -0.1, 0.0)),
    ((-0.2, -0.6, 0.0), (0.2, -0.1, 0.0), (0.2, -0.6, 0.0)));
  QuadColor: array[0..1] of TFace4f =
    (((0.0, 1.0, 0.0, 0.5), (0.0, 1.0, 0.0, 1.0), (0.0, 1.0, 0.0, 0.0)),
    ((0.0, 1.0, 0.0, 0.5), (0.0, 1.0, 0.0, 0.0), (0.0, 1.0, 0.0, 0.0)));
//code-

type
  TVB = record
    VAO,
    VBOvert,         // VBO für Vektor.
    VBOcol: GLuint;  // VBO für Farbe.
  end;

var
  MatrixRot: TMatrix;     // Matrix
  MatrixRot_ID: GLint;    // ID für Matrix.

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
  Timer1.Enabled := True;
end;

procedure TForm1.CreateScene;
begin
  Shader := TShader.Create([FileToStr('Vertexshader.glsl'), FileToStr('Fragmentshader.glsl')]);
  Shader.UseProgram;
  MatrixRot_ID := Shader.UniformLocation('mat');
  MatrixRot := TMatrix.Create;

  glGenVertexArrays(1, @VBTriangle.VAO);
  glGenVertexArrays(1, @VBQuad.VAO);

  glGenBuffers(1, @VBTriangle.VBOvert);
  glGenBuffers(1, @VBTriangle.VBOcol);
  glGenBuffers(1, @VBQuad.VBOvert);
  glGenBuffers(1, @VBQuad.VBOcol);
end;

(*
Hier kommen zwie wichtige Zeilen hinzu, mit der Ersten wird Alphablending aktiviert und mit der zweiten gibt man die Art des Blinding an.
Bei <b>glVertexAttribPointer(...</b> bei der Farbe sieht man, das ein Vector 4 Werte anstelle 3 hat.
*)
//code+
procedure TForm1.InitScene;
begin
  glClearColor(0.6, 0.6, 0.4, 1.0); // Hintergrundfarbe

  glEnable(GL_BLEND);                                  // Alphablending an
  glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);   // Sortierung der Primitiven von hinten nach vorne.

  glEnable(GL_DEPTH_TEST);
  glDepthFunc(GL_LESS);

  // --- Daten für Dreieck
  glBindVertexArray(VBTriangle.VAO);

  // Vektor
  glBindBuffer(GL_ARRAY_BUFFER, VBTriangle.VBOvert);
  glBufferData(GL_ARRAY_BUFFER, sizeof(TriangleVector), @TriangleVector, GL_STATIC_DRAW);
  glEnableVertexAttribArray(10);                         // 10 ist die Location in inPos Shader.
  glVertexAttribPointer(10, 3, GL_FLOAT, False, 0, nil);

  // Farbe
  glBindBuffer(GL_ARRAY_BUFFER, VBTriangle.VBOcol);
  glBufferData(GL_ARRAY_BUFFER, sizeof(TriangleColor), @TriangleColor, GL_STATIC_DRAW);
  glEnableVertexAttribArray(11);                         // 11 ist die Location in inCol Shader.
  glVertexAttribPointer(11, 4, GL_FLOAT, False, 0, nil);
//code-

  // --- Daten für Quadrat
  glBindVertexArray(VBQuad.VAO);

  // Vektor
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBOvert);
  glBufferData(GL_ARRAY_BUFFER, sizeof(QuadVector), @QuadVector, GL_STATIC_DRAW);
  glEnableVertexAttribArray(10);
  glVertexAttribPointer(10, 3, GL_FLOAT, False, 0, nil);

  // Farbe
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBOcol);
  glBufferData(GL_ARRAY_BUFFER, sizeof(QuadColor), @QuadColor, GL_STATIC_DRAW);
  glEnableVertexAttribArray(11);
  glVertexAttribPointer(11, 4, GL_FLOAT, False, 0, nil);
end;

procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);  // Frame und Tiefen-Buffer löschen.
  Shader.UseProgram;
  MatrixRot.Uniform(MatrixRot_ID);                      // MatrixRot in den Shader.

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
  Timer1.Enabled := False;

  Shader.Free;
  MatrixRot.Free;

  glDeleteVertexArrays(1, @VBTriangle.VAO);
  glDeleteVertexArrays(1, @VBQuad.VAO);

  glDeleteBuffers(1, @VBTriangle.VBOvert);
  glDeleteBuffers(1, @VBTriangle.VBOcol);
  glDeleteBuffers(1, @VBQuad.VBOvert);
  glDeleteBuffers(1, @VBQuad.VBOcol);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
const
  step: GLfloat = 0.01;     // Der Winkel ist im Bogenmass.
begin
  MatrixRot.RotateC(step);  // MatrixRot rotieren.
  ogcDrawScene(Sender);     // Neu zeichnen.
end;

//lineal

(*
Die Shader sind sehr einfach gehalten. Man könnte mit <b>Color.a</b> direkt einen Alphawert zuordnen.
Da der Alpha-Kanal gebraucht wird, sieht man mehrfach <b>vec4</b> anstelle <b>vec3</b>.

<b>Vertex-Shader:</b>
*)
//includeglsl Vertexshader.glsl
//lineal

(*
<b>Fragment-Shader:</b>
*)
//includeglsl Fragmentshader.glsl

end.
