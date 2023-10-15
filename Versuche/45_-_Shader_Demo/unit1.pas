unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, Menus,
  dglOpenGL,
  oglContext, oglShader, oglVector, oglMatrix;

type

  { TForm1 }

  TForm1 = class(TForm)
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormResize(Sender: TObject);
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

//image image.png

(*
*)

//lineal

type
  TVB = record
    VAO: GLuint;
  end;

var
  time_ID,
  Resolution_ID: GLint;
  timeRot: GLfloat;

  VBQuad: TVB;

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
  Timer1.Enabled := True;
end;

procedure TForm1.CreateScene;
var
  i: integer;
begin
  Shader := TShader.Create([FileToStr('Vertexshader.glsl'), FileToStr('Fragmentshader.glsl')]);
  with Shader do begin
    UseProgram;

    Resolution_ID := UniformLocation('iResolution');
    time_ID := UniformLocation('iTime');
  end;

  glGenVertexArrays(1, @VBQuad.VAO);
end;

procedure TForm1.InitScene;
begin
  glClearColor(0.2, 0.1, 0.0, 1.0); // Hintergrundfarbe

  // Daten für Quadrat
  glBindVertexArray(VBQuad.VAO);
end;

procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT);
  Shader.UseProgram;

  // Zeichne Quadrat

  glUniform1f(time_ID, timeRot);
  glBindVertexArray(VBQuad.VAO);
  glDrawArrays(GL_TRIANGLES, 0, 6);

  ogc.SwapBuffers;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Timer1.Enabled := False;

  Shader.Free;

  glDeleteVertexArrays(1, @VBQuad.VAO);
end;

procedure TForm1.FormResize(Sender: TObject);
var
  Resolution: TVector2f = (0, 0);
begin
  Resolution.x := ClientWidth / 500;
  Resolution.y := ClientHeight / 500;
  glUniform2fv(Resolution_ID, 1, @Resolution);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  timeRot += 0.024;
  ogcDrawScene(Sender);
end;

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
