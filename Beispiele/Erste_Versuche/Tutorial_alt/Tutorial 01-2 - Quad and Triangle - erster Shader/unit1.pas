unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  OpenGLContext, dglOpenGL;      // Die 2 Units für OpenGL

type

  { TForm1 }

  TForm1 = class(TForm)
    OpenGLControl1: TOpenGLControl;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure OpenGLControl1Paint(Sender: TObject);
  private
    procedure InitScene;
    procedure RenderScene;
  public
    ProgramID: GLuint;
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

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

function Initshader(VertexDatei, FragmentDatei: string): GLuint;
var
  StringList: TStringList;
  Str: ansistring;

  ProgramObject: GLhandle;
  VertexShaderObject: GLhandle;
  FragmentShaderObject: GLhandle;

  ErrorStatus, InfoLogLength: integer;

begin
  StringList := TStringList.Create;
  ProgramObject := glCreateProgram();

  // Vertex - Shader

  VertexShaderObject := glCreateShader(GL_VERTEX_SHADER);
  StringList.LoadFromFile(VertexDatei);
  Str := StringList.Text;
  glShaderSource(VertexShaderObject, 1, @Str, nil);
  glCompileShader(VertexShaderObject);
  glAttachShader(ProgramObject, VertexShaderObject);

  // Check  Shader

  glGetShaderiv(VertexShaderObject, GL_COMPILE_STATUS, @ErrorStatus);
  if ErrorStatus = 0 then begin
    glGetShaderiv(VertexShaderObject, GL_INFO_LOG_LENGTH, @InfoLogLength);
    SetLength(Str, InfoLogLength);
    glGetShaderInfoLog(VertexShaderObject, InfoLogLength, @InfoLogLength, @Str[1]);
    Application.MessageBox(PChar(Str), 'OpenGL Vertex Fehler', 48);
    Halt;
  end;

  glDeleteShader(VertexShaderObject);

  // Fragment - Shader

  FragmentShaderObject := glCreateShader(GL_FRAGMENT_SHADER);
  StringList.LoadFromFile(FragmentDatei);
  Str := StringList.Text;
  glShaderSource(FragmentShaderObject, 1, @Str, nil);
  glCompileShader(FragmentShaderObject);
  glAttachShader(ProgramObject, FragmentShaderObject);

  // Check  Shader

  glGetShaderiv(FragmentShaderObject, GL_COMPILE_STATUS, @ErrorStatus);
  if ErrorStatus = 0 then begin
    glGetShaderiv(FragmentShaderObject, GL_INFO_LOG_LENGTH, @InfoLogLength);
    SetLength(Str, InfoLogLength);
    glGetShaderInfoLog(FragmentShaderObject, InfoLogLength, @InfoLogLength, @Str[1]);
    Application.MessageBox(PChar(Str), 'OpenGL Fragment Fehler', 48);
    Halt;
  end;

  glDeleteShader(FragmentShaderObject);

  glLinkProgram(ProgramObject);

  // Check  Link
  glGetProgramiv(ProgramObject, GL_LINK_STATUS, @ErrorStatus);
  if ErrorStatus = 0 then begin
    glGetProgramiv(ProgramObject, GL_INFO_LOG_LENGTH, @InfoLogLength);
    SetLength(Str, InfoLogLength);
    glGetProgramInfoLog(ProgramObject, InfoLogLength, @InfoLogLength, @Str[1]);
    Application.MessageBox(PChar(Str), 'OpenGL ShaderLink Fehler', 48);
    Halt;
  end;

  Result := ProgramObject;
  FreeAndNil(StringList);
end;

procedure TForm1.InitScene;
begin
  ProgramID := InitShader('Vertexshader.glsl', 'Fragmentshader.glsl');
  glUseProgram(programID);

  glClearColor(0.0, 0.5, 1.0, 1.0); //Hintergrundfarbe: Hier ein leichtes Blau

  // Dreieck

  glGenBuffers(1, @VBTriangle.VBO);
  glGenVertexArrays(1, @VBTriangle.VAO);

  glBindVertexArray(VBTriangle.VAO);

  glBindBuffer(GL_ARRAY_BUFFER, VBTriangle.VBO);
  glBufferData(GL_ARRAY_BUFFER, sizeof(Triangle), @Triangle, GL_STATIC_DRAW);
  glEnableVertexAttribArray(10);
  glVertexAttribPointer(10, 3, GL_FLOAT, False, 0, nil);

  // Rechteck

  glGenBuffers(1, @VBQuad.VBO);
  glGenVertexArrays(1, @VBQuad.VAO);

  glBindVertexArray(VBQuad.VAO);

  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBO);
  glBufferData(GL_ARRAY_BUFFER, sizeof(Quad), @Quad, GL_STATIC_DRAW);
  glEnableVertexAttribArray(10);
  glVertexAttribPointer(10, 3, GL_FLOAT, False, 0, nil);
end;

procedure TForm1.RenderScene;
begin
  glClear(GL_COLOR_BUFFER_BIT);

  // Zeichen Dreieck

  glBindVertexArray(VBTriangle.VAO);
  glDrawArrays(GL_TRIANGLES, 0, Length(Triangle) * 3);

  // Zeichne Quadrat

  glBindVertexArray(VBQuad.VAO);
  glDrawArrays(GL_TRIANGLES, 0, Length(Quad) * 3);

  OpenGLControl1.SwapBuffers;
end;


procedure TForm1.FormCreate(Sender: TObject);
begin
  InitOpenGL;

  OpenGLControl1.MakeCurrent;

//  ReadExtensions;
ReadOpenGLCore;

  ReadImplementationProperties;

//  InitOpenGLDebug;
  InitScene;

end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  glDeleteVertexArrays(1, @VBTriangle.VAO);
  glDeleteVertexArrays(1, @VBQuad.VAO);

  glDeleteBuffers(1, @VBTriangle.VBO);
  glDeleteBuffers(1, @VBQuad.VBO);

  glDeleteShader(ProgramID);
end;

procedure TForm1.OpenGLControl1Paint(Sender: TObject);
begin
  RenderScene;
end;

end.
