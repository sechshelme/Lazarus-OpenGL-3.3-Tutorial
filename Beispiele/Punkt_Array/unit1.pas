unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls,
  dglOpenGL,
  oglContext, oglShader, oglVector, oglMatrix;

//image image.png
(*
Will man die Scene realistisch proportional darstellen, nimmt man eine Frustum-Matrix.
Dies hat den Einfluss, das Objekte kleiner erscheinen, je weiter die Scene von einem weg ist.
In der Realität ist dies auch so, das Objekte kleiner erscheinen, je weiter sie von einem weg sind.
*)
//lineal

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

const
  PixelCount=1000;

type
  TPixel=record
    Pos,
    Col:TVector3f;
  end;

  TPixels=array of TPixel;


var Pixels:TPixels;

type
  TVB = record
    VAO,
    VBO: GLuint;  // VBO für Farbe.
  end;

var
  VBCube: TVB;
  FrustumMatrix,
  WorldMatrix,
  Matrix: TMatrix;
  Matrix_ID: GLint;

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
end;

(*
Der Frustum funktioniert ähnlich wie beim Ortho.
Nur die Parameter sind ein wenig anders.
Die Z-Werte müssen immer <b>positiv</b> sein.

Mit den zwei letzten Parametern von Frustum und der World-Matrix muss man ein bisschen probieren, zum Teil wird sonst das Bild verzehrt.

Alternativ kann man den Frustum auch mit <b>Perspective(...</b> einstellen.
Dabei ist der erste Parameter der Betrachtungs-Winkel.
Der zweite Parameter ist das Fensterverhältniss, mehr dazu und glViewPort.
*)
//code+
procedure TForm1.CreateScene;
const
  w = 1.0;
var
  i: Integer;
begin
  SetLength(Pixels, PixelCount);
  for i:=0 to Length(Pixels)-1 do begin
    Pixels[i].Pos:=vec3(Random*20,Random*20,Random*20);
    Pixels[i].Col:=vec3(Random,Random,Random);
  end;

  Matrix.Identity;
  FrustumMatrix.Frustum(-w, w, -w, w, 2.5, 1000.0);

  WorldMatrix.Identity;
  WorldMatrix.Translate(0.0, 0.0, -200.0); // Die Scene in den sichtbaren Bereich verschieben.
  WorldMatrix.Scale(5.0);                  // Und der Grösse anpassen.
  //code-

  glEnable(GL_DEPTH_TEST);
  glDepthFunc(GL_LESS);

  Shader := TShader.Create([FileToStr('Vertexshader.glsl'), FileToStr('Fragmentshader.glsl')]);
  with Shader do begin
    UseProgram;
    Matrix_ID := UniformLocation('Matrix');
  end;

  glGenVertexArrays(1, @VBCube.VAO);
  glGenBuffers(1, @VBCube.VBO);

  Timer1.Enabled := True;
end;

procedure TForm1.InitScene;
begin
  glClearColor(0.6, 0.6, 0.4, 1.0); // Hintergrundfarbe

  // --- Daten für Würfel
  glBindVertexArray(VBCube.VAO);

  // Vektor
  glBindBuffer(GL_ARRAY_BUFFER, VBCube.VBO);
  glBufferData(GL_ARRAY_BUFFER, sizeof(TPixel)* Length(Pixels), Pointer(Pixels), GL_STATIC_DRAW);
  glEnableVertexAttribArray(10);                         // 10 ist die Location in inPos Shader.
  glVertexAttribPointer(10, 3, GL_FLOAT, False, 24, nil);

  // Farbe
  glEnableVertexAttribArray(11);                         // 11 ist die Location in inCol Shader.
  glVertexAttribPointer(11, 3, GL_FLOAT, False, 0, Pointer(12));

end;

(*
Das Zeichnen ist das Selbe wie bei Ortho.
*)
procedure TForm1.ogcDrawScene(Sender: TObject);
const
  d = 1.8;
  s = 4;
begin
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
  glEnable(GL_CULL_FACE);
  glCullface(GL_BACK);

  Shader.UseProgram;

  glBindVertexArray(VBCube.VAO);

  //code+
  // --- Zeichne Würfel

        Matrix.Identity;
//        Matrix.Translate(x * d, y * d, z * d);                 // Matrix verschieben.

        Matrix := FrustumMatrix * WorldMatrix * Matrix;        // Matrizen multiplizieren.

        Matrix.Uniform(Matrix_ID);                             // Matrix dem Shader übergeben.
        glPointSize(5.0);
        glDrawArrays(GL_POINTS, 0, Length(Pixels)); // Zeichnet einen kleinen Würfel.
  //code-

  ogc.SwapBuffers;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Shader.Free;

  glDeleteVertexArrays(1, @VBCube.VAO);
  glDeleteBuffers(1, @VBCube.VBO);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  WorldMatrix.RotateA(0.0123);  // Drehe um X-Achse
  WorldMatrix.RotateB(0.0234);  // Drehe um Y-Achse

  ogcDrawScene(Sender);
//  ogc.Invalidate;
end;

//lineal

(*
<b>Vertex-Shader:</b>
*)
//includeglsl Vertexshader.glsl
//lineal

(*
<b>Fragment-Shader</b>
*)
//includeglsl Fragmentshader.glsl

end.
