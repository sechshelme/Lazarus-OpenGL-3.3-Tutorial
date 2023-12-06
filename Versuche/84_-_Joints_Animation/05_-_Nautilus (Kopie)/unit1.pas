unit Unit1;

{$mode objfpc}{$H+}
{$modeswitch typehelpers}
{$modeswitch arrayoperators}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, Menus,
  dglOpenGL,
  oglContext, oglShader, oglVector, oglVectors, oglMatrix;

type
  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    ogc: TContext;
    Shader: TShader;
    procedure CreateScene;
    procedure CreatJoints;
    procedure ogcDrawScene(Sender: TObject);
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

//image image.png
//lineal

type
  TUBOBuffer = record
    ModelMatrix: TMatrix;
  end;

var
  UBOBuffer: TUBOBuffer;
  QuadVertex: TVectors2f = nil;

var
  VAO, VBOVektor, UBO: GLint;

  { TJointIDsHelper }

procedure TForm1.FormCreate(Sender: TObject);
begin
  //remove+
  Width := 640;
  Height := 480;
  //remove-
  Randomize;
  ogc := TContext.Create(Self);
  ogc.OnPaint := @ogcDrawScene;

  CreateScene;
end;

procedure TForm1.CreatJoints;
begin
end;

// https://www.youtube.com/watch?app=desktop&v=lDaQ3a43x8A

procedure TForm1.CreateScene;
var
  tmpQuad: TVectors2f = nil;
  UBO_ID: GLuint;
begin
  Shader := TShader.Create;
  Shader.LoadShaderObjectFromFile(GL_VERTEX_SHADER, 'Vertexshader.glsl');
  Shader.LoadShaderObjectFromFile(GL_FRAGMENT_SHADER, 'Fragmentshader.glsl');
  Shader.LinkProgramm;
  Shader.UseProgram;

  glGenBuffers(1, @UBO);
  // UBO mit Daten laden
  glBindBuffer(GL_UNIFORM_BUFFER, UBO);
  glBufferData(GL_UNIFORM_BUFFER, SizeOf(TUBOBuffer), nil, GL_DYNAMIC_DRAW);

  // UBO mit dem Shader verbinden
  UBO_ID := Shader.UniformBlockIndex('UBO');
  glUniformBlockBinding(Shader.ID, UBO_ID, 0);
  glBindBufferBase(GL_UNIFORM_BUFFER, 0, UBO);

  UBOBuffer.ModelMatrix.Identity;
  CreatJoints;

  glClearColor(0.6, 0.6, 0.4, 1.0); // Hintergrundfarbe

  tmpQuad := nil;
  tmpQuad.addrectangle;
  tmpQuad.Scale([1, 3]);
  tmpQuad.Translate([-0.5, -1.5]);
  tmpQuad.Scale(0.1);

  QuadVertex.Add(tmpQuad);

  // Daten für Quadrat
  glGenVertexArrays(1, @VAO);
  glBindVertexArray(VAO);

  // Vektor
  glGenBuffers(1, @VBOVektor);

  glBindBuffer(GL_ARRAY_BUFFER, VBOVektor);
  glBufferData(GL_ARRAY_BUFFER, QuadVertex.Size, QuadVertex.Ptr, GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 2, GL_FLOAT, False, 0, nil);
end;

procedure TForm1.ogcDrawScene(Sender: TObject);
var
  i: integer;
begin
  glClear(GL_COLOR_BUFFER_BIT);
  Shader.UseProgram;

  UBOBuffer.ModelMatrix.Identity;
  UBOBuffer.ModelMatrix.Scale(1.8);
  UBOBuffer.ModelMatrix.Translate(0.2, 0.6, 0.0);

  for i := 0 to 150 do begin
    glBufferSubData(GL_UNIFORM_BUFFER, 0, sizeof(TUBOBuffer), @UBOBuffer);

    // Zeichne Quadrat
    glBindVertexArray(VAO);
    glDrawArrays(GL_TRIANGLES, 0, QuadVertex.Count);

    UBOBuffer.ModelMatrix.TranslateLocalspaceX(-0.1);
    UBOBuffer.ModelMatrix.RotateC(pi / 8);
    UBOBuffer.ModelMatrix.TranslateLocalspaceX(-0.1);

    UBOBuffer.ModelMatrix.Scale(0.95);
  end;

  ogc.SwapBuffers;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Shader.Free;

  glDeleteVertexArrays(1, @VAO);
  glDeleteBuffers(1, @VBOVektor);
end;

//includeglsl Vertexshader.glsl
//lineal

(*
<b>Fragment-Shader:</b>
*)
//includeglsl Fragmentshader.glsl

end.
