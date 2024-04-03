unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls,
  oglglad_gl,
  oglContext, oglShader, oglMatrix;

//image image.png
(*
Einen Tiefenpuffer braucht man, das Polygone nicht einfach willkürlich übereinander gezeichnet werden.
Mit dem Tiefenpuffer wird berechnet, das ein Polygon das sich hinter einem anderen befindet, nicht gezeichnet wird.
Diese Berechnung läuft auf Pixelebene.

Bei dem Würfelbeispiel, wird der kleine Würfel nicht mehr gezeichnet, da sich dieser hinter den Flächen des grossen Würfels befindet.
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

var
  VBCube: TVB;
  WorldMatrix: TMatrix;
  WorldMatrix_ID: GLint;

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
Hier wird den Tiefenpufferprüfung eingeschaltet, dies geschieht mit <b>glEnable(GL_DEPTH_TEST);</b>.
Die Art der Prüfung kann man mit <b>glDepthFunc(...</b> einstellen, wobei Default auf <b>GL_LESS</b> ist.
Mit <b>GL_LESS</b> wird geprüft, ob der Z-Wert geringer ist, und wen ja, darf der Pixel gezeichnet werden.

*)
//code+
procedure TForm1.CreateScene;
begin
  glEnable(GL_DEPTH_TEST);  // Tiefenprüfung einschalten.
  glDepthFunc(GL_LESS);     // Kann man weglassen, da Default.
  //code-

  WorldMatrix.Identity;
  Shader := TShader.Create([FileToStr('Vertexshader.glsl'), FileToStr('Fragmentshader.glsl')]);
  with Shader do begin
    UseProgram;
    WorldMatrix_ID := UniformLocation('Matrix');
  end;

  glGenVertexArrays(1, @VBCube.VAO);

  glGenBuffers(1, @VBCube.VBOvert);
  glGenBuffers(1, @VBCube.VBOcol);

  Timer1.Enabled := True;
end;

procedure TForm1.InitScene;
begin
  glClearColor(0.6, 0.6, 0.4, 1.0); // Hintergrundfarbe

  // --- Daten für Würfel
  glBindVertexArray(VBCube.VAO);

  // Vektor
  glBindBuffer(GL_ARRAY_BUFFER, VBCube.VBOvert);
  glBufferData(GL_ARRAY_BUFFER, sizeof(CubeVertex), @CubeVertex, GL_STATIC_DRAW);
  glEnableVertexAttribArray(10);                         // 10 ist die Location in inPos Shader.
  glVertexAttribPointer(10, 3, GL_FLOAT, GL_FALSE, 0, nil);

  // Farbe
  glBindBuffer(GL_ARRAY_BUFFER, VBCube.VBOcol);
  glBufferData(GL_ARRAY_BUFFER, sizeof(CubeColor), @CubeColor, GL_STATIC_DRAW);
  glEnableVertexAttribArray(11);                         // 11 ist die Location in inCol Shader.
  glVertexAttribPointer(11, 3, GL_FLOAT, GL_FALSE, 0, nil);

end;

(*
Bei <b>glClear(...</b> ist noch etwas neues dazugekommen, <b>GL_DEPTH_BUFFER_BIT</b>.
Dies bewirkt, das bei <b>glClear(...</b> nicht nur der Frame-Puffer gelöscht wird, sondern auch der Tiefen-Puffer.
Jetzt darf der kleine Würfel nicht mehr sichtbar sein, da sich dieser hinter dem grossen versteckt.
*)
//code+
procedure TForm1.ogcDrawScene(Sender: TObject);
var
  TempMatrix: TMatrix;
begin
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);  // Frame und Tiefen-Puffer löschen.

  Shader.UseProgram;

  // --- Zeichne Würfel

  glBindVertexArray(VBCube.VAO);

  WorldMatrix.Uniform(WorldMatrix_ID);
  glDrawArrays(GL_TRIANGLES, 0, Length(CubeVertex) * 3);

  TempMatrix := WorldMatrix;

  WorldMatrix.Scale(0.5);
  WorldMatrix.Uniform(WorldMatrix_ID);
  glDrawArrays(GL_TRIANGLES, 0, Length(CubeVertex) * 3); // wird nicht gezeichnet.

  WorldMatrix := TempMatrix;

  ogc.SwapBuffers;
end;
//code-

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Shader.Free;

  glDeleteVertexArrays(1, @VBCube.VAO);
  glDeleteBuffers(1, @VBCube.VBOvert);
  glDeleteBuffers(1, @VBCube.VBOcol);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  WorldMatrix.RotateA(0.0123);  // Drehe um X-Achse
  WorldMatrix.RotateB(0.0234);  // Drehe um Y-Achse

  ogc.Invalidate;
end;

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

