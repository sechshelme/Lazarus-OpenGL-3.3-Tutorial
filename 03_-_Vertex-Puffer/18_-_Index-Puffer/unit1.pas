unit Unit1;
{$include ..\..\units\opts.inc}
{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, Menus,
{$IFDEF COREGL}
glcorearb,
{$ELSE}
dglOpenGL,
{$ENDIF}
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
Die Indicien, kann man auch von Anfang an ins VRAM laden, so müssen die Daten nich jedes mal mit <b>glDrawElements(...</b> neu übegeben werden.
Dafür gibt es den <b> Index Buffer Objects</b> (IBO).
Das Laden geschieht ähnlich wie mit den Vertex-Daten.
*)
//lineal

type
  TVertex3f = array[0..2] of GLfloat; // XYZ-Koordinaten

(*
Die Deklaration der Vektor-Koordianten und Indicien Konstanten, dies ist gleich wie ohne Buffer.
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
  Quad_Indices: array[0..5] of GLint = (0, 1, 2, 0, 2, 3);
//code-

(*
Der IBO muss noch deklariert werden.
*)
type
  TVB = record
    VAO,
    IBO,  // Deklaration des IBO.
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

(*
Das Erzeugen des IBI-Puffer geht gleich wie beim VBO-Puffer.
*)
procedure TForm1.CreateScene;
begin
  Shader := TShader.Create([FileToStr('Vertexshader.glsl'), FileToStr('Fragmentshader.glsl')]);
  Shader.UseProgram;

  glGenVertexArrays(1, @VBTriangle.VAO);
  glGenVertexArrays(1, @VBQuad.VAO);

  glGenBuffers(1, @VBTriangle.VBO);
  glGenBuffers(1, @VBQuad.VBO);

  glGenBuffers(1, @VBTriangle.IBO); // Indices-Buffer erzeugen
  glGenBuffers(1, @VBQuad.IBO);
end;

(*
Hier werden die IBO-Daten in den Buffer geladen, dies geschieht ähnlich, wie bei den Vertex-Daten.
Der Unterschied ist der zweite Parameter, dieser muss <b>GL_ELEMENT_ARRAY_BUFFER</b> sein.
*)

procedure TForm1.InitScene;
begin
  glClearColor(0.6, 0.6, 0.4, 1.0); // Hintergrundfarbe

  // --- Daten für das Dreieck
  glBindVertexArray(VBTriangle.VAO);

  glBindBuffer(GL_ARRAY_BUFFER, VBTriangle.VBO);
  glBufferData(GL_ARRAY_BUFFER, sizeof(Triangle), @Triangle, GL_STATIC_DRAW);

  // IBO binden und mit den Indices-Daten laden
  glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, VBTriangle.IBO);
  glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(Triangle_Indices), @Triangle_Indices, GL_STATIC_DRAW);

  glEnableVertexAttribArray(10);
  glVertexAttribPointer(10, 3, GL_FLOAT, GL_FALSE, 0, nil);

  // --- Daten für das Quadrat
  glBindVertexArray(VBQuad.VAO);

  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBO);
  glBufferData(GL_ARRAY_BUFFER, sizeof(Quad), @Quad, GL_STATIC_DRAW);

  // IBO binden und mit den Indices-Daten laden
  glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, VBQuad.IBO);
  glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(Quad_Indices), @Quad_Indices, GL_STATIC_DRAW);

  glEnableVertexAttribArray(10);
  glVertexAttribPointer(10, 3, GL_FLOAT, GL_FALSE, 0, nil);
end;

(*
Da die Indicien im IBO gespeichert sind muss der dritte Paramter bei <b>glDrawElements(...</b>, nil sein.
*)
//code+
procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT);
  glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);   // Linien
  Shader.UseProgram;

  // Zeichne Dreieck
  glBindVertexArray(VBTriangle.VAO);
  glDrawElements(GL_TRIANGLES, Length(Triangle_Indices), GL_UNSIGNED_INT, Nil);  // Hier Nil

  // Zeichne Quadrat
  glBindVertexArray(VBQuad.VAO);
  glDrawElements(GL_TRIANGLES, Length(Quad_Indices), GL_UNSIGNED_INT, Nil);      // Hier Nil
  //code-

  ogc.SwapBuffers;
end;

(*
IBO Freigabe ist glech wie bei dem VBO.
*)
//code+
procedure TForm1.FormDestroy(Sender: TObject);
begin
  Shader.Free;

  glDeleteBuffers(1, @VBTriangle.IBO);  // Indices-Buffer freigeben.
  glDeleteBuffers(1, @VBQuad.IBO);
//code-
  glDeleteBuffers(1, @VBTriangle.VBO);
  glDeleteBuffers(1, @VBQuad.VBO);

  glDeleteVertexArrays(1, @VBTriangle.VAO);
  glDeleteVertexArrays(1, @VBQuad.VAO);
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
