unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, Menus,
  oglglad_gl,
  oglContext, oglShader, oglVector, oglMatrix;

type
  TForm1 = class(TForm)
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    ogc: TContext;
    Shader: TShader;
    procedure CreateScene;
    procedure ogcDrawScene(Sender: TObject);
    function CreateFontTexture: GLuint;
    procedure OutText(s: string);
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
    ((0.0, 1.0), (1.0, 0.0), (0.0, 0.0),
    (0.0, 1.0), (1.0, 1.0), (1.0, 0.0));

type
  TVB = record
    VAO,
    VBOVertex,
    VBOTex: GLuint;
  end;

var
  textureID: GLuint = 0;
  VBQuad: TVB;
  RotMatrix, ScaleMatrix, ProdMatrix: Tmat4x4;
  UniformID:record
  Chars, Matrix: GLint;
  end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  //remove+
  Width := 340;
  Height := 240;
  //remove-
  ogc := TContext.Create(Self);
  ogc.OnPaint := @ogcDrawScene;

  CreateScene;
  Timer1.Enabled := True;
end;

// https://www.khronos.org/opengl/wiki/Array_Texture
// https://www.reddit.com/r/opengl/comments/ercdsq/only_getting_first_image_in_sampler2darray/

function TForm1.CreateFontTexture: GLuint;
const
  size = 32;
  FontCount = 94;
var
  i: integer;
  bit: TBitmap;
begin
  bit := TBitmap.Create;
  bit.SetSize(size div 2, size * FontCount);

  bit.Canvas.Font.Color := clRed;
  bit.Canvas.Font.Name := 'monospace';
  bit.Canvas.Font.Height := size div 2;
  for i := 0 to FontCount - 1 do begin
    bit.Canvas.TextOut(0, i * size, char(i + 32));
  end;

  glGenTextures(1, @Result);
  glActiveTexture(GL_TEXTURE0);
  glBindTexture(GL_TEXTURE_2D_ARRAY, Result);
  glTexImage3D(GL_TEXTURE_2D_ARRAY, 0, GL_RGBA, bit.Width, bit.Height div FontCount, FontCount, 0, GL_BGRA, GL_UNSIGNED_BYTE, bit.RawImage.Data);

  glTexParameteri(GL_TEXTURE_2D_ARRAY, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
  glTexParameteri(GL_TEXTURE_2D_ARRAY, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
  glTexParameteri(GL_TEXTURE_2D_ARRAY, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
  glTexParameteri(GL_TEXTURE_2D_ARRAY, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);

  bit.Free;
end;

procedure TForm1.CreateScene;
begin
  glGenVertexArrays(1, @VBQuad.VAO);
  glGenBuffers(1, @VBQuad.VBOVertex);
  glGenBuffers(1, @VBQuad.VBOTex);

  Shader := TShader.Create([FileToStr('Vertexshader.glsl'), FileToStr('Fragmentshader.glsl')]);
  with Shader do begin
    UseProgram;
   UniformID.Matrix := UniformLocation('mat');
    UniformID.Chars := UniformLocation('chars');
    glUniform1i(UniformLocation('Sampler'), 0);  // Dem Sampler 0 zuweisen.
  end;
  RotMatrix.Identity;
  ScaleMatrix.Identity;
  ScaleMatrix.Scale(0.1);
  ProdMatrix.Identity;

  textureID := CreateFontTexture;

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

procedure TForm1.OutText(s: string);
var
  ci: array of TGLint = nil;
  len: SizeInt;
  i: integer;
begin
  glBindTexture(GL_TEXTURE_2D_ARRAY, textureID);
  len := Length(s);
  SetLength(ci, len);
  for i := 0 to len - 1 do begin
    ci[i] := uint32(s[i + 1]);
  end;
  glUniform1iv(UniformID.Chars, Length(ci), PGLint(ci));

  glBindVertexArray(VBQuad.VAO);
  glDrawArraysInstanced(GL_TRIANGLES, 0, Length(QuadVertex), Length(ci));
end;

procedure TForm1.ogcDrawScene(Sender: TObject);
const
  s: string = 'Hello!';
  counter: integer = 0;
var
  s2: string;
  m: Tmat4x4;
begin
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);

  Shader.UseProgram;

  m.Identity;
  ProdMatrix := ScaleMatrix * RotMatrix * m;
  ProdMatrix.Uniform(UniformID.Matrix);
  OutText('Hello World !');
  Inc(counter);

  m.Translate([0, 2, 0]);
  ProdMatrix := ScaleMatrix * RotMatrix * m;
  ProdMatrix.Uniform(UniformID.Matrix);
  WriteStr(s2, s, ' ', counter);
  OutText(s2);
  Inc(counter);

  ogc.SwapBuffers;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Timer1.Enabled := False;

  glDeleteTextures(1, @textureID);
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