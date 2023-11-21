unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, Menus,
  dglOpenGL,
  oglContext, oglShader, oglVector, oglMatrix;

type

  { TForm1 }

  TForm1 = class(TForm)
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    ogc: TContext;
    Shader: TShader; // Shader-Object
    procedure CreateScene;
    procedure InitScene;
    procedure ogcDrawScene(Sender: TObject);
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

//image image.png

(*
Zum Schluss eine kleine Spielerei: Hier wird ein Mandelbrot im Shader (also auf der GPU) berechnet.
Mit der CPU hatte ich noch keine so schnelle Berechnung hingekriegt, trotz Assembler.

Anmerkung: Bei diesem Beispiel geht es nicht um mathematische Hintegründe, sondern es soll legentlich demonstrieren, das man mit Shader-Programs sehr komplexe Berechnungen machen kann.

Der Lazarus-Code ist nichts besonderes, es wird nur ein Rechteck gerendert und anschliessend mit einer Matrix gedreht. Was eine Matrix ist, wird im Kapitel Matrix beschrieben.
<b>Achtung:</b> Eine lahme Grafikkarte kann bei Vollbild ins Stockern kommen.
Zur Beschleunigung kann der Wert <b>#define depth 1000.0</b> im Fragment-Shader verkleinert werden.
*)

//lineal

type
  TVertex3f = array[0..2] of GLfloat;
  TFace = array[0..2] of TVertex3f;

const
  Quad: array[0..1] of TFace =
    (((-1.0, -1.0, 0.0), (-1.0, 1.0, 0.0), (1.0, 1.0, 0.0)),
    ((-1.0, -1.0, 0.0), (1.0, -1.0, 0.0), (1.0, 1.0, 0.0)));

type
  TVB = record
    VAO,
    VBO: GLuint;
  end;

var
  RotMatrix: TMatrix;
  Matrix_ID: GLint;
  Color_ID: GLint;

  c: single;

  VBQuad: TVB;

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
  Timer1.Enabled := True;
end;

procedure TForm1.CreateScene;
begin
  Shader := TShader.Create([FileToStr('Vertexshader.glsl'), FileToStr('Fragmentshader.glsl')]);
  Shader.UseProgram;
  Color_ID := Shader.UniformLocation('col');
  Matrix_ID := Shader.UniformLocation('mat');
  RotMatrix.Identity;

  glGenVertexArrays(1, @VBQuad.VAO);

  glGenBuffers(1, @VBQuad.VBO);
end;

procedure TForm1.InitScene;
begin
  glClearColor(0.6, 0.6, 0.4, 1.0); // Hintergrundfarbe

  // Daten für Quadrat
  glBindVertexArray(VBQuad.VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBO);
  glBufferData(GL_ARRAY_BUFFER, sizeof(Quad), @Quad, GL_STATIC_DRAW);
  glEnableVertexAttribArray(10);
  glVertexAttribPointer(10, 3, GL_FLOAT, False, 0, nil);

  RotMatrix.RotateB(0.03); // RotMatrix rotieren

end;

procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT);
  Shader.UseProgram;
  RotMatrix.Uniform(Matrix_ID);

  // Zeichne Quadrat
  glUniform1f(Color_ID, c);
  glBindVertexArray(VBQuad.VAO);
  glDrawArrays(GL_TRIANGLES, 0, Length(Quad) * 3);

  ogc.SwapBuffers;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Timer1.Enabled := False;

  Shader.Free;

  glDeleteVertexArrays(1, @VBQuad.VAO);
  glDeleteBuffers(1, @VBQuad.VBO);
end;

var
  lights: array [0..2] of TVector3f = ((-20, 20, 20), (30, 50, -25), (30, 20, 30));


procedure TForm1.Timer1Timer(Sender: TObject);
const
  step: GLfloat = 0.01;
var
  id: GLint;
begin
  c := c + 0.1;
  if c >= 10.0 then begin
    c := c - 10.0;
  end;

//  lights[0] := (RotMatrix * vec4(lights[0], 1)).xyz;

lights[0].RotateB(0.01);
lights[1].RotateB(0.012);
lights[2].RotateB(0.013);
  //  lights[1] := (RotMatrix * vec4(lights[1], 1)).xyz;
  //  lights[2] := (RotMatrix * vec4(lights[2], 1)).xyz;

  id := Shader.UniformLocation('lights');
  glUniform3fv(Shader.ID, 3, @lights);


  //  RotMatrix.RotateC(step); // RotMatrix rotieren
  ogc.Invalidate;          // Neu zeichnen
end;

(*
<b>Vertex-Shader:</b>
*)
//includeglsl Vertexshader.glsl
//lineal

(*
<b>Fragment-Shader:</b>

Hier steckt die ganze Berechnung für das Mandelbrot.
*)
//includeglsl Fragmentshader.glsl

end.
