unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls,
  oglglad_gl, oglVector, oglDebug, oglShader,

  fp_shaderc,

  oglContext;

type
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


function PCharToSpriV(kind: Tshaderc_shader_kind; src: pchar): AnsiString;
var
  compiler: Pshaderc_compiler;
  res: Pshaderc_compilation_result;
  spirv_size: Tsize_t;
  spirv_data: pansichar;
begin
  compiler := shaderc_compiler_initialize;
  res := shaderc_compile_into_spv(compiler, src, Length(src), kind, 'shader.glsl', 'main', nil);
  if shaderc_result_get_compilation_status(res) <> shaderc_compilation_status_success then begin
    WriteLn('Shaderc error: %s'#10, shaderc_result_get_error_message(res));
    shaderc_result_release(res);
    shaderc_compiler_release(compiler);
    exit('');
  end;

  spirv_size := shaderc_result_get_length(res);
  spirv_data := shaderc_result_get_bytes(res);

  SetLength(Result, spirv_size);
  Move(spirv_data[0], Result[1], spirv_size);

  shaderc_result_release(res);
  shaderc_compiler_release(compiler);
end;

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
  spirv_data: AnsiString;
begin
  Shader := TShader.Create;

  spirv_data := PCharToSpriV( shaderc_vertex_shader,vertex_shader);
  Shader.LoadSPIRVShaderObject(GL_VERTEX_SHADER, spirv_data);

  spirv_data := PCharToSpriV(shaderc_fragment_shader,fragment_shader );
  Shader.LoadSPIRVShaderObject(GL_FRAGMENT_SHADER, spirv_data);

  Shader.LinkProgram;
  Shader.UseProgram;

  glGenVertexArrays(1, @VBTriangle.VAO);
  glGenVertexArrays(1, @VBQuad.VAO);

  glGenBuffers(1, @VBTriangle.VBO);
  glGenBuffers(1, @VBQuad.VBO);
end;

procedure TForm1.InitScene;
begin
  glClearColor(0.6, 0.6, 0.4, 1.0);

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
