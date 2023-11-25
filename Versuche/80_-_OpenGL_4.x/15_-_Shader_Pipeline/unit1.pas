unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls,
  dglOpenGL, oglDebug,
  oglContext,oglVector;

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

(*
Hier wird zum ersten Mal ein Shader geladen, ohne solchen macht OpenGL >= 3.3 keinen Sinn.
Nähere Details dazu im Kapitel Shader. Hier geht es in erster Linie mal darum, dass man etwas rendern kann.

In diesem Beispiel wird ein sehr einfacher Shader verwendet. Dieser macht nichts anderes, als das Mesh rot darzustellen.
*)

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
    '#define col vec3(1.0, 0.0, 0.0)'#10 +
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

(*
Die ID, welche auf den Shader zeigt.
*)
  //code+
var
  ProgramID: TGLuint;
  //code-

(*
Lädt den Vertex- und Fragment-Shader in die Grafikkarte.
In diesem Beispiel sind die beiden Shader in einer Textdatei.
Natürlich kann man diese auch direkt als String-Konstante im Quellcode deklarieren.
*)

  // https://stackoverflow.com/questions/27777226/how-to-use-glcreateshaderprogram

//code+
function Initshader(VertexS, FragmentS: string): TGLuint;
var
  linked,log_length,
  vertexID, fragmentID, pipelineID: TGLuint;
  log:array of Char=nil;
begin
  //  glGenProgramPipelines(1, @pipelineID);
  glCreateProgramPipelines(1, @pipelineID);

  // --- Vertex
  vertexID := glCreateShaderProgramv(GL_VERTEX_SHADER, 1, @VertexS);
  glUseProgramStages(pipelineID, GL_VERTEX_SHADER_BIT, vertexID);

  // Fehler
  glGetProgramiv(vertexID, GL_LINK_STATUS, @linked);
  if linked = 0 then begin
    WriteLn('Vertex-Fehler');
    glGetProgramiv(vertexID, GL_INFO_LOG_LENGTH, @log_length);
     SetLength(log,log_length);
     glGetProgramInfoLog(vertexID, log_length,@log_length, PChar(log));
     WriteLn(PChar( log));
  end;

  // --- Fragment
  fragmentID := glCreateShaderProgramv(GL_FRAGMENT_SHADER, 1, @FragmentS);
  glUseProgramStages(pipelineID, GL_FRAGMENT_SHADER_BIT, fragmentID);

  // Fehler
  glGetProgramiv(fragmentID, GL_LINK_STATUS, @linked);
  if linked = 0 then begin
    WriteLn('Fragment-Fehler');
    glGetProgramiv(fragmentID, GL_INFO_LOG_LENGTH, @log_length);
     SetLength(log,log_length);
     glGetProgramInfoLog(vertexID, log_length,@log_length, PChar(log));
     WriteLn(PChar( log));
  end;

  glBindProgramPipeline(pipelineID);
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
  InitScene;
end;

(*
Dieser Code wurde um 2 Zeilen erweitert.

In der ersten Zeile wird der Shader in die Grafikkarte geladen.
Die zweite Zeile aktiviert den Shader.
Dies wird spätestens dann interessant, wenn man mehrere Shader verwendet.
Näheres im Kapitel Shader.
*)

//code+
procedure TForm1.CreateScene;
begin
  ProgramID := InitShader(VertexShader, FragmentShader);
  //  glUseProgram(programID);
  //code-

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
  glVertexAttribPointer(0, 3, GL_FLOAT, False, 0, nil);

  // Daten für Quadrat
  glBindVertexArray(VBQuad.VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBO);
  glBufferData(GL_ARRAY_BUFFER, sizeof(Quad), @Quad, GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 3, GL_FLOAT, False, 0, nil);
end;

(*
Beim Zeichnen muss man auch mit <b>glUseProgram(...</b> den Shader wählen, mit welchem das Mesh gezeichnet wird.
Bei diesem Mini-Code könnte dies weggelassen werden, da nur ein Shader verwendet wird und dieser bereits in TForm1.CreateScene aktiviert wurde.
*)

//code+
procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT);

  glBindProgramPipeline(0);
  glBindProgramPipeline(ProgramID);

  //code-

  // Zeichne Dreieck
  glBindVertexArray(VBTriangle.VAO);
  glDrawArrays(GL_TRIANGLES, 0, Length(Triangle));

  // Zeichne Quadrat
  glBindVertexArray(VBQuad.VAO);
  glDrawArrays(GL_TRIANGLES, 0, Length(Quad));

  ogc.SwapBuffers;
end;

(*
Am Ende noch mit <b>glDeleteShader(...</b> die Shader in der Grafikkarte wieder freigeben.
In diesem Code ist dies nur einer.
*)

//code+
procedure TForm1.FormDestroy(Sender: TObject);
begin
  glDeleteProgramPipelines(1, @ProgramID);

  //  glDeleteProgram(ProgramID);
  //code-

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
