unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, ComCtrls, StdCtrls,
  dglOpenGL,
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
  Quad: array of TVector3f =
    ((-0.2, -0.6, 0.0), (0.2, 0.6, 0.0), (-0.2, 0.6, 0.0),
    (0.2, -0.6, 0.0), (-0.2, -0.6, 0.0), (0.2, 0.6, 0.0));

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

  { TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
const level=32;
var
  i: integer;
  s: string;
begin
  for i:=0 to Length(outer_levels)-1 do outer_levels[i]:=level;
  for i:=0 to Length(inner_levels)-1 do inner_levels[i]:=level;

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
  Shader := TShader.Create;
  Shader.LoadShaderObjectFromFile(GL_VERTEX_SHADER, 'Vertexshader.glsl');
  Shader.LoadShaderObjectFromFile(GL_TESS_EVALUATION_SHADER, 'Tesselationshader.glsl');
  Shader.LoadShaderObjectFromFile(GL_FRAGMENT_SHADER, 'Fragmentshader.glsl');
  Shader.LinkProgramm;
  Shader.UseProgram;
  //code-

  glGenVertexArrays(1, @VBQuad.VAO);

  glGenBuffers(1, @VBQuad.VBO);

  Timer1.Enabled := True;
end;

procedure TForm1.InitScene;
begin
  glClearColor(0.6, 0.6, 0.4, 1.0);

  glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);
  glPatchParameteri(GL_PATCH_VERTICES, 3);

  // Daten für Quadrat
  glBindVertexArray(VBQuad.VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBO);
  glBufferData(GL_ARRAY_BUFFER, Length(Quad) * sizeof(TVector3f), PVector3f(Quad), GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 3, GL_FLOAT, False, 0, nil);
end;

procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT);

  glPatchParameterfv(GL_PATCH_DEFAULT_OUTER_LEVEL, PGLfloat(outer_levels));
  glPatchParameterfv(GL_PATCH_DEFAULT_INNER_LEVEL, PGLfloat(inner_levels));

  Shader.UseProgram;

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

  glDeleteVertexArrays(1, @VBQuad.VAO);
  glDeleteBuffers(1, @VBQuad.VBO);
end;

procedure TForm1.CheckBox1Change(Sender: TObject);
var
  id: GLint;
begin
  id:=Shader.UniformLocation('isSinus');
  glUniform1i(id, GLint(CheckBox1.Checked));
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
