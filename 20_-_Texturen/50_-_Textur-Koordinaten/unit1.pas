unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, Menus,
  oglglad_gl,
  oglContext, oglShader, oglVector, oglMatrix, oglTextur;

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

    procedure CalcCircle;
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

//image image.png

(*
Dieses Beispiel zeigt, wie sich Textur-Koordinaten auf die Textur auswirken.
Bei der linken Textur, entsprechen die Textur-Koordinaten, denen der Vektoren, dies gibt ein Matrix ähnliches Muster, ausser das sie skaliert wird.
Rechts ist jede Koordinate von 0.0-1.0, somit wird die Textur um die Scheibe gezogen. Jedes Rechteck enthält die ganze Textur.
*)
//lineal

type
  TVB = record
    VAO,
    VBOVertex,        // Vertex-Koordinaten
    VBOTex: GLuint;   // Textur-Koordianten
  end;

  TDiscVector = record
    Vertex: TVector3f;
    TexkoorL, TexkoorR: TVector2f;
  end;

var
  Disc: array of TDiscVector;

  VBRingL, VBRingR: TVB;
  RotMatrix, ScaleMatrix, ProdMatrix: TMatrix;
  Matrix_ID: GLint;

  TextureBuffer: TTexturBuffer;

(*
Hier sieht man gut, das die Textur-Koordinaten verschieden Werte bekommen.
*)
//code+
procedure TForm1.CalcCircle;
const
  TextureVertex: array[0..5] of TVector2f =    // Textur-Koordinaten
    ((0.0, 0.0), (1.0, 1.0), (0.0, 1.0),
    (0.0, 0.0), (1.0, 0.0), (1.0, 1.0));

  Sektoren = 16;
  r0 = 0.5;
  r1 = 1.0;
var
  i: integer;
  w0, w1: single;

begin
  SetLength(Disc, Sektoren * 3 * 2);

  for i := 0 to Sektoren - 1 do begin
    w0 := pi * 2 / Sektoren * (i + 0);
    w1 := pi * 2 / Sektoren * (i + 1);

    // 1. Dreieck

    Disc[i * 2 * 3 + 0].Vertex := vec3(sin(w0) * r0, cos(w0) * r0, 0.0);
    Disc[i * 2 * 3 + 1].Vertex := vec3(sin(w0) * r1, cos(w0) * r1, 0.0);
    Disc[i * 2 * 3 + 2].Vertex := vec3(sin(w1) * r1, cos(w1) * r1, 0.0);

    Disc[i * 2 * 3 + 0].TexkoorL := Disc[i * 2 * 3 + 0].Vertex.xy;
    Disc[i * 2 * 3 + 0].TexkoorL.scale(5.0);
    Disc[i * 2 * 3 + 1].TexkoorL := Disc[i * 2 * 3 + 1].Vertex.xy;
    Disc[i * 2 * 3 + 1].TexkoorL.scale(5.0);
    Disc[i * 2 * 3 + 2].TexkoorL := Disc[i * 2 * 3 + 2].Vertex.xy;
    Disc[i * 2 * 3 + 2].TexkoorL.scale(5.0);

    Disc[i * 2 * 3 + 0].TexkoorR := TextureVertex[3];
    Disc[i * 2 * 3 + 1].TexkoorR := TextureVertex[4];
    Disc[i * 2 * 3 + 2].TexkoorR := TextureVertex[5];

    // 2. Dreieck

    Disc[i * 2 * 3 + 3].Vertex := vec3(sin(w0) * r0, cos(w0) * r0, 0.0);
    Disc[i * 2 * 3 + 4].Vertex := vec3(sin(w1) * r1, cos(w1) * r1, 0.0);
    Disc[i * 2 * 3 + 5].Vertex := vec3(sin(w1) * r0, cos(w1) * r0, 0.0);

    Disc[i * 2 * 3 + 3].TexkoorL := Disc[i * 2 * 3 + 3].Vertex.xy;
    Disc[i * 2 * 3 + 3].TexkoorL.scale(5.0);
    Disc[i * 2 * 3 + 4].TexkoorL := Disc[i * 2 * 3 + 4].Vertex.xy;
    Disc[i * 2 * 3 + 4].TexkoorL.scale(5.0);
    Disc[i * 2 * 3 + 5].TexkoorL := Disc[i * 2 * 3 + 5].Vertex.xy;
    Disc[i * 2 * 3 + 5].TexkoorL.scale(5.0);

    Disc[i * 2 * 3 + 3].TexkoorR := TextureVertex[0];
    Disc[i * 2 * 3 + 4].TexkoorR := TextureVertex[1];
    Disc[i * 2 * 3 + 5].TexkoorR := TextureVertex[2];
  end;
end;
//code-

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
  CalcCircle;

  glGenVertexArrays(1, @VBRingL.VAO);
  glGenBuffers(1, @VBRingL.VBOVertex);
  glGenBuffers(1, @VBRingL.VBOTex);

  glGenVertexArrays(1, @VBRingR.VAO);
  glGenBuffers(1, @VBRingR.VBOVertex);
  glGenBuffers(1, @VBRingR.VBOTex);

  TextureBuffer := TTexturBuffer.Create;
  TextureBuffer.LoadTextures('muster.xpm');

  Shader := TShader.Create([FileToStr('Vertexshader.glsl'), FileToStr('Fragmentshader.glsl')]);
  with Shader do begin
    UseProgram;
    Matrix_ID := UniformLocation('mat');
    glUniform1i(UniformLocation('Sampler'), 0);  // Dem Sampler 0 zuweisen.
  end;

  RotMatrix.Identity;
  ScaleMatrix.Identity;
  ScaleMatrix.Scale(0.45);
  ProdMatrix.Identity;
end;

(*
Vertex-Koordianten bekommen beide Meshes die gleichen, aber die Textur-Koordinaten weichen ab.
*)
//code+
procedure TForm1.InitScene;
begin
  TextureBuffer.ActiveAndBind;
  glClearColor(0.6, 0.6, 0.4, 1.0);

  // Ring Links
  glBindVertexArray(VBRingL.VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBRingL.VBOVertex);
  glBufferData(GL_ARRAY_BUFFER, Length(Disc) * SizeOf(TDiscVector), Pointer(Disc), GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 28, Pointer(0));

  glBindBuffer(GL_ARRAY_BUFFER, VBRingL.VBOTex);
  glBufferData(GL_ARRAY_BUFFER, Length(Disc) * SizeOf(TDiscVector), Pointer(Disc), GL_STATIC_DRAW);
  glEnableVertexAttribArray(10);
  glVertexAttribPointer(10, 2, GL_FLOAT, GL_FALSE, 28, Pointer(12));

  // Ring Rechts
  glBindVertexArray(VBRingR.VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBRingR.VBOVertex);
  glBufferData(GL_ARRAY_BUFFER, Length(Disc) * SizeOf(TDiscVector), Pointer(Disc), GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 28, Pointer(0));

  glBindBuffer(GL_ARRAY_BUFFER, VBRingR.VBOTex);
  glBufferData(GL_ARRAY_BUFFER, Length(Disc) * SizeOf(TDiscVector), Pointer(Disc), GL_STATIC_DRAW);
  glEnableVertexAttribArray(10);
  glVertexAttribPointer(10, 2, GL_FLOAT, GL_FALSE, 28, Pointer(20));
end;
//code-

//code+
procedure TForm1.ogcDrawScene(Sender: TObject);
var
  TempMatrix: TMatrix;
begin
  glClear(GL_COLOR_BUFFER_BIT);

  TextureBuffer.ActiveAndBind;

  Shader.UseProgram;

  ProdMatrix := ScaleMatrix * RotMatrix;

  // Zeichne linke Scheibe
  TempMatrix := ProdMatrix;
  ProdMatrix.Translate(-0.5, 0.0, 0.0);
  ProdMatrix.Uniform(Matrix_ID);
  ProdMatrix := TempMatrix;

  glBindVertexArray(VBRingL.VAO);
  glDrawArrays(GL_TRIANGLES, 0, Length(Disc) * 3); // Zeichnet die linke Scheibe

  // Zeichne rechte Scheibe
  ProdMatrix.Translate(0.5, 0.0, 0.0);
  ProdMatrix.Uniform(Matrix_ID);

  glBindVertexArray(VBRingR.VAO);
  glDrawArrays(GL_TRIANGLES, 0, Length(Disc) * 3); // Zeichnet die rechte Scheibe

  ogc.SwapBuffers;
end;
//code-

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Timer1.Enabled := False;

  TextureBuffer.Free;

  glDeleteVertexArrays(1, @VBRingL.VAO);
  glDeleteBuffers(1, @VBRingL.VBOVertex);
  glDeleteBuffers(1, @VBRingL.VBOTex);

  glDeleteVertexArrays(1, @VBRingR.VAO);
  glDeleteBuffers(1, @VBRingR.VBOVertex);
  glDeleteBuffers(1, @VBRingR.VBOTex);

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
*)
//includeglsl Fragmentshader.glsl

//lineal
(*
<b>muster.xpm:</b>
*)
//includecpp muster.xpm



end.
