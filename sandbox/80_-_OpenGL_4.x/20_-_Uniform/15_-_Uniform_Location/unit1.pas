unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, Menus,
  oglglad_gl, oglVector, oglMatrix,
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
    procedure Init_OpenGL;
    procedure DrawScene(Sender: TObject);
    procedure Destroy_OpenGL;
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

//image image.png

(*
Ohne Bewegung ist OpenGL langweilig.
Hier werden dem Shader ein X- und ein Y-Wert übergeben. Diese Werte werden mit einem Timer verändert.
Damit die Änderung auch sichtbar wird, wird <b>DrawScene</b> danach manuell ausgelöst.
*)

//lineal

const
  Triangle: array of Tmat3x3 =
    (((-0.4, 0.1, 0.0), (0.4, 0.1, 0.0), (0.0, 0.7, 0.0)));
  Quad: array of Tmat3x3 =
    (((-0.2, -0.6, 0.0), (-0.2, -0.1, 0.0), (0.2, -0.1, 0.0)),
    ((-0.2, -0.6, 0.0), (0.2, -0.1, 0.0), (0.2, -0.6, 0.0)));

type
  TVB = record
    VAO,
    VBO: GLuint;
  end;

  //code+
const
  Matrix_ID = 0;
  X_ID = 1;
  Y_ID = 2;
  Color_ID = 20;

var
  TrianglePos: record
    x, y: GLfloat;        // Position
    xr, yr: boolean;      // Richtung
      end;

  TriangleMatrix, QuadMatrix: TMatrix;
  //code-
  VBTriangle, VBQuad: TVB;

  //code+
procedure TForm1.FormCreate(Sender: TObject);
begin
  //remove+
  Width := 340;
  Height := 240;
  //remove-
  ogc := TContext.Create(Self);
  ogc.OnPaint := @DrawScene;

  Init_OpenGL;
  Timer1.Enabled := True;   // Timer starten
end;

procedure TForm1.Init_OpenGL;
begin
  // --- Shader laden
  Shader := TShader.Create;
  Shader.LoadShaderObjectFromFile(GL_VERTEX_SHADER, 'Vertexshader.glsl');
  Shader.LoadShaderObjectFromFile(GL_FRAGMENT_SHADER, 'Fragmentshader.glsl');
  Shader.LinkProgram;
  Shader.UseProgram;

  TriangleMatrix.Identity;
  QuadMatrix.Identity;
  //code-

  glGenVertexArrays(1, @VBTriangle.VAO);
  glGenVertexArrays(1, @VBQuad.VAO);

  glGenBuffers(1, @VBTriangle.VBO);
  glGenBuffers(1, @VBQuad.VBO);

  glClearColor(0.6, 0.6, 0.4, 1.0); // Hintergrundfarbe

  // Daten für Dreieck
  glBindVertexArray(VBTriangle.VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBTriangle.VBO);
  glBufferData(GL_ARRAY_BUFFER, sizeof(Tmat3x3) * Length(Triangle), Pmat3x3(Triangle), GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 0, nil);

  // Daten für Quadrat
  glBindVertexArray(VBQuad.VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBO);
  glBufferData(GL_ARRAY_BUFFER, sizeof(Tmat3x3) * Length(Quad), Pmat3x3(Quad), GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 0, nil);
end;

//code+
procedure TForm1.DrawScene(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT);

  Shader.UseProgram;

  // Zeichne Dreieck
  glUniform3f(Color_ID, 1.0, 1.0, 0.0); // Gelb
  with TrianglePos do begin
    glUniform1f(X_ID, x);
    glUniform1f(Y_ID, y);
    TriangleMatrix.Uniform(Matrix_ID);
  end;
  glBindVertexArray(VBTriangle.VAO);
  glDrawArrays(GL_TRIANGLES, 0, Length(Triangle) * 3);

  // Zeichne Quadrat
  glUniform3f(Color_ID, 1.0, 0.0, 0.0);  // Rot
  glUniform1f(X_ID, 0.0);
  glUniform1f(Y_ID, 0.0);
  QuadMatrix.Uniform(Matrix_ID);

  glBindVertexArray(VBQuad.VAO);
  glDrawArrays(GL_TRIANGLES, 0, Length(Quad) * 3);
  //code-

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

//code+
procedure TForm1.FormDestroy(Sender: TObject);
begin
  Timer1.Enabled := False;
  //code-

  Destroy_OpenGL;
end;

//code+
procedure TForm1.Timer1Timer(Sender: TObject);
const
  stepx: GLfloat = 0.010;
  stepy: GLfloat = 0.0133;
begin
  with TrianglePos do begin
    if xr then begin
      x := x - stepx;
      if x < -0.5 then begin
        xr := False;
      end;
    end else begin
      x := x + stepx;
      if x > 0.5 then begin
        xr := True;
      end;
    end;
    if yr then begin
      y := y - stepy;
      if y < -1.0 then begin
        yr := False;
      end;
    end else begin
      y := y + stepy;
      if y > 0.3 then begin
        yr := True;
      end;
    end;
  end;
  QuadMatrix.RotateC(0.02);
  DrawScene(Sender);  // Neu zeichnen
end;

//code-

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
