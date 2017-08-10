unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, Menus,
  dglOpenGL,
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
  Triangle: array[0..0] of TFace =
    (((-0.4, 0.1, 0.0), (0.4, 0.1, 0.0), (0.0, 0.7, 0.0)));
  Quad: array[0..1] of TFace =
    (((-0.2, -0.6, 0.0), (-0.2, -0.1, 0.0), (0.2, -0.1, 0.0)),
    ((-0.2, -0.6, 0.0), (0.2, -0.1, 0.0), (0.2, -0.6, 0.0)));

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
var
  X_ID, Y_ID: GLint;      // ID für X und Y.
  Color_ID: GLint;

  TrianglePos: record
    x, y: GLfloat;        // Position
    xr, yr: boolean;      // Richtung
  end;
  //code-
  VBTriangle, VBQuad: TVB;

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
begin
  Shader := TShader.Create([FileToStr('Vertexshader.glsl'), FileToStr('Fragmentshader.glsl')]);
  Shader.UseProgram;
  Color_ID := Shader.UniformLocation('Color');
  X_ID := Shader.UniformLocation('x'); // Ermittelt die ID von x.
  Y_ID := Shader.UniformLocation('y'); // Ermittelt die ID von y.
  //code-

  glGenVertexArrays(1, @VBTriangle.VAO);
  glGenVertexArrays(1, @VBQuad.VAO);

  glGenBuffers(1, @VBTriangle.VBO);
  glGenBuffers(1, @VBQuad.VBO);
end;

procedure TForm1.InitScene;
begin
  glClearColor(0.6, 0.6, 0.4, 1.0); // Hintergrundfarbe

  // Daten für Dreieck
  glBindVertexArray(VBTriangle.VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBTriangle.VBO);
  glBufferData(GL_ARRAY_BUFFER, sizeof(Triangle), @Triangle, GL_STATIC_DRAW);
  glEnableVertexAttribArray(10);
  glVertexAttribPointer(10, 3, GL_FLOAT, False, 0, nil);

  // Daten für Quadrat
  glBindVertexArray(VBQuad.VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBO);
  glBufferData(GL_ARRAY_BUFFER, sizeof(Quad), @Quad, GL_STATIC_DRAW);
  glEnableVertexAttribArray(10);
  glVertexAttribPointer(10, 3, GL_FLOAT, False, 0, nil);
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

  // Zeichne Dreieck
  glUniform3f(Color_ID, 1.0, 1.0, 0.0); // Gelb
  with TrianglePos do begin  // Beim Dreieck, die xy-Werte.
    glUniform1f(X_ID, x);
    glUniform1f(Y_ID, y);
  end;
  glBindVertexArray(VBTriangle.VAO);
  glDrawArrays(GL_TRIANGLES, 0, Length(Triangle) * 3);

  // Zeichne Quadrat
  glUniform3f(Color_ID, 1.0, 0.0, 0.0);  // Rot
  glUniform1f(X_ID, 0.0);  // Beim Quadrat keine Verschiebung, daher 0.0, 0.0 .
  glUniform1f(Y_ID, 0.0);
  glBindVertexArray(VBQuad.VAO);
  glDrawArrays(GL_TRIANGLES, 0, Length(Quad) * 3);
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

  glDeleteVertexArrays(1, @VBTriangle.VAO);
  glDeleteVertexArrays(1, @VBQuad.VAO);

  glDeleteBuffers(1, @VBTriangle.VBO);
  glDeleteBuffers(1, @VBQuad.VBO);
end;

(*
Im Timer wird die Position berechnet, so dass sich das Dreieck bewegt.
Anschliessend wird neu gezeichnet.
*)
//code+
procedure TForm1.Timer1Timer(Sender: TObject);
const
  stepx: GLfloat = 0.010;
  stepy: GLfloat = 0.0133;
begin
  with TrianglePos do begin
    if xr then begin
      x := x - stepx;
      if x < -0.5 then begin
        xr := False;
      end;
    end else begin
      x := x + stepx;
      if x > 0.5 then begin
        xr := True;
      end;
    end;
    if yr then begin
      y := y - stepy;
      if y < -1.0 then begin
        yr := False;
      end;
    end else begin
      y := y + stepy;
      if y > 0.3 then begin
        yr := True;
      end;
    end;
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
