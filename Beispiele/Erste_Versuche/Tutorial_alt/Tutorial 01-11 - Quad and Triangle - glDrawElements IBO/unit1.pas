unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Forms, ExtCtrls, OpenGLContext,
  dglOpenGL, Classes;

type

  { TForm1 }

  TForm1 = class(TForm)
    OpenGLControl1: TOpenGLControl;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    procedure InitScene;
    procedure RenderScene;
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

type
  TVertex3f = array[0..2] of GLfloat;

const
  TriangleVertex: array[0..2] of TVertex3f =
    ((-0.4, 0.1, 0.0), (0.4, 0.1, 0.0), (0.0, 0.7, 0.0));
  QuadVertex: array[0..3] of TVertex3f =
    ((-0.2, -0.6, 0.0), (0.2, -0.6, 0.0), (0.2, -0.1, 0.0), (-0.2, -0.1, 0.0));

  TriangleIndices: array[0..2] of GLint = (0, 1, 2);
  QuadIndices: array[0..5] of GLint = (0, 1, 2, 0, 2, 3);

type
  TVB = record
    VAO,
    IBO,
    VBO: GLuint;
  end;

var
  VBTriangle, VBQuad: TVB;

procedure TForm1.InitScene;
begin
  glGenVertexArrays(1, @VBTriangle.VAO);
  glGenVertexArrays(1, @VBQuad.VAO);

  glGenBuffers(1, @VBTriangle.VBO);
  glGenBuffers(1, @VBQuad.VBO);
  glGenBuffers(1, @VBTriangle.IBO);
  glGenBuffers(1, @VBQuad.IBO);

  glClearColor(0.0, 0.5, 1.0, 1.0);

  // Triangle

  glBindVertexArray(VBTriangle.VAO);

  glBindBuffer(GL_ARRAY_BUFFER, VBTriangle.VBO);
  glBufferData(GL_ARRAY_BUFFER, sizeof(TriangleVertex), @TriangleVertex, GL_STATIC_DRAW);

  glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, VBTriangle.IBO);
  glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(TriangleIndices), @TriangleIndices, GL_STATIC_DRAW);

  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 3, GL_FLOAT, False, 0, nil);

  // Quad

  glBindVertexArray(VBQuad.VAO);

  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBO);
  glBufferData(GL_ARRAY_BUFFER, sizeof(QuadVertex), @QuadVertex, GL_STATIC_DRAW);

  glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, VBQuad.IBO);
  glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(QuadIndices), @QuadIndices, GL_STATIC_DRAW);

  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 3, GL_FLOAT, False, 0, nil);
end;

procedure TForm1.RenderScene;
begin
  glClear(GL_COLOR_BUFFER_BIT);

  // Triangle

  glBindVertexArray(VBTriangle.VAO);
  glDrawElements(GL_TRIANGLES, Length(TriangleIndices), GL_UNSIGNED_INT, Nil);

  // Quad

  glBindVertexArray(VBQuad.VAO);
  glDrawElements(GL_TRIANGLES, Length(QuadIndices), GL_UNSIGNED_INT, Nil);

  OpenGLControl1.SwapBuffers;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  InitOpenGL();

  OpenGLControl1.MakeCurrent();

  ReadExtensions;
  ReadImplementationProperties;

  InitScene;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  glDeleteVertexArrays(1, @VBTriangle.VAO);
  glDeleteVertexArrays(1, @VBQuad.VAO);

  glDeleteBuffers(1, @VBTriangle.VBO);
  glDeleteBuffers(1, @VBQuad.VBO);
  glDeleteBuffers(1, @VBTriangle.IBO);
  glDeleteBuffers(1, @VBQuad.IBO);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  RenderScene;
end;

end.
