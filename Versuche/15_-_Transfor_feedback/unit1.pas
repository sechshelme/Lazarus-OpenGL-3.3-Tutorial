unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, OpenGLContext, Forms, Controls, Graphics,
  Dialogs, ExtCtrls,
  dglOpenGL, oglContext, oglShader;

type

  { TForm1 }

  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    ogc: TContext;
    shader: TShader;
    procedure InitShader(VertexDatei: string);
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
  DataLength = 8;

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

procedure TForm1.InitShader(VertexDatei: string);
const
  feedbackVarings: array of PGLchar = ('outValue0', 'outValue1', 'multi', 'divi');
begin
  shader := TShader.Create;
  shader.LoadShaderObjectFromFile(GL_VERTEX_SHADER, VertexDatei);

  // Feedback
  glTransformFeedbackVaryings(shader.ID, Length(feedbackVarings), PPGLchar(feedbackVarings), GL_INTERLEAVED_ATTRIBS);

  shader.LinkProgramm;
  shader.UseProgram;
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

  InitShader('Vertexshader.glsl');

  glGenVertexArrays(1, @VBData.VAO);
  glBindVertexArray(VBData.VAO);

  glGenBuffers(1, @VBData.VBO);
  glBindBuffer(GL_ARRAY_BUFFER, VBData.VBO);
  glBufferData(GL_ARRAY_BUFFER, Length(Data) * SizeOf(TGLfloat), PGLvoid(Data), GL_STATIC_DRAW);

  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 1, GL_FLOAT, False, 0, nil);
end;

procedure TForm1.OutputScene;
type
  TFeedBack = record
    sqrt, pow, multi, dive: GLfloat;
  end;
var
  i: integer;
  feedbacks: array of TFeedBack = nil;
begin
  SetLength(feedbacks, DataLength);
  glGenBuffers(1, @VBData.TBO);
  glBindBuffer(GL_ARRAY_BUFFER, VBData.TBO);
  glBufferData(GL_ARRAY_BUFFER, Length(feedbacks) * SizeOf(TFeedBack), nil, GL_DYNAMIC_READ);

  glEnable(GL_RASTERIZER_DISCARD);
  glBindBufferBase(GL_TRANSFORM_FEEDBACK_BUFFER, 0, VBData.TBO);
  glBeginTransformFeedback(GL_POINTS);

  glDrawArrays(GL_POINTS, 0, Length(Data));

  glEndTransformFeedback;
  glFlush;

  glGetBufferSubData(GL_TRANSFORM_FEEDBACK_BUFFER, 0, Length(feedbacks) * SizeOf(TFeedBack), PGLvoid(feedbacks));

  for i := 0 to Length(feedbacks) - 1 do begin
    WriteLn(feedbacks[i].sqrt: 10: 5, '   ', feedbacks[i].pow: 10: 5, '   ', feedbacks[i].multi: 10: 5, '   ', feedbacks[i].dive: 10: 5);
  end;
  WriteLn;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  shader.Free;

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
