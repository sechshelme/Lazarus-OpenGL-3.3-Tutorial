unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, OpenGLContext, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, dglOpenGL;

type

  { TForm1 }

  TForm1 = class(TForm)
    OpenGLControl1: TOpenGLControl;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private   { private declarations }
    procedure InitScene;
    procedure RenderScene;
  public        { public declarations }
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
  TriangleColor: array[0..0] of TFace =
    (((1.0, 0.0, 0.0), (0.0, 1.0, 0.0), (0.0, 0.0, 1.0)));

  Quad: array[0..1] of TFace =
    (((-0.2, -0.6, 0.0), (-0.2, -0.1, 0.0), (0.2, -0.1, 0.0)),
    ((-0.2, -0.6, 0.0), (0.2, -0.1, 0.0), (0.2, -0.6, 0.0)));
  QuadColor: array[0..1] of TFace =
    (((1.0, 0.0, 0.0), (0.0, 1.0, 0.0), (0.0, 0.0, 1.0)),
    ((1.0, 0.0, 0.0), (0.0, 0.0, 1.0), (1.0, 1.0, 0.0)));

type
  TVB = record
    VAO,
    VBO0, VBO1: GLuint;
  end;


var
  VBTriangle, VBQuad: TVB;
  Vertex_id, Color_id: GLint;

function Initshader(VertexDatei, FragmentDatei: string): GLuint;
var
  StringList: TStringList;
  Str: ansistring;

  ProgramObject: GLhandle;
  VertexShaderObject: GLhandle;
  FragmentShaderObject: GLhandle;

  ErrorStatus: boolean;
  InfoLogLength: integer;

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
  if ErrorStatus = GL_FALSE then begin
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
  if ErrorStatus = GL_FALSE then begin
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
  if ErrorStatus = GL_FALSE then begin
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
  ProgramID := InitShader('shader.vert', 'shader.frag');
  glUseProgram(programID);

  Vertex_id := glGetAttribLocation(ProgramID, 'inPos');
  Color_id := glGetAttribLocation(ProgramID, 'inColor');

  glClearColor(0.0, 0.5, 1.0, 1.0);

  glGenVertexArrays(1, @VBTriangle.VAO);
  glGenVertexArrays(1, @VBQuad.VAO);

  glGenBuffers(1, @VBTriangle.VBO0);
  glGenBuffers(1, @VBQuad.VBO0);
  glGenBuffers(1, @VBTriangle.VBO1);
  glGenBuffers(1, @VBQuad.VBO1);

  glBindVertexArray(VBTriangle.VAO);

  glBindBuffer(GL_ARRAY_BUFFER, VBTriangle.VBO0);
  glBufferData(GL_ARRAY_BUFFER, sizeof(Triangle), @Triangle, GL_STATIC_DRAW);
  glEnableVertexAttribArray(Vertex_id);
  glVertexAttribPointer(Vertex_id, 3, GL_FLOAT, False, 0, nil);

  glBindBuffer(GL_ARRAY_BUFFER, VBTriangle.VBO1);
  glBufferData(GL_ARRAY_BUFFER, sizeof(TriangleColor), @TriangleColor, GL_STATIC_DRAW);
  glEnableVertexAttribArray(Color_id);
  glVertexAttribPointer(Color_id, 3, GL_FLOAT, False, 0, nil);


  glBindVertexArray(VBQuad.VAO);

  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBO0);
  glBufferData(GL_ARRAY_BUFFER, sizeof(Quad), @Quad, GL_STATIC_DRAW);
  glEnableVertexAttribArray(Vertex_id);
  glVertexAttribPointer(Vertex_id, 3, GL_FLOAT, False, 0, nil);

  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBO1);
  glBufferData(GL_ARRAY_BUFFER, sizeof(QuadColor), @QuadColor, GL_STATIC_DRAW);
  glEnableVertexAttribArray(Color_id);
  glVertexAttribPointer(Color_id, 3, GL_FLOAT, False, 0, nil);
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
  ReadExtensions;
  ReadImplementationProperties;

  InitScene;
  Timer1.Enabled := True;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  glDeleteBuffers(1, @VBTriangle.VAO);
  glDeleteBuffers(1, @VBQuad.VAO);

  glDeleteVertexArrays(1, @VBTriangle.VBO0);
  glDeleteVertexArrays(1, @VBQuad.VBO0);
  glDeleteVertexArrays(1, @VBTriangle.VBO1);
  glDeleteVertexArrays(1, @VBQuad.VBO1);

  glDeleteShader(ProgramID);
end;

procedure TForm1.FormResize(Sender: TObject);
begin
  glViewport(0, 0, ClientWidth, ClientHeight);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  RenderScene;
end;

end.
