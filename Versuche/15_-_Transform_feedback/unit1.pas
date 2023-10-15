unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, OpenGLContext, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, StdCtrls,
  dglOpenGL, oglContext, oglDebug, oglShader, oglVector, oglMatrix;

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

//code+
const
  DataLength = 16;

type
  TData = array of TGLfloat;

var
  Data: TData;

const
  feedbackVarings: array of PGLchar = ('outSqrt', 'outMat');

  //code-

procedure TForm1.FormCreate(Sender: TObject);
var
  i: integer;
begin
  //remove+
  Width := 340;
  Height := 240;
  //remove-
  ogc := TContext.Create(Self);
  ogc.Visible := False;

  // --- Eingabebuffer beladen
  SetLength(Data, DataLength);
  for i := 0 to Length(Data) - 1 do begin
    Data[i] := i;
  end;
end;

procedure TForm1.InterleavedClick(Sender: TObject);
type
  TVB = record
    VAO,
    VBO, TBO: GLuint;
  end;

  TFeedBack = record
    outSqrt: GLfloat;
    outMat: Tmat4x4;
  end;
var
  VBData: TVB;

  i, x, y: integer;
  feedbacks: array of TFeedBack = nil;

  query: GLuint;
  PrimitivesCount: GLuint;

begin
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
  glDeleteQueries(1, @query);

  // --- TBO Binden und auslesen
  glBindBuffer(GL_ARRAY_BUFFER, VBData.TBO);
  glGetBufferSubData(GL_ARRAY_BUFFER, 0, Length(feedbacks) * SizeOf(TFeedBack), PGLvoid(feedbacks));

  // --- Die gelesenen Daten ausgeben
  WriteLn('GL_INTERLEAVED_ATTRIBS:');
  for i := 0 to PrimitivesCount  - 1 do begin
    Write(Data[i]: 10: 5, '   ', feedbacks[i].outSqrt: 10: 5, '   ');
    for y := 0 to 3 do begin
      for x := 0 to 3 do begin
        Write(feedbacks[i].outMat[y, x]: 5: 1, '  ');
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
    VBO, TBOSqrt, TBOMat: GLuint;
  end;
var
  VBData: TVB;
  i, x,y: integer;
  SqrtFeedbacks: array of GLfloat = nil;
  MatFeedbacks: array of Tmat4x4 = nil;

  query: GLuint;
  PrimitivesCount: GLuint;
begin
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
  SetLength(MatFeedbacks, DataLength);

  glGenBuffers(1, @VBData.TBOSqrt);
  glBindBuffer(GL_TRANSFORM_FEEDBACK_BUFFER, VBData.TBOSqrt);
  glBufferData(GL_TRANSFORM_FEEDBACK_BUFFER, Length(SqrtFeedbacks) * SizeOf(GLfloat), nil, GL_DYNAMIC_READ);
  glBindBufferBase(GL_TRANSFORM_FEEDBACK_BUFFER, 0, VBData.TBOSqrt);

  glGenBuffers(1, @VBData.TBOMat);
  glBindBuffer(GL_TRANSFORM_FEEDBACK_BUFFER, VBData.TBOMat);
  glBufferData(GL_TRANSFORM_FEEDBACK_BUFFER, Length(MatFeedbacks) * SizeOf(Tmat4x4), nil, GL_DYNAMIC_READ);
  glBindBufferBase(GL_TRANSFORM_FEEDBACK_BUFFER, 1, VBData.TBOMat);


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
  glDeleteQueries(1, @query);

  // --- TBO Binden und auslesen
  glBindBuffer(GL_TRANSFORM_FEEDBACK_BUFFER, VBData.TBOSqrt);
  glGetBufferSubData(GL_TRANSFORM_FEEDBACK_BUFFER, 0, Length(SqrtFeedbacks) * SizeOf(GLfloat), PGLvoid(SqrtFeedbacks));

  glBindBuffer(GL_TRANSFORM_FEEDBACK_BUFFER, VBData.TBOMat);
  glGetBufferSubData(GL_TRANSFORM_FEEDBACK_BUFFER, 0, Length(MatFeedbacks) * SizeOf(Tmat4x4), PGLvoid(MatFeedbacks));

  // --- Die gelesenen Daten ausgeben
  WriteLn('GL_SEPARATE_ATTRIBS:');
  for i := 0 to PrimitivesCount - 1 do begin
    Write(Data[i]: 10: 5, '   ', SqrtFeedbacks[i]: 10: 5, '   ');
    for y := 0 to 3 do begin
      for x := 0 to 3 do begin
        Write(MatFeedbacks[i][y, x]: 5: 1, '  ');
      end;
    end;
    WriteLn();
  end;
  WriteLn();

  // --- Alles freigeben
  shader.Free;
  glDeleteVertexArrays(1, @VBData.VAO);
  glDeleteBuffers(1, @VBData.VBO);
  glDeleteBuffers(1, @VBData.TBOSqrt);
  glDeleteBuffers(1, @VBData.TBOMat);
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
