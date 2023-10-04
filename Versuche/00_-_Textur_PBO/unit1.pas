unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, Menus,
  dglOpenGL,    oglDebug,
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

const
  Textur32_0: TTexture32 = ((($FF, $00, $00, $FF), ($00, $FF, $00, $FF)), (($00, $00, $FF, $FF), ($FF, $00, $00, $FF)));

type
  TVB = record
    PBO,
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
var
  mapBuffer: PTexture32;
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
  glGenBuffers(1, @VBQuad.PBO);
  checkError('glGenBuffers');

  glBindBuffer(GL_PIXEL_UNPACK_BUFFER, VBQuad.PBO);
  checkError('glBindBuffer');
  glBufferData(GL_PIXEL_UNPACK_BUFFER, SizeOf(Textur32_0), nil, GL_STREAM_COPY);
  checkError('glBufferData');

  glBindBuffer(GL_PIXEL_UNPACK_BUFFER, VBQuad.PBO);
  checkError('glBindBuffer');
  mapBuffer := glMapBufferRange(GL_PIXEL_UNPACK_BUFFER,0,SizeOf(Textur32_0), GL_MAP_WRITE_BIT or GL_MAP_WRITE_BIT);
  checkError('glMapBufferRange');

  WriteLn(PtrUInt(mapBuffer));
  mapBuffer^ := Textur32_0;
 if  glUnmapBuffer(GL_PIXEL_UNPACK_BUFFER)<>True then WriteLn('Fehler');
  checkError('glUnmapBuffer');

  glBindTexture(GL_TEXTURE_2D, textureID);
  checkError('glBindTexture');
//  glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, 2, 2, 0, GL_RGBA, GL_UNSIGNED_BYTE, nil);
//  checkError('glTexImage2D');
  glTexSubImage2D(GL_TEXTURE_2D, 0,0,0,2, 2, GL_RGBA, GL_UNSIGNED_BYTE, nil);
  checkError('glTexSubImage2D');

  glBindBuffer(GL_PIXEL_UNPACK_BUFFER,0);
  checkError('glBindBuffer');






  glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, 2, 2, 0, GL_RGBA, GL_UNSIGNED_BYTE, nil);

//  glBindBuffer(GL_PIXEL_UNPACK_BUFFER, VBQuad.PBO1);





  //glBufferData(GL_PIXEL_UNPACK_BUFFER,SizeOf(Textur32_0),nil,GL_STREAM_DRAW);
  //mapBuffer:=glMapBuffer(GL_PIXEL_UNPACK_BUFFER, GL_WRITE_ONLY);
  ////  move(Textur32_0, mapBuffer, SizeOf(Textur32_0));
  //  FillChar(mapBuffer, SizeOf(Textur32_0),$FF);
  //glBindBuffer(GL_PIXEL_UNPACK_BUFFER, VBQuad.PBO0);
  //glUnmapBuffer(GL_PIXEL_UNPACK_BUFFER);




  //glGenTextures(1, @textureID);                 // Erzeugen des Textur-Puffer.
  //glBindTexture(GL_TEXTURE_2D, textureID);
  //glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, 2, 2, 0, GL_RGBA, GL_UNSIGNED_BYTE, @Textur32_0);
  //glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
  //glGenerateMipmap(GL_TEXTURE_2D);

  glBindTexture(GL_TEXTURE_2D, 0);
  //code-

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

(*
Bevor man ein Polygon zeichnet, muss man die Texur binden. Dies geschieht mit <b>glBindTexture(...</b>.
Anschliessend kann ganz normal gezeichnet werden.
*)
//code+
procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT);

  glBindTexture(GL_TEXTURE_2D, textureID);  // Textur binden.
  //code-

  Shader.UseProgram;

  ProdMatrix := ScaleMatrix * RotMatrix;
  ProdMatrix.Uniform(Matrix_ID);

  // Zeichne Quadrat
  glBindVertexArray(VBQuad.VAO);
  glDrawArrays(GL_TRIANGLES, 0, Length(QuadVertex));

  ogc.SwapBuffers;
end;

(*
Zum Schluss muss man wie gewohnt, auch den Textur-Puffer wieder frei geben.
*)
//code+
procedure TForm1.FormDestroy(Sender: TObject);
begin
  Timer1.Enabled := False;

  glDeleteTextures(1, @textureID);       // Textur-Puffer frei geben.
  glDeleteVertexArrays(1, @VBQuad.VAO);
  glDeleteBuffers(1, @VBQuad.VBOVertex);
  glDeleteBuffers(1, @VBQuad.VBOTex);
  //code-

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

Hier sieht man, das die Textur-Koordinaten gleich behandelt werden wie Vertex-Attribute.
Dies muss man dann aber dem Fragment-Shader weiterleiten. So wurde es auch schon mit den Color-Vectoren gemacht.
*)
//includeglsl Vertexshader.glsl
//lineal

(*
<b>Fragment-Shader:</b>

Hier ist der Sampler für die Zuordnung dazu gekommen.
Und man sieht auch, das die Farb-Ausgabe von der Textur kommen.
Die UV-Koordinate gibt an, von welchem Bereich der Pixel aus der Textur gelesen wird.
*)
//includeglsl Fragmentshader.glsl

end.
