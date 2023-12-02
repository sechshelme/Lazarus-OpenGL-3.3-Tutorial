unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, Menus,
  dglOpenGL,
  oglContext, oglShader, oglVector, oglMatrix;

type

  { TForm1 }

  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    ogc: TContext;
    Shader: TShader; // Shader Klasse
    procedure CreateScene;
    procedure ogcDrawScene(Sender: TObject);
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

//image image.png

(*
Hier wird gezeigt, wie man mehrere Texturen laden kann, im Prinzip geht dies fast gleich wie bei einer Textur.
In diesem Beispiel werden zwei Texturen geladen.

Wichtig dabei ist, das man mit <b>glBindTexture(...</b> immer die richtige Textur bindet.
*)
//lineal
const
  QuadVertex0: array[0..5] of TVector3f =       // Koordinaten der Polygone.
    ((-0.8, -0.8, 0.0), (0.8, 0.8, 0.0), (-0.8, 0.8, 0.0),
    (-0.8, -0.8, 0.0), (0.8, -0.8, 0.0), (0.8, 0.8, 0.0));

  QuadVertex1: array[0..5] of TVector3f =       // Koordinaten der Polygone.
    ((-0.8, -0.8, 0.0), (0.8, 0.8, 0.0), (-0.8, 0.8, 0.0),
    (-0.8, -0.8, 0.0), (0.8, -0.8, 0.0), (0.8, 0.8, 0.0));

  TextureVertex0: array[0..5] of TVector3f =    // Textur-Koordinaten
    ((0.0, 0.0,0.0), (1.0, 1.0,0.0), (0.0, 1.0,0.0),
    (0.0, 0.0,0.0), (1.0, 0.0,0.0), (1.0, 1.0,0.0));

  TextureVertex1: array[0..5] of TVector3f =    // Textur-Koordinaten
    ((0.0, 0.0,1.0), (1.0, 1.0,1.0), (0.0, 1.0,1.0),
    (0.0, 0.0,1.0), (1.0, 0.0,1.0), (1.0, 1.0,1.0));


(*
Da es zwei Texturn hat, ist noch eine zweite Textur-Konstnate dazu gekommen.
*)
//code+
const
  Textur32_0: packed array[0..7, 0..3] of byte = (
  ($FF, $00, $00, $FF), ($00, $FF, $00, $FF), ($00, $00, $FF, $FF), ($FF, $00, $00, $FF),
($00, $FF, $FF, $FF), ($FF, $00, $FF, $FF), ($FF, $FF, $00, $FF), ($00, $FF, $FF, $FF));
//code-

type
  TVB = record
    VAO,
    VBOVertex,
    VBOTex: GLuint;
  end;

var
  VBQuad0,VBQuad1: TVB;
  ScaleMatrix, ProdMatrix: TMatrix;
  Matrix_ID: GLint;

(*
Da es zwei Texturen hat, bracuht es auch zwei IDs.
*)
//code+
var
  textureID:  GLuint;
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
end;

(*
Da die Zextur-IDs in einer Array sind, kann man die Textur-Puffer mit nur einem <b>glGenTextures(...</b> erzeugen.
Dazu gebe ich als ersten Parameter die Länge der Array an.
Natürlich könnte man die Puffer auch einzeln erzeugen.

Das selbe könnte man auch bei den VAOs und VBOs machen.


// https://stackoverflow.com/questions/16553671/opengl-how-to-use-glteximage3d-function
*)
//code+
procedure TForm1.CreateScene;
begin
  //code-

  Shader := TShader.Create([FileToStr('Vertexshader.glsl'), FileToStr('Fragmentshader.glsl')]);
  with Shader do begin
    UseProgram;
    Matrix_ID := UniformLocation('mat');
    glUniform1i(UniformLocation('Sampler'), 0);  // Dem Sampler 0 zuweisen.
  end;
  ScaleMatrix.Identity;
  ScaleMatrix.Scale(0.5);
  ProdMatrix.Identity;

  glGenTextures(1, @textureID);  // Erster Parameter die Länge der Arrray.
  // Textur 0 laden.
  glEnable(GL_TEXTURE_3D);
  glBindTexture(GL_TEXTURE_3D, textureID);
  glTexImage3D(GL_TEXTURE_3D, 0, GL_RGBA, 2, 2,2, 0, GL_RGBA, GL_UNSIGNED_BYTE, @Textur32_0);
  glTexParameterf(GL_TEXTURE_3D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);

//  glTexParameteri(GL_TEXTURE_3D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
//  glTexParameteri(GL_TEXTURE_3D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
  glTexParameteri(GL_TEXTURE_3D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
  glTexParameteri(GL_TEXTURE_3D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
  glTexParameteri(GL_TEXTURE_3D, GL_TEXTURE_WRAP_R, GL_CLAMP_TO_EDGE);

//  glBindImageTexture(0, textureID, 0, GL_TRUE, 0, GL_READ_WRITE, GL_R8);
  glBindImageTexture(0, textureID, 0, GL_TRUE, 0, GL_READ_WRITE, GL_RGBA);

  glBindTexture(GL_TEXTURE_3D, 0);
  //code-

  glClearColor(0.6, 0.6, 0.4, 1.0);

  // Quad 0
  glGenVertexArrays(1, @VBQuad0.VAO);
  glGenBuffers(1, @VBQuad0.VBOVertex);
  glGenBuffers(1, @VBQuad0.VBOTex);

  glBindVertexArray(VBQuad0.VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad0.VBOVertex);
  glBufferData(GL_ARRAY_BUFFER, sizeof(QuadVertex0), @QuadVertex0, GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 3, GL_FLOAT, False, 0, nil);

  glBindBuffer(GL_ARRAY_BUFFER, VBQuad0.VBOTex);
  glBufferData(GL_ARRAY_BUFFER, sizeof(TextureVertex0), @TextureVertex0, GL_STATIC_DRAW);
  glEnableVertexAttribArray(1);
  glVertexAttribPointer(1, 3, GL_FLOAT, False, 0, nil);

  // Quad 1
  glGenVertexArrays(1, @VBQuad1.VAO);
  glGenBuffers(1, @VBQuad1.VBOVertex);
  glGenBuffers(1, @VBQuad1.VBOTex);

  glBindVertexArray(VBQuad1.VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad1.VBOVertex);
  glBufferData(GL_ARRAY_BUFFER, sizeof(QuadVertex1), @QuadVertex1, GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 3, GL_FLOAT, False, 0, nil);

  glBindBuffer(GL_ARRAY_BUFFER, VBQuad1.VBOTex);
  glBufferData(GL_ARRAY_BUFFER, sizeof(TextureVertex1), @TextureVertex1, GL_STATIC_DRAW);
  glEnableVertexAttribArray(1);
  glVertexAttribPointer(1, 3, GL_FLOAT, False, 0, nil);
end;

(*
Hier sieht man, das ich für die beiden Qudrate unterschiedliche Texturen binde.
Koordinaten verwende ich für beide Qudrate die gleichen, einziger Unterschied, ich verschiebe die Matrix in unterschiedliche Richtungen.
Aus diesem Grund wird die VAO auch nur einmal gebunden.
*)
//code+
procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT);
  Shader.UseProgram;

  glBindTexture(GL_TEXTURE_3D, textureID);  // Textur binden.

  // Linkes Quadrat.
  glBindVertexArray(VBQuad0.VAO);
  ProdMatrix := ScaleMatrix;
  ProdMatrix.Translate(-0.5, 0.0, 0.0);
  ProdMatrix.Uniform(Matrix_ID);

  glDrawArrays(GL_TRIANGLES, 0, Length(QuadVertex0));

  // Rechtes Quadrat.
  glBindVertexArray(VBQuad1.VAO);
  ProdMatrix := ScaleMatrix;
  ProdMatrix.Translate(0.5, 0.0, 0.0);
  ProdMatrix.Uniform(Matrix_ID);

  glDrawArrays(GL_TRIANGLES, 0, Length(QuadVertex1));
  ogc.SwapBuffers;
end;
//code-

(*
Logischerweise muss man auch wieder beide Textur-Puffer frei geben.
*)
//code+
procedure TForm1.FormDestroy(Sender: TObject);
begin
  glDeleteTextures(1, @textureID); // Textur-Puffer frei geben.
//code-
glDeleteVertexArrays(1, @VBQuad0.VAO);
glDeleteBuffers(1, @VBQuad0.VBOVertex);
glDeleteBuffers(1, @VBQuad0.VBOTex);

glDeleteVertexArrays(1, @VBQuad1.VAO);
glDeleteBuffers(1, @VBQuad1.VBOVertex);
glDeleteBuffers(1, @VBQuad1.VBOTex);

  Shader.Free;
end;

//lineal

(*
Die Shader sind genau gleich, wie bei einer Textur.

<b>Vertex-Shader:</b>

*)
//includeglsl Vertexshader.glsl
//lineal

(*
<b>Fragment-Shader:</b>

*)
//includeglsl Fragmentshader.glsl

end.
