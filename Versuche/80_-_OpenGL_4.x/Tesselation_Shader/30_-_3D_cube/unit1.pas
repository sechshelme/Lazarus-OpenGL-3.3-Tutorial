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

const
  CubeVertex: array of Tmat4x3 =
    (((-0.5, 0.5, 0.5), (-0.5, -0.5, 0.5), (0.5, 0.5, 0.5),  (0.5, -0.5, 0.5)),
    ((0.5, 0.5, 0.5), (0.5, -0.5, 0.5), (0.5, 0.5, -0.5),  (0.5, -0.5, -0.5)),
    ((0.5, 0.5, -0.5), (0.5, -0.5, -0.5), (-0.5, 0.5, -0.5), (-0.5, -0.5, -0.5)),
    ((-0.5, 0.5, -0.5), (-0.5, -0.5, -0.5), (-0.5, 0.5, 0.5), (-0.5, -0.5, 0.5)),
    // oben
    ((0.5, 0.5, 0.5), (0.5, 0.5, -0.5), (-0.5, 0.5, 0.5), (-0.5, 0.5, -0.5)),
    // unten
    ((-0.5, -0.5, 0.5), (-0.5, -0.5, -0.5), (0.5, -0.5, 0.5), (0.5, -0.5, -0.5)));

  // --- Texturkoordinaten
  CubeTextureVertex: array of Tmat4x2 =
    (((0.0, 1.0), (0.0, 0.0), (1.0, 1.0), (1.0, 0.0)),
    ((0.0, 1.0), (0.0, 0.0), (1.0, 1.0),  (1.0, 0.0)),
    ((0.0, 1.0), (0.0, 0.0), (1.0, 1.0),  (1.0, 0.0)),
    ((0.0, 1.0), (0.0, 0.0), (1.0, 1.0),  (1.0, 0.0)),
    ((0.0, 1.0), (0.0, 0.0), (1.0, 1.0),  (1.0, 0.0)),
    ((0.0, 1.0), (0.0, 0.0), (1.0, 1.0),  (1.0, 0.0)));

type
  TVB = record
    VAO,
    VBOVertex,            // Vertex-Koordinaten
    VBOTex_Col: GLuint;   // Textur/Color-Koordinaten
  end;

var
  VBCube: TVB;
  WorldMatrix: TMatrix;
  WorldMatrix_ID: GLint;

type
  TTextures = array of TTexturBuffer;

var
  TexturIndex: integer = 0;
  Textures: TTextures = nil;

function CreateTextures: TTextures;
const
  len = 100;
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
    //    Result[i].LoadTextures('mauer.xpm');
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
  glEnable(GL_DEPTH_TEST);  // Tiefenprüfung einschalten.
  glDepthFunc(GL_LESS);     // Kann man weglassen, da Default.

  WorldMatrix.Identity;

  Shader := TShader.Create([
    FileToStr('Vertexshader.glsl'),
    FileToStr('tesselationevalationshader.glsl'),
    FileToStr('Fragmentshader.glsl')], True);

  with Shader do begin
    UseProgram;
    WorldMatrix_ID := UniformLocation('Matrix');

    glUniform1i(UniformLocation('heightMap'), 0);  // Dem Sampler[0] 0 zuweisen.
  end;

  //code-

  glGenVertexArrays(1, @VBCube.VAO);
  glGenBuffers(1, @VBCube.VBOVertex);
  glGenBuffers(1, @VBCube.VBOTex_Col);

  Timer1.Enabled := True;
end;

procedure TForm1.InitScene;
const
  cnt = 1024;
  outer_levels: array of GLfloat = (cnt, cnt, cnt, cnt);
  inner_levels: array of GLfloat = (cnt, cnt);
begin
  Textures := CreateTextures;

  glClearColor(0.6, 0.6, 0.4, 1.0); // Hintergrundfarbe

  glPatchParameterfv(GL_PATCH_DEFAULT_OUTER_LEVEL, PGLfloat(outer_levels));
  glPatchParameterfv(GL_PATCH_DEFAULT_INNER_LEVEL, PGLfloat(inner_levels));

//  glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);
  glPolygonMode(GL_FRONT, GL_POINT);
  glPolygonMode(GL_BACK, GL_LINE);
  glPatchParameteri(GL_PATCH_VERTICES, 4);

  glBindVertexArray(VBCube.VAO);

  // Vertexkoordinaten
  glBindBuffer(GL_ARRAY_BUFFER, VBCube.VBOVertex);
  glBufferData(GL_ARRAY_BUFFER, sizeof(Tmat4x3) * Length(CubeVertex), Pmat4x3(CubeVertex), GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 3, GL_FLOAT, False, 0, nil);

  // Texturkoordinaten
  glBindBuffer(GL_ARRAY_BUFFER, VBCube.VBOTex_Col);
  glBufferData(GL_ARRAY_BUFFER, sizeof(Tmat4x2) * Length(CubeTextureVertex), Pmat4x2(CubeTextureVertex), GL_STATIC_DRAW);
  glEnableVertexAttribArray(1);
  glVertexAttribPointer(1, 2, GL_FLOAT, False, 0, nil);
end;

procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);  // Frame und Tiefen-Puffer löschen.

  Shader.UseProgram;
  Textures[TexturIndex].ActiveAndBind(0);

  WorldMatrix.Uniform(WorldMatrix_ID);                     // Matrix dem Shader übergeben

  // Zeichne Quad0;
  glBindVertexArray(VBCube.VAO);
  glDrawArrays(GL_PATCHES, 0, Length(CubeTextureVertex) * 4);

  ogc.SwapBuffers;
end;

procedure TForm1.FormDestroy(Sender: TObject);
var
  i: integer;
begin
  Shader.Free;

  glDeleteVertexArrays(1, @VBCube.VAO);
  glDeleteBuffers(1, @VBCube.VBOVertex);
  glDeleteBuffers(1, @VBCube.VBOTex_Col);

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
  WorldMatrix.RotateB(0.0223);  // Drehe um Z-Achse
  WorldMatrix.RotateA(0.0423);  // Drehe um Z-Achse
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
