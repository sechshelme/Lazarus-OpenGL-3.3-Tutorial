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
  Quad: array[0..1] of Tmat3x3 =
    (((-1.0, 1.0, 0.0), (-1.0, -1.0, 0.0), (1.0, -1.0, 0.0)), ((-1.0, 1.0, 0.0), (1.0, -1.0, 0.0), (1.0, 1.0, 0.0)));


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

const
  TexturSize = 2048;

type
  TVB = record
    VAO,
    VBOVertex,            // Vertex-Koordinaten
    VBOTex_Col: GLuint;   // Textur/Color-Koordinaten
  end;

  TQuad_VB = record
    VAO,
    VBOVertex: GLuint;   // Textur/Color-Koordinaten
  end;

var
  VBQuad: TQuad_VB;
  VBCube: TVB;

  WorldMatrix: TMatrix;
  WorldMatrix_ID: GLint;

  Quad_Shader: record
    WorldMatrix: TMatrix;
    col: GLfloat;

    Shader: TShader;
    Color_ID,
    WorldMatrix_ID: GLint;
      end;

var
  // ID der Textur.
  textureID: GLuint;

  // Renderpuffer
  FramebufferName, depthrenderbuffer: GLuint;



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
//   Result[i].LoadTextures('mauer.xpm');
//   Result[i].LoadTextures('project1.ico');
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

  // Shader des Quadrates
  with Quad_Shader do begin
    Shader := TShader.Create([FileToStr('quad.vert'), FileToStr('quad.frag')]);
    with Shader do begin
      UseProgram;

      Color_ID := UniformLocation('col');
      WorldMatrix_ID := UniformLocation('Matrix');
    end;
  end;

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

  // Vertex Puffer erzeugen.
  glGenVertexArrays(1, @VBQuad.VAO);
  glGenBuffers(1, @VBQuad.VBOVertex);

  glGenVertexArrays(1, @VBCube.VAO);
  glGenBuffers(1, @VBCube.VBOVertex);
  glGenBuffers(1, @VBCube.VBOTex_Col);

  Quad_Shader.WorldMatrix.Identity;
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


  Quad_Shader.WorldMatrix.Scale(1.5);

  // --- Quadrat
  with Quad_Shader do begin
    WorldMatrix.Scale(1.5);
    glBindVertexArray(VBQuad.VAO);

    // Vertexkoordinaten
    glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBOVertex);
    glBufferData(GL_ARRAY_BUFFER, sizeof(Quad), @Quad, GL_STATIC_DRAW);
    glEnableVertexAttribArray(0);
    glVertexAttribPointer(0, 3, GL_FLOAT, False, 0, nil);
  end;

  // ---- Cube

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


  // ------------ Texturen erzeugen --------------

  // --- Textur

  glGenTextures(1, @textureID);
  glBindTexture(GL_TEXTURE_2D, textureID);

  glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, TexturSize, TexturSize, 0, GL_RGBA, GL_UNSIGNED_BYTE, nil);

  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);

  // Frame Puffer erzeugen.
  glGenFramebuffers(1, @FramebufferName);
  glBindFramebuffer(GL_FRAMEBUFFER, FramebufferName);

  // Render Puffer erzeugen.
  glGenRenderbuffers(1, @depthrenderbuffer);
  glBindRenderbuffer(GL_RENDERBUFFER, depthrenderbuffer);

  glRenderbufferStorage(GL_RENDERBUFFER, GL_DEPTH_COMPONENT, TexturSize, TexturSize);
  glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_DEPTH_ATTACHMENT, GL_RENDERBUFFER, depthrenderbuffer);

  // Die Textur mit dem Framebuffer koppeln
  glFramebufferTexture(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, textureID, 0);
end;

procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  // --- In den Texturpuffer render.

  with Quad_Shader do begin // Quadrat

    // FramePuffer aktivieren.
    glBindFramebuffer(GL_FRAMEBUFFER, FramebufferName);

    glClearColor(0.3, 0.3, 1.0, 1.0);
    glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
    glViewport(0, 0, TexturSize, TexturSize);

    Shader.UseProgram;
    glBindVertexArray(VBQuad.VAO);

    WorldMatrix.Uniform(WorldMatrix_ID);
    glUniform1f(Color_ID, col);

    glDrawArrays(GL_TRIANGLES, 0, Length(Quad) * 3);
  end;

  //  --- Normal auf den Bildschirm rendern.


  glBindFramebuffer(GL_FRAMEBUFFER, 0);
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);  // Frame und Tiefen-Puffer löschen.
      glViewport(0, 0, ClientWidth, ClientHeight);

          glBindTexture(GL_TEXTURE_2D, textureID);


      Shader.UseProgram;
//  Textures[TexturIndex].ActiveAndBind(0);



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

  // Vertex Puffer frei geben.
  glDeleteVertexArrays(1, @VBQuad.VAO);
  glDeleteBuffers(1, @VBQuad.VBOVertex);

  glDeleteVertexArrays(1, @VBCube.VAO);
  glDeleteBuffers(1, @VBCube.VBOVertex);
  glDeleteBuffers(1, @VBCube.VBOTex_Col);

    // Shader frei geben.
  Quad_Shader.Shader.Free;
  Shader.Free;

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
  with Quad_Shader do begin
    col := col + 0.1;
    if col >= 10.0 then begin
      col := col - 10.0;
    end;

    WorldMatrix.RotateC(-Pi / 124);
  end;

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
