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
Wen man mehrere Texturen im gleichen Format hat, kann man diese in einem einzigen Puffer ablegen.
Dafür gibt es <b>GL_TEXTURE_2D_ARRAY</b>.
Inerhalb des Puffers, sind die Texturen in mehreren Ebenen/Layer gespeichert.
Zur Laufzeit muss man nur mit teilen, welche Layer das verwendet werden soll. Dies geschieht über eine Uniform-Variable.

Eine Textur-Array kann man auch für Multitexturing verwenden. Man muss im Fragment-Shader nur bei <b>texture(...</b> nur den Layer angeben.
Eine andere Anwendung wäre, bei einem 2D-Spiel, Sprites in eine Textur-Array abzulegen.
*)
//lineal
(*
Die Koordinaten sind gleich, wie bei einer einzelnen Textur.
*)
//code+
const
  QuadVertex: array[0..5] of TVector3f =       // Koordinaten der Polygone.
    ((-1.0, -1.0, 0.0), (1.0, 1.0, 0.0), (-1.0, 1.0, 0.0),
    (-1.0, -1.0, 0.0), (1.0, -1.0, 0.0), (1.0, 1.0, 0.0));

  TextureVertex: array[0..5] of TVector2f =    // Textur-Koordinaten
    ((0.0, 0.0), (1.0, 1.0), (0.0, 1.0),
    (0.0, 0.0), (1.0, 0.0), (1.0, 1.0));
//code-

type
  TVB = record
    VAO,
    VBOVertex,        // Vertex-Koordinaten
    VBOTex: GLuint;   // Textur-Koordianten
  end;

var
  VBQuad: TVB;
  ScaleMatrix: TMatrix;
  Layer_ID, Matrix_ID,
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

(*
Dieser Puffer wird gleich reserviert, wie bei der einzelnen Textur.
Im Shader ist der Layer eine Unifom-Variable.
*)
//code+
procedure TForm1.CreateScene;
begin
  glGenTextures(1, @textureID);                 // Erzeugen des Textur-Puffer.

  Shader := TShader.Create([FileToStr('Vertexshader.glsl'), FileToStr('Fragmentshader.glsl')]);
  with Shader do begin
    UseProgram;
    Matrix_ID := UniformLocation('mat');
    Layer_ID := UniformLocation('Layer');        // Die ID für den Layer Zugriff.
    glUniform1i(UniformLocation('Sampler'), 0);  // Dem Sampler 0 zuweisen.
  end;

  glGenVertexArrays(1, @VBQuad.VAO);
  glGenBuffers(1, @VBQuad.VBOVertex);
  glGenBuffers(1, @VBQuad.VBOTex);
  //code-

  ScaleMatrix.Identity;
  ScaleMatrix.Scale(0.6, -0.6, 1.0);
end;

(*
Die Ziffern befinde sich alle in einer Bitmap, welche alle Ziffern übereinander beinhaltet.
Man sieht hier gut, das man anstelle von <b>GL_TEXTURE_2D</b>, <b>GL_TEXTURE_2D_ARRAY</b> verwenden muss.
Die Textur-Daten werden mit <b>glTexImage3D(GL_TEXTURE_2D_ARRAY,...</b> übegeben. Neben der Breite und Höhe, muss man noch die Anzahl Layer mitgeben.
Die Höhe muss man noch durch die Anzahl Layer teilen.
*)
//code+
procedure TForm1.InitScene;
const
  anzLayer = 6;
var
  bit: TPicture;                  // Bitmap
begin
  bit := TPicture.Create;
  with bit do begin
    LoadFromFile('ziffer.xpm');   // Das Images laden.

    glBindTexture(GL_TEXTURE_2D_ARRAY, textureID);

    glTexImage3D(GL_TEXTURE_2D_ARRAY, 0, GL_RGB, Width, Height div anzLayer, anzLayer, 0, GL_BGR, GL_UNSIGNED_BYTE, Bitmap.RawImage.Data);

    glTexParameteri(GL_TEXTURE_2D_ARRAY, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
    glTexParameteri(GL_TEXTURE_2D_ARRAY, GL_TEXTURE_MAG_FILTER, GL_NEAREST);

    glBindTexture(GL_TEXTURE_2D_ARRAY, 0);
    Free;                        // Bitmap frei geben.
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
Zeichnen der einzelnen Quadrate. Hier sieht man gut, das nur eine Textur gebunden wird.
Für den Textur-Wechsel muss man nur den Layer übergeben.
Die Matrizen drehen und positionieren nur die Quadrate.
*)
//code+
procedure TForm1.ogcDrawScene(Sender: TObject);
var
  x, y: integer;
  Matrix: TMatrix;
begin
  glClear(GL_COLOR_BUFFER_BIT);

  Shader.UseProgram;
  glBindTexture(GL_TEXTURE_2D_ARRAY, textureID);  // Textur binden.
  glBindVertexArray(VBQuad.VAO);

  for x := 0 to 2 do begin
    for y := 0 to 1 do begin
      Matrix.Identity;
      Matrix.RotateC(x + y * 3 + 1);
      Matrix.Scale(0.4);
      Matrix.Translate(-1.0 + x, -0.5 + y, 0.0);
      Matrix.Multiply(ScaleMatrix, Matrix);
      Matrix.Uniform(Matrix_ID);

      glUniform1i(Layer_ID, x + y * 3);    // Layer wechseln

      glDrawArrays(GL_TRIANGLES, 0, Length(QuadVertex));
    end;
  end;
  //code-

  ogc.SwapBuffers;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  glDeleteTextures(1, @textureID);       // Textur-Puffer frei geben.
  glDeleteVertexArrays(1, @VBQuad.VAO);
  glDeleteBuffers(1, @VBQuad.VBOVertex);
  glDeleteBuffers(1, @VBQuad.VBOTex);

  Shader.Free;
end;

//lineal

(*
Im Fragment-Shader muss ein 2D-Array-Sampler verwendet werden.
Dieser hat ein 3. Parameter, welcher den Layer enthält.
Ansonsten ist der Shader sehr einfach.

<b>Vertex-Shader:</b>
*)
//includeglsl Vertexshader.glsl
//lineal

(*
<b>Fragment-Shader:</b>
*)
//includeglsl Fragmentshader.glsl

(*
<b>ziffer.xpm:</b>
*)
//includecpp ziffer.xpm

end.
