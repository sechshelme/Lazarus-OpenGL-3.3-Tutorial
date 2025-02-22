unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, Menus,
  oglglad_gl,
  oglContext, oglShader,oglVector, oglMatrix;

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
*)

//lineal

const
  Quad: array[0..5] of TVector3f =
    ((-0.8, -0.8, 0.0), (0.8, 0.8, 0.0), (-0.8, 0.8, 0.0),
    (-0.8, -0.8, 0.0), (0.8, -0.8, 0.0), (0.8, 0.8, 0.0));

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

(*
*)
var
  //  RotMatrix, ScaleMatrix, prodMatrix: TMatrix;   // Matrixen von der Klasse aus oglMatrix.
  FrustumMatrix,
  WorldMatrix,
  Matrix: TMatrix;
  Matrix_ID: GLint;                              // ID für Matrix.

  VBTriangle: TVB;

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

(*
*)
//code+
procedure TForm1.CreateScene;
const
  w = 1.0;
begin
  Shader := TShader.Create([FileToStr('Vertexshader.glsl'), FileToStr('Fragmentshader.glsl')]);
  with Shader do begin
    UseProgram;
    Matrix_ID := UniformLocation('mat');
    glUniform1i(UniformLocation('Sampler'), 0);
  end;
  Matrix.Identity;

  FrustumMatrix.Identity;
  FrustumMatrix.Frustum(-w, w, -w, w, 2.5, 1000.0);

  //   FrustumMatrix.Perspective(45, 1.0, 2.5, 1000.0); // Alternativ

  WorldMatrix.Identity;
  WorldMatrix.Translate(0, 0, -200.0); // Die Scene in den sichtbaren Bereich verschieben.
  WorldMatrix.Scale(5.0);              // Und der Grösse anpassen.

  WorldMatrix.RotateA(1.5);  // Drehe um Y-Achse
  WorldMatrix.RotateC(pi);  // Drehe um Y-Achse

  //code-

  glGenVertexArrays(1, @VBTriangle.VAO);

  glGenBuffers(1, @VBTriangle.VBOVertex);
  glGenBuffers(1, @VBTriangle.VBOTex);
end;

(*
Texturen laden
*)
//code+
procedure TForm1.InitScene;
const
  maxLevel = 5;
var
  tex: array of UInt32=nil;
  w, i, j: integer;
begin
  // ------------ Texture laden --------------

  glGenTextures(1, @textureID0);
  glActiveTexture(GL_TEXTURE0);
  glBindTexture(GL_TEXTURE_2D, textureID0);

  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAX_LEVEL, maxLevel - 1);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_BASE_LEVEL, 0);
//  glTexParameteri( GL_TEXTURE_3D, GL_GENERATE_MIPMAP, 1 );
  for i := 1 to maxLevel do begin
    w := (1 shl (maxLevel - i)) * 256 * 4;
    //    w := (1 shl i) * 256;
//    WriteLn(w);
    SetLength(tex, w * w);
    for j := 0 to Length(tex) - 1 do begin
      //      tex[j] := $FF shl (4 * i) + (j mod 255);
      //case i of
      //1: tex[j] := $000FF;
      //2: tex[j] := $00FF0;
      //3: tex[j] := $0FF00;
      //4: tex[j] := $FF000;
      //end;
      tex[j] := $FF00000 shr (i * 4);
    end;
    //    WriteLn(IntToHex($FF00000 shr (i * 4), 8));
    glTexImage2D(GL_TEXTURE_2D, i - 1, GL_RGBA, w, w, 0, GL_RGBA, GL_UNSIGNED_BYTE, Pointer(tex));
  end;

  glBindTexture(GL_TEXTURE_2D, 0);

  glClearColor(0.6, 0.6, 0.4, 1.0); // Hintergrundfarbe

  // Daten für Dreieck
  glBindVertexArray(VBTriangle.VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBTriangle.VBOVertex);
  glBufferData(GL_ARRAY_BUFFER, sizeof(Quad), @Quad, GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 0, nil);

  glBindBuffer(GL_ARRAY_BUFFER, VBTriangle.VBOTex);
  glBufferData(GL_ARRAY_BUFFER, sizeof(TextureVertex), @TextureVertex, GL_STATIC_DRAW);
  glEnableVertexAttribArray(10);
  glVertexAttribPointer(10, 2, GL_FLOAT, GL_FALSE, 0, nil);
end;
//code-

(*
*)
//code+
procedure TForm1.ogcDrawScene(Sender: TObject);
var
  x, y: integer;
const
  d = 2.0;
  s = 8;
begin
  Matrix.Identity;
  glClear(GL_COLOR_BUFFER_BIT);

  glBindTexture(GL_TEXTURE_2D, textureID0);
  //code-

  Shader.UseProgram;

  glBindVertexArray(VBTriangle.VAO);
  for x := -s to s do begin
    for y := -s to s do begin
//      for y := -s*10 to s do begin
      Matrix.Identity;
      Matrix.Translate(x * d, y * d, -4 * d);                 // Matrix verschieben.

      Matrix:=WorldMatrix* Matrix;                  // Matrixen multiplizieren.
      Matrix:=FrustumMatrix* Matrix;

      Matrix.Uniform(Matrix_ID);                             // Matrix dem Shader übergeben.
      glDrawArrays(GL_TRIANGLES, 0, Length(Quad)); // Zeichnet einen kleinen Würfel.
    end;
  end;


  //  prodMatrix.Multiply(ScaleMatrix, RotMatrix);
  //  prodMatrix.Uniform(Matrix_ID);

  // Zeichne Quadrat
  //  glBindVertexArray(VBTriangle.VAO);
  //  glDrawArrays(GL_TRIANGLES, 0, Length(Quad) * 3);


  ogc.SwapBuffers;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Timer1.Enabled := False;

  Shader.Free;

  glDeleteTextures(1, @textureID0);
  glDeleteVertexArrays(1, @VBTriangle.VAO);
  glDeleteBuffers(1, @VBTriangle.VBOVertex);
  glDeleteBuffers(1, @VBTriangle.VBOTex);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
const
  step: GLfloat = 0.01;
  scale: GLfloat = 0.1;
begin
  scale := scale * 1.02;
  if scale > 1.0 then begin
    scale := 0.1;
  end;
  //  ScaleMatrix.Identity;
  //  ScaleMatrix.Scale(scale);

  //  RotMatrix.RotateC(step);




  ogcDrawScene(Sender);
end;

//lineal

(*
<b>Vertex-Shader:</b>

Hier ist die Uniform-Variable <b>mat</b> hinzugekommen.
Diese wird im Vertex-Shader deklariert, Bewegungen kommen immer in diesen Shader.
*)
//includeglsl Vertexshader.glsl
//lineal

(*
<b>Fragment-Shader:</b>
*)
//includeglsl Fragmentshader.glsl

end.
