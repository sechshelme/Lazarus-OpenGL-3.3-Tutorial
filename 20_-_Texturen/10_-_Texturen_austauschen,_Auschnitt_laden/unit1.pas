unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, Menus,
  oglglad_gl,
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
Dies ist auch mit einem <b>Texturauschnitt</b> möglich.
Dies geschieht mit <b>glTexSubImage2D(...</b>.
*)

//lineal

type
  TQuad = array[0..1] of TFace3D;

(*
Big ist die Totalgrösse der Texturdaten.
Small ist ein Auschnitt.
*)
//code+
const
  TextursizeBig = 256;
  TextursizeSmall = 64;
//code-

  Quad: TQuad =
    (((-0.8, -0.8, 0.0), (0.8, 0.8, 0.0), (-0.8, 0.8, 0.0)),
    ((-0.8, -0.8, 0.0), (0.8, -0.8, 0.0), (0.8, 0.8, 0.0)));

  TextureVertex: array[0..5] of TVector2f =
    ((0.0, 0.0), (1.0, 1.0), (0.0, 1.0),
    (0.0, 0.0), (1.0, 0.0), (1.0, 1.0));


type
  TVB = record
    VAO,
    VBOVertex, VBOTex: GLuint;
  end;

(*
3 Datenpuffer, welche sehr mit sehr einfachen Werten geladen werden.
*)
//code+
var
  TexturBig: packed array [0..TextursizeBig*TextursizeBig-1] of UInt32 ;
  TexturSmall0, TexturSmall1: packed array [0..TextursizeSmall*TextursizeSmall-1]of UInt32;
  textureID: GLuint;
//code-
  RotMatrix, TransMatrix: TMatrix;
  Matrix_ID: GLint;

  VBQuad: TVB;

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

  glGenVertexArrays(1, @VBQuad.VAO);

  glGenBuffers(1, @VBQuad.VBOVertex);
  glGenBuffers(1, @VBQuad.VBOTex);
end;

(*
Es werden sehr einfache Datenbuffer mit Daten befüllt.
In der Praxis werden die Puffer meistens mit Bitmaps gefüllt.
Der grosse Texturbuffer füllt die ganze Textur auf.
Die kleinen Datenbuffer werden später zur Laufzeit abwechslungsweise geladen.
*)
//code+
procedure TForm1.InitScene;
var
  i: integer;
begin
  // Einfache Datenbuffer erzeugen.
  for i := 0 to TextursizeBig * TextursizeBig - 1 do begin
    TexturBig[i] := i or $FF000000;
  end;

  for i := 0 to TextursizeSmall * TextursizeSmall - 1 do begin
    TexturSmall0[i] := i or $FF000000;
    TexturSmall1[i] := (not i) or $FF000000;
  end;

  // --- Texturbuffer erzeugen und anschliessend mit Daten der grossen Textur befüllen.

  glGenTextures(1, @textureID);
  glBindTexture(GL_TEXTURE_2D, textureID);

  // Nur Speicher reservieren
  glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, TextursizeBig, TextursizeBig, 0, GL_RGBA, GL_UNSIGNED_BYTE, nil);

  // Texturbuffer mit dem grossen Datenbuffer befüllen.
  glTexSubImage2D(GL_TEXTURE_2D, 0, 0, 0, TextursizeBig, TextursizeBig, GL_RGBA, GL_UNSIGNED_BYTE, @TexturBig);
//code-

  glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
  glBindTexture(GL_TEXTURE_2D, 0);

  glClearColor(0.6, 0.6, 0.4, 1.0); // Hintergrundfarbe

  // Daten für Rechteck
  glBindVertexArray(VBQuad.VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBOVertex);
  glBufferData(GL_ARRAY_BUFFER, sizeof(Quad), @Quad, GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 0, nil);

  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBOTex);
  glBufferData(GL_ARRAY_BUFFER, sizeof(TextureVertex), @TextureVertex, GL_STATIC_DRAW);
  glEnableVertexAttribArray(10);
  glVertexAttribPointer(10, 2, GL_FLOAT, GL_FALSE, 0, nil);
end;

procedure TForm1.ogcDrawScene(Sender: TObject);
var
  Matrix:TMatrix;
begin
  glClear(GL_COLOR_BUFFER_BIT);

  glBindTexture(GL_TEXTURE_2D, textureID);

  Shader.UseProgram;

  Matrix := TransMatrix * RotMatrix;
  Matrix.Uniform(Matrix_ID);

  // Zeichne Quadrat
  glBindVertexArray(VBQuad.VAO);
  glDrawArrays(GL_TRIANGLES, 0, Length(Quad) * 3);

  ogc.SwapBuffers;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Timer1.Enabled := False;

  Shader.Free;

  glDeleteTextures(1, @textureID);
  glDeleteVertexArrays(1, @VBQuad.VAO);
  glDeleteBuffers(1, @VBQuad.VBOVertex);
  glDeleteBuffers(1, @VBQuad.VBOTex);
end;

(*
Ein Auschnitt der Textur wird zur Laufzeit abwechslungsweise ausgtauscht
*)
//code+
procedure TForm1.Timer1Timer(Sender: TObject);
const
  step = 0.01;
  z: integer = 1;
begin
  if z > 10 then begin
    glTexSubImage2D(GL_TEXTURE_2D, 0, 64, 64, TextursizeSmall, TextursizeSmall, GL_RGBA, GL_UNSIGNED_BYTE, @TexturSmall0);
  end else begin
    glTexSubImage2D(GL_TEXTURE_2D, 0, 64, 64, TextursizeSmall, TextursizeSmall, GL_RGBA, GL_UNSIGNED_BYTE, @TexturSmall1);
  end;
  //code-
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
