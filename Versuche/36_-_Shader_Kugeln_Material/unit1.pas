unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, Menus,
  dglOpenGL,
  oglVector, oglMatrix, oglContext, oglShader;

type

  { TForm1 }

  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    ogc: TContext;
    Shader: TShader; // Shader-Object
    procedure CreateVertex;
    procedure CreateScene;
    procedure InitScene;
    procedure ogcDrawScene(Sender: TObject);
    procedure ogcResize(Sender: TObject);
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

//image image.png

(*
Man kann auch Punkte mit dem Shader darstellen, dies kann man auf verschiedene Weise.
Im Fragment-Shader kann man das Zeichen der Punkte manipulieren.
*)

//lineal

(*
Die Deklaration der Koordianten und Punktgrösse.
*)
//code+

type
  TPoint = record
    vec: TVector3f;
    PointSize: GLfloat;
  end;

var
  Points: array of TPoint;
  //code-

type
  TVB = record
    VAO,
    VBO, VBO_Size: GLuint;
  end;

var
  ViewPort_ID: GLint;
  VBPoint: TVB;

  { TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  //remove+
  Randomize;
  Width := 340;
  Height := 240;
  //remove-
  ogc := TContext.Create(Self);
  ogc.OnPaint := @ogcDrawScene;
  ogc.OnResize := @ogcResize;

  CreateVertex;

  CreateScene;
  InitScene;
end;

procedure TForm1.CreateScene;
begin
  Shader := TShader.Create([FileToStr('Vertexshader.glsl'), FileToStr('Fragmentshader.glsl')]);
  Shader.UseProgram;
  ViewPort_ID := Shader.UniformLocation('viewport');

  glGenVertexArrays(1, @VBPoint.VAO);
  glGenBuffers(1, @VBPoint.VBO);
  glGenBuffers(1, @VBPoint.VBO_Size);
end;

procedure TForm1.CreateVertex;
const
  s = 1.8;
  step = 8;
  sek = step * step;
var
  x, y, z, i: integer;
  l: GLfloat;
begin
  SetLength(Points, sek);
  //for i := 0 to sek - 1 do begin
  //  repeat
  //    Points[i].vec := vec3(Random - 0.5, Random - 0.5, Random - 0.5);
  //    l := Points[i].vec.Length;
  //  until l <= 0.5;
  //  Points[i].vec.Scale(s);
  //
  //  Points[i].PointSize := Random / 8;
  //end;
  for x := 0 to step - 1 do begin
    for y := 0 to step - 1 do begin
        i := y * step + x;
        Points[i].vec := vec3((x - (step / 2)) / 10, (y - (step / 2)) / 10, 0);
        Points[i].vec.Scale(s);

        Points[i].PointSize := 0.07;
      end;
  end;
end;

(*
Daten für die Punkte in die Grafikkarte übertragen
*)

//code+
procedure TForm1.InitScene;
begin
  glClearColor(0.6, 0.6, 0.4, 1.0); // Hintergrundfarbe

  glBindVertexArray(VBPoint.VAO);

  glBindBuffer(GL_ARRAY_BUFFER, VBPoint.VBO);
  glBufferData(GL_ARRAY_BUFFER, sizeof(TPoint) * Length(Points), Pointer(Points), GL_STATIC_DRAW);

  // Daten für Punkt Position
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 3, GL_FLOAT, False, SizeOf(TPoint), nil);

  // Daten für Punkt Grösse
  glEnableVertexAttribArray(1);
  glVertexAttribPointer(1, 1, GL_FLOAT, False, SizeOf(TPoint), Pointer(12));

end;

//code-

(*
Zeichnen der Punkte
*)
//code+
procedure TForm1.ogcDrawScene(Sender: TObject);
const
  ofs = 0.4;
var
  vp: TVector4f;
begin
  glEnable(GL_PROGRAM_POINT_SIZE);

  glClear(GL_COLOR_BUFFER_BIT);
  Shader.UseProgram;

  glBindVertexArray(VBPoint.VAO);

  glGetFloatv(GL_VIEWPORT, @vp);
  WriteLn(vp[0]: 10: 5, '  ', vp[1]: 10: 5, '  ', vp[2]: 10: 5, '  ', vp[3]: 10: 5, '  ');
  glUniform4fv(ViewPort_ID, 1, vp);
  WriteLn(ViewPort_ID);

  glDrawArrays(GL_POINTS, 0, Length(Points));

  ogc.SwapBuffers;
end;

procedure TForm1.ogcResize(Sender: TObject);
begin
  glViewport(0, 0, ogc.Width, ogc.Height);
end;

//code-

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Shader.Free;

  glDeleteVertexArrays(1, @VBPoint.VAO);

  glDeleteBuffers(1, @VBPoint.VBO);
  glDeleteBuffers(1, @VBPoint.VBO_Size);
end;

procedure TForm1.FormResize(Sender: TObject);
begin
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
