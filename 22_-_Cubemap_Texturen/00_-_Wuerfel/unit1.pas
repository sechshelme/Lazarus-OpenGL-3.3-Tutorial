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
Mit <b>Textur Cube Map</b> hat man die Möglichkeit die Texturen auf einer Würfel-Fläche abzubilden.
Ausser für den einfachen Würfel kann man dies auch für folgendes gebrauchen.
* Hintergrund in einer 360° Optik.
* Reflektionen auf einer Mesh.
Man kann auch eine Kugel oder sonst eine komplizierte Mesh nehmen.

Die Textur-Koordinaten sind 3D-Vektoren, welche auf die Position des Würfels zeigen,
dabei ist nur die Richtung des Vektores wichtig, die Länge ist egal.

Meistens sind Vertex und Texturkoordinaten gleich. Hier im Beispiel ein Würfel.
*)
//lineal
const
  Cube: array[0..11] of Tmat3x3 = (
    // Umfang
    ((-0.5, +0.5, +0.5), (-0.5, -0.5, +0.5), (+0.5, -0.5, +0.5)), ((-0.5, +0.5, +0.5), (+0.5, -0.5, +0.5), (+0.5, +0.5, +0.5)),
    ((+0.5, +0.5, +0.5), (+0.5, -0.5, +0.5), (+0.5, -0.5, -0.5)), ((+0.5, +0.5, +0.5), (+0.5, -0.5, -0.5), (+0.5, +0.5, -0.5)),
    ((+0.5, +0.5, -0.5), (+0.5, -0.5, -0.5), (-0.5, -0.5, -0.5)), ((+0.5, +0.5, -0.5), (-0.5, -0.5, -0.5), (-0.5, +0.5, -0.5)),
    ((-0.5, +0.5, -0.5), (-0.5, -0.5, -0.5), (-0.5, -0.5, +0.5)), ((-0.5, +0.5, -0.5), (-0.5, -0.5, +0.5), (-0.5, +0.5, +0.5)),
    // oben
    ((+0.5, +0.5, +0.5), (+0.5, +0.5, -0.5), (-0.5, +0.5, -0.5)), ((+0.5, +0.5, +0.5), (-0.5, +0.5, -0.5), (-0.5, +0.5, +0.5)),
    // unten
    ((-0.5, -0.5, +0.5), (-0.5, -0.5, -0.5), (+0.5, -0.5, -0.5)), ((-0.5, -0.5, +0.5), (+0.5, -0.5, -0.5), (+0.5, -0.5, +0.5)));

type
  TVB = record
    VAO,
    VBOVertex:GLint;  // Vertex-Koordinaten
  end;

var
  VBCube: TVB;
  RotMatrix: TMatrix;
  Matrix_ID,
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
  Timer1.Enabled := True;
end;

procedure TForm1.CreateScene;
begin
  glGenTextures(1, @textureID);                  // Erzeugen des Textur-Puffer.

  Shader := TShader.Create([FileToStr('Vertexshader.glsl'), FileToStr('Fragmentshader.glsl')]);
  with Shader do begin
    UseProgram;
    Matrix_ID := UniformLocation('mat');
    glUniform1i(UniformLocation('Sampler'), 0);  // Dem Sampler 0 zuweisen.
  end;

  glEnable(GL_DEPTH_TEST);
  glDepthFunc(GL_LESS);

  glGenVertexArrays(1, @VBCube.VAO);
  glGenBuffers(1, @VBCube.VBOVertex);

  RotMatrix.Identity;
end;

(*
Die 6 Flächen des Würfels werden einzeln in VRAM geladen.
Dies geschieht ähnlich, wie bei einer Textur-Array.

Die sechs einelnen Bitmap heisen 1.xpm - 6.xpm .
*)
//code+
procedure TForm1.InitScene;
var
  bit: TPicture; // Bitmap
begin
  bit := TPicture.Create;
  with bit do begin
    glBindTexture(GL_TEXTURE_2D_ARRAY, textureID);

    LoadFromFile('1.xpm');
    glTexImage2D(GL_TEXTURE_CUBE_MAP_POSITIVE_X, 0, GL_RGB, Width, Height, 0, GL_BGR, GL_UNSIGNED_BYTE, Bitmap.RawImage.Data);
    LoadFromFile('2.xpm');
    glTexImage2D(GL_TEXTURE_CUBE_MAP_NEGATIVE_X, 0, GL_RGB, Width, Height, 0, GL_BGR, GL_UNSIGNED_BYTE, Bitmap.RawImage.Data);
    LoadFromFile('3.xpm');
    glTexImage2D(GL_TEXTURE_CUBE_MAP_POSITIVE_Y, 0, GL_RGB, Width, Height, 0, GL_BGR, GL_UNSIGNED_BYTE, Bitmap.RawImage.Data);
    LoadFromFile('4.xpm');
    glTexImage2D(GL_TEXTURE_CUBE_MAP_NEGATIVE_Y, 0, GL_RGB, Width, Height, 0, GL_BGR, GL_UNSIGNED_BYTE, Bitmap.RawImage.Data);
    LoadFromFile('5.xpm');
    glTexImage2D(GL_TEXTURE_CUBE_MAP_POSITIVE_Z, 0, GL_RGB, Width, Height, 0, GL_BGR, GL_UNSIGNED_BYTE, Bitmap.RawImage.Data);
    LoadFromFile('6.xpm');
    glTexImage2D(GL_TEXTURE_CUBE_MAP_NEGATIVE_Z, 0, GL_RGB, Width, Height, 0, GL_BGR, GL_UNSIGNED_BYTE, Bitmap.RawImage.Data);

    glTexParameteri(GL_TEXTURE_CUBE_MAP, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_CUBE_MAP, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_CUBE_MAP, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
    glTexParameteri(GL_TEXTURE_CUBE_MAP, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
    glTexParameteri(GL_TEXTURE_CUBE_MAP, GL_TEXTURE_WRAP_R, GL_CLAMP_TO_EDGE);

    glBindTexture(GL_TEXTURE_2D_ARRAY, 0);
    Free; // Picture frei geben.
  end;
  //code-
  glClearColor(0.6, 0.6, 0.4, 1.0);

  glBindVertexArray(VBCube.VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBCube.VBOVertex);
  glBufferData(GL_ARRAY_BUFFER, sizeof(Cube), @Cube, GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 3, GL_FLOAT, False, 0, nil);
end;

procedure TForm1.ogcDrawScene(Sender: TObject);
var
  Matrix: TMatrix;
begin
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);  // Frame und Tiefen-Buffer löschen.

  glEnable(GL_CULL_FACE);
  glCullface(GL_BACK);

  Shader.UseProgram;
  glBindTexture(GL_TEXTURE_2D_ARRAY, textureID);  // Textur binden.
  glBindVertexArray(VBCube.VAO);

  Matrix.Identity;
  Matrix.Scale(0.8);
  Matrix := RotMatrix * Matrix;
//  Matrix.Translate(0.5, 0.0, 0.0);
  Matrix.Uniform(Matrix_ID);

  glDrawArrays(GL_TRIANGLES, 0, Length(Cube) * 3);

  ogc.SwapBuffers;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Timer1.Enabled := False;

  glDeleteTextures(1, @textureID);       // Textur-Puffer frei geben.
  glDeleteVertexArrays(1, @VBCube.VAO);
  glDeleteBuffers(1, @VBCube.VBOVertex);

  Shader.Free;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  RotMatrix.RotateA(0.02);
  RotMatrix.RotateB(0.02);
  ogcDrawScene(Sender);
end;

//lineal

(*
Die Shader sind gleich, wie wen man alles auf einmal hoch ladet.

<b>Vertex-Shader:</b>
Hier sieht man, das für die Textur und Vertex-Koordinaten die gleichen Werte genommen werden.
*)
//includeglsl Vertexshader.glsl
//lineal

(*
<b>Fragment-Shader:</b>
Einzig Unterschied zu einer normalen Textur, das die Textur-Koordinaten 3D sind.
*)
//includeglsl Fragmentshader.glsl

end.
