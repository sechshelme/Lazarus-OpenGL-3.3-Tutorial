unit Zylinder;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, Menus,
  dglOpenGL,
  oglContext, oglShader, oglVector, oglMatrix;

type

  { TZylinder }

  TZylinder = class(TObject)
  private
  const
    Sector = 36;

    type
    TVB = record
      VAO: GLuint;
      VBO: record
        Vertex,
        Normal,
        Tex: GLuint;
      end;
    end;

  var
    VBZylinder: TVB;
    Matrix_ID, ModelMatrix_ID: GLuint;

    FrustumMatrix, WorldMatrix: TMatrix;

    Vertex: array of TFace3D;
    Normal: array of TFace3D;
    TextureVertex: array of TFace2D;

    Shader: TShader;

    textureID: GLuint;
  public
    constructor Create;
    procedure InitScene;
    procedure DrawScene(FrameTextur_ID: GLuint);
    destructor Destroy; override;
  end;

implementation

{ TZylinder }

constructor TZylinder.Create;
const
  w = 1.0;
begin
  Shader := TShader.Create([FileToStr('Zylinder.vert'), FileToStr('Zylinder.frag')]);
  with Shader do begin
    UseProgram;
    ModelMatrix_ID := UniformLocation('ModelMatrix');
    Matrix_ID := UniformLocation('Matrix');
    glUniform1i(UniformLocation('Sampler'), 0);
  end;

  glGenTextures(1, @textureID);

  glGenVertexArrays(1, @VBZylinder.VAO);
  glGenBuffers(3, @VBZylinder.VBO);

  FrustumMatrix.Frustum(-w, w, -w, w, 2.5, 1000.0);

  WorldMatrix.Identity;
  WorldMatrix.Translate(0.0, 0.0, -200.0);
  WorldMatrix.Scale(50.0);
end;

procedure TZylinder.InitScene;
var
  k: array of TVector2f;
  i: integer;
  t: GLfloat;

begin
  SetLength(Vertex, Sector * 2);
  SetLength(Normal, Sector * 2);
  SetLength(TextureVertex, Sector * 2);

  SetLength(k, Sector + 1);
  t := 2 * pi / Sector;
  for i := 0 to Sector do begin
    k[i].x := sin(t * i);
    k[i].y := cos(t * i);
  end;

  for i := 0 to Sector - 1 do begin
    Vertex[i * 2, 0] := vec3(k[i + 1], 1.0);
    Vertex[i * 2, 1] := vec3(k[i + 1], -1.0);
    Vertex[i * 2, 2] := vec3(k[i + 0], -1.0);
    Vertex[i * 2 + 1, 0] := vec3(k[i + 1], 1.0);
    Vertex[i * 2 + 1, 1] := vec3(k[i + 0], -1.0);
    Vertex[i * 2 + 1, 2] := vec3(k[i + 0], 1.0);

    Normal[i * 2, 0] := vec3(k[i + 1], 0.0);
    Normal[i * 2, 1] := vec3(k[i + 1], 0.0);
    Normal[i * 2, 2] := vec3(k[i + 0], 0.0);
    Normal[i * 2 + 1, 0] := vec3(k[i + 1], 0.0);
    Normal[i * 2 + 1, 1] := vec3(k[i + 0], 0.0);
    Normal[i * 2 + 1, 2] := vec3(k[i + 0], 0.0);

    TextureVertex[i * 2, 0] := vec2((i + 1) / Sector, 1.0);
    TextureVertex[i * 2, 1] := vec2((i + 1) / Sector, 0.0);
    TextureVertex[i * 2, 2] := vec2((i + 0) / Sector, 0.0);
    TextureVertex[i * 2 + 1, 0] := vec2((i + 1) / Sector, 1.0);
    TextureVertex[i * 2 + 1, 1] := vec2((i + 0) / Sector, 0.0);
    TextureVertex[i * 2 + 1, 2] := vec2((i + 0) / Sector, 1.0);
  end;

  glBindVertexArray(VBZylinder.VAO);

  // --- Koordinatem

  // Vertex
  glBindBuffer(GL_ARRAY_BUFFER, VBZylinder.VBO.Vertex);
  glBufferData(GL_ARRAY_BUFFER, Length(Vertex) * sizeof(TFace3D), Pointer(Vertex), GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 3, GL_FLOAT, False, 0, nil);

  // Normal
  glBindBuffer(GL_ARRAY_BUFFER, VBZylinder.VBO.Normal);
  glBufferData(GL_ARRAY_BUFFER, Length(Normal) * sizeof(TFace3D), Pointer(Normal), GL_STATIC_DRAW);
  glEnableVertexAttribArray(1);
  glVertexAttribPointer(1, 3, GL_FLOAT, False, 0, nil);

  // TexturVertex
  glBindBuffer(GL_ARRAY_BUFFER, VBZylinder.VBO.Tex);
  glBufferData(GL_ARRAY_BUFFER, Length(TextureVertex) * sizeof(TFace3D), Pointer(TextureVertex), GL_STATIC_DRAW);
  glEnableVertexAttribArray(2);
  glVertexAttribPointer(2, 2, GL_FLOAT, False, 0, nil);

end;

procedure TZylinder.DrawScene(FrameTextur_ID: GLuint);
var
  Matrix: TMatrix;
begin

  glClearColor(0.3, 0.3, 1.0, 1.0);
  glEnable(GL_CULL_FACE);
  glEnable(GL_BLEND);                                  // Alphablending an
  glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);   // Sortierung der Primitiven von hinten nach vorne.
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);

  Shader.UseProgram;
  glBindTexture(GL_TEXTURE_2D, FrameTextur_ID);  // Textur binden.

  glBindVertexArray(VBZylinder.VAO);

  Matrix.Identity;
  Matrix.Uniform(ModelMatrix_ID);
  Matrix.RotateA(-Pi / 2);

  Matrix := FrustumMatrix * WorldMatrix * Matrix;        // Matrizen multiplizieren.

  Matrix.Uniform(Matrix_ID);                             // Matrix dem Shader übergeben.

  glDrawArrays(GL_TRIANGLES, 0, Length(Vertex) * 3);
end;

destructor TZylinder.Destroy;
begin
  glDeleteTextures(1, @textureID);

  glDeleteVertexArrays(1, @VBZylinder.VAO);
  glDeleteBuffers(3, @VBZylinder.VBO);

  Shader.Free;

  inherited Destroy;
end;

end.
