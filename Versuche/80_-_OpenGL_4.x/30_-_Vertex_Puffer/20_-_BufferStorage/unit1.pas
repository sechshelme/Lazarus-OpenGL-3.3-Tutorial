unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, Menus,
  dglOpenGL, oglVector, oglMatrix, oglContext, oglShader;

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
  TriangleVectors: TglFloatArray = nil;
  TriangleColors: TglFloatArray = nil;
  QuadVectors: TglFloatArray = nil;
  QuadColors: TglFloatArray = nil;

  VBTriangle, VBQuad: TVB;

  //code+
procedure TForm1.FormCreate(Sender: TObject);
const
  TriangleVector: array of TFace =
    (((-0.4, 0.1, 0.0), (0.4, 0.1, 0.0), (0.0, 0.7, 0.0)));
  TriangleColor: array of TFace =
    (((1.0, 1.0, 0.0), (0.0, 1.0, 1.0), (1.0, 0.0, 1.0)));

  QuadVector: array of TFace =
    (((-0.2, -0.6, 0.0), (-0.2, -0.1, 0.0), (0.2, -0.1, 0.0)),
    ((-0.2, -0.6, 0.0), (0.2, -0.1, 0.0), (0.2, -0.6, 0.0)));
  QuadColor: array of TFace =
    (((1.0, 0.0, 0.0), (0.0, 1.0, 0.0), (0.0, 0.0, 1.0)),
    ((1.0, 0.0, 0.0), (0.0, 0.0, 1.0), (1.0, 1.0, 0.0)));
begin
  //remove+
  Width := 340;
  Height := 240;
  //remove-

  TriangleVectors.AddFace3DArray(TriangleVector);
  TriangleColors.AddFace3DArray(TriangleColor);
  QuadVectors.AddFace3DArray(QuadVector);
  QuadColors.AddFace3DArray(QuadColor);

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
  Shader := TShader.Create([
    GL_VERTEX_SHADER, FileToStr('Vertexshader.glsl'),
    GL_FRAGMENT_SHADER, FileToStr('Fragmentshader.glsl')]);

  Shader.UseProgram;

  //   https://github.com/drew-diamantoukos/OpenGLBookExamples/blob/master/Projects/OpenGLBookExamples/Main.cpp

  // Daten für das Dreieck
  glCreateBuffers(1, @VBTriangle.VBO);
  glNamedBufferStorage(VBTriangle.VBO, TriangleVectors.Size + TriangleColors.Size, nil, GL_DYNAMIC_STORAGE_BIT);
  glNamedBufferSubData(VBTriangle.VBO, 0, TriangleVectors.Size, PFace(TriangleVectors));
  glNamedBufferSubData(VBTriangle.VBO, TriangleVectors.Size, TriangleColors.Size, PFace(TriangleColors));

  glGenVertexArrays(1, @VBTriangle.VAO);
  glBindVertexArray(VBTriangle.VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBTriangle.VBO);
  glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 0, nil);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(1, 3, GL_FLOAT, GL_FALSE, 0, TGLvoid(TriangleVectors.Size));
  glEnableVertexAttribArray(1);

  // Daten für das Quad
  glCreateBuffers(1, @VBQuad.VBO);
  glNamedBufferStorage(VBQuad.VBO, QuadVectors.Size + QuadColors.Size, nil, GL_DYNAMIC_STORAGE_BIT);
  glNamedBufferSubData(VBQuad.VBO, 0, QuadVectors.Size, PFace(QuadVectors));
  glNamedBufferSubData(VBQuad.VBO, QuadVectors.Size, QuadColors.Size, PFace(QuadColors));

  glGenVertexArrays(1, @VBQuad.VAO);
  glBindVertexArray(VBQuad.VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBO);
  glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 0, nil);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(1, 3, GL_FLOAT, GL_FALSE, 0, TGLvoid(QuadVectors.Size));
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
  glDrawArrays(GL_TRIANGLES, 0, TriangleVectors.Vector3DCount);

  // Zeichne Quadrat
  glBindVertexArray(VBQuad.VAO);
  glDrawArrays(GL_TRIANGLES, 0, QuadVectors.Vector3DCount);

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
