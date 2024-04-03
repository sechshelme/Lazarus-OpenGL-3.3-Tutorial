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
    function CreateFontBitmat: TBitmap;
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

//image image.png

(*
Texturen werden erst richtig interessant, wen noch der Alpha-Kanal verwendet wird.
Wie hier im Beispiel ein Baum.
<b>Hinweis:</b> Das Z-Bufferproblem, wie bei einfachen Alphablending muss bei Alphatexturen auch beachtet werden. Siehe [[Lazarus_-_OpenGL_3.3_Tutorial#Alpha_Blending|Alphablending]].
*)
//lineal

const
  QuadVertex: array[0..5] of TVector3f =
    ((-0.8, -0.8, 0.0), (0.8, 0.8, 0.0), (-0.8, 0.8, 0.0),
    (-0.8, -0.8, 0.0), (0.8, -0.8, 0.0), (0.8, 0.8, 0.0));

  TextureVertex: array[0..5] of TVector2f =
    ((0.0, 0.0), (1.0, 1.0), (0.0, 1.0),
    (0.0, 0.0), (1.0, 0.0), (1.0, 1.0));

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

function TForm1.CreateFontBitmat: TBitmap;
const
  size = 32;
  FontCount = 94;
var
  i: integer;
begin
  Result := TBitmap.Create;
  Result.Width := size * FontCount;
  Result.Height := size;

  Result.Canvas.Font.Color := clRed;
  Result.Canvas.Font.Name := 'monospace';
  Result.Canvas.Font.Height:=size div 2;
  for i := 0 to FontCount - 1 do begin
    Result.Canvas.TextOut(I * size, 0, char(i + 32));
  end;
end;

procedure TForm1.InitScene;
var
  bit: TBitmap;
begin
  bit := CreateFontBitmat;
  Textur.LoadTextures(bit.RawImage);
  bit.Free;

  glEnable(GL_BLEND);                                  // Alphablending an
  glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);   // Sortierung der Primitiven von hinten nach vorne.
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

procedure TForm1.ogcDrawScene(Sender: TObject);
const
    s:String= 'Hello!';
    counter:Integer=0;
var
  ci: array of TGLint = nil;
  len: SizeInt;
  i: integer;     s2:string;
begin
  WriteStr(s2, s,' ',counter);
  WriteLn(s2);
  len := Length(s2);
  SetLength(ci, len);
  for i := 0 to len - 1 do begin
    ci[i] := uint32(s2[i+1]);
  end;
  Inc(counter);

  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);

  Textur.ActiveAndBind; // Textur binden

  Shader.UseProgram;


  ProdMatrix := ScaleMatrix * RotMatrix;
  ProdMatrix.Uniform(Matrix_ID);

  glUniform1iv(Chars_ID, Length(s2), PGLint(ci));

  // Zeichne Quadrat
  glBindVertexArray(VBQuad.VAO);
  glDrawArraysInstanced(GL_TRIANGLES, 0, Length(QuadVertex), Length(s2));

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
