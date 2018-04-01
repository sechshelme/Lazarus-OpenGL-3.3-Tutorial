unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls,
  dglOpenGL,
  oglContext, oglShader, oglVertex, oglMatrix, oglTextur;

//image image.png
(*
Das Directional-Light entspricht in etwa dem Sonnen-Licht, die Lichtstrahlen kommen alle von der gleichen Richtung.
Im Grunde ist die Sonne auch ein Punktlicht, aber auf der Erde nimmt man es als Directional-Light war.
Im Beispiel von Rechts.

Im ersten Beispiel wurde die Beleuchung mit Acos und Pi berechnet.
Dieser Umweg kann man sich sparen, es gibt zwar so ein kleiner Rechnungsfehler, aber diesen kann man getrost ingnorieren.
Dies hat sogar den Vorteil, wen der Einstrahlwinkel des Lichtes flacher als 90° ist, ist die Beleuchtungsstärke gleich null.
Als was flacher als 90° ist, ist negativ.
Für dies gibt es in GLSL eine fertige Funktion <b>clamp</b>, mit der kann man einen Bereich festlegen.
So das es in diesem Beispiel keinen Wert < <b>0.0</b> oder > <b>1.0</b> gibt.

Der einzige Unterschied zu vorherigem Beispiel ist im Shader-Code. Auch der Hintergrund wurde etwas dunkler gemacht, das man den Licht-Effekt besser sieht.

Bei dem Lichtpositions-Vector ist es egal, wie weit die Lichtquelle weg ist, da der Vektor nur die Lichtrichtung angeben muss.
Meistens nimmt man aber einen <b>Einheitsvektor</b>, das ist ein Vektor mit der Länge <b>1.0</b>.
Die Lichtposition wird im Vertex-Shader als Konstante definiert.
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
    procedure ogcResize(Sender: TObject);
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

type
  TCube3D = array[0..11] of Tmat3x3;
  TCube2D = array[0..11] of Tmat3x2;

const
  CubeVertex: TCube3D =
    (((-0.5, 0.5, 0.5), (-0.5, -0.5, 0.5), (0.5, -0.5, 0.5)), ((-0.5, 0.5, 0.5), (0.5, -0.5, 0.5), (0.5, 0.5, 0.5)),
    ((0.5, 0.5, 0.5), (0.5, -0.5, 0.5), (0.5, -0.5, -0.5)), ((0.5, 0.5, 0.5), (0.5, -0.5, -0.5), (0.5, 0.5, -0.5)),
    ((0.5, 0.5, -0.5), (0.5, -0.5, -0.5), (-0.5, -0.5, -0.5)), ((0.5, 0.5, -0.5), (-0.5, -0.5, -0.5), (-0.5, 0.5, -0.5)),
    ((-0.5, 0.5, -0.5), (-0.5, -0.5, -0.5), (-0.5, -0.5, 0.5)), ((-0.5, 0.5, -0.5), (-0.5, -0.5, 0.5), (-0.5, 0.5, 0.5)),
    // oben
    ((0.5, 0.5, 0.5), (0.5, 0.5, -0.5), (-0.5, 0.5, -0.5)), ((0.5, 0.5, 0.5), (-0.5, 0.5, -0.5), (-0.5, 0.5, 0.5)),
    // unten
    ((-0.5, -0.5, 0.5), (-0.5, -0.5, -0.5), (0.5, -0.5, -0.5)), ((-0.5, -0.5, 0.5), (0.5, -0.5, -0.5), (0.5, -0.5, 0.5)));


  CubeTextur: TCube2D = (
    ((0.0, 3.0), (0.0, 0.0), (3.0, 0.0)), ((0.0, 3.0), (3.0, 0.0), (3.0, 3.0)),
    ((0.0, 3.0), (0.0, 0.0), (3.0, 0.0)), ((0.0, 3.0), (3.0, 0.0), (3.0, 3.0)),
    ((0.0, 3.0), (0.0, 0.0), (3.0, 0.0)), ((0.0, 3.0), (3.0, 0.0), (3.0, 3.0)),
    ((0.0, 3.0), (0.0, 0.0), (3.0, 0.0)), ((0.0, 3.0), (3.0, 0.0), (3.0, 3.0)),
    ((0.0, 3.0), (0.0, 0.0), (3.0, 0.0)), ((0.0, 3.0), (3.0, 0.0), (3.0, 3.0)),
    ((0.0, 3.0), (0.0, 0.0), (3.0, 0.0)), ((0.0, 3.0), (3.0, 0.0), (3.0, 3.0)));

var
  CubeNormal: TCube3D;
type
  TVB = record
    VAO,
    VBOvert,            // VBO für Vektor.
    VBONormal,          // VBO für Normale.
    VBOTexture: GLuint; // VBO für Textur.
  end;

var
  VBCube: TVB;
  FrustumMatrix,
  WorldMatrix,
  ModelMatrix,
  Matrix: TMatrix;

  ModelMatrix_ID,
  Matrix_ID: GLint;

  TexturBuffer:record
    Textur, Normal:TTexturBuffer;
  end;

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  //remove+
  Width := 340;
  Height := 240;
  //remove-
  ogc := TContext.Create(Self);
  ogc.OnPaint := @ogcDrawScene;
  ogc.OnResize := @ogcResize;   // neues Ereigniss

  CreateScene;
  InitScene;
end;

procedure TForm1.CreateScene;
begin
  TexturBuffer.Textur := TTexturBuffer.Create;
  TexturBuffer.Normal := TTexturBuffer.Create;

  FaceToNormale(CubeVertex, CubeNormal);

  Matrix.Identity;

  WorldMatrix.Identity;
  WorldMatrix.Translate(0, 0, -200.0);
  WorldMatrix.Scale(75.0);

  ModelMatrix.Identity;

  glEnable(GL_DEPTH_TEST);
  glDepthFunc(GL_LESS);

  Shader := TShader.Create([FileToStr('Vertexshader.glsl'), FileToStr('Fragmentshader.glsl')]);
  with Shader do begin
    UseProgram;
    Matrix_ID := UniformLocation('Matrix');
    ModelMatrix_ID := UniformLocation('ModelMatrix');
    glUniform1i(UniformLocation('Sampler[0]'), 0);  // Dem Sampler[0] 0 zuweisen.
    glUniform1i(UniformLocation('Sampler[1]'), 1);  // Dem Sampler[1] 0 zuweisen.
  end;

  glGenVertexArrays(1, @VBCube.VAO);

  glGenBuffers(1, @VBCube.VBOvert);
  glGenBuffers(1, @VBCube.VBONormal);
  glGenBuffers(1, @VBCube.VBOTexture);

  Timer1.Enabled := True;
end;

procedure TForm1.InitScene;
begin
  glClearColor(0.15, 0.15, 0.1, 1.0); // Hintergrundfarbe

  // Texturen laden
  TexturBuffer.Textur.LoadTextures('textur.bmp');
  TexturBuffer.Normal.LoadTextures('normal.bmp');

  // --- Daten für Würfel
  glBindVertexArray(VBCube.VAO);

  // Vektor
  glBindBuffer(GL_ARRAY_BUFFER, VBCube.VBOvert);
  glBufferData(GL_ARRAY_BUFFER, sizeof(CubeVertex), @CubeVertex, GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 3, GL_FLOAT, False, 0, nil);

  // Normale
  glBindBuffer(GL_ARRAY_BUFFER, VBCube.VBONormal);
  glBufferData(GL_ARRAY_BUFFER, sizeof(CubeNormal), @CubeNormal, GL_STATIC_DRAW);
  glEnableVertexAttribArray(1);
  glVertexAttribPointer(1, 3, GL_FLOAT, False, 0, nil);

  // Textur
  glBindBuffer(GL_ARRAY_BUFFER, VBCube.VBOTexture);
  glBufferData(GL_ARRAY_BUFFER, sizeof(CubeTextur), @CubeTextur, GL_STATIC_DRAW);
  glEnableVertexAttribArray(10);
  glVertexAttribPointer(10, 2, GL_FLOAT, False, 0, nil);

end;

procedure TForm1.ogcDrawScene(Sender: TObject);
var
  x, y, z: integer;
const
  d = 1.8;
  s = 0;
begin
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);  // Frame und Tiefen-Buffer löschen.

  glEnable(GL_CULL_FACE);
  glCullface(GL_BACK);

  TexturBuffer.Textur.ActiveAndBind(0);
  TexturBuffer.Normal.ActiveAndBind(1);

  Shader.UseProgram;

  glBindVertexArray(VBCube.VAO);

  // --- Zeichne Würfel

  for x := -s to s do begin
    for y := -s to s do begin
      for z := -s to s do begin
        Matrix.Identity;
        Matrix.Translate(x * d, y * d, z * d);                 // Matrix verschieben.
        Matrix.Multiply(ModelMatrix, Matrix);

        Matrix.Uniform(ModelMatrix_ID);

        Matrix.Multiply(WorldMatrix, Matrix);                  // Matrixen multiplizieren.
        Matrix.Multiply(FrustumMatrix, Matrix);

        Matrix.Uniform(Matrix_ID);                             // Matrix dem Shader übergeben.
        glDrawArrays(GL_TRIANGLES, 0, Length(CubeVertex) * 3); // Zeichnet einen kleinen Würfel.
      end;
    end;
  end;

  ogc.SwapBuffers;
end;

procedure TForm1.ogcResize(Sender: TObject);
begin
  FrustumMatrix.Perspective(45, ClientWidth / ClientHeight, 2.5, 1000.0);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Shader.Free;

  glDeleteVertexArrays(1, @VBCube.VAO);
  glDeleteBuffers(1, @VBCube.VBOvert);
  glDeleteBuffers(1, @VBCube.VBONormal);
  glDeleteBuffers(1, @VBCube.VBOTexture);

  TexturBuffer.Textur.Free;
  TexturBuffer.Normal.Free;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  ModelMatrix.RotateA(0.00223);  // Drehe um X-Achse
  ModelMatrix.RotateB(0.00434);  // Drehe um Y-Achse

  ogc.Invalidate;
end;

//lineal

(*
Hier sieht man, das anstelle von arcos und Pi, <b>clamp</b> verwendet wurde.
*)

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
