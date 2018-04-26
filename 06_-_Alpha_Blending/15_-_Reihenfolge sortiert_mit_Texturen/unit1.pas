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
Wie Texturen funktionieren, in einem späterne Kapitel
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

type
  TCube = array[0..11] of Tmat3x3;

const
  QuadVertex: array[0..5] of TVector3f =
    ((-0.8, -0.8, 0.0), (0.8, 0.8, 0.0), (-0.8, 0.8, 0.0),
    (-0.8, -0.8, 0.0), (0.8, -0.8, 0.0), (0.8, 0.8, 0.0));

  TextureVertex: array[0..5] of TVector2f =
    ((0.0, 0.0), (1.0, 1.0), (0.0, 1.0),
    (0.0, 0.0), (1.0, 0.0), (1.0, 1.0));

type
  TVB = record
    VAO,
    VBOVertex,        // Vertex-Koordinaten
    VBOTex: GLuint;   // Textur-Koordianten
  end;

const
//  s = 2;
//  l = 2 * s + 1;
  all = 60;

type
  TCubePos = record
    pos: TVector3f;
  end;

var
  CubePosArray: array[0..all - 1] of TCubePos;

  Textur: TTexturBuffer;

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

(*
*)
//code+
procedure TForm1.CreateScene;
const
  w = 1.0;
begin
  Matrix.Identity;
  FrustumMatrix.Frustum(-w, w, -w, w, 2.5, 1000.0);

  //   FrustumMatrix.Perspective(45, 1.0, 2.5, 1000.0); // Alternativ

  WorldMatrix.Identity;
  WorldMatrix.Translate(0.0, 0.0, -200.0); // Die Scene in den sichtbaren Bereich verschieben.
  WorldMatrix.Scale(-20.0, -20.0, 20.0);                  // Und der Grösse anpassen.
  //code-

  glEnable(GL_DEPTH_TEST);
  glDepthFunc(GL_LESS);

  Shader := TShader.Create([FileToStr('Vertexshader.glsl'), FileToStr('Fragmentshader.glsl')]);
  with Shader do begin
    UseProgram;
    Matrix_ID := UniformLocation('Matrix');
    glUniform1i(UniformLocation('Sampler'), 0);  // Dem Sampler 0 zuweisen.
  end;

  Textur := TTexturBuffer.Create;

  glGenVertexArrays(1, @VBQuad.VAO);
  glGenBuffers(1, @VBQuad.VBOVertex);
  glGenBuffers(1, @VBQuad.VBOTex);

  Timer1.Enabled := True;
end;

procedure TForm1.InitScene;
const
  d = 14;
var
  i:Integer;
begin
  Textur.LoadTextures('baum.png');

  for i := 0 to all - 1 do begin
    CubePosArray[i].pos.x := -d / 2 + Random(d);
    CubePosArray[i].pos.y := 0.0;
    CubePosArray[i].pos.z := -d / 2 + Random(d);
  end;

  glClearColor(0.6, 0.6, 0.4, 1.0); // Hintergrundfarbe

  glEnable(GL_BLEND);                                  // Alphablending an
  glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);   // Sortierung der Primitiven von hinten nach vorne.

  // --- Daten für Rechteck

  glBindVertexArray(VBQuad.VAO);

  // Vertex
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
Das Zeichnen ist das Selbe wie bei Ortho.
*)
procedure TForm1.ogcDrawScene(Sender: TObject);

  procedure QuickSort(var ia: array of TCubePos; ALo, AHi: integer);
  var
    Lo, Hi: integer;
    dummy, Pivot : TCubePos;
  begin
    Lo := ALo;
    Hi := AHi;
    Pivot := ia[(Lo + Hi) div 2];
    repeat
      while ia[Lo].pos.z < Pivot.pos.z do begin
        Inc(Lo);
      end;
      while ia[Hi].pos.z > Pivot.pos.z do begin
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
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);  // Frame und Tiefen-Buffer löschen.

  glEnable(GL_CULL_FACE);
  glCullface(GL_BACK);

  Textur.ActiveAndBind; // Textur binden
  Shader.UseProgram;

  glBindVertexArray(VBQuad.VAO);

  QuickSort(CubePosArray, 0, all-1);

  //code+
  // --- Zeichne Würfel

  for i := 0 to all - 1 do begin
    Matrix.Identity;
    Matrix.Translate(CubePosArray[i].pos);                 // Matrix verschieben.

    Matrix.Multiply(WorldMatrix, Matrix);                  // Matrixen multiplizieren.
    Matrix.Multiply(FrustumMatrix, Matrix);

    Matrix.Uniform(Matrix_ID);                             // Matrix dem Shader übergeben.
    glDrawArrays(GL_TRIANGLES, 0, Length(QuadVertex) * 3); // Zeichnet einen kleinen Würfel.
  end;
  //code-

  ogc.SwapBuffers;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Shader.Free;
  Textur.Free;

  glDeleteVertexArrays(1, @VBQuad.VAO);
  glDeleteBuffers(1, @VBQuad.VBOVertex);
  glDeleteBuffers(1, @VBQuad.VBOTex);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
  i: Integer;
begin
    for i := 0 to all - 1 do begin
      CubePosArray[i].pos.RotateB(0.0234);
    end;

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
*)
//includeglsl Fragmentshader.glsl

end.
