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
Die Textur-Koordinaten kann man im Shader auch mit einer Matrix multipizieren.
Dies geschieht ähnlich, wie bei den Vertex-Koordinanten, der grösste Unterschied dabei ist, das es sich um 2D-Koordinaten handelt.
*)
//lineal
const
  QuadVertex: array[0..3] of TVector3f =       // Koordinaten der Polygone.
    ((-0.8, -0.8, 0.0), (-0.2, 0.8, 0.0), (0.8, -0.8, 0.0), (0.2, 0.8, 0.0));

  TextureVertex: array[0..3] of TVector4f =    // Textur-Koordinaten
  ((0.0, 0.0, 1.0, 0.8), (0.0, 1.0, 1.0, 0.2), (1.6, 0.0, 1.0, 0.8), (0.4, 1.0, 1.0, 0.2));
//  ((0.0, 0.0, 0.0, 0.8), (0.0, 0.8, 0.0, 0.2), (0.8, 0.0, 0.0, 0.8), (0.2, 0.8, 0.0, 0.2));
//  ((0.0, 0.0, 0.0, 0.8), (0.2, 0.0, 0.0, 0.2), (0.0, 0.8, 0.0, 0.8), (0.2, 0.2, 0.0, 0.2));

type
  TVB = record
    VAO,
    VBOVertex,        // Vertex-Koordinaten
    VBOTex: GLuint;   // Textur-Koordianten
  end;

var
  VBQuad: TVB;
  ScaleMatrix: TMatrix;
  texMatrix: TMatrix;
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
    Matrix_ID := UniformLocation('mat');
    texMatrix_ID := UniformLocation('texMat');
    glUniform1i(UniformLocation('Sampler'), 0);  // Dem Sampler 0 zuweisen.
  end;
  ScaleMatrix := TMatrix.Create;
  ScaleMatrix.Scale(1.1);

  texMatrix := TMatrix.Create;

  with TexturTransform do begin
    scale := 1.0;
    direction := True;
  end;
end;

(*
*)
//code+
procedure TForm1.InitScene;
var
  bit: TBitmap;
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
  glVertexAttribPointer(10, 4, GL_FLOAT, False, 0, nil);
end;

procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT);

  Textur.ActiveAndBind;

  Shader.UseProgram;

  ScaleMatrix.Uniform(Matrix_ID);

  texMatrix.Push;
///  texMatrix.Translate(10.5, 10.5,0.0);
  texMatrix.Scale(TexturTransform.scale);

  texMatrix.Uniform(texMatrix_ID);
  texMatrix.Pop;

  // Zeichne Quadrat
  glBindVertexArray(VBQuad.VAO);
  glDrawArrays(GL_TRIANGLE_STRIP, 0, Length(QuadVertex));

  ogc.SwapBuffers;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Timer1.Enabled := False;

  Textur.Free;

  glDeleteVertexArrays(1, @VBQuad.VAO);
  glDeleteBuffers(1, @VBQuad.VBOVertex);
  glDeleteBuffers(1, @VBQuad.VBOTex);

  ScaleMatrix.Free;

  texMatrix.Free;

  Shader.Free;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
const
  sstep = 1.03;  // Schritt für Skalierung
  rstep = 0.01;  // Schritt für Rotation
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


    scale:=10;
    texMatrix.RotateC(rstep/10);
  end;
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
