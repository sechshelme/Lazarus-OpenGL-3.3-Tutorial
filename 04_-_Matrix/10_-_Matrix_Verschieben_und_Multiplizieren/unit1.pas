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
Hier wird die Mesh verschoben, und anschliessend gedreht.

Dazu werden zwei 4x4 Matrixen verwendet, eine für das Verschieben und die andere für die Drehung.
Eine dritte Matrix ist noch für das Produkt von den zweit Matrixen, welche dann am Shader übergeben wird.
Im Timer wird Matrix-Rotation ausgeführt.

Für Matrixen, wird ab jetzt ein Type Helper aus der Unit <b>OpenGLMatrix</b> verwendent, dies macht das Ganze übersichtlicher.
Dafür muss einfach die Unit <b>oglMatrix</b> bei uses eingebunden werden.
In der Regel muss dann die Matrix mit <b>TMatrix.Indenty</b> auf die Einheits-Matrix gesetzt werden.
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

(*
Die Deklaration der drei Matrixen.
Und die ID für den Shader. Die ID wird nur eine gebraucht, da nur das Produkt dem Shader übergeben wird.
*)
//code+
var
  RotMatrix, TransMatrix, prodMatrix: TMatrix;   // Matrizen von der Unit oglMatrix.
  Matrix_ID: GLint;                              // ID für Matrix.
  //code-
  Color_ID: GLint;

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

(*
Hier werden die drei Matrixen auf die gesetzt.
*)
//code+
procedure TForm1.CreateScene;
begin
  Shader := TShader.Create([FileToStr('Vertexshader.glsl'), FileToStr('Fragmentshader.glsl')]);
  Shader.UseProgram;
  Color_ID := Shader.UniformLocation('Color');
  Matrix_ID := Shader.UniformLocation('mat');
  RotMatrix.Identity;                   // Zuerst ist eine Einheitsmatrix erwünscht.
  TransMatrix.Identity;
  prodMatrix.Identity;
  TransMatrix.Translate(0.5, 0.0, 0.0); // TransMatrix um 0.5 nach links verschieben.
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
Hier wird das Produkt von TransMatrx und RotMatrix den Shader übergeben.
Mit der Klasse geht dies einfacht mit <b>Matrix.Uniform(ID)</b>

<b>Matrix.Multiply(...</b> entspricht: <b>prodMatrix = TransMatrix * RotMatrix</b> .
Dabei wird die Mesh zuerst gedreht und dann verschoben.
<b>Die Reihenfolge der Multiplikatoren ist sehr wichtig !</b>

Einfach mal TransMatrix und RotMatrix vertauschen, dann sieht man ganz ein anderes Ergebniss.
Dann wird zuerst die Mesh verschoben und dann das Ganze um den Mittelpunkt gedreht.
*)
//code+
procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT);
  Shader.UseProgram;
  prodMatrix.Multiply(TransMatrix, RotMatrix); // Matrix multiplizieren.
  prodMatrix.Uniform(Matrix_ID);               // prodMatrix in den Shader schreiben.
  //code-
(*
Alternativ zu <b>Matrix.Multiply(...</b>, kann man den überladenen Multipliktor "<b>*</b>" verwenden.
//code+
  ...
  prodMatrix := TransMatrix * RotMatrix;       // Matrix multiplizieren.
  prodMatrix.Uniform(Matrix_ID);               // prodMatrix in den Shader schreiben.
//code-
*)

  // Zeichne Dreieck
  glUniform3f(Color_ID, 1.0, 1.0, 0.0);
  glBindVertexArray(VBTriangle.VAO);
  glDrawArrays(GL_TRIANGLES, 0, Length(Triangle) * 3);

  // Zeichne Quadrat
  glUniform3f(Color_ID, 1.0, 0.0, 0.0);
  glBindVertexArray(VBQuad.VAO);
  glDrawArrays(GL_TRIANGLES, 0, Length(Quad) * 3);

  ogc.SwapBuffers;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Timer1.Enabled := False;

  Shader.Free;

  glDeleteVertexArrays(1, @VBTriangle.VAO);
  glDeleteVertexArrays(1, @VBQuad.VAO);

  glDeleteBuffers(1, @VBTriangle.VBO);
  glDeleteBuffers(1, @VBQuad.VBO);
end;

(*
Die Drehung der Matrix wird fortlaufend um den Wert <b>step</b> gedreht.
*)
//code+
procedure TForm1.Timer1Timer(Sender: TObject);
const
  step: GLfloat = 0.01;
begin
  RotMatrix.RotateC(step); // RotMatrix rotieren
  ogcDrawScene(Sender);    // Neu zeichnen
end;
//code-

//lineal

(*
<b>Vertex-Shader:</b>

Hier ist die Uniform-Variable <b>mat</b> hinzugekommen.
Diese wird im Vertex-Shader deklariert, Bewegungen kommen immer in diesen Shader.
*)
//includeglsl Vertexshader.glsl
//lineal

(*
<b>Fragment-Shader:</b>
*)
//includeglsl Fragmentshader.glsl

end.
