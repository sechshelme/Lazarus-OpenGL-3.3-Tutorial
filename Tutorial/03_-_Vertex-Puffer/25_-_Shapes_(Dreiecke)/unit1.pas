unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, Menus,
  dglOpenGL,
  oglContext, oglShader;

type

  { TForm1 }

  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    ogc: TContext;
    Shader: TShader; // Shader-Object
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

Die Darstellung sieht folgendermassen aus:

<b>GL_TRIANGLES</b>
//code+
4 - 3     2
| /     / |
5     0 - 1
//code-
<b>GL_TRIANGLES_STRIP</b>
//code+
  5 - 3 - 1
 / \ / \ / \
6 - 4 - 2 - 0
//code-
<b>GL_TRIANGLES_FAN</b>
//code+
  5 - 4
 / \ / \
6 - 0 - 3
 \ / \ /
  1 - 2
//code-

*)

//lineal

type
  TVertex2f = array[0..1] of GLfloat; // XY-Koordinaten

(*
Die Deklaration der Vektor-Koordianten Konstanten, zur Vereinfachung habe ich nur 2D-Vektoren genommen. Natürlich können diese auch 3D sein.
*)
//code+
const
  // Einfache Dreiecke        ( Gelb )
  Triangles: array[0..5] of TVertex2f =
    ((0.1, 0.0), (0.6, 0.0), (0.6, 0.5), (0.5, 0.6), (0.0, 0.5), (0.0, 0.1));
  // Dreicke als Band, Strip  ( Rot )
  Triangle_Strip: array[0..6] of TVertex2f =
    ((0.6, 0.0), (0.5, 0.5), (0.4, 0.2), (0.3, 0.5), (0.2, 0.0), (0.1, 0.4), (0.0, 0.0));
  // Dreiecke als Wedel, Fan  ( Grün )
  Triangle_Fan: array[0..6] of TVertex2f =
    ((0.0, 0.0), (-0.2, -0.3), (0.2, -0.3), (0.3, 0.0), (0.2, 0.3), (-0.2, 0.3), (-0.3, 0.0));
//code-

type
  TVB = record
    VAO,
    VBO: GLuint;
  end;

var
  X_ID, Y_ID: GLint;      // ID für X und Y.
  Color_ID: GLint;        // ID für Farbe

  VBTriangles, VBTriangle_Strip, VBTriangle_Fan: TVB;

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
  Color_ID := Shader.UniformLocation('Color');
  X_ID := Shader.UniformLocation('x'); // Ermittelt die ID von x.
  Y_ID := Shader.UniformLocation('y'); // Ermittelt die ID von y.

  glGenVertexArrays(1, @VBTriangles.VAO);
  glGenVertexArrays(1, @VBTriangle_Strip.VAO);
  glGenVertexArrays(1, @VBTriangle_Fan.VAO);

  glGenBuffers(1, @VBTriangles.VBO);
  glGenBuffers(1, @VBTriangle_Strip.VBO);
  glGenBuffers(1, @VBTriangle_Fan.VBO);
end;

(*
Hier werden die Daten in die Grafikkarte geschrieben.
Es hat nichts besonderes.
*)

//code+
procedure TForm1.InitScene;
begin
  glClearColor(0.6, 0.6, 0.4, 1.0); // Hintergrundfarbe

  // Daten für GL_TRIANGLE
  glBindVertexArray(VBTriangles.VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBTriangles.VBO);
  glBufferData(GL_ARRAY_BUFFER, sizeof(Triangles), @Triangles, GL_STATIC_DRAW);
  glEnableVertexAttribArray(10);
  glVertexAttribPointer(10, 2, GL_FLOAT, False, 0, nil);

  // Daten für GL_TRIANGLE_STRIP
  glBindVertexArray(VBTriangle_Strip.VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBTriangle_Strip.VBO);
  glBufferData(GL_ARRAY_BUFFER, sizeof(Triangle_Strip), @Triangle_Strip, GL_STATIC_DRAW);
  glEnableVertexAttribArray(10);
  glVertexAttribPointer(10, 2, GL_FLOAT, False, 0, nil);

  // Daten für GL_TRIANGLE_FAN
  glBindVertexArray(VBTriangle_Fan.VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBTriangle_Fan.VBO);
  glBufferData(GL_ARRAY_BUFFER, sizeof(Triangle_Fan), @Triangle_Fan, GL_STATIC_DRAW);
  glEnableVertexAttribArray(10);
  glVertexAttribPointer(10, 2, GL_FLOAT, False, 0, nil);
end;
//code-

(*
Bei <b>glDrawArrays(...</b> ist der erste Parameter das wichtigste, hier wird angegeben, wie die Vektor-Koordinaten gezeichnet werden.
*)
//code+
procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT);
  Shader.UseProgram;

  // Zeichne GL_TRIANGLE
  glUniform3f(Color_ID, 1.0, 1.0, 0.0); // Gelb
  glUniform1f(X_ID, -0.9);
  glUniform1f(Y_ID, -0.7);
  glBindVertexArray(VBTriangles.VAO);
  glDrawArrays(GL_TRIANGLES, 0, Length(Triangles));

  // Zeichne GL_TRIANGLE_STRIP
  glUniform3f(Color_ID, 1.0, 0.0, 0.0);  // Rot
  glUniform1f(X_ID, 0.3);
  glUniform1f(Y_ID, -0.6);
  glBindVertexArray(VBTriangle_Strip.VAO);
  glDrawArrays(GL_TRIANGLE_STRIP, 0, Length(Triangle_Strip));

  // Zeichne GL_TRIANGLE_FAN
  glUniform3f(Color_ID, 0.0, 1.0, 0.0);  // Grün
  glUniform1f(X_ID, 0.0);
  glUniform1f(Y_ID, 0.4);
  glBindVertexArray(VBTriangle_Fan.VAO);
  glDrawArrays(GL_TRIANGLE_FAN, 0, Length(Triangle_Fan));
  //code-

  ogc.SwapBuffers;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Shader.Free;

  glDeleteVertexArrays(1, @VBTriangles.VAO);
  glDeleteVertexArrays(1, @VBTriangle_Strip.VAO);
  glDeleteVertexArrays(1, @VBTriangle_Fan.VAO);

  glDeleteBuffers(1, @VBTriangles.VBO);
  glDeleteBuffers(1, @VBTriangle_Strip.VBO);
  glDeleteBuffers(1, @VBTriangle_Fan.VBO);
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
