unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, Menus,
  dglOpenGL,
  oglContext, oglShader, oglMatrix, oglTextur;

type

  { TForm1 }

  TForm1 = class(TForm)
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    ogc: TContext;
    Shader_Normal, Shader_Perspek: TShader; // Shader Klasse
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
Für sehr einfache Texturen, ist das xpm-Format geeignet. Mit diesem kann man sehr schnell eine einfache Textur mit einem Text-Editor erstellen.
*)
//lineal
const
  QuadVertex: array[0..5] of TVector3f =       // Koordinaten der Polygone.
    ((-1.2, -0.8, 0.0), (0.4, 0.8, 0.0), (-0.4, 0.8, 0.0),
    (-1.2, -0.8, 0.0), (1.2, -0.8, 0.0), (0.4, 0.8, 0.0));

  TextureNormalVertex: array[0..5] of TVector2f =
    ((-1.0, -1.0), (1.0, 1.0), (-1.0, 1.0),
    (-1.0, -1.0), (1.0, -1.0), (1.0, 1.0));

  TexturePerspVertex: array[0..5] of TVector4f =
    ((-1.2, -0.8, 0.0, 1.2), (0.4, 0.8, 0.0, 0.4), (-0.4, 0.8, 0.0, 0.4),
    (-1.2, -0.8, 0.0, 1.2), (1.2, -0.8, 0.0, 1.2), (0.4, 0.8, 0.0, 0.4));


type
  TVB = record
    VAO,
    VBOVertex,        // Vertex-Koordinaten
    VBOTex: GLuint;   // Textur-Koordianten
  end;

var
  VBO_Quad_Normal, VBO_Quad_Persp: TVB;
  RotMatrix, ScaleMatrix, ProdMatrix: TMatrix;
  Textur: TTexturBuffer;
  Matrix_Normal_ID, Matrix_Perspek_ID: GLint;


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
  glGenVertexArrays(1, @VBO_Quad_Normal.VAO);
  glGenBuffers(1, @VBO_Quad_Normal.VBOVertex);
  glGenBuffers(1, @VBO_Quad_Normal.VBOTex);

  glGenVertexArrays(1, @VBO_Quad_Persp.VAO);
  glGenBuffers(1, @VBO_Quad_Persp.VBOVertex);
  glGenBuffers(1, @VBO_Quad_Persp.VBOTex);

  Textur := TTexturBuffer.Create;                 // Erzeugen des Textur-Puffer.

  Shader_Normal := TShader.Create([FileToStr('Vertexshader_nor.glsl'), FileToStr('Fragmentshader_nor.glsl')]);
  with Shader_Normal do begin
    UseProgram;
    Matrix_Normal_ID := UniformLocation('mat');
    glUniform1i(UniformLocation('Sampler'), 0);  // Dem Sampler 0 zuweisen.
  end;

  Shader_Perspek := TShader.Create([FileToStr('Vertexshader_per.glsl'), FileToStr('Fragmentshader_per.glsl')]);
  with Shader_Perspek do begin
    UseProgram;
    Matrix_Perspek_ID := UniformLocation('mat');
    glUniform1i(UniformLocation('Sampler'), 0);  // Dem Sampler 0 zuweisen.
  end;
  RotMatrix := TMatrix.Create;
  ScaleMatrix := TMatrix.Create;
  ScaleMatrix.Scale(0.4);
  ProdMatrix := TMatrix.Create;
end;

(*
Da etwas anderes als <b>BMP</b> gleaden wird, muss anstelle von <b>TBitmap TPicture</b> verwendet werden.

Momentan kann TPicture folgende Datei-Formate laden: <b>BMP, GIF, JPG, PCX, PNG, P?M, PDS, TGA, TIF, XPM, ICO, CUR, ICNS</b>.
*)
//code+
procedure TForm1.InitScene;
var
  pic: TPicture;
  i: integer;
begin
  pic := TPicture.Create;                     // Picture erzeugen.
  with pic do begin
    LoadFromFile('mauer.xpm');                // XPM-Datei laden.
    Textur.LoadTextures(pic.Bitmap.RawImage); // Bitmap in VRAM laden.
    Free;                                     // Picture frei geben.
  end;
  //code-
  glClearColor(0.6, 0.6, 0.4, 1.0);

  for i := 0 to Length(TextureNormalVertex) - 1 do begin
    TextureNormalVertex[i].Scale(3.0);
  end;
  for i := 0 to Length(TexturePerspVertex) - 1 do begin
    TexturePerspVertex[i].Scale(3.0);
  end;

  // Normal
  glBindVertexArray(VBO_Quad_Normal.VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBO_Quad_Normal.VBOVertex);
  glBufferData(GL_ARRAY_BUFFER, sizeof(QuadVertex), @QuadVertex, GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 3, GL_FLOAT, False, 0, nil);

  glBindBuffer(GL_ARRAY_BUFFER, VBO_Quad_Normal.VBOTex);
  glBufferData(GL_ARRAY_BUFFER, sizeof(TextureNormalVertex), @TextureNormalVertex, GL_STATIC_DRAW);
  glEnableVertexAttribArray(10);
  glVertexAttribPointer(10, 2, GL_FLOAT, False, 0, nil);

  // Perspektive
  glBindVertexArray(VBO_Quad_Persp.VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBO_Quad_Persp.VBOVertex);
  glBufferData(GL_ARRAY_BUFFER, sizeof(QuadVertex), @QuadVertex, GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 3, GL_FLOAT, False, 0, nil);

  glBindBuffer(GL_ARRAY_BUFFER, VBO_Quad_Persp.VBOTex);
  glBufferData(GL_ARRAY_BUFFER, sizeof(TexturePerspVertex), @TexturePerspVertex, GL_STATIC_DRAW);
  glEnableVertexAttribArray(10);
  glVertexAttribPointer(10, 4, GL_FLOAT, False, 0, nil);
end;

procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT);
  Textur.ActiveAndBind;  // Textur binden.

  // Zeichne Quadrat
  Shader_Normal.UseProgram;
  RotMatrix.Identity;
  RotMatrix.Translate(-1.2, 0.0, 0.0);
  ProdMatrix.Multiply(ScaleMatrix, RotMatrix);
  ProdMatrix.Uniform(Matrix_Normal_ID);

  glBindVertexArray(VBO_Quad_Normal.VAO);
  glDrawArrays(GL_TRIANGLES, 0, Length(QuadVertex));

  // Zeichne Quadrat
  Shader_Perspek.UseProgram;
  RotMatrix.Identity;
  RotMatrix.Translate(1.2, 0.0, 0.0);
  ProdMatrix.Multiply(ScaleMatrix, RotMatrix);
  ProdMatrix.Uniform(Matrix_Perspek_ID);

  glBindVertexArray(VBO_Quad_Persp.VAO);
  glDrawArrays(GL_TRIANGLES, 0, Length(QuadVertex));

  ogc.SwapBuffers;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Timer1.Enabled := False;

  glDeleteVertexArrays(1, @VBO_Quad_Normal.VAO);
  glDeleteBuffers(1, @VBO_Quad_Normal.VBOVertex);
  glDeleteBuffers(1, @VBO_Quad_Normal.VBOTex);

  glDeleteVertexArrays(1, @VBO_Quad_Persp.VAO);
  glDeleteBuffers(1, @VBO_Quad_Persp.VBOVertex);
  glDeleteBuffers(1, @VBO_Quad_Persp.VBOTex);

  Textur.Free;                           // Textur-Puffer frei geben.
  ProdMatrix.Free;
  RotMatrix.Free;
  ScaleMatrix.Free;

  Shader_Normal.Free;
  Shader_Perspek.Free;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
const
  step: GLfloat = 0.01;
begin
  //  RotMatrix.RotateC(step);
  ogcDrawScene(Sender);
end;

//lineal
(*
<b>Vertex-Shader:</b>
*)
//includeglsl Vertexshader_nor.glsl

//lineal
(*
<b>Fragment-Shader:</b>
*)
//includeglsl Fragmentshader_nor.glsl

//lineal
(*
<b>Vertex-Shader:</b>
*)
//includeglsl Vertexshader_per.glsl

//lineal
(*
<b>Fragment-Shader:</b>
*)
//includeglsl Fragmentshader_per.glsl

//lineal
(*
<b>mauer.xpm:</b>
*)
//includetext mauer.xpm

end.
