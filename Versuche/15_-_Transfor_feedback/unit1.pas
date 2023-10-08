unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls,
  dglOpenGL,
  oglContext;

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

(*
Hier wird zum ersten Mal ein Shader geladen, ohne solchen macht OpenGL >= 3.3 keinen Sinn.
Nähere Details dazu im Kapitel Shader. Hier geht es in erster Linie mal darum, dass man etwas rendern kann.

In diesem Beispiel wird ein sehr einfacher Shader verwendet. Dieser macht nichts anderes, als das Mesh rot darzustellen.
*)

//lineal
type
  TData = array[0..7] of TGLfloat;

const
  Data: TData = (1, 2, 3, 4, 5, 6, 7, 8);

var
  feedback: TData;

type
  TVB = record
    VAO,
    VBO, TBO: GLuint;
  end;

var
  VBData: TVB;

(*
Die ID, welche auf den Shader zeigt.
*)
  //code+

// https://vis.uni-jena.de/Lecture/ComputerGraphics/Lec11_TransformFeedback.pdf

var
  ProgramID: GLuint;

function Initshader(VertexDatei: string): GLuint;
const
  feedbackVarings: array of PGLchar = ('outValue');
var
  sl: TStringList;
  s: string;

  ProgramObject: GLhandle;
  VertexShaderObject: GLhandle;

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
    WriteLn('OpenGL Vertex Fehler', s);
  end;

  glDeleteShader(VertexShaderObject);
  // Feedback
  glTransformFeedbackVaryings(ProgramObject, 1, PPGLchar(feedbackVarings), GL_INTERLEAVED_ATTRIBS);




  glLinkProgram(ProgramObject);    // Die beiden Shader zusammen linken

  // Check Link
  glGetProgramiv(ProgramObject, GL_LINK_STATUS, @ErrorStatus);
  if ErrorStatus = 0 then begin
    glGetProgramiv(ProgramObject, GL_INFO_LOG_LENGTH, @InfoLogLength);
    SetLength(s, InfoLogLength + 1);
    glGetProgramInfoLog(ProgramObject, InfoLogLength, nil, @s[1]);
    WriteLn('OpenGL Link Fehler', s);
  end;

  Result := ProgramObject;
  sl.Free;
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
//  ogc.OnPaint := @ogcDrawScene;


//InitOpenGL;
//MakeCurrent;

//  ReadExtensions;
//ReadOpenGLCore;
//ReadImplementationProperties;


  CreateScene;
end;

procedure TForm1.CreateScene;
var
  i: Integer;
begin
  ProgramID := InitShader('Vertexshader.glsl');
  glUseProgram(programID);

  glGenVertexArrays(1, @VBData.VAO);
  glBindVertexArray(VBData.VAO);

  glGenBuffers(1, @VBData.VBO);
  glBindBuffer(GL_ARRAY_BUFFER, VBData.VBO);
  glBufferData(GL_ARRAY_BUFFER, Length(Data) * SizeOf(TGLfloat), @Data, GL_STATIC_DRAW);

  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 1, GL_FLOAT, False, 0, nil);


  glGenBuffers(1, @VBData.TBO);
  glBindBuffer(GL_ARRAY_BUFFER, VBData.TBO);
  glBufferData(GL_ARRAY_BUFFER, Length(Data) * SizeOf(TGLfloat), nil, GL_STATIC_READ);

  glEnable(GL_RASTERIZER_DISCARD);
  glBindBufferBase(GL_TRANSFORM_FEEDBACK_BUFFER, 0, VBData.TBO);
  glBeginTransformFeedback(GL_POINTS);


  glDrawArrays(GL_POINTS, 0, Length(Data));

  glEndTransformFeedback;
  glFlush;

  glGetBufferSubData(GL_TRANSFORM_FEEDBACK_BUFFER, 0, Length(feedback) * SizeOf(TGLfloat), @feedback);

  for i := 0 to Length(feedback) - 1 do begin
    Write(feedback[i]: 10: 5);
  end;
  WriteLn;
end;

procedure TForm1.ogcDrawScene(Sender: TObject);
var
  i: integer;
begin
  //  glUseProgram(programID);
  //code-

  // Zeichne Dreieck
  //  glBindVertexArray(VBData.VAO);

  ogc.SwapBuffers;
end;

//code+
procedure TForm1.FormDestroy(Sender: TObject);
begin
  glDeleteProgram(ProgramID);
  //code-

  glDeleteVertexArrays(1, @VBData.VAO);

  glDeleteBuffers(1, @VBData.VBO);
  glDeleteBuffers(1, @VBData.TBO);
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
