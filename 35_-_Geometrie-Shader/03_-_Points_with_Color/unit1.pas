unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls,
  dglOpenGL,
  oglContext, oglShader;

  //image image.png

(*
Es ist möglich, nur Punkte zu übegeben, an welche dann im Geometrie-Shader Mehses gerendert werden.
Auch wird eine Grundfarbe für die Mesh übergeben.
Nur leider ist die Anzahl der Vertex auf 256 begrenzt.
*)

  //lineal

type

  { TForm1 }

  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
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

type
  TVertex3f = array[0..2] of GLfloat;
  TFace = array[0..2] of TVertex3f;

const
  TriangleVertex: array[0..2] of TVertex3f =
    ((-0.25, 0.3, 0.0), (0.25, 0.3, 0.0), (0.0, 0.7, 0.0));
  TriangleColor: array[0..2] of TVertex3f =
    ((1.0, 0.0, 0.0), (0.0, 1.0, 0.0), (0.0, 0.0, 1.0));

  QuadVertex: array[0..3] of TVertex3f =
    ((-0.15, -0.6, 0.0), (-0.15, -0.1, 0.0), (0.15, -0.1, 0.0), (0.15, -0.6, 0.0));
  QuadColor: array[0..3] of TVertex3f =
    ((1.0, 0.0, 0.0), (0.0, 1.0, 0.0), (0.0, 0.0, 1.0), (1.0, 1.0, 0.0));

type
  TVB = record
    VAO: GLuint;
    VBO: record
      Vertex, Color: GLuint;
      end;
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
  Shader := TShader.Create([FileToStr('Vertexshader.glsl'), FileToStr('Geometrieshader.glsl'), FileToStr('Fragmentshader.glsl')]);
  Shader.UseProgram;

  glGenVertexArrays(1, @VBTriangle.VAO);
  glGenVertexArrays(1, @VBQuad.VAO);

  glGenBuffers(2, @VBTriangle.VBO);
  glGenBuffers(2, @VBQuad.VBO);
end;

procedure TForm1.InitScene;
begin
  glClearColor(0.6, 0.6, 0.4, 1.0); // Hintergrundfarbe

  // --- Daten für Dreieck
  glBindVertexArray(VBTriangle.VAO);

  glBindBuffer(GL_ARRAY_BUFFER, VBTriangle.VBO.Vertex);
  glBufferData(GL_ARRAY_BUFFER, sizeof(TriangleVertex), @TriangleVertex, GL_STATIC_DRAW);
  glEnableVertexAttribArray(10);
  glVertexAttribPointer(10, 3, GL_FLOAT, False, 0, nil);

  glBindBuffer(GL_ARRAY_BUFFER, VBTriangle.VBO.Color);
  glBufferData(GL_ARRAY_BUFFER, sizeof(TriangleColor), @TriangleColor, GL_STATIC_DRAW);
  glEnableVertexAttribArray(11);
  glVertexAttribPointer(11, 3, GL_FLOAT, False, 0, nil);

  // --- Daten für Quadrat
  glBindVertexArray(VBQuad.VAO);

  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBO.Vertex);
  glBufferData(GL_ARRAY_BUFFER, sizeof(QuadVertex), @QuadVertex, GL_STATIC_DRAW);
  glEnableVertexAttribArray(10);
  glVertexAttribPointer(10, 3, GL_FLOAT, False, 0, nil);

  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBO.Color);
  glBufferData(GL_ARRAY_BUFFER, sizeof(QuadColor), @QuadColor, GL_STATIC_DRAW);
  glEnableVertexAttribArray(11);
  glVertexAttribPointer(11, 3, GL_FLOAT, False, 0, nil);
end;

procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT);

  Shader.UseProgram;

  // Zeichne Dreieck
  glBindVertexArray(VBTriangle.VAO);
  glDrawArrays(GL_POINTS, 0, Length(TriangleVertex));

  // Zeichne Quadrat
  glBindVertexArray(VBQuad.VAO);
  glDrawArrays(GL_POINTS, 0, Length(QuadVertex));

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

//lineal

(*
<b>Vertex-Shader:</b>
*)
//includeglsl Vertexshader.glsl
//lineal

(*
<b>Geometrie-Shader:</b>
*)
//includeglsl Geometrieshader.glsl
//lineal

(*
<b>Fragment-Shader</b>
*)
//includeglsl Fragmentshader.glsl

end.
