unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls,
  dglOpenGL,
  oglContext, oglShader, oglVector, oglMatrix;

//image image.png
(*
Ohne Beleuchtung sehen die Object statisch aus, wen man noch Beleuchtung ins Spiel bringt, wirkt eine OpenGL-Scene viel realistischer.
Dabei gibt es verschiedene Arten von Beleuchtung. Die meist verwendete ist das <b>Directional Light</b>, dies entspricht dem Sonnenlicht.
Dieses Beispiel zeigt eine ganz einfache Variante von diesem Licht. Je steiler das Licht auf ein Polygon einstrahlt, je heller wird das Polygon.

Das man dies berechnen kann, braucht es für jede Ecke des Polygons einen Normale-Vektor.
Eine Normale zeigt meistens senkrecht auf ein Polygon.
Es gibt Ausnahmen, zB. bei runden Flächen. Dazu in einem späteren Beispiel.

Die <b>Normalen</b> werden mit der <b>ModelMatrix</b> multipliziert, da diese unbeinflusst von Perspektive/Frustum ist.
Die Position der <b>Polygone</b> wird mit <b>Matrix</b> modifiziert, da ist eine perspektifische Darstellung erwünscht.
Wen man dies nicht macht, hat man eine falsche Abdunklung auf den schrägen Dreiecken. Die macht sich besonders start bemerkbar bei <b>Punkt</b> und <b>Spot</b>-Licht.

Hier wird die einfachste Variante einer Beleuchtung gezeigt.
Dazu wird das Skalarprodukt zwischen der Normalen und der Lichtposition berechnet.
Dabei werden die Polygone dunkler, je grösser der Winkel. 0°=weiss; 180°=schwarz.
Diese Beleuchtung ist eigentlich nicht üblich, aber immerhin sieht man die Mehses viel besser.
Aber es zeigt wenigsten, wie das Grundgerüst einer Beleuchtung aussieht.

Die gebräuchlichsten Lichvarianten von OpenGL:
* <b>Ambient-Light</b> - Einfache Raumausleuchtung, alles ist gleich Hell.
* <b>Directional-Light</b> - Das Licht kommt alles aus gleicher Richtung, so wie das Sonnenlicht auf Erde.
* <b>Point-Light</b> - Das Licht wird von einem Punkt ausgestrahlt, so wie bei einer Glühbirne.
* <b>Spot-Light</b> - Das Lich hat einen Kegel, so wie wen es aus einer Taschenlampe kommt.

Was zu beachten das die Beleuchtungs-Effekte <b>keine Schatten</b> berücksichtigen.
Schatten muss man auf eine ganz andere weise berechnen.

Es ist auch möglich mehrere Lichtquellen zu berechnen, dazu werden alle Lichtquellen addiert.
Das sieht man gut bei den mehrfarbigen Beleuchtungbeispielen. Da sieht man auch, das das Licht farbig sein kann.

Dazu später.
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
Diese zeigt dann senkrecht auf das Dreieck.
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
  ModelMatrix,
  Matrix: TMatrix;

  ModelMatrix_ID,
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
Diese Funktion sollte  man <b>nur</b> verwenden, wen die <b>Normale</b> senkrecht auf dem Dreieck steht.
Bei runden Objekten ist dies nicht der Fall.
*)
//code+
procedure TForm1.CreateScene;
begin
  FaceToNormale(CubeVertex, CubeNormal);
//code-

  Matrix.Identity;

  WorldMatrix.Identity;
  WorldMatrix.Translate(0, 0, -200.0);
  WorldMatrix.Scale(5.0);

  ModelMatrix.Identity;

  glEnable(GL_DEPTH_TEST);
  glDepthFunc(GL_LESS);

  Shader := TShader.Create([FileToStr('Vertexshader.glsl'), FileToStr('Fragmentshader.glsl')]);
  with Shader do begin
    UseProgram;
    Matrix_ID := UniformLocation('Matrix');
    ModelMatrix_ID := UniformLocation('ModelMatrix');
  end;

  glGenVertexArrays(1, @VBCube.VAO);

  glGenBuffers(1, @VBCube.VBOvert);
  glGenBuffers(1, @VBCube.VBONormal);

  Timer1.Enabled := True;
end;

(*
Die Normale wird auf gleiche weise in den VRAM geladen, wie die Vertex-Koordinaten.
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

(*
Hier sieht man gut, das 2 Matrizen dem Shader übergeben werden.
Bevor die Matrix mit Frustum und Worldposition beinflusst wird, wird sie das erste mal dem Shader übergeben.
Diese Matrix beinhaltet nur die lokalen Transformationen der Meshes.
Für die Position der Vektoren, wird eine komplett berechnete Matrix dem Shader übergeben.
Die Multiplikationen hätte man auch im Shader ausführen können, aber dies verbraucht nur unnötige <b>GPU</b>-Leistung.
Wen man es mit der <b>CPU</b> macht, wird die Berechnung nur einmal pro Meshes gemacht und nicht bei jedem Vektor.
Das wird in <b>allen</b> Beleuchtungsbeispielen so gemacht, egal ob Punkt, Directinal, etc. Beleuchtung.
Ausser bei Ambient, da es dort <b>keine</b> Normalen gibt.

In diesem Beispiel wird die pro Würfel gemacht. Da der Würfel mehrmals verwendet wird, gibt es pro Würfel eine Berechnung.
*)

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

//code+                                                        // Schleifen für die Würfel.
  for x := -s to s do begin
    for y := -s to s do begin
      for z := -s to s do begin
        Matrix.Identity;
        Matrix.Translate(x * d, y * d, z * d);                 // Lokale Translationen.
        Matrix := ModelMatrix * Matrix;

        Matrix.Uniform(ModelMatrix_ID);                        // Erste Übergabe an den Shader.

        Matrix := FrustumMatrix * WorldMatrix *  Matrix;       // Matrixen multiplizieren.

        Matrix.Uniform(Matrix_ID);                             // Die komplettt berechnete Matrix übergeben.
        glDrawArrays(GL_TRIANGLES, 0, Length(CubeVertex) * 3); // Zeichnet einen einzelnen Würfel.
      end;
    end;
  end;
//code-

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

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  ModelMatrix.RotateA(0.0123);  // Drehe um X-Achse
  ModelMatrix.RotateB(0.0234);  // Drehe um Y-Achse

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
Hier sieht man, das verschiedene Matrizen für <b>Normale</b> und <b>Vertex</b> verwendet werden.
*)
//includeglsl Vertexshader.glsl
//lineal

(*
<b>Fragment-Shader</b>
*)
//includeglsl Fragmentshader.glsl

end.
