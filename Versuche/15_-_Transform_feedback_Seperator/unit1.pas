unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls,
  dglOpenGL, oglContext, oglDebug, oglShader;

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
  DataLength = 16;

type
  TData = array of TGLfloat;

var
  Data: TData;

type
  TVB = record
    VAO,
    VBO, TBOSqrt, TBOPow: GLuint;
  end;

var
  VBData: TVB;

  // https://open.gl/feedback
  // https://vis.uni-jena.de/Lecture/ComputerGraphics/Lec11_TransformFeedback.pdf
  // https://mathweb.ucsd.edu/~sbuss/MathCG2/OpenGLsoft/Chap1TransformFeedback/C1TFexplain.html
  // file:///home/tux/Downloads/CGDC_OpenGL_ES_3.0.pdf
  // https://prideout.net/modern-opengl-prezo/

procedure TForm1.InitShader(VertexDatei: string);
const
  feedbackVarings: array of PGLchar = ('outSqrt', 'outPow');
begin
  shader := TShader.Create;
  shader.LoadShaderObjectFromFile(GL_VERTEX_SHADER, VertexDatei);

  // Feedback
  glTransformFeedbackVaryings(shader.ID, Length(feedbackVarings), PPGLchar(feedbackVarings), GL_SEPARATE_ATTRIBS);

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
  InitOpenGLDebug;
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
var
  i: integer;
  SqrtFeedbacks: array of GLfloat = nil;
  PowFeedbacks: array of GLfloat = nil;

  query: GLuint;
  PrimitivesCount: GLuint;

begin
  SetLength(SqrtFeedbacks, DataLength);
  SetLength(PowFeedbacks, DataLength);

  glGenBuffers(1, @VBData.TBOSqrt);
  glBindBuffer(GL_TRANSFORM_FEEDBACK_BUFFER, VBData.TBOSqrt);
  glBufferData(GL_TRANSFORM_FEEDBACK_BUFFER, Length(SqrtFeedbacks) * SizeOf(GLfloat), nil, GL_DYNAMIC_READ);
  glBindBufferBase(GL_TRANSFORM_FEEDBACK_BUFFER, 0, VBData.TBOSqrt);

  glGenBuffers(1, @VBData.TBOPow);
  glBindBuffer(GL_TRANSFORM_FEEDBACK_BUFFER, VBData.TBOPow);
  glBufferData(GL_TRANSFORM_FEEDBACK_BUFFER, Length(SqrtFeedbacks) * SizeOf(GLfloat), nil, GL_DYNAMIC_READ);
  glBindBufferBase(GL_TRANSFORM_FEEDBACK_BUFFER, 1, VBData.TBOPow);


  glGenQueries(1, @query);
  glEnable(GL_RASTERIZER_DISCARD);
  glBeginQuery(GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN, query);
  glBeginTransformFeedback(GL_POINTS);
  glDrawArrays(GL_POINTS, 0, Length(Data));
  glEndTransformFeedback;
  glEndQuery(GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN);
  glDisable(GL_RASTERIZER_DISCARD);

  glFlush;

  glGetQueryObjectiv(query, GL_QUERY_RESULT, @PrimitivesCount);
  WriteLn('query: ', PrimitivesCount, #10);
  glDeleteQueries(1, @query);

  glBindBuffer(GL_TRANSFORM_FEEDBACK_BUFFER, VBData.TBOSqrt);
  glGetBufferSubData(GL_TRANSFORM_FEEDBACK_BUFFER, 0, Length(SqrtFeedbacks) * SizeOf(GLfloat), PGLvoid(SqrtFeedbacks));

  glBindBuffer(GL_TRANSFORM_FEEDBACK_BUFFER, VBData.TBOPow);
  glGetBufferSubData(GL_TRANSFORM_FEEDBACK_BUFFER, 0, Length(PowFeedbacks) * SizeOf(GLfloat), PGLvoid(PowFeedbacks));

  for i := 0 to Length(SqrtFeedbacks) - 1 do begin
    WriteLn(Data[i]: 10: 5, '   ', SqrtFeedbacks[i]: 10: 5, '   ', PowFeedbacks[i]: 10: 5);
  end;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  shader.Free;

  glDeleteVertexArrays(1, @VBData.VAO);

  glDeleteBuffers(1, @VBData.VBO);
  glDeleteBuffers(1, @VBData.TBOSqrt);
  glDeleteBuffers(1, @VBData.TBOPow);
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
