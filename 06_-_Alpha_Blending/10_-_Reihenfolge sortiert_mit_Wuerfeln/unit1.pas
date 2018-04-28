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
Wen man mehrere Objekte mit Alpha-Blending hat, ist es wichtig, das man zuerst die Objekte zeichnet, die am weitesten weg sind.
Aus diesem Grund habe ich jeden Objekt eine eigene Matrix gegeben. Somit kann ich die Object anhand dieser Matrix sortieren, das sie später in richtiger Reihenfolge gezeichnet werden können.
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
  public
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
  CubeColor: TCube =
    (((1.0, 0.0, 0.0), (1.0, 0.0, 0.0), (1.0, 0.0, 0.0)), ((1.0, 0.0, 0.0), (1.0, 0.0, 0.0), (1.0, 0.0, 0.0)),
    ((0.0, 1.0, 0.0), (0.0, 1.0, 0.0), (0.0, 1.0, 0.0)), ((0.0, 1.0, 0.0), (0.0, 1.0, 0.0), (0.0, 1.0, 0.0)),
    ((0.0, 0.0, 1.0), (0.0, 0.0, 1.0), (0.0, 0.0, 1.0)), ((0.0, 0.0, 1.0), (0.0, 0.0, 1.0), (0.0, 0.0, 1.0)),
    ((0.0, 1.0, 1.0), (0.0, 1.0, 1.0), (0.0, 1.0, 1.0)), ((0.0, 1.0, 1.0), (0.0, 1.0, 1.0), (0.0, 1.0, 1.0)),
    // oben
    ((1.0, 1.0, 0.0), (1.0, 1.0, 0.0), (1.0, 1.0, 0.0)), ((1.0, 1.0, 0.0), (1.0, 1.0, 0.0), (1.0, 1.0, 0.0)),
    // unten
    ((1.0, 0.0, 1.0), (1.0, 0.0, 1.0), (1.0, 0.0, 1.0)), ((1.0, 0.0, 1.0), (1.0, 0.0, 1.0), (1.0, 0.0, 1.0)));

type
  TVB = record
    VAO,
    VBOvert,         // VBO für Vektor.
    VBOcol: GLuint;  // VBO für Farbe.
  end;

const
  CubeSize = 5;                                // Anzahl Würfel pro Seite
  CubeTotal = CubeSize * CubeSize * CubeSize;  // Würfel Total

  (*
  Für CubePos, verwende ich Pointer, somit müssen beim Sortieren nur die Pointer vertauscht werden.
  Ansonsten musste der ganze Record umkopiert werden. Auf einem 32Bit OS müssen so nur 4Byte kopiert werden, ansonsten sind es mehr als 64 Byte.
  *)
//code+
type
  TCubePos = record
    pos: TVector3f;
    mat: TMatrix;
  end;
  PCubePos = ^TCubePos; // Pointer für Cube

var
  CubePosArray: array[0..CubeTotal - 1] of PCubePos; // Alle Würfel
  //code-

  VBCube: TVB;
  FrustumMatrix,
  WorldMatrix: TMatrix;
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
end;

(*
Hier wird der Speicher für die Würfel angefordert.
*)
//code+
procedure TForm1.CreateScene;
const
  w = 1.0;
var
  i: integer;
begin
  for i := 0 to CubeTotal - 1 do begin
    New(CubePosArray[i]);  // Speicher anfordern.
  end;
  //code-

  FrustumMatrix.Frustum(-w, w, -w, w, 2.5, 1000.0);

  WorldMatrix.Identity;
  WorldMatrix.Translate(0.0, 0.0, -200.0); // Die Scene in den sichtbaren Bereich verschieben.
  WorldMatrix.Scale(10.0);                 // Und der Grösse anpassen.

  glEnable(GL_DEPTH_TEST);
  glDepthFunc(GL_LESS);

  Shader := TShader.Create([FileToStr('Vertexshader.glsl'), FileToStr('Fragmentshader.glsl')]);
  with Shader do begin
    UseProgram;
    Matrix_ID := UniformLocation('Matrix');
  end;

  glGenVertexArrays(1, @VBCube.VAO);

  glGenBuffers(1, @VBCube.VBOvert);
  glGenBuffers(1, @VBCube.VBOcol);

  Timer1.Enabled := True;
end;

(*
Startpositionen der einzelnen Würfel definieren.
*)
//code+
procedure TForm1.InitScene;
const
  d = 1.8;
var
  i, s: integer;
begin
  s := CubeSize div 2;
  for i := 0 to CubeTotal - 1 do begin
    CubePosArray[i]^.pos.x := ((i mod CubeSize) - s) * d;
    CubePosArray[i]^.pos.y := ((i div CubeSize) mod CubeSize - s) * d;
    CubePosArray[i]^.pos.z := (i div (CubeSize * CubeSize) - s) * d;
  end;
  //code-

  glClearColor(0.6, 0.6, 0.4, 1.0); // Hintergrundfarbe

  glEnable(GL_BLEND);                                  // Alphablending an
  glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);   // Sortierung der Primitiven von hinten nach vorne.

  // --- Daten für Würfel
  glBindVertexArray(VBCube.VAO);

  // Vektor
  glBindBuffer(GL_ARRAY_BUFFER, VBCube.VBOvert);
  glBufferData(GL_ARRAY_BUFFER, sizeof(CubeVertex), @CubeVertex, GL_STATIC_DRAW);
  glEnableVertexAttribArray(10);                         // 10 ist die Location in inPos Shader.
  glVertexAttribPointer(10, 3, GL_FLOAT, False, 0, nil);

  // Farbe
  glBindBuffer(GL_ARRAY_BUFFER, VBCube.VBOcol);
  glBufferData(GL_ARRAY_BUFFER, sizeof(CubeColor), @CubeColor, GL_STATIC_DRAW);
  glEnableVertexAttribArray(11);                         // 11 ist die Location in inCol Shader.
  glVertexAttribPointer(11, 3, GL_FLOAT, False, 0, nil);

end;

(*
Hier sieht man, das ich die Matrizen vor dem Zeichnen mit einem Quick-Sort sortiere.
Die Tiefe ist in der Matrix bei <b>[3, 2]</b> gespeichert, somit nehme ich den Wert als Vergleich für die Sortierung.
*)
//code+

// Pointer vertauschen
procedure SwapPointer(var p1, p2: Pointer); inline;
var
  dummy: Pointer;
begin
  dummy := p1;
  p1 := p2;
  p2 := dummy;
end;

// Der Quick-Sort
procedure QuickSort(var ia: array of PCubePos; ALo, AHi: integer);
var
  Lo, Hi: integer;
  Pivot: TCubePos;
begin
  Lo := ALo;
  Hi := AHi;
  Pivot := ia[(Lo + Hi) div 2]^;
  repeat
    while ia[Lo]^.mat[3, 2] < Pivot.mat[3, 2] do begin
      Inc(Lo);
    end;
    while ia[Hi]^.mat[3, 2] > Pivot.mat[3, 2] do begin
      Dec(Hi);
    end;
    if Lo <= Hi then begin
      SwapPointer(ia[Lo], ia[Hi]);
      Inc(Lo);
      Dec(Hi);
    end;
  until Lo > Hi;
  if Hi > ALo then begin
    QuickSort(ia, ALo, Hi);
  end;
  if Lo < AHi then begin
    QuickSort(ia, Lo, AHi);
  end;
end;
//code-

(*
Hier sieht man, das die Matrix der einzelnen Würfel berechnet werden, um sie anschliessend nach der Z-Tiefe zu sortieren.
Nach dem Sortieren werden die Würfel in der richtigen Reihenfolge gezeichnet.
Versuchsweise kann man die Sortierroutine ausklammern, dann sieht man sofort die fehlerhafte Darstellung.
*)
//code+
procedure TForm1.ogcDrawScene(Sender: TObject);
var
  i: integer;
begin
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);  // Frame und Tiefen-Buffer CubeSizeöschen.

  glEnable(GL_CULL_FACE);
  glCullface(GL_BACK);

  Shader.UseProgram;

  glBindVertexArray(VBCube.VAO);


  // --- Zeichne Würfel

  for i := 0 to CubeTotal - 1 do begin
    CubePosArray[i]^.mat.Identity;
    CubePosArray[i]^.mat.Translate(CubePosArray[i]^.pos);             // Matrix verschieben.
    CubePosArray[i]^.mat.Multiply(WorldMatrix, CubePosArray[i]^.mat); // Matrixen multiplizieren.
  end;

  QuickSort(CubePosArray, 0, CubeTotal - 1);                          // Würfel nach der Z-Tiefe sortieren.

  for i := 0 to CubeTotal - 1 do begin
    CubePosArray[i]^.mat.Multiply(FrustumMatrix, CubePosArray[i]^.mat);
    CubePosArray[i]^.mat.Uniform(Matrix_ID);                          // Matrix dem Shader übergeben.
    glDrawArrays(GL_TRIANGLES, 0, Length(CubeVertex) * 3);            // Zeichnet einen kleinen Würfel.
  end;

  ogc.SwapBuffers;
end;
//code-
(*
Den Speicher von den CubePos wieder frei geben.
*)
//code+
procedure TForm1.FormDestroy(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to CubeTotal - 1 do begin
    New(CubePosArray[i]);
  end;
//code-
  Shader.Free;

  glDeleteVertexArrays(1, @VBCube.VAO);
  glDeleteBuffers(1, @VBCube.VBOvert);
  glDeleteBuffers(1, @VBCube.VBOcol);
end;

(*
Gedreht wird nur die WorldMatrix.
*)
//code+
procedure TForm1.Timer1Timer(Sender: TObject);
var
  i: integer;
begin
  WorldMatrix.RotateA(0.0123);  // Drehe um X-Achse
  WorldMatrix.RotateB(0.0234);  // Drehe um Y-Achse

  ogc.Invalidate;
end;
//code-

//lineal

(*
<b>Vertex-Shader:</b>
*)
//includeglsl Vertexshader.glsl
//lineal

(*
<b>Fragment-Shader</b>
*)
//includeglsl Fragmentshader.glsl

end.
