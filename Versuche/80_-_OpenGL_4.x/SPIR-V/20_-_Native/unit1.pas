unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls,
  oglglad_gl, oglDebug, oglShader,
  oglContext;

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

var
  ProgramID: GLuint;

function Initshader: GLuint;
var
  chs: string;

  ProgramObject, VertexShaderObject, FragmentShaderObject: TGLuint;
  ErrorStatus, InfoLogLength: TGLint;

begin
  ProgramObject := glCreateProgram();

  // === Vertex - Shader

  VertexShaderObject := glCreateShader(GL_VERTEX_SHADER);
  chs := FileToStr('vert.spv');

  glShaderBinary(1, @VertexShaderObject, GL_SHADER_BINARY_FORMAT_SPIR_V, PGLvoid(chs), Length(chs));
  glSpecializeShader(VertexShaderObject, 'main', 0, nil, nil);

  glAttachShader(ProgramObject, VertexShaderObject);

  // Check Shader

  glGetShaderiv(VertexShaderObject, GL_COMPILE_STATUS, @ErrorStatus);
  if ErrorStatus = 0 then begin
    glGetShaderiv(VertexShaderObject, GL_INFO_LOG_LENGTH, @InfoLogLength);
    SetLength(chs, InfoLogLength + 1);
    glGetShaderInfoLog(VertexShaderObject, InfoLogLength, nil, pchar(chs));
    WriteLn('OpenGL Vertex Fehler', #10, pchar(chs));
  end;

  glDeleteShader(VertexShaderObject);

  // === Fragment - Shader

  FragmentShaderObject := glCreateShader(GL_FRAGMENT_SHADER);
  chs := FileToStr('frag.spv');

  glShaderBinary(1, @FragmentShaderObject, GL_SHADER_BINARY_FORMAT_SPIR_V, PGLvoid(chs), Length(chs));
  glSpecializeShader(FragmentShaderObject, 'main', 0, nil, nil);

  glAttachShader(ProgramObject, FragmentShaderObject);

  // Check Shader

  glGetShaderiv(FragmentShaderObject, GL_COMPILE_STATUS, @ErrorStatus);
  if ErrorStatus = 0 then begin
    glGetShaderiv(FragmentShaderObject, GL_INFO_LOG_LENGTH, @InfoLogLength);
    SetLength(chs, InfoLogLength + 1);
    glGetShaderInfoLog(FragmentShaderObject, InfoLogLength, nil, pchar(chs));
    WriteLn('OpenGL Fragment Fehler', #10, pchar(chs));
  end;

  glDeleteShader(FragmentShaderObject);


  // === Shader linken
  glLinkProgram(ProgramObject);

  // Check Link
  glGetProgramiv(ProgramObject, GL_LINK_STATUS, @ErrorStatus);
  if ErrorStatus = 0 then begin
    glGetProgramiv(ProgramObject, GL_INFO_LOG_LENGTH, @InfoLogLength);
    SetLength(chs, InfoLogLength + 1);
    glGetProgramInfoLog(ProgramObject, InfoLogLength, nil, pchar(chs));
    WriteLn('OpenGL Link Fehler', #10, pchar(chs));
  end;

  Result := ProgramObject;
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
  ProgramID := InitShader;
  glUseProgram(programID);
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
  glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 0, nil);

  // Daten für Quadrat
  glBindVertexArray(VBQuad.VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBO);
  glBufferData(GL_ARRAY_BUFFER, sizeof(Quad), @Quad, GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 0, nil);
end;

(*
Beim Zeichnen muss man auch mit <b>glUseProgram(...</b> den Shader wählen, mit welchem das Mesh gezeichnet wird.
Bei diesem Mini-Code könnte dies weggelassen werden, da nur ein Shader verwendet wird und dieser bereits in TForm1.CreateScene aktiviert wurde.
*)

//code+
procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT);

  glUseProgram(programID);
  //code-

  // Zeichne Dreieck
  glBindVertexArray(VBTriangle.VAO);
  glDrawArrays(GL_TRIANGLES, 0, Length(Triangle) * 3);

  // Zeichne Quadrat
  glBindVertexArray(VBQuad.VAO);
  glDrawArrays(GL_TRIANGLES, 0, Length(Quad) * 3);

  ogc.SwapBuffers;
end;

(*
Am Ende noch mit <b>glDeleteShader(...</b> die Shader in der Grafikkarte wieder freigeben.
In diesem Code ist dies nur einer.
*)

//code+
procedure TForm1.FormDestroy(Sender: TObject);
begin
  glDeleteProgram(ProgramID);
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
