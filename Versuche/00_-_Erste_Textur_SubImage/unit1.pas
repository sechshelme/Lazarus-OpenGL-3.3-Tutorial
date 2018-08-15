unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, Menus,
  dglOpenGL,
  oglContext, oglShader, oglVector, oglMatrix;

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
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

//image image.png

(*
Es ist möglich sehr schnell die Daten des Texturpuffers auszutauschen.
Dies geschieht mit <b>glTexSubImage2D(...</b>.
*)

//lineal

type
  TQuad = array[0..1] of TFace3D;

const
  Quad: TQuad =
    (((-0.8, -0.8, 0.0), (0.8, 0.8, 0.0), (-0.8, 0.8, 0.0)),
    ((-0.8, -0.8, 0.0), (0.8, -0.8, 0.0), (0.8, 0.8, 0.0)));

  TextureVertex: array[0..5] of TVector2f =
    ((0.0, 0.0), (1.0, 1.0), (0.0, 1.0),
    (0.0, 0.0), (1.0, 0.0), (1.0, 1.0));

  Textur32_0: packed array[0..1, 0..1, 0..3] of byte = ((($FF, $00, $00, $FF), ($00, $FF, $00, $FF)), (($00, $00, $FF, $FF), ($FF, $00, $00, $FF)));
  Textur32_1: packed array[0..1, 0..1, 0..3] of byte = ((($00, $FF, $FF, $FF), ($FF, $00, $FF, $FF)), (($FF, $FF, $00, $FF), ($00, $FF, $FF, $FF)));

type
  TVB = record
    VAO,
    VBOVertex, VBOTex: GLuint;
  end;

var
  RotMatrix, TransMatrix, prodMatrix: TMatrix;
  Matrix_ID: GLint;

  VBQuad: TVB;
  textureID0: GLuint;


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
  Shader := TShader.Create([FileToStr('Vertexshader.glsl'), FileToStr('Fragmentshader.glsl')]);
  with Shader do begin
    UseProgram;
    Matrix_ID := UniformLocation('mat');
    glUniform1i(UniformLocation('Sampler'), 0);
  end;
  RotMatrix.Identity;
  TransMatrix.Identity;
  prodMatrix.Identity;
  TransMatrix.Translate(0.5, 0.0, 0.0);   // TransMatrix um 0.5 nach links verschieben.

  glGenVertexArrays(1, @VBQuad.VAO);

  glGenBuffers(1, @VBQuad.VBOVertex);
  glGenBuffers(1, @VBQuad.VBOTex);
end;

(*
Texturen laden
*)
//code+
procedure TForm1.InitScene;
begin
  // ------------ Texture laden --------------

  glGenTextures(1, @textureID0);
  glBindTexture(GL_TEXTURE_2D, textureID0);

  glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, 2, 2, 0, GL_RGBA, GL_UNSIGNED_BYTE, nil);

  glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
  glBindTexture(GL_TEXTURE_2D, 0);

  glClearColor(0.6, 0.6, 0.4, 1.0); // Hintergrundfarbe

  // Daten für Rechteck
  glBindVertexArray(VBQuad.VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBOVertex);
  glBufferData(GL_ARRAY_BUFFER, sizeof(Quad), @Quad, GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 3, GL_FLOAT, False, 0, nil);

  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBOTex);
  glBufferData(GL_ARRAY_BUFFER, sizeof(TextureVertex), @TextureVertex, GL_STATIC_DRAW);
  glEnableVertexAttribArray(10);
  glVertexAttribPointer(10, 2, GL_FLOAT, False, 0, nil);
end;
//code-

(*
*)
//code+
procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT);

  glBindTexture(GL_TEXTURE_2D, textureID0);
  //code-

  Shader.UseProgram;

  prodMatrix := TransMatrix * RotMatrix;
  prodMatrix.Uniform(Matrix_ID);

  // Zeichne Quadrat
  glBindVertexArray(VBQuad.VAO);
  glDrawArrays(GL_TRIANGLES, 0, Length(Quad) * 3);


  ogc.SwapBuffers;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Timer1.Enabled := False;

  Shader.Free;

  glDeleteTextures(1, @textureID0);
  glDeleteVertexArrays(1, @VBQuad.VAO);
  glDeleteBuffers(1, @VBQuad.VBOVertex);
  glDeleteBuffers(1, @VBQuad.VBOTex);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
const
  step: GLfloat = 0.01;

const  z: integer=1;
begin
  if z > 10 then begin
    glTexSubImage2D(GL_TEXTURE_2D, 0, 0, 0, 2, 2, GL_RGBA, GL_UNSIGNED_BYTE, @Textur32_0);
  end else begin
    glTexSubImage2D(GL_TEXTURE_2D, 0, 0, 0, 2, 2, GL_RGBA, GL_UNSIGNED_BYTE, @Textur32_1);
  end;
  if z > 20 then begin
    z := 0;
  end;
  Inc(z);

  RotMatrix.RotateC(step);
  ogcDrawScene(Sender);
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
