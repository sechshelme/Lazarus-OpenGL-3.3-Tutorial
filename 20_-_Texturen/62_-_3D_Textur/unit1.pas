unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, Menus,
  oglglad_gl,
  oglContext, oglShader, oglVector, oglMatrix;

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
    procedure ogcDrawScene(Sender: TObject);
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

//image image.png

(*
Ein Einfache Anwendung eine 3D-Textur

Normalerweise wäre die Textur-Vertex eine vec3 Konstante.
Ab da im Beispiel die W-Achse zur Laufzeit geändert wird, wir sie da ingnoriert.
*)
//lineal
//code+
const
  QuadVertex0: array[0..5] of TVector3f =
    ((-0.8, -0.8, 0.0), (0.8, 0.8, 0.0), (-0.8, 0.8, 0.0),
    (-0.8, -0.8, 0.0), (0.8, -0.8, 0.0), (0.8, 0.8, 0.0));

  TextureVertex0: array[0..5] of TVector2f =
    ((0.0, 0.0), (1.0, 1.0), (0.0, 1.0),
    (0.0, 0.0), (1.0, 0.0), (1.0, 1.0));

const
  // Ebene 0
  Textur32_0: array of array[0..3] of byte = (
    ($00, $00, $00, $FF), ($00, $00, $FF, $FF), ($00, $FF, $00, $FF), ($00, $FF, $FF, $FF));
  // Ebene 1
  Textur32_1: array of array[0..3] of byte = (
    ($FF, $00, $00, $FF), ($FF, $00, $FF, $FF), ($FF, $FF, $00, $FF), ($FF, $FF, $FF, $FF));

var
  VAO, VBOVertex, VBOTex: GLuint;
  UBO: TGLuint;
  ProdMatrix: TMatrix;

  UBOBuffer: record
    mat: Tmat4x4;
    W: TGLfloat;  // W-Koordinate
      end;

  //code-
var
  textureID: GLuint;

  { TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  //remove+
  Width := 340;
  Height := 240;
  //remove-
  Timer1.Enabled := False;
  Timer1.Interval := 20;
  ogc := TContext.Create(Self);
  ogc.OnPaint := @ogcDrawScene;

  CreateScene;
end;

// https://stackoverflow.com/questions/16553671/opengl-how-to-use-glteximage3d-function
// https://www.codeproject.com/Articles/352270/Getting-Started-with-Volume-Rendering-using-OpenGL

procedure TForm1.CreateScene;
var
  UBO_ID: GLuint;
begin
  Shader := TShader.Create;
  Shader.LoadShaderObjectFromFile(GL_VERTEX_SHADER, 'Vertexshader.glsl');
  Shader.LoadShaderObjectFromFile(GL_FRAGMENT_SHADER, 'Fragmentshader.glsl');
  Shader.LinkProgram;
  Shader.UseProgram;
  glUniform1i(Shader.UniformLocation('Sampler'), 0);

  // UBO
  glGenBuffers(1, @UBO);
  glBindBuffer(GL_UNIFORM_BUFFER, UBO);
  glBufferData(GL_UNIFORM_BUFFER, SizeOf(UBOBuffer), nil, GL_DYNAMIC_DRAW);

  UBO_ID := Shader.UniformBlockIndex('UBO');
  glUniformBlockBinding(Shader.ID, UBO_ID, 0);
  glBindBufferBase(GL_UNIFORM_BUFFER, 0, UBO);

  // Matrix
  ProdMatrix.Identity;
  ProdMatrix.Scale(0.5);

  // Textur
  glGenTextures(1, @textureID);
  glBindTexture(GL_TEXTURE_3D, textureID);
  glTexImage3D(GL_TEXTURE_3D, 0, GL_RGBA, 2, 2, 2, 0, GL_RGBA, GL_UNSIGNED_BYTE, nil);

  glTexSubImage3D(GL_TEXTURE_3D, 0, 0, 0, 0, 2, 2, 1, GL_RGBA, GL_UNSIGNED_BYTE, PGLvoid(Textur32_0));
  glTexSubImage3D(GL_TEXTURE_3D, 0, 0, 0, 1, 2, 2, 1, GL_RGBA, GL_UNSIGNED_BYTE, PGLvoid(Textur32_1));

//  glTexEnvi(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_REPLACE);
   //glTexParameteri(GL_TEXTURE_3D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_BORDER);
   //glTexParameteri(GL_TEXTURE_3D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_BORDER);
   //glTexParameteri(GL_TEXTURE_3D, GL_TEXTURE_WRAP_R, GL_CLAMP_TO_BORDER);
   //glTexParameteri(GL_TEXTURE_3D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
   //glTexParameteri(GL_TEXTURE_3D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);

  glTexParameterf(GL_TEXTURE_3D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
  glTexParameterf(GL_TEXTURE_3D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
  glTexParameterf(GL_TEXTURE_3D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
  glTexParameterf(GL_TEXTURE_3D, GL_TEXTURE_WRAP_R, GL_CLAMP_TO_EDGE);

  glBindTexture(GL_TEXTURE_3D, 0);
  //code-

  glClearColor(0.6, 0.6, 0.4, 1.0);

  // Attribute
  glGenVertexArrays(1, @VAO);
  glGenBuffers(1, @VBOVertex);
  glGenBuffers(1, @VBOTex);

  glBindVertexArray(VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBOVertex);
  glBufferData(GL_ARRAY_BUFFER, sizeof(QuadVertex0), @QuadVertex0, GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 0, nil);

  glBindBuffer(GL_ARRAY_BUFFER, VBOTex);
  glBufferData(GL_ARRAY_BUFFER, sizeof(TextureVertex0), @TextureVertex0, GL_STATIC_DRAW);
  glEnableVertexAttribArray(1);
  glVertexAttribPointer(1, 2, GL_FLOAT, GL_FALSE, 0, nil);

  Timer1.Enabled := True;
end;

procedure TForm1.ogcDrawScene(Sender: TObject);
const
  ofs: integer = 0;
begin
  glClear(GL_COLOR_BUFFER_BIT);
  Shader.UseProgram;

  glBindTexture(GL_TEXTURE_3D, textureID);
  glBindVertexArray(VAO);

  Inc(ofs);
  UBOBuffer.W := (sin(ofs / 30) + 1) / 2; // W nachträglich ändern
  UBOBuffer.mat := ProdMatrix;

  glBufferSubData(GL_UNIFORM_BUFFER, 0, sizeof(UBOBuffer), @UBOBuffer);
  glDrawArrays(GL_TRIANGLES, 0, Length(QuadVertex0));

  ogc.SwapBuffers;
end;
procedure TForm1.FormDestroy(Sender: TObject);
begin
  glDeleteTextures(1, @textureID);
  glDeleteVertexArrays(1, @VAO);
  glDeleteBuffers(1, @VBOVertex);
  glDeleteBuffers(1, @VBOTex);
  glDeleteBuffers(1, @UBO);

  Shader.Free;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
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
