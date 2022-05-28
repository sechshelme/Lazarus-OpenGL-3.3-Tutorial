unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, OpenGLContext, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, dglOpenGL, oglShader;

type

  { TForm1 }

  TForm1 = class(TForm)
    OpenGLControl1: TOpenGLControl;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private   { private declarations }
    procedure InitScene;
    procedure RenderScene;
  public        { public declarations }
    ProgramID: GLuint;
    Shader: TShader;
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

const
  vert =
    '#version 330' + #13#10 +
    'in vec3 inPos;' + #13#10 +
    'in vec3 inColor;' + #13#10 +

    'out vec4 Color;' + #13#10 +

    'void main(void)' + #13#10 +
    '{' + #13#10 +
    '  gl_Position = vec4(inPos, 1.0);' + #13#10 +
    '  Color = vec4(inColor, 1.0);' + #13#10 +
    '}';

  frag =
    '#version 330' + #13#10 +
    'in vec4 Color;' + #13#10 +
    'out vec4 outColor;' + #13#10 +

    'void main(void)' + #13#10 +
    '{' + #13#10 +
    '  outColor = Color;' + #13#10 +
    '}';

type
  TVertex3f = array[0..2] of GLfloat;
  TFace = array[0..2] of TVertex3f;

const
  TrianglePos: array[0..0] of TFace =
    (((-0.4, 0.1, 0.0), (0.4, 0.1, 0.0), (0.0, 0.7, 0.0)));
  TriangleColor: array[0..0] of TFace =
    (((1.0, 0.0, 0.0), (0.0, 1.0, 0.0), (0.0, 0.0, 1.0)));

  QuadPos: array[0..1] of TFace =
    (((-0.2, -0.6, 0.0), (-0.2, -0.1, 0.0), (0.2, -0.1, 0.0)),
    ((-0.2, -0.6, 0.0), (0.2, -0.1, 0.0), (0.2, -0.6, 0.0)));
  QuadColor: array[0..1] of TFace =
    (((1.0, 0.0, 0.0), (0.0, 1.0, 0.0), (0.0, 0.0, 1.0)),
    ((1.0, 0.0, 0.0), (0.0, 0.0, 1.0), (1.0, 1.0, 0.0)));


type
  TVB = record
    VBOPos, VBOColor: GLuint;
  end;

var
  VBTriangle, VBQuad: TVB;
  Vertex_id, Color_id: GLint;

procedure TForm1.InitScene;
begin
  glGenBuffers(1, @VBTriangle.VBOPos);
  glGenBuffers(1, @VBTriangle.VBOColor);

  glBindBuffer(GL_ARRAY_BUFFER, VBTriangle.VBOPos);
  glBufferData(GL_ARRAY_BUFFER, sizeof(TrianglePos), @TrianglePos, GL_STATIC_DRAW);

  glBindBuffer(GL_ARRAY_BUFFER, VBTriangle.VBOColor);
  glBufferData(GL_ARRAY_BUFFER, sizeof(TriangleColor), @TriangleColor, GL_STATIC_DRAW);

  glGenBuffers(1, @VBQuad.VBOPos);
  glGenBuffers(1, @VBQuad.VBOColor);

  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBOPos);
  glBufferData(GL_ARRAY_BUFFER, sizeof(QuadPos), @QuadPos, GL_STATIC_DRAW);

  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBOColor);
  glBufferData(GL_ARRAY_BUFFER, sizeof(QuadColor), @QuadColor, GL_STATIC_DRAW);


  Shader := TShader.Create([vert, frag]);
  with Shader do begin
    Vertex_id := AttribLocation('inPos');
    Color_id := AttribLocation('inColor');
  end;

  glClearColor(0.0, 0.5, 1.0, 1.0);
end;

procedure TForm1.RenderScene;
begin
  glClear(GL_COLOR_BUFFER_BIT);

  // TrianglePos

  glEnableVertexAttribArray(Vertex_id);
  glBindBuffer(GL_ARRAY_BUFFER, VBTriangle.VBOPos);
  glVertexAttribPointer(Vertex_id, 3, GL_FLOAT, False, 12, nil);

  glEnableVertexAttribArray(Color_id);
  glBindBuffer(GL_ARRAY_BUFFER, VBTriangle.VBOColor);
  glVertexAttribPointer(Color_id, 3, GL_FLOAT, False, 12, nil);

  glDrawArrays(GL_TRIANGLES, 0, Length(TrianglePos) * 3);


  // QuadPos

  glEnableVertexAttribArray(Vertex_id);
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBOPos);
  glVertexAttribPointer(Vertex_id, 3, GL_FLOAT, False, 12, nil);

  glEnableVertexAttribArray(Color_id);
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBOColor);
  glVertexAttribPointer(Color_id, 3, GL_FLOAT, False, 12, nil);

  glDrawArrays(GL_TRIANGLES, 0, Length(QuadPos) * 3);

  OpenGLControl1.SwapBuffers;
end;


procedure TForm1.FormCreate(Sender: TObject);
begin
  InitOpenGL;

  OpenGLControl1.MakeCurrent;

  ReadExtensions;
  ReadImplementationProperties;

  InitScene;
  Timer1.Enabled := True;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Shader.Free;

  glDeleteBuffers(1, @VBTriangle.VBOPos);
  glDeleteBuffers(1, @VBQuad.VBOPos);
  glDeleteBuffers(1, @VBTriangle.VBOColor);
  glDeleteBuffers(1, @VBQuad.VBOColor);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  RenderScene;
end;

end.
