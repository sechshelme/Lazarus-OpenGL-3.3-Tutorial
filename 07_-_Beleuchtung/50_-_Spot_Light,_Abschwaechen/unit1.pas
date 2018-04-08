unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, ComCtrls, StdCtrls, Menus,
  dglOpenGL,
  oglContext, oglShader, oglVertex, oglMatrix;

//image image.png
(*
Wen das Licht schwächer wird, je weiter es von der Mesh entfernt wird, sieht es viel realistischer aus.
Auch wird ein Lichtstrahl schwächer je weit er vom Zentrum weg ist.

Die beiden linken Lichter wird nur eine Abschwächung angewendet. Das rechte Licht ist eine Kombination aus beiden Abschwächungen und somit die realistischte.

Dies Distanzabhängige Abschwächung, kann man auch bei einer Punkt-Beleuchtung anwenden.
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

  LightPos: record
    Red, Green, Blue: TVector3f;
  end;

type
  TVB = record
    VAO,
    VBOvert,            // VBO für Vektor.
    VBONormal: GLuint;  // VBO für Normale.
  end;

var
  VBCube: TVB;
  FrustumMatrix,
  WorldMatrix,
  ModelMatrix,
  Matrix: TMatrix;

  ModelMatrix_ID,
  Matrix_ID: GLint;

  LightPos_ID: record
    Red, Green, Blue: GLint;
  end;


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

(*
Hier werden die Lichtpositionen der drei Lampen festgelegt.
*)
//code+
procedure TForm1.CreateScene;
const
  LichtPositionRadius = 25.0;
begin
  with LightPos do begin
    Red := vec3(-1.2, 0.0, 4.0);
    Red.Scale(LichtPositionRadius);

    Green := vec3(0.0, 0.0, 4.0);
    Green.Scale(LichtPositionRadius);

    Blue := vec3(1.2, 0.0, 4.0);
    Blue.Scale(LichtPositionRadius);
  end;
//code-

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
    with LightPos_ID do begin
      Red := UniformLocation('LeftLightPos');
      Green := UniformLocation('CenterLightPos');
      Blue := UniformLocation('RightLightPos');
    end;
  end;

  glGenVertexArrays(1, @VBCube.VAO);

  glGenBuffers(1, @VBCube.VBOvert);
  glGenBuffers(1, @VBCube.VBONormal);

  Timer1.Enabled := True;
end;

procedure TForm1.InitScene;
begin
  glClearColor(0.1, 0.1, 0.05, 1.0); // Hintergrundfarbe

  // --- Daten für Würfel
  glBindVertexArray(VBCube.VAO);

  // Vektor
  glBindBuffer(GL_ARRAY_BUFFER, VBCube.VBOvert);
  glBufferData(GL_ARRAY_BUFFER, Length(CubeVertex) * SizeOf(Tmat3x3), @CubeVertex, GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 3, GL_FLOAT, False, 0, nil);

  // Normale
  glBindBuffer(GL_ARRAY_BUFFER, VBCube.VBONormal);
  glBufferData(GL_ARRAY_BUFFER, Length(CubeNormal) * SizeOf(Tmat3x3), @CubeNormal, GL_STATIC_DRAW);
  glEnableVertexAttribArray(1);
  glVertexAttribPointer(1, 3, GL_FLOAT, False, 0, nil);

end;

procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);  // Frame und Tiefen-Buffer löschen.

  glEnable(GL_CULL_FACE);
  glCullface(GL_BACK);

  Shader.UseProgram;

  with LightPos_ID do begin
    glUniform3fv(Red, 1, @LightPos.Red);
    glUniform3fv(Green, 1, @LightPos.Green);
    glUniform3fv(Blue, 1, @LightPos.Blue);
  end;

  glBindVertexArray(VBCube.VAO);

  // --- Zeichne Würfel

  Matrix.Identity;
  Matrix.Scale(100, 50, 10.0);
  Matrix.Translate(0.0, -20.0, 0.0);
  Matrix.Multiply(ModelMatrix, Matrix);

  Matrix.Uniform(ModelMatrix_ID);

  Matrix.Multiply(WorldMatrix, Matrix);                  // Matrixen multiplizieren.
  Matrix.Multiply(FrustumMatrix, Matrix);

  Matrix.Uniform(Matrix_ID);                             // Matrix dem Shader übergeben.
  glDrawArrays(GL_TRIANGLES, 0, Length(CubeVertex) * 3); // Zeichnet einen kleinen Würfel.

  // --- Zeichne Würfel

  Matrix.Identity;
  Matrix.Scale(95, 50, 10.0);
  Matrix.Translate(0.0, 20.0, -10.0);
  Matrix.Multiply(ModelMatrix, Matrix);

  Matrix.Uniform(ModelMatrix_ID);

  Matrix.Multiply(WorldMatrix, Matrix);                  // Matrixen multiplizieren.
  Matrix.Multiply(FrustumMatrix, Matrix);

  Matrix.Uniform(Matrix_ID);                             // Matrix dem Shader übergeben.
  glDrawArrays(GL_TRIANGLES, 0, Length(CubeVertex) * 3); // Zeichnet einen kleinen Würfel.

  ogc.SwapBuffers;
end;

procedure TForm1.ogcResize(Sender: TObject);
begin
  FrustumMatrix.Perspective(45, ClientWidth / ClientHeight, 2.5, 1000.0);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Shader.Free;

  glDeleteVertexArrays(1, @VBCube.VAO);
  glDeleteBuffers(1, @VBCube.VBOvert);
  glDeleteBuffers(1, @VBCube.VBONormal);
end;

(*
Hier werden die 3 Lichter in der Z-Achse bewegt.
*)
//code+
procedure TForm1.Timer1Timer(Sender: TObject);
const
  Step: single = 0.5;
  min = 40.0;
  max = 80.0;

  ZPos: single = (max + min) / 2;
begin
  ModelMatrix.Identity;
  ModelMatrix.Translate(0.0, 0.0, 30);
  ModelMatrix.RotateA(0.25);

  ZPos += Step;
  if (ZPos > max) or (ZPos < min) then begin
    Step *= -1;
  end;
  LightPos.Red.z := ZPos;

  ZPos += Step;
  if (ZPos > max) or (ZPos < min) then begin
    Step *= -1;
  end;
  LightPos.Green.z := ZPos;

  ZPos += Step;
  if (ZPos > max) or (ZPos < min) then begin
    Step *= -1;
  end;
  LightPos.Blue.z := ZPos;

  ogc.Invalidate;
end;
//code-

(*
Berechnen der 3 Lichtkegel.

<b>Vertex-Shader:</b>
*)
//includeglsl Vertexshader.glsl
//lineal

(*
<b>Fragment-Shader</b>
*)
//includeglsl Fragmentshader.glsl

end.
