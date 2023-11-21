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
Normalerweise, werden die Polygone der Reihenfolge der Vertex-Konstanten abgearbeitet.
Man kann aber auch selbst bestimmen, welche Koordinate abgearbeitet werden.
Dafür muss man eine Indices-Array kreieren, welche die Reihenfolge der Koordinaten bestimmt.

Der Unterschied zum einfachen Zeichenn ist, das ich noch eine Indicen-Array brauche.
Und das Zeichnen ist vor allem anders.
Man verwendet anstelle von <b>glDrawArrays(...</b>, <b>glDrawElements(...</b>, welche als dritten Parameter noch einen Zeiger auf die Indicen-Array bekommt.
*)
//lineal

type
  TVertex3f = array[0..2] of GLfloat; // XYZ-Koordinaten

(*
Die Deklaration der Vektor-Koordianten und Indicien Konstanten.
Beim Dreieck sieht man keinen Vorteil bei der Indicien-Version, da das Dreieck sowieso nur aus einem Polygon besteht.
Beim Quadrat, konnten so schon zwei Koordinaten eingespart werden, da man die Eckpunkte nur einmal angeben muss.
Bei der einfachen Variante bräuchte es dafür sechs Eckpunte, weil dort zwei Punkte doppelt vorhandnen sein müssen.
Bei einem Würfel ist der Vorteil noch grösser, da braucht es bei der einfachen Version 36 Punkte, bei der Indicien-Version, nur 8 Stück !

Mit den Indicen kann ich sagen, zeichen von Punkt 0-1-2 und von Punkt 0-2-3.

//codetext+
3 - 2
| / |
0 - 1
//codetext-
*)
//code+
const
  // --- Dreieck
  // Vertex-Koordinaten
  Triangle: array[0..2] of TVertex3f =
    ((-0.4, 0.1, 0.0), (0.4, 0.1, 0.0), (0.0, 0.7, 0.0));
  // Indicien ( Reihenfolge )
  Triangle_Indices: array[0..2] of GLint = (0, 1, 2);

  // --- Quadrat
  // Vertex-Koordinaten
  Quad: array[0..3] of TVertex3f =
    ((-0.2, -0.6, 0.0), (0.2, -0.6, 0.0), (0.2, -0.1, 0.0), (-0.2, -0.1, 0.0));
  // Indicien ( Reihenfolge )
  Quad_Indices: array[0..5] of GLshort = (0, 1, 2, 0, 2, 3);
//code-

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

procedure TForm1.CreateScene;
begin
  Shader := TShader.Create([FileToStr('Vertexshader.glsl'), FileToStr('Fragmentshader.glsl')]);
  Shader.UseProgram;

  glGenVertexArrays(1, @VBTriangle.VAO);
  glGenVertexArrays(1, @VBQuad.VAO);

  glGenBuffers(1, @VBTriangle.VBO);
  glGenBuffers(1, @VBQuad.VBO);
end;

procedure TForm1.InitScene;
begin
  glClearColor(0.6, 0.6, 0.4, 1.0); // Hintergrundfarbe

  // Daten für das Dreieck
  glBindVertexArray(VBTriangle.VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBTriangle.VBO);
  glBufferData(GL_ARRAY_BUFFER, sizeof(Triangle), @Triangle, GL_STATIC_DRAW);
  glEnableVertexAttribArray(10);
  glVertexAttribPointer(10, 3, GL_FLOAT, False, 0, nil);

  // Daten für das Quadrat
  glBindVertexArray(VBQuad.VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBO);
  glBufferData(GL_ARRAY_BUFFER, sizeof(Quad), @Quad, GL_STATIC_DRAW);
  glEnableVertexAttribArray(10);
  glVertexAttribPointer(10, 3, GL_FLOAT, False, 0, nil);
end;

(*
Bei <b>glDrawElements(...</b>, muss als dritten Parameter der Zeiger auf die Indicien-Array übergeben werden.
Ansonsten geht das Zeichen gleich, wie bei der einfachen Methode.
Der Polygonmodus wurde auf Linien umgestellt, so das man die Polygone besser sieht.
*)
//code+
procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT);
  glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);   // Linien
  Shader.UseProgram;

  // Zeichne Dreieck
  glBindVertexArray(VBTriangle.VAO);
  glDrawElements(GL_TRIANGLES, Length(Triangle_Indices), GL_UNSIGNED_INT, @Triangle_Indices);

  // Zeichne Quadrat
  glBindVertexArray(VBQuad.VAO);
  glDrawElements(GL_TRIANGLES, Length(Quad_Indices), GL_UNSIGNED_SHORT, @Quad_Indices);
  //code-

  ogc.SwapBuffers;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Shader.Free;

  glDeleteVertexArrays(1, @VBTriangle.VAO);
  glDeleteVertexArrays(1, @VBQuad.VAO);

  glDeleteBuffers(1, @VBTriangle.VBO);
  glDeleteBuffers(1, @VBQuad.VBO);
end;

//lineal

(*
<b>Vertex-Shader:</b>

*)
//includeglsl Vertexshader.glsl
//lineal

(*
<b>Fragment-Shader:</b>
*)
//includeglsl Fragmentshader.glsl

end.
