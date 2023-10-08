unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, OpenGLContext, Forms, Controls, Graphics,
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
    procedure OutputScene;
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

//image image.png

(*
*)

//lineal
const
//  DataLength = 100000;
  DataLength = 10;

type
  TData = array of TGLfloat;

var
  Data: TData;

type
  TVB = record
    VAO,
    VBO, TBO: GLuint;
  end;

var
  VBData: TVB;

  // https://open.gl/feedback
  // https://vis.uni-jena.de/Lecture/ComputerGraphics/Lec11_TransformFeedback.pdf
  // https://mathweb.ucsd.edu/~sbuss/MathCG2/OpenGLsoft/Chap1TransformFeedback/C1TFexplain.html

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
  glTransformFeedbackVaryings(ProgramObject, Length(feedbackVarings), PPGLchar(feedbackVarings), GL_INTERLEAVED_ATTRIBS);



  glLinkProgram(ProgramObject);

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

  CreateScene;
  OutputScene;
end;

procedure TForm1.CreateScene;
var
  i: integer;
begin
  SetLength(Data, DataLength);
  for i := 0 to Length(Data) - 1 do begin
    Data[i] := i;
  end;

  ProgramID := InitShader('Vertexshader.glsl');
  glUseProgram(programID);

  glGenVertexArrays(1, @VBData.VAO);
  glBindVertexArray(VBData.VAO);

  glGenBuffers(1, @VBData.VBO);
  glBindBuffer(GL_ARRAY_BUFFER, VBData.VBO);
  glBufferData(GL_ARRAY_BUFFER, Length(Data) * SizeOf(TGLfloat), PGLvoid(Data), GL_STATIC_DRAW);

  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 1, GL_FLOAT, False, 0, nil);
end;

procedure TForm1.OutputScene;
var
  i, j: integer;
var
  feedbacks: TData;
  GPUTime, CPUTime, start: TDateTime;
  di:Integer;
begin
  SetLength(feedbacks, DataLength);
  di:=DataLength div 10;;
  WriteLn(di);

  start := now;
  glGenBuffers(1, @VBData.TBO);
  glBindBuffer(GL_ARRAY_BUFFER, VBData.TBO);
  glBufferData(GL_ARRAY_BUFFER, Length(feedbacks) * SizeOf(TGLfloat), nil, GL_DYNAMIC_READ);

  glEnable(GL_RASTERIZER_DISCARD);
  glBindBufferBase(GL_TRANSFORM_FEEDBACK_BUFFER, 0, VBData.TBO);
  glBeginTransformFeedback(GL_POINTS);

  glDrawArrays(GL_POINTS, 0, Length(Data));

  glEndTransformFeedback;
  glFlush;

  glGetBufferSubData(GL_TRANSFORM_FEEDBACK_BUFFER, 0, Length(feedbacks) * SizeOf(TGLfloat), PGLvoid(feedbacks));
  GPUTime := now - start;

  for i := 0 to Length(feedbacks)-1 do begin
    if i mod di = 0 then  WriteLn(i:10,'  ',feedbacks[i]: 20: 10);
  end;
  WriteLn();

  start := now;
  for i := 0 to Length(feedbacks) - 1 do begin
    feedbacks[i] := Data[i];
    for j := 0 to 1000000 - 1 do begin
      feedbacks[i] := Sqrt(Data[i]) + feedbacks[i];
    end;
  end;
  CPUTime := now - start;


  for i := 0 to Length(feedbacks)-1 do begin
    if i mod di = 0 then  WriteLn(i:10,'  ',feedbacks[i]: 20: 10);
  end;
  WriteLn();

  WriteLn('GPU: ', GPUTime: 20: 20);
  WriteLn('CPU: ', CPUTime: 20: 20);

  WriteLn;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  glDeleteProgram(ProgramID);

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
