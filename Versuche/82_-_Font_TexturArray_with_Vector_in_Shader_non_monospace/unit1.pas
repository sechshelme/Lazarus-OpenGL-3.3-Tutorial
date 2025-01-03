unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,        GraphType,
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

type
  TVB = record
    VAO: GLuint;
  end;

var
  textureID: GLuint = 0;
  VBQuad: TVB;
  RotMatrix, ScaleMatrix, ProdMatrix: Tmat4x4;
  UniformID: record
    Chars, CharsOfs, Matrix: GLint;
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

// https://github.com/turborium/Dither3/blob/main/BitmapPixels.pas

function CreateBitmap(w, h:Integer):TBitmap;
var
  ra:TRawImage;
  i: Integer;
begin
  ra.Init;
  ra.Description.Init_BPP32_R8G8B8A8_BIO_TTB(w,h);
  ra.DataSize:=w*h*4;
  ra.CreateData(False);
//  ra.Description.Init_BPP32_B8G8R8A8_BIO_TTB(w,h);
//  ra.Description.LineOrder:=riloBottomToTop;


  Result:=TBitmap.Create;
//  Result.RawImage.Description.Init_BPP32_R8G8B8A8_BIO_TTB(w,h);
//  Result.RawImage.Description.Init_BPP32_B8G8R8A8_BIO_TTB(w,h);
    Result.SetSize(w,h);

//  Result.LoadFromRawImage(ra,True);
//  Result.Transparent:=True;

WriteLn('w: ',Result.Width,'   h: ',Result.Height);

//for i:= 0 to w  * h  do Result.RawImage.Data[i]:=$55;
end;

function TForm1.CreateFontTexture: GLuint;
const
  size = 128;
  FontCount = 94;
var
  i: integer;
  bit: TBitmap;
begin
  bit:=CreateBitmap(size div 2, size * FontCount);

  bit.Canvas.Pen.Color := clRed;
    bit.Canvas.Brush.Color := clGreen;
  bit.Canvas.Brush.Style := bsClear;
  bit.Canvas.Font.Color := clYellow;
  //  bit.Canvas.Font.Name := 'monospace';
  bit.Canvas.Font.Height := size div 2;
  for i := 0 to FontCount - 1 do begin
//        bit.Canvas.Rectangle(0, i * size, size div 2, i * size + size);
    bit.Canvas.TextOut(0, i * size, char(i + 32));
  end;

  glGenTextures(1, @Result);
  glActiveTexture(GL_TEXTURE0);
  glBindTexture(GL_TEXTURE_2D_ARRAY, Result);
  {$IFDEF Linux}
  glTexImage3D(GL_TEXTURE_2D_ARRAY, 0, GL_RGBA, bit.Width, bit.Height div FontCount, FontCount, 0, GL_BGRA, GL_UNSIGNED_BYTE, bit.RawImage.Data);
  {$ENDIF}

  {$IFDEF Windows}
  glTexImage3D(GL_TEXTURE_2D_ARRAY, 0, GL_RGBA, bit.Width, bit.Height div FontCount, FontCount, 0, GL_RGB, GL_UNSIGNED_BYTE, bit.RawImage.Data);
  {$ENDIF}

  glTexParameteri(GL_TEXTURE_2D_ARRAY, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
  glTexParameteri(GL_TEXTURE_2D_ARRAY, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
  glTexParameteri(GL_TEXTURE_2D_ARRAY, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
  glTexParameteri(GL_TEXTURE_2D_ARRAY, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);

  bit.Free;
end;

procedure TForm1.CreateScene;
begin
  glGenVertexArrays(1, @VBQuad.VAO);

  Shader := TShader.Create([FileToStr('Vertexshader.glsl'), FileToStr('Fragmentshader.glsl')]);
  with Shader do begin
    UseProgram;
    UniformID.Matrix := UniformLocation('mat');
    UniformID.Chars := UniformLocation('chars');
    UniformID.CharsOfs := UniformLocation('charsOfs');
    glUniform1i(UniformLocation('Sampler'), 0);  // Dem Sampler 0 zuweisen.
  end;
  RotMatrix.Identity;
  ScaleMatrix.Identity;
  ScaleMatrix.Scale(0.2);
  ProdMatrix.Identity;

  textureID := CreateFontTexture;

  glEnable(GL_BLEND);
  glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
  //code-

  glClearColor(0.3, 0.3, 0.2, 1.0);

  glBindVertexArray(0);
end;

procedure TForm1.OutText(s: string);
var
  ci: array of TGLint = nil;
  CharOfs: array of TGLfloat = nil;
  len: SizeInt;
  i: integer;
  index: integer = 0;
begin
  glBindTexture(GL_TEXTURE_2D_ARRAY, textureID);
  len := Length(s);
  SetLength(ci, len);
  SetLength(CharOfs, len + 1);
  CharOfs[index] := 0;
  for i := 0 to len - 1 do begin
    ci[i] := uint32(s[i + 1]);
    Inc(index);
    CharOfs[index] := CharOfs[index - 1] + Canvas.TextWidth(s[i + 1]) / 12;
  end;
  glUniform1iv(UniformID.Chars, Length(ci), PGLint(ci));
  glUniform1fv(UniformID.CharsOfs, Length(CharOfs), PGLfloat(CharOfs));

  glBindVertexArray(VBQuad.VAO);
  glDrawArraysInstanced(GL_TRIANGLES, 0, 6, Length(ci));
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
  m.Translate([-3, -0.25, 0]);
  ProdMatrix := ScaleMatrix * RotMatrix * m;
  ProdMatrix.Uniform(UniformID.Matrix);
  OutText('Hallo Welt !');
  Inc(counter);

  m.Translate([0, 0.5, 0]);
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
