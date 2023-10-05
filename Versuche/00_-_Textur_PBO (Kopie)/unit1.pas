unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, Menus,
  dglOpenGL, oglDebug,
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
    procedure ogcDrawScene(Sender: TObject);
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

//image image.png

//lineal
const
  QuadVertex: array[0..5] of TVector3f =       // Koordinaten der Polygone.
    ((-0.8, -0.8, 0.0), (0.8, 0.8, 0.0), (-0.8, 0.8, 0.0),
    (-0.8, -0.8, 0.0), (0.8, -0.8, 0.0), (0.8, 0.8, 0.0));

  TextureVertex: array[0..5] of TVector2f =    // Textur-Koordinaten
    ((0.0, 0.0), (1.0, 1.0), (0.0, 1.0),
    (0.0, 0.0), (1.0, 0.0), (1.0, 1.0));

type
  TTexture32 = packed array[0..1, 0..1, 0..3] of byte;
  PTexture32 = ^TTexture32;

var
  Textur32_0: TTexture32 = ((($FF, $00, $00, $FF), ($00, $FF, $00, $FF)), (($00, $00, $FF, $FF), ($FF, $00, $00, $FF)));

type
  TVB = record
    PBO: array[0..1] of GLuint;
    VAO,
    VBOVertex,        // Vertex-Koordinaten
    VBOTex: GLuint;   // Textur-Koordianten
  end;

var
  VBQuad: TVB;
  //code-
  RotMatrix, ScaleMatrix, ProdMatrix: TMatrix;
  Matrix_ID: GLint;

var
  textureID: GLuint;

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
  InitOpenGLDebug;
end;

//code+
procedure TForm1.CreateScene;
begin
  Shader := TShader.Create([FileToStr('Vertexshader.glsl'), FileToStr('Fragmentshader.glsl')]);
  with Shader do begin
    UseProgram;
    Matrix_ID := UniformLocation('mat');
    glUniform1i(UniformLocation('Sampler'), 0);  // Dem Sampler 0 zuweisen.
  end;
  //code-
  RotMatrix.Identity;
  ScaleMatrix.Identity;
  ScaleMatrix.Scale(0.7);
  ProdMatrix.Identity;

  glGenVertexArrays(1, @VBQuad.VAO);

  // https://www.songho.ca/opengl/gl_pbo.html

  glGenTextures(1, @textureID);                 // Erzeugen des Textur-Puffer.
  glBindTexture(GL_TEXTURE_2D, textureID);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);

  glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, 2, 2, 0, GL_RGBA, GL_UNSIGNED_BYTE, nil);
  glBindTexture(GL_TEXTURE_2D, 0);


  glGenBuffers(2, VBQuad.PBO);
  glBindBuffer(GL_PIXEL_UNPACK_BUFFER, VBQuad.PBO[0]);
  glBufferData(GL_PIXEL_UNPACK_BUFFER, SizeOf(Textur32_0), nil, GL_STREAM_DRAW);
  glBindBuffer(GL_PIXEL_UNPACK_BUFFER, VBQuad.PBO[1]);
  glBufferData(GL_PIXEL_UNPACK_BUFFER, SizeOf(Textur32_0), nil, GL_STREAM_DRAW);
  glBindBuffer(GL_PIXEL_UNPACK_BUFFER, 0);


  glClearColor(0.6, 0.6, 0.4, 1.0); // Hintergrundfarbe

  glGenBuffers(1, @VBQuad.VBOVertex);
  glGenBuffers(1, @VBQuad.VBOTex);

  glBindVertexArray(VBQuad.VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBOVertex);
  glBufferData(GL_ARRAY_BUFFER, sizeof(QuadVertex), @QuadVertex, GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 3, GL_FLOAT, False, 0, nil);

  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBOTex);
  glBufferData(GL_ARRAY_BUFFER, sizeof(TextureVertex), @TextureVertex, GL_STATIC_DRAW);
  glEnableVertexAttribArray(10);
  glVertexAttribPointer(10, 2, GL_FLOAT, False, 0, nil);
end;

procedure TForm1.ogcDrawScene(Sender: TObject);
const
  index: integer = 0;
var
  nextIndex: integer;
var
  mapBuffer: PTexture32;
begin
  glClear(GL_COLOR_BUFFER_BIT);

  Shader.UseProgram;

  index := (index + 1) mod 2;
  nextIndex := (index + 1) mod 2;

  glBindTexture(GL_TEXTURE_2D, textureID);
  glBindBuffer(GL_PIXEL_UNPACK_BUFFER, VBQuad.PBO[index]);
  glTexSubImage2D(GL_TEXTURE_2D, 0, 0, 0, 2, 2, GL_RGBA, GL_UNSIGNED_BYTE, nil);
  glBindBuffer(GL_PIXEL_UNPACK_BUFFER, VBQuad.PBO[nextIndex]);
  glBufferData(GL_PIXEL_UNPACK_BUFFER, SizeOf(Textur32_0), nil, GL_STREAM_DRAW);

  mapBuffer := glMapBuffer(GL_PIXEL_UNPACK_BUFFER, GL_WRITE_ONLY);

  if mapBuffer <> nil then begin
 //   mapBuffer^ := Textur32_0;
    mapBuffer^[0,0,0]:=Random($FF);
    mapBuffer^[0,1,0]:=Random($FF);
    mapBuffer^[1,0,0]:=Random($FF);
    mapBuffer^[1,1,0]:=Random($FF);
    glUnmapBuffer(GL_PIXEL_UNPACK_BUFFER);
  end;
  glBindBuffer(GL_PIXEL_UNPACK_BUFFER, 0);




  ProdMatrix := ScaleMatrix * RotMatrix;
  ProdMatrix.Uniform(Matrix_ID);

  // Zeichne Quadrat
  glBindVertexArray(VBQuad.VAO);
  glDrawArrays(GL_TRIANGLES, 0, Length(QuadVertex));

  ogc.SwapBuffers;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Timer1.Enabled := False;

  glDeleteTextures(1, @textureID);       // Textur-Puffer frei geben.
  glDeleteVertexArrays(1, @VBQuad.VAO);
  glDeleteBuffers(1, @VBQuad.VBOVertex);
  glDeleteBuffers(1, @VBQuad.VBOTex);
  glDeleteBuffers(2, VBQuad.PBO);

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
<b>Vertex-Shader:</b>
*)
//includeglsl Vertexshader.glsl
//lineal

(*
<b>Fragment-Shader:</b>
*)
//includeglsl Fragmentshader.glsl

end.
