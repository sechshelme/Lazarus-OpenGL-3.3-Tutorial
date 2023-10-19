unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, OpenGLContext, Forms, Controls, Graphics,
  Dialogs, ExtCtrls,
  dglOpenGL;

type

  { TForm1 }

  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    ogc: TOpenGLControl;
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
    (((-0.4, -0.8, 0.0), (0.4, -0.8, 0.0), (0.0, 0.2, 0.0)));
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
  ProgramID: GLuint;

function Initshader(VertexDatei, FragmentDatei: string): GLuint;
var
  sl: TStringList;
  s: string;

  ProgramObject: GLhandle;
  VertexShaderObject: GLhandle;
  FragmentShaderObject: GLhandle;

  ErrorStatus, InfoLogLength: integer;

begin
  sl := TStringList.Create;
  ProgramObject := glCreateProgram();

  // Vertex - Shader

  VertexShaderObject := glCreateShader(GL_VERTEX_SHADER);
  sl.LoadFromFile(VertexDatei);
  s := sl.Text;
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
  sl.LoadFromFile(FragmentDatei);
  s := sl.Text;
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
  sl.Free;
end;

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  //remove+
  Width := 340;
  Height := 240;
  //remove-
  ogc := TOpenGLControl.Create(Self);
  ogc.AutoResizeViewport := True;
  ogc.OpenGLMajorVersion := 3;
  ogc.OpenGLMinorVersion := 3;
  ogc.Align := alClient;
  ogc.Parent := Self;
  ogc.StencilBits:=1;
  ogc.MakeCurrent;

  InitOpenGL;

  ReadExtensions;
  ReadOpenGLCore;
  ReadImplementationProperties;

  ogc.OnPaint := @ogcDrawScene;

  CreateScene;
  InitScene;
end;

procedure TForm1.CreateScene;
begin
  ProgramID := InitShader('Vertexshader.glsl', 'Fragmentshader.glsl');
  glUseProgram(programID);

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

    glEnable(GL_STENCIL_TEST);
    glEnable(GL_DEPTH_TEST);
//    glClearStencil(0);

end;

procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT or GL_STENCIL_BUFFER_BIT);
  glUseProgram(programID);

  // --- Zeichne Dreieck
  glUniform3f(glGetUniformLocation(ProgramID, 'color'), 1, 0, 0);
  glBindVertexArray(VBTriangle.VAO);

  glStencilFunc(GL_ALWAYS, 1, $FF);
  glStencilOp(GL_KEEP, GL_KEEP, GL_REPLACE);
  //glStencilMask($FF);
  glDepthMask(GL_FALSE);

  glDrawArrays(GL_TRIANGLES, 0, Length(Triangle) * 3);

  // --- Zeichne Quadrat
  glUniform3f(glGetUniformLocation(ProgramID, 'color'), 0, 1, 0);
  glBindVertexArray(VBQuad.VAO);

  glStencilFunc(GL_EQUAL, 1, $FF);
//  glStencilMask($00);
  glDepthMask(GL_TRUE);

  glDrawArrays(GL_TRIANGLES, 0, Length(Quad) * 3);

  ogc.SwapBuffers;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  glDeleteProgram(ProgramID);

  glDeleteVertexArrays(1, @VBTriangle.VAO);
  glDeleteVertexArrays(1, @VBQuad.VAO);

  glDeleteBuffers(1, @VBTriangle.VBO);
  glDeleteBuffers(1, @VBQuad.VBO);
end;

end.
