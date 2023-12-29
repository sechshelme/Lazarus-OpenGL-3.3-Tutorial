unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, Menus,
  dglOpenGL, oglVector,oglVectors, oglMatrix, oglContext, oglShader;

type

  { TForm1 }

  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    ogc: TContext;
    Shader: TShader; // Shader-Object
    procedure Init_OpenGL;
    procedure ogcDrawScene(Sender: TObject);
    procedure Destroy_OpenGL;
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

//image image.png

//lineal


type
  TVB = record
    VAO,
    VBO: GLuint;
  end;

var
  TriangleVectors: TVectors3f = nil;
  TriangleColors: TVectors3f = nil;
  QuadVectors: TVectors3f = nil;
  QuadColors: TVectors3f = nil;

  VBTriangle, VBQuad: TVB;

  //code+
procedure TForm1.FormCreate(Sender: TObject);
const
  TriangleVector: array of TVector3f =
    ((-0.4, 0.1, 0.0), (0.4, 0.1, 0.0), (0.0, 0.7, 0.0));
  TriangleColor: array of TVector3f =
    ((1.0, 1.0, 0.0), (0.0, 1.0, 1.0), (1.0, 0.0, 1.0));

  QuadVector: array of TVector3f =
    ((-0.2, -0.6, 0.0), (-0.2, -0.1, 0.0), (0.2, -0.1, 0.0),
    (-0.2, -0.6, 0.0), (0.2, -0.1, 0.0), (0.2, -0.6, 0.0));
  QuadColor: array of TVector3f =
    ((1.0, 0.0, 0.0), (0.0, 1.0, 0.0), (0.0, 0.0, 1.0),
    (1.0, 0.0, 0.0), (0.0, 0.0, 1.0), (1.0, 1.0, 0.0));
begin
  //remove+
  Width := 340;
  Height := 240;
  //remove-

  TriangleVectors.Add(TriangleVector);
  TriangleColors.Add(TriangleColor);

  QuadVectors.Add(QuadVector);
  QuadVectors.Translate([0.4,0.3,0]);
  QuadColors.Add(QuadColor);

  QuadVectors.Add(QuadVector);
  QuadColors.Add(QuadColor);

  Init_OpenGL;
end;

procedure TForm1.Init_OpenGL;
begin
  // --- Context erzeugen
  ogc := TContext.Create(Self);
  ogc.OnPaint := @ogcDrawScene;

  glClearColor(0.6, 0.6, 0.4, 1.0);                  // Hintergrundfarbe
  glEnable(GL_BLEND);                                // Alphablending an
  glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA); // Sortierung der Primitiven von hinten nach vorne.

  // --- Shader laden
  Shader := TShader.Create;
  Shader.LoadShaderObjectFromFile(GL_VERTEX_SHADER, 'Vertexshader.glsl');
  Shader.LoadShaderObjectFromFile(GL_FRAGMENT_SHADER, 'Fragmentshader.glsl');
  Shader.LinkProgram;
  Shader.UseProgram;

  //   https://github.com/drew-diamantoukos/OpenGLBookExamples/blob/master/Projects/OpenGLBookExamples/Main.cpp

  // Daten für das Dreieck
  glCreateBuffers(1, @VBTriangle.VBO);
  glNamedBufferStorage(VBTriangle.VBO, TriangleVectors.Size + TriangleColors.Size, nil, GL_DYNAMIC_STORAGE_BIT);
  glNamedBufferSubData(VBTriangle.VBO, 0, TriangleVectors.Size, TriangleVectors.Ptr);
  glNamedBufferSubData(VBTriangle.VBO, TriangleVectors.Size, TriangleColors.Size, TriangleColors.Ptr);

  glGenVertexArrays(1, @VBTriangle.VAO);
  glBindVertexArray(VBTriangle.VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBTriangle.VBO);
  glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 0, nil);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(1, 3, GL_FLOAT, GL_FALSE, 0,TriangleVectors.SizePtr);
  glEnableVertexAttribArray(1);

  // Daten für das Quad
  glCreateBuffers(1, @VBQuad.VBO);
  glNamedBufferStorage(VBQuad.VBO, QuadVectors.Size + QuadColors.Size, nil, GL_DYNAMIC_STORAGE_BIT);
  glNamedBufferSubData(VBQuad.VBO, 0, QuadVectors.Size, QuadVectors.Ptr);
  glNamedBufferSubData(VBQuad.VBO, QuadVectors.Size, QuadColors.Size, QuadColors.Ptr);

  glGenVertexArrays(1, @VBQuad.VAO);
  glBindVertexArray(VBQuad.VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBO);
  glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 0, nil);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(1, 3, GL_FLOAT, GL_FALSE, 0, QuadVectors.SizePtr);
  glEnableVertexAttribArray(1);
end;

//code-

//code+
procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT);
  Shader.UseProgram;

  // Zeichne Dreieck
  glBindVertexArray(VBTriangle.VAO);
  glDrawArrays(GL_TRIANGLES, 0, TriangleVectors.Count);

  // Zeichne Quadrat
  glBindVertexArray(VBQuad.VAO);
  glDrawArrays(GL_TRIANGLES, 0, QuadVectors.Count);

  ogc.SwapBuffers;
end;

procedure TForm1.Destroy_OpenGL;
begin
  Shader.Free;

  glDeleteVertexArrays(1, @VBTriangle.VAO);
  glDeleteVertexArrays(1, @VBQuad.VAO);

  glDeleteBuffers(1, @VBTriangle.VBO);
  glDeleteBuffers(1, @VBQuad.VBO);
end;

//code-

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Destroy_OpenGL;
end;

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
