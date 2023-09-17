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

  //  extern void *memcpy (void *__restrict __dest, const void *__restrict __src,           size_t __n) __THROW __nonnull ((1, 2));

procedure memcpy(dest, src: Pointer; size: SizeInt); cdecl; external 'c';


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
type
  TUBORec = record
    scale: TGLfloat;
    translation: TVector3f;
    rotation: TVector4f;
    Enabled: TGLboolean;
  end;
const
  UBORec: TUBORec = (
    scale: 0.5;
    translation: (0.1, 0.1, 0.0);
    rotation: (90, 0, 0, 1);
    Enabled: True);

  tranlation: TVector3f = (0.1, 0.1, 0.0);
  names: array of PChar = ('translation', 'scale', 'rotation', 'enabled');
  NumUniforms = 4;
var
  uboIndex: TGLuint;
  uboSize: TGLint;
  ubo: TGLuint;
  buffer: PChar;

  indices: array[0..NumUniforms - 1] of GLuint;
  offset: array[0..NumUniforms - 1] of GLuint;
  size: array[0..NumUniforms - 1] of GLuint;
  type_: array[0..NumUniforms - 1] of GLuint;
  i: integer;
begin
  glClearColor(1, 0, 0, 1);

  glCreateBuffers(Buffer_IDs_NumBuffers, Buffers);
  glNamedBufferStorage(Buffers[Buffer_IDs_ArrayBuffer], SizeOf(vertices), @vertices, 0);

  Shader := TShader.Create([FileToStr('Vertexshader.glsl'), FileToStr('Fragmentshader.glsl')]);
  Shader.UseProgram;

  // --- uniform
  uboIndex := glGetUniformBlockIndex(Shader.ID, 'Uniforms');
  glGetActiveUniformBlockiv(Shader.ID, uboIndex, GL_UNIFORM_BLOCK_DATA_SIZE, @uboSize);
  Getmem(buffer, uboSize);
  if buffer = nil then begin
    WriteLn('Unable to allocate buffer');
    halt(1);
  end;

  glGetUniformIndices(Shader.ID, NumUniforms, PPChar(names), indices);

  glGetActiveUniformsiv(Shader.ID, NumUniforms, indices, GL_UNIFORM_OFFSET, @offset);
  glGetActiveUniformsiv(Shader.ID, NumUniforms, indices, GL_UNIFORM_SIZE, @size);
  glGetActiveUniformsiv(Shader.ID, NumUniforms, indices, GL_UNIFORM_TYPE, @type_);

  WriteLn('uboSize: ', uboSize);
  for i := 0 to NumUniforms - 1 do begin
    WriteLn('ofs: ', offset[i]: 8, '  size: ', size[i]: 8, '  type:', type_[i]: 8);
  end;

  //  memcpy(buffer, @UBORec.translation, 48);
  //  memcpy(buffer + 12, @UBORec.scale, 4);

  move(UBORec.translation, buffer[offset[0]], SizeOf(TUBORec.translation));
  move(UBORec.scale, buffer[offset[1]], SizeOf(TUBORec.scale));
  //  move(UBORec.rotation, buffer[12], 4);
  //  move(UBORec.Enabled, buffer[12], 4);

  glGenBuffers(1, @ubo);
  glBindBuffer(GL_UNIFORM_BUFFER, ubo);
  glBufferData(GL_UNIFORM_BUFFER, uboSize, buffer, GL_STATIC_DRAW);
  glBindBufferBase(GL_UNIFORM_BUFFER, uboIndex, ubo);




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
