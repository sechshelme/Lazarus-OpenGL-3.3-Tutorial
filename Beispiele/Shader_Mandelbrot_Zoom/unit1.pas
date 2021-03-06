unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, Menus,
  dglOpenGL,
  oglContext, oglShader, oglMatrix;

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
Zum Schluss eine kleine Spielerei: Hier wird ein Mandelbrot im Shader (also auf der GPU) berechnet.
Mit der CPU hatte ich noch keine so schnelle Berechnung hingekriegt, trotz Assembler.

Anmerkung: Bei diesem Beispiel geht es nicht um mathematische Hintegründe, sondern es soll legentlich demonstrieren, das man mit Shader-Programs sehr komplexe Berechnungen machen kann.

Der Lazarus-Code ist nichts besonderes, es wird nur ein Rechteck gerendert und anschliessend mit einer Matrix gedreht. Was eine Matrix ist, wird im Kapitel Matrix beschrieben.
<b>Achtung:</b> Eine lahme Grafikkarte kann bei Vollbild ins Stockern kommen.
Zur Beschleunigung kann der Wert <b>#define depth 1000.0</b> im Fragment-Shader verkleinert werden.
*)

//lineal

type
  TVertex3f = array[0..2] of GLfloat;
  TFace = array[0..2] of TVertex3f;

const
  Quad: array[0..1] of TFace =
    (((-1.0, -1.0, 0.0), (-1.0, 1.0, 0.0), (1.0, 1.0, 0.0)),
    ((-1.0, -1.0, 0.0), (1.0, -1.0, 0.0), (1.0, 1.0, 0.0)));

type
  TVB = record
    VAO,
    VBO: GLuint;
  end;

  TRectR = record
    Left, Right, Top, Bottom: single;
  end;

var
  RotMatrix: TMatrix;
  Matrix_ID: GLint;

  Left_ID, Right_ID, Top_ID, Bottom_ID, Color_ID: GLint;

  StartKoor, EndKoor, CalcKoor: TRectR;

  zoomStep: single;
  col: single;

  VBQuad: TVB;

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
var
  sl: TStringList;
  s: string;
  c: integer;
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

  zoomStep := 0;

  sl := TStringList.Create;
  sl.LoadFromFile('Koordinaten.cfg');
  c := 0;

  repeat
    if pos('*', sl[c]) > 0 then begin
      s := sl[c + 1];
      s := Copy(s, pos(':', s) + 1);
      EndKoor.Left := s.ToSingle;

      s := sl[c + 2];
      s := Copy(s, pos(':', s) + 1);
      EndKoor.Right := s.ToSingle;

      s := sl[c + 3];
      s := Copy(s, pos(':', s) + 1);
      EndKoor.Top := s.ToSingle;

      s := sl[c + 4];
      s := Copy(s, pos(':', s) + 1);
      EndKoor.Bottom := s.ToSingle;



      //      ShowMessage(s+#13+EndKoor.Left.ToString);
    end;

    Inc(c);
  until c >= sl.Count;

//
//  EndKoor.Left := -0.604488646155;
//  EndKoor.Right := -0.604454446072;
//  EndKoor.Top := -0.615292225271;
//  EndKoor.Bottom := -0.615268845830;

  sl.Free;
end;

procedure TForm1.CreateScene;
begin
  Shader := TShader.Create([FileToStr('Vertexshader.glsl'), FileToStr('Fragmentshader.glsl')]);
  Shader.UseProgram;

  Color_ID := Shader.UniformLocation('col');
  Left_ID := Shader.UniformLocation('left');
  Right_ID := Shader.UniformLocation('right');
  Top_ID := Shader.UniformLocation('top');
  Bottom_ID := Shader.UniformLocation('bottom');

  Matrix_ID := Shader.UniformLocation('mat');
  RotMatrix.Identity;

  glGenVertexArrays(1, @VBQuad.VAO);

  glGenBuffers(1, @VBQuad.VBO);
end;

procedure TForm1.InitScene;
begin
  glClearColor(0.6, 0.6, 0.4, 1.0); // Hintergrundfarbe

  // Daten für Quadrat
  glBindVertexArray(VBQuad.VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBO);
  glBufferData(GL_ARRAY_BUFFER, sizeof(Quad), @Quad, GL_STATIC_DRAW);
  glEnableVertexAttribArray(10);
  glVertexAttribPointer(10, 3, GL_FLOAT, False, 0, nil);
end;

procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT);
  Shader.UseProgram;
  RotMatrix.Uniform(Matrix_ID);

  // Zeichne Quadrat
  glUniform1f(Left_ID, CalcKoor.Left);
  glUniform1f(Right_ID, CalcKoor.Right);
  glUniform1f(Top_ID, CalcKoor.Top);
  glUniform1f(Bottom_ID, CalcKoor.Bottom);

  glUniform1f(Color_ID, col);

  glBindVertexArray(VBQuad.VAO);
  glDrawArrays(GL_TRIANGLES, 0, Length(Quad) * 3);

  ogc.SwapBuffers;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Timer1.Enabled := False;

  Shader.Free;

  glDeleteVertexArrays(1, @VBQuad.VAO);
  glDeleteBuffers(1, @VBQuad.VBO);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
z,  s: single;
const
  step: GLfloat = 0.01;

begin
  StartKoor.Left := -2.0;
  StartKoor.Right := 2.0;
  StartKoor.Top := -2.0;
  StartKoor.Bottom := 2.0;

  s := (StartKoor.Left - EndKoor.Left) / 1000;
  CalcKoor.Left := -(EndKoor.Left + s * zoomStep);

  s := (StartKoor.Right - EndKoor.Right) / 1000;
  CalcKoor.Right := -(EndKoor.Right + s * zoomStep);

  s := (StartKoor.Top - EndKoor.Top) / 1000;
  CalcKoor.Top := -(EndKoor.Top + s * zoomStep);

  s := (StartKoor.Bottom - EndKoor.Bottom) / 1000;
  CalcKoor.Bottom := -(EndKoor.Bottom + s * zoomStep);

  z:=zoomStep;
  zoomStep /= 1.01;
  if zoomStep < 0.01 then begin
    zoomStep := 1000;
//    zoomStep:=z;
  end;
  Caption := zoomStep.ToString;

  //col := col + 0.1;
  //if col >= 10.0 then begin
  //  col := col - 10.0;
  //end;

  //  RotMatrix.RotateC(step); // RotMatrix rotieren
  ogc.Invalidate;          // Neu zeichnen
end;

(*
<b>Vertex-Shader:</b>
*)
//includeglsl Vertexshader.glsl
//lineal

(*
<b>Fragment-Shader:</b>

Hier steckt die ganze Berechnung für das Mandelbrot.
*)
//includeglsl Fragmentshader.glsl

end.
