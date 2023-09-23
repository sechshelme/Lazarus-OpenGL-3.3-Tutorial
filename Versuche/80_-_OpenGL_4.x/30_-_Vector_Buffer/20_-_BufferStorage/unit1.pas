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
  TriangleVector: array of TFace =
    (((-0.4, 0.1, 0.0), (0.4, 0.1, 0.0), (0.0, 0.7, 0.0)));
  TriangleColor: array of TFace =
    (((1.0, 0.0, 0.0), (0.0, 1.0, 0.0), (0.0, 0.0, 1.0)));

  Quad: array of TFace =
    (((-0.2, -0.6, 0.0), (-0.2, -0.1, 0.0), (0.2, -0.1, 0.0)),
    ((-0.2, -0.6, 0.0), (0.2, -0.1, 0.0), (0.2, -0.6, 0.0)));

  //type
  //  TVB = record
  //    VAO,
  //    VBO: GLuint;
  //  end;
  //
  //var
  //  VBTriangle, VBQuad: TVB;
var
  VAO:     TGLuint;


var
  buffer: TGLuint;

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
begin
  // --- Context erzeugen
  ogc := TContext.Create(Self);
  ogc.OnPaint := @ogcDrawScene;

  glClearColor(0.6, 0.6, 0.4, 1.0);                  // Hintergrundfarbe
  glEnable(GL_BLEND);                                // Alphablending an
  glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA); // Sortierung der Primitiven von hinten nach vorne.

  // --- Shader laden
  Shader := TShader.Create([
    GL_VERTEX_SHADER, FileToStr('Vertexshader.glsl'),
    GL_FRAGMENT_SHADER, FileToStr('Fragmentshader.glsl')]);

  Shader.UseProgram;

  //// --- Buffer erzeugen
  //glGenVertexArrays(1, @VBTriangle.VAO);
  //glGenVertexArrays(1, @VBQuad.VAO);
  //
  //glGenBuffers(1, @VBTriangle.VBO);
  //glGenBuffers(1, @VBQuad.VBO);
  //
  //// --- Buffer beladen
  //
  //// Daten für das Dreieck
  //glBindVertexArray(VBTriangle.VAO);
  //glBindBuffer(GL_ARRAY_BUFFER, VBTriangle.VBO);
  //glBufferData(GL_ARRAY_BUFFER, Length(TriangleVector) * sizeof(TFace), PFace(TriangleVector), GL_STATIC_DRAW);
  //glEnableVertexAttribArray(10);
  //glVertexAttribPointer(10, 3, GL_FLOAT, False, 0, nil);
  //
  //// Daten für das Quadrat
  //glBindVertexArray(VBQuad.VAO);
  //glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBO);
  //glBufferData(GL_ARRAY_BUFFER, Length(Quad) * sizeof(TFace), PFace(Quad), GL_STATIC_DRAW);
  //glEnableVertexAttribArray(10);
  //glVertexAttribPointer(10, 3, GL_FLOAT, False, 0, nil);

//   https://github.com/drew-diamantoukos/OpenGLBookExamples/blob/master/Projects/OpenGLBookExamples/Main.cpp

  glCreateBuffers(1, @buffer);

  glNamedBufferStorage(buffer, Length(TriangleVector) * (sizeof(TFace) + sizeof(TFace)), nil, GL_DYNAMIC_STORAGE_BIT);

  glNamedBufferSubData(buffer, 0, Length(TriangleVector) * sizeof(TFace), PFace(TriangleVector));

  glNamedBufferSubData(buffer, Length(TriangleVector) * sizeof(TFace), Length(TriangleVector) * sizeof(TFace), PFace(TriangleColor));


  glGenVertexArrays(1, @VAO);

  glBindVertexArray(VAO);
  glBindBuffer(GL_ARRAY_BUFFER, buffer);
  glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 0, nil);
  glEnableVertexAttribArray(0);

  glBindVertexArray(VAO);
  glBindBuffer(GL_ARRAY_BUFFER, buffer);
  glVertexAttribPointer(1, 3, GL_FLOAT, GL_FALSE, 0, nil);
  glEnableVertexAttribArray(1);

end;

//code-

//code+
procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT);
  Shader.UseProgram;

  // Zeichne Dreieck

  glBindVertexArray(buffer);
  glDrawArrays(GL_TRIANGLES, 0, Length(TriangleVector) * 3);

  // Zeichne Quadrat

  //  glBindVertexArray(VBQuad.VAO);
  //  glDrawArrays(GL_TRIANGLES, 0, Length(Quad) * 3);

  ogc.SwapBuffers;
end;

procedure TForm1.Destroy_OpenGL;
begin
  Shader.Free;

  //glDeleteVertexArrays(1, @VBTriangle.VAO);
  //glDeleteVertexArrays(1, @VBQuad.VAO);
  //
  //glDeleteBuffers(1, @VBTriangle.VBO);
  //glDeleteBuffers(1, @VBQuad.VBO);

  glDeleteBuffers(1, @buffer);
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
