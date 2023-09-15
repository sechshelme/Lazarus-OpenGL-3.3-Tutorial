unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, Menus,
  dglOpenGL, oglVector, oglMatrix, oglTextur,
  oglContext, oglShader;

type

  { TForm1 }

  TForm1 = class(TForm)
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
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

const
  InstanceCount = 12;

type
  TVB = record
    VAO: GLuint;
    VBO: record
      Vertex: GLuint;
    end;
  end;

var
  VBQuad: TVB;
  tb:TTexturBuffer;

  Data: record
    Color: array[0..InstanceCount - 1] of TVector2f;
  end;

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  Randomize;
  //remove+
  Width := 340;
  Height := 240;
  //remove-
  ogc := TContext.Create(Self);
  ogc.OnPaint := @ogcDrawScene;

  CreateScene;
  InitScene;
  Timer1.Enabled := True;   // Timer starten
end;

procedure TForm1.CreateScene;
var
  i: integer;
begin
  Shader := TShader.Create([
    GL_VERTEX_SHADER, FileToStr('Vertexshader.glsl'),
    GL_GEOMETRY_SHADER, FileToStr('Geometrie.glsl'),
    GL_FRAGMENT_SHADER, FileToStr('Fragmentshader.glsl')]);

  Shader.UseProgram;

  glGenVertexArrays(1, @VBQuad.VAO);
  glGenBuffers(1, @VBQuad.VBO);

  tb:=TTexturBuffer.Create;
  tb.LoadTextures('project1.ico');

  for i := 0 to Length(Data.Color) - 1 do begin
    Data.Color[i] := vec2((-0.5 + Random) * 2, (-0.5 + Random) * 2);
  end;
end;

procedure TForm1.InitScene;
var
  i: integer;
begin
  glClearColor(0.6, 0.6, 0.4, 1.0); // Hintergrundfarbe

  glBindVertexArray(VBQuad.VAO);

  // Vector
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBO.Vertex);
  glBufferData(GL_ARRAY_BUFFER, SizeOf(Data.Color), @Data.Color, GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 2, GL_FLOAT, False, 0, nil);
end;

procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  tb.ActiveAndBind;

  glClear(GL_COLOR_BUFFER_BIT);
  Shader.UseProgram;

  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBO.Vertex);
  glBufferSubData(GL_ARRAY_BUFFER, 0, SizeOf(Data.Color), @Data.Color);

  glBindVertexArray(VBQuad.VAO);
  glDrawArrays(GL_POINTS, 0, InstanceCount);

  ogc.SwapBuffers;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Timer1.Enabled := False;
  Shader.Free;
  glDeleteVertexArrays(1, @VBQuad.VAO);
  glDeleteBuffers(1, @VBQuad.VBO);
  tb.Free;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to Length(Data.Color) - 1 do begin
    Data.Color[i].Rotate(0.02);
  end;

  glBindVertexArray(VBQuad.VAO);
  ogcDrawScene(Sender);  // Neu zeichnen
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
//includeglsl Geometrier.glsl
//lineal

(*
<b>Fragment-Shader:</b>
*)
//includeglsl Fragmentshader.glsl

end.
