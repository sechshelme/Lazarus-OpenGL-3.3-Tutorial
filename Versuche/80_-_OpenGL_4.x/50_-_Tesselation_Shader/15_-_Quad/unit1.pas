unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, ComCtrls, StdCtrls,
  oglglad_gl,
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
  Quad0: array of TVector3f =
    ((-0.3, 0.6, 0.0), (-0.2, 0.1, 0.0), (0.3, 0.6, 0.0), (0.2, 0.1, 0.0));
  Quad1: array of TVector3f =
    ((-0.2, -0.6, 0.0), (-0.2, -0.1, 0.0), (0.2, -0.6, 0.0), (0.2, -0.1, 0.0));

const
  outer_levels: array of GLfloat = (2, 2, 2, 2);
  inner_levels: array of GLfloat = (2, 2);

type
  TVB = record
    VAO,
    VBO: GLuint;
  end;

var
  VBQuad0, VBQuad1: TVB;

  { TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
var
  i: integer;
  s: string;
begin
  SetLength(Buttons, 12);
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
  Buttons[6].Caption := 'O3+';
  Buttons[7].Caption := 'O4-';
  Buttons[8].Caption := 'I0+';
  Buttons[9].Caption := 'I0-';
  Buttons[10].Caption := 'I1+';
  Buttons[11].Caption := 'I1-';

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
  Shader := TShader.Create;
  Shader.LoadShaderObjectFromFile(GL_VERTEX_SHADER, 'Vertexshader.glsl');
  Shader.LoadShaderObjectFromFile(GL_TESS_EVALUATION_SHADER, 'Tesselationshader.glsl');
  Shader.LoadShaderObjectFromFile(GL_FRAGMENT_SHADER, 'Fragmentshader.glsl');
  Shader.LinkProgram;
  Shader.UseProgram;
  //code-

  glGenVertexArrays(1, @VBQuad0.VAO);
  glGenVertexArrays(1, @VBQuad1.VAO);

  glGenBuffers(1, @VBQuad0.VBO);
  glGenBuffers(1, @VBQuad1.VBO);

  Timer1.Enabled := True;
end;

procedure TForm1.InitScene;
begin
  glClearColor(0.6, 0.6, 0.4, 1.0); // Hintergrundfarbe

  glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);
  glPatchParameteri(GL_PATCH_VERTICES, 4);

  // Daten für Dreieck
  glBindVertexArray(VBQuad0.VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad0.VBO);
  glBufferData(GL_ARRAY_BUFFER, Length(Quad0) * sizeof(TVector3f), PVector3f(Quad0), GL_STATIC_DRAW);
  glEnableVertexAttribArray(10);
  glVertexAttribPointer(10, 3, GL_FLOAT, GL_FALSE, 0, nil);

  // Daten für Quadrat
  glBindVertexArray(VBQuad1.VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad1.VBO);
  glBufferData(GL_ARRAY_BUFFER, Length(Quad1) * sizeof(TVector3f), PVector3f(Quad1), GL_STATIC_DRAW);
  glEnableVertexAttribArray(10);
  glVertexAttribPointer(10, 3, GL_FLOAT, GL_FALSE, 0, nil);
end;

procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT);

  glPatchParameterfv(GL_PATCH_DEFAULT_OUTER_LEVEL, PGLfloat(outer_levels));
  glPatchParameterfv(GL_PATCH_DEFAULT_INNER_LEVEL, PGLfloat(inner_levels));

  Shader.UseProgram;

  // Zeichne Dreieck
  glBindVertexArray(VBQuad0.VAO);
  glDrawArrays(GL_PATCHES, 0, Length(Quad0));

  // Zeichne Quadrat
  glBindVertexArray(VBQuad1.VAO);
  glDrawArrays(GL_PATCHES, 0, Length(Quad1));

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
      outer_levels[3] += step;
    end;
    7: begin
      outer_levels[3] -= step;
      if outer_levels[3] <= 0 then begin
        outer_levels[3] := step;
      end;
    end;

    8: begin
      inner_levels[0] += step;
    end;
    9: begin
      inner_levels[0] -= step;
      if inner_levels[0] <= 0 then begin
        inner_levels[0] := step;
      end;
    end;
    10: begin
      inner_levels[1] += step;
    end;
    11: begin
      inner_levels[1] -= step;
      if inner_levels[1] <= 0 then begin
        inner_levels[1] := step;
      end;
    end;
  end;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Shader.Free;

  glDeleteVertexArrays(1, @VBQuad0.VAO);
  glDeleteVertexArrays(1, @VBQuad1.VAO);

  glDeleteBuffers(1, @VBQuad0.VBO);
  glDeleteBuffers(1, @VBQuad1.VBO);
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
