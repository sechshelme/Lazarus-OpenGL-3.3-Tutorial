unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls,
  dglOpenGL,
  oglContext, oglShader, oglMatrix;

//image image.png
(*
Ohne Beleuchtung sehen die Object statisch aus, wen man noch Beleuchtung ins Spiel bringt, wirkt eine OpenGL-Scene viel realistischer.
Dabei gibt es verschiedene Arten von Beleuchtung. Das meist verwendete ist <b>Directional Light</b>, dies entspricht dem Sonnenlicht.
Dieses Beispiel zeigt eine ganz einfache Variante von diesem Licht. Je steiler das Licht auf ein Polygon einstrahlt, je heller wird das Polygon.

Das man dies berechnen kann, braucht es für jede Ecke des Polygons eie Normale-Vektor.
Eine Normale zeigt meistens senkrecht auf ein Polygon.

Es gibt Ausnahmen, zB. bei runden Flächen. Dazu in einem späteren Beispiel.
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
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

type
  TCube = array[0..11] of Tmat3x3;

(*
Die Konstanten der Würfel-Vektoren.
*)
//code+
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
//code-

(*
Für die Normale wird nur eine Variable für Vektoren deklariert, da diese aus den Vektoren des Würfels berechnet werden.
*)
//code+
var
  CubeNormal: TCube;
//code-

(*
Für die Normale braucht es noch eine VBO.
*)
//code+
type
  TVB = record
    VAO,
    VBOvert,            // VBO für Vektor.
    VBONormal: GLuint;  // VBO für Normale.
  end;
//code-

var
  VBCube: TVB;
  FrustumMatrix,
  WorldMatrix,
  Matrix: TMatrix;
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
  ogc.OnResize := @ogcResize;   // neues Ereigniss

  CreateScene;
  InitScene;
end;

(*
In der Unit Matrix hat es eine fertige Funktion, welche die Normale aus den Vertex-Koordinaten berechnet.
*)
//code+
procedure TForm1.CreateScene;
begin
  FaceToNormale(CubeVertex, CubeNormal);
//code-

  Matrix := TMatrix.Create;
  FrustumMatrix := TMatrix.Create;

  WorldMatrix := TMatrix.Create;
  WorldMatrix.Translate(0, 0, -200.0);
  WorldMatrix.Scale(5.0);

  glEnable(GL_DEPTH_TEST);
  glDepthFunc(GL_LESS);

  Shader := TShader.Create([FileToStr('Vertexshader.glsl'), FileToStr('Fragmentshader.glsl')]);
  with Shader do begin
    UseProgram;
    Matrix_ID := UniformLocation('Matrix');
  end;

  glGenVertexArrays(1, @VBCube.VAO);

  glGenBuffers(1, @VBCube.VBOvert);
  glGenBuffers(1, @VBCube.VBONormal);

  Timer1.Enabled := True;
end;

(*
Die Normale wird genau gleich in den VRAM geladen, wie die Vertex-Koordinaten.
*)
//code+
procedure TForm1.InitScene;
begin
  glClearColor(0.6, 0.6, 0.4, 1.0); // Hintergrundfarbe

  // --- Daten für Würfel
  glBindVertexArray(VBCube.VAO);

  // Vektor
  glBindBuffer(GL_ARRAY_BUFFER, VBCube.VBOvert);
  glBufferData(GL_ARRAY_BUFFER, sizeof(CubeVertex), @CubeVertex, GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 3, GL_FLOAT, False, 0, nil);

  // Normale
  glBindBuffer(GL_ARRAY_BUFFER, VBCube.VBONormal);
  glBufferData(GL_ARRAY_BUFFER, sizeof(CubeNormal), @CubeNormal, GL_STATIC_DRAW);
  glEnableVertexAttribArray(1);
  glVertexAttribPointer(1, 3, GL_FLOAT, False, 0, nil);

end;
//code-

procedure TForm1.ogcDrawScene(Sender: TObject);
var
  x, y, z: integer;
const
  d = 1.8;
  s = 4;
begin
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);  // Frame und Tiefen-Buffer löschen.

  glEnable(GL_CULL_FACE);
  glCullface(GL_BACK);

  Shader.UseProgram;

  glBindVertexArray(VBCube.VAO);

  // --- Zeichne Würfel

  for x := -s to s do begin
    for y := -s to s do begin
      for z := -s to s do begin
        Matrix.Identity;
        Matrix.Translate(x * d, y * d, z * d);                 // Matrix verschieben.

        Matrix.Multiply(WorldMatrix, Matrix);                  // Matrixen multiplizieren.
        Matrix.Multiply(FrustumMatrix, Matrix);

        Matrix.Uniform(Matrix_ID);                             // Matrix dem Shader übergeben.
        glDrawArrays(GL_TRIANGLES, 0, Length(CubeVertex) * 3); // Zeichnet einen kleinen Würfel.
      end;
    end;
  end;

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

  Matrix.Free;
  FrustumMatrix.Free;
  WorldMatrix.Free;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  WorldMatrix.RotateA(0.0123);  // Drehe um X-Achse
  WorldMatrix.RotateB(0.0234);  // Drehe um Y-Achse

  ogc.Invalidate;
end;

//lineal

(*
Einfachere Beleuchtungen macht man im Vertex-Shader.
Will man aber komplexer Beleuchtungen, nimmt man dazu den Fragment-Shader, das dieser Pixelgenau ist.
Dafür wird aber mehr Berechnugszeit benötigt.
*)
//lineal
(*
<b>Vertex-Shader:</b>

Die Berechnug für das Licht des einfachen Beispieles ist hier im Vetex-Shader.
*)
//includeglsl Vertexshader.glsl
//lineal

(*
<b>Fragment-Shader</b>
*)
//includeglsl Fragmentshader.glsl

end.
