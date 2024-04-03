unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls,
  oglglad_gl,
  oglContext, oglShader,oglVector,oglMatrix;

//image image.png
(*
Man kann auch mehrer Vector-Daten in einem VBO verwalten.
*)

//lineal

type
  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
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

const
  TriangleVector: array of TFace =
    (((-0.4, 0.1, 0.0), (0.4, 0.1, 0.0), (0.0, 0.7, 0.0)));
  TriangleColor: array of TFace =   // Rot / Grün / Blau
    (((1.0, 0.0, 0.0), (0.0, 1.0, 0.0), (0.0, 0.0, 1.0)));

  QuadVector: array of TFace =
    (((-0.2, -0.6, 0.0), (-0.2, -0.1, 0.0), (0.2, -0.1, 0.0)),
    ((-0.2, -0.6, 0.0), (0.2, -0.1, 0.0), (0.2, -0.6, 0.0)));
  QuadColor: array of TFace =       // Rot / Grün / Gelb / Rot / Gelb / Mint
    (((1.0, 0.0, 0.0), (0.0, 1.0, 0.0), (1.0, 1.0, 0.0)),
    ((1.0, 0.0, 0.0), (1.0, 1.0, 0.0), (0.0, 1.0, 1.0)));
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

(*
Es wird nur ein VBO benötigt.
*)

procedure TForm1.CreateScene;
begin
  Shader := TShader.Create([FileToStr('Vertexshader.glsl'), FileToStr('Fragmentshader.glsl')]);
  Shader.UseProgram;

  //code+
  glGenVertexArrays(1, @VBTriangle.VAO);
  glGenVertexArrays(1, @VBQuad.VAO);

  glGenBuffers(1, @VBTriangle.VBO);
  glGenBuffers(1, @VBQuad.VBO);
  //code-
end;

(*
Es wird nur ein VBO beladen.
Dafür müssen die Daten nachträglich und gesplitten mit <b>glBufferSubData</b> hochgeladen werden.
*)
//code+
procedure TForm1.InitScene;
begin
  glClearColor(0.6, 0.6, 0.4, 1.0); // Hintergrundfarbe

  // --- Daten für Dreieck
  glBindVertexArray(VBTriangle.VAO);

  glBindBuffer(GL_ARRAY_BUFFER, VBTriangle.VBO);
  glBufferData(GL_ARRAY_BUFFER, Length(TriangleVector) * (sizeof(TFace) + sizeof(TFace)), nil, GL_DYNAMIC_DRAW);

  // Vektor
  glBufferSubData(GL_ARRAY_BUFFER, 0, Length(TriangleVector) * sizeof(TFace), PFace(TriangleVector));
  glEnableVertexAttribArray(10);
  glVertexAttribPointer(10, 3, GL_FLOAT, GL_FALSE, 0, nil);

  // Farbe
  glBufferSubData(GL_ARRAY_BUFFER, Length(TriangleVector) * sizeof(TFace), Length(TriangleColor) * sizeof(TFace), PFace(TriangleColor));
  glEnableVertexAttribArray(11);
  glVertexAttribPointer(11, 3, GL_FLOAT, GL_FALSE, 0, Pointer(Length(TriangleVector) * sizeof(TFace)));

  // --- Daten für Quadrat
  glBindVertexArray(VBQuad.VAO);

  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBO);
  glBufferData(GL_ARRAY_BUFFER, Length(QuadVector) * (sizeof(TFace) + sizeof(TFace)), nil, GL_DYNAMIC_DRAW);

  // Vektor
  glBufferSubData(GL_ARRAY_BUFFER, 0, Length(QuadVector) * sizeof(TFace), PFace(QuadVector));
  glEnableVertexAttribArray(10);
  glVertexAttribPointer(10, 3, GL_FLOAT, GL_FALSE, 0, nil);

  // Farbe
  glBufferSubData(GL_ARRAY_BUFFER, Length(QuadVector) * sizeof(TFace), Length(QuadColor) * sizeof(TFace), PFace(QuadColor));
  glEnableVertexAttribArray(11);
  glVertexAttribPointer(11, 3, GL_FLOAT, GL_FALSE, 0, Pointer(Length(QuadVector) * sizeof(TFace)));
end;
//code-

procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT);

  Shader.UseProgram;

  //code+
  // Zeichne Dreieck
  glBindVertexArray(VBTriangle.VAO);
  glDrawArrays(GL_TRIANGLES, 0, Length(TriangleVector) * 3);

  // Zeichne Quadrat
  glBindVertexArray(VBQuad.VAO);
  glDrawArrays(GL_TRIANGLES, 0, Length(QuadVector) * 3);
  //code-

  ogc.SwapBuffers;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Shader.Free;

  glDeleteVertexArrays(1, @VBTriangle.VAO);
  glDeleteVertexArrays(1, @VBQuad.VAO);

  //code+
  glDeleteBuffers(1, @VBTriangle.VBO);
  glDeleteBuffers(1, @VBQuad.VBO);
  //code-
end;

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
