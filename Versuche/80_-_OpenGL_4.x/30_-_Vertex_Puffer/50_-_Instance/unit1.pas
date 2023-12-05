unit Unit1;

{$mode objfpc}{$H+}
{$modeswitch arrayoperators}


interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, Menus,
  dglOpenGL, oglVector, oglVectors, oglMatrix, oglContext, oglShader, oglDebug;

type

  { TForm1 }

  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    ogc: TContext;
    Shader: TShader; // Shader-Object
    procedure CreateInstance;
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

var
  Mesh_Buffers: array [(EBO, IEBO, VBO, UBO)] of TGLuint;
  VAO: TGLuint;
  QuadInstance: TVectors2f = nil;

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

procedure TForm1.CreateInstance;
const
  s = 0.26;
  Count = 2;
var
  x, y: integer;
begin
  for x := -Count to Count do begin
    for y := -Count to Count do begin
      QuadInstance.Add([x * s, y * s]);
    end;
  end;
end;

const
  QuadVector: array of TVector6f = (
    (-0.2, -0.2, 0.1, 0.5, 0.0, 0.0), (0.2, -0.2, 0.1, 0.0, 0.5, 0.0),
    (0.2, 0.2, 0.1, 0.0, 0.0, 0.5), (-0.2, 0.2, 0.1, 0.5, 0.0, 0.0));

  QuadIndices: array of TGLuint = (0, 1, 2, 0, 2, 3);


procedure TForm1.FormCreate(Sender: TObject);
begin
  //remove+
  Width := 340;
  Height := 240;
  //remove-

  CreateInstance;

  Init_OpenGL;
  InitOpenGLDebug;

  ogc.OnKeyPress := @ogcKeyPress;
end;

procedure TForm1.Init_OpenGL;
var
  uboIndex: TGLuint;
begin
  // --- Context erzeugen
  ogc := TContext.Create(Self);
  ogc.OnPaint := @ogcDrawScene;

  glClearColor(0.6, 0.6, 0.4, 1.0);                  // Hintergrundfarbe
  glEnable(GL_BLEND);                                // Alphablending an
  glEnable(GL_DEPTH_TEST);                           // Tiefenprüfung einschalten.
  glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA); // Sortierung der Primitiven von hinten nach vorne.

  // --- Shader laden
  Shader := TShader.Create;
  Shader.LoadShaderObjectFromFile(GL_VERTEX_SHADER, 'Vertexshader.glsl');
  Shader.LoadShaderObjectFromFile(GL_FRAGMENT_SHADER, 'Fragmentshader.glsl');
  Shader.LinkProgramm;
  Shader.UseProgram;

  uboIndex := glGetUniformBlockIndex(Shader.ID, 'Uniforms');

  // Buffer reservieren
  glCreateBuffers(Length(Mesh_Buffers), Mesh_Buffers);

  // --- UBO
  glNamedBufferData(Mesh_Buffers[UBO], SizeOf(UBORec9Quad), nil, GL_DYNAMIC_DRAW);
  glNamedBufferSubData(Mesh_Buffers[UBO], 0, SizeOf(UBORec9Quad), @UBORec9Quad);
  glBindBufferBase(GL_UNIFORM_BUFFER, uboIndex, Mesh_Buffers[UBO]);

  // --- Daten für das Quad
  glGenVertexArrays(1, @VAO);
  glBindVertexArray(VAO);

  // Attribute Vektor und Color
  glNamedBufferStorage(Mesh_Buffers[VBO], Length(QuadVector) * SizeOf(TVector6f), PVector6f(QuadVector), GL_DYNAMIC_STORAGE_BIT);

  glVertexAttribBinding(0, 0);
  glVertexAttribFormat(0, 3, GL_FLOAT, GL_FALSE, 0);
  glEnableVertexAttribArray(0);
  glBindVertexBuffer(0, Mesh_Buffers[VBO], 0, 24);

  glVertexAttribBinding(1, 1);
  glVertexAttribFormat(1, 3, GL_FLOAT, GL_FALSE, 12);
  glEnableVertexAttribArray(1);
  glBindVertexBuffer(1, Mesh_Buffers[VBO], 0, 24);

  // ArrayElement
  glNamedBufferData(Mesh_Buffers[EBO], Length(QuadIndices) * SizeOf(TGLuint), PGLshort(QuadIndices), GL_STATIC_DRAW);
  glVertexArrayElementBuffer(VAO, Mesh_Buffers[EBO]);

  // Instance
  glNamedBufferData(Mesh_Buffers[IEBO], QuadInstance.Size, PGLint(QuadInstance), GL_STATIC_DRAW);

  // https://stackoverflow.com/questions/52993262/vao-drawing-the-wrong-index-buffer
  // https://stackoverflow.com/questions/62005944/trouble-with-glvertexarrayvertexbuffer-glvertexarrayattribformat-in-differ
  // https://registry.khronos.org/OpenGL/extensions/ARB/ARB_vertex_attrib_binding.txt

  // https://learnopengl.com/Advanced-OpenGL/Advanced-Data
  // https://www.reddit.com/r/opengl/comments/aifvjl/glnamedbufferstorage_vs_glbufferdata/

  glVertexAttribFormat(10, 2, GL_FLOAT, GL_FALSE, 0);
  glVertexAttribDivisor(10, 1);
  glEnableVertexAttribArray(10);

  glBindVertexBuffer(10, Mesh_Buffers[IEBO], 0, 8);

  glBindVertexArray(0);
end;

//code-

//code+
procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
  Shader.UseProgram;

  // Zeichne Quadrat
  glBindVertexArray(VAO);
  glNamedBufferSubData(Mesh_Buffers[UBO], 0, SizeOf(UBORecQuad), @UBORecQuad);
  glDrawElementsInstanced(GL_TRIANGLES, Length(QuadIndices), GL_UNSIGNED_INT, nil, QuadInstance.Count);

  ogc.SwapBuffers;
end;

procedure TForm1.Destroy_OpenGL;
begin
  Shader.Free;

  glDeleteBuffers(Length(Mesh_Buffers), Mesh_Buffers);
  glDeleteVertexArrays(1, @VAO);
end;

procedure TForm1.ogcKeyPress(Sender: TObject; var Key: char);
begin
  case key of
    #27: begin
      Close;
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
