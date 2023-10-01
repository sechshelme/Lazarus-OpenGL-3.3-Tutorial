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
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    ogc: TContext;
    Shader: TShader; // Shader-Object
    procedure CreateVertex;
    procedure Init_OpenGL;
    procedure ogcDrawScene(Sender: TObject);
    procedure Destroy_OpenGL;
    procedure ogcKeyPress(Sender: TObject; var Key: char);
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
  Quad9Vectors: TglFloatArray = nil;
  Quad9Colors: TglFloatArray = nil;
  Quad9Indices: array of TGLshort = nil;

  UBO: TGLuint;
  VB9Quad, VBQuad: TVB;

var
  uboIndex: TGLuint;
  uboSize: TGLint;

type
  TUBORec = record
    translation: TVector3f;
    scale: TGLfloat;
    rotation: TVector4f;
    Enabled: TGLboolean;
  end;

const
  UBORec9Quad: TUBORec = (
    translation: (0.2, 0.0, 0.0);
    scale: 1.0;
    rotation: (0, 0, 0, 1);
    Enabled: True);

  UBORecQuad: TUBORec = (
    translation: (-0.3, 0.1, 0.0);
    scale: 0.5;
    rotation: (90, 0, 0, 1);
    Enabled: True);

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
      Quad9Vectors.AddVector3f(x * s - si, y * s - si, 0);
      Quad9Vectors.AddVector3f(x * s - si, y * s + si, 0);
      Quad9Vectors.AddVector3f(x * s + si, y * s + si, 0);
      Quad9Vectors.AddVector3f(x * s + si, y * s - si, 0);

      Quad9Colors.AddVector3f(1, 0, 0);
      Quad9Colors.AddVector3f(0, 1, 0);
      Quad9Colors.AddVector3f(0, 0, 1);
      Quad9Colors.AddVector3f(1, 0, 1);
    end;
  end;

  x := 0;
  for i := 0 to (Count * 2 + 1) * (Count * 2 + 1) - 1 do begin
    Quad9Indices += [x, x + 1, x + 2, x, x + 2, x + 3];
    Inc(x, 4);
  end;
end;

const
  QuadVector: array of TVector6f =
    ((-0.8, -0.8, 0.1, 0.5, 0.0, 0.0), (-0.8, 0.8, 0.1, 0.0, 0.5, 0.0), (0.8, 0.8, 0.1, 0.0, 0.0, 0.5),
    (-0.8, -0.8, 0.1, 0.5, 0.0, 0.0), (0.8, 0.8, 0.1, 0.0, 0.0, 0.5), (0.8, -0.8, 0.1, 0.5, 0.5, 0.0));

  // https://github.com/drew-diamantoukos/OpenGLBookExamples/blob/master/Projects/OpenGLBookExamples/Main.cpp
  // https://blog.csdn.net/yuxiaohen/article/details/50551232


procedure TForm1.FormCreate(Sender: TObject);
begin
  //remove+
  Width := 340;
  Height := 240;
  //remove-

  CreateVertex;

  Init_OpenGL;
  InitOpenGLDebug;

  ogc.OnKeyPress := @ogcKeyPress;
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

  uboIndex := glGetUniformBlockIndex(Shader.ID, 'Uniforms');

  // --- UBO
  glCreateBuffers(1, @UBO);
  glNamedBufferData(UBO, SizeOf(UBORec9Quad), nil, GL_STATIC_DRAW);
  glNamedBufferSubData(UBO, 0, SizeOf(UBORec9Quad), @UBORec9Quad);
  glBindBufferBase(GL_UNIFORM_BUFFER, uboIndex, UBO);


  // --- Daten für 9 Quadrats
  glCreateBuffers(1, @VB9Quad.VBO);
  //  glNamedBufferData(VB9Quad.VBO, Quad9Vectors.Size + Quad9Colors.Size, nil, GL_STATIC_DRAW);
  glNamedBufferStorage(VB9Quad.VBO, Quad9Vectors.Size + Quad9Colors.Size, nil, GL_DYNAMIC_STORAGE_BIT);
  glNamedBufferSubData(VB9Quad.VBO, 0, Quad9Vectors.Size, PFace(Quad9Vectors));
  glNamedBufferSubData(VB9Quad.VBO, Quad9Vectors.Size, Quad9Colors.Size, PFace(Quad9Colors));

//  glBindBufferRange;

  glGenVertexArrays(1, @VB9Quad.VAO);
  glBindVertexArray(VB9Quad.VAO);

  // Vektoren
  glVertexAttribBinding(0, 0);
  glVertexAttribFormat(0, 3, GL_FLOAT, GL_FALSE, 0);
  glEnableVertexAttribArray(0);

  glVertexAttribBinding(1, 0);
  glVertexAttribFormat(1, 3, GL_FLOAT, GL_FALSE, Quad9Vectors.Size);
  glEnableVertexAttribArray(1);

  glBindVertexBuffer(0, VB9Quad.VBO, 0, SizeOf(TVector3f));

  // ArrayElement
  glCreateBuffers(1, @VB9Quad.EBO);
  glNamedBufferData(VB9Quad.EBO, Length(Quad9Indices) * SizeOf(TGLshort), nil, GL_STATIC_DRAW);
  glNamedBufferSubData(VB9Quad.EBO, 0, Length(Quad9Indices) * sizeof(TGLshort), PGLshort(Quad9Indices));
  glVertexArrayElementBuffer(VB9Quad.VAO, VB9Quad.EBO);


  // --- Daten für das Quad
  glCreateBuffers(1, @VBQuad.VBO);
  glNamedBufferStorage(VBQuad.VBO, Length(QuadVector) * SizeOf(TVector6f), PVector6f(QuadVector), GL_MAP_WRITE_BIT);

  glGenVertexArrays(1, @VBQuad.VAO);
  glBindVertexArray(VBQuad.VAO);

  glVertexAttribBinding(0, 0);
  glVertexAttribFormat(0, 3, GL_FLOAT, GL_FALSE, 0);
  glEnableVertexAttribArray(0);

  glVertexAttribBinding(1, 0);
  glVertexAttribFormat(1, 3, GL_FLOAT, GL_FALSE, 12);
  glEnableVertexAttribArray(1);

  glBindVertexBuffer(0, VBQuad.VBO, 0, 24);
end;

//code-

//code+
procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
  Shader.UseProgram;

  // Zeichne 9 Quadrats
  glBindVertexArray(VB9Quad.VAO);
  glNamedBufferSubData(UBO, 0, SizeOf(UBORec9Quad), @UBORec9Quad);
  glDrawElements(GL_TRIANGLES, Length(Quad9Indices), GL_UNSIGNED_SHORT, nil);

  // Zeichne Quadrat
  glBindVertexArray(VBQuad.VAO);
  glNamedBufferSubData(UBO, 0, SizeOf(UBORecQuad), @UBORecQuad);
  glDrawArrays(GL_TRIANGLES, 0, Length(QuadVector));

  ogc.SwapBuffers;
end;

procedure TForm1.Destroy_OpenGL;
begin
  Shader.Free;

  glDeleteBuffers(1, @VB9Quad.VBO);
  glDeleteBuffers(1, @VB9Quad.EBO);

  glDeleteBuffers(1, @VBQuad.VBO);

  glDeleteBuffers(1, @UBO);

  glDeleteVertexArrays(1, @VB9Quad.VAO);
  glDeleteVertexArrays(1, @VBQuad.VAO);
end;

// https://learnopengl.com/Advanced-OpenGL/Advanced-Data
// https://www.reddit.com/r/opengl/comments/aifvjl/glnamedbufferstorage_vs_glbufferdata/

procedure TForm1.ogcKeyPress(Sender: TObject; var Key: char);
var
  i: integer;
  v: PVector6f;
begin
  case key of
    #27: begin
      Close;
    end;
    '1': begin
      for i := 0 to Length(Quad9Colors) - 1 do begin
        Quad9Colors[i] := Random;
      end;
      glNamedBufferSubData(VB9Quad.VBO, Quad9Vectors.Size, Quad9Colors.Size, PFace(Quad9Colors));
      ogcDrawScene(Sender);
    end;
    '2': begin
      v := glMapNamedBuffer(VBQuad.VBO, GL_WRITE_ONLY);
      if v <> nil then begin
        //
        v[0, 3] := 1;
        v[0, 4] := 1;
        v[0, 5] := 1;
        glUnmapBuffer(GL_ARRAY_BUFFER);
      end;
      //  glTransformFeedbackVaryings:=;

// https://registry.khronos.org/OpenGL-Refpages/gl4/html/glCopyBufferSubData.xhtml
    end;
  end;
  ogcDrawScene(Sender);
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
