unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls,
  oglglad_gl, oglDebug, oglShader,

  shaderc,
  env,
  status,


  oglContext;

const
  libclib = 'c';

function calloc(num, size: Tsize_t): Pointer; cdecl; external libclib;
function malloc(size: Tsize_t): Pointer; cdecl; external libclib;
procedure free(p: Pointer); cdecl; external libclib;

function memcpy(dest, src: Pointer; n: SizeUInt): Pointer; cdecl; external libclib;
function memchr(ptr: Pointer; value: integer; num: SizeUInt): Pointer; cdecl; external libclib;
function memcmp(ptr1, ptr2: Pointer; num: SizeUInt): integer; cdecl; external libclib;
function memset(ptr: Pointer; value: integer; num: SizeUInt): Pointer; cdecl; external libclib;

function strlen(str: pchar): Tsize_t; cdecl; external libclib;
function strdup(str: pchar): pchar; cdecl; external libclib;
function strcmp(str1, str2: pchar): integer; cdecl; external libclib;

function printf(__format: pchar): longint; cdecl; varargs; external libclib;


type

  { TForm1 }

  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    ogc: TContext;
    procedure CreateScene;
    procedure InitScene;
    procedure ogcDrawScene(Sender: TObject);
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

//image image.png

//lineal

const
  vertex_shader =
    '#version 460 core'#10 +
    ''#10 +
    'layout (location = 0) in vec3 inPos;'#10 +
    ''#10 +
    'void main(void)'#10 +
    '{'#10 +
    '  gl_Position = vec4(inPos, 1.0);'#10 +
    '}';

  fragment_shader =
    '#version 460 core'#10 +
    ''#10 +
    'layout (location = 0) out vec4 outColor;'#10 +
    ''#10 +
    'void main(void)'#10 +
    '{'#10 +
    '  outColor = vec4(1.0, 1.0, 0.0, 1.0);'#10 +
    '}';



function glsl_to_spriv(src: pchar; kind: Tshaderc_shader_kind): TAnsiCharArray;
var
  compiler: Pshaderc_compiler;
  res: Pshaderc_compilation_result;
  len: Tsize_t;
  spirv: pansichar;
  i: integer;
//  options: Pshaderc_compile_options;
  msg: pchar;
begin
  compiler := shaderc_compiler_initialize();
  if compiler = nil then begin
    WriteLn('compiler=nil');
    Exit(nil);
  end;
  //options := shaderc_compile_options_initialize();
  //if options = nil then begin
  //  WriteLn('Options Fehler');
  //  Exit(nil);
  //end;
  //shaderc_compile_options_set_target_env(options, shaderc_target_env_opengl, 0);

  res := shaderc_compile_into_spv(compiler, src, Length(src), kind, 'shader.glsl', 'main', nil);
  if shaderc_result_get_compilation_status(res) <> shaderc_compilation_status_success then begin
    msg := shaderc_result_get_error_message(res);
    WriteLn('Status Fehler:', msg);

    shaderc_result_release(res);
    shaderc_compiler_release(compiler);
    Exit(nil);
  end;

  len := shaderc_result_get_length(res);
  spirv := shaderc_result_get_bytes(res);

  SetLength(Result, len);
  for i := 0 to len - 1 do begin
    //    Write(byte(spirv[i]),  ' - ');
    Result[i] := spirv[i];
  end;
  //  WriteLn(#10);

  shaderc_result_release(res);
  shaderc_compiler_release(compiler);

  //  WriteLn('len: ', len);
  WriteLn(Length(Result));
end;

type
  TVertex3f = array[0..2] of GLfloat;
  TFace = array[0..2] of TVertex3f;

const
  Triangle: array[0..0] of TFace =
    (((-0.4, 0.1, 0.0), (0.4, 0.1, 0.0), (0.0, 0.7, 0.0)));
  Quad: array[0..1] of TFace =
    (((-0.2, -0.6, 0.0), (-0.2, -0.1, 0.0), (0.2, -0.1, 0.0)),
    ((-0.2, -0.6, 0.0), (0.2, -0.1, 0.0), (0.2, -0.6, 0.0)));

type
  TVB = record
    VAO,
    VBO: GLuint;
  end;

var
  VBTriangle, VBQuad: TVB;

  Shader: TShader;

procedure TForm1.FormCreate(Sender: TObject);
begin
  //remove+
  Width := 340;
  Height := 240;
  //remove-
  ogc := TContext.Create(Self);
  ogc.OnPaint := @ogcDrawScene;

  InitOpenGLDebug;
  CreateScene;
  InitScene;
end;

procedure TForm1.CreateScene;
var
  spri: TAnsiCharArray;
begin
  Shader := TShader.Create;

  spri := glsl_to_spriv(vertex_shader, shaderc_vertex_shader);
  Shader.LoadSPRIVShaderObjectAnsiChar(GL_VERTEX_SHADER, spri);

  spri := glsl_to_spriv(fragment_shader, shaderc_fragment_shader);
  Shader.LoadSPRIVShaderObjectAnsiChar(GL_FRAGMENT_SHADER, spri);


  //  Shader.LoadSPRIVShaderObjectFromFile(GL_VERTEX_SHADER, 'vert.spv');
  //  Shader.LoadSPRIVShaderObjectFromFile(GL_FRAGMENT_SHADER, 'frag.spv');
  Shader.LinkProgram;
  Shader.UseProgram;

  glGenVertexArrays(1, @VBTriangle.VAO);
  glGenVertexArrays(1, @VBQuad.VAO);

  glGenBuffers(1, @VBTriangle.VBO);
  glGenBuffers(1, @VBQuad.VBO);
end;

procedure TForm1.InitScene;
begin
  glClearColor(0.6, 0.6, 0.4, 1.0); // Hintergrundfarbe

  // Daten für Dreieck
  glBindVertexArray(VBTriangle.VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBTriangle.VBO);
  glBufferData(GL_ARRAY_BUFFER, sizeof(Triangle), @Triangle, GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 0, nil);

  // Daten für Quadrat
  glBindVertexArray(VBQuad.VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBO);
  glBufferData(GL_ARRAY_BUFFER, sizeof(Quad), @Quad, GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 0, nil);
end;

procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT);

  Shader.UseProgram;

  // Zeichne Dreieck
  glBindVertexArray(VBTriangle.VAO);
  glDrawArrays(GL_TRIANGLES, 0, Length(Triangle) * 3);

  // Zeichne Quadrat
  glBindVertexArray(VBQuad.VAO);
  glDrawArrays(GL_TRIANGLES, 0, Length(Quad) * 3);

  ogc.SwapBuffers;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Shader.Free;

  glDeleteVertexArrays(1, @VBTriangle.VAO);
  glDeleteVertexArrays(1, @VBQuad.VAO);

  glDeleteBuffers(1, @VBTriangle.VBO);
  glDeleteBuffers(1, @VBQuad.VBO);
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
