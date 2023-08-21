unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, ComCtrls, StdCtrls, Menus,
  dglOpenGL,
  oglContext, oglShader, oglVector, oglMatrix;

  //image image.png
(*
Mit <b>Instancing</b> hat man die Möglichkeit die Mesh mit <b>einem<b> glDraw... Aufruf mehrmals zu zeichnen.
Bei dieser regelmässigen Anordnung ist dies sehr einfach.
Man hat aber auch bei <b>Instancing</b> die Möglichkeit die Meshes X-beliebig anzuordnen.
Dies wird in den nächsten Themen behandelt.
*)
  //lineal

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
    procedure ogcResize(Sender: TObject);
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

type
  TCube = array[0..11] of Tmat3x3;

const
  CubeVertex: TCube =
    (((-0.5, 0.5, 0.5), (-0.5, -0.5, 0.5), (0.5, -0.5, 0.5)), ((-0.5, 0.5, 0.5), (0.5, -0.5, 0.5), (0.5, 0.5, 0.5)),
    ((0.5, 0.5, 0.5), (0.5, -0.5, 0.5), (0.5, -0.5, -0.5)), ((0.5, 0.5, 0.5), (0.5, -0.5, -0.5), (0.5, 0.5, -0.5)),
    ((0.5, 0.5, -0.5), (0.5, -0.5, -0.5), (-0.5, -0.5, -0.5)), ((0.5, 0.5, -0.5), (-0.5, -0.5, -0.5), (-0.5, 0.5, -0.5)),
    ((-0.5, 0.5, -0.5), (-0.5, -0.5, -0.5), (-0.5, -0.5, 0.5)), ((-0.5, 0.5, -0.5), (-0.5, -0.5, 0.5), (-0.5, 0.5, 0.5)),
    // oben
    ((0.5, 0.5, 0.5), (0.5, 0.5, -0.5), (-0.5, 0.5, -0.5)), ((0.5, 0.5, 0.5), (-0.5, 0.5, -0.5), (-0.5, 0.5, 0.5)),
    // unten
    ((-0.5, -0.5, 0.5), (-0.5, -0.5, -0.5), (0.5, -0.5, -0.5)), ((-0.5, -0.5, 0.5), (0.5, -0.5, -0.5), (0.5, -0.5, 0.5)));

var
  CubeNormal: TCube;

type
  TVB = record
    VAO: GLuint;
    VBO: record
      Vertex,
      Normal: GLuint;
      end;
  end;

var
  VBCube: TVB;
  FrustumMatrix,
  WorldMatrix,
  ModelMatrix,
  Matrix: TMatrix;

  ModelMatrix_ID, Matrix_ID, size_ID: GLint;

  { TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  //remove+
  Width := 340;
  Height := 240;
  //remove-
  ogc := TContext.Create(Self);
  ogc.OnPaint := @ogcDrawScene;
  ogc.OnResize := @ogcResize;

  CreateScene;
  InitScene;
end;

procedure TForm1.CreateScene;
begin
  FaceToNormale(CubeVertex, CubeNormal);

  Matrix.Identity;

  WorldMatrix.Identity;
  WorldMatrix.Translate(0, 0, -300.0);
  WorldMatrix.Scale(2.5);

  ModelMatrix.Identity;

  glEnable(GL_DEPTH_TEST);
  glDepthFunc(GL_LESS);

  Shader := TShader.Create([FileToStr('Vertexshader.glsl'), FileToStr('Fragmentshader.glsl')]);
  with Shader do begin
    UseProgram;
    Matrix_ID := UniformLocation('Matrix');
    ModelMatrix_ID := UniformLocation('ModelMatrix');
    size_ID := UniformLocation('size');
  end;

  glGenVertexArrays(1, @VBCube.VAO);

  glGenBuffers(2, @VBCube.VBO);

  Timer1.Enabled := True;
end;

procedure TForm1.InitScene;
begin
  glClearColor(0.15, 0.15, 0.1, 1.0); // Hintergrundfarbe

  // --- Daten für Würfel
  glBindVertexArray(VBCube.VAO);

  // Vektor
  glBindBuffer(GL_ARRAY_BUFFER, VBCube.VBO.Vertex);
  glBufferData(GL_ARRAY_BUFFER, Length(CubeVertex) * SizeOf(Tmat3x3), @CubeVertex, GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 3, GL_FLOAT, False, 0, nil);

  // Normale
  glBindBuffer(GL_ARRAY_BUFFER, VBCube.VBO.Normal);
  glBufferData(GL_ARRAY_BUFFER, Length(CubeNormal) * SizeOf(Tmat3x3), @CubeNormal, GL_STATIC_DRAW);
  glEnableVertexAttribArray(1);
  glVertexAttribPointer(1, 3, GL_FLOAT, False, 0, nil);
end;

(*
Das Zeichnen ist sehr einfach und übersichtlich geworden.
Es braucht <b>keine</b> for-to-Schleifen für die Cube-Array, dieser Teile erledigt alles der Vertex-Shader.
Die Matrix muss nur <b>einmal</b> berechnet werden, da es nur <b>einen</b> Aufruf von <b>glDraw...</b> gibt.
*)
//code+
procedure TForm1.ogcDrawScene(Sender: TObject);
const
  s = 9;            // Eine Seite hat 9 Würfel.
begin
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);

  glEnable(GL_CULL_FACE);
  glCullface(GL_BACK);

  Shader.UseProgram;

  glBindVertexArray(VBCube.VAO);

  // Die Matrizen werden nur einmal berechnet.
  Matrix.Identity;
  Matrix.Scale(6.0);
  Matrix := ModelMatrix * Matrix;
  Matrix.Uniform(ModelMatrix_ID);
  Matrix := FrustumMatrix * WorldMatrix * Matrix;
  Matrix.Uniform(Matrix_ID);

  glUniform1i(size_ID, s);

  // glDraw... muss nur einmal aufgerufen werden.
  glDrawArraysInstanced(GL_TRIANGLES, 0, Length(CubeVertex) * 3, s * s * s);

  ogc.SwapBuffers;
end;

//code-

procedure TForm1.ogcResize(Sender: TObject);
begin
  FrustumMatrix.Perspective(45, ClientWidth / ClientHeight, 2.5, 1000.0);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Shader.Free;

  glDeleteVertexArrays(1, @VBCube.VAO);
  glDeleteBuffers(2, @VBCube.VBO);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  ModelMatrix.RotateA(0.0123);
  ModelMatrix.RotateB(0.0134);

  ogc.Invalidate;
end;

(*
Das grosse Arbeit bei Instancing leistet der Vertex-Shader.

<b>Vertex-Shader:</b>
*)
//includeglsl Vertexshader.glsl
//lineal

(*
<b>Fragment-Shader</b>
*)
//includeglsl Fragmentshader.glsl

end.
