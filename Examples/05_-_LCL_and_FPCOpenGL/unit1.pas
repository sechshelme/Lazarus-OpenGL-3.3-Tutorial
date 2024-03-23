unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, OpenGLContext, Forms, Controls, Graphics,
  Dialogs, ExtCtrls,
  GL, GLext;

type
  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    ogc: TOpenGLControl;
    procedure CreateScene;
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

var
  ProgramID: GLuint;

  VAOs: array [(vaTriangle, vaQuad)] of TGLuint;
  Mesh_Buffers: array [(mbTriangle, mbQuad)] of TGLuint;

const
  vertexShaderText =
    '#version 330'#10 +
    'layout (location = 0) in vec3 inPos;'#10 +
    'void main(void)'#10 +
    '{'#10 +
    '  gl_Position = vec4(inPos, 1.0);'#10 +
    '}';
  fragmentShaderText =
    '#version 330'#10 +
    'out vec4 outColor; // ausgegebene Farbe'#10 +
    'void main(void)'#10 +
    '{'#10 +
    '  outColor = vec4(1.0, 0.0, 0.0, 1.0);'#10 +
    '}';

//code+
function Initshader: GLuint;
var
  s: string;

  ProgramObject: GLint;
  VertexShaderObject: GLint;
  FragmentShaderObject: GLint;

  ErrorStatus, InfoLogLength: integer;

begin
  ProgramObject := glCreateProgram();

  // Vertex - Shader

  VertexShaderObject := glCreateShader(GL_VERTEX_SHADER);
  s := vertexShaderText;
  glShaderSource(VertexShaderObject, 1, @s, nil);
  glCompileShader(VertexShaderObject);
  glAttachShader(ProgramObject, VertexShaderObject);

  // Check Shader

  glGetShaderiv(VertexShaderObject, GL_COMPILE_STATUS, @ErrorStatus);
  if ErrorStatus = 0 then begin
    glGetShaderiv(VertexShaderObject, GL_INFO_LOG_LENGTH, @InfoLogLength);
    SetLength(s, InfoLogLength + 1);
    glGetShaderInfoLog(VertexShaderObject, InfoLogLength, nil, @s[1]);
    Application.MessageBox(PChar(s), 'OpenGL Vertex Fehler', 48);
    Halt;
  end;

  glDeleteShader(VertexShaderObject);

  // Fragment - Shader

  FragmentShaderObject := glCreateShader(GL_FRAGMENT_SHADER);
  s := fragmentShaderText;
  glShaderSource(FragmentShaderObject, 1, @s, nil);
  glCompileShader(FragmentShaderObject);
  glAttachShader(ProgramObject, FragmentShaderObject);

  // Check Shader

  glGetShaderiv(FragmentShaderObject, GL_COMPILE_STATUS, @ErrorStatus);
  if ErrorStatus = 0 then begin
    glGetShaderiv(FragmentShaderObject, GL_INFO_LOG_LENGTH, @InfoLogLength);
    SetLength(s, InfoLogLength + 1);
    glGetShaderInfoLog(FragmentShaderObject, InfoLogLength, nil, @s[1]);
    Application.MessageBox(PChar(s), 'OpenGL Fragment Fehler', 48);
    Halt;
  end;

  glDeleteShader(FragmentShaderObject);

  glLinkProgram(ProgramObject);    // Die beiden Shader zusammen linken
  // Check Link
  glGetProgramiv(ProgramObject, GL_LINK_STATUS, @ErrorStatus);
  if ErrorStatus = 0 then begin
    glGetProgramiv(ProgramObject, GL_INFO_LOG_LENGTH, @InfoLogLength);
    SetLength(s, InfoLogLength + 1);
    glGetProgramInfoLog(ProgramObject, InfoLogLength, nil, @s[1]);
    Application.MessageBox(PChar(s), 'OpenGL ShaderLink Fehler', 48);
    Halt;
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
  Load_GL_VERSION_3_3();

  ogc := TOpenGLControl.Create(Self);
  ogc.Parent := Self;
  ogc.Align := alClient;
  ogc.AutoResizeViewport := True;
  ogc.OpenGLMajorVersion := 3;
  ogc.OpenGLMinorVersion := 3;
  ogc.StencilBits := 8;
  ogc.MakeCurrent;
  ogc.OnPaint := @ogcDrawScene;

  CreateScene;
end;

procedure TForm1.CreateScene;
begin
  ProgramID := InitShader;
  glUseProgram(programID);

  glGenVertexArrays(Length(VAOs), VAOs);
  glGenBuffers(Length(Mesh_Buffers), Mesh_Buffers);

  glClearColor(0.6, 0.6, 0.4, 1.0);

  // Daten für Dreieck
  glBindVertexArray(VAOs[vaTriangle]);
  glBindBuffer(GL_ARRAY_BUFFER, Mesh_Buffers[mbTriangle]);
  glBufferData(GL_ARRAY_BUFFER, sizeof(Triangle), @Triangle, GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 0, nil);

  // Daten für Quadrat
  glBindVertexArray(VAOs[vaQuad]);
  glBindBuffer(GL_ARRAY_BUFFER, Mesh_Buffers[mbQuad]);
  glBufferData(GL_ARRAY_BUFFER, sizeof(Quad), @Quad, GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 0, nil);
end;

procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT);

  glUseProgram(programID);

  // Zeichne Dreieck
  glBindVertexArray(VAOs[vaTriangle]);
  glDrawArrays(GL_TRIANGLES, 0, Length(Triangle) * 3);

  // Zeichne Quadrat
  glBindVertexArray(VAOs[vaQuad]);
  glDrawArrays(GL_TRIANGLES, 0, Length(Quad) * 3);

  ogc.SwapBuffers;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  glDeleteProgram(ProgramID);

  glDeleteVertexArrays(Length(VAOs), VAOs);
  glDeleteBuffers(Length(Mesh_Buffers), Mesh_Buffers);
end;

end.
