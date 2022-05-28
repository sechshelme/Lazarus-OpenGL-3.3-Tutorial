unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Forms,
  ExtCtrls, OpenGLContext, dglOpenGL, oglShader;

type

  { TForm1 }

  TForm1 = class(TForm)
    OpenGLControl1: TOpenGLControl;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private   { private declarations }
    procedure InitScene;
    procedure RenderScene;
  public        { public declarations }
    shader: TShader;
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

type
  TVertex3f = array[0..2] of GLfloat;
  TFace = array[0..2] of TVertex3f;
  TMatrix = array[0..3, 0..3] of GLfloat;

const
  Triangle: array[0..0] of TFace =
    (((-0.4, 0.1, 0.0), (0.0, 0.7, 0.0), (0.4, 0.1, 0.0)));
  TriangleColor: array[0..0] of TFace =
    (((1.0, 0.0, 0.0), (0.0, 0.0, 1.0), (0.0, 1.0, 0.0)));

  Quad: array[0..1] of TFace =
    (((-0.2, -0.6, 0.0), (-0.2, -0.1, 0.0), (0.2, -0.1, 0.0)),
    ((-0.2, -0.6, 0.0), (0.2, -0.1, 0.0), (0.2, -0.6, 0.0)));
  QuadColor: array[0..1] of TFace =
    (((1.0, 0.0, 0.0), (0.0, 1.0, 0.0), (0.0, 0.0, 1.0)),
    ((1.0, 0.0, 0.0), (0.0, 0.0, 1.0), (1.0, 1.0, 0.0)));

  EinheitsMatrix: TMatrix = ((1.0, 0.0, 0.0, 0.0), (0.0, 1.0, 0.0, 0.0), (0.0, 0.0, 1.0, 0.0), (0.0, 0.0, 0.0, 1.0));


type
  TVB = record
    VAO,
    VBO0, VBO1: GLuint;
  end;

var
  VBTriangle, VBQuad: TVB;
  Vertex_id, Color_id: GLint;
  Matrix_id: GLint;

  Matrix: TMatrix;

procedure RotateZ(var Matrix: TMatrix; Winkel: GLfloat);
var
  x, y: GLfloat;
  i: integer;
begin
  for i := 0 to 2 do begin
    x := Matrix[i, 0];
    y := Matrix[i, 1];
    Matrix[i, 0] := x * cos(Winkel) - y * sin(Winkel);
    Matrix[i, 1] := x * sin(Winkel) + y * cos(Winkel);
  end;
end;

procedure RotateY(var Matrix: TMatrix; Winkel: GLfloat);
var
  x, z: GLfloat;
  i: integer;
begin
  for i := 0 to 2 do begin
    x := Matrix[i, 0];
    z := Matrix[i, 2];
    Matrix[i, 0] := x * cos(Winkel) - z * sin(Winkel);
    Matrix[i, 2] := x * sin(Winkel) + z * cos(Winkel);
  end;
end;

procedure TForm1.InitScene;
begin
  Shader := TShader.Create([FileToStr('Vertexshader.glsl'), FileToStr('Fragmentshader.glsl')]);

  Vertex_id := shader.AttribLocation('inPos');
  Color_id := shader.AttribLocation('inColor');
  Matrix_id := shader.UniformLocation('Matrix');

//  glEnable(GL_CULL_FACE);

  glClearColor(0.0, 0.5, 0.8, 1.0);

  glGenVertexArrays(1, @VBTriangle.VAO);
  glGenVertexArrays(1, @VBQuad.VAO);

  glGenBuffers(1, @VBTriangle.VBO0);
  glGenBuffers(1, @VBQuad.VBO0);
  glGenBuffers(1, @VBTriangle.VBO1);
  glGenBuffers(1, @VBQuad.VBO1);

  glBindVertexArray(VBTriangle.VAO);

  glBindBuffer(GL_ARRAY_BUFFER, VBTriangle.VBO0);
  glBufferData(GL_ARRAY_BUFFER, sizeof(Triangle), @Triangle, GL_STATIC_DRAW);
  glEnableVertexAttribArray(Vertex_id);
  glVertexAttribPointer(Vertex_id, 3, GL_FLOAT, False, 0, nil);

  glBindBuffer(GL_ARRAY_BUFFER, VBTriangle.VBO1);
  glBufferData(GL_ARRAY_BUFFER, sizeof(TriangleColor), @TriangleColor, GL_STATIC_DRAW);
  glEnableVertexAttribArray(Color_id);
  glVertexAttribPointer(Color_id, 3, GL_FLOAT, False, 0, nil);


  glBindVertexArray(VBQuad.VAO);

  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBO0);
  glBufferData(GL_ARRAY_BUFFER, sizeof(Quad), @Quad, GL_STATIC_DRAW);
  glEnableVertexAttribArray(Vertex_id);
  glVertexAttribPointer(Vertex_id, 3, GL_FLOAT, False, 0, nil);

  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBO1);
  glBufferData(GL_ARRAY_BUFFER, sizeof(QuadColor), @QuadColor, GL_STATIC_DRAW);
  glEnableVertexAttribArray(Color_id);
  glVertexAttribPointer(Color_id, 3, GL_FLOAT, False, 0, nil);

  Matrix := EinheitsMatrix;
end;

procedure TForm1.RenderScene;
begin
  glClear(GL_COLOR_BUFFER_BIT);

  glUniformMatrix4fv(Matrix_id, 1, False, @Matrix);

  // Zeichen Dreieck
  glBindVertexArray(VBTriangle.VAO);
  glDrawArrays(GL_TRIANGLES, 0, Length(Triangle) * 3);

  // Zeichne Quadrat
  glBindVertexArray(VBQuad.VAO);
  glDrawArrays(GL_TRIANGLES, 0, Length(Quad) * 3);

  OpenGLControl1.SwapBuffers;
end;


procedure TForm1.FormCreate(Sender: TObject);
begin
  InitOpenGL;
  OpenGLControl1.MakeCurrent;
  ReadExtensions;
  ReadImplementationProperties;

  InitScene;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  glDeleteBuffers(1, @VBTriangle.VAO);
  glDeleteBuffers(1, @VBQuad.VAO);

  glDeleteBuffers(1, @VBTriangle.VBO0);
  glDeleteBuffers(1, @VBQuad.VBO0);
  glDeleteBuffers(1, @VBTriangle.VBO1);
  glDeleteBuffers(1, @VBQuad.VBO1);

  shader.Free;
end;

procedure TForm1.FormResize(Sender: TObject);
begin
  glViewport(0, 0, ClientWidth, ClientHeight);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  RenderScene;
  //  RotateZ(Matrix, Pi/100);
  RotateY(Matrix, Pi / 100);
end;

end.
