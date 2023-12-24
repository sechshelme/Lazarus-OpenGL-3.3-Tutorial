unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, Menus,
  sdl, sdl_image,
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
    procedure ogcDrawScene(Sender: TObject);
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

//image image.png
const
  QuadVertex: array[0..5] of TVector3f =       // Koordinaten der Polygone.
    ((-0.8, -0.8, 0.0), (0.8, 0.8, 0.0), (-0.8, 0.8, 0.0),
    (-0.8, -0.8, 0.0), (0.8, -0.8, 0.0), (0.8, 0.8, 0.0));

  TextureVertex: array[0..5] of TVector2f =    // Textur-Koordinaten
    ((0.0, 0.0), (1.0, 1.0), (0.0, 1.0),
    (0.0, 0.0), (1.0, 0.0), (1.0, 1.0));

type
  TVB = record
    VAO,
    VBOVertex,
    VBOTex: GLuint;
  end;

var
  VBQuad: TVB;
  RotMatrix, ScaleMatrix, ProdMatrix: TMatrix;
  Matrix_ID: GLint;

var
  paletteID,
  textureID: GLuint;

procedure TForm1.FormCreate(Sender: TObject);
begin
  //remove+
  Width := 340;
  Height := 240;
  //remove-
  ogc := TContext.Create(Self, True, 3, 3);
  ogc.OnPaint := @ogcDrawScene;

  CreateScene;
  Timer1.Enabled := True;
end;

procedure TForm1.CreateScene;
var
  surface: PSDL_Surface;
begin

  Shader := TShader.Create([FileToStr('Vertexshader.glsl'), FileToStr('Fragmentshader.glsl')]);
  with Shader do begin
    UseProgram;
    Matrix_ID := UniformLocation('mat');
    glUniform1i(UniformLocation('myPalette'), 0);  // Dem Sampler 0 zuweisen.
    glUniform1i(UniformLocation('myTexture'), 1);  // Dem Sampler 0 zuweisen.
  end;
  RotMatrix.Identity;
  ScaleMatrix.Identity;
  ScaleMatrix.Scale(0.7);
  ProdMatrix.Identity;

  // --- vertex-Buffer
  glGenVertexArrays(1, @VBQuad.VAO);

  glGenBuffers(1, @VBQuad.VBOVertex);
  glBindVertexArray(VBQuad.VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBOVertex);
  glBufferData(GL_ARRAY_BUFFER, sizeof(QuadVertex), @QuadVertex, GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 3, GL_FLOAT, False, 0, nil);

  glGenBuffers(1, @VBQuad.VBOTex);
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBOTex);
  glBufferData(GL_ARRAY_BUFFER, sizeof(TextureVertex), @TextureVertex, GL_STATIC_DRAW);
  glEnableVertexAttribArray(1);
  glVertexAttribPointer(1, 2, GL_FLOAT, False, 0, nil);


//  surface := IMG_Load('Ts01.bmp');
  surface := IMG_Load('image.bmp');
  if surface = nil then begin
    WriteLn('img Fehler');
  end;

  glGenTextures(1, @paletteID);
  glBindTexture(GL_TEXTURE_2D, paletteID);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
 glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, 256, 1, 0, GL_RGBA, GL_UNSIGNED_BYTE, surface^.format^.palette^.colors);

  // Textur binden.
  glGenTextures(1, @textureID);
  glBindTexture(GL_TEXTURE_2D, textureID);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
  glTexImage2D(GL_TEXTURE_2D, 0, GL_RED, surface^.w, surface^.h, 0, GL_RED, GL_UNSIGNED_BYTE, surface^.pixels);

  SDL_FreeSurface(surface);

  glBindTexture(GL_TEXTURE_2D, 0);
  glClearColor(0.6, 0.6, 0.4, 1.0);
end;

procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  Shader.UseProgram;

  glClear(GL_COLOR_BUFFER_BIT);

  glActiveTexture(GL_TEXTURE0);
  glBindTexture(GL_TEXTURE_2D, paletteID);

  glActiveTexture(GL_TEXTURE1);
  glBindTexture(GL_TEXTURE_2D, textureID);
  //code-

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

  glDeleteTextures(1, @textureID);
  glDeleteTextures(1, @paletteID);
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
<b>Vertex-Shader:</b>
*)
//includeglsl Vertexshader.glsl
//lineal

(*
<b>Fragment-Shader:</b>
*)
//includeglsl Fragmentshader.glsl

end.
