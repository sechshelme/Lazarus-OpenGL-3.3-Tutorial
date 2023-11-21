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

(*
Hier ist noch ein Integer-Array dazugekommen.
*)
//code+
type
  TVertex3f = array[0..2] of GLfloat;
  TFace = array[0..2] of TVertex3f;

  TColorIndexs = array[0..2] of GLint;

const
  TriangleVector: array[0..0] of TFace = (
    ((-0.4, 0.1, 0.0), (0.4, 0.1, 0.0), (0.0, 0.7, 0.0)));
  TriangleColorIndex: array[0..0] of TColorIndexs = (
    (0, 1, 2));
  QuadVector: array[0..1] of TFace = (
    ((-0.2, -0.6, 0.0), (-0.2, -0.1, 0.0), (0.2, -0.1, 0.0)),
    ((-0.2, -0.6, 0.0), (0.2, -0.1, 0.0), (0.2, -0.6, 0.0)));
  QuadColorIndex: array[0..1] of TColorIndexs = (
    (0, 1, 2),
    (0, 2, 1));
  //code-

type
  TVB = record
    VAO,
    VBOvert,              // VBO für Vektor.
    VBOcolIndex: GLuint;  // VBO für Farbe Index.
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
  glGenBuffers(1, @VBTriangle.VBOcolIndex);
  glGenBuffers(1, @VBQuad.VBOvert);
  glGenBuffers(1, @VBQuad.VBOcolIndex);
end;

(*
Achtung, bei Integer in einem Attribut, muss
//code+
glVertexAttribIPointer(11, 1, GL_INT, 0, nil);
//code-
anstelle
//code+
glVertexAttribPointer(11, 1, GL_FLOAT, False, 0, nil);
//code-
verwendet werden !
Mehr Infos: https://stackoverflow.com/questions/28014864/why-do-different-variations-of-glvertexattribpointer-exist
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
  glVertexAttribPointer(10, 3, GL_FLOAT, False, 0, nil);

  // Farbe
  glBindBuffer(GL_ARRAY_BUFFER, VBTriangle.VBOcolIndex);
  glBufferData(GL_ARRAY_BUFFER, sizeof(TriangleColorIndex), @TriangleColorIndex, GL_STATIC_DRAW);
  glEnableVertexAttribArray(11);
  glVertexAttribIPointer(11, 1, GL_INT, 0, nil);

  // --- Daten für Quadrat
  glBindVertexArray(VBQuad.VAO);

  // Vektor
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBOvert);
  glBufferData(GL_ARRAY_BUFFER, sizeof(QuadVector), @QuadVector, GL_STATIC_DRAW);
  glEnableVertexAttribArray(10);
  glVertexAttribPointer(10, 3, GL_FLOAT, False, 0, nil);

  // Farbe
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBOcolIndex);
  glBufferData(GL_ARRAY_BUFFER, sizeof(QuadColorIndex), @QuadColorIndex, GL_STATIC_DRAW);
  glEnableVertexAttribArray(11);
  glVertexAttribIPointer(11, 1, GL_INT, 0, nil);
end;
//code-

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
  glDeleteBuffers(1, @VBTriangle.VBOcolIndex);
  glDeleteBuffers(1, @VBQuad.VBOvert);
  glDeleteBuffers(1, @VBQuad.VBOcolIndex);
end;

//lineal

(*
<b>Vertex-Shader:</b>
Hier wird das Integer Attribut verwendet.
*)
//includeglsl Vertexshader.glsl
//lineal

(*
<b>Fragment-Shader</b>
*)
//includeglsl Fragmentshader.glsl

end.
