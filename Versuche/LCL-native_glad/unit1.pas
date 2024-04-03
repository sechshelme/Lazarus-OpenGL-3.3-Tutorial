unit Unit1;

{$mode objfpc}{$H+}

interface

uses       gl,      GLext,
  Classes, SysUtils, FileUtil, OpenGLContext, Forms, Controls, Graphics,
  Dialogs, ExtCtrls,
//    oglgl,oglglext;
  glad_gl;
//  gl,glext;

//  dglOpenGL;

type

  { TForm1 }

  TForm1 = class(TForm)
    OpenGLControl1: TOpenGLControl;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
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

(*
Die ID, welche auf den Shader zeigt.
*)
  //code+
var
  ProgramID: GLuint;
  //code-

(*
Lädt den Vertex- und Fragment-Shader in die Grafikkarte.
In diesem Beispiel sind die beiden Shader in einer Textdatei.
Natürlich kann man diese auch direkt als String-Konstante im Quellcode deklarieren.
*)

//code+
function Initshader(VertexDatei, FragmentDatei: string): GLuint;
var
  sl: TStringList;
  s: string;

  ProgramObject: GLint;
  VertexShaderObject: GLint;
  FragmentShaderObject: GLint;

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
//code-

{ TForm1 }

procedure Test_Show;
var
  p1, p2: Pointer;
  s:String;
begin
    p1 := GetProcAddress(LibGL, 'glClear');
  p2 := GetProcAddress(LibGL, 'glBindBuffer');
  WriteStr(s, 'GetProcAddress:'#10'glClear: ', PtrUInt(p1), '       glBindBuffer: ', PtrUInt(p2));

  p1 := wglGetProcAddress('glClear');
  p2 := wglGetProcAddress('glBindBuffer');
  WriteStr(s, s, #10#10'wglGetProcAddress:'#10'glClear: ', PtrUInt(p1), '       glBindBuffer: ', PtrUInt(p2));
  ShowMessage(s);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Width := 340;
  Height := 240;

  //  ShowMessage(PtrUInt(glGenVertexArrays).ToString);


  OpenGLControl1.AutoResizeViewport := True;
  OpenGLControl1.OpenGLMajorVersion := 3;
  OpenGLControl1.OpenGLMinorVersion := 3;
  OpenGLControl1.Align := alClient;
  OpenGLControl1.OnPaint := @ogcDrawScene;

  OpenGLControl1.MakeCurrent;
  Load_GLADE;
//  Test_Show;




    //Load_GL_version_4_3_CORE();
  //  InitOpenGL;
  //ReadExtensions;
  //ReadOpenGLCore;
  //ReadImplementationProperties;
//  ShowMessage(PtrUInt(glBindBuffer).ToString);



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
//  ShowMessage('bind');
  glBindBuffer(GL_ARRAY_BUFFER, 0);
//  ShowMessage('bind');

  glGenVertexArrays(1, @VBTriangle.VAO);
  glGenVertexArrays(1, @VBQuad.VAO);

  glGenBuffers(1, @VBTriangle.VBO);
  glGenBuffers(1, @VBQuad.VBO);


  ProgramID := InitShader('Vertexshader.glsl', 'Fragmentshader.glsl');
  glUseProgram(programID);
  //code-

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

  OpenGLControl1.SwapBuffers;
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
