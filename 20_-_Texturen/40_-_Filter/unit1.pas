unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls,
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
Hier wird gezeigt, wie man Filter für Texturen verwenden kann.
In diesem Beispiel wird nur eine Texturen geladen, aber es werden mehrere Filter verwendet.

Die Filter verstellt man mit <b>glTexParameter(...</b>.
*)
//lineal
const
  QuadVertex: array[0..5] of TVector3f =       // Koordinaten der Rechtecke.
    ((-0.8, -0.8, 0.0), (0.8, 0.8, 0.0), (-0.8, 0.8, 0.0),
    (-0.8, -0.8, 0.0), (0.8, -0.8, 0.0), (0.8, 0.8, 0.0));

  TextureVertex: array[0..5] of TVector2f =    // Textur-Koordinaten
    ((-2.0, -2.0), (2.0, 2.0), (-2.0, 2.0),
    (-2.0, -2.0), (2.0, -2.0), (2.0, 2.0));

type
  TVB = record
    VAO,
    VBOVertex,
    VBOTex: GLuint;
  end;

var
  VBQuad: TVB;
  ScaleMatrix: TMatrix;
  Matrix_ID: GLint;
  textureID: GLuint;

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
  glGenVertexArrays(1, @VBQuad.VAO);
  glGenBuffers(1, @VBQuad.VBOVertex);
  glGenBuffers(1, @VBQuad.VBOTex);

  glGenTextures(1, @textureID);

  Shader := TShader.Create([FileToStr('Vertexshader.glsl'), FileToStr('Fragmentshader.glsl')]);
  with Shader do begin
    UseProgram;
    Matrix_ID := UniformLocation('mat');
    glUniform1i(UniformLocation('Sampler'), 0);
  end;
  ScaleMatrix.Identity;
  ScaleMatrix.Scale(0.5);
end;

(*
Hier wird die Textur geladen und der Filter <b>MIN_FILTER</b> festgelegt, welcher für alle Ausgaben gültig ist.
*)
//code+
procedure TForm1.InitScene;
var
  pic: TPicture;

begin
  pic := TPicture.Create;
  with pic do begin
    LoadFromFile('bild.xpm');

    // Textur laden
    glBindTexture(GL_TEXTURE_2D, textureID);
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB8, Width, Height, 0, GL_BGR, GL_UNSIGNED_BYTE, Bitmap.RawImage.Data);

    // Globaler Filter
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);

    glBindTexture(GL_TEXTURE_2D, 0);
    Free;
  end;
  //code-

  glClearColor(0.6, 0.6, 0.4, 1.0);

  glBindVertexArray(VBQuad.VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBOVertex);
  glBufferData(GL_ARRAY_BUFFER, sizeof(QuadVertex), @QuadVertex, GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 3, GL_FLOAT, False, 0, nil);

  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBOTex);
  glBufferData(GL_ARRAY_BUFFER, sizeof(TextureVertex), @TextureVertex, GL_STATIC_DRAW);
  glEnableVertexAttribArray(10);
  glVertexAttribPointer(10, 2, GL_FLOAT, False, 0, nil);
end;

(*
Bei dem Filter <b>GL_CLAMP_TO_BORDER</b> kann man noch eine Hintergrundfarbe festlegen.
*)
//code+
procedure TForm1.ogcDrawScene(Sender: TObject);
// Hintergrundfarbe für Clamp_to_Border, ein Dunkelgrün.
const
  border: array[0..3] of GLfloat = (0.0, 0.3, 0.0, 1.0);
var
  ProdMatrix: TMatrix;
begin
  glClear(GL_COLOR_BUFFER_BIT);
  Shader.UseProgram;

  glBindVertexArray(VBQuad.VAO);
  glBindTexture(GL_TEXTURE_2D, textureID);  // Textur binden.

  // Links-Oben
  glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
  glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);

  ProdMatrix := ScaleMatrix;
  ProdMatrix.Translate(-0.5, 0.5, 0.0);
  ProdMatrix.Uniform(Matrix_ID);

  glDrawArrays(GL_TRIANGLES, 0, Length(QuadVertex));

  // Rechts-Oben
  glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_BORDER);
  glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_BORDER);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
  glTexParameterfv(GL_TEXTURE_2D, GL_TEXTURE_BORDER_COLOR, @border);

  ProdMatrix := ScaleMatrix;
  ProdMatrix.Translate(0.5, 0.5, 0.0);
  ProdMatrix.Uniform(Matrix_ID);

  glDrawArrays(GL_TRIANGLES, 0, Length(QuadVertex));

  // Links-Unten
  glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_MIRRORED_REPEAT);
  glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_MIRRORED_REPEAT);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);

  ProdMatrix := ScaleMatrix;
  ProdMatrix.Translate(-0.5, -0.5, 0.0);
  ProdMatrix.Uniform(Matrix_ID);

  glDrawArrays(GL_TRIANGLES, 0, Length(QuadVertex));

  // Rechts-Unten
  glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
  glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);

  ProdMatrix := ScaleMatrix;
  ProdMatrix.Translate(0.5, -0.5, 0.0);
  ProdMatrix.Uniform(Matrix_ID);

  glDrawArrays(GL_TRIANGLES, 0, Length(QuadVertex));

  ogc.SwapBuffers;
end;
//code-

procedure TForm1.FormDestroy(Sender: TObject);
begin
  glDeleteTextures(1, @textureID);
  glDeleteVertexArrays(1, @VBQuad.VAO);
  glDeleteBuffers(1, @VBQuad.VBOVertex);
  glDeleteBuffers(1, @VBQuad.VBOTex);

  Shader.Free;
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

//lineal

(*
<b>bild.xpm</b>

*)
//includecpp bild.xpm

end.
