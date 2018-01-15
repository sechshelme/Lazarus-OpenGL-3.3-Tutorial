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
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure MenuItemClick(Sender: TObject);
  private
    ogc: TContext;
    Shader: TShader; // Shader-Objecte
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
Hier wird die Farbe des Meshes über eine Unifom-Variable an den Shader übergeben, somit kann die Farbe zur Laufzeit geändert werden.
Unifom-Variablen dienen dazu, um Parameter den Shader-Objecte zu übergeben. Meistens sind dies Matrixen, oder wie hier im Beispiel die Farben.
Oder auch Beleuchtung-Parameter, zB. die Position des Lichtes.
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
Deklaration der ID, welche auf die Unifom-Variable im Shader zeigt, und die Variable, welche die Farbe für den Vektor enthält.
Da man die Farbe als Vektor übergibt, habe ich dafür den Typ <b>TVertex3f</b> gewählt. Seine Komponenten beschreiben den Rot-, Grün- und Blauanteil der Farbe.
*)
//code+
var
  Color_ID: GLint;      // ID
  MyColor: TVertex3f;   // Farbe
  //code-
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
end;

(*
Dieser Code wurde um eine Zeile <b>UniformLocation</b> erweitert.
Diese ermittelt die ID, wo sich <b>Color</b> im Shader befindet.

Vor dem Ermitteln muss mit <b>UseProgram</b> der Shader aktviert werden, von dem man lesen will.
Im Hintergrund wird dabei <b>glGetUniformLocation(ProgrammID,...</b> aufgerufen.
Der Vektor von MyColor ist in RGB (Rot, Grün, Blau).

Der String in <b>UniformLocation</b> muss indentisch mit dem Namen der Uniform-Variable im Shader sein. <b>Wichtig:</b> Es muss auf Gross- und Kleinschreibung geachtet werden.
*)


//code+
procedure TForm1.CreateScene;
begin
  Shader := TShader.Create([FileToStr('Vertexshader.glsl'), FileToStr('Fragmentshader.glsl')]);
  Shader.UseProgram;
  Color_ID := Shader.UniformLocation('Color'); // Ermittelt die ID von "Color".
  // MyColor Blau zuweisen.
  MyColor[0] := 0.0;
  MyColor[1] := 0.0;
  MyColor[2] := 1.0;
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
Hier wird die Uniform-Variable übergeben. Für diese vec3-Variable gibt es zwei Möglichkeiten.
Mit <b>glUniform3fv...</b> kann man sie als ganzen Vektor übergeben.
Mit <b>glUniform3f(...</b> kann man die Komponenten der Farben auch einzeln übergeben.
*)

//code+
procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT);
  Shader.UseProgram;

  // Zeichne Dreieck
  glUniform3fv(Color_ID, 1, @MyColor);   // Als Vektor
  glBindVertexArray(VBTriangle.VAO);
  glDrawArrays(GL_TRIANGLES, 0, Length(Triangle) * 3);

  // Zeichne Quadrat
  glUniform3f(Color_ID, 1.0, 0.0, 0.0);  // Einzel
  glBindVertexArray(VBQuad.VAO);
  glDrawArrays(GL_TRIANGLES, 0, Length(Quad) * 3);

  ogc.SwapBuffers;
end;
//code-

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Shader.Free;

  glDeleteVertexArrays(1, @VBTriangle.VAO);
  glDeleteVertexArrays(1, @VBQuad.VAO);

  glDeleteBuffers(1, @VBTriangle.VBO);
  glDeleteBuffers(1, @VBQuad.VBO);
end;

(*
Folgende Prozedur weist dem Vektor <b<MyColor</b> eine andere Farbe zu.
Dafür wird ein einfaches Menü verwendet.
*)
//code+
procedure TForm1.MenuItemClick(Sender: TObject);
begin
  case TMainMenu(Sender).Tag of
    0: begin   // Rot
      MyColor[0] := 1.0;
      MyColor[1] := 0.0;
      MyColor[2] := 0.0;
    end;
    1: begin   // Grün
      MyColor[0] := 0.0;
      MyColor[1] := 1.0;
      MyColor[2] := 0.0;
    end;
    2: begin   // Blau
      MyColor[0] := 0.0;
      MyColor[1] := 0.0;
      MyColor[2] := 1.0;
    end;
  end;
  ogc.Invalidate;   // Manuelle Aufruf von DrawScene.
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

Hier ist die Uniform-Variable <b>Color</b> hinzugekommen.
Diese habe ich nur im Fragment-Shader deklariert, da diese nur hier gebraucht wird.
*)
//includeglsl Fragmentshader.glsl

end.
