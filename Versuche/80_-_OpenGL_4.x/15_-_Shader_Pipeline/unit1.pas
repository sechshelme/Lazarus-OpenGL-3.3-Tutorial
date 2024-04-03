unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls,
  oglglad_gl, oglDebug,
  oglContext, oglVector;

type

  { TForm1 }

  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    ogc: TContext;
    procedure CreateScene;
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
  Triangle: array[0..2] of TVector3f =
    ((-0.4, 0.1, 0.0), (0.4, 0.1, 0.0), (0.0, 0.7, 0.0));
  Quad: array[0..5] of TVector3f =
    ((-0.2, -0.6, 0.0), (-0.2, -0.1, 0.0), (0.2, -0.1, 0.0),
    (-0.2, -0.6, 0.0), (0.2, -0.1, 0.0), (0.2, -0.6, 0.0));

  VertexShader: string =
    '#version 330'#10 +
    'layout (location = 0) in vec3 inPos;'#10 +
    'void main(void)'#10 +
    '{'#10 +
    ' gl_Position = vec4(inPos, 1.0);'#10 +
    '}';

  FragmentShader: string =
    '#version 330'#10 +
    'uniform vec3 col;'#10 +
    'out vec4 outColor;'#10 +
    'void main(void)'#10 +
    '{'#10 +
    '  outColor = vec4(col, 1.0); '#10 +
    '}';

type
  TVB = record
    VAO,
    VBO: GLuint;
  end;

var
  VBTriangle, VBQuad: TVB;

  vertexID, fragmentID, ProgramID: TGLuint;
  // https://stackoverflow.com/questions/27777226/how-to-use-glcreateshaderprogram

function Initshader(VertexS, FragmentS: string): TGLuint;
var
  linked, log_length,
  pipelineID: TGLuint;
  log: array of char = nil;
begin

  //  glGenProgramPipelines(1, @pipelineID);
  glCreateProgramPipelines(1, @pipelineID);

  // --- Vertex
  vertexID := glCreateShaderProgramv(GL_VERTEX_SHADER, 1, @VertexS);

  // Fehler
  glGetProgramiv(vertexID, GL_LINK_STATUS, @linked);
  if linked = 0 then begin
    WriteLn('Vertex-Fehler');
    glGetProgramiv(vertexID, GL_INFO_LOG_LENGTH, @log_length);
    SetLength(log, log_length);
    glGetProgramInfoLog(vertexID, log_length, @log_length, PChar(log));
    WriteLn(PChar(log));
  end;
  glUseProgramStages(pipelineID, GL_VERTEX_SHADER_BIT, vertexID);
  glDeleteProgram(vertexID);

  // --- Fragment
  fragmentID := glCreateShaderProgramv(GL_FRAGMENT_SHADER, 1, @FragmentS);

  // Fehler
  glGetProgramiv(fragmentID, GL_LINK_STATUS, @linked);
  if linked = 0 then begin
    WriteLn('Fragment-Fehler');
    glGetProgramiv(fragmentID, GL_INFO_LOG_LENGTH, @log_length);
    SetLength(log, log_length);
    glGetProgramInfoLog(vertexID, log_length, @log_length, PChar(log));
    WriteLn(PChar(log));
  end;
  glUseProgramStages(pipelineID, GL_FRAGMENT_SHADER_BIT, fragmentID);
  WriteLn('col: ', glGetUniformLocation(fragmentID, 'col'));
  glDeleteProgram(fragmentID);

  Result := pipelineID;
end;
//code-

{ TForm1 }

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
end;

procedure TForm1.CreateScene;
begin
  ProgramID := InitShader(VertexShader, FragmentShader);

  glClearColor(0.6, 0.6, 0.4, 1.0);

  // Daten für Dreieck
  glGenVertexArrays(1, @VBTriangle.VAO);
  glBindVertexArray(VBTriangle.VAO);

  glCreateBuffers(1, @VBTriangle.VBO);
  glNamedBufferData(VBTriangle.VBO, sizeof(Triangle), @Triangle, GL_STATIC_DRAW);

  glVertexAttribBinding(0, 10);
  glVertexAttribFormat(0, 3, GL_FLOAT, GL_FALSE, 0);
  glBindVertexBuffer(10, VBTriangle.VBO, 0, 12);
  glEnableVertexAttribArray(0);

  // Daten für Quadrat
  glGenVertexArrays(1, @VBQuad.VAO);
  glBindVertexArray(VBQuad.VAO);

  glCreateBuffers(1, @VBQuad.VBO);
  glNamedBufferData(VBQuad.VBO, sizeof(Quad), @Quad, GL_STATIC_DRAW);

  glVertexAttribBinding(0, 10);
  glVertexAttribFormat(0, 3, GL_FLOAT, False, 0);
  glBindVertexBuffer(10, VBQuad.VBO, 0, 12);
  glEnableVertexAttribArray(0);
end;

procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT);

  glBindProgramPipeline(0);
  glBindProgramPipeline(ProgramID);

  // Zeichne Dreieck

  glProgramUniform3fv(fragmentID, glGetUniformLocation(fragmentID, 'col'), 1, @vec3red);
  glBindVertexArray(VBTriangle.VAO);
  glDrawArrays(GL_TRIANGLES, 0, Length(Triangle));

  // Zeichne Quadrat
  glProgramUniform3fv(fragmentID, glGetUniformLocation(fragmentID, 'col'), 1, @vec3green);
  glBindVertexArray(VBQuad.VAO);
  glDrawArrays(GL_TRIANGLES, 0, Length(Quad));

  ogc.SwapBuffers;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  glDeleteProgramPipelines(1, @ProgramID);

  glDeleteVertexArrays(1, @VBTriangle.VAO);
  glDeleteVertexArrays(1, @VBQuad.VAO);

  glDeleteBuffers(1, @VBTriangle.VBO);
  glDeleteBuffers(1, @VBQuad.VBO);
end;

//lineal
(*
Die beiden verwendeten Shader, Details dazu im Kapitel Shader.

<b>Vertex-Shader:</b>
*)
//includeglsl Vertexshader.glsl
//lineal

(*
<b>Fragment-Shader:</b>
*)
//includeglsl Fragmentshader.glsl


end.
