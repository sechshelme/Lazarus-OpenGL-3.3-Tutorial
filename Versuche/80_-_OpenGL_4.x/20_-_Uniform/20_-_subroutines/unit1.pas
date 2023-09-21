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
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
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


  { TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  //remove+
  Width := 340;
  Height := 240;
  //remove-
  ogc := TContext.Create(Self);
  ogc.OnPaint := @ogcDrawScene;

  CreateScene;
  InitScene;
end;

procedure TForm1.CreateScene;
begin
  Shader := TShader.Create([
    GL_VERTEX_SHADER, FileToStr('Vertexshader.glsl'),
    GL_FRAGMENT_SHADER, FileToStr('Fragmentshader.glsl')]);

  Shader.UseProgram;

  glGenVertexArrays(1, @VBTriangle.VAO);
  glGenVertexArrays(1, @VBQuad.VAO);

  glGenBuffers(1, @VBTriangle.VBO);
  glGenBuffers(1, @VBQuad.VBO);
end;

//code+
procedure TForm1.InitScene;
var
  n: TGLsizei;
begin
  glClearColor(0.6, 0.6, 0.4, 1.0);                  // Hintergrundfarbe
  glEnable(GL_BLEND);                                // Alphablending an
  glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA); // Sortierung der Primitiven von hinten nach vorne.


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

  // Subroutines
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
    glUniformSubroutinesuiv(GL_FRAGMENT_SHADER, n, PGLuint(indices));
  end;

  with VertexSubRoutine do begin
    SelectorLoc := glGetSubroutineUniformLocation(Shader.ID, GL_VERTEX_SHADER, 'MoveSelector');
    MoveLeft := glGetSubroutineIndex(Shader.ID, GL_VERTEX_SHADER, 'MoveLeft');
    MoveRight := glGetSubroutineIndex(Shader.ID, GL_VERTEX_SHADER, 'MoveRight');

    glGetProgramStageiv(Shader.ID, GL_VERTEX_SHADER, GL_ACTIVE_SUBROUTINE_UNIFORM_LOCATIONS, @n);
    SetLength(indices, n);
    glUniformSubroutinesuiv(GL_VERTEX_SHADER, n, PGLuint(indices));
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
  //code-

  ogc.SwapBuffers;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Shader.Free;

  glDeleteVertexArrays(1, @VBTriangle.VAO);
  glDeleteVertexArrays(1, @VBQuad.VAO);

  glDeleteBuffers(1, @VBTriangle.VBO);
  glDeleteBuffers(1, @VBQuad.VBO);
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
