unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, ComCtrls, StdCtrls,
  dglOpenGL,
  oglContext, oglShader, oglVector, oglMatrix;

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
    Timer1: TTimer;
    ToolBar1: TToolBar;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    Buttons: array of TButton;
    ogc: TContext;
    Shader: TShader; // Shader-Object
    procedure CreateScene;
    procedure InitScene;
    procedure ogcDrawScene(Sender: TObject);
    procedure OnButtomsClick(Sender: TObject);
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

const
  Triangle: array of TVector3f =
    ((-0.4, 0.1, 0.0), (0.4, 0.1, 0.0), (0.0, 0.7, 0.0));
  Quad: array of TVector3f =
    ((-0.2, -0.6, 0.0), (-0.2, -0.1, 0.0), (0.2, -0.1, 0.0),
    (-0.2, -0.6, 0.0), (0.2, -0.1, 0.0), (0.2, -0.6, 0.0));

const
  outer_levels: array of GLfloat = (2, 2, 2, 2);
  inner_levels: array of GLfloat = (2, 2);

var
  Uniform_ID: record
    ol, il: GLint;
      end;


type
  TVB = record
    VAO,
    VBO: GLuint;
  end;

var
  VBTriangle, VBQuad: TVB;

  { TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
var
  i: integer;
  s: string;
begin
  SetLength(Buttons, 8);
  for i := 0 to Length(Buttons) - 1 do begin
    Buttons[i] := TButton.Create(ToolBar1);
    Buttons[i].Parent := ToolBar1;
    Buttons[i].Width := 30;
    Buttons[i].Tag := i;
    Buttons[i].OnClick := @OnButtomsClick;
  end;
  Buttons[0].Caption := 'O0+';
  Buttons[1].Caption := 'O0-';
  Buttons[2].Caption := 'O1+';
  Buttons[3].Caption := 'O1-';
  Buttons[4].Caption := 'O2+';
  Buttons[5].Caption := 'O2-';
  Buttons[6].Caption := 'I0+';
  Buttons[7].Caption := 'I0-';

  //remove+
  Width := 340;
  Height := 240;
  //remove-
  ogc := TContext.Create(Self);
  ogc.OnPaint := @ogcDrawScene;

  CreateScene;
  InitScene;
end;

(*
Hier ist die einzige Besonderheit, dem Constructor von TShader wird ein dritter Shader-Code mitgegeben.

Wen man bei der Shader-Klasse einen dritten Shader mit gibt, wird automatisch erkannt, das noch ein Geometrie-Shader dazu kommt.
*)

//code+
procedure TForm1.CreateScene;
begin
  Shader := TShader.Create([
    FileToStr('Vertexshader.glsl'),
    FileToStr('tesselationcontrolshader.glsl'),
    FileToStr('Tesselationshader.glsl'),
    FileToStr('Fragmentshader.glsl')], True);
  with Shader do begin
    UseProgram;
    Uniform_ID.ol := UniformLocation('TLO');
    Uniform_ID.il := UniformLocation('TLI');
  end;
  //code-

  glGenVertexArrays(1, @VBTriangle.VAO);
  glGenVertexArrays(1, @VBQuad.VAO);

  glGenBuffers(1, @VBTriangle.VBO);
  glGenBuffers(1, @VBQuad.VBO);

  Timer1.Enabled := True;
end;

procedure TForm1.InitScene;
begin
  glClearColor(0.6, 0.6, 0.4, 1.0); // Hintergrundfarbe

  glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);
  glPatchParameteri(GL_PATCH_VERTICES, 3);

  // Daten für Dreieck
  glBindVertexArray(VBTriangle.VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBTriangle.VBO);
  glBufferData(GL_ARRAY_BUFFER, Length(Triangle) * sizeof(TVector3f), PVector3f(Triangle), GL_STATIC_DRAW);
  glEnableVertexAttribArray(10);
  glVertexAttribPointer(10, 3, GL_FLOAT, False, 0, nil);

  // Daten für Quadrat
  glBindVertexArray(VBQuad.VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBO);
  glBufferData(GL_ARRAY_BUFFER, Length(Quad) * sizeof(TVector3f), PVector3f(Quad), GL_STATIC_DRAW);
  glEnableVertexAttribArray(10);
  glVertexAttribPointer(10, 3, GL_FLOAT, False, 0, nil);
end;

procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT);

  //  glPatchParameterfv(GL_PATCH_DEFAULT_OUTER_LEVEL, PGLfloat(outer_levels));
  //  glPatchParameterfv(GL_PATCH_DEFAULT_INNER_LEVEL, PGLfloat(inner_levels));

  Shader.UseProgram;

  glUniform1fv(Uniform_ID.ol, Length(outer_levels), PGLfloat(outer_levels));
  glUniform1fv(Uniform_ID.il, Length(inner_levels), PGLfloat(inner_levels));

  // Zeichne Dreieck
  glBindVertexArray(VBTriangle.VAO);
  glDrawArrays(GL_PATCHES, 0, Length(Triangle));

  // Zeichne Quadrat
  glBindVertexArray(VBQuad.VAO);
  glDrawArrays(GL_PATCHES, 0, Length(Quad));

  ogc.SwapBuffers;
end;

procedure TForm1.OnButtomsClick(Sender: TObject);
const
  step = 1.0;
begin
  case TButton(Sender).Tag of
    0: begin
      outer_levels[0] += step;
    end;
    1: begin
      outer_levels[0] -= step;
      if outer_levels[0] <= 0 then begin
        outer_levels[0] := step;
      end;
    end;
    2: begin
      outer_levels[1] += step;
    end;
    3: begin
      outer_levels[1] -= step;
      if outer_levels[1] <= 0 then begin
        outer_levels[1] := step;
      end;
    end;
    4: begin
      outer_levels[2] += step;
    end;
    5: begin
      outer_levels[2] -= step;
      if outer_levels[2] <= 0 then begin
        outer_levels[2] := step;
      end;
    end;
    6: begin
      inner_levels[0] += step;
    end;
    7: begin
      inner_levels[0] -= step;
      if inner_levels[0] <= 0 then begin
        inner_levels[0] := step;
      end;
    end;
  end;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Shader.Free;

  glDeleteVertexArrays(1, @VBTriangle.VAO);
  glDeleteVertexArrays(1, @VBQuad.VAO);

  glDeleteBuffers(1, @VBTriangle.VBO);
  glDeleteBuffers(1, @VBQuad.VBO);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
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
