unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, Menus,
  dglOpenGL,
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
    VAO: GLuint;
    VBO: record
      Vertex, Prev, Next: GLuint;
    end;
  end;

var
  Linies: array of TVector2f;
  Linies_Prev: array of TVector2f;
  Linies_Next: array of TVector2f;

  VBRingL: TVB;
  RotMatrix, ScaleMatrix, ProdMatrix: TMatrix;
  Matrix_ID: GLint;

  TextureBuffer: TTexturBuffer;

(*
Hier sieht man gut, das die Textur-Koordinaten verschieden Werte bekommen.
*)
//code+
procedure TForm1.CalcCircle;
const
  Sektoren = 7;
  maxSek = Sektoren * 8;
  r = 1.6 / maxSek;
var
  i: integer;
begin
  SetLength(Linies, maxSek);
  SetLength(Linies_Prev, maxSek);
  SetLength(Linies_Next, maxSek);
  for i := 0 to maxSek - 1 do begin
    Linies[i, 0] := sin(Pi * 2 / Sektoren * i) * r * i;
    Linies[i, 1] := cos(Pi * 2 / Sektoren * i) * r * i;
  end;

  Linies_Prev[0] := vec2(0.0, 0.0);
  for i := 1 to maxSek - 1 do begin
    Linies_Prev[i] := Linies[i - 1];
  end;

  Linies_Next[maxSek - 1] := vec2(0.0, 0.0);
  for i := 0 to maxSek - 1 - 1 do begin
    Linies_Next[i] := Linies[i + 1];
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
  glGenBuffers(3, @VBRingL.VBO);

  TextureBuffer := TTexturBuffer.Create;
  TextureBuffer.LoadTextures('muster.xpm');

  Shader := TShader.Create([
    GL_VERTEX_SHADER, FileToStr('Vertexshader.glsl'),
    GL_GEOMETRY_SHADER, FileToStr('Geometrieshader.glsl'),
    GL_FRAGMENT_SHADER, FileToStr('Fragmentshader.glsl')]);

  with Shader do begin
    UseProgram;
    Matrix_ID := UniformLocation('mat');
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

  glBindBuffer(GL_ARRAY_BUFFER, VBRingL.VBO.Vertex);
  glBufferData(GL_ARRAY_BUFFER, Length(Linies) * SizeOf(TVector2f), Pointer(Linies), GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 2, GL_FLOAT, False, 0, nil);

  glBindBuffer(GL_ARRAY_BUFFER, VBRingL.VBO.Prev);
  glBufferData(GL_ARRAY_BUFFER, Length(Linies) * SizeOf(TVector2f), Pointer(Linies_Prev), GL_STATIC_DRAW);
  glEnableVertexAttribArray(1);
  glVertexAttribPointer(1, 2, GL_FLOAT, False, 0, nil);

  glBindBuffer(GL_ARRAY_BUFFER, VBRingL.VBO.Next);
  glBufferData(GL_ARRAY_BUFFER, Length(Linies) * SizeOf(TVector2f), Pointer(Linies_Next), GL_STATIC_DRAW);
  glEnableVertexAttribArray(2);
  glVertexAttribPointer(2, 2, GL_FLOAT, False, 0, nil);
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
  //  ProdMatrix.Translate(-0.5, 0.0, 0.0);
  ProdMatrix.Uniform(Matrix_ID);
  ProdMatrix := TempMatrix;

  glBindVertexArray(VBRingL.VAO);
  glDrawArrays(GL_LINE_STRIP, 0, Length(Linies) div 2);

  ogc.SwapBuffers;
end;
//code-

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Timer1.Enabled := False;

  TextureBuffer.Free;

  glDeleteVertexArrays(1, @VBRingL.VAO);
  glDeleteBuffers(3, @VBRingL.VBO);

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
