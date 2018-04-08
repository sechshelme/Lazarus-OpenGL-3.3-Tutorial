unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, Menus,
  dglOpenGL,
  oglContext, oglShader, oglVertex, oglMatrix, oglTextur;

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
Die Textur-Koordinaten kann man im Shader auch mit einer Matrix multipizieren.
Dies geschieht ähnlich, wie bei den Vertex-Koordinanten, der grösste Unterschied dabei ist, das es sich um 2D-Koordinaten handelt.

Das Translate ist noch fehlerhaft !!!!!
*)
//lineal
const
  QuadVertex: array[0..5] of TVector3f =       // Koordinaten der Polygone.
    ((-0.8, -0.8, 0.0), (0.8, 0.8, 0.0), (-0.8, 0.8, 0.0),
    (-0.8, -0.8, 0.0), (0.8, -0.8, 0.0), (0.8, 0.8, 0.0));

  TextureVertex: array[0..5] of TVector2f =    // Textur-Koordinaten
    ((0.0, 0.0), (1.0, 1.0), (0.0, 1.0),
    (0.0, 0.0), (1.0, 0.0), (1.0, 1.0));

type
  TVB = record
    VAO,
    VBOVertex,        // Vertex-Koordinaten
    VBOTex: GLuint;   // Textur-Koordianten
  end;

var
  VBQuad: TVB;
  ScaleMatrix: TMatrix;
  texTransMatrix, texRotMatrix: TMatrix2D;
  texMatrix_ID,
  Matrix_ID: GLint;

  Textur: TTexturBuffer;

  TexturTransform: record
    scale: GLfloat;
    direction: boolean;
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

  CreateScene;
  InitScene;
  Timer1.Enabled := True;
end;

procedure TForm1.CreateScene;
begin
  glGenVertexArrays(1, @VBQuad.VAO);
  glGenBuffers(1, @VBQuad.VBOVertex);
  glGenBuffers(1, @VBQuad.VBOTex);

  Textur := TTexturBuffer.Create;

  Shader := TShader.Create([FileToStr('Vertexshader.glsl'), FileToStr('Fragmentshader.glsl')]);
  with Shader do begin
    UseProgram;
    texMatrix_ID := UniformLocation('texMat');
    Matrix_ID := UniformLocation('mat');
    glUniform1i(UniformLocation('Sampler'), 0);  // Dem Sampler 0 zuweisen.
  end;
  ScaleMatrix.Identity;
  ScaleMatrix.Scale(1.1);

  texRotMatrix.Identity;

  texTransMatrix.Identity;
  texTransMatrix.Translate(0.5, 0.0);

  with TexturTransform do begin
    scale := 1.0;
    direction := True;
  end;
end;

(*
*)
//code+
procedure TForm1.InitScene;
begin
  Textur.LoadTextures('mauer.bmp');
  //code-
  glClearColor(0.6, 0.6, 0.4, 1.0);

  glBindVertexArray(VBQuad.VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBOVertex);
  glBufferData(GL_ARRAY_BUFFER, sizeof(QuadVertex), @QuadVertex, GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 3, GL_FLOAT, False, 0, nil);

  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBOTex);
  glBufferData(GL_ARRAY_BUFFER, sizeof(TextureVertex), @TextureVertex, GL_STATIC_DRAW);
  glEnableVertexAttribArray(10);
  glVertexAttribPointer(10, 2, GL_FLOAT, False, 0, nil);
end;

(*
Matrizen multiplizieren und den Shader übergeben.
*)
//code+
procedure TForm1.ogcDrawScene(Sender: TObject);
var
  m: TMatrix2D;
begin
  glClear(GL_COLOR_BUFFER_BIT);
  Textur.ActiveAndBind;
  Shader.UseProgram;

  ScaleMatrix.Uniform(Matrix_ID);  // Matrix für die Vektoren.

  // --- Texturmatrizen multiplizieren und übergeben.
  m := texRotMatrix;                                    // texRotMatrix sichern.
  texRotMatrix.Multiply(texTransMatrix, texRotMatrix);  // multiplizieren
  texRotMatrix.Uniform(texMatrix_ID);                   // Dem Shader übergeben.
  texRotMatrix := m;                                    // Gersicherte Matrix laden.

  // --- Zeichne Quadrat
  glBindVertexArray(VBQuad.VAO);
  glDrawArrays(GL_TRIANGLES, 0, Length(QuadVertex));

  ogc.SwapBuffers;
end;
//code-

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Timer1.Enabled := False;

  Textur.Free;

  glDeleteVertexArrays(1, @VBQuad.VAO);
  glDeleteBuffers(1, @VBQuad.VBOVertex);
  glDeleteBuffers(1, @VBQuad.VBOTex);

  Shader.Free;
end;

(*
Berechnen der Matrix-Bewegungen.
*)
//code+
procedure TForm1.Timer1Timer(Sender: TObject);
const
  sstep = 1.03;  // Schritt für Skalierung
  rstep = 0.01;  // Schritt für Rotation

  winkel: single = 0.0;
begin
  with TexturTransform do begin
    if direction then begin
      scale *= sstep;
      if scale > 15.0 then begin
        direction := False;
      end;
    end else begin
      scale /= sstep;
      if scale < 1.0 then begin
        direction := True;
      end;
    end;

    winkel := winkel + rstep;
    if winkel > 2 * pi then begin
      winkel := winkel - 2 * pi;
    end;

    texRotMatrix.Identity;        // Matrix manipulieren.
    texRotMatrix.Scale(scale);
    texRotMatrix.Rotate(winkel);
  end;
  ogcDrawScene(Sender);
end;
//code-

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
