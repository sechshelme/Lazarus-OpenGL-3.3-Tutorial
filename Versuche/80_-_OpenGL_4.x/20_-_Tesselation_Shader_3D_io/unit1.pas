unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, Menus,
  dglOpenGL,
  oglContext, oglShader, oglVector, oglMatrix, oglTextur;

  //image image.png

(*
Hier wird ganz kurz der Geometrie-Shader erwähnt.
In diesem Beispiel wird nicht ins Detail eingegangen, es sollte nur zeigen für was ein Geometrie-Shader gut ist.
Die Funktion hier im Beispiel ist, die beiden Meshes werden kopiert und anschliessend nach Links und Rechts verschoben.
Auch bekommt die Linke Version eine andere Farbe als die Rechte.

Man kann einen Geometrie-Shader auch brauchen um automatisch die Normale auszurechnen, welche für Beleuchtungs-Effekte gebraucht wird.
Was eine Normale ist, wird später im Kapitel Beleuchtung erklärt.

Der Lazarus-Code ist nichts besonderes, er rendert die üblichen zwei Meshes Dreieck und Quadrat.
Die einzige Besondeheit ist, es wird zu den üblichen zwei Shader noch ein Geometrie-Shader geladen wird.
*)

  //lineal

type

  { TForm1 }

  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    ogc: TContext;
    Shader: TShader; // Shader-Object
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
  Tvertice = record
    x, y, z, u, v: GLfloat;
  end;
  Tvertices = array of Tvertice;

var
  vertices: Tvertices = nil;

const
  Triangle: array of TVector5f =
    ((0.4, 0.1, 0.0, 1.0, 0.0), (-0.4, 0.1, 0.0, 0.0, 0.0), (0.0, 0.7, 0.0, 0.5, 1.0));
  Quad: array[0..5] of TVector5f =
    ((-0.2, -0.6, 0.0, 0.0, 0.0), (-0.2, -0.1, 0.0, 0.0, 1.0), (0.2, -0.1, 0.0, 1.0, 1.0),
    (-0.2, -0.6, 0.0, 0.0, 0.0), (0.2, -0.1, 0.0, 1.0, 1.0), (0.2, -0.6, 0.0, 1.0, 0.0));
  //const
  //  Triangle: array of TVector5f =
  //    ((0.4, 0.0, 0.1, 1.0, 0.0),(-0.4, 0.0, 0.1,  0.0, 0.0),  (0.0, 0.0, 0.7, 0.5, 1.0));
  //  Quad: array[0..5] of TVector5f =
  //    ((-0.2, 0.0, -0.6,  0.0, 0.0), (-0.2, 0.0, -0.1, 0.0, 1.0), (0.2, 0.0, -0.1, 1.0, 1.0),
  //    (-0.2, 0.0, -0.6,  0.0, 0.0), (0.2, 0.0, -0.1, 1.0, 1.0), (0.2, 0.0, -0.6,  1.0, 0.0));

type
  TVB = record
    VAO,
    VBO: GLuint;
  end;

var
  VBTriangle, VBQuad, VBVert: TVB;
  WorldMatrix: TMatrix;
  WorldMatrix_ID: GLint;

  Mat: record
    model,
    view,
    projection: Tmat4x4;
    model_ID, view_ID, projection_ID: glint;
      end;

type
  TTextures = array of TTexturBuffer;

var
  TexturIndex: integer = 0;
  Textures: TTextures = nil;

function CreateTextures: TTextures;
const
  len = 10;
  texSize = 1024;
var
  i, j: integer;
  texData: array of TGLenum = nil;
  b: byte;
begin
  SetLength(Result, len);
  SetLength(texData, texSize * texSize);
  for i := 0 to len - 1 do begin
    Result[i] := TTexturBuffer.Create;
    for j := 0 to Length(texData) - 1 do begin
      b := 255 div len * i;
      texData[j] := Random($FFFFFF) + $FF000000;

      //if j mod 2 = 1 then  begin
      //  texData[j] := b + b shl 8 + b shl 16 + $FF000000;
      //end else begin
      //  texData[j] := $FF000000;
      //end;
    end;
    Result[i].LoadTextures(texSize, texSize, texData);
  end;
end;

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  //remove+
  Width := 340;
  Height := 240;
  //remove-
  ogc := TContext.Create(Self, True, 4, 0);
  ogc.OnPaint := @ogcDrawScene;

  CreateScene;
  InitScene;
end;

(*
Hier ist die einzige Besonderheit, dem Constructor von TShader wird ein dritter Shader-Code mitgegeben.

Wen man bei der Shader-Klasse einen dritten Shader mit gibt, wird automatisch erkannt, das noch ein Geometrie-Shader dazu kommt.
*)

// https://learnopengl.com/Guest-Articles/2021/Tessellation/Tessellation

//code+
procedure TForm1.CreateScene;
begin

  WorldMatrix.Identity;
  Mat.model.Identity;
  Mat.view.Identity;
  Mat.projection.Identity;

  Shader := TShader.Create([
    FileToStr('Vertexshader.glsl'),
    FileToStr('tesselationcontrolshader.glsl'),
    FileToStr('tesselationevalationshader.glsl'),
    FileToStr('Fragmentshader.glsl')], True);

  with Shader do begin
    UseProgram;
    WorldMatrix_ID := UniformLocation('Matrix');

    Mat.model_ID := UniformLocation('model');
    Mat.view_ID := UniformLocation('view');
    Mat.projection_ID := UniformLocation('projection');

    glUniform1i(UniformLocation('heightMap'), 0);  // Dem Sampler[0] 0 zuweisen.
    //    glUniform1i(UniformLocation('Sampler[1]'), 1);  // Dem Sampler[1] 1 zuweisen.
  end;

  //code-

  glGenVertexArrays(1, @VBTriangle.VAO);
  glGenVertexArrays(1, @VBQuad.VAO);
  glGenVertexArrays(1, @VBVert.VAO);

  glGenBuffers(1, @VBTriangle.VBO);
  glGenBuffers(1, @VBQuad.VBO);
  glGenBuffers(1, @VBVert.VBO);

  Timer1.Enabled := True;
end;

procedure TForm1.InitScene;
const
  outer_levels: array of GLfloat = (4, 4, 4);
  inner_levels: array of GLfloat = (4);
begin
  Textures := CreateTextures;

  glClearColor(0.6, 0.6, 0.4, 1.0); // Hintergrundfarbe

  glPatchParameterfv(GL_PATCH_DEFAULT_OUTER_LEVEL, PGLfloat(outer_levels));
  glPatchParameterfv(GL_PATCH_DEFAULT_INNER_LEVEL, PGLfloat(inner_levels));

//  glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);
  glPatchParameteri(GL_PATCH_VERTICES, 3);


  // Daten für Dreieck
  glBindVertexArray(VBTriangle.VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBTriangle.VBO);
  glBufferData(GL_ARRAY_BUFFER, Length(Triangle) * sizeof(TVector5f), PVector5f(Triangle), GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 3, GL_FLOAT, False, 20, nil);
  glEnableVertexAttribArray(1);
  glVertexAttribPointer(1, 2, GL_FLOAT, False, 20, Pointer(12));

  // Daten für Quadrat
  glBindVertexArray(VBQuad.VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBO);
  glBufferData(GL_ARRAY_BUFFER, Length(Quad) * sizeof(TVector5f), PVector5f(Quad), GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 3, GL_FLOAT, False, 20, nil);
  glEnableVertexAttribArray(1);
  glVertexAttribPointer(1, 2, GL_FLOAT, False, 20, Pointer(12));

  // Daten für Vert
  glBindVertexArray(VBVert.VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBVert.VBO);
  glBufferData(GL_ARRAY_BUFFER, Length(vertices) * sizeof(TVector5f), PVector5f(vertices), GL_STATIC_DRAW);
  glEnableVertexAttribArray(1);
  glVertexAttribPointer(0, 3, GL_FLOAT, False, 20, nil);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(1, 2, GL_FLOAT, False, 20, Pointer(12));
end;

procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT);

  Textures[TexturIndex].ActiveAndBind(0);
  //  Textur.ActiveAndBind(0); // Textur 0 mit Sampler 0 binden.

  Shader.UseProgram;

  WorldMatrix.Uniform(WorldMatrix_ID);                     // Matrix dem Shader übergeben
  mat.model.Uniform(Mat.model_ID);
  mat.projection.Uniform(Mat.projection_ID);
  mat.view.Uniform(Mat.view_ID);

  // Zeichne Dreieck
  glBindVertexArray(VBTriangle.VAO);
  glDrawArrays(GL_PATCHES, 0, Length(Triangle));

  // Zeichne Quadrat
  glBindVertexArray(VBQuad.VAO);
  glDrawArrays(GL_PATCHES, 0, Length(Quad));

  // Zeichne Vert
  glBindVertexArray(VBVert.VAO);
  glDrawArrays(GL_PATCHES, 0, Length(vertices));

  ogc.SwapBuffers;
end;

procedure TForm1.FormDestroy(Sender: TObject);
var
  i: integer;
begin
  Shader.Free;

  glDeleteVertexArrays(1, @VBTriangle.VAO);
  glDeleteVertexArrays(1, @VBQuad.VAO);
  glDeleteVertexArrays(1, @VBVert.VAO);

  glDeleteBuffers(1, @VBTriangle.VBO);
  glDeleteBuffers(1, @VBQuad.VBO);
  glDeleteBuffers(1, @VBVert.VBO);

  for i := 0 to Length(Textures) - 1 do begin
    Textures[i].Free;
  end;
end;

procedure TForm1.MenuItem2Click(Sender: TObject);
begin
  Inc(TexturIndex);
  if TexturIndex >= Length(Textures) then begin
    TexturIndex := 0;
  end;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  mat.model.RotateB(0.0223);  // Drehe um Z-Achse
  mat.model.RotateA(0.0423);  // Drehe um Z-Achse
  // WorldMatrix.RotateB(0.0123);  // Drehe um Z-Achse
  // WorldMatrix.RotateA(0.0223);  // Drehe um Z-Achse
  ogcDrawScene(Sender);
end;

//lineal

(*
<b>Vertex-Shader:</b>
*)
//includeglsl Vertexshader.glsl
//lineal

(*
<b>Geometrie-Shader:</b>
*)
//includeglsl Geometrieshader.glsl
//lineal

(*
<b>Fragment-Shader</b>
*)
//includeglsl Fragmentshader.glsl

end.
