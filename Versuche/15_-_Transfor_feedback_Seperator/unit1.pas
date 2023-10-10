unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, OpenGLContext, Forms, Controls, Graphics,
  Dialogs, ExtCtrls,
  dglOpenGL, oglContext,oglDebug, oglShader;

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
    VBO, TBO0, TBO1: GLuint;
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
  feedbackVarings: array of PGLchar = ('outValue0', 'outValue1');
begin
  shader := TShader.Create;
  shader.LoadShaderObjectFromFile(GL_VERTEX_SHADER, VertexDatei);

  // Feedback
//  glTransformFeedbackVaryings(shader.ID, Length(feedbackVarings), PPGLchar(feedbackVarings), GL_INTERLEAVED_ATTRIBS);
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
  ogc := TContext.Create(Self,True,4,6);

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
type
  TFeedBack = record
    sqrt, pow: GLfloat;
  end;
var
  i: integer;
  feedbacks: array of TFeedBack = nil;
var
  query: GLuint;
  PrimitivesCount: GLuint;
begin
  SetLength(feedbacks, DataLength);

  glGenQueries(1, @query);

  glGenBuffers(1, @VBData.TBO0);
  glBindBuffer(GL_ARRAY_BUFFER, VBData.TBO0);
  glGenBuffers(1, @VBData.TBO1);
  glBindBuffer(GL_ARRAY_BUFFER, VBData.TBO1);

  glBindBufferBase(GL_TRANSFORM_FEEDBACK_BUFFER, 0, VBData.TBO0);
  glBindBufferBase(GL_TRANSFORM_FEEDBACK_BUFFER, 1, VBData.TBO1);

  glEnable(GL_RASTERIZER_DISCARD);

  glBeginTransformFeedback(GL_POINTS);
  glBeginQuery(GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN, query);
  glDrawArrays(GL_POINTS, 0, Length(Data));
  glEndQuery(GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN);
  glEndTransformFeedback;

  glFlush;

  glGetQueryObjectiv(query, GL_QUERY_RESULT, @PrimitivesCount);
  WriteLn('query: ', PrimitivesCount, #10);
  glDeleteQueries(1, @query);

  glGetBufferSubData(GL_TRANSFORM_FEEDBACK_BUFFER, 0, Length(feedbacks) * SizeOf(TFeedBack), PGLvoid(feedbacks));

  for i := 0 to Length(feedbacks) - 1 do begin
    WriteLn(Data[i]: 10: 5, '   ', feedbacks[i].sqrt: 10: 5, '   ', feedbacks[i].pow: 10: 5);
  end;
  WriteLn;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  shader.Free;

  glDeleteVertexArrays(1, @VBData.VAO);

  glDeleteBuffers(1, @VBData.VBO);
  glDeleteBuffers(1, @VBData.TBO0);
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
