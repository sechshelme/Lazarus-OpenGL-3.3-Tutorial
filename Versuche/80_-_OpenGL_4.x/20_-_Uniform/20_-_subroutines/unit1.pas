unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, Menus,
  dglOpenGL, oglVector, oglMatrix, oglContext, oglShader;

type

  { TForm1 }

  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
  private
    ogc: TContext;
    Shader: TShader; // Shader-Object
    procedure Init_OpenGL;
    procedure ogcDrawScene(Sender: TObject);
    procedure Destroy_OpenGL;
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

//image image.png

//lineal

const
  Triangle: array of TFace =
    (((-0.4, 0.1, 0.0), (0.4, 0.1, 0.0), (0.0, 0.7, 0.0)));

  Quad: array of TFace =
    (((-0.2, -0.6, 0.0), (-0.2, -0.1, 0.0), (0.2, -0.1, 0.0)),
    ((-0.2, -0.6, 0.0), (0.2, -0.1, 0.0), (0.2, -0.6, 0.0)));

type
  TVB = record
    VAO,
    VBO: GLuint;
  end;

var
  VBTriangle, VBQuad: TVB;

var
  FragmentSubRoutine: record
    ColorIndex: record
      SelectorLoc: TGLint;
      Red, Green, Blue: TGLuint;
      end;
    AlphaIndex: record
      SelectorLoc: TGLint;
      AlphaTrue, AlphaFalse: TGLuint;
      end;
    indices: array of TGLuint;
      end;

  VertexSubRoutine: record
    SelectorLoc: TGLint;
    MoveLeft, MoveRight: TGLuint;
    indices: array of TGLuint;
      end;


  // https://www.lighthouse3d.com/tutorials/glsl-tutorial/subroutines/

  //code+
procedure TForm1.FormCreate(Sender: TObject);
begin
  //remove+
  Width := 340;
  Height := 240;
  //remove-
  Init_OpenGL;
end;

procedure TForm1.Init_OpenGL;
var
  n: TGLsizei;
begin
  // --- Context erzeugen
  ogc := TContext.Create(Self);
  ogc.OnPaint := @ogcDrawScene;

  glClearColor(0.6, 0.6, 0.4, 1.0);                  // Hintergrundfarbe
  glEnable(GL_BLEND);                                // Alphablending an
  glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA); // Sortierung der Primitiven von hinten nach vorne.

  // --- Shader laden
  Shader := TShader.Create;
  Shader.LoadShaderObjectFromFile(GL_VERTEX_SHADER, 'Vertexshader.glsl');
  Shader.LoadShaderObjectFromFile(GL_FRAGMENT_SHADER, 'Fragmentshader.glsl');
  Shader.LinkProgramm;
  Shader.UseProgram;

  // --- Buffer erzeugen
  glGenVertexArrays(1, @VBTriangle.VAO);
  glGenVertexArrays(1, @VBQuad.VAO);

  glGenBuffers(1, @VBTriangle.VBO);
  glGenBuffers(1, @VBQuad.VBO);

  // --- Buffer beladen

  // Daten für das Dreieck
  glBindVertexArray(VBTriangle.VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBTriangle.VBO);
  glBufferData(GL_ARRAY_BUFFER, Length(Triangle) * sizeof(TFace), PFace(Triangle), GL_STATIC_DRAW);
  glEnableVertexAttribArray(10);
  glVertexAttribPointer(10, 3, GL_FLOAT, False, 0, nil);

  // Daten für das Quadrat
  glBindVertexArray(VBQuad.VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBO);
  glBufferData(GL_ARRAY_BUFFER, Length(Quad) * sizeof(TFace), PFace(Quad), GL_STATIC_DRAW);
  glEnableVertexAttribArray(10);
  glVertexAttribPointer(10, 3, GL_FLOAT, False, 0, nil);

  // --- Subroutines
  with FragmentSubRoutine do begin
    with ColorIndex do begin
      SelectorLoc := glGetSubroutineUniformLocation(Shader.ID, GL_FRAGMENT_SHADER, 'ColorSelector');
      Red := glGetSubroutineIndex(Shader.ID, GL_FRAGMENT_SHADER, 'colorRed');
      Green := glGetSubroutineIndex(Shader.ID, GL_FRAGMENT_SHADER, 'colorGreen');
      Blue := glGetSubroutineIndex(Shader.ID, GL_FRAGMENT_SHADER, 'colorBlue');
    end;

    with AlphaIndex do begin
      SelectorLoc := glGetSubroutineUniformLocation(Shader.ID, GL_FRAGMENT_SHADER, 'AlphaSelector');
      AlphaFalse := glGetSubroutineIndex(Shader.ID, GL_FRAGMENT_SHADER, 'AlphaFalse');
      AlphaTrue := glGetSubroutineIndex(Shader.ID, GL_FRAGMENT_SHADER, 'AlphaTrue');
    end;

    glGetProgramStageiv(Shader.ID, GL_FRAGMENT_SHADER, GL_ACTIVE_SUBROUTINE_UNIFORM_LOCATIONS, @n);
    SetLength(indices, n);
  end;

  with VertexSubRoutine do begin
    SelectorLoc := glGetSubroutineUniformLocation(Shader.ID, GL_VERTEX_SHADER, 'MoveSelector');
    MoveLeft := glGetSubroutineIndex(Shader.ID, GL_VERTEX_SHADER, 'MoveLeft');
    MoveRight := glGetSubroutineIndex(Shader.ID, GL_VERTEX_SHADER, 'MoveRight');

    glGetProgramStageiv(Shader.ID, GL_VERTEX_SHADER, GL_ACTIVE_SUBROUTINE_UNIFORM_LOCATIONS, @n);
    SetLength(indices, n);
  end;
end;

//code-

//code+
procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT);
  Shader.UseProgram;

  // Zeichne Dreieck
  with VertexSubRoutine do begin
    indices[SelectorLoc] := MoveLeft;
    glUniformSubroutinesuiv(GL_VERTEX_SHADER, Length(indices), PGLuint(indices));
  end;
  with FragmentSubRoutine do begin
    indices[ColorIndex.SelectorLoc] := ColorIndex.Blue;
    indices[AlphaIndex.SelectorLoc] := AlphaIndex.AlphaTrue;
    glUniformSubroutinesuiv(GL_FRAGMENT_SHADER, Length(indices), PGLuint(indices));
  end;

  glBindVertexArray(VBTriangle.VAO);
  glDrawArrays(GL_TRIANGLES, 0, Length(Triangle) * 3);

  // Zeichne Quadrat
  with VertexSubRoutine do begin
    indices[SelectorLoc] := MoveRight;
    glUniformSubroutinesuiv(GL_VERTEX_SHADER, Length(indices), PGLuint(indices));
  end;
  with FragmentSubRoutine do begin
    indices[ColorIndex.SelectorLoc] := ColorIndex.Green;
    indices[AlphaIndex.SelectorLoc] := AlphaIndex.AlphaFalse;
    glUniformSubroutinesuiv(GL_FRAGMENT_SHADER, Length(indices), PGLuint(indices));
  end;

  glBindVertexArray(VBQuad.VAO);
  glDrawArrays(GL_TRIANGLES, 0, Length(Quad) * 3);

  ogc.SwapBuffers;
end;

procedure TForm1.Destroy_OpenGL;
begin
  Shader.Free;

  glDeleteVertexArrays(1, @VBTriangle.VAO);
  glDeleteVertexArrays(1, @VBQuad.VAO);

  glDeleteBuffers(1, @VBTriangle.VBO);
  glDeleteBuffers(1, @VBQuad.VBO);
end;

//code-

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Destroy_OpenGL;
end;

procedure TForm1.MenuItem2Click(Sender: TObject);
var
  countActiveSU: TGLsizei;
  sl: TStringList;
  sname: array of char = nil;
  len, numComps: TGLint;
  i, j: integer;
  su: array of TGLint = nil;
begin
  sl := TStringList.Create;

  glGetIntegerv(GL_MAX_SUBROUTINES, @i);
  sl.Add('Max Subroutines: ' + i.ToString);
  glGetIntegerv(GL_MAX_SUBROUTINE_UNIFORM_LOCATIONS, @i);
  sl.Add('Max Subroutine Uniforms: ' + i.ToString);

  sl.Add('');
  glGetProgramStageiv(Shader.ID, GL_FRAGMENT_SHADER, GL_ACTIVE_SUBROUTINE_UNIFORM_LOCATIONS, @countActiveSU);
  sl.Add('Subroutines Lacations: ' + countActiveSU.ToString);
  glGetProgramStageiv(Shader.ID, GL_FRAGMENT_SHADER, GL_ACTIVE_SUBROUTINE_UNIFORMS, @countActiveSU);
  sl.Add('Subroutines Count: ' + countActiveSU.ToString);

  SetLength(sname, 255);
  for i := 0 to countActiveSU - 1 do begin
    glGetActiveSubroutineUniformName(Shader.ID, GL_FRAGMENT_SHADER, i, 255, @len, PChar(sname));
    sl.Add('');
    sl.Add('Subname: ' + PChar(sname));

    glGetActiveSubroutineUniformiv(Shader.ID, GL_FRAGMENT_SHADER, i, GL_NUM_COMPATIBLE_SUBROUTINES, @numComps);
    sl.Add('  Subs Count: ' + numComps.ToString);

    SetLength(su, numComps);
    glGetActiveSubroutineUniformiv(Shader.ID, GL_FRAGMENT_SHADER, i, GL_COMPATIBLE_SUBROUTINES, PGLint(su));

    for j := 0 to numComps - 1 do begin
      glGetActiveSubroutineName(Shader.ID, GL_FRAGMENT_SHADER, su[j], 255, @len, PChar(sname));
      sl.Add('    ' + PChar(sname) + ' (' + su[j].ToString + ')');
    end;
  end;

  ShowMessage(sl.Text);
  sl.Free;
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
