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
Für sehr einfache Texturen, ist das xpm-Format geeignet. Mit diesem kann man sehr schnell eine einfache Textur mit einem Text-Editor erstellen.
*)
//lineal
const
  TrapezeVertex: array[0..5] of TVector3f =       // Koordinaten der Polygone.
    ((-1.2, -0.8, 0.0), (0.4, 0.8, 0.0), (-0.4, 0.8, 0.0),
    (-1.2, -0.8, 0.0), (1.2, -0.8, 0.0), (0.4, 0.8, 0.0));

  TextureNormalVertex: array[0..5] of TVector2f =
    ((-1.0, -1.0), (1.0, 1.0), (-1.0, 1.0),
    (-1.0, -1.0), (1.0, -1.0), (1.0, 1.0));

  TexturePerspVertex1: array[0..5] of TVector3f =
    ((-1.2, -0.8, 1.2), (0.4, 0.8, 0.4), (-0.4, 0.8, 0.4),
    (-1.2, -0.8, 1.2), (1.2, -0.8, 1.2), (0.4, 0.8, 0.4));

  TexturePerspVertex2: array[0..5] of TVector4f =
    ((-1.2, -0.8, 0.0, 1.2), (0.4, 0.8, 0.0, 0.4), (-0.4, 0.8, 0.0, 0.4),
    (-1.2, -0.8, 0.0, 1.2), (1.2, -0.8, 0.0, 1.2), (0.4, 0.8, 0.0, 0.4));


type
  TVB = record
    VAO: GLuint;
    VBO: record
      Vertex: GLuint;        // Vertex-Koordinaten
      Textur: array[0..2] of GLuint;   // Textur-Koordianten
    end;
  end;

var
  VBO_Trapeze: TVB;
  TransMatrix, ScaleMatrix, ProdMatrix: TMatrix;
  Textur: TTexturBuffer;
  Matrix_ID, Variante_ID: GLint;

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
  glGenVertexArrays(1, @VBO_Trapeze.VAO);
  glGenBuffers(4, @VBO_Trapeze.VBO);

  Textur := TTexturBuffer.Create;                 // Erzeugen des Textur-Puffer.

  Shader := TShader.Create([FileToStr('Vertexshader.glsl'), FileToStr('Fragmentshader.glsl')]);
  with Shader do begin
    UseProgram;
    Matrix_ID := UniformLocation('mat');
    Variante_ID := UniformLocation('variante');
    glUniform1i(UniformLocation('Sampler'), 0);  // Dem Sampler 0 zuweisen.
  end;

  TransMatrix := TMatrix.Create;
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
  glClearColor(0.6, 0.6, 0.4, 1.0);

  glBindVertexArray(VBO_Trapeze.VAO);

  // Vektoren Trapez
  glBindBuffer(GL_ARRAY_BUFFER, VBO_Trapeze.VBO.Vertex);
  glBufferData(GL_ARRAY_BUFFER, sizeof(TrapezeVertex), @TrapezeVertex, GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 3, GL_FLOAT, False, 0, nil);

  // Unkorrigierte Textur-Koordinaten
  glBindBuffer(GL_ARRAY_BUFFER, VBO_Trapeze.VBO.Textur[0]);
  glBufferData(GL_ARRAY_BUFFER, sizeof(TextureNormalVertex), @TextureNormalVertex, GL_STATIC_DRAW);
  glEnableVertexAttribArray(10);
  glVertexAttribPointer(10, 2, GL_FLOAT, False, 0, nil);

  // Perspektivenkorrigiert Variante 1
  glBindBuffer(GL_ARRAY_BUFFER, VBO_Trapeze.VBO.Textur[1]);
  glBufferData(GL_ARRAY_BUFFER, sizeof(TexturePerspVertex1), @TexturePerspVertex1, GL_STATIC_DRAW);
  glEnableVertexAttribArray(11);
  glVertexAttribPointer(11, 3, GL_FLOAT, False, 0, nil);

  // Perspektivenkorrigiert Variante 2
  glBindBuffer(GL_ARRAY_BUFFER, VBO_Trapeze.VBO.Textur[2]);
  glBufferData(GL_ARRAY_BUFFER, sizeof(TexturePerspVertex2), @TexturePerspVertex2, GL_STATIC_DRAW);
  glEnableVertexAttribArray(12);
  glVertexAttribPointer(12, 4, GL_FLOAT, False, 0, nil);
  //code-

  pic := TPicture.Create;                     // Textur laden.
  with pic do begin
    LoadFromFile('mauer.xpm');
    Textur.LoadTextures(pic.Bitmap.RawImage);
    Free;
  end;
end;

procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT);
  Textur.ActiveAndBind;  // Textur binden.

  // Zeichne Unkorrigiert (Links)
  Shader.UseProgram;
  glUniform1i(Variante_ID, 0);
  TransMatrix.Identity;
  TransMatrix.Translate(-1.2, 0.0, 0.0);
  ProdMatrix.Multiply(ScaleMatrix, TransMatrix);
  ProdMatrix.Uniform(Matrix_ID);

  glBindVertexArray(VBO_Trapeze.VAO);
  glDrawArrays(GL_TRIANGLES, 0, Length(TrapezeVertex));

  // Zeichne korrigiert Variante 1 (Rechts Oben)
  glUniform1i(Variante_ID, 1);
  TransMatrix.Identity;
  TransMatrix.Translate(1.2, 1.0, 0.0);
  ProdMatrix.Multiply(ScaleMatrix, TransMatrix);
  ProdMatrix.Uniform(Matrix_ID);
  glDrawArrays(GL_TRIANGLES, 0, Length(TrapezeVertex));

  // Zeichne korrigiert Variante 2 (Rechts Unten)
  glUniform1i(Variante_ID, 2);
  TransMatrix.Identity;
  TransMatrix.Translate(1.2, -1.0, 0.0);
  ProdMatrix.Multiply(ScaleMatrix, TransMatrix);
  ProdMatrix.Uniform(Matrix_ID);
  glDrawArrays(GL_TRIANGLES, 0, Length(TrapezeVertex));

  ogc.SwapBuffers;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Timer1.Enabled := False;

  glDeleteVertexArrays(1, @VBO_Trapeze.VAO);
  glDeleteBuffers(4, @VBO_Trapeze.VBO);

  Textur.Free;
  ProdMatrix.Free;
  TransMatrix.Free;
  ScaleMatrix.Free;

  Shader.Free;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
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

//lineal
(*
<b>mauer.xpm:</b>
*)
//includecpp mauer.xpm

end.
