unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls,
  oglglad_gl, oglDebug, oglVector,
  oglContext, oglShader;

  //image image.png
(*
Dies könnte man auch mit einer Array in Uniform lösen,
nur dort ist die Array-Grenze recht limitiert.
*)

  //lineal

type
  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    ogc: TContext;
    Shader: TShader;
    procedure CreateScene;
    procedure ogcDrawScene(Sender: TObject);
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

//code+
const
  TriangleVector: array[0..0] of TFace =
    (((-0.4, 0.1, 0.0), (0.4, 0.1, 0.0), (0.0, 0.7, 0.0)));

  QuadVector: array[0..1] of TFace =
    (((-0.2, -0.6, 0.0), (-0.2, -0.1, 0.0), (0.2, -0.1, 0.0)),
    ((-0.2, -0.6, 0.0), (0.2, -0.1, 0.0), (0.2, -0.6, 0.0)));

  TBOData: array of TVector3f = ((1, 0, 0), (0, 1, 0), (0, 0, 1), (1, 0, 1), (1, 1, 0), (0, 1, 1));
  //code-

  // https://wiki.delphigl.com/index.php/TextureBufferObjects

type
  TVB = record
    VAO,
    VBOvert: GLuint;
  end;

var
  VBTriangle, VBQuad: TVB;

  TBO_tex_ID: GLint;
  TBO, Textur_ID: GLuint;

  { TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  //remove+
  Width := 340;
  Height := 240;
  //remove-
  ogc := TContext.Create(Self);
  ogc.OnPaint := @ogcDrawScene;

  InitOpenGLDebug;
  CreateScene;
end;

//code+
procedure TForm1.CreateScene;
begin
  Shader := TShader.Create([FileToStr('Vertexshader.glsl'), FileToStr('Fragmentshader.glsl')]);
  Shader.UseProgram;
  TBO_tex_ID := Shader.UniformLocation('sb');
  glUniform1i(TBO_tex_ID, 0);

  glClearColor(0.6, 0.6, 0.4, 1.0);

  // --- VAO für Dreieck
  glGenVertexArrays(1, @VBTriangle.VAO);
  glBindVertexArray(VBTriangle.VAO);

  glGenBuffers(1, @VBTriangle.VBOvert);
  glBindBuffer(GL_ARRAY_BUFFER, VBTriangle.VBOvert);
  glBufferData(GL_ARRAY_BUFFER, sizeof(TriangleVector), @TriangleVector, GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 0, nil);

  // --- VAO für Quadrat
  glGenVertexArrays(1, @VBQuad.VAO);
  glBindVertexArray(VBQuad.VAO);

  glGenBuffers(1, @VBQuad.VBOvert);
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBOvert);
  glBufferData(GL_ARRAY_BUFFER, sizeof(QuadVector), @QuadVector, GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 0, nil);

  // --- TBO
  glGenBuffers(1, @TBO);
  glBindBuffer(GL_TEXTURE_BUFFER, TBO);
  glBufferData(GL_TEXTURE_BUFFER, Length(TBOData) * SizeOf(TVector3f), PGLvoid(TBOData), GL_STATIC_DRAW);
  glGenTextures(1, @Textur_ID);
end;
//code-

//code+
procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT);

  Shader.UseProgram;

  // --- TBO
  glActiveTexture(GL_TEXTURE0);
  glBindTexture(GL_TEXTURE_BUFFER, Textur_ID);
  glTexBuffer(GL_TEXTURE_BUFFER, GL_RGB32F, TBO);

  // --- Zeichne Dreieck
  glBindVertexArray(VBTriangle.VAO);
  glDrawArrays(GL_TRIANGLES, 0, Length(TriangleVector) * 3);

  // --- Zeichne Quadrat
  glBindVertexArray(VBQuad.VAO);
  glDrawArrays(GL_TRIANGLES, 0, Length(QuadVector) * 3);

  ogc.SwapBuffers;
end;

//code-

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Shader.Free;
  glDeleteBuffers(1, @TBO);

  glDeleteVertexArrays(1, @VBTriangle.VAO);
  glDeleteVertexArrays(1, @VBQuad.VAO);

  glDeleteBuffers(1, @VBTriangle.VBOvert);
  glDeleteBuffers(1, @VBQuad.VBOvert);
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
