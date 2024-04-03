unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, Menus,
  oglglad_gl, oglVector, oglMatrix,
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
Vorher hatte es für jedes Instance-Attribut eine eigene Array gehabt.
Jetzt sind alle Attribute in einer Array, dies macht den Code einiges übersichtlicher.
Dafür ist die Übergabe mit <b>glVertexAttribPointer(...</b> ein wenig komplizierter.
Siehe [[Lazarus - OpenGL 3.3 Tutorial - Vertex-Puffer - Nur eine Array]].
*)

//lineal

const
  Quad: array[0..1] of TFace2D =
    (((-0.01, -0.01), (-0.01, 0.01), (0.01, 0.01)),
    ((-0.01, -0.01), (0.01, 0.01), (0.01, -0.01)));

  InstanceCount = 100;
type
  TVB = record
    VAO: GLuint;
    VBO: record
      Vertex,
      Instance: GLuint;
    end;
  end;

(*
Die Deklaration der Array. Es ist nur noch eine Array.
*)
//code+
type
  PData = ^TData;
  TData = record
    Scale: GLfloat;
    Matrix: TMatrix;
    Color: TVector3f;
  end;

var
  Data: array[0..InstanceCount - 1] of TData;
//code-
  VBQuad: TVB;

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  Randomize;
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

procedure TForm1.CreateScene;
var
  i: integer;
begin
  Shader := TShader.Create([FileToStr('Vertexshader.glsl'), FileToStr('Fragmentshader.glsl')]);
  Shader.UseProgram;

  glGenVertexArrays(1, @VBQuad.VAO);

  glGenBuffers(2, @VBQuad.VBO);

  for i := 0 to Length(Data) - 1 do begin
    Data[i].Scale := Random * 20 + 1.0;
    Data[i].Matrix.Identity;
    Data[i].Matrix.Translate(1.5 - Random * 3.0, 1.5 - Random * 3.0, 0.0);
    Data[i].Color := vec3(Random, Random, Random);
  end;
end;

(*
Das es ein wenig einfacher wird, habe ich <b>ofs</b> verwendet.
*)
//code+
procedure TForm1.InitScene;
var
  ofs, i: integer;
begin
  glClearColor(0.6, 0.6, 0.4, 1.0); // Hintergrundfarbe

  glBindVertexArray(VBQuad.VAO);

  // --- Normale Vektordaten
  // Daten für Vektoren
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBO.Vertex);
  glBufferData(GL_ARRAY_BUFFER, sizeof(Quad), @Quad, GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 2, GL_FLOAT, GL_FALSE, 0, nil);

  // --- Instancen
  ofs := 0;
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBO.Instance);
  glBufferData(GL_ARRAY_BUFFER, SizeOf(Data), PData(Data), GL_STATIC_DRAW);

  // Instance Size
  glEnableVertexAttribArray(1);
  glVertexAttribPointer(1, 1, GL_FLOAT, GL_FALSE, SizeOf(TData), nil);
  glVertexAttribDivisor(1, 1);
  Inc(ofs, SizeOf(GLfloat));

  // Instance Matrix
  for i := 0 to 3 do begin
    glEnableVertexAttribArray(i + 2);
    glVertexAttribPointer(i + 2, 4, GL_FLOAT, GL_FALSE, SizeOf(TData),PGLvoid(ofs));
    glVertexAttribDivisor(i + 2, 1);
    Inc(ofs, SizeOf(TVector4f));
  end;

  // Instance Color
  glEnableVertexAttribArray(6);
  glVertexAttribPointer(6, 3, GL_FLOAT, GL_FALSE, SizeOf(TData), PGLvoid(ofs));
  glVertexAttribDivisor(6, 1);
end;
//code-

(*
An der Zeichenroutine ändert sich nichts.
*)
//code+
procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT);
  Shader.UseProgram;

  glBindVertexArray(VBQuad.VAO);

  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBO.Instance);
  glBufferSubData(GL_ARRAY_BUFFER, 0, SizeOf(Data), @Data);

  glDrawArraysInstanced(GL_TRIANGLES, 0, Length(Quad) * 3, InstanceCount);

  ogc.SwapBuffers;
end;
//code-

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Timer1.Enabled := False;
  Shader.Free;
  glDeleteVertexArrays(1, @VBQuad.VAO);
  glDeleteBuffers(2, @VBQuad.VBO);
end;

(*
Matrizen neu berechnen.
*)
//code+
procedure TForm1.Timer1Timer(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to Length(Data) - 1 do begin
    Data[i].Matrix.RotateC(0.02);
  end;

  ogcDrawScene(Sender);  // Neu zeichnen
end;
//code-

//lineal

(*
<b>Vertex-Shader:</b>
Am Shader hat sich nichts geändert.
*)
//includeglsl Vertexshader.glsl
//lineal

(*
<b>Fragment-Shader:</b>
*)
//includeglsl Fragmentshader.glsl

end.
