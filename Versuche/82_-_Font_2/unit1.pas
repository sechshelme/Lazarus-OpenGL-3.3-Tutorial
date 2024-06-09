unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, Menus,
  oglglad_gl,
  oglContext, oglShader, oglVector, oglMatrix,
  oglTextur; // Unit für Texturen

type

  { TForm1 }

  TForm1 = class(TForm)
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    ogc: TContext;
    Shader: TShader; // Shader Klasse
    procedure CreateScene;
    procedure InitScene;
    procedure ogcDrawScene(Sender: TObject);
    function CreateFontBitmap: TBitmap;
    procedure OutText(s:String);
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
  QuadVertex: array[0..5] of TVector3f =
    ((-0.8, -0.8, 0.0), (0.8, 0.8, 0.0), (-0.8, 0.8, 0.0),
    (-0.8, -0.8, 0.0), (0.8, -0.8, 0.0), (0.8, 0.8, 0.0));

  TextureVertex: array[0..5] of TVector2f =
    ((1.0, 1.0), (0.0, 0.0), (1.0, 0.0),
    (1.0, 1.0), (0.0, 1.0), (0.0, 0.0));

type
  TVB = record
    VAO,
    VBOVertex,        // Vertex-Koordinaten
    VBOTex: GLuint;   // Textur-Koordianten
  end;

var
  Textur: TTexturBuffer;

  VBQuad: TVB;
  RotMatrix, ScaleMatrix, ProdMatrix: TMatrix;
  Chars_ID, Matrix_ID: GLint;

  { TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  //remove+
  Width := 340;
  Height := 240;
  //remove-
  ogc := TContext.Create(Self);
  ogc.OnPaint := @ogcDrawScene;

  CreateScene;
  InitScene;
  Timer1.Enabled := True;
end;

procedure TForm1.CreateScene;
begin
  Textur := TTexturBuffer.Create;

  glGenVertexArrays(1, @VBQuad.VAO);
  glGenBuffers(1, @VBQuad.VBOVertex);
  glGenBuffers(1, @VBQuad.VBOTex);

  Shader := TShader.Create([FileToStr('Vertexshader.glsl'), FileToStr('Fragmentshader.glsl')]);
  with Shader do begin
    UseProgram;
    Matrix_ID := UniformLocation('mat');
    Chars_ID := UniformLocation('chars');
    glUniform1i(UniformLocation('Sampler'), 0);  // Dem Sampler 0 zuweisen.
  end;
  RotMatrix.Identity;
  ScaleMatrix.Identity;
  ScaleMatrix.Scale(0.1);
  ProdMatrix.Identity;
end;

function TForm1.CreateFontBitmap: TBitmap;
const
  size = 32;
  FontCount = 94;
var
  i: integer;
begin
  Result := TBitmap.Create;
Result.SetSize(size div 2,size * FontCount);

  Result.Canvas.Font.Color := clRed;
  Result.Canvas.Font.Name := 'monospace';
  Result.Canvas.Font.Height := size div 2;
  for i := 0 to FontCount - 1 do begin
    Result.Canvas.TextOut(0, i * size, char(i + 32));
  end;
//  Result.SaveToFile('test.bmp');
end;

procedure TForm1.InitScene;
var
  bit: TBitmap;
begin
  bit := CreateFontBitmap;
  Textur.LoadTextures(bit.RawImage);
  bit.Free;

  glEnable(GL_BLEND);
  glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
  //code-

  glClearColor(0.6, 0.6, 0.4, 1.0);

  glBindVertexArray(VBQuad.VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBOVertex);
  glBufferData(GL_ARRAY_BUFFER, sizeof(QuadVertex), @QuadVertex, GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 0, nil);

  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBOTex);
  glBufferData(GL_ARRAY_BUFFER, sizeof(TextureVertex), @TextureVertex, GL_STATIC_DRAW);
  glEnableVertexAttribArray(1);
  glVertexAttribPointer(1, 2, GL_FLOAT, GL_FALSE, 0, nil);
end;

procedure TForm1.OutText(s: String);
var
  ci: array of TGLint = nil;
  len: SizeInt;
  i: integer;
begin
  len := Length(s);
  SetLength(ci, len);
  for i := 0 to len - 1 do begin
    ci[i] := uint32(s[i + 1]);
  end;
  glUniform1iv(Chars_ID, Length(ci), PGLint(ci));

  glBindVertexArray(VBQuad.VAO);
  glDrawArraysInstanced(GL_TRIANGLES, 0, Length(QuadVertex), Length(ci));

end;

procedure TForm1.ogcDrawScene(Sender: TObject);
const
  s: string = 'Hello!';
  counter: integer = 0;
var
  s2:String;
  m:Tmat4x4;
begin
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
  Textur.ActiveAndBind;
  Shader.UseProgram;

  m.Identity;
  ProdMatrix := ScaleMatrix * RotMatrix * m;
  ProdMatrix.Uniform(Matrix_ID);
  OutText('Hello World !');
  Inc(counter);

  m.Translate([0, 2, 0]);
  ProdMatrix := ScaleMatrix * RotMatrix * m;
  ProdMatrix.Uniform(Matrix_ID);
  WriteStr(s2, s, ' ', counter);
  OutText(s2);
  Inc(counter);

  ogc.SwapBuffers;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Textur.Free;

  Timer1.Enabled := False;

  glDeleteVertexArrays(1, @VBQuad.VAO);
  glDeleteBuffers(1, @VBQuad.VBOVertex);
  glDeleteBuffers(1, @VBQuad.VBOTex);

  Shader.Free;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
const
  step: GLfloat = 0.01;
begin
  RotMatrix.RotateC(step);
  ogcDrawScene(Sender);
end;

//lineal

(*
Die Shader sehen gleich aus, wie bei einer einfachen Textur.

<b>Vertex-Shader:</b>
*)
//includeglsl Vertexshader.glsl
//lineal

(*
<b>Fragment-Shader:</b>
*)
//includeglsl Fragmentshader.glsl

end.
