unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls,
  oglglad_gl, oglShader,  oglContext;

type

  { TForm1 }

  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    ogc: TContext;
    shader: TShader;
    procedure Initshader(VertexDatei: string);
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
  DataLength = 10000;

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

procedure TForm1.Initshader(VertexDatei: string);
const
  feedbackVarings: array of PGLchar = ('outValue');
begin
  shader := TShader.Create;
  shader.LoadShaderObjectFromFile(GL_VERTEX_SHADER, VertexDatei);

  // Feedback
  glTransformFeedbackVaryings(shader.ID, Length(feedbackVarings), PPGLchar(feedbackVarings), GL_INTERLEAVED_ATTRIBS);

  shader.LinkProgram;
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
  glVertexAttribPointer(0, 1, GL_FLOAT, GL_FALSE, 0, nil);
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
