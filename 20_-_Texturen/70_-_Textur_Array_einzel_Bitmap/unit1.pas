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
Man kann auch in jedem Layer einzeln die Texturen laden.
Der einzige Unterschied zum kompletten laden ist, man ladet die Texturen einzeln mit SubImage hoch.
Der Rest ist gleich, wie wen man alles miteinander hoch ladet.
*)
//lineal
const
  QuadVertex: array[0..5] of TVector3f =       // Koordinaten der Polygone.
    ((-1.0, -1.0, 0.0), (1.0, 1.0, 0.0), (-1.0, 1.0, 0.0),
    (-1.0, -1.0, 0.0), (1.0, -1.0, 0.0), (1.0, 1.0, 0.0));

  TextureVertex: array[0..5] of TVector2f =    // Textur-Koordinaten
    ((0.0, 0.0), (1.0, 1.0), (0.0, 1.0),
    (0.0, 0.0), (1.0, 0.0), (1.0, 1.0));

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

  ScaleMatrix.Identity;
  ScaleMatrix.Scale(0.6, -0.6, 1.0);
end;

(*
Mit <b>glTexImage3D(...</b> wird nur der Speicher für die Texturen reserviert. Dabei muss man von Anfang an wissen, wie gross die Texturen sind.
Mit <b>glTexSubImage3D(...</b> werden dann die Texturen Layer für Layer hochgeladen.
Die sechs einzelnen Bitmap heisen 1.xpm - 6.xpm .
*)
//code+
procedure TForm1.InitScene;
const
  size = 8;      // Grösse der Texturen
  anzLayer = 6;
var
  i: integer;
  bit: TPicture; // Bitmap
begin
  bit := TPicture.Create;
  with bit do begin

    glBindTexture(GL_TEXTURE_2D_ARRAY, textureID);

    // Speicher reservieren
    glTexImage3D(GL_TEXTURE_2D_ARRAY, 0, GL_RGB, size, size, anzLayer, 0, GL_BGR, GL_UNSIGNED_BYTE, nil);
    glTexParameteri(GL_TEXTURE_2D_ARRAY, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
    glTexParameteri(GL_TEXTURE_2D_ARRAY, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
    for i := 0 to anzLayer - 1 do begin

      // Bitmap von HD laden.
      LoadFromFile(IntToStr(i + 1) + '.xpm');   // Die Images laden.

      // Texturen hoch laden
      glTexSubImage3D(GL_TEXTURE_2D_ARRAY, 0, 0, 0, i, Width, Height, 1, GL_BGR, GL_UNSIGNED_BYTE, Bitmap.RawImage.Data);
    end;
    glBindTexture(GL_TEXTURE_2D_ARRAY, 0);
    Free; // Picture frei geben.
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
      Matrix.Scale(0.4);
      Matrix.Translate(-1.0 + x, -0.5 + y, 0.0);
      Matrix := ScaleMatrix * Matrix;
      Matrix.Uniform(Matrix_ID);

      glUniform1i(Layer_ID, x + y * 3);    // Layer wechseln

      glDrawArrays(GL_TRIANGLES, 0, Length(QuadVertex));
    end;
  end;

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
Die Shader sind gleich, wie wen man alles auf einmal hoch ladet.

<b>Vertex-Shader:</b>
*)
//includeglsl Vertexshader.glsl
//lineal

(*
<b>Fragment-Shader:</b>
*)
//includeglsl Fragmentshader.glsl

end.
