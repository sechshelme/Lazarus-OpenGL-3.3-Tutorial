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
Die meisten Texturen sind eine Bitmap(Foto) welche im 2D-Format vorliegen.
Es gibt aber noch 1D und 3D-Texturen. Dieses Beispiel zeigt die Anwendung einer 1D-Textur.
Eine 1D-Textur kann man sich am besten als eine farbige Linie vorstellen.
*)
//lineal
(*
Die Texturkoordinaten sind nun keine Vectorenarray mehr sondern nur eine einfache Float-Array.
*)
//code+
const
  QuadVertex: array[0..5] of TVector3f =       // Koordinaten der Polygone.
    ((-0.8, -0.8, 0.0), (0.8, 0.8, 0.0), (-0.8, 0.8, 0.0), (-0.8, -0.8, 0.0), (0.8, -0.8, 0.0), (0.8, 0.8, 0.0));

  TextureVertex: array[0..5] of GLfloat =
    (0.0, 3.0, 0.0, 0.0, 3.0, 3.0);
//code-

(*
Eine Einfache 1D-Textur mit 5 Pixeln.
*)
//code+
const
  Textur24: packed array[0..4, 0..2] of byte =
    (($FF, $00, $00), ($00, $FF, $00), ($00, $00, $FF), ($FF, $FF, $00), ($FF, $FF, $FF));
//code-
type
  TVB = record
    VAO,
    VBOVertex,        // Vertex-Koordinaten
    VBOTex: GLuint;   // Textur-Koordianten
  end;

var
  VBQuad: TVB;
  RotMatrix, ScaleMatrix, ProdMatrix: TMatrix;
  Matrix_ID: GLint;

var
  textureID: GLuint;

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
Generieren des Texturbuffers.
Dies geschieht gleich wie bei der normalen 2D-Textur.
*)
//code+
procedure TForm1.CreateScene;
begin
  glGenTextures(1, @textureID);  // Erzeugen des Textur-Puffer.
  //code-

  glGenVertexArrays(1, @VBQuad.VAO);
  glGenBuffers(1, @VBQuad.VBOVertex);
  glGenBuffers(1, @VBQuad.VBOTex);

  Shader := TShader.Create([FileToStr('Vertexshader.glsl'), FileToStr('Fragmentshader.glsl')]);
  with Shader do begin
    UseProgram;
    Matrix_ID := UniformLocation('mat');
    glUniform1i(UniformLocation('Sampler'), 0);  // Dem Sampler 0 zuweisen.
  end;
  RotMatrix.Identity;
  ScaleMatrix.Identity;
  ScaleMatrix.Scale(0.7);
  ProdMatrix.Identity;
end;

(*
Beim laden muss man bei den Textur-Befehlen beachten, das man <b>GL_TEXTURE_1D</b> nimmt.
Beim VertexAttribut wird für die Textur-Koordinaten nur eine Float-Array übergeben.
*)
//code+
procedure TForm1.InitScene;
begin
  // Textur binden.
  glBindTexture(GL_TEXTURE_1D, textureID);

  // Textur laden.
  glTexImage1D(GL_TEXTURE_1D, 0, GL_RGB, 5, 0, GL_RGB, GL_UNSIGNED_BYTE, @Textur24);

  // Ein minimalst Filter aktivieren, ansonsten bleibt die Ausgabe schwarz.
  glTexParameterf(GL_TEXTURE_1D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);

  // Textur entbinden.
  glBindTexture(GL_TEXTURE_1D, 0);

  glClearColor(0.6, 0.6, 0.4, 1.0); // Hintergrundfarbe

  // Vektorkoordinaten
  glBindVertexArray(VBQuad.VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBOVertex);
  glBufferData(GL_ARRAY_BUFFER, sizeof(QuadVertex), @QuadVertex, GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 3, GL_FLOAT, False, 0, nil);

  // Nur eine Float-Array
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBOTex);
  glBufferData(GL_ARRAY_BUFFER, sizeof(TextureVertex), @TextureVertex, GL_STATIC_DRAW);
  glEnableVertexAttribArray(10);
  glVertexAttribPointer(10, 1, GL_FLOAT, False, 0, nil);
end;
//code-

(*
Das Zeichnen ist nichts besonderes.
*)
//code+
procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT);

  // Textur binden.
  glBindTexture(GL_TEXTURE_1D, textureID);

  Shader.UseProgram;

  ProdMatrix := ScaleMatrix * RotMatrix;
  ProdMatrix.Uniform(Matrix_ID);

  // Zeichne Quadrat
  glBindVertexArray(VBQuad.VAO);
  glDrawArrays(GL_TRIANGLES, 0, Length(QuadVertex));

  ogc.SwapBuffers;
end;
//code-

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Timer1.Enabled := False;

  glDeleteTextures(1, @textureID);       // Textur-Puffer frei geben.
  glDeleteVertexArrays(1, @VBQuad.VAO);
  glDeleteBuffers(1, @VBQuad.VBOVertex);
  glDeleteBuffers(1, @VBQuad.VBOTex);

  Shader.Free;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
const
  step: GLfloat = 0.01;
begin
  RotMatrix.RotateC(step);
  ogcDrawScene(Sender);
end;

//lineal

(*
<b>Vertex-Shader:</b>

Man beachte, das die UV-Koordinaten nur ein <b>Float</b> ist.
*)
//includeglsl Vertexshader.glsl
//lineal

(*
<b>Fragment-Shader:</b>
*)
//includeglsl Fragmentshader.glsl

end.
