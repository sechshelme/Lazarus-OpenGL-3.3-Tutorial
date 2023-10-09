unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, Menus,
  dglOpenGL, oglContext, oglShader, oglMatrix;

type
  TForm1 = class(TForm)
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    ogc: TContext;
    Shader: TShader;
    procedure CreateScene;
    procedure ogcDrawScene(Sender: TObject);
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

//image image.png

//lineal

type
  TVB = record
    UBO,
    VAO: GLuint;
  end;

  TRectR = record
    Left, Right, Top, Bottom: GLfloat;
  end;

var
  UNOBuffer_ID: GLint;
  VBQuad: TVB;

  zoomStep: single;
  StartKoor, EndKoor: TRectR;

  UBO_Buffer: record
    mat: Tmat4x4;
    coord: TRectR;
    col: GLfloat;
      end;

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
    end;

    Inc(c);
  until c >= sl.Count;

  //  EndKoor.Left := -0.604488646155;
  //  EndKoor.Right := -0.604454446072;
  //  EndKoor.Top := -0.615292225271;
  //  EndKoor.Bottom := -0.615268845830;

  sl.Free;
end;

procedure TForm1.CreateScene;
var
  bindingPoint: gluint = 0;
begin
  Shader := TShader.Create;
  Shader.LoadShaderObjectFromFile(GL_VERTEX_SHADER, 'Vertexshader.glsl');
  Shader.LoadShaderObjectFromFile(GL_FRAGMENT_SHADER, 'Fragmentshader.glsl');
  Shader.LinkProgramm;
  Shader.UseProgram;

  UNOBuffer_ID := Shader.UniformBlockIndex('ubo');
  UBO_Buffer.mat.Identity;

  // Daten für Quadrat
  glGenVertexArrays(1, @VBQuad.VAO);
  glBindVertexArray(VBQuad.VAO);

  // UBO mit Daten laden
  glGenBuffers(1, @VBQuad.UBO);
  glBindBuffer(GL_UNIFORM_BUFFER, VBQuad.UBO);
  glBufferData(GL_UNIFORM_BUFFER, SizeOf(UBO_Buffer), nil, GL_DYNAMIC_DRAW);

  // UBO mit dem Shader verbinden
  glUniformBlockBinding(Shader.ID, UNOBuffer_ID, bindingPoint);
  glBindBufferBase(GL_UNIFORM_BUFFER, bindingPoint, VBQuad.UBO);

  glClearColor(0.6, 0.6, 0.4, 1.0); // Hintergrundfarbe
end;

procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT);
  Shader.UseProgram;

  UBO_Buffer.col := 0.0;

  glBindVertexArray(VBQuad.VAO);

  glBindBuffer(GL_UNIFORM_BUFFER, VBQuad.UBO);
  glBufferSubData(GL_UNIFORM_BUFFER, 0, sizeof(UBO_Buffer), @UBO_Buffer);

  glDrawArrays(GL_TRIANGLES, 0, 6);

  ogc.SwapBuffers;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Timer1.Enabled := False;
  Shader.Free;
  glDeleteBuffers(1, @VBQuad.UBO);
  glDeleteVertexArrays(1, @VBQuad.VAO);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
  s: single;
begin
  StartKoor.Left := -2.0;
  StartKoor.Right := 2.0;
  StartKoor.Top := -2.0;
  StartKoor.Bottom := 2.0;

  s := (StartKoor.Left - EndKoor.Left) / 1000;
  UBO_Buffer.coord.Left := -(EndKoor.Left + s * zoomStep);

  s := (StartKoor.Right - EndKoor.Right) / 1000;
  UBO_Buffer.coord.Right := -(EndKoor.Right + s * zoomStep);

  s := (StartKoor.Top - EndKoor.Top) / 1000;
  UBO_Buffer.coord.Top := -(EndKoor.Top + s * zoomStep);

  s := (StartKoor.Bottom - EndKoor.Bottom) / 1000;
  UBO_Buffer.coord.Bottom := -(EndKoor.Bottom + s * zoomStep);

  zoomStep /= 1.01;
  if zoomStep < 0.01 then begin
    zoomStep := 1000;
  end;
  Caption := zoomStep.ToString;

  ogc.Invalidate;
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
