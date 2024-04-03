unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, Menus,
  oglglad_gl,
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
Die Meshes ist hier noch 2D, aber <b>Backface Culling</b> wird in folgenden 3D-Beispielen gebraucht.

Defaultmässig zeichnet OpenGL immer die Vorder und Rückseite eines Polygones. Für die meisten Meshes ist dies aber nicht nötig.
Bei einem Würfel ist es nicht nötig, das die Innenseite der Polygone gezeichnet werden, da man diese sowieso nicht sieht.
Dies spart Rechneleistung, weil jede Pixelüberprüfung Zeit kostet.
Mit <b>glEnable(GL_CULL_FACE);</b> wird nur die Vorderseite der Polygone gezeichnet. Ausgenommen man schaltet es mit <b>glCullFace(...</b> um, so das nur die Rückseite gezeichnet wird.

In diesem Beispiel, wird dies mit einem Timer demonstriert.

Was dabei wichtig ist, die Polygone müssen immer im Gegenuhrzeigersinn gerendert werden. Auch dies könnte man <b>glFrontFace(...</b> umstellen.
Dafür gibt es die Parameter <b>GL_CW</b> für Uhrzeigersinn, und den Default-Parameter <b>GL_CCW</b>.
*)

//lineal

type
  TVertex3f = array[0..2] of GLfloat; // XYZ-Koordinaten
  TFace = array[0..2] of TVertex3f;

(*
Wen man die Konstanten genau anschaut, sieht man, das das Dreieck im Gegenuhrzegersinn und das Qaudrat im Uhrzeigersinn deklariert ist.
*)
//code+
const
  // Dreieck
  Triangle: array[0..0] of TFace =
    (((-0.4, 0.1, 0.0), (0.4, 0.1, 0.0), (0.0, 0.7, 0.0)));

  // Quadrat
  Quad: array[0..1] of TFace =
    (((-0.2, -0.6, 0.0), (-0.2, -0.1, 0.0), (0.2, -0.1, 0.0)),
    ((-0.2, -0.6, 0.0), (0.2, -0.1, 0.0), (0.2, -0.6, 0.0)));
//code-

type
  TVB = record
    VAO,
    VBO: GLuint;
  end;

var
  VBTriangle, VBQuad: TVB;

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

  glGenVertexArrays(1, @VBTriangle.VAO);
  glGenVertexArrays(1, @VBQuad.VAO);

  glGenBuffers(1, @VBTriangle.VBO);
  glGenBuffers(1, @VBQuad.VBO);
end;

(*
Hier wird die Backface Culling aktiviert:
*)

//code+
procedure TForm1.InitScene;
begin
  glEnable(GL_CULL_FACE);           // Überprüfung einschalten
  //code-

  glClearColor(0.6, 0.6, 0.4, 1.0); // Hintergrundfarbe

  // Daten für das Dreieck
  glBindVertexArray(VBTriangle.VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBTriangle.VBO);
  glBufferData(GL_ARRAY_BUFFER, sizeof(Triangle), @Triangle, GL_STATIC_DRAW);
  glEnableVertexAttribArray(10);
  glVertexAttribPointer(10, 3, GL_FLOAT, GL_FALSE, 0, nil);

  // Daten für das Quadrat
  glBindVertexArray(VBQuad.VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBO);
  glBufferData(GL_ARRAY_BUFFER, sizeof(Quad), @Quad, GL_STATIC_DRAW);
  glEnableVertexAttribArray(10);
  glVertexAttribPointer(10, 3, GL_FLOAT, GL_FALSE, 0, nil);
end;

procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT);
  Shader.UseProgram;

  // Zeichne Dreieck
  glBindVertexArray(VBTriangle.VAO);
  glDrawArrays(GL_TRIANGLES, 0, Length(Triangle) * 3);

  // Zeichne Quadrat
  glBindVertexArray(VBQuad.VAO);
  glDrawArrays(GL_TRIANGLES, 0, Length(Quad) * 3);

  ogc.SwapBuffers;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Shader.Free;

  glDeleteVertexArrays(1, @VBTriangle.VAO);
  glDeleteVertexArrays(1, @VBQuad.VAO);

  glDeleteBuffers(1, @VBTriangle.VBO);
  glDeleteBuffers(1, @VBQuad.VBO);
end;

(*
Hier wird zwischen der Rück und Vorder-Seite umgesschalten.
Man sagt immer, welche Seite nicht gezeichnet wird.
*)
//code+
procedure TForm1.Timer1Timer(Sender: TObject);
const
  CullFace: boolean = False;
begin
  if CullFace then begin
    glCullFace(GL_BACK);      // Rückseite nicht zeichnen.
  end else begin
    glCullFace(GL_FRONT);     // Vorderseite nicht zeichnen.
  end;
  CullFace := not CullFace;
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
<b>Fragment-Shader:</b>
*)
//includeglsl Fragmentshader.glsl

end.
