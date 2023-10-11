unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, OpenGLContext, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, StdCtrls,
  dglOpenGL, oglContext, oglDebug, oglShader, oglVector;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    procedure SeperateClick(Sender: TObject);
    procedure InterleavedClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    ogc: TContext;
    shader: TShader;
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

// https://open.gl/feedback
// https://vis.uni-jena.de/Lecture/ComputerGraphics/Lec11_TransformFeedback.pdf
// https://mathweb.ucsd.edu/~sbuss/MathCG2/OpenGLsoft/Chap1TransformFeedback/C1TFexplain.html
// file:///home/tux/Downloads/CGDC_OpenGL_ES_3.0.pdf
// https://prideout.net/modern-opengl-prezo/

const
  DataLength = 16;

type
  TData = array of TGLfloat;

var
  Data: TData;

const
  feedbackVarings: array of PGLchar = ('outSqrt', 'outPow', 'outTest', 'outInt');

  //code-

procedure TForm1.FormCreate(Sender: TObject);
begin
  //remove+
  Width := 340;
  Height := 240;
  //remove-
  ogc := TContext.Create(Self);
  ogc.Visible := False;
end;

procedure TForm1.InterleavedClick(Sender: TObject);
type
  TVB = record
    VAO,
    VBO, TBO: GLuint;
  end;

  TFeedBack = record
    sqrt, pow: GLfloat;
    v3: TVector3i;
    outInt: array[0..5] of GLint;
  end;
var
  VBData: TVB;

  i, j: integer;
  feedbacks: array of TFeedBack = nil;

  query: GLuint;
  PrimitivesCount: GLuint;

begin
  SetLength(Data, DataLength);
  for i := 0 to Length(Data) - 1 do begin
    Data[i] := i;
  end;

  // --- Shader inizialisieren
  shader := TShader.Create;
  shader.LoadShaderObjectFromFile(GL_VERTEX_SHADER, 'Vertexshader.glsl');

  // Sagen, das man einen Interleaved Feedback will
  glTransformFeedbackVaryings(shader.ID, Length(feedbackVarings), PPGLchar(feedbackVarings), GL_INTERLEAVED_ATTRIBS);

  shader.LinkProgramm;
  shader.UseProgram;

  // --- VAO und VBO für den Input
  glGenVertexArrays(1, @VBData.VAO);
  glBindVertexArray(VBData.VAO);

  glGenBuffers(1, @VBData.VBO);
  glBindBuffer(GL_ARRAY_BUFFER, VBData.VBO);
  glBufferData(GL_ARRAY_BUFFER, Length(Data) * SizeOf(TGLfloat), PGLvoid(Data), GL_STATIC_DRAW);

  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 1, GL_FLOAT, False, 0, nil);

  // --- TBO für den Output
  SetLength(feedbacks, DataLength);
  glGenBuffers(1, @VBData.TBO);
  glBindBuffer(GL_ARRAY_BUFFER, VBData.TBO);
  glBufferData(GL_ARRAY_BUFFER, Length(feedbacks) * SizeOf(TFeedBack), nil, GL_DYNAMIC_READ);
  glBindBufferBase(GL_TRANSFORM_FEEDBACK_BUFFER, 0, VBData.TBO);

  // --- Rendervorgang starten
  glEnable(GL_RASTERIZER_DISCARD);
  glGenQueries(1, @query);
  glBeginQuery(GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN, query);
  glBeginTransformFeedback(GL_POINTS);
  glDrawArrays(GL_POINTS, 0, Length(Data));
  glEndTransformFeedback;
  glEndQuery(GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN);
  glFlush;

  // --- Anzahl Primitiven ausgeben
  glGetQueryObjectiv(query, GL_QUERY_RESULT, @PrimitivesCount);
  WriteLn('query: ', PrimitivesCount, #10);
  glDeleteQueries(1, @query);

  // --- TBO Binden und auslesen
  glBindBuffer(GL_ARRAY_BUFFER, VBData.TBO);
  glGetBufferSubData(GL_ARRAY_BUFFER, 0, Length(feedbacks) * SizeOf(TFeedBack), PGLvoid(feedbacks));

  // --- Die gelesenen Daten ausgeben
  for i := 0 to Length(feedbacks) - 1 do begin
    Write(Data[i]: 10: 5, '   ', feedbacks[i].sqrt: 10: 5, '   ', feedbacks[i].pow: 10: 5, '   ');
    Write(feedbacks[i].v3[0]: 10, '-', feedbacks[i].v3[1]: 10, '-', feedbacks[i].v3[2]: 10,'   ');

    for j := 0 to Length(feedbacks[i].outInt) - 1 do begin
      Write(feedbacks[i].outInt[j]);
      if j <> Length(feedbacks[i].outInt) - 1 then begin
        Write('-');
      end;
    end;
    WriteLn();
  end;
  WriteLn;

  // --- Alles freigeben
  shader.Free;
  glDeleteVertexArrays(1, @VBData.VAO);
  glDeleteBuffers(1, @VBData.VBO);
  glDeleteBuffers(1, @VBData.TBO);
end;

procedure TForm1.SeperateClick(Sender: TObject);
type
  TVB = record
    VAO,
    VBO, TBOSqrt, TBOPow, TBOv3, TBOIntArr: GLuint;
  end;
var
  VBData: TVB;
  i: integer;
  SqrtFeedbacks: array of GLfloat = nil;
  PowFeedbacks: array of GLfloat = nil;

  query: GLuint;
  PrimitivesCount: GLuint;
begin
  SetLength(Data, DataLength);
  for i := 0 to Length(Data) - 1 do begin
    Data[i] := i;
  end;

  // --- Shader inizialisieren
  shader := TShader.Create;
  shader.LoadShaderObjectFromFile(GL_VERTEX_SHADER, 'Vertexshader.glsl');

  // Sagen, das man einen Seperator Feedback will
  glTransformFeedbackVaryings(shader.ID, Length(feedbackVarings), PPGLchar(feedbackVarings), GL_SEPARATE_ATTRIBS);

  shader.LinkProgramm;
  shader.UseProgram;

  // --- VAO und VBO für den Input
  glGenVertexArrays(1, @VBData.VAO);
  glBindVertexArray(VBData.VAO);

  glGenBuffers(1, @VBData.VBO);
  glBindBuffer(GL_ARRAY_BUFFER, VBData.VBO);
  glBufferData(GL_ARRAY_BUFFER, Length(Data) * SizeOf(TGLfloat), PGLvoid(Data), GL_STATIC_DRAW);

  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 1, GL_FLOAT, False, 0, nil);

  // --- TBO für den Output
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

  glGenBuffers(1, @VBData.TBOv3);
  glBindBuffer(GL_TRANSFORM_FEEDBACK_BUFFER, VBData.TBOv3);
  glBufferData(GL_TRANSFORM_FEEDBACK_BUFFER, Length(SqrtFeedbacks) * SizeOf(TVector3i), nil, GL_DYNAMIC_READ);
  glBindBufferBase(GL_TRANSFORM_FEEDBACK_BUFFER, 2, VBData.TBOv3);

  glGenBuffers(1, @VBData.TBOIntArr);
  glBindBuffer(GL_TRANSFORM_FEEDBACK_BUFFER, VBData.TBOIntArr);
  glBufferData(GL_TRANSFORM_FEEDBACK_BUFFER, Length(SqrtFeedbacks) * SizeOf(GLint) * 6, nil, GL_DYNAMIC_READ);
  glBindBufferBase(GL_TRANSFORM_FEEDBACK_BUFFER, 3, VBData.TBOIntArr);


  // --- Rendervorgang starten
  glEnable(GL_RASTERIZER_DISCARD);
  glGenQueries(1, @query);
  glBeginQuery(GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN, query);
  glBeginTransformFeedback(GL_POINTS);
  glDrawArrays(GL_POINTS, 0, Length(Data));
  glEndTransformFeedback;
  glEndQuery(GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN);
  glDisable(GL_RASTERIZER_DISCARD);
  glFlush;

  // --- Anzahl Primitiven ausgeben
  glGetQueryObjectiv(query, GL_QUERY_RESULT, @PrimitivesCount);
  WriteLn('query: ', PrimitivesCount, #10);
  glDeleteQueries(1, @query);

  // --- TBO Binden und auslesen
  glBindBuffer(GL_TRANSFORM_FEEDBACK_BUFFER, VBData.TBOSqrt);
  glGetBufferSubData(GL_TRANSFORM_FEEDBACK_BUFFER, 0, Length(SqrtFeedbacks) * SizeOf(GLfloat), PGLvoid(SqrtFeedbacks));

  glBindBuffer(GL_TRANSFORM_FEEDBACK_BUFFER, VBData.TBOPow);
  glGetBufferSubData(GL_TRANSFORM_FEEDBACK_BUFFER, 0, Length(PowFeedbacks) * SizeOf(GLfloat), PGLvoid(PowFeedbacks));

  // --- Die gelesenen Daten ausgeben
  for i := 0 to Length(SqrtFeedbacks) - 1 do begin
    WriteLn(Data[i]: 10: 5, '   ', SqrtFeedbacks[i]: 10: 5, '   ', PowFeedbacks[i]: 10: 5);
  end;

  // --- Alles freigeben
  shader.Free;
  glDeleteVertexArrays(1, @VBData.VAO);
  glDeleteBuffers(1, @VBData.VBO);
  glDeleteBuffers(1, @VBData.TBOSqrt);
  glDeleteBuffers(1, @VBData.TBOPow);
end;


//lineal
(*
<b>Vertex-Shader:</b>
*)
//includeglsl Vertexshader.glsl
//lineal

(*
<b>Fragment-Shader:</b>
*)
//includeglsl Fragmentshader.glsl


end.
