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
    proMatrix,
    modelMatrix: TMatrix;
  end;

var
  UBOBuffer: TUBOBuffer;
  QuadVertex: TVectors2f = nil;
  QuadColor: TVectors3f = nil;

var
  VAO, VBOVektor, VBOColor, UBO: GLint;

const
  JointCount = 3;


procedure TForm1.FormCreate(Sender: TObject);
begin
  //remove+
  Width := 640;
//  Height := 480;
  Height := 640;
  //remove-
  Randomize;
  ogc := TContext.Create(Self);
  ogc.OnPaint := @ogcDrawScene;

  CreateScene;
end;

// https://www.youtube.com/watch?app=desktop&v=lDaQ3a43x8A

procedure TForm1.CreateScene;
const
  colors: array of PVector3f = (@vec3blue, @vec3green, @vec3cyan, @vec3red, @vec3magenta, @vec3yellow);
var
  tmpQuad: TVectors2f = nil;
  UBO_ID: GLuint;
  i: integer;
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

  UBOBuffer.proMatrix.Identity;
  UBOBuffer.proMatrix.Scale(0.02);
//  UBOBuffer.proMatrix.Translate(0.9, 0.0, 0.0);

  UBOBuffer.modelMatrix.Identity;

  glClearColor(0.6, 0.6, 0.4, 1.0); // Hintergrundfarbe
  glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);

  for i := 0 to JointCount - 1 do begin
    tmpQuad := nil;
    tmpQuad.addrectangle;
    tmpQuad.Scale([8, 4]);
    tmpQuad.Translate([-8.0 * i, 0.0]);
    QuadVertex.Add(tmpQuad);

    QuadColor.AddRectangleColor(colors[i mod JointCount]^);
  end;

  // Daten für Quadrat
  glGenVertexArrays(1, @VAO);
  glBindVertexArray(VAO);

  // Vektor
  glGenBuffers(1, @VBOVektor);
  glBindBuffer(GL_ARRAY_BUFFER, VBOVektor);
  glBufferData(GL_ARRAY_BUFFER, QuadVertex.Size, QuadVertex.Ptr, GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 2, GL_FLOAT, False, 0, nil);

  // Color
  glGenBuffers(1, @VBOColor);
  glBindBuffer(GL_ARRAY_BUFFER, VBOColor);
  glBufferData(GL_ARRAY_BUFFER, QuadColor.Size, QuadColor.Ptr, GL_STATIC_DRAW);
  glEnableVertexAttribArray(1);
  glVertexAttribPointer(1, 3, GL_FLOAT, False, 0, nil);
end;

procedure TForm1.ogcDrawScene(Sender: TObject);
var
  i: integer;
  mHand: TMatrix;
begin
  glClear(GL_COLOR_BUFFER_BIT);
  Shader.UseProgram;
  glBindVertexArray(VAO);

  mHand.Identity;
  UBOBuffer.modelMatrix := mHand;
  glBufferSubData(GL_UNIFORM_BUFFER, 0, sizeof(TUBOBuffer), @UBOBuffer);
  glDrawArrays(GL_TRIANGLES, 0, QuadVertex.Count);

  mHand.Identity;
//  mHand.TranslateLocalspaceX(-4 * 2 * 8);
  mHand.TranslateLocalspaceX(- 16);
  mHand.RotateC(pi / 2);
  mHand.TranslateLocalspaceX( 16);
//  mHand.TranslateLocalspaceX(4 * 2 * 8);

  UBOBuffer.modelMatrix := mHand;

  glBufferSubData(GL_UNIFORM_BUFFER, 0, sizeof(TUBOBuffer), @UBOBuffer);
  glDrawArrays(GL_TRIANGLES, 0, QuadVertex.Count);
//  glDrawArrays(GL_TRIANGLES, 2 * 6, 6);



  //
  //
  //  UBOBuffer.modelMatrix.Identity;
  //  for i := 0 to JointCount - 1 do begin
  //    UBOBuffer.col := [i / JointCount, 0.5, 1 - i / JointCount];
  //    glBufferSubData(GL_UNIFORM_BUFFER, 0, sizeof(TUBOBuffer), @UBOBuffer);
  //
  //    // Zeichne Quadrat
  //    glDrawArrays(GL_TRIANGLES, i * 6, 6);
  //
  //    UBOBuffer.modelMatrix.TranslateLocalspaceX(-4 * (i+1));
  //    UBOBuffer.modelMatrix.RotateC(pi / 2);
  //    UBOBuffer.modelMatrix.TranslateLocalspaceX(4 * (i+1));
  //
  //    //    UBOBuffer.modelMatrix.Scale(0.95);
  //  end;

  ogc.SwapBuffers;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Shader.Free;

  glDeleteVertexArrays(1, @VAO);
  glDeleteBuffers(1, @VBOVektor);
  glDeleteBuffers(1, @VBOColor);
  glDeleteBuffers(1, @UBO);
end;

//includeglsl Vertexshader.glsl
//lineal

(*
<b>Fragment-Shader:</b>
*)
//includeglsl Fragmentshader.glsl

end.
