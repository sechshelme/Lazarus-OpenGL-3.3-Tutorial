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
Hier sind sogar 10'000'000 Instancen möglich, gegenüber der Uniform-Variante die bei gut 800 schon Schluss machte.
Bei noch höheren Werten macht der FPC-Compiler Schluss, wieviel das die Grafikkarte vertägt, kann ich nicht sagen.
Das es eine Diashow ist, das ist was anderes.
*)

//lineal

const
  Quad: array[0..1] of TFace2D =
    (((-0.01, -0.01), (-0.01, 0.01), (0.01, 0.01)),
    ((-0.01, -0.01), (0.01, 0.01), (0.01, -0.01)));

(*
Die Anzahl Instance
*)
//code+
const
  InstanceCount = 10000;
//code-

(*
Für die Instancen werden VBOs gebraucht.
*)
//code+
type
  TVB = record
    VAO,
    VBOVertex,
    VBO_I_Size, VBO_I_Matrix, VBO_I_Color: GLuint;
  end;
//code-


(*
Die Deklaration, der Arrays ist gleich wie bei der Uniform-Übergaben.
*)
//code+
var
  VBQuad: TVB;

  Data: record
    Size: array[0..InstanceCount - 1] of GLfloat;
    Matrix: array[0..InstanceCount - 1] of TMatrix;
    Color: array[0..InstanceCount - 1] of TVector3f;
  end;
//code-

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

(*
VBO-Puffer für Instancen anlegen. Uniformen werden keine gebraucht.
*)
//code+
procedure TForm1.CreateScene;
var
  i: integer;
begin
  Shader := TShader.Create([FileToStr('Vertexshader.glsl'), FileToStr('Fragmentshader.glsl')]);
  Shader.UseProgram;

  glGenVertexArrays(1, @VBQuad.VAO);

  glGenBuffers(1, @VBQuad.VBOVertex);
  glGenBuffers(1, @VBQuad.VBO_I_Size);
  glGenBuffers(1, @VBQuad.VBO_I_Matrix);
  glGenBuffers(1, @VBQuad.VBO_I_Color);

  for i := 0 to Length(Data.Matrix) - 1 do begin
    Data.Size[i] := Random() * 0.2 + 1.0;
    Data.Matrix[i].Identity;
    Data.Matrix[i].Translate(1.5 - Random * 3.0, 1.5 - Random * 3.0, 0.0);
    Data.Color[i] := vec3(Random, Random, Random);
  end;
end;
//code-

(*
Für die Instancen werden die Puffer gefüllt.
Da für die Puffer nur Vektoren mit 1-4 Elemeten erlaubt sind, muss man die Matrix in 4 Vektoren unterteilen.
Dabei werden auch 4 Attribut-Indexe gebraucht.
Eine <b>glVertexAttribPointer(2, 16,...</b> geht leider nicht. Im Shader kann man es direkt als Matrix deklarieren.
*)
//code+
procedure TForm1.InitScene;
var
  i: integer;
begin
  glClearColor(0.6, 0.6, 0.4, 1.0); // Hintergrundfarbe

  glBindVertexArray(VBQuad.VAO);

  // --- Normale Vektordaten
  // Daten für Vektoren
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBOVertex);
  glBufferData(GL_ARRAY_BUFFER, sizeof(Quad), @Quad, GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 2, GL_FLOAT, False, 0, nil);

  // --- Instancen
  // Instance Size
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBO_I_Size);
  glBufferData(GL_ARRAY_BUFFER, SizeOf(Data.Size), @Data.Size, GL_STATIC_DRAW);
  glEnableVertexAttribArray(1);
  glVertexAttribPointer(1, 1, GL_FLOAT, False, 0, nil);
  glVertexAttribDivisor(1, 1);

  // Instance Matrix
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBO_I_Matrix);
  glBufferData(GL_ARRAY_BUFFER, SizeOf(Data.Matrix), nil, GL_STATIC_DRAW); // Nur Speicher reservieren
  for i := 0 to 3 do begin
    glEnableVertexAttribArray(i + 2);
    //  glVertexAttribPointer(2, 16, GL_FLOAT, False, 0, nil);
    glVertexAttribPointer(i + 2, 4, GL_FLOAT, False, SizeOf(TMatrix), Pointer(i * 16));
    glVertexAttribDivisor(i + 2, 1);
  end;

  // Instance Color
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBO_I_Color);
  glBufferData(GL_ARRAY_BUFFER, SizeOf(Data.Color), @Data.Color, GL_STATIC_DRAW);
  glEnableVertexAttribArray(6);
  glVertexAttribPointer(6, 3, GL_FLOAT, False, 0, nil);
  glVertexAttribDivisor(6, 1);
end;
//code-

(*
Die Instance Parameter werden einfache mit <b>glBufferSubData(....</b> übergeben.
Es werden nur die Matrizen aktualisiert, die anderen Werte bleiben gleich.
Will man eine andere Anzahl von Instance, dann muss man mit <b>glBufferData(...</b> mehr oder weniger Speicher reservieren.
Dafür braucht man keine Uniformen.
*)
//code+
procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT);
  Shader.UseProgram;

  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBO_I_Matrix);
  glBufferSubData(GL_ARRAY_BUFFER, 0, SizeOf(Data.Matrix), @Data.Matrix);

  glBindVertexArray(VBQuad.VAO);
  glDrawArraysInstanced(GL_TRIANGLES, 0, Length(Quad) * 3, InstanceCount);

  ogc.SwapBuffers;
end;
//code-

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Timer1.Enabled := False;
  Shader.Free;
  glDeleteVertexArrays(1, @VBQuad.VAO);
  glDeleteBuffers(1, @VBQuad.VBOVertex);
  glDeleteBuffers(1, @VBQuad.VBO_I_Size);
  glDeleteBuffers(1, @VBQuad.VBO_I_Matrix);
  glDeleteBuffers(1, @VBQuad.VBO_I_Color);
end;

(*
Matrizen neu berechnen.
*)
//code+
procedure TForm1.Timer1Timer(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to Length(Data.Matrix) - 1 do begin
    Data.Matrix[i].RotateC(0.02);
  end;

  glBindVertexArray(VBQuad.VAO);
  ogcDrawScene(Sender);  // Neu zeichnen
end;
//code-

//lineal

(*
<b>Vertex-Shader:</b>
Der Shader sieht sher einfach aus.
*)
//includeglsl Vertexshader.glsl
//lineal

(*
<b>Fragment-Shader:</b>
*)
//includeglsl Fragmentshader.glsl

end.
