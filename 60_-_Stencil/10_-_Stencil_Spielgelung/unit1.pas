unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, Menus,
  oglglad_gl,
  oglContext, oglShader, oglVector, oglVectors, oglMatrix,
  oglTextur;

type

  { TForm1 }

  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    RevertCubeItem: TMenuItem;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure RevertCubeItemClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    ogc: TContext;
    Shader: TShader;
    procedure UpdateCube;
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

// https://learnopengl.com/code_viewer_gh.php?code=src/4.advanced_opengl/2.stencil_testing/stencil_testing.cpp
// https://learnopengl.com/Advanced-OpenGL/Stencil-testing

// https://open.gl/depthstencils
// https://open.gl/content/code/c5_reflection.txt

// https://learnopengl.com/Advanced-OpenGL/Stencil-testing
// https://en.wikibooks.org/wiki/OpenGL_Programming/Stencil_buffer
// https://gist.github.com/sealfin/d22f4ba4d1022e1b89dd
// https://lazyfoo.net/tutorials/OpenGL/26_the_stencil_buffer/index.php

type
  TVB = record
    VAO,
    VBOvert, VBOnorm, VBOtex: GLuint;
  end;

  TUBOBuffer = record
    Color: TVector4f;
    ProjMatrix, ViewMatrix, ModelMatrix: Tmat4x4;
  end;

var
  ReflectVerts: TVectors3f = nil;
  ReflectTexCoords: TVectors2f = nil;

  CubeVerts: TVectors3f = nil;
  CubeNormals: TVectors3f = nil;
  CubeTexCoords: TVectors2f = nil;

var
  Textur: TTexturBuffer;

  VBReflect, VBCube: TVB;
  UBOBuffer: TUBOBuffer;

  UBO,
  UBO_ID: GLint;

const
  si = 7;


procedure TForm1.UpdateCube;
const
  scale = 1 / si;
var
  CubeArr: array of array of array of boolean;
  cp: TVector3i;
  i, x, y, z: integer;
  tmpCube: TVectors3f;

  function BottomTest(p: TVector3i): boolean;
  begin
    Result := True;
    if CubeArr[p[0], p[1], p[2]] = True then begin
      Exit(False);
    end;
    if p[0] > 0 then begin
      if CubeArr[p[0] - 1, p[1], p[2]] <> True then begin
        Exit(False);
      end;
    end;
    CubeArr[p[0], p[1], p[2]] := True;
  end;

begin
  SetLength(CubeVerts, 0);
  SetLength(CubeNormals, 0);
  SetLength(CubeTexCoords, 0);

  SetLength(CubeArr, si, si, si);
  for z := 0 to Length(CubeArr) - 1 do begin
    for i := 0 to si * 3 - z * 2 do begin
      repeat
        cp[0] := z;
        cp[1] := Random(si);
        cp[2] := Random(si);
      until BottomTest(cp);
    end;
  end;

  for z := 0 to Length(CubeArr) - 1 do begin
    for y := 0 to Length(CubeArr[z]) - 1 do begin
      for x := 0 to Length(CubeArr[z, y]) - 1 do begin
        if CubeArr[z, y, x] then begin
          tmpCube := nil;
          tmpCube.AddCube;
          tmpCube.Translate([x - si div 2, y - si div 2, z - si / 2 + 0.5]);
          CubeVerts.Add(tmpCube);

          CubeNormals.AddCubeNormale;
          CubeTexCoords.AddCubeTexCoords;
        end;
      end;
    end;
  end;

  WriteLn(Length(CubeVerts));
  WriteLn(Length(CubeNormals));

  CubeVerts.Scale([scale * 1.5, scale * 1.5, scale]);
  //  CubeVerts.Scale(scale * 1.5);

  glBindVertexArray(VBCube.VAO);

  glBindBuffer(GL_ARRAY_BUFFER, VBCube.VBOvert);
  glBufferSubData(GL_ARRAY_BUFFER, 0, CubeVerts.Size, CubeVerts.Ptr);

  glBindBuffer(GL_ARRAY_BUFFER, VBCube.VBOnorm);
  glBufferSubData(GL_ARRAY_BUFFER, 0, CubeNormals.Size, CubeVerts.Ptr);

  glBindBuffer(GL_ARRAY_BUFFER, VBCube.VBOtex);
  glBufferSubData(GL_ARRAY_BUFFER, 0, CubeTexCoords.Size, CubeTexCoords.Ptr);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Randomize;
  //remove+
  //  Width := 340;
  //  Height := 240;
  Width := 640;
  Height := 480;
  //remove-
  ogc := TContext.Create(Self);
  ogc.OnPaint := @ogcDrawScene;

  CreateScene;
  Timer1.Enabled := True;
end;

procedure TForm1.CreateScene;
begin
  glEnable(GL_DEPTH_TEST);

  //   glEnable(GL_CULL_FACE);   // Überprüfung einschalten
  //  glCullFace(GL_BACK);      // Rückseite nicht zeichnen.

  // --- Shader laden
  Shader := TShader.Create;
  Shader.LoadShaderObjectFromFile(GL_VERTEX_SHADER, 'Vertexshader.glsl');
  Shader.LoadShaderObjectFromFile(GL_FRAGMENT_SHADER, 'Fragmentshader.glsl');
  Shader.LinkProgram;
  Shader.UseProgram;
  with Shader do begin
    UBO_ID := UniformBlockIndex('UBO');

    glUniform1i(UniformLocation('Sampler'), 0);
  end;

  // --- UBO
  UBOBuffer.ModelMatrix.Identity;
  UBOBuffer.ViewMatrix.Identity;
  UBOBuffer.ViewMatrix.Translate(0, 0.3, -4);
  UBOBuffer.ViewMatrix.RotateA(2.0 + pi);
  UBOBuffer.ProjMatrix.Identity;
  UBOBuffer.ProjMatrix.Perspective(45, ClientWidth / ClientHeight, 0.1, 100.0);

  glGenBuffers(1, @UBO);                          // UB0-Puffer generieren.
  // UBO mit Daten laden
  glBindBuffer(GL_UNIFORM_BUFFER, UBO);
  glBufferData(GL_UNIFORM_BUFFER, SizeOf(TUBOBuffer), nil, GL_DYNAMIC_DRAW);

  // UBO mit dem Shader verbinden
  glUniformBlockBinding(Shader.ID, UBO_ID, 0);
  glBindBufferBase(GL_UNIFORM_BUFFER, 0, UBO);

  // --- Reflect
  ReflectVerts.AddRectangle;
  ReflectVerts.Scale([2, 2, 1]);
  ReflectVerts.Translate([0, 0, -0.5]);
  ReflectTexCoords.AddQuadTexCoords;

  glGenVertexArrays(1, @VBReflect.VAO);
  glBindVertexArray(VBReflect.VAO);

  // Vertex
  glGenBuffers(1, @VBReflect.VBOvert);
  glBindBuffer(GL_ARRAY_BUFFER, VBReflect.VBOvert);
  glBufferData(GL_ARRAY_BUFFER, ReflectVerts.Size, ReflectVerts.Ptr, GL_STATIC_DRAW);

  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, SizeOf(TVector3f), nil);

  // Normale
  //glGenBuffers(1, @VBReflect.VBOnorm);
  //glBindBuffer(GL_ARRAY_BUFFER, VBReflect.VBOnorm);
  //glBufferData(GL_ARRAY_BUFFER, ReflectVerts.Size, ReflectVerts.Ptr, GL_STATIC_DRAW);
  //
  //glEnableVertexAttribArray(1);
  //glVertexAttribPointer(1, 3, GL_FLOAT, GL_FALSE, SizeOf(TVector3f), nil);

  // TexturCoord
  glGenBuffers(1, @VBReflect.VBOtex);
  glBindBuffer(GL_ARRAY_BUFFER, VBReflect.VBOtex);
  glBufferData(GL_ARRAY_BUFFER, ReflectTexCoords.Size, ReflectTexCoords.Ptr, GL_STATIC_DRAW);

  glEnableVertexAttribArray(2);
  glVertexAttribPointer(2, 2, GL_FLOAT, GL_FALSE, SizeOf(TVector2f), nil);

  // --- Cube
  glGenVertexArrays(1, @VBCube.VAO);
  glBindVertexArray(VBCube.VAO);

  // Vertex
  glGenBuffers(1, @VBCube.VBOvert);
  glBindBuffer(GL_ARRAY_BUFFER, VBCube.VBOvert);
  glBufferData(GL_ARRAY_BUFFER, si * si * si * SizeOf(TVector3f) * 12, nil, GL_DYNAMIC_DRAW);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, SizeOf(TVector3f), nil);

  // Normale
  glGenBuffers(1, @VBCube.VBOnorm);
  glBindBuffer(GL_ARRAY_BUFFER, VBCube.VBOnorm);
  glBufferData(GL_ARRAY_BUFFER, si * si * si * SizeOf(TVector3f) * 12, nil, GL_DYNAMIC_DRAW);
  glEnableVertexAttribArray(1);
  glVertexAttribPointer(1, 3, GL_FLOAT, GL_FALSE, SizeOf(TVector3f), nil);

  // TexturCoord
  glGenBuffers(1, @VBCube.VBOtex);
  glBindBuffer(GL_ARRAY_BUFFER, VBCube.VBOtex);
  glBufferData(GL_ARRAY_BUFFER, si * si * si * SizeOf(TVector2f) * 12, nil, GL_DYNAMIC_DRAW);
  glEnableVertexAttribArray(2);
  glVertexAttribPointer(2, 2, GL_FLOAT, GL_FALSE, SizeOf(TVector2f), nil);

  UpdateCube;

  // Texturen
  Textur := TTexturBuffer.Create;
  Textur.LoadTextures('woodenbox.png');
  Textur.ActiveAndBind;
end;

procedure TForm1.ogcDrawScene(Sender: TObject);
var
  mat: TMatrix;
begin
  Shader.UseProgram;
  glBindBuffer(GL_UNIFORM_BUFFER, UBO);

  glClearColor(0.3, 0.1, 0.2, 1.0);
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);

  // Draw cube
  glBindVertexArray(VBCube.VAO);

  UBOBuffer.Color := [0.8, 0.8, 0.8, 1.0];
  glBufferSubData(GL_UNIFORM_BUFFER, 0, sizeof(TUBOBuffer), @UBOBuffer);
  glDrawArrays(GL_TRIANGLES, 0, CubeVerts.Count);

  // Draw Reflect
  glBindVertexArray(VBReflect.VAO);
  glEnable(GL_STENCIL_TEST);
  glStencilFunc(GL_ALWAYS, 1, $FF);
  glStencilOp(GL_KEEP, GL_KEEP, GL_REPLACE);
  glStencilMask($FF);
  glDepthMask(GL_FALSE);
  glClear(GL_STENCIL_BUFFER_BIT);

  UBOBuffer.Color := [0, 0, 0, 1];
  glBufferSubData(GL_UNIFORM_BUFFER, 0, sizeof(TUBOBuffer), @UBOBuffer);
  glDrawArrays(GL_TRIANGLES, 0, 6);

  // Draw cube reflect
  glBindVertexArray(VBCube.VAO);
  glStencilFunc(GL_EQUAL, 1, $FF);
  glStencilMask($00);
  glDepthMask(GL_TRUE);

  mat := UBOBuffer.ModelMatrix;
  UBOBuffer.ModelMatrix.TranslateZ(-1.0);
  UBOBuffer.ModelMatrix.Scale(1, 1, -1);

  UBOBuffer.Color := [0.3, 0.3, 0.3, 1.0];
  glBufferSubData(GL_UNIFORM_BUFFER, 0, sizeof(TUBOBuffer), @UBOBuffer);
  glDrawArrays(GL_TRIANGLES, 0, CubeVerts.Count);
  UBOBuffer.ModelMatrix := mat;

  glDisable(GL_STENCIL_TEST);
  ogc.SwapBuffers;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Textur.Free;
  Shader.Free;

  Timer1.Enabled := False;

  glDeleteBuffers(1, @UBO);

  glDeleteVertexArrays(1, @VBReflect.VAO);
  glDeleteBuffers(1, @VBReflect.VBOvert);
  glDeleteBuffers(1, @VBReflect.VBOnorm);
  glDeleteBuffers(1, @VBReflect.VBOtex);

  glDeleteVertexArrays(1, @VBCube.VAO);
  glDeleteBuffers(1, @VBCube.VBOvert);
  glDeleteBuffers(1, @VBCube.VBOnorm);
  glDeleteBuffers(1, @VBCube.VBOtex);
end;

procedure TForm1.RevertCubeItemClick(Sender: TObject);
begin
  UpdateCube;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
const
  step: GLfloat = 0.02;
begin
  UBOBuffer.ModelMatrix.RotateC(step);
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
