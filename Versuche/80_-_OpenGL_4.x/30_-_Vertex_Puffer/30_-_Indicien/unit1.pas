unit Unit1;

{$mode objfpc}{$H+}
{$modeswitch arrayoperators}


interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, Menus,
  dglOpenGL, oglVector, oglMatrix, oglContext, oglShader;

type

  { TForm1 }

  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
  private
    ogc: TContext;
    Shader: TShader; // Shader-Object
    procedure CreateVertex;
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
    EBO,
    VBO: GLuint;
  end;

var
  TriangleVectors: TglFloatArray = nil;
  TriangleColors: TglFloatArray = nil;
  TriangleIndices: array of TGLshort = nil;

  //QuadVectors: TglFloatArray = nil;
  //QuadColors: TglFloatArray = nil;
  //QuadIndices: array of TGLshort = nil;

  VBTriangle, VBQuad: TVB;

  //code+

procedure TForm1.CreateVertex;
const
  s = 0.6;
  Count = 1;
  si = 0.25;
var
  x, y, i: integer;
begin
  for x := -Count to Count do begin
    for y := -Count to Count do begin
      TriangleVectors.AddVector3f(x * s - si, y * s - si, 0);
      TriangleVectors.AddVector3f(x * s - si, y * s + si, 0);
      TriangleVectors.AddVector3f(x * s + si, y * s + si, 0);
      TriangleVectors.AddVector3f(x * s + si, y * s - si, 0);

      TriangleColors.AddVector3f(1, 0, 0);
      TriangleColors.AddVector3f(0, 1, 0);
      TriangleColors.AddVector3f(0, 0, 1);
      TriangleColors.AddVector3f(1, 0, 1);
    end;
  end;

  x := 0;
  for i := 0 to (Count * 2 + 1) * (Count * 2 + 1) - 1 do begin
    TriangleIndices += [x, x + 1, x + 2, x, x + 2, x + 3];
    Inc(x, 4);
  end;
end;

const
  QuadVector: array of TVector6f =
    ((-0.8, -0.8, 0.1, 0.5, 0.0, 0.0), (-0.8, 0.8, 0.1, 0.0, 0.5, 0.0), (0.8, 0.8, 0.1, 0.0, 0.0, 0.5),
    (-0.8, -0.8, 0.1, 0.5, 0.0, 0.0), (0.8, 0.8, 0.1, 0.0, 0.0, 0.5), (0.8, -0.8, 0.1, 0.5, 0.5, 0.0));


procedure TForm1.FormCreate(Sender: TObject);
begin
  //remove+
  Width := 340;
  Height := 240;
  //remove-

  CreateVertex;

  //  QuadVectors.AddFace3DArray(QuadVector);
  //  QuadColors.AddFace3DArray(QuadColor);

  Init_OpenGL;
end;

procedure TForm1.Init_OpenGL;
begin
  // --- Context erzeugen
  ogc := TContext.Create(Self);
  ogc.OnPaint := @ogcDrawScene;

  glClearColor(0.6, 0.6, 0.4, 1.0);                  // Hintergrundfarbe
  glEnable(GL_BLEND);                                // Alphablending an
  glEnable(GL_DEPTH_TEST);                           // Tiefenprüfung einschalten.
  glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA); // Sortierung der Primitiven von hinten nach vorne.

  // --- Shader laden
  Shader := TShader.Create([
    GL_VERTEX_SHADER, FileToStr('Vertexshader.glsl'),
    GL_FRAGMENT_SHADER, FileToStr('Fragmentshader.glsl')]);

  Shader.UseProgram;

  //   https://github.com/drew-diamantoukos/OpenGLBookExamples/blob/master/Projects/OpenGLBookExamples/Main.cpp

  // glMapBuffer

  // Daten für 9 Quadrats
  glGenVertexArrays(1, @VBTriangle.VAO);
  glBindVertexArray(VBTriangle.VAO);

  glCreateBuffers(1, @VBTriangle.VBO);
//  glNamedBufferData(VBTriangle.VBO, TriangleVectors.Size + TriangleColors.Size, nil, GL_STATIC_DRAW);
  glNamedBufferStorage(VBTriangle.VBO, TriangleVectors.Size + TriangleColors.Size, nil, GL_DYNAMIC_STORAGE_BIT);
  glNamedBufferSubData(VBTriangle.VBO, 0, TriangleVectors.Size, PFace(TriangleVectors));
  glNamedBufferSubData(VBTriangle.VBO, TriangleVectors.Size, TriangleColors.Size, PFace(TriangleColors));

  glBindBuffer(GL_ARRAY_BUFFER, VBTriangle.VBO);
  glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 0, nil);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(1, 3, GL_FLOAT, GL_FALSE, 0, PGLvoid(TriangleVectors.Size));
  glEnableVertexAttribArray(1);

  glCreateBuffers(1, @VBTriangle.EBO);
  glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, VBTriangle.EBO);
//  glNamedBufferData(VBTriangle.EBO, Length(TriangleIndices) * sizeof(TGLfloat), nil, GL_STATIC_DRAW);
  glNamedBufferStorage(VBTriangle.EBO, Length(TriangleIndices) * sizeof(TGLfloat), nil, GL_DYNAMIC_STORAGE_BIT);
  glNamedBufferSubData(VBTriangle.EBO, 0, Length(TriangleIndices) * sizeof(TGLfloat), PGLshort(TriangleIndices));

  // Daten für das Quad
  glGenVertexArrays(1, @VBQuad.VAO);
  glBindVertexArray(VBQuad.VAO);

  glCreateBuffers(1, @VBQuad.VBO);

  glNamedBufferStorage(VBQuad.VBO, Length(QuadVector) * SizeOf(TVector6f), PVector6f(QuadVector), GL_DYNAMIC_STORAGE_BIT);

  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBO);
  glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 24, nil);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(1, 3, GL_FLOAT, GL_FALSE, 24, PGLvoid(12));
  glEnableVertexAttribArray(1);
end;

//code-

//code+
procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
  Shader.UseProgram;

  // Zeichne 9 Quadrats
  glBindVertexArray(VBTriangle.VAO);
  glDrawElements(GL_TRIANGLES, Length(TriangleIndices), GL_UNSIGNED_SHORT, nil);

  // Zeichne Quadrat
  glBindVertexArray(VBQuad.VAO);
  glDrawArrays(GL_TRIANGLES, 0, Length(QuadVector));

  ogc.SwapBuffers;
end;

procedure TForm1.Destroy_OpenGL;
begin
  Shader.Free;

  glDeleteBuffers(1, @VBTriangle.VBO);
  glDeleteBuffers(1, @VBTriangle.EBO);

  glDeleteBuffers(1, @VBQuad.VBO);

  glDeleteVertexArrays(1, @VBTriangle.VAO);
  glDeleteVertexArrays(1, @VBQuad.VAO);
end;

//code-

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Destroy_OpenGL;
end;

procedure TForm1.MenuItem1Click(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to Length(TriangleColors) - 1 do begin
    TriangleColors[i] := Random;
  end;
  glNamedBufferSubData(VBTriangle.VBO, TriangleVectors.Size, TriangleColors.Size, PFace(TriangleColors));
  ogcDrawScene(Sender);
end;

procedure TForm1.MenuItem2Click(Sender: TObject);
var
  i, j: integer;
  vsize: SizeInt;

  v:Pointer;

  // https://learnopengl.com/Advanced-OpenGL/Advanced-Data
  // https://www.reddit.com/r/opengl/comments/aifvjl/glnamedbufferstorage_vs_glbufferdata/
begin
  for i := 0 to Length(QuadVector) - 1 do begin
    for j := 3 to 5 do begin
      QuadVector[i, j] := Random;
    end;
  end;
  QuadVector[0, 3] := 1;
  QuadVector[0, 4] := 1;
  QuadVector[0, 5] := 1;
  QuadVector[1, 3] := 1;
  QuadVector[1, 4] := 1;
  QuadVector[1, 5] := 1;
  QuadVector[2, 3] := 1;
  QuadVector[2, 4] := 1;
  QuadVector[2, 5] := 1;

  vsize := Length(QuadVector) * SizeOf(TVector6f);
  glNamedBufferSubData(VBQuad.VBO, 0, vsize, PVector6f(QuadVector));
  glNamedBufferSubData(VBQuad.VBO, SizeOf(TVector3f), vsize, PVector6f(QuadVector));

  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBO);
  v:=glMapNamedBuffer(GL_ARRAY_BUFFER, GL_READ_ONLY);
//
  WriteLn(PtrUInt(v));
////  v[0, 3]:=1;
////  v[0, 4]:=1;
////  v[0, 5]:=1;
//
  glUnmapBuffer(GL_ARRAY_BUFFER);


  ogcDrawScene(Sender);
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
