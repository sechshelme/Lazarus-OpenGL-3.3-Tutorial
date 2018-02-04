unit Unit1;
{$include ..\..\units\opts.inc}
{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls,
{$IFDEF COREGL}
glcorearb,
{$ELSE}
dglOpenGL,
{$ENDIF}
  oglContext, oglShader, oglMatrix;

//image image.png
(*
Jetzt wird das erste mal 3D gerendert.
Dafür wird ein einfacher Würfel genommen, welcher sechs unterschiedlich farbige Flächen hat.

In diesem Beispiel wird bewusst noch auf den Tiefenbuffer verzichtet.
Somit sieht man gut, was passiert wen man diesen nicht berücksichtigt.
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

(*
Hier sind die Koordinaten und die Farben des Würfels deklariert.
*)
//code+
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
//code-

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

procedure TForm1.CreateScene;
begin
  WorldMatrix := TMatrix.Create;
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
Ohne Tiefenbuffer wird einfach alles gezeichnet, auch wen es verdeckt hinter einem anderen Object ist.
Das man dies gut sieht, zeichne ich einen kleinen Würfel in den Grossen.
Der Kleine übermahlt einfach den grossen.
*)
//code+
procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);

  Shader.UseProgram;

  // --- Zeichne Würfel

  glBindVertexArray(VBCube.VAO);

  WorldMatrix.Uniform(WorldMatrix_ID);                     // Matrix dem Shader übergeben
  glDrawArrays(GL_TRIANGLES, 0, Length(CubeVertex) * 3);   // Zeichne grossen Würfel

  WorldMatrix.Push;                                        // Matrix sichern

  WorldMatrix.Scale(0.5);                                  // Matrix kleiner scalieren
  WorldMatrix.Uniform(WorldMatrix_ID);                     // Matrix dem Shader übergeben
  glDrawArrays(GL_TRIANGLES, 0, Length(CubeVertex) * 3);   // Zeichne kleinen Würfel

  WorldMatrix.Pop;                                         // Matrix laden

  ogc.SwapBuffers;
end;
//code-

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Shader.Free;

  glDeleteVertexArrays(1, @VBCube.VAO);
  glDeleteBuffers(1, @VBCube.VBOvert);
  glDeleteBuffers(1, @VBCube.VBOcol);

  WorldMatrix.Free;
end;

(*
Mit einem Timer wird der Würfel gedreht und neu gezeichnet.
*)
//code+
procedure TForm1.Timer1Timer(Sender: TObject);
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

