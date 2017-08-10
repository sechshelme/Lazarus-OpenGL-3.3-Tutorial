unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, Menus,
  dglOpenGL,
  oglContext, oglShader, oglMatrix;

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
Hier wird die Mesh verschoben, und anschliessend gedreht.

Dazu werden zwei 4x4 Matrixen verwendet, eine für das Verschieben und die andere für die Drehung.
Eine dritte Matrix ist noch für das Produkt von den zweit Matrixen, welche dann am Shader übergeben wird.
Im Timer wird Matrix-Rotation ausgeführt.

Für Matrixen, wird ab jetzt Klassen aus der Unit <b>OpenGLMatrix</b> verwendent, dies macht das Ganze übersichtlicher.
Im Constructor wird die Matrix von Anfang an auf die Einheits-Matrix gesetzt.
*)

//lineal

type
  TQuad = array[0..1] of TFace3D;

const
  Quad: TQuad =
    (((-0.8, -0.8, 0.0), (0.8, 0.8, 0.0), (-0.8, 0.8, 0.0)),
    ((-0.8, -0.8, 0.0), (0.8, -0.8, 0.0), (0.8, 0.8, 0.0)));

  TextureVertex: array[0..5] of TVector2f =
    ((0.0, 0.0), (1.0, 1.0), (0.0, 1.0),
    (0.0, 0.0), (1.0, 0.0), (1.0, 1.0));

  Textur32_0: packed array[0..1, 0..1, 0..3] of byte = ((($FF, $00, $00, $FF), ($00, $FF, $00, $FF)), (($00, $00, $FF, $FF), ($FF, $00, $00, $FF)));
  Textur32_1: packed array[0..1, 0..1, 0..3] of byte = ((($00, $FF, $FF, $FF), ($FF, $00, $FF, $FF)), (($FF, $FF, $00, $FF), ($00, $FF, $FF, $FF)));

type
  TVB = record
    VAO,
    VBOVertex, VBOTex: GLuint;
  end;

(*
Die Deklaration der drei Matrixen.
Und die ID für den Shader. ID wird nur eine gebraucht, da nur da Produkt dem Shader übergeben wird.
*)
//code+
var
  RotMatrix, TransMatrix, prodMatrix: TMatrix;   // Matrixen von der Klasse aus oglMatrix.
  Matrix_ID: GLint;                              // ID für Matrix.
  //code-

  VBTriangle: TVB;

  textureID0: GLuint;


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

(*
Hier werden die drei Matrixen-Klassen erzeugt.
Mit diesem Kontruktor wird die Matrix automatisch auf die Einheits-Matrix gesetzt.
*)
//code+
procedure TForm1.CreateScene;
begin
  Shader := TShader.Create([FileToStr('Vertexshader.glsl'), FileToStr('Fragmentshader.glsl')]);
  with Shader do begin
    UseProgram;
    Matrix_ID := UniformLocation('mat');
    glUniform1i(UniformLocation('Sampler'), 0);
  end;
  RotMatrix := TMatrix.Create;            // Die drei Konstruktoren
  TransMatrix := TMatrix.Create;
  prodMatrix := TMatrix.Create;
  TransMatrix.Translate(0.5, 0.0, 0.0);   // TransMatrix um 0.5 nach links verschieben.
  //code-

  glGenVertexArrays(1, @VBTriangle.VAO);

  glGenBuffers(1, @VBTriangle.VBOVertex);
  glGenBuffers(1, @VBTriangle.VBOTex);
end;

(*
Texturen laden
*)
//code+
procedure TForm1.InitScene;
begin
  // ------------ Texture laden --------------

  glGenTextures(1, @textureID0);
  glBindTexture(GL_TEXTURE_2D, textureID0);

  glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, 2, 2, 0, GL_RGBA, GL_UNSIGNED_BYTE, nil);

  //  glTexStorage2D(GL_TEXTURE_2D, 0, GL_RGBA, 2, 2);
  //  glTexSubImage2D(GL_TEXTURE_2D, 0, 0, 0, 2, 2, GL_RGBA, GL_UNSIGNED_BYTE, @Textur32);

  glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
  glBindTexture(GL_TEXTURE_2D, 0);


  glClearColor(0.6, 0.6, 0.4, 1.0); // Hintergrundfarbe

  // Daten für Dreieck
  glBindVertexArray(VBTriangle.VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBTriangle.VBOVertex);
  glBufferData(GL_ARRAY_BUFFER, sizeof(Quad), @Quad, GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 3, GL_FLOAT, False, 0, nil);

  glBindBuffer(GL_ARRAY_BUFFER, VBTriangle.VBOTex);
  glBufferData(GL_ARRAY_BUFFER, sizeof(TextureVertex), @TextureVertex, GL_STATIC_DRAW);
  glEnableVertexAttribArray(10);
  glVertexAttribPointer(10, 2, GL_FLOAT, False, 0, nil);
end;
//code-

(*
*)
//code+
procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT);

  glBindTexture(GL_TEXTURE_2D, textureID0);
  //code-

  Shader.UseProgram;

  prodMatrix.Multiply(TransMatrix, RotMatrix);
  prodMatrix.Uniform(Matrix_ID);

  // Zeichne Quadrat
  glBindVertexArray(VBTriangle.VAO);
  glDrawArrays(GL_TRIANGLES, 0, Length(Quad) * 3);


  ogc.SwapBuffers;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Timer1.Enabled := False;

  prodMatrix.Free;
  RotMatrix.Free;
  TransMatrix.Free;

  Shader.Free;

  glDeleteTextures(1, @textureID0);
  glDeleteVertexArrays(1, @VBTriangle.VAO);
  glDeleteBuffers(1, @VBTriangle.VBOVertex);
  glDeleteBuffers(1, @VBTriangle.VBOTex);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
const
  step: GLfloat = 0.01;

const  z: integer=1;
begin
  if z > 10 then begin
    glTexSubImage2D(GL_TEXTURE_2D, 0, 0, 0, 2, 2, GL_RGBA, GL_UNSIGNED_BYTE, @Textur32_0);
  end else begin
    glTexSubImage2D(GL_TEXTURE_2D, 0, 0, 0, 2, 2, GL_RGBA, GL_UNSIGNED_BYTE, @Textur32_1);
  end;
  if z > 20 then begin
    z := 0;
  end;
  Inc(z);

  RotMatrix.RotateC(step);
  ogcDrawScene(Sender);
end;

//lineal

(*
<b>Vertex-Shader:</b>

Hier ist die Uniform-Variable <b>mat</b> hinzugekommen.
Diese wird im Vertex-Shader deklariert, Bewegungen kommen immer in diesen Shader.
*)
//includeglsl Vertexshader.glsl
//lineal

(*
<b>Fragment-Shader:</b>
*)
//includeglsl Fragmentshader.glsl

end.
