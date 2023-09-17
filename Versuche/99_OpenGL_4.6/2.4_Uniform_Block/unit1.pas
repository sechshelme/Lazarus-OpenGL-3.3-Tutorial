unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  dglOpenGL,
  oglContext, oglVector, oglMatrix, oglShader;

type
  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    ogc: TContext;
    Shader: TShader;
    procedure CreateScene;
    procedure ogcDrawScene(Sender: TObject);
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

const
  VAO_IDs_Trinagles = 0;
  VAO_IDs_NUMVAOs = 1;

  Buffer_IDs_ArrayBuffer = 0;
  Buffer_IDs_NumBuffers = 1;

  Attrib_IDs_vPosition = 0;

var
  VAOs: array[0..VAO_IDs_NUMVAOs - 1] of GLuint;
  Buffers: array[0..Buffer_IDs_NumBuffers - 1] of GLuint;

const
  NumVertices = 6;

const
  vertices: array [0..NumVertices - 1] of TVector2f = (
    (-0.90, -0.90), // Triangle 1
    (0.85, -0.90),
    (-0.90, 0.85),
    (0.90, -0.85), // Triangle 2
    (0.90, 0.90),
    (-0.85, 0.90));


procedure TForm1.FormCreate(Sender: TObject);
begin
  Width := 340;
  Height := 240;
  ogc := TContext.Create(Self);
  ogc.OnPaint := @ogcDrawScene;

  CreateScene;
end;

procedure TForm1.CreateScene;
const
  tranlation:TVector3f=(0.1,0.1,0.0);
  names:array of PChar=('tramslation','scale','rotation','enabled');
  NumUniforms=1;
var
  uboIndex: TGLuint;
  uboSize: TGLint;
  buffer: TGLvoid;

  indices :array[0..NumUniforms-1] of GLuint;
  offset :array[0..NumUniforms-1] of GLuint;
begin
  glClearColor(1, 0, 0, 1);

  glCreateBuffers(Buffer_IDs_NumBuffers, Buffers);
  glNamedBufferStorage(Buffers[Buffer_IDs_ArrayBuffer], SizeOf(vertices), @vertices, 0);

  Shader := TShader.Create([FileToStr('Vertexshader.glsl'), FileToStr('Fragmentshader.glsl')]);
  Shader.UseProgram;

  // --- uniform
  uboIndex := glGetUniformBlockIndex(Shader.ID, 'Uniforms');
  glGetActiveUniformBlockiv(Shader.ID, uboIndex, GL_UNIFORM_BLOCK_DATA_SIZE, @uboSize);

  glGetActiveUniformsiv(Shader.ID, NumUniforms, indices,GL_UNIFORM_OFFSET, offset);

  Getmem(buffer, uboSize);
  if buffer = nil then begin
    WriteLn('Unable to allocate buffer');
    halt(1);
  end;


  WriteLn(uboSize);



  // --- Vertex
  glGenVertexArrays(VAO_IDs_NUMVAOs, VAOs);
  glBindVertexArray(VAOs[VAO_IDs_Trinagles]);
  glBindBuffer(GL_ARRAY_BUFFER, Buffers[Buffer_IDs_ArrayBuffer]);
  glVertexAttribPointer(Attrib_IDs_vPosition, 2, GL_FLOAT, GL_FALSE, 0, nil);
  glEnableVertexAttribArray(Attrib_IDs_vPosition);
end;

procedure TForm1.ogcDrawScene(Sender: TObject);
const
  black: TVector4f = (0, 0, 0, 0);
begin
  glClearBufferfv(GL_COLOR, 0, black);

  glBindVertexArray(VAOs[VAO_IDs_Trinagles]);
  glDrawArrays(GL_TRIANGLES, 0, NumVertices);

  ogc.SwapBuffers;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Shader.Free;
end;

(*
<b>Vertex-Shader:</b>
*)
//includeglsl Vertexshader.glsl
//lineal

(*
<b>Fragment-Shader:</b>

Hier wird der Tiefenwert korrigiert.
*)
//includeglsl Fragmentshader.glsl

end.
