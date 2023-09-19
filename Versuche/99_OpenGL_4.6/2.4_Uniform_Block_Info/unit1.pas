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
  vertices: array of TVector2f = (
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

function TypeSize(typ: TGLenum): SizeInt;

begin
  case typ of
    GL_FLOAT: begin
      Result := 1 * SizeOf(TGLfloat);
    end;
    GL_FLOAT_VEC2: begin
      Result := 2 * SizeOf(TGLfloat);
    end;
    GL_FLOAT_VEC3: begin
      Result := 3 * SizeOf(TGLfloat);
    end;
    GL_FLOAT_VEC4: begin
      Result := 4 * SizeOf(TGLfloat);
    end;

    GL_INT: begin
      Result := 1 * SizeOf(TGLint);
    end;
    GL_INT_VEC2: begin
      Result := 2 * SizeOf(TGLint);
    end;
    GL_INT_VEC3: begin
      Result := 3 * SizeOf(TGLint);
    end;
    GL_INT_VEC4: begin
      Result := 4 * SizeOf(TGLint);
    end;

    GL_UNSIGNED_INT: begin
      Result := 1 * SizeOf(TGLuint);
    end;
    GL_UNSIGNED_INT_VEC2: begin
      Result := 2 * SizeOf(TGLuint);
    end;
    GL_UNSIGNED_INT_VEC3: begin
      Result := 3 * SizeOf(TGLuint);
    end;
    GL_UNSIGNED_INT_VEC4: begin
      Result := 4 * SizeOf(TGLuint);
    end;

    GL_BOOL: begin
      Result := 1 * SizeOf(TGLboolean);
    end;
    GL_BOOL_VEC2: begin
      Result := 2 * SizeOf(TGLboolean);
    end;
    GL_BOOL_VEC3: begin
      Result := 3 * SizeOf(TGLboolean);
    end;
    GL_BOOL_VEC4: begin
      Result := 4 * SizeOf(TGLboolean);
    end;

    GL_FLOAT_MAT2: begin
      Result := 4 * SizeOf(TGLfloat);
    end;
    GL_FLOAT_MAT2x3: begin
      Result := 6 * SizeOf(TGLfloat);
    end;
    GL_FLOAT_MAT2x4: begin
      Result := 8 * SizeOf(TGLfloat);
    end;

    GL_FLOAT_MAT3: begin
      Result := 9 * SizeOf(TGLfloat);
    end;
    GL_FLOAT_MAT3x2: begin
      Result := 6 * SizeOf(TGLfloat);
    end;
    GL_FLOAT_MAT3x4: begin
      Result := 12 * SizeOf(TGLfloat);
    end;

    GL_FLOAT_MAT4: begin
      Result := 16 * SizeOf(TGLfloat);
    end;
    GL_FLOAT_MAT4x2: begin
      Result := 8 * SizeOf(TGLfloat);
    end;
    GL_FLOAT_MAT4x3: begin
      Result := 12 * SizeOf(TGLfloat);
    end;
    else begin
      WriteLn('Ungültiger Typ !');
    end;
  end;
end;

procedure TForm1.CreateScene;
type
  TUBORec = record
    translation: TVector3f;
    scale: TGLfloat;
    rotation: TVector4f;
    Enabled: TGLboolean;
  end;
const
  UBORec: TUBORec = (
    translation: (0.1, 0.1, 0.0);
    scale: 0.5;
    rotation: (90, 0, 0, 1);
    Enabled: True);

var
  uboIndex: TGLuint;
  uboSize: TGLint;
  ubo: TGLuint;

  maxUniLength, activeUnif, dataSize, actualLen, Count: TGLint;
  BlockName: array of char = nil;
  UniformName: array of char = nil;
  indices2: array of TGLint = nil;

  UniformInfo: record
    offset: TGLuint;
    size: TGLuint;
    type_: TGLuint;
    matrix_strides: TGLuint;
    array_strides: TGLuint;
      end;
  i, k: integer;
  indice: GLint;
begin
//  glClearColor(1, 0, 0, 1);

  Shader := TShader.Create([FileToStr('Vertexshader.glsl'), FileToStr('Fragmentshader.glsl')]);
  Shader.UseProgram;

  // --- Uniform-Blöcke auslesen
  glGetProgramiv(Shader.ID, GL_ACTIVE_UNIFORM_MAX_LENGTH, @maxUniLength);
  SetLength(UniformName, maxUniLength);
  Writeln('  maxlength: ', maxUniLength);

  glGetProgramiv(Shader.ID, GL_ACTIVE_UNIFORM_BLOCKS, @Count);

  WriteLn('Block Uniform Count: ', Count);
  for i := 0 to Count - 1 do begin
    glGetActiveUniformBlockiv(Shader.ID, i, GL_UNIFORM_BLOCK_NAME_LENGTH, @actualLen);
    Write('len: ', actualLen);
    SetLength(BlockName, actualLen);
    glGetActiveUniformBlockName(Shader.ID, i, actualLen, nil, PChar(BlockName));
    WriteLn('  Block-Name: ', PChar(BlockName));

    glGetActiveUniformBlockiv(Shader.ID, i, GL_UNIFORM_BLOCK_DATA_SIZE, @dataSize);
    Write('Data-Size: ', dataSize);

    glGetActiveUniformBlockiv(Shader.ID, i, GL_UNIFORM_BLOCK_ACTIVE_UNIFORMS, @activeUnif);
    Writeln('  Uniforms/Block: ', activeUnif);

    SetLength(indices2, activeUnif);
    glGetActiveUniformBlockiv(Shader.ID, i, GL_UNIFORM_BLOCK_ACTIVE_UNIFORM_INDICES, PGLint(indices2));

    for k := 0 to activeUnif - 1 do begin
      indice := indices2[k];
      glGetActiveUniformName(Shader.ID, indice, maxUniLength, @actualLen, PChar(UniformName));
      Write('  Uniform-Name: ', PChar(UniformName));

      with UniformInfo do begin
        glGetActiveUniformsiv(Shader.ID, 1, @indice, GL_UNIFORM_OFFSET, @offset);
        glGetActiveUniformsiv(Shader.ID, 1, @indice, GL_UNIFORM_SIZE, @size);
        glGetActiveUniformsiv(Shader.ID, 1, @indice, GL_UNIFORM_TYPE, @type_);
        glGetActiveUniformsiv(Shader.ID, 1, @indice, GL_UNIFORM_ARRAY_STRIDE, @array_strides);
        glGetActiveUniformsiv(Shader.ID, 1, @indice, GL_UNIFORM_MATRIX_STRIDE, @matrix_strides);

        Write('  indicie: ', indice: 4, ' ofs: ', offset: 4, ' Array_Size: ', size: 4, ' Size: ', size * TypeSize(type_): 4, ' type:', type_: 6);
        Write('  array_strides: ', array_strides: 4, ' mat_strides: ', matrix_strides: 4);
        WriteLn();
      end;
    end;
  end;

  // --- UBO
  uboIndex := glGetUniformBlockIndex(Shader.ID, 'Uniforms');
  glGetActiveUniformBlockiv(Shader.ID, uboIndex, GL_UNIFORM_BLOCK_DATA_SIZE, @uboSize);
  WriteLn('uboSize: ', uboSize);

  glGenBuffers(1, @ubo);
  glBindBuffer(GL_UNIFORM_BUFFER, ubo);
  glBufferData(GL_UNIFORM_BUFFER, uboSize, @UBORec, GL_STATIC_DRAW);
  glBindBufferBase(GL_UNIFORM_BUFFER, uboIndex, ubo);

  // --- Vertex
  glCreateBuffers(Buffer_IDs_NumBuffers, Buffers);
  glNamedBufferStorage(Buffers[Buffer_IDs_ArrayBuffer], Length(vertices) * SizeOf(vertices), PGLvoid(vertices), 0);

  glGenVertexArrays(VAO_IDs_NUMVAOs, VAOs);
  glBindVertexArray(VAOs[VAO_IDs_Trinagles]);
  glBindBuffer(GL_ARRAY_BUFFER, Buffers[Buffer_IDs_ArrayBuffer]);
  glVertexAttribPointer(Attrib_IDs_vPosition, 2, GL_FLOAT, GL_FALSE, 0, nil);
  glEnableVertexAttribArray(Attrib_IDs_vPosition);
end;

procedure TForm1.ogcDrawScene(Sender: TObject);
const
  black: TVector4f = (0.3, 0, 0.3, 0);
begin
  glClearBufferfv(GL_COLOR, 0, black);

  glBindVertexArray(VAOs[VAO_IDs_Trinagles]);
  glDrawArrays(GL_TRIANGLES, 0, Length(vertices));

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
