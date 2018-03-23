unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, Menus,
  dglOpenGL,
  oglContext, oglShader, oglVertex, oglMatrix,
  oglTextur; // Unit für Texturen

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
Multitexturing, tönt Anfangs sehr kompliziert, aber im Grunde ist es sehr einfach.
Der Unterschied zu einer einzelnen Textur ist, das man mehrere Texturen über die Mesh zieht.
Somit muss man auch mehrere Texturen beim Zeichenen mittels <b>glActiveTexture(...</b> aktivieren.

Hier im Beispiel, ist es ein Stück Mauer, welches mit einer farbigen Lampe angeleuchtet wird.
*)
//lineal

const
  QuadVertex: array[0..5] of TVector3f =
    ((-0.8, -0.8, 0.0), (0.8, 0.8, 0.0), (-0.8, 0.8, 0.0),
    (-0.8, -0.8, 0.0), (0.8, -0.8, 0.0), (0.8, 0.8, 0.0));

  TextureVertex0: array[0..5] of TVector2f =
    ((0.0, 0.0), (4.0, 4.0), (0.0, 4.0),
    (0.0, 0.0), (4.0, 0.0), (4.0, 4.0));

  TextureVertex1: array[0..5] of TVector2f =
    ((0.0, 0.0), (1.0, 1.0), (0.0, 1.0),
    (0.0, 0.0), (1.0, 0.0), (1.0, 1.0));

type
  TVB = record
    VAO,
    VBOVertex:GLint;                // Vertex-Koordinaten
    VBOTex: array[0..1] of GLint;   // Textur-Koordianten
  end;

(*
Die Textur-Puffer deklarieren, sehr einfach geht dies mit einer Array.
*)
//code+
var
  Textur: array [0..1] of TTexturBuffer;
  //code-

  VBQuad: TVB;
  RotMatrix, ScaleMatrix, ProdMatrix: TMatrix;
  Matrix_ID: GLint;

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
Textur-Puffer erzeugen und Shader vorbereiten.
Die Textur-Sampler muss man durchnummerieren.
*)
//code+
procedure TForm1.CreateScene;
begin
  Textur[0] := TTexturBuffer.Create;
  Textur[1] := TTexturBuffer.Create;

  Shader := TShader.Create([FileToStr('Vertexshader.glsl'), FileToStr('Fragmentshader.glsl')]);
  with Shader do begin
    UseProgram;
    Matrix_ID := UniformLocation('mat');
    glUniform1i(UniformLocation('Sampler[0]'), 0);  // Dem Sampler[0] 0 zuweisen.
    glUniform1i(UniformLocation('Sampler[1]'), 1);  // Dem Sampler[1] 0 zuweisen.
  end;
  //code-

  glGenVertexArrays(1, @VBQuad.VAO);
  glGenBuffers(1, @VBQuad.VBOVertex);
  glGenBuffers(2, @VBQuad.VBOTex);

  RotMatrix.Identity;
  ScaleMatrix.Identity;
  ScaleMatrix.Scale(0.7);
  ProdMatrix.Identity;
end;

(*
Mit diesr Klasse geht das laden einer Bitmap sehr einfach.
Man kann die Texturen auch von einem <b>TRawImages</b> laden.
*)
//code+
procedure TForm1.InitScene;
begin
  Textur[0].LoadTextures('mauer.xpm');
  Textur[1].LoadTextures('licht.xpm');
  //code-
  glClearColor(0.6, 0.6, 0.4, 1.0);

  glBindVertexArray(VBQuad.VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBOVertex);
  glBufferData(GL_ARRAY_BUFFER, sizeof(QuadVertex), @QuadVertex, GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 3, GL_FLOAT, False, 0, nil);

  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBOTex[0]);
  glBufferData(GL_ARRAY_BUFFER, sizeof(TextureVertex0), @TextureVertex0, GL_STATIC_DRAW);
  glEnableVertexAttribArray(10);
  glVertexAttribPointer(10, 2, GL_FLOAT, False, 0, nil);

  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBOTex[1]);
  glBufferData(GL_ARRAY_BUFFER, sizeof(TextureVertex1), @TextureVertex1, GL_STATIC_DRAW);
  glEnableVertexAttribArray(11);
  glVertexAttribPointer(11, 2, GL_FLOAT, False, 0, nil);
end;

(*
Da man bei Multitexturing mehrere Sampler braucht, muss man mitteilen, welche Textur zu welchen Sampler gehört.
Dies macht man mit <b>glActiveTexture(...</b>, Dazu muss man als Parameter die <b>Sampler-Nr + GL_TEXTURE0</b> mitgeben.

Das sieht man auch gut in der TTexturBuffer Class.
//code+
procedure TTexturBuffer.ActiveAndBind(Nr: integer);
begin
  glActiveTexture(GL_TEXTURE0 + Nr);
  glBindTexture(GL_TEXTURE_2D, FID);  // FID ist Textur-ID.
end;
//code-

*)
//code+
procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT);

  Textur[0].ActiveAndBind(0); // Textur 0 mit Sampler 0 binden.
  Textur[1].ActiveAndBind(1); // Textur 1 mit Sampler 1 binden.
  //code-

  Shader.UseProgram;

  ProdMatrix.Multiply(ScaleMatrix, RotMatrix);
  ProdMatrix.Uniform(Matrix_ID);

  // Zeichne Quadrat
  glBindVertexArray(VBQuad.VAO);
  glDrawArrays(GL_TRIANGLES, 0, Length(QuadVertex));

  ogc.SwapBuffers;
end;

(*
Die beiden Texturen am Ende wieder frei geben.
*)
//code+
procedure TForm1.FormDestroy(Sender: TObject);
begin
  Textur[0].Free;  // Texturen frei geben.
  Textur[1].Free;
  //code-

  Timer1.Enabled := False;

  glDeleteVertexArrays(1, @VBQuad.VAO);
  glDeleteBuffers(1, @VBQuad.VBOVertex);
  glDeleteBuffers(2, @VBQuad.VBOTex);

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
*)
//includeglsl Vertexshader.glsl
//lineal

(*
<b>Fragment-Shader:</b>

Bei diesem einfachen Beispiel werden einfach die Pixel der Textur addiert und anschliessend duch 2 geteilt.
*)
//includeglsl Fragmentshader.glsl

//lineal
(*
<b>mauer.xpm:</b>
*)
//includecpp mauer.xpm

//lineal
(*
<b>licht.xpm:</b>
*)
//includecpp licht.xpm

end.
