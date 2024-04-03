unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls,
  oglglad_gl,
  oglContext, oglShader, oglVector, oglMatrix, oglTextur;

//image image.png
(*
Da mit Texturen welche Alpha-Blending haben das gleiche Problem besteht, wie mit den Würfeln, muss man auch dort sortieren.
Da die Position der Bäume keine Drehbewegung haben, reicht ein Vector für dessen Position, eine Matrix ist nicht nötig.
Für den Boden wird eine Matrix gebraucht, da ich diesen drehe.

Zusätzlich habe ich für den Boden noch eine Textur genommen, somit sieht die Scene recht realistisch aus.

Wie Texturen funktionieren, in einem späteren Kapitel.
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
  PTreePos = ^TTreePos;

  TVB = record
    VAO,
    VBOVertex,        // Vertex-Koordinaten
    VBOTex: GLuint;   // Textur-Koordianten
  end;

var
  TreePosArray: array[0..TreeCount - 1] of PTreePos;
  GroundPos: TMatrix;

  SandTextur, BaumTextur: TTexturBuffer;

  VBQuad: TVB;
  FrustumMatrix,
  WorldMatrix,
  Matrix: TMatrix;
  Matrix_ID: GLint;

{ TForm1 }
(*
Den Speicher für die Position der Bäume reservieren.
*)
//code+

procedure TForm1.FormCreate(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to TreeCount - 1 do begin
    New(TreePosArray[i]);
  end;
  //code-

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
  WorldMatrix.Translate(0.0, 0.0, -200.0); // Die Scene in den sichtbaren Bereich verschieben.
  WorldMatrix.Scale(-20.0, -20.0, 20.0);   // Und der Grösse anpassen.

  glEnable(GL_DEPTH_TEST);
  glDepthFunc(GL_LESS);

  Shader := TShader.Create([FileToStr('Vertexshader.glsl'), FileToStr('Fragmentshader.glsl')]);
  with Shader do begin
    UseProgram;
    Matrix_ID := UniformLocation('Matrix');
    glUniform1i(UniformLocation('Sampler'), 0);  // Dem Sampler 0 zuweisen.
  end;

  BaumTextur := TTexturBuffer.Create;
  SandTextur := TTexturBuffer.Create;

  glGenVertexArrays(1, @VBQuad.VAO);
  glGenBuffers(1, @VBQuad.VBOVertex);
  glGenBuffers(1, @VBQuad.VBOTex);

  Timer1.Enabled := True;
end;

(*
Die Position der Bäume  wird zufällig bestimmt.
*)
//code+
procedure TForm1.InitScene;
const
  d = 10;
var
  i: integer;
begin
  for i := 0 to TreeCount - 1 do begin
    TreePosArray[i]^.x := -d / 2 + Random * d;
    TreePosArray[i]^.y := 0.0;
    TreePosArray[i]^.z := -d / 2 + Random * d;
  end;
//code-

  BaumTextur.TexParameter.Add(GL_TEXTURE_WRAP_S, GL_CLAMP_TO_BORDER);
  BaumTextur.TexParameter.Add(GL_TEXTURE_WRAP_T, GL_CLAMP_TO_BORDER);
  BaumTextur.LoadTextures('baum.png');
  SandTextur.LoadTextures('sand.png');

  GroundPos.Identity;

  glClearColor(0.4, 0.4, 0.8, 1.0); // Hintergrundfarbe

  glEnable(GL_BLEND);                                  // Alphablending an
  glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);   // Sortierung der Primitiven von hinten nach vorne.

  // --- Daten für Rechteck

  glBindVertexArray(VBQuad.VAO);

  // Vertex-Koordinaten
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBOVertex);
  glBufferData(GL_ARRAY_BUFFER, sizeof(QuadVertex), @QuadVertex, GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 0, nil);

  // Textur-Koordinaten
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBOTex);
  glBufferData(GL_ARRAY_BUFFER, sizeof(TextureVertex), @TextureVertex, GL_STATIC_DRAW);
  glEnableVertexAttribArray(10);
  glVertexAttribPointer(10, 2, GL_FLOAT, GL_FALSE, 0, nil);

end;

(*
Der Boden und die Bäume zeichen.
Dabei ist es wichtig, das man zuerst den Boden zeichnet, weil die Bäume Alpha-Blending haben.
Objecte mit Alpha-Blending sollte man immer zum Schluss zeichnen.
*)
//code+
procedure TForm1.ogcDrawScene(Sender: TObject);

  procedure QuickSort(var ia: array of PTreePos; ALo, AHi: integer);
  var
    Lo, Hi: integer;
    dummy : PTreePos;
    Pivot: TTreePos;
  begin
    Lo := ALo;
    Hi := AHi;
    Pivot := ia[(Lo + Hi) div 2]^;
    repeat
      while ia[Lo]^.z < Pivot.z do begin
        Inc(Lo);
      end;
      while ia[Hi]^.z > Pivot.z do begin
        Dec(Hi);
      end;
      if Lo <= Hi then begin
        dummy := ia[Lo];
        ia[Lo] := ia[Hi];
        ia[Hi] := dummy;
        Inc(Lo);
        Dec(Hi);
      end;
    until Lo > Hi;
    if Hi > ALo then begin
      QuickSort(ia, ALo, Hi);
    end;
    if Lo < AHi then begin
      QuickSort(ia, Lo, AHi);
    end;
  end;

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
  glDrawArrays(GL_TRIANGLES, 0, Length(QuadVertex));      // Zeichnet einen kleinen Würfel.

  // --- Zeichne Bäume
  QuickSort(TreePosArray, 0, TreeCount - 1);                  // Die Bäume sortieren.

  BaumTextur.ActiveAndBind;                                   // Baum-Textur binden

  for i := 0 to TreeCount - 1 do begin
    Matrix.Identity;
    Matrix.Translate(TreePosArray[i]^);                       // Die Bäume an die richtige Position bringen

    Matrix := FrustumMatrix * WorldMatrix * Matrix;           // Matrizen multiplizieren.

    Matrix.Uniform(Matrix_ID);
    glDrawArrays(GL_TRIANGLES, 0, Length(QuadVertex));
  end;

  ogc.SwapBuffers;
end;
//code-

procedure TForm1.FormDestroy(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to TreeCount - 1 do begin
    Dispose(TreePosArray[i]);
  end;

  Shader.Free;
  BaumTextur.Free;
  SandTextur.Free;

  glDeleteVertexArrays(1, @VBQuad.VAO);
  glDeleteBuffers(1, @VBQuad.VBOVertex);
  glDeleteBuffers(1, @VBQuad.VBOTex);
end;

(*
Da sieht man, das es reicht nur den Vector zu drehen.
*)
//code+
procedure TForm1.Timer1Timer(Sender: TObject);
const
  rot = 0.0134;
var
  i: integer;
begin
  for i := 0 to TreeCount - 1 do begin
    TreePosArray[i]^.RotateB(rot);
  end;
  GroundPos.RotateB(rot);

  ogc.Invalidate;
end;
//code-

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
