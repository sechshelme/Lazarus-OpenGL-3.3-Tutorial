unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, Menus,
  dglOpenGL,
  oglContext, oglShader,oglVector, oglMatrix;

type

  { TForm1 }

  TForm1 = class(TForm)
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
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
    ((-1.0, -1.0, 0.0), (1.0, 1.0, 0.0), (-1.0, 1.0, 0.0),
    (-1.0, -1.0, 0.0), (1.0, -1.0, 0.0), (1.0, 1.0, 0.0));

//  TextureVertex: array[0..5] of TVector2f =
//    ((0.0, 0.0), (1.0, 1.0), (0.0, 1.0),
//    (0.0, 0.0), (1.0, 0.0), (1.0, 1.0));
  TextureVertex: array[0..5] of TVector2f =
    ((0.0, 0.0), (100.0, 100.0), (0.0, 100.0),
    (0.0, 0.0), (100.0, 0.0), (100.0, 100.0));

type
  TVB = record
    VAO,
    VBOVertex, VBOTex: GLuint;
  end;

var
  FrustumMatrix,
  WorldMatrix,
  Matrix: TMatrix;
  Matrix_ID: GLint;

  VBTriangle: TVB;

  textureID: array[0..1] of GLuint;

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
  Matrix.Identity;

  FrustumMatrix.Identity;
  FrustumMatrix.Perspective(45, 1.0, 2.5, 1000.0);

  WorldMatrix.Identity;
  WorldMatrix.Translate(0, 0, -200.0); // Die Scene in den sichtbaren Bereich verschieben.
  WorldMatrix.Scale(5.0);              // Und der Grösse anpassen.

  WorldMatrix.RotateA(1.5);  // Drehe um Y-Achse
  WorldMatrix.RotateC(pi);   // Drehe um Y-Achse

  glGenVertexArrays(1, @VBTriangle.VAO);

  glGenBuffers(1, @VBTriangle.VBOVertex);
  glGenBuffers(1, @VBTriangle.VBOTex);
end;

(*
Texturen laden
*)
//code+
procedure TForm1.InitScene;
var
  pic: TPicture;
begin
  // ------------ Texture laden --------------

  pic := TPicture.Create;
  with pic do begin
//    LoadFromFile('mauer.xpm');
    LoadFromFile('project1.ico');
    glGenTextures(2, @textureID);                 // Erzeugen des Textur-Puffer.

    // --- Textur [0]
    glBindTexture(GL_TEXTURE_2D, textureID[0]);
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, Width, Height, 0, GL_BGRA, GL_UNSIGNED_BYTE, Bitmap.RawImage.Data);
//    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, Width, Height, 0, GL_BGR, GL_UNSIGNED_BYTE, Bitmap.RawImage.Data);
    glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);

    // --- Textur [1]
    glBindTexture(GL_TEXTURE_2D, textureID[1]);
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, Width, Height, 0, GL_BGR, GL_UNSIGNED_BYTE, Bitmap.RawImage.Data);
//    glGenerateMipmap(GL_TEXTURE_2D);  //Generate num_mipmaps number of mipmaps here.


glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR_MIPMAP_LINEAR);

//glTexParameteri( GL_TEXTURE_2D, GL_GENERATE_MIPMAP, 1) ;
    glGenerateMipmap(GL_TEXTURE_2D);

    glBindTexture(GL_TEXTURE_2D, 0);
    Free; // pic
  end;

  glClearColor(0.6, 0.6, 0.4, 1.0); // Hintergrundfarbe

  // Daten für Dreieck
  glBindVertexArray(VBTriangle.VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBTriangle.VBOVertex);
  glBufferData(GL_ARRAY_BUFFER, sizeof(Quad), @Quad, GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 3, GL_FLOAT, False, 0, nil);

  glBindBuffer(GL_ARRAY_BUFFER, VBTriangle.VBOTex);
  glBufferData(GL_ARRAY_BUFFER, sizeof(TextureVertex), @TextureVertex, GL_STATIC_DRAW);
  glEnableVertexAttribArray(10);
  glVertexAttribPointer(10, 2, GL_FLOAT, False, 0, nil);
end;
//code-

procedure TForm1.ogcDrawScene(Sender: TObject);
var
  x, y: integer;
const
  d = 2.0;
  s = 8;
begin
  Matrix.Identity;;
  glClear(GL_COLOR_BUFFER_BIT);
  Shader.UseProgram;
  glBindVertexArray(VBTriangle.VAO);

//  for x := -s to s do begin
//    for y := -s * 10 to s do begin
//      if x = 0 then begin
//        break;
//      end;
//      if x < 0 then begin
        glBindTexture(GL_TEXTURE_2D, textureID[0]);
//      end else begin
//        glBindTexture(GL_TEXTURE_2D, textureID[1]);
//      end;

      Matrix.Identity;
      Matrix.Scale(40);
//      Matrix.Translate(x * d, y * d, -4 * d);

      Matrix:=WorldMatrix* Matrix;
      Matrix:=FrustumMatrix* Matrix;

      Matrix.Uniform(Matrix_ID);
      glDrawArrays(GL_TRIANGLES, 0, Length(Quad));
//    end;
//  end;

  ogc.SwapBuffers;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Timer1.Enabled := False;

  Shader.Free;

  glDeleteTextures(2, @textureID);       // Textur-Puffer frei geben.
  glDeleteVertexArrays(1, @VBTriangle.VAO);
  glDeleteBuffers(1, @VBTriangle.VBOVertex);
  glDeleteBuffers(1, @VBTriangle.VBOTex);
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
