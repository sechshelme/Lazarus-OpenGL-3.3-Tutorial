unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls,
  oglglad_gl,
  oglContext, oglShader, ogldebug;

  //image image.png
(*
Man kann die Vertex-Daten, auch alles in einen Daten-Block schreiben. Hier werden die Vector- und Color - Daten alle in einen Block geschrieben.
In den vorherigen Beispielen hat es für die Vector- und  Color - Daten eine separate TFace-Array gehabt.
Hier werden zwei Möglichkeiten vorgestellt, wie die Daten in der Array sind.
Variante1: <b>Vec0, Col0, ..., Vecn, Coln</b>
Variante2: <b>Vec0, ..., Vecn, Col0, ..., Coln</b>
Die hat noch den Vorteil, das nur ein <b>VBO</b> angelegt werden muss, obwohl mehrere Attribute in der Array sind.
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
  QuadVektor1: array[0..35] of GLfloat = (
    // Vec
    -0.2, -0.2, 0.2, -0.2, 0.2, 0.2,
    -0.6, -0.1, -0.1, -0.6, -0.1, -0.6,
    0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
    // Col
    1.0, 0.0, 1.0, 1.0, 1.0, 0.0,
    0.0, 1.0, 1.0, 0.0, 1.0, 1.0,
    1.0, 0.0, 1.0, 1.0, 1.0, 1.0
    );
  //code-

type
  TVB = record
    VAO,
    VBO: GLuint;
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
  //  ini
end;

procedure TForm1.CreateScene;
begin
  Shader := TShader.Create([FileToStr('Vertexshader.glsl'), FileToStr('Fragmentshader.glsl')]);
  Shader.UseProgram;

  glGenVertexArrays(1, @VBQuad0.VAO);
  glGenVertexArrays(1, @VBQuad1.VAO);

  glGenBuffers(1, @VBQuad0.VBO);
  glGenBuffers(1, @VBQuad1.VBO);
end;

//code+
procedure TForm1.InitScene;
begin
  glClearColor(0.6, 0.6, 0.4, 1.0);

  // --- Daten für Quadrat 0
  glBindVertexArray(VBQuad0.VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad0.VBO);
  glBufferData(GL_ARRAY_BUFFER, sizeof(QuadVektor0), @QuadVektor0, GL_STATIC_DRAW);

  glEnableVertexAttribArray(10);
  glVertexAttribPointer(10, 1, GL_FLOAT, GL_FALSE, 24, Pointer(0));

  glEnableVertexAttribArray(11);
  glVertexAttribPointer(11, 1, GL_FLOAT, GL_FALSE, 24, Pointer(4));

  glEnableVertexAttribArray(12);
  glVertexAttribPointer(12, 1, GL_FLOAT, GL_FALSE, 24, Pointer(8));

  glEnableVertexAttribArray(13);
  glVertexAttribPointer(13, 1, GL_FLOAT, GL_FALSE, 24, Pointer(12));

  glEnableVertexAttribArray(14);
  glVertexAttribPointer(14, 1, GL_FLOAT, GL_FALSE, 24, Pointer(16));

  glEnableVertexAttribArray(15);
  glVertexAttribPointer(15, 1, GL_FLOAT, GL_FALSE, 24, Pointer(20));

  // --- Daten für Quadrat 1
  glBindVertexArray(VBQuad1.VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad1.VBO);
  glBufferData(GL_ARRAY_BUFFER, sizeof(QuadVektor1), @QuadVektor1, GL_STATIC_DRAW);

  glEnableVertexAttribArray(10);
  glVertexAttribPointer(10, 1, GL_FLOAT, GL_FALSE, 4, Pointer(0));

  glEnableVertexAttribArray(11);
  glVertexAttribPointer(11, 1, GL_FLOAT, GL_FALSE, 4, Pointer(24));

  glEnableVertexAttribArray(12);
  glVertexAttribPointer(12, 1, GL_FLOAT, GL_FALSE, 4, Pointer(48));

  glEnableVertexAttribArray(13);
  glVertexAttribPointer(13, 1, GL_FLOAT, GL_FALSE, 4, Pointer(72));

  glEnableVertexAttribArray(14);
  glVertexAttribPointer(14, 1, GL_FLOAT, GL_FALSE, 4, Pointer(96));

  glEnableVertexAttribArray(15);
  glVertexAttribPointer(15, 1, GL_FLOAT, GL_FALSE, 4, Pointer(120));
end;

//code-

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

  glDeleteBuffers(1, @VBQuad0.VBO);
  glDeleteBuffers(1, @VBQuad1.VBO);
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
