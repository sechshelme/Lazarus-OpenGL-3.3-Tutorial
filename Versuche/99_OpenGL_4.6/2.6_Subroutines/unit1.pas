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

function TypeSize(typ:TGLenum):SizeInt;

begin
  case typ of
  GL_FLOAT:  Result:=1*SizeOf(TGLfloat);
  GL_FLOAT_VEC2:  Result:=2*SizeOf(TGLfloat);
  GL_FLOAT_VEC3:  Result:=3*SizeOf(TGLfloat);
  GL_FLOAT_VEC4:  Result:=4*SizeOf(TGLfloat);

  GL_INT:  Result:=1*SizeOf(TGLint);
  GL_INT_VEC2:  Result:=2*SizeOf(TGLint);
  GL_INT_VEC3:  Result:=3*SizeOf(TGLint);
  GL_INT_VEC4:  Result:=4*SizeOf(TGLint);

  GL_UNSIGNED_INT:  Result:=1*SizeOf(TGLuint);
  GL_UNSIGNED_INT_VEC2:  Result:=2*SizeOf(TGLuint);
  GL_UNSIGNED_INT_VEC3:  Result:=3*SizeOf(TGLuint);
  GL_UNSIGNED_INT_VEC4:  Result:=4*SizeOf(TGLuint);

  GL_BOOL:  Result:=1*SizeOf(TGLboolean);
  GL_BOOL_VEC2:  Result:=2*SizeOf(TGLboolean);
  GL_BOOL_VEC3:  Result:=3*SizeOf(TGLboolean);
  GL_BOOL_VEC4:  Result:=4*SizeOf(TGLboolean);

  GL_FLOAT_MAT2:  Result:=4*SizeOf(TGLfloat);
  GL_FLOAT_MAT2x3:  Result:=6*SizeOf(TGLfloat);
  GL_FLOAT_MAT2x4:  Result:=8*SizeOf(TGLfloat);

  GL_FLOAT_MAT3:  Result:=9*SizeOf(TGLfloat);
  GL_FLOAT_MAT3x2:  Result:=6*SizeOf(TGLfloat);
  GL_FLOAT_MAT3x4:  Result:=12*SizeOf(TGLfloat);

  GL_FLOAT_MAT4:  Result:=16*SizeOf(TGLfloat);
  GL_FLOAT_MAT4x2:  Result:=8*SizeOf(TGLfloat);
  GL_FLOAT_MAT4x3:  Result:=12*SizeOf(TGLfloat);
  else WriteLn('Ungültiger Typ !');
  end;
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
  matrix_strides: array[0..NumUniforms - 1] of GLuint;
  array_strides: array[0..NumUniforms - 1] of GLuint;
  i: integer;


  matrialShaderLoc:TGLint;
  ambientIndex: TGLuint;
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
  glGetActiveUniformsiv(Shader.ID, NumUniforms, indices, GL_UNIFORM_ARRAY_STRIDE, @array_strides);
  glGetActiveUniformsiv(Shader.ID, NumUniforms, indices, GL_UNIFORM_MATRIX_STRIDE, @matrix_strides);

  WriteLn('uboSize: ', uboSize);
  for i := 0 to NumUniforms - 1 do begin
    WriteLn('indicies: ', indices[i]: 4,' ofs: ', offset[i]: 4, ' Array_Size: ', size[i]: 4, ' Size: ', size[i]*TypeSize(type_[i]): 4,' type:', type_[i]: 6);
    WriteLn('array_strides: ', array_strides[i]: 4, ' mat_strides: ', matrix_strides[i]: 4);
    WriteLn();
  end;

  //  memcpy(buffer, @UBORec.translation, 48);
  //  memcpy(buffer + 12, @UBORec.scale, 4);

  move(UBORec.translation, buffer[offset[0]], SizeOf(TUBORec.translation));
  move(UBORec.scale, buffer[offset[1]], SizeOf(TUBORec.scale));
  move(UBORec.rotation, buffer[offset[2]], SizeOf(TUBORec.rotation));
  move(UBORec.Enabled, buffer[offset[2]], SizeOf(TUBORec.Enabled));

  glGenBuffers(1, @ubo);
  glBindBuffer(GL_UNIFORM_BUFFER, ubo);
  glBufferData(GL_UNIFORM_BUFFER, uboSize, buffer, GL_STATIC_DRAW);
  glBindBufferBase(GL_UNIFORM_BUFFER, uboIndex, ubo);

  Freemem(buffer);


  matrialShaderLoc:=glGetSubroutineUniformLocation(Shader.ID,GL_VERTEX_SHADER,'materialShader');
  if matrialShaderLoc<0 then WriteLn('Fehler: materialShader');

  ambientIndex:=glGetSubroutineIndex(Shader.ID, GL_VERTEX_SHADER,'ambient');

  if ambientIndex=GL_INVALID_INDEX then WriteLn('Fehler: ambient');



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
