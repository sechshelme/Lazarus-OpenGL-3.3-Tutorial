unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, ComCtrls, StdCtrls,
  dglOpenGL, oglDebug,
  oglContext, oglShader, oglVector, oglMatrix;

  //image image.png


  //lineal

type

  { TForm1 }

  TForm1 = class(TForm)
    CheckBox1: TCheckBox;
    Timer1: TTimer;
    ToolBar1: TToolBar;
    procedure CheckBox1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    ogc: TContext;
    Shader: TShader; // Shader-Object
    procedure CreateScene;
    procedure ogcDrawScene(Sender: TObject);
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

type
  TUBOBuffer = record
    ModelMatrix: Tmat4x4;
    isSinus: TGLboolean;
  end;

const
  Quad: array of TVector3f = (
    (-0.5, 0.5, -0.5), (-0.5, -0.5, -0.5), (0.5, 0.5, -0.5), (0.5, -0.5, -0.5),
    (0.5, 0.5, -0.5), (0.5, -0.5, -0.5), (0.5, 0.5, 0.5), (0.5, -0.5, 0.5),
    (0.5, 0.5, 0.5), (0.5, -0.5, 0.5), (-0.5, 0.5, 0.5), (-0.5, -0.5, 0.5),
    (-0.5, 0.5, 0.5), (-0.5, -0.5, 0.5), (-0.5, 0.5, -0.5), (-0.5, -0.5, -0.5),
    // oben
    (0.5, 0.5, -0.5), (0.5, 0.5, 0.5), (-0.5, 0.5, -0.5), (-0.5, 0.5, 0.5),
    // unten
    (-0.5, -0.5, -0.5), (-0.5, -0.5, 0.5), (0.5, -0.5, -0.5), (0.5, -0.5, 0.5));

const
  outer_levels: array of GLfloat = (2, 2, 2, 2);
  inner_levels: array of GLfloat = (2, 2);

type
  TVB = record
    VAO,
    VBO: GLuint;
  end;

var
  VBQuad: TVB;
  UBOBuffer: TUBOBuffer;
  UBO,
  UBO_ID: GLint;


  { TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
const
  level = 64;
var
  i: integer;
begin
  for i := 0 to Length(outer_levels) - 1 do begin
    outer_levels[i] := level;
  end;
  for i := 0 to Length(inner_levels) - 1 do begin
    inner_levels[i] := level;
  end;

  //remove+
  Width := 340;
  Height := 240;
  //remove-
  ogc := TContext.Create(Self);
  ogc.OnPaint := @ogcDrawScene;

  CreateScene;
end;

(*
Hier ist die einzige Besonderheit, dem Constructor von TShader wird ein dritter Shader-Code mitgegeben.

Wen man bei der Shader-Klasse einen dritten Shader mit gibt, wird automatisch erkannt, das noch ein Geometrie-Shader dazu kommt.
*)

//code+
procedure TForm1.CreateScene;
begin
  InitOpenGLDebug;

  Shader := TShader.Create;
  Shader.LoadShaderObjectFromFile(GL_VERTEX_SHADER, 'Vertexshader.glsl');
  Shader.LoadShaderObjectFromFile(GL_TESS_EVALUATION_SHADER, 'Tesselationshader.glsl');
  Shader.LoadShaderObjectFromFile(GL_GEOMETRY_SHADER, 'geometrie.glsl');
  Shader.LoadShaderObjectFromFile(GL_FRAGMENT_SHADER, 'Fragmentshader.glsl');
  Shader.LinkProgramm;
  Shader.UseProgram;
  //code-

  // --- UBO
  UBOBuffer.ModelMatrix.Identity;
  UBOBuffer.ModelMatrix.Scale(1.5);
  UBOBuffer.isSinus := CheckBox1.Checked;

  glGenBuffers(1, @UBO);                          // UB0-Puffer generieren.
  // UBO mit Daten laden
  glBindBuffer(GL_UNIFORM_BUFFER, UBO);
  glBufferData(GL_UNIFORM_BUFFER, SizeOf(TUBOBuffer), nil, GL_DYNAMIC_DRAW);

  // UBO mit dem Shader verbinden
  UBO_ID := Shader.UniformBlockIndex('UBO');
  glUniformBlockBinding(Shader.ID, UBO_ID, 0);
  glBindBufferBase(GL_UNIFORM_BUFFER, 0, UBO);


  Timer1.Enabled := True;
  glEnable(GL_DEPTH_TEST);

  glEnable(GL_CULL_FACE);   // Überprüfung einschalten
  glCullFace(GL_BACK);      // Rückseite nicht zeichnen.


  glClearColor(0.6, 0.6, 0.4, 1.0);

  //  glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);
  glPatchParameteri(GL_PATCH_VERTICES, 4);

  // Daten für Quadrat
  glGenVertexArrays(1, @VBQuad.VAO);
  glGenBuffers(1, @VBQuad.VBO);

  glBindVertexArray(VBQuad.VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBO);
  glBufferData(GL_ARRAY_BUFFER, Length(Quad) * sizeof(TVector3f), PGLvoid(Quad), GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 3, GL_FLOAT, False, 0, nil);
end;

procedure TForm1.ogcDrawScene(Sender: TObject);
var
  mat: Tmat4x4;
begin
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);  // Frame und Tiefen-Buffer löschen.

  glPatchParameterfv(GL_PATCH_DEFAULT_OUTER_LEVEL, PGLfloat(outer_levels));
  glPatchParameterfv(GL_PATCH_DEFAULT_INNER_LEVEL, PGLfloat(inner_levels));

  Shader.UseProgram;

  // Zeichne cube
  glBufferSubData(GL_UNIFORM_BUFFER, 0, sizeof(TUBOBuffer), @UBOBuffer);

  glBindVertexArray(VBQuad.VAO);
  glDrawArrays(GL_PATCHES, 0, Length(Quad));

  //mat:=UBOBuffer.ModelMatrix;
  //UBOBuffer.ModelMatrix.Scale(0.5);
  //glBufferSubData(GL_UNIFORM_BUFFER, 0, sizeof(TUBOBuffer), @UBOBuffer);
  //glDrawArrays(GL_PATCHES, 0, Length(Quad));
  //UBOBuffer.ModelMatrix:=mat;

  ogc.SwapBuffers;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Shader.Free;

  glDeleteBuffers(1, @UBO);
  glDeleteVertexArrays(1, @VBQuad.VAO);
  glDeleteBuffers(1, @VBQuad.VBO);
end;

procedure TForm1.CheckBox1Change(Sender: TObject);
begin
  UBOBuffer.isSinus := CheckBox1.Checked;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  UBOBuffer.ModelMatrix.RotateB(0.02);
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
