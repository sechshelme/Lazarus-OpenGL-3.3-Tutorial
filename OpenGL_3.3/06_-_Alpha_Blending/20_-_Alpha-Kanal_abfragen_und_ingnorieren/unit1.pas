unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls,
  dglOpenGL,
  oglContext, oglShader, oglVector, oglMatrix, oglTextur;

//image image.png
(*
Bei Texturen mit Alphablending gibt es noch eine einfacher Variante als sortieren.
Voraus gesetzt der Alphakanal ist voll transparent.

Wen es transparent ist, wird einfach kein Pixel gezeichnet und dadurch wird auch der Z-Buffer nicht aktualisiert.
Dies spielt sich im FragmentShader ab.
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
  QuadVertex: array[0..5] of TVector3f =
    ((-1.0, -1.0, 0.0), (1.0, 1.0, 0.0), (-1.0, 1.0, 0.0),
    (-1.0, -1.0, 0.0), (1.0, -1.0, 0.0), (1.0, 1.0, 0.0));

  TextureVertex: array[0..5] of TVector2f =
    ((0.0, 0.0), (1.0, 1.0), (0.0, 1.0),
    (0.0, 0.0), (1.0, 0.0), (1.0, 1.0));

  TreeCount = 30; // Anzahl Bäume

type
  TTreePos = TVector3f;

  TVB = record
    VAO,
    VBOVertex,        // Vertex-Koordinaten
    VBOTex: GLuint;   // Textur-Koordianten
  end;

var
  TreePosArray: array[0..TreeCount - 1] of TTreePos;
  GroundPos: TMatrix;

  SandTextur, BaumTextur: TTexturBuffer;

  VBQuad: TVB;
  FrustumMatrix,
  WorldMatrix,
  Matrix: TMatrix;
  Matrix_ID: GLint;

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  Randomize;
  //remove+
  Width := 340;
  Height := 240;
  //remove-
  ogc := TContext.Create(Self);
  ogc.OnPaint := @ogcDrawScene;

  CreateScene;
  InitScene;
end;

procedure TForm1.CreateScene;
const
  w = 1.0;
begin
  Matrix.Identity;
  FrustumMatrix.Frustum(-w, w, -w, w, 2.5, 1000.0);

  WorldMatrix.Identity;
  WorldMatrix.Translate(0.0, 0.0, -200.0);
  WorldMatrix.Scale(-30.0, -30.0, 20.0);

  glEnable(GL_DEPTH_TEST);
  glDepthFunc(GL_LESS);

  Shader := TShader.Create([FileToStr('Vertexshader.glsl'), FileToStr('Fragmentshader.glsl')]);
  with Shader do begin
    UseProgram;
    Matrix_ID := UniformLocation('Matrix');
    glUniform1i(UniformLocation('Sampler'), 0);
  end;

  BaumTextur := TTexturBuffer.Create;
  SandTextur := TTexturBuffer.Create;

  glGenVertexArrays(1, @VBQuad.VAO);
  glGenBuffers(1, @VBQuad.VBOVertex);
  glGenBuffers(1, @VBQuad.VBOTex);

  Timer1.Enabled := True;
end;

procedure TForm1.InitScene;
const
  d = 10;
var
  i: integer;
begin
  for i := 0 to TreeCount - 1 do begin
    TreePosArray[i].x := -d / 2 + Random * d;
    TreePosArray[i].y := 0.0;
    TreePosArray[i].z := -d / 2 + Random * d;
  end;

  BaumTextur.TexParameter.Add(GL_TEXTURE_WRAP_S, GL_CLAMP_TO_BORDER);
  BaumTextur.TexParameter.Add(GL_TEXTURE_WRAP_T, GL_CLAMP_TO_BORDER);
  BaumTextur.LoadTextures('baum.png');
  SandTextur.LoadTextures('sand.png');

  GroundPos.Identity;

  glClearColor(0.4, 0.4, 0.8, 1.0); // Hintergrundfarbe

  glEnable(GL_BLEND);
  glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);

  // --- Daten für Rechteck

  glBindVertexArray(VBQuad.VAO);

  // Vertex-Koordinaten
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBOVertex);
  glBufferData(GL_ARRAY_BUFFER, sizeof(QuadVertex), @QuadVertex, GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 3, GL_FLOAT, False, 0, nil);

  // Textur-Koordinaten
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBOTex);
  glBufferData(GL_ARRAY_BUFFER, sizeof(TextureVertex), @TextureVertex, GL_STATIC_DRAW);
  glEnableVertexAttribArray(10);
  glVertexAttribPointer(10, 2, GL_FLOAT, False, 0, nil);

end;

(*
Es empfieht sich trotzdem immer die Objecte mit Alpha-Blending zum Schluss zu zeichnen.
Aber es muss nicht mehr sortiert werden.
*)
//code+
procedure TForm1.ogcDrawScene(Sender: TObject);

var
  i: integer;
begin
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);        // Frame und Tiefen-Puffer löschen.

  glEnable(GL_CULL_FACE);
  glCullface(GL_BACK);

  Shader.UseProgram;

  glBindVertexArray(VBQuad.VAO);

  // --- Zeichne Boden
  SandTextur.ActiveAndBind;                                   // Boden-Textur binden
  Matrix.Identity;
  Matrix.Translate(0.0, 1.0, 0.0);
  Matrix.Scale(10.0);
  Matrix.RotateA(Pi / 2);

  Matrix := FrustumMatrix * WorldMatrix * GroundPos * Matrix; // Matrizen multiplizieren.

  Matrix.Uniform(Matrix_ID);                                  // Matrix dem Shader übergeben.
  glDrawArrays(GL_TRIANGLES, 0, Length(QuadVertex));          // Zeichnet einen kleinen Würfel.

  // --- Zeichne Bäume
  BaumTextur.ActiveAndBind;                                   // Baum-Textur binden

  for i := 0 to TreeCount - 1 do begin
    Matrix.Identity;
    Matrix.Translate(TreePosArray[i]);                        // Die Bäume an die richtige Position bringen

    Matrix := FrustumMatrix * WorldMatrix * Matrix;           // Matrizen multiplizieren.

    Matrix.Uniform(Matrix_ID);
    glDrawArrays(GL_TRIANGLES, 0, Length(QuadVertex));
  end;

  ogc.SwapBuffers;
end;
//code-

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Shader.Free;
  BaumTextur.Free;
  SandTextur.Free;

  glDeleteVertexArrays(1, @VBQuad.VAO);
  glDeleteBuffers(1, @VBQuad.VBOVertex);
  glDeleteBuffers(1, @VBQuad.VBOTex);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
const
  rot = 0.0134;
var
  i: integer;
begin
  for i := 0 to TreeCount - 1 do begin
    TreePosArray[i].RotateB(rot);
  end;
  GroundPos.RotateB(rot);

  ogc.Invalidate;
end;

//lineal

(*
<b>Vertex-Shader:</b>
*)
//includeglsl Vertexshader.glsl
//lineal

(*
<b>Fragment-Shader</b>
Hier wird abgefragt, ob der Pixel transparent ist, wen ja wird er nicht ausgegeben und
dadurch wird der Z-Buffer nicht aktualisiert. Dadurch werden Objecte hinter der transparent Textur trozdem gezeichnet.

Da die Kanten der Baume nicht voll transparent sind, habe ich einen Mittelwert von 0.5 genommen.
Da muss man abschätzen, wie streng die Prüfung sein soll.
*)
//includeglsl Fragmentshader.glsl

end.
