unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, Menus,
  dglOpenGL,
  oglContext, oglShader, oglVector, oglMatrix, oglTextur;

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

    procedure CalcCircle;
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

type
  TVB = record
    VAO: GLuint;
    VBO: record
      Vertex: GLuint;
      end;
  end;

var
  Linies: array of TVector2f;

  VBRingL: TVB;
  RotMatrix, ScaleMatrix, ProdMatrix: TMatrix;
  Matrix_ID: GLint;

  TextureBuffer: TTexturBuffer;

procedure TForm1.CalcCircle;
const
  Sektoren = 30;
  maxSek = Sektoren * 8;
  r = 0.7 / maxSek;
  va = 0;
var
  i: integer;
begin
  case va of
    0: begin
      SetLength(Linies, maxSek);
      for i := 0 to maxSek - 1 do begin
        Linies[i].x := sin(Pi * 2 / Sektoren * i) * r * i;
        Linies[i].y := cos(Pi * 2 / Sektoren * i) * r * i;
      end;
    end;
    1: begin
      SetLength(Linies, Sektoren);
      Linies[0, 0] := -1.0 + 1.0 / Sektoren * i * 2;
      Linies[0, 1] := 0.0;
      for i := 1 to Sektoren - 1 do begin
        Linies[i, 0] := -1.0 + 1.0 / Sektoren * i * 2;
        Linies[i, 1] := Linies[i - 1, 1] + (-0.08 + Random * 0.16);
      end;
    end;
    2: begin
      SetLength(Linies, 9);
      Linies[0] := vec2(0.0, 0.0);
      Linies[1] := vec2(-0.5, -0.5);
      Linies[2] := vec2(0.5, -0.5);
      Linies[3] := vec2(0.5, 0.5);
      Linies[4] := vec2(-0.5, 0.5);
      Linies[5] := vec2(-1.0, 0.5);
      Linies[6] := vec2(-0.2, 0.25);
      Linies[7] := vec2(-0.2, -0.25);
      Linies[8] := vec2(0.0, 0.0);
    end;
  end;
end;

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
  Timer1.Enabled := True;
end;

procedure TForm1.CreateScene;
begin
  CalcCircle;

  glGenVertexArrays(1, @VBRingL.VAO);
  glGenBuffers(1, @VBRingL.VBO);

  TextureBuffer := TTexturBuffer.Create;
  TextureBuffer.LoadTextures('muster.xpm');

  Shader := TShader.Create;
  Shader.LoadShaderObjectFromFile(GL_VERTEX_SHADER, 'Vertexshader.glsl');
  Shader.LoadShaderObjectFromFile(GL_GEOMETRY_SHADER, 'Geometrieshader.glsl');
  Shader.LoadShaderObjectFromFile(GL_FRAGMENT_SHADER, 'Fragmentshader.glsl');
  Shader.LinkProgram;
  Shader.UseProgram;

  Matrix_ID := Shader.UniformLocation('mat');

  RotMatrix.Identity;
  ScaleMatrix.Identity;
  //  ScaleMatrix.Scale(0.45);
  ProdMatrix.Identity;
end;

procedure TForm1.InitScene;
begin
  TextureBuffer.ActiveAndBind;
  glClearColor(0.6, 0.6, 0.4, 1.0);

  // Ring Links
  glBindVertexArray(VBRingL.VAO);

  glBindBuffer(GL_ARRAY_BUFFER, VBRingL.VBO.Vertex);
  glBufferData(GL_ARRAY_BUFFER, Length(Linies) * SizeOf(TVector2f), Pointer(Linies), GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 2, GL_FLOAT, False, 0, nil);
end;

procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT);

  TextureBuffer.ActiveAndBind;

  Shader.UseProgram;

  ProdMatrix := ScaleMatrix * RotMatrix;

  // Zeichne linke Scheibe
  ProdMatrix.Uniform(Matrix_ID);

  glBindVertexArray(VBRingL.VAO);
  glDrawArrays(GL_LINE_STRIP_ADJACENCY, 0, Length(Linies));

  ogc.SwapBuffers;
end;

//code-

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Timer1.Enabled := False;

  TextureBuffer.Free;

  glDeleteVertexArrays(1, @VBRingL.VAO);
  glDeleteBuffers(1, @VBRingL.VBO);

  Shader.Free;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
const
  step: GLfloat = 0.01;
begin
  //  RotMatrix.RotateC(step);
  ogcDrawScene(Sender);
end;

end.
