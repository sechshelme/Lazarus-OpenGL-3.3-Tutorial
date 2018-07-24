unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, Menus,
  dglOpenGL, oglVector, oglMatrix,
  oglContext, oglShader;

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
Ohne Bewegung ist OpenGL langweilig.
Hier werden dem Shader ein X- und ein Y-Wert übergeben. Diese Werte werden mit einem Timer verändert.
Damit die Änderung auch sichtbar wird, wird <b>DrawScene</b> danach manuell ausgelöst.
*)

//lineal

type
  TVertex3f = array[0..2] of GLfloat;
  TFace = array[0..2] of TVertex3f;

const
  Quad: array[0..1] of TFace =
    (((-0.01, -0.01, 0.0), (-0.01, 0.01, 0.0), (0.01, 0.01, 0.0)),
    ((-0.01, -0.01, 0.0), (0.01, 0.01, 0.0), (0.01, -0.01, 0.0)));

type
  TVB = record
    VAO,
    VBO: GLuint;
  end;

(*
Hinzugekommen sind die Deklarationen der IDs für die X- und Y-Koordinaten.
<b>TrianglePos</b> bestimmt die Bewegung und Richtung des Dreiecks.
*)
//code+
const
  QuadCount = 2000;


var
  Pos_ID, Color_ID, Size_ID: GLint;

  //code-
  VBQuad: TVB;

  Data: record
    Position: array[0..QuadCount - 1] of TVector2f;
    Color: array[0..QuadCount - 1] of TVector3f;
    Size: array[0..QuadCount - 1] of GLfloat;
  end;

{ TForm1 }

(*
Den Timer immer erst nach dem Initialisieren starten!
Im Objektinspektor <b>muss</b> dessen Eigenschaft <b>Enable=(False)</b> sein!
Ansonsten ist ein SIGSEV vorprogrammiert, da Shader aktviert werden, die es noch gar nicht gibt.
*)
//code+
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
  Timer1.Enabled := True;   // Timer starten
end;
//code-

(*
Dieser Code wurde um zwei <b>UniformLocation</b>-Zeilen erweitert.
Diese ermitteln die IDs, wo sich <b>x</b> und <b>y</b> im Shader befinden.
*)
//code+
procedure TForm1.CreateScene;
var
  i: integer;
begin
  Shader := TShader.Create([FileToStr('Vertexshader.glsl'), FileToStr('Fragmentshader.glsl')]);
  Shader.UseProgram;
  Color_ID := Shader.UniformLocation('Color');
  Pos_ID := Shader.UniformLocation('Position');
  Size_ID := Shader.UniformLocation('Size');
  //code-

  glGenVertexArrays(1, @VBQuad.VAO);

  glGenBuffers(1, @VBQuad.VBO);

  for i := 0 to Length(Data.Position) - 1 do begin
    Data.Position[i] := vec2(1.5 - Random * 3.0, 1.5- Random * 3.0);
    Data.Color[i] := vec3(Random, Random, Random);
    Data.Size[i] := Random() * 3 + 1.0;
  end;
end;

procedure TForm1.InitScene;
begin
  glClearColor(0.6, 0.6, 0.4, 1.0); // Hintergrundfarbe

  // Daten für Quadrat
  glBindVertexArray(VBQuad.VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBO);
  glBufferData(GL_ARRAY_BUFFER, sizeof(Quad), @Quad, GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 3, GL_FLOAT, False, 0, nil);
end;

(*
Hier werden die Uniform-Variablen x und y dem Shader übergeben.
Beim Dreieck sind das die Positions-Koordinaten.
Beim Quad ist es 0, 0 und somit bleibt das Quadrat stehen.
Mit <b>glUniform1f(...</b> kann man einen Float-Wert dem Shader übergeben.
*)
//code+
procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT);
  Shader.UseProgram;

  // Zeichne Quadrat
  glUniform3fv(Color_ID, QuadCount, @Data.Color);
  glUniform2fv(Pos_ID, QuadCount, @Data.Position);
  glUniform1fv(Size_ID, QuadCount, @Data.Size);
  glBindVertexArray(VBQuad.VAO);
  glDrawArraysInstanced(GL_TRIANGLES, 0, Length(Quad) * 3, QuadCount);
  //code-

  ogc.SwapBuffers;
end;

(*
Den Timer vor dem Freigeben anhalten.
*)
//code+
procedure TForm1.FormDestroy(Sender: TObject);
begin
  Timer1.Enabled := False;
  //code-

  Shader.Free;

  glDeleteVertexArrays(1, @VBQuad.VAO);

  glDeleteBuffers(1, @VBQuad.VBO);
end;

(*
Im Timer wird die Position berechnet, so dass sich das Dreieck bewegt.
Anschliessend wird neu gezeichnet.
*)
//code+
procedure TForm1.Timer1Timer(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to Length(Data.Position) - 1 do begin
    Data.Position[i].Rotate(0.02);
  end;

  ogcDrawScene(Sender);  // Neu zeichnen
end;
//code-

//lineal

(*
<b>Vertex-Shader:</b>

Hier sind die Uniform-Variablen <b>x</b> und <b>y</b> hinzugekommen.
Diese werden im Vertex-Shader deklariert. Bewegungen kommen immer in diesen Shader.
*)
//includeglsl Vertexshader.glsl
//lineal

(*
<b>Fragment-Shader:</b>
*)
//includeglsl Fragmentshader.glsl

end.
