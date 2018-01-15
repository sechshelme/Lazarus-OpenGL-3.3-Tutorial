unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, Menus,
  dglOpenGL,
  oglContext, oglShader, oglMatrix, oglTextur;

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
In der Praxis liegen die Texturen meisten als Bitmap, auf der Festplatte.
Hier wird gezeigt, wie man eine 24Bit BMP als Textur lädt.
*)
//lineal

var
  sphereVertex: array of Tmat3x3;
  Texkoor0, Texkoor1: array of Tmat3x2;


type
  TVB = record
    VAO,
    VBOVertex,        // Vertex-Koordinaten
    VBOTex: GLuint;   // Textur-Koordianten
  end;

var
  VBRing0, VBRing1: TVB;
  RotMatrix, ScaleMatrix, ProdMatrix: TMatrix;
  Matrix_ID: GLint;

  TextureBuffer: TTexturBuffer;

{ TForm1 }

procedure TForm1.CalcCircle;
const
  TextureVertex: array[0..5] of TVector2f =    // Textur-Koordinaten
    ((0.0, 0.0), (1.0, 1.0), (0.0, 1.0),
    (0.0, 0.0), (1.0, 0.0), (1.0, 1.0));
var
  p: integer;

  procedure Triangles(Vector0, Vector1, Vector2: TVector2f);
  begin
    SphereVertex[p, 0] := vec3(Vector0, 0.0);
    SphereVertex[p, 1] := vec3(Vector1, 0.0);
    SphereVertex[p, 2] := vec3(Vector2, 0.0);

    Texkoor0[p, 0] := Vector0;
    Texkoor0[p, 0].scale(5.0);
    Texkoor0[p, 1] := Vector1;
    Texkoor0[p, 1].scale(5.0);
    Texkoor0[p, 2] := Vector2;
    Texkoor0[p, 2].scale(5.0);
  end;

const
  Sektoren = 16;
  r0 = 0.7;
  r1 = 1.0;
var
  i: integer;
  w0, w1: single;

begin
  p := 0;
  SetLength(SphereVertex, Sektoren * 2);
  SetLength(Texkoor0, Sektoren * 2);
  SetLength(Texkoor1, Sektoren * 2);

  for i := 0 to Sektoren - 1 do begin
    w0 := pi * 2 / Sektoren * (i + 0);
    w1 := pi * 2 / Sektoren * (i + 1);

    Triangles(
      vec2(sin(w0) * r0, cos(w0) * r0),
      vec2(sin(w0) * r1, cos(w0) * r1),
      vec2(sin(w1) * r1, cos(w1) * r1));
    Texkoor1[i * 2, 0] := TextureVertex[3];
    Texkoor1[i * 2, 1] := TextureVertex[4];
    Texkoor1[i * 2, 2] := TextureVertex[5];
    Inc(p);

    Triangles(
      vec2(sin(w0) * r0, cos(w0) * r0),
      vec2(sin(w1) * r1, cos(w1) * r1),
      vec2(sin(w1) * r0, cos(w1) * r0));
    Texkoor1[i * 2 + 1, 0] := TextureVertex[0];
    Texkoor1[i * 2 + 1, 1] := TextureVertex[1];
    Texkoor1[i * 2 + 1, 2] := TextureVertex[2];
    Inc(p);
  end;
end;

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

  glGenVertexArrays(1, @VBRing0.VAO);
  glGenBuffers(1, @VBRing0.VBOVertex);
  glGenBuffers(1, @VBRing0.VBOTex);

  glGenVertexArrays(1, @VBRing1.VAO);
  glGenBuffers(1, @VBRing1.VBOVertex);
  glGenBuffers(1, @VBRing1.VBOTex);

  TextureBuffer := TTexturBuffer.Create;
  TextureBuffer.LoadTextures('kreis.xpm');

  Shader := TShader.Create([FileToStr('Vertexshader.glsl'), FileToStr('Fragmentshader.glsl')]);
  with Shader do begin
    UseProgram;
    Matrix_ID := UniformLocation('mat');
    glUniform1i(UniformLocation('Sampler'), 0);  // Dem Sampler 0 zuweisen.
  end;

  RotMatrix := TMatrix.Create;
  ScaleMatrix := TMatrix.Create;
  ScaleMatrix.Scale(0.45);
  ProdMatrix := TMatrix.Create;
end;

(*
*)
//code+
procedure TForm1.InitScene;
begin
  TextureBuffer.ActiveAndBind;
  //code-
  glClearColor(0.6, 0.6, 0.4, 1.0);

  // Ring 0
  glBindVertexArray(VBRing0.VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBRing0.VBOVertex);
  glBufferData(GL_ARRAY_BUFFER, Length(SphereVertex) * SizeOf(Tmat3x3), Pointer(SphereVertex), GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 3, GL_FLOAT, False, 0, nil);

  glBindBuffer(GL_ARRAY_BUFFER, VBRing0.VBOTex);
  glBufferData(GL_ARRAY_BUFFER, Length(Texkoor0) * SizeOf(Tmat3x2), Pointer(Texkoor0), GL_STATIC_DRAW);
  glEnableVertexAttribArray(10);
  glVertexAttribPointer(10, 2, GL_FLOAT, False, 0, nil);

  // Ring 1
  glBindVertexArray(VBRing1.VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBRing1.VBOVertex);
  glBufferData(GL_ARRAY_BUFFER, Length(SphereVertex) * SizeOf(Tmat3x3), Pointer(SphereVertex), GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 3, GL_FLOAT, False, 0, nil);

  glBindBuffer(GL_ARRAY_BUFFER, VBRing1.VBOTex);
  glBufferData(GL_ARRAY_BUFFER, Length(Texkoor1) * SizeOf(Tmat3x2), Pointer(Texkoor1), GL_STATIC_DRAW);
  glEnableVertexAttribArray(10);
  glVertexAttribPointer(10, 2, GL_FLOAT, False, 0, nil);
end;

procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT);

  TextureBuffer.ActiveAndBind;

  Shader.UseProgram;

  ProdMatrix.Multiply(ScaleMatrix, RotMatrix);

  // Zeichne Ring 0
  ProdMatrix.Push;
  ProdMatrix.Translate(-0.5, 0.0, 0.0);
  ProdMatrix.Uniform(Matrix_ID);
  ProdMatrix.Pop;

  glBindVertexArray(VBRing0.VAO);
  glDrawArrays(GL_TRIANGLES, 0, Length(SphereVertex) * 3); // Zeichnet einen kleinen Würfel.

  // Zeichne Ring 1
  ProdMatrix.Translate(0.5, 0.0, 0.0);
  ProdMatrix.Uniform(Matrix_ID);

  glBindVertexArray(VBRing1.VAO);
  glDrawArrays(GL_TRIANGLES, 0, Length(SphereVertex) * 3); // Zeichnet einen kleinen Würfel.

  ogc.SwapBuffers;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Timer1.Enabled := False;

  TextureBuffer.Free;

  glDeleteVertexArrays(1, @VBRing0.VAO);
  glDeleteBuffers(1, @VBRing0.VBOVertex);
  glDeleteBuffers(1, @VBRing0.VBOTex);

  glDeleteVertexArrays(1, @VBRing1.VAO);
  glDeleteBuffers(1, @VBRing1.VBOVertex);
  glDeleteBuffers(1, @VBRing1.VBOTex);

  ProdMatrix.Free;
  RotMatrix.Free;
  ScaleMatrix.Free;

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

end.
