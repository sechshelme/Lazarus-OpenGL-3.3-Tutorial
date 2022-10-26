unit Unit1;

{$mode objfpc}{$H+}
{$modeswitch typehelpers}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, Menus,
  dglOpenGL,
  oglContext, oglShader;

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
Hier wird eine <b>4x4 Matrix</b> verwendet, dies ist Standard bei allen Mesh Translationen.
Im Timer wird eine Matrix-Rotation ausgeführt.
Für diese einfache Roatation, könnte man auch eine <b>2x2-Matrix</b> nehmen, aber sobald man die Mesh auch verschieben will, braucht man <b>4x4-Matrix</b>, auch wird es sonst komplizierter im Shader.
*)

//lineal

(*
Hier wird ein Matrix4x4-Typ deklariert.
Für die Manipulationen einer Matrix eignet sich hervorragend ein <b>Type Helper</b>.
*)
//code+
type
  TMatrix = array[0..3, 0..3] of GLfloat;

  TMatrixfHelper = Type Helper for TMatrix
    procedure Indenty;                  // Generiere eine Einheitsmatrix
    procedure Rotate(angele: single);   // Drehe Matrix
  end;
  //code-

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
Die Matrix selbst, die rotiert wird.
Und die ID für den Shader.
*)
//code+
var
  MatrixRot: TMatrix;     // Matrix
  MatrixRot_ID: GLint;    // ID für Matrix.
  //code-
  Color_ID: GLint;

  VBTriangle, VBQuad: TVB;

(*
Hier wird eine Einheits-Matrix erzeugt, bei einer 4x4-Matrix, sieht dies so aus:

//matrix+

 1 | 0 | 0 | 0 
 0 | 1 | 0 | 0 
 0 | 0 | 1 | 0 
 0 | 0 | 0 | 1 fdgfdgd

//matrix-
*)
//code+
procedure TMatrixfHelper.Indenty;
const
  MatrixIndenty: TMatrix = ((1.0, 0.0, 0.0, 0.0), (0.0, 1.0, 0.0, 0.0), (0.0, 0.0, 1.0, 0.0), (0.0, 0.0, 0.0, 1.0));
begin
  Self := MatrixIndenty;
end;
//code-

(*
Mit dieser Procedure, wird die Matrix um die Z-Achse rotiert.
Der Winkel wird im <b>Bogenmass</b> angegeben.
Für nicht Mathematiker, <b>360°</b> sind <b>2⋅π</b> ( 2⋅Pi ).
*)
//code+
procedure TMatrixfHelper.Rotate(angele: single);
var
  i: integer;
  x, y: GLfloat;
begin
  for i := 0 to 1 do begin
    x := Self[i, 0];
    y := Self[i, 1];
    Self[i, 0] := x * cos(angele) - y * sin(angele);
    Self[i, 1] := x * sin(angele) + y * cos(angele);
  end;
end;

//code-

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
In diesem Code sind zwei Zeilen relevant, eine mit <b>UniformLocation</b> für die Matrix-ID.
In der anderen wird die Matrix, die gedreht wird, erst mal als Einheits-Matrix gesetzt.
Dies ist wichtig, ansonsten sieht man keine Mesh mehr, da diese unendlich klein skaliert wird.
*)
//code+
procedure TForm1.CreateScene;
begin
  Shader := TShader.Create([FileToStr('Vertexshader.glsl'), FileToStr('Fragmentshader.glsl')]);
  Shader.UseProgram;
  Color_ID := Shader.UniformLocation('Color');
  MatrixRot_ID := Shader.UniformLocation('mat'); // Ermittelt die ID von MatrixRot.
  MatrixRot.Indenty;                             // MatrixRot auf Einheits-Matrix setzen.
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
Hier wird die Uniform-Variable <b>MatrixRot</b> dem Shader übergeben.
Mit <b>glUniform4fv(...</b> kann man eine <b>4x4 Matrix</b> dem Shader übergeben.
Für eine 2x2 Matrix wäre dies <b>glUniform2fv(...</b> und für die 3x3 <b>glUniform3fv(...</b>.
*)
//code+
procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT);
  Shader.UseProgram;
  glUniformMatrix4fv(MatrixRot_ID, 1, False, @MatrixRot); // MatrixRot in den Shader.
  //code-

  // Zeichne Dreieck
  glUniform3f(Color_ID, 0.0, 1.0, 1.0);
  glBindVertexArray(VBTriangle.VAO);
  glDrawArrays(GL_TRIANGLES, 0, Length(Triangle) * 3);

  // Zeichne Quadrat
  glUniform3f(Color_ID, 1.0, 0.0, 1.0);
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
  step: GLfloat = 0.01;          // Der Winkel ist im Bogenmass.
begin
  MatrixRot.Rotate(step);        // MatrixRot rotieren.
  ogcDrawScene(Sender);          // Neu zeichnen.
end;
//code-

//lineal

(*
<b>Vertex-Shader:</b>

Hier ist die Uniform-Variable <b>mat</b> hinzugekommen, dies ist auch eine 4x4-Matrix, so wie im Haupt-Programm.
Diese wird im Vertex-Shader deklariert, Bewegungen kommen immer in diesen Shader.

Man sieht dort auch gut, das die <b>Vektoren</b> mit dieser <b>Matrix</b> multipliziert werden.
Da diese Multiplikation im Shader ist, wird die Berechnung in der <b>GPU</b> ausgeführt, und somit wird die <b>CPU</b> entlastet.
Aus diesem Grund haben Gaming-Grafikkarten solch eine grosse Leistung.
*)
//includeglsl Vertexshader.glsl
//lineal

(*
<b>Fragment-Shader:</b>
*)
//includeglsl Fragmentshader.glsl

end.
