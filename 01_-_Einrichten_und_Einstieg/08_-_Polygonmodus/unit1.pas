unit Unit1;
{$include ..\..\units\opts.inc}
{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, Menus,
  {$IFDEF COREGL}
  glcorearb,
  {$ELSE}
  dglOpenGL,
  {$ENDIF}
  oglContext, oglShader;

type

  { TForm1 }

  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure MenuItemClick(Sender: TObject);
  private
    Shader:TShader;   // Shader-Object
    ogc: TContext;
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
Standartmässig stellt OpenGL Polygone flächenfüllend dar.
Man kann aber die Polygone auch als Drahtgitter, oder nur die Eckpunkte als Punkte darstellen.

Dies kann man mit <b>glPolygonMode(...</b> einstellen.
Der Modus <b>GL_LINE</b> ist recht praktisch, wen man eine Mesh in der Entwicklungphase rendert, so kann man recht gut Renderfehler erkennen.

Hinweis: Hier wird die TShader-Klasse verwendet, näheres dazu im Kapitel Shader.
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
end;

procedure TForm1.CreateScene;
begin
  Shader:=TShader.Create([FileToStr('Vertexshader.glsl'),FileToStr( 'Fragmentshader.glsl')]);
  Shader.UseProgram;

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
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 0, nil);

  // Daten für Quadrat
  glBindVertexArray(VBQuad.VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBO);
  glBufferData(GL_ARRAY_BUFFER, sizeof(Quad), @Quad, GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 0, nil);
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
  glDeleteVertexArrays(1, @VBTriangle.VAO);
  glDeleteVertexArrays(1, @VBQuad.VAO);

  glDeleteBuffers(1, @VBTriangle.VBO);
  glDeleteBuffers(1, @VBQuad.VBO);

  Shader.Free;
end;

(*
Hier werden die verschiedenen Polygone-Modis eingestellt.
Mit <b>glPolygonMode(...</b> und dem zweiten Parameter werden die verschiedenen Modis eingestellt.
Dabei muss der erste Paramter immer <b>GL_FRONT_AND_BACK</b> sein, die beiden Parameter <b>GL_FRONT</b> und <b>GL_BACK</b> gehen mit OpenGL >= 3.3 nicht mehr.
<b>glPolygonMode(...</b> kann auch bei DrawScene aufgerufen werden. ZB. wen man zwei Meshes hat, kann man die einte Fächenfüllend und die andere als Drahtgitter darstellen.
*)
//code+
procedure TForm1.MenuItemClick(Sender: TObject);
begin
  case TMainMenu(Sender).Tag of
    1: begin
      glPolygonMode(GL_FRONT_AND_BACK, GL_POINT);  // Punkte
    end;
    2: begin
      glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);   // Linien
    end;
    3: begin
      glPolygonMode(GL_FRONT_AND_BACK, GL_FILL);   // Flächenfüllend
    end;
  end;
  ogc.Invalidate;   // Manuelle Aufruf von DrawScene.
end;
//code-

//lineal
(*
Die Shader haben keinen Einfluss auf die Polygonmodis.
<b>Vertex-Shader:</b>
*)
//includeglsl Vertexshader.glsl
//lineal

(*
<b>Fragment-Shader:</b>
*)
//includeglsl Fragmentshader.glsl


end.
