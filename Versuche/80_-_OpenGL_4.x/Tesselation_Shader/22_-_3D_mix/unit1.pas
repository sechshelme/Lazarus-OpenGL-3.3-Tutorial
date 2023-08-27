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
  Quad0: array of TVector5f =
    ((-0.3, 0.6, 0.0, 0.0, 1.1), (-0.2, 0.1, 0.0, 0.0, 0.0), (0.3, 0.6, 0.0, 1.1, 1.1), (0.2, 0.1, 0.0, 1.0, 1.0));
  Quad1: array of TVector5f =
    ((-0.2, -0.1, 0.0, 0.0, 1.1), (-0.2, -0.6, 0.0, 0.0, 0.0), (0.2, -0.1, 0.0, 1.1, 1.1), (0.2, -0.6, 0.0, 1.0, 1.0));

type
  TVB = record
    VAO,
    VBO: GLuint;
  end;

var
  VBQuad0, VBQuad1, VBVert: TVB;
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
  texSize = 16;
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
    //    glUniform1i(UniformLocation('Sampler[1]'), 1);  // Dem Sampler[1] 1 zuweisen.
  end;

  //code-

  glGenVertexArrays(1, @VBQuad0.VAO);
  glGenVertexArrays(1, @VBQuad1.VAO);
  glGenVertexArrays(1, @VBVert.VAO);

  glGenBuffers(1, @VBQuad0.VBO);
  glGenBuffers(1, @VBQuad1.VBO);
  glGenBuffers(1, @VBVert.VBO);

  Timer1.Enabled := True;
end;

procedure TForm1.InitScene;
const
  cnt = 2048;
  outer_levels: array of GLfloat = (cnt, cnt, cnt, cnt);
  inner_levels: array of GLfloat = (cnt, cnt);
begin
  Textures := CreateTextures;

  glClearColor(0.6, 0.6, 0.4, 1.0); // Hintergrundfarbe

  glPatchParameterfv(GL_PATCH_DEFAULT_OUTER_LEVEL, PGLfloat(outer_levels));
  glPatchParameterfv(GL_PATCH_DEFAULT_INNER_LEVEL, PGLfloat(inner_levels));

  glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);
  glPatchParameteri(GL_PATCH_VERTICES, 4);


  // Daten für Quad0;
  glBindVertexArray(VBQuad0.VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad0.VBO);
  glBufferData(GL_ARRAY_BUFFER, Length(Quad0) * sizeof(TVector5f), PVector5f(Quad0), GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 3, GL_FLOAT, False, 20, nil);
  glEnableVertexAttribArray(1);
  glVertexAttribPointer(1, 2, GL_FLOAT, False, 20, Pointer(12));

  glPatchParameterfv(GL_PATCH_DEFAULT_OUTER_LEVEL, PGLfloat(outer_levels));
  glPatchParameterfv(GL_PATCH_DEFAULT_INNER_LEVEL, PGLfloat(inner_levels));

  //  glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);
  glPatchParameteri(GL_PATCH_VERTICES, 4);

  // Daten für Quad1;
  glBindVertexArray(VBQuad1.VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad1.VBO);
  glBufferData(GL_ARRAY_BUFFER, Length(Quad1) * sizeof(TVector5f), PVector5f(Quad1), GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 3, GL_FLOAT, False, 20, nil);
  glEnableVertexAttribArray(1);
  glVertexAttribPointer(1, 2, GL_FLOAT, False, 20, Pointer(12));

end;

procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);  // Frame und Tiefen-Puffer löschen.

  Textures[TexturIndex].ActiveAndBind(0);
  //  Textur.ActiveAndBind(0); // Textur 0 mit Sampler 0 binden.

  Shader.UseProgram;

  WorldMatrix.Uniform(WorldMatrix_ID);                     // Matrix dem Shader übergeben

  // Zeichne Quad0;
  glBindVertexArray(VBQuad0.VAO);
  glDrawArrays(GL_PATCHES, 0, Length(Quad0));

  // Zeichne Quad1;
  glBindVertexArray(VBQuad1.VAO);
  glDrawArrays(GL_PATCHES, 0, Length(Quad1));

  ogc.SwapBuffers;
end;

procedure TForm1.FormDestroy(Sender: TObject);
var
  i: integer;
begin
  Shader.Free;

  glDeleteVertexArrays(1, @VBQuad0.VAO);
  glDeleteVertexArrays(1, @VBQuad1.VAO);
  glDeleteVertexArrays(1, @VBVert.VAO);

  glDeleteBuffers(1, @VBQuad0.VBO);
  glDeleteBuffers(1, @VBQuad1.VBO);
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
